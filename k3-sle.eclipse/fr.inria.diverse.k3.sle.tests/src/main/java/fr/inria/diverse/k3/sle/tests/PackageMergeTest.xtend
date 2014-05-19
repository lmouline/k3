package fr.inria.diverse.k3.sle.tests

import fr.inria.diverse.k3.sle.tests.common.OrderAgnosticEqualityHelper
import fr.inria.diverse.k3.sle.lib.PackageMergeException

import org.eclipse.emf.ecore.EPackage

import org.eclipse.emf.common.util.Diagnostic
import org.eclipse.emf.common.util.URI

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl

import org.eclipse.emf.ecore.util.Diagnostician

import org.eclipse.emf.ecore.xmi.impl.EcoreResourceFactoryImpl

import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*

import static extension fr.inria.diverse.k3.sle.lib.PackageMerge.*

class PackageMergeTest
{
	OrderAgnosticEqualityHelper equalityHelper = new OrderAgnosticEqualityHelper
	EPackage pkgA
	EPackage pkgB
	EPackage pkgC
	EPackage pkgD
	EPackage pkgE
	EPackage pkgF
	EPackage pkgG

	@Before
	def void setUp() {
		val rs = new ResourceSetImpl
		Resource$Factory$Registry.INSTANCE.extensionToFactoryMap.put("ecore", new EcoreResourceFactoryImpl)

		pkgA = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/A.ecore"), true).contents.head as EPackage
		pkgB = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/B.ecore"), true).contents.head as EPackage
		pkgC = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/C.ecore"), true).contents.head as EPackage
		pkgD = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/D.ecore"), true).contents.head as EPackage
		pkgE = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/E.ecore"), true).contents.head as EPackage
		pkgF = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/F.ecore"), true).contents.head as EPackage
		pkgG = rs.getResource(URI.createURI("tests-inputs/metamodels/merge/G.ecore"), true).contents.head as EPackage
	}

	@Test
	def testMergeWithoutConflict1() {
		val res = callMergeOperator(pkgA, pkgB, pkgC)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgC))
	}

	@Test
	def testMergeWithoutConflict2() {
		val res = callMergeOperator(pkgB, pkgA, pkgC)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgC))
	}

	@Test
	def testMergeWithNewClasses1() {
		val res = callMergeOperator(pkgA, pkgD, pkgE)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgE))
	}

	@Test
	def testMergeWithNewClasses2() {
		val res = callMergeOperator(pkgD, pkgA, pkgE)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgE))
	}

	@Test(expected = PackageMergeException)
	def void testMergeWithConflict1() {
		pkgC.mergeWith(pkgA)
	}

	@Test(expected = PackageMergeException)
	def void testMergeWithConflict2() {
		pkgC.mergeWith(pkgB)
	}

	@Test(expected = PackageMergeException)
	def void testMergeWithConflict3() {
		pkgA.mergeWith(pkgC)
	}

	@Test(expected = PackageMergeException)
	def void testMergeWithConflict4() {
		pkgB.mergeWith(pkgC)
	}

	@Test
	def testMergeDisjoint1() {
		val res = callMergeOperator(pkgB, pkgF, pkgG)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgG))
	}

	@Test
	def testMergeDisjoint2() {
		val res = callMergeOperator(pkgF, pkgB, pkgG)

		assertEquals(Diagnostician.INSTANCE.validate(res).getCode(), Diagnostic.OK)
		assertTrue(equalityHelper.equals(res, pkgG))
	}

	// Just adapting packages features so that the equals() doesn't fail because of nsURI and the like
	private def callMergeOperator(EPackage base, EPackage ext, EPackage expected) {
		val res = base.mergeWith(ext)

		res.name = expected.name
		res.nsURI = expected.nsURI
		res.nsPrefix = expected.nsPrefix

		return res
	}
}