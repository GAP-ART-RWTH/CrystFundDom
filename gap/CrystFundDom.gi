# Euclidean distance for internal use
BindGlobal("__cryst__EuclideanDistance",
    function(x, y)
        return Sqrt( Float(x[1]-y[1])^2 + Float(x[2]-y[2])^2 + Float(x[3]-y[3])^2);
    end
);

# Euclidean distance for internal use
BindGlobal("__cryst__EuclideanNorm",
    function(x)
        local res, minDist, i;
        res:=0;
        for i in [1..Length(x)] do
            res:=res+x[i]^2;
        od;
        return Rat(Sqrt(Float(res)));
    end
);


__cryst__Hyperplaneconversion:=function(elementsInOrbit, vector)
    ErrorNoReturn("there is neither the package 'polymaking' nor installed, nor are you running GAP inside OSCAR. \nPlease chose one of these options start the package loading process again.");
end;


InstallGlobalFunction( DirichletCellForFiniteWord,
    function( vector, length, generatingSet)
        local i, j, k, elementsOfLenghtL, gen, elementsInOrbit, e, hyperplanes, y, h, l, el, fundDomSurface, vif, coords, polymakeObj, vifTriangulated, facett, nextEdge, edges, facet, orderedFacets, newFacet, currVertex, possVertex, remainingVertices, oldElems, triangulatedFacets, pr;

        elementsOfLenghtL:=DuplicateFreeList(generatingSet);

        # check that vector has trailing 1 and if not append it
        if Length(vector) in [3,4] then
            if Length(vector) = 4 and not vector[4] = 1 then
                Error("last entry of vector to construct dirichlet cell around needs to end with trailing 1 or have three entries");
            fi; 
            if Length(vector) = 3 then
                Add(vector, 1);
            fi;
        else
            Error("vector needs to either have three entries or four entries including a trailing 1");
        fi; 

        for i in [1..Length(vector)] do
            vector[i] := Rat(vector[i]);
        od;

        # generate all elements induced by words of maximum length length
        for i in [1..length-1] do
            for gen in generatingSet do
                oldElems:=StructuralCopy(elementsOfLenghtL);
                for el in oldElems do
                    if not el*gen in elementsOfLenghtL then
                        Add(elementsOfLenghtL, el*gen);
                        #Print("added element ", el*gen, "\n");
                    fi;
                    if not el*(gen^(-1)) in elementsOfLenghtL then
                        Add(elementsOfLenghtL, el*(gen^(-1)));
                        #Print("added element ", el*(gen^(-1)), "\n");
                    fi;
                od;
            od;
        od;

        # generate all points of x^e for e \in elementsOfLenghtL
        elementsInOrbit := [];
        for e in elementsOfLenghtL do
            Add(elementsInOrbit, (vector*e));
        od;

        hyperplanes:=__cryst__Hyperplaneconversion(elementsInOrbit, vector);
        vif:=hyperplanes[1];
        coords:=hyperplanes[2];

        # vertices in faces are not necessary triangulated
        vifTriangulated:=[];
        edges:=[];
        for facet in vif do
            for i in [1..Size(facet)] do
                for j in [i..Size(facet)] do
                    if not i=j then
                        Add(edges, [facet[i], facet[j]]);
                    fi;
                od;
            od;
        od;

        # order the facets
        orderedFacets:=[];
        for facet in vif do
            if Size(facet) = 3 then
                Add(orderedFacets, facet);
            else
                newFacet:=[facet[1]];
                remainingVertices:=StructuralCopy(facet);
                Remove(remainingVertices, 1);
                while not IsEmpty(remainingVertices) do
                    currVertex:=Last(newFacet);
                    nextEdge:=[];
                    for possVertex in remainingVertices do
                        if Size(Filtered(edges, e -> e=[possVertex, currVertex] or e=[currVertex, possVertex]))>1 then
                            nextEdge:=Filtered(edges, e -> e=[possVertex, currVertex] or e=[currVertex, possVertex])[1];
                        fi;
                    od;
                    if nextEdge = [] then
                        Error("could not find new edge, currently trying from vertex ", currVertex, "\n");
                    fi;
                    if nextEdge[1] = currVertex then
                        Add(newFacet, nextEdge[2]);
                        Remove(remainingVertices, Position(remainingVertices, nextEdge[2]));
                    else
                        Add(newFacet, nextEdge[1]);
                        Remove(remainingVertices, Position(remainingVertices, nextEdge[1]));
                    fi;
                od;
                Add(orderedFacets, newFacet);
            fi;
        od;

        # triangulate the ordered faces
        triangulatedFacets:=[];
        for facet in orderedFacets do
            if not Size(facet) = 3 then
                for i in [2..(Size(facet)-1)] do
                    Add(triangulatedFacets, [facet[1], facet[i], facet[i+1]]);
                od;
            else
                Add(triangulatedFacets, facet);
            fi;
        od;

        # plot with GAPic
        # fundDomSurface:=SimplicialSurfaceByVerticesInFaces(triangulatedFacets);
        # pr:=SetVertexCoordinates3D(fundDomSurface, coords);
        # DrawComplexToJavaScript(fundDomSurface, Concatenation("dirichlet-cell-", String(length)), pr);

        # Print("dirichlet cell has volume of: ", Float(Polymake(polymakeObj, "VOLUME")), "\n\n");

        # return [fundDomSurface, triangulatedFacets, coords];
        return [triangulatedFacets, coords];
        # return 0;
    end 
);