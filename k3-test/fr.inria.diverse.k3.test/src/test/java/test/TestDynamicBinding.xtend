package test

import fr.inria.triskell.k3.Aspect
import fr.inria.triskell.k3.OverrideAspectMethod
import org.junit.Test
import static org.junit.Assert.*
import static extension test.RootAspect.*


class TestDynamicBinding {
	@Test def void testX1_as_XExpression() {
		val XExpression x = new X1()
		println(x.visit)
		assertEquals("test.X1 X1 test.X1 XExp test.X1 Root", x.visit)
	}
	
	@Test def void testX1_as_XSubExp1() {
		val XSubExp1 x = new X1()
		println(x.visit)
		assertEquals("test.X1 X1 test.X1 XExp test.X1 Root", x.visit)
	}
	
	@Test def void testX1_as_X1() {
		val x = new X1()
		println(x.visit)
		assertEquals("test.X1 X1 test.X1 XExp test.X1 Root", x.visit)
	}
	
	
	@Test def void testX2_as_XExpression() {
		val XExpression x = new X2()
		println(x.visit)
		assertEquals("test.X2 X2 test.X2 XExp test.X2 Root", x.visit)
	}
	
	@Test def void testX2_as_XSubExp2() {
		val XSubExp2 x = new X2()
		println(x.visit)
		assertEquals("test.X2 X2 test.X2 XExp test.X2 Root", x.visit)
	}
	
	@Test def void testX2_as_X2() {
		val x = new X2()
		println(x.visit)
		assertEquals("test.X2 X2 test.X2 XExp test.X2 Root", x.visit)
	}
	
	
	@Test def void testX3_as_XExpression() {
		val XExpression x = new X3
		println(x.visit)
		assertEquals("test.X3 X3 test.X3 XExp test.X3 Root", x.visit)
	}
	
	@Test def void testX3_as_XSubExp3() {
		val XSubExp3 x = new X3
		println(x.visit)
		assertEquals("test.X3 X3 test.X3 XExp test.X3 Root", x.visit)
	}
	
	@Test def void testX3_as_X3() {
		val x = new X3
		println(x.visit)
		assertEquals("test.X3 X3 test.X3 XExp test.X3 Root", x.visit)
	}
	
	
	
	@Test def void testX4_as_XExpression() {
		val XExpression x = new X4
		println(x.visit)
		assertEquals("test.X4 X4 test.X4 XExp test.X4 Root", x.visit)
	}
	
	@Test def void testX4_as_XSubExp4() {
		val XSubExp4 x = new X4
		println(x.visit)
		assertEquals("test.X4 X4 test.X4 XExp test.X4 Root", x.visit)
	}
	
	@Test def void testX4_as_X4() {
		val x = new X4
		println(x.visit)
		assertEquals("test.X4 X4 test.X4 XExp test.X4 Root", x.visit)
	}
}

interface XExpression {}
interface XSubExp1 extends XExpression{}
interface XSubExp2 extends XExpression{}
interface XSubExp3 extends XExpression{}
interface XSubExp4 extends XExpression{}
class X1 implements XSubExp1{}
class X2 implements XSubExp2{}
class X3 implements XSubExp3{}
class X4 implements XSubExp4{}

@Aspect(className=typeof(Object))
abstract class RootAspect {
	def String visit() {
		_self.class.name + " Root"
	}
}

@Aspect(className=typeof(XExpression))
abstract class XExpressionAspect extends RootAspect{
	@OverrideAspectMethod
	def String visit() {
		_self.class.name + " XExp" + " " + _self.super_visit
	}
}

@Aspect(className=typeof(XSubExp1))
class X1Aspect extends XExpressionAspect{
	@OverrideAspectMethod
	def String visit() {
		_self.class.name + " X1" + " " + _self.super_visit
	}
}


@Aspect(className=typeof(XSubExp2))
class X2Aspect extends XExpressionAspect{
	@OverrideAspectMethod
	def String visit() {
		_self.class.name + " X2" + " " + _self.super_visit
	}
}


@Aspect(className=typeof(XSubExp3))
class X3Aspect extends XExpressionAspect{
	@OverrideAspectMethod
	def String visit() {
		_self.class.name + " X3" + " " + _self.super_visit
	}
}


@Aspect(className=typeof(XSubExp4))
class X4Aspect extends XExpressionAspect{
	@OverrideAspectMethod
	def String visit() {
		_self.class.name + " X4" + " " + _self.super_visit
	}
}

