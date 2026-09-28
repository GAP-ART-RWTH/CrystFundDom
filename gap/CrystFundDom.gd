#! @Chapter Fundamental domains
#! @ChapterLabel fundDoms

#! @Section Main function
#! @SectionLabel main

#! The following is a definition of crystallographic groups, which will be used in this package.
#! Let <Math>\Gamma \leq E(n)</Math> be a subgroup of the Euclidean group of dimension <Math>n</Math> as well as <Math>F \subseteq &RR;^n</Math> a closed subset. 
#! We call <Math>F</Math> a fundamental domain of <Math>\Gamma</Math> if the following two properties are satisfied:

#! <Display>\bigcup_{\gamma \in \Gamma} F^\gamma = &RR;^n</Display>
#! and there is a system of representatives <Math>V \subseteq &RR;^n</Math> of the orbits of <Math>\Gamma</Math> on <Math>&RR;^n</Math> such that 
#! <Display>F^\circ \subseteq V \subseteq F.</Display>

#! Further, if <Math>\Gamma</Math> is a discrete subgroup and there exists a compact fundamental domain for <Math>\Gamma</Math> we call <Math>\Gamma</Math> a <E>crystallographic group</E>.

#! With Bieberbachs theorem showing that there are only finitely many crystallographic groups for a fixed dimension and lists existing for small degrees (currently <Math>\leq 6</Math>) the question arises how one can compute such a compact fundamental domain. 

#! One approach is to compute a Dirichlet cell, which for vectors in special position has been show to be a fundamental domain. However the formula for a Dirichlet cell contains an intersection over the orbit of an vector, which is an infinite set. In TODO it has been shown, that there is a finite word length such that the Dirichlet cell can be computed as the intersection only over the finite word length elements. Therefore, an algorithm has been implemented below, that takes a starting vector, crystallographic group and natural number and computes the Dirichlet cell over words of at most that length. If the natural number is big enough, the resulting polyhedron will be a Dirichlet cell. Combined with choosing a vector in general position (i.e. trivial stabiliser), this allows a user to compute a fundamental domain for a given crystallographic group.
#! For <Math>n=3</Math> to check if the number is big enough, there is a possibility to precompute the volume of the fundamental domains (is the same for all) (cite TODO). The algorithm below also prints the computed volume and when both are the same, the word length was sufficient. 

#! @BeginGroup
#! @Description

#! Computes the Dirichlet cell computed as the intersection over the orbit of <K>vector</K> with elements being words of length at most <K>length</K> in <K>generatingSet</K>.
#! A requirement for the computation is <K>Polymaking</K> or the use of GAP inside OSCAR (https://www.oscar-system.org/). If none are available then an error is thrown, if both are available oscar is preferred. 
#! The result is a list <K>[triangulatedFacets, coords]</K> where <K>triangulatedFacets</K> is a list of the faces of the resulting polyhedron and <K>coords</K> contains the coordinates of the vertices. 

#! @Returns a polygonal complex
#! @Arguments startingVector, length, generatingSet
DeclareGlobalFunction( "DirichletCellForFiniteWord" );
#! @EndGroup

#! @ExampleSession
#! gap> gens := GeneratorsOfGroup(SpaceGroupBBNWZ(3, 195));;
#! gap> cell := DirichletCellForFiniteWord([1/3,1/4,1/5,1], 4, gens);;
#! polymake: upgrading /tmp/gaptempdiriN29av/poly2545 from old plain file format
#! polymake: used package ppl
#!   The Parma Polyhedra Library ([[wiki:external_software#PPL]]): A C++ library for 
#!   convex polyhedra and other numerical abstractions.
#!   http://www.cs.unipr.it/ppl/
#! @EndExampleSession

#! If the packages <K>SimplicialSurfaces</K> and <K>GAPic</K> are also loaded, the resulting polyhedron can also be animated in an <K>.html</K> file.

#! @ExampleSession
#! gap> LoadPackage("SimplicialSurfaces");;
#! gap> LoadPackage("GAPic");;
#! [banners ommited for readability]
#! gap> fundDomSurface:=SimplicialSurfaceByVerticesInFaces(cell[1]);
#! simplicial surface (18 vertices, 48 edges, and 32 faces)
#! gap> printRecord:=SetVertexCoordinates3D(fundDomSurface, cell[2]);;
#! gap> DrawComplexToJavaScript(fundDomSurface, "dirichlet-cell.html", printRecord);;
#! @EndExampleSession

#! As a result of the commands used in the example above, there should be a file called <K>dirichlet-cell.html</K> in the current directory. This contains the animation, which can be viewed with most webbrowsers.