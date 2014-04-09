package fr.inria.diverse.k3.al.annotationprocessor

import java.lang.annotation.Target
import java.util.ArrayList
import java.util.Comparator
import java.util.HashMap
import java.util.LinkedHashSet
import java.util.List
import java.util.Map
import java.util.Set
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.CodeGenerationContext
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableFieldDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableMethodDeclaration
import org.eclipse.xtend.lib.macro.declaration.TypeReference
import org.eclipse.xtend.lib.macro.declaration.Visibility
import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy

@Active(typeof(AspectProcessor)) 
public annotation Aspect {
	Class<?> className;
	Class<?>[] with = #[];
	String adapter = "";
}

public annotation OverrideAspectMethod {}

public annotation NotAspectProperty {}

public annotation ReplaceAspectMethod {}

/**
 * Used to tag a k3 operation as abstract as initially defined.
 * Used when generating super operations: must not generate super for abstract operations.
 */
@Target(#[ElementType::METHOD])
@Retention(RetentionPolicy::SOURCE)
annotation Abstract {}


public class AspectProcessor extends AbstractClassProcessor {
	val Map<MutableClassDeclaration,List<MutableClassDeclaration>> listResMap = new HashMap
	
	public static val CTX_NAME = 'AspectContext'
	public static val PROP_NAME = 'AspectProperties'
	public static val OVERRIDE_METHOD = OverrideAspectMethod.simpleName
	public static val PROP_VAR_NAME = '_self_'
	public static val SELF_VAR_NAME = '_self'
	public static val PRIV_PREFIX = '_privk3_'

	/**
	 * Phase 1
	 */
	override doRegisterGlobals(ClassDeclaration annotatedClass, RegisterGlobalsContext context) {
		val type = Helper::getAnnotationAspectType(annotatedClass)
		if(type!=null) {
			val className = type.simpleName
			context.registerClass(annotatedClass.qualifiedName + className + PROP_NAME)
			context.registerClass(annotatedClass.qualifiedName + className + CTX_NAME)
		}
	}

	/**
	 * Phase 2
	 */
	override def doTransform(List<? extends MutableClassDeclaration> classes, extension TransformationContext context) {
		//Method name_parameterlengths, 
		val Map<MutableClassDeclaration, List<MutableClassDeclaration>> superclass = new HashMap
		val Map<MutableMethodDeclaration, Set<MutableMethodDeclaration>> dispatchmethod = new HashMap
		initSuperclass(classes, context, superclass)
		initDispatchmethod(superclass, dispatchmethod, context)
		
		for (clazz : classes) {
			val List<MutableClassDeclaration> listRes = Helper::sortByClassInheritance(clazz, classes, context)
			val List<String> inheritList = listRes.map[simpleName]
			listResMap.put(clazz,listRes)
			val typeRef = Helper::getAnnotationAspectType(clazz)
			if(typeRef==null)
				clazz.addError("The aspectised class cannot be resolved.")
			else {
				val className = typeRef.simpleName
				val identifier = typeRef.name
				val Map<MutableMethodDeclaration, String> bodies = new HashMap
	
				//MOVE non static fields
				fieldsProcessing(context, clazz, className, identifier, bodies)
	
				//Transform method to static
				methodsProcessing(clazz, context, identifier, bodies, dispatchmethod, inheritList, className)
				aspectContextMaker(context, clazz, className, identifier)
			}
		}
	}
	
	/** Phase 3
	 *  use an additional code generator to produce the .k3_aspect_mapping.properties file
	 */
	override doGenerateCode(List<? extends ClassDeclaration> annotatedSourceElements, extension CodeGenerationContext context) {
		// clean up previous version
		if(annotatedSourceElements.size > 0){
			val filePath = annotatedSourceElements.get(0).compilationUnit.filePath
			val targetFilePath = filePath.projectFolder.append("/META-INF/xtend-gen/"+filePath.projectFolder.lastSegment + ".k3_aspect_mapping.properties")
			targetFilePath.delete
		
			// add aspectizedClass = aspectClasses mapping separated by ,
			val Map<String, List<String>> mapping = new HashMap
			for(annotatedSourceElement : annotatedSourceElements){
				val aspectizedclassType = Helper::getAnnotationAspectType(annotatedSourceElement)
				if(aspectizedclassType!=null) {
					val aspectizedclassName = aspectizedclassType.name
					var existingListForAspectizedElement = mapping.get(aspectizedclassName)
					if(existingListForAspectizedElement == null){
						existingListForAspectizedElement = new ArrayList<String>
						mapping.put(aspectizedclassName,existingListForAspectizedElement)
					}
					existingListForAspectizedElement.add(annotatedSourceElement.qualifiedName)
				}
			}
			var buf = ''''''
			for(entrySet : mapping.entrySet){
				buf = '''«buf.toString»
«entrySet.key» = «FOR aString : entrySet.value SEPARATOR ', '»«aString»«ENDFOR»'''
			}
			targetFilePath.contents = '''# List of the Java classes that have been aspectized and name of the aspect classes separated by comma
«buf.toString»''' 
		}		
	}


	private def methodProcessingAddSelfStatic(MutableMethodDeclaration m, String identifier, extension TransformationContext cxt) {
		//In not visited method, add _self as first parameter and set it static
		if (m.parameters.empty || m.parameters.get(0).simpleName != SELF_VAR_NAME) {
			val l = new ArrayList<Pair<String, TypeReference>>
			for(p1 : m.parameters) l.add(new Pair(p1.simpleName, p1.type))

			// If the initial operation is abstract, the new static one must be tagged as abstract to perform some computations afterward.
			if(m.abstract)
				m.addAnnotation(typeof(Abstract).findTypeGlobally)			
			m.parameters.toList.clear				
			m.addParameter(SELF_VAR_NAME, newTypeReference(identifier))

			for(param : l) m.addParameter(param.key, param.value)
		}
		m.setStatic(true)
	}


	private def methodProcessingAddSuper(MutableMethodDeclaration m, MutableClassDeclaration clazz, extension TransformationContext cxt) {
		if(m.annotations.findFirst[annotationTypeDeclaration.simpleName == OVERRIDE_METHOD] == null) return;
		//Add a method "super_methodName" which call first method in the
		//super class hierarchy with the same name.
		val superClasses = Helper::getAnnotationWithType(clazz).map[cl | findClass(cl.name)].filterNull.toSet
		val superCl = if(clazz.extendedClass==null) null else findClass(clazz.extendedClass.name)
		if(superCl!=null) superClasses.add(superCl)
	 	if(superClasses.empty) return;

		// TODO findMethod does not support the annotation 'with' yet.
		val superMeths = superClasses.map[sc| Helper::findMethod(sc, m, cxt)].
					// The super operations must not be abstract.
					filterNull.filter[annotations.findFirst[annotationTypeDeclaration.simpleName=='Abstract']==null]
		val multiSuper = superMeths.size>1

		superMeths.forEach[sm |
			val superNamePrefix = if(multiSuper) "super_"+Helper::getAspectedClassName(sm.declaringType).split("\\.").last+"_" else "super_"
			clazz.addMethod(superNamePrefix + m.simpleName, [
				val paramsList = new StringBuilder
				val adapter = Helper::getAdapterClassName(clazz, cxt)
				visibility = Visibility::PRIVATE
				static = true
				returnType = m.returnType
				for(p : m.parameters) addParameter(p.simpleName, p.type)
				if (!adapter.empty) {
					paramsList.append("_k3_adap")
					if (m.parameters.size > 1)
						paramsList.append("," + m.parameters.drop(1).map[simpleName].join(','))
				} else {
					paramsList.append(m.parameters.map[simpleName].join(','))
				}
				//TODO find super method
				
				
				body = ['''
					«IF !adapter.empty»
					«adapter» _k3_adap = new «adapter»() ;
					_k3_adap.setAdaptee(«SELF_VAR_NAME») ;
					«ENDIF»
					«IF (sm.returnType.name != "void")»return «ENDIF» «sm.declaringType.newTypeReference.name».«PRIV_PREFIX+m.simpleName»(«paramsList»);
				''']
			])
		]
	}
	
	
	private def methodProcessingAddHidden(MutableMethodDeclaration m, String identifier, extension TransformationContext cxt) {
		//Add "_hidden_" at the beginning of the replaced method name
		if(m.annotations.findFirst[annotationTypeDeclaration.simpleName == "ReplaceAspectMethod"] != null) {
			val cl = findClass(identifier)
			if(cl != null) {
				val m2 = cl.declaredMethods.findFirst[m2| m2.simpleName == m.simpleName && m2.parameters.size == m.parameters.size - 1]
				m2.setSimpleName("_hidden_" + m.simpleName)
			}
			//TODO Do that for all super and lower classes
		}
	}


	private def methodProcessingAddPriv(MutableMethodDeclaration m, MutableClassDeclaration clazz, Map<MutableMethodDeclaration,String> bodies,
										extension TransformationContext cxt) {
		//Make PRIV_PREFIX+methodName as a copy of the method
		clazz.addMethod(PRIV_PREFIX + m.simpleName, [
				visibility = Visibility::PROTECTED
				static = true
				abstract = false
				returnType = m.returnType
				if(m.abstract)
					body = ['''throw new java.lang.RuntimeException("Not implemented");''']
				else
					if(m.body == null)
						body = [bodies.get(m)] //getters & setters
					else body = m.body
				for(p : m.parameters)
					addParameter(p.simpleName, p.type)
		])
	}


	private def methodProcessingChangeBody(MutableMethodDeclaration m, MutableClassDeclaration clazz, extension TransformationContext cxt, 
									Map<MutableMethodDeclaration,Set<MutableMethodDeclaration>> dispatchmethod, List<String> inheritList, String className) {
		//Change the body of the method to call the closest method PRIV_PREFIX+methodName in the aspect hierarchy
		val s = m.parameters.map[simpleName].join(',')
		val ret = if(m.returnType != newTypeReference("void")) "return" else ""
		val call = new StringBuilder

		if(dispatchmethod.get(m) != null) {
			val listmethod = Helper::sortByMethodInheritance(dispatchmethod.get(m), inheritList)
			val declTypes = listmethod.map[declaringType]
			
			// A time-consuming check to be used for debugging only.
			// Looks for any problem in the order of the classes.
//					val declTypes = new ArrayList(listmethod.map[declaringType])
//					val size = declTypes.size
//					var i=1
//
//					for(type : declTypes) {
//						for(pos : i..<size)
//							if(type.isAssignableFrom(declTypes.get(pos)))
//								addError(clazz, "The generated factory does not have a correct hierarchy: " + type.simpleName + ", " + declTypes.get(pos).simpleName)
//						i=i+1
//					}

			val ifst = '''«FOR dt : declTypes» if («SELF_VAR_NAME» instanceof «Helper::getAspectedClassName(dt)»){
«ret» «dt.newTypeReference.name».«PRIV_PREFIX+m.simpleName»(«s.replaceFirst(SELF_VAR_NAME,
				"(" + Helper::getAspectedClassName(dt) + ")"+SELF_VAR_NAME)»);
} else «IF !Helper::getAdapterClassName(dt, cxt).empty»if («SELF_VAR_NAME» instanceof «Helper::getAdapterClassName(dt, cxt)»){
«ret» «dt.newTypeReference.name».«PRIV_PREFIX+m.simpleName»(«s.replaceFirst(SELF_VAR_NAME,
				"((" + Helper::getAdapterClassName(dt, cxt) + ")"+SELF_VAR_NAME+").getAdaptee()")»);
} else «ENDIF»«ENDFOR»'''
			call.append(ifst).append(''' { throw new IllegalArgumentException("Unhandled parameter types: " + java.util.Arrays.<Object>asList(«SELF_VAR_NAME»).toString()); }''')
		}
		else call.append('''«ret» «PRIV_PREFIX+m.simpleName»(«s»); ''') //for getters & setters

		m.abstract = false
		m.body = ['''«PROP_VAR_NAME» = «clazz.qualifiedName + className + CTX_NAME».getSelf(«SELF_VAR_NAME»);
	     «call.toString»''']
	}


	/**
	 * In the case of multi-inheritance, operations of the aspects that cannot be classically extended must be added
	 * to the class.
	 */
	private def methodProcessingAddMultiInheritMeth(MutableClassDeclaration clazz, String identifier, TransformationContext cxt) {
		val superClasses = Helper::getAnnotationWithType(clazz).filter[cl | cl!=clazz.extendedClass].map[cl | cxt.findClass(cl.name)].filterNull
		val Set<MutableClassDeclaration> scs = newHashSet()
	 	superClasses.forEach[sc | Helper::getSuperClasses(sc, scs, cxt)]
		
		scs.forEach[sc |
			// Only non-private methods which does not already exist in the aspect class are considered.
			sc.declaredMethods.filter[dm | dm.visibility!=Visibility::PRIVATE && !dm.simpleName.startsWith(PRIV_PREFIX) &&
				!clazz.declaredMethods.exists[dm2| Helper::isSamePrototype(dm, dm2, true)]].forEach[dm |
				// Adding a new proxy method in the aspect class.
				val me = clazz.addMethod(dm.simpleName) [
					visibility = dm.visibility
					static = true
					final = false
					abstract = false
					returnType = dm.returnType
					dm.parameters.forEach[par | addParameter(par.simpleName, par.type)]
				]
				// This new method must be transformed like the other ones.
				methodProcessingAddSelfStatic(me, identifier, cxt)
				// The proxy consists of calling the corresponding operation in the targeted aspect class.
				val params = me.parameters.map[simpleName].join(',')
				me.body = ['''«IF me.returnType==null || me.returnType.simpleName=='void'»«ELSE»return «ENDIF»«sc.simpleName».«dm.simpleName»(«params»);''']
			]

			sc.declaredFields.filter[simpleName!=PROP_VAR_NAME].forEach[fi |
				val clName = fi.declaringType.simpleName
				clazz.addMethod(fi.simpleName,[
					static = true
					returnType = fi.type
					addParameter(SELF_VAR_NAME, cxt.newTypeReference(identifier))
					body = ['''return «clName».«fi.simpleName»(«SELF_VAR_NAME»);''']
				])
				
				if(!fi.final)
					clazz.addMethod(fi.simpleName,[
						static = true
						returnType = cxt.newTypeReference("void")
						addParameter(SELF_VAR_NAME, cxt.newTypeReference(identifier))
						addParameter(fi.simpleName, fi.type)
						body = ['''«clName».«fi.simpleName»(«SELF_VAR_NAME», «fi.simpleName»);''']
					])
			]
		]
	}


	private def methodsProcessing(MutableClassDeclaration clazz, TransformationContext cxt, String identifier, 
		Map<MutableMethodDeclaration,String> bodies, Map<MutableMethodDeclaration,Set<MutableMethodDeclaration>> dispatchmethod, 
		List<String> inheritList, String className) {

		for(m : clazz.declaredMethods) {
			if(checkAnnotationprocessorCorrect(m, clazz, cxt)) {
				methodProcessingAddSelfStatic(m, identifier, cxt)
				methodProcessingAddSuper(m, clazz, cxt)
				methodProcessingAddHidden(m, identifier, cxt)
				methodProcessingAddPriv(m, clazz, bodies, cxt)
				methodProcessingChangeBody(m, clazz, cxt, dispatchmethod, inheritList, className)
			}
			else cxt.addError(m, "Cannot find a super method in the aspect hierarchy.")
		}
		
		methodProcessingAddMultiInheritMeth(clazz, identifier, cxt)
	}


	/** Checks that the given method of the given class is correctly tagged with the annotation OverrideAspectMethod, i.e.
	 * checks that a super method exists in its hierarchy. */
	private def boolean checkAnnotationprocessorCorrect(MutableMethodDeclaration m, MutableClassDeclaration clazz, TransformationContext cxt) {
		val annot = m.annotations.findFirst[annotationTypeDeclaration.simpleName == OVERRIDE_METHOD]
		if(annot==null) return true
		val supers = Helper::getDirectSuperClasses(clazz, cxt)
		if(supers.empty) return false
		return supers.findFirst[superCl| Helper::findMethod(superCl, m, cxt)!=null]!=null
	}


	/**
	 * Create the class which link classes with their aspects 
	 */
	private def aspectContextMaker(extension TransformationContext context, MutableClassDeclaration clazz, String className, String identifier) {
		val holderClass = findClass(clazz.qualifiedName + className + CTX_NAME)
		if(holderClass==null) return;
		
		holderClass.visibility = Visibility::PUBLIC
		holderClass.addConstructor [visibility = Visibility::PRIVATE]

		holderClass.addField('INSTANCE') [
			visibility = Visibility::PUBLIC
			static = true
			final = true
			type = holderClass.newTypeReference
			initializer = ['''new «holderClass.simpleName»()''']
		]

		holderClass.addMethod('getSelf') [
			visibility = Visibility::PUBLIC
			static = true
			addParameter("_self", newTypeReference(identifier))
			returnType = newTypeReference(clazz.qualifiedName + className + PROP_NAME)
			body = [
				'''		if (!INSTANCE.map.containsKey(_self))
			INSTANCE.map.put(_self, new «clazz.qualifiedName + className + PROP_NAME»());
		return INSTANCE.map.get(_self);'''
			]
		]

		holderClass.addField('map', [
			visibility = Visibility::PRIVATE
			static = false
			type = newTypeReference("java.util.Map", newTypeReference(identifier),
				newTypeReference(clazz.qualifiedName + className + PROP_NAME))
			initializer = [
				'''new java.util.HashMap<«identifier + Helper::mkstring(newTypeReference(identifier).actualTypeArguments,",","<",">")», «clazz.qualifiedName + className + PROP_NAME»>()''']
		])
 
		holderClass.addMethod('getMap') [
			visibility = Visibility::PUBLIC
			static = false
			returnType = newTypeReference("java.util.Map", newTypeReference(identifier), newTypeReference(clazz.qualifiedName + className + PROP_NAME))
			body = ['''return map;''']
		]
	}


	/** Move non static fields */
	private def fieldProcessingMoveField(MutableClassDeclaration clazz, List<MutableFieldDeclaration> toRemove, List<MutableFieldDeclaration> propertyAspect,
										String className, extension TransformationContext context) {
		val c = findClass(clazz.qualifiedName + className + PROP_NAME)

		for(f : clazz.declaredFields) {
			if(f.simpleName != PROP_VAR_NAME) {
				toRemove.add(f)
				if(f.annotations.findFirst[annotationTypeDeclaration.simpleName == "NotAspectProperty"] == null)
					propertyAspect.add(f)

				c.addField(f.simpleName) [
					visibility = Visibility::PUBLIC
					static = f.static
					final = f.final
					type = f.type
					if(f.initializer != null) initializer = f.initializer
				]
			} else if (!f.static && f.simpleName == PROP_VAR_NAME) {
				f.type = findClass(clazz.qualifiedName + className + PROP_NAME).newTypeReference
				f.static = true
			}
		}
	}
	
	
	private def fieldProcessingAddField(MutableClassDeclaration clazz, String className, extension TransformationContext context) {
		if(clazz.declaredFields.findFirst[simpleName == PROP_VAR_NAME] == null) {
			val clazzProp = findClass(clazz.qualifiedName + className + PROP_NAME)
			if(clazzProp==null)
				addError(clazz, "Cannot resolve the class to aspectise. Check that the classes to aspectise are not in the same project that your aspects.")
			else
				clazz.addField(PROP_VAR_NAME,[
					type = findClass(clazz.qualifiedName + className + PROP_NAME).newTypeReference
					static = true
					visibility = Visibility::PUBLIC
				])
		}
	}


	private def fieldProcessingAddGetterSetter(MutableClassDeclaration clazz, List<MutableFieldDeclaration> propertyAspect, String identifier,
		Map<MutableMethodDeclaration,String> bodies, extension TransformationContext context) {
		for (f : propertyAspect) {
			var get = clazz.addMethod(f.simpleName,[
					returnType = f.type
					addParameter(SELF_VAR_NAME, newTypeReference(identifier))
				])
			bodies.put(get, ''' return «clazz.qualifiedName».«PROP_VAR_NAME».«f.simpleName»; ''')

			if(!f.final) {
				var set = clazz.addMethod(f.simpleName,[
						returnType = newTypeReference("void")
						addParameter(SELF_VAR_NAME, newTypeReference(identifier))
						addParameter(f.simpleName, f.type)
					])
				bodies.put(set, '''«clazz.qualifiedName».«PROP_VAR_NAME».«f.simpleName» = «f.simpleName»; ''')
			}
		}
	}
	

	/**
	 * Move fields of the aspect to the AspectProperties class
	 */
	private def fieldsProcessing(extension TransformationContext context, MutableClassDeclaration clazz, String className, String identifier, Map<MutableMethodDeclaration,String> bodies) {
		val List<MutableFieldDeclaration> toRemove = newArrayList
		val List<MutableFieldDeclaration> propertyAspect = newArrayList
		fieldProcessingMoveField(clazz, toRemove, propertyAspect, className, context)
		fieldProcessingAddField(clazz, className, context)
		fieldProcessingAddGetterSetter(clazz, propertyAspect, identifier, bodies, context)
		for(f : toRemove) f.remove
	}


	/**
	 * Each aspect method is associatated with the lists of all methods with the
	 * same signature (name + number of args) of parents classes and children classes.
	 * @superclass All aspects associated with their superclasses
	 * @dispatchmethod Associations computed
	 * @context
	 */
	private def initDispatchmethod(Map<MutableClassDeclaration,List<MutableClassDeclaration>> superclass, Map<MutableMethodDeclaration,Set<MutableMethodDeclaration>> dispatchmethod, TransformationContext context) {
		var i =0
		for (cl : superclass.keySet) {
			//Regroup methods of the class hierarchy by name+number of parameters
			val clazzes = new ArrayList<MutableClassDeclaration>()
			clazzes.add(cl)
			clazzes.addAll(superclass.get(cl))
			val Map<String, Set<MutableMethodDeclaration>> dispatchs = newHashMap
			for (clazz : clazzes) {
				for (m : clazz.declaredMethods) {
					val mname = m.simpleName + "__" + m.parameters.size
					var v = dispatchs.get(mname)
					if (v == null) {
						v = new LinkedHashSet<MutableMethodDeclaration>()
						dispatchs.put(mname, v)
					}
					v.add(m)
				}
			}
			
			for (key : dispatchs.keySet) {
				val res = dispatchs.get(key)
				if (res.size > 1) {
					i=i+res.size
					for (m : res) {
						if (dispatchmethod.get(m) == null)
							dispatchmethod.put(m, res)
						else
							dispatchmethod.get(m).addAll(res)
					}
				}
			}
		}

		//Sort Dispatchmethod entries values by hierarchy of their containing classes
		for (m : dispatchmethod.keySet) {
			val l = dispatchmethod.get(m).sort(new SortMethod(context))
			dispatchmethod.get(m).clear
			dispatchmethod.get(m).addAll(l)
			//m.addError(dispatchmethod.get(m).size.toString)
		}
	}
	
	/**
	 * For each annotated class store his super classes hierarchy.
	 * An annotated class which is a parent of an other annotated
	 * class is not in the final result.
	 * @annotedClasses All aspects
	 * @superclass Mapping computed between class and list of his super classes
	 * @context
	 */
	private def initSuperclass(List<? extends MutableClassDeclaration> annotedClasses, TransformationContext context, Map<MutableClassDeclaration,List<MutableClassDeclaration>> superclass) {
		//Add super classes for all annotated classes
		for (clazz : annotedClasses) {
			val ext = new ArrayList<MutableClassDeclaration>()
			Helper::getSuperClass(ext, clazz, context)
			if (ext.size > 0)
				superclass.put(clazz, ext)
		}
		//Get all super classes
		val allparent = new LinkedHashSet<MutableClassDeclaration>()
		for (child : superclass.keySet) {
			allparent.addAll(superclass.get(child))
		}
		//Remove super classes which are annotated
		for (p : allparent)
			superclass.remove(p)
	}
}


class SortMethod implements Comparator<MutableMethodDeclaration> {
	TransformationContext context

	new(TransformationContext context) {
		this.context = context
	}

	def override int compare(MutableMethodDeclaration arg0, MutableMethodDeclaration arg2) {
		val ext = new ArrayList<MutableClassDeclaration>()
		Helper::getSuperClass(ext, arg0.declaringType as MutableClassDeclaration, context)
		val ext1 = new ArrayList<MutableClassDeclaration>()
		Helper::getSuperClass(ext1, arg2.declaringType as MutableClassDeclaration, context)

		if (ext.contains(arg2.declaringType)) {
			//context.addError(arg0.declaringType,arg0.declaringType.simpleName + " > " + arg2.declaringType.simpleName+" " +ext.size)
			return -1
		} else if (ext1.contains(arg0.declaringType)) {
			//context.addError(arg0.declaringType,arg0.declaringType.simpleName + " < " + arg2.declaringType.simpleName + " " +ext1.size)
			return 1
		} else {
			//context.addError(arg0.declaringType,arg0.declaringType.simpleName + " = " + arg2.declaringType.simpleName)
			return 0
		}
	}
}