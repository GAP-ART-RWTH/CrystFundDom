BindGlobal("__cryst__HyperplaneconversionPolymaking",
    function(elementsInOrbit, vector)
        local hyperplanes, y, h, i, polymakeObj, coords, vif;
        # calculate the hyperplanes necessary for the dirichlet construction
        # we cut of the last coordinate as it is always 0 because of the trailing 1 from the isometry operations
        # using the formulas presented here: https://math.stackexchange.com/questions/2858815/understanding-formula-for-hyperplanes
        hyperplanes:=[];
        for y in elementsInOrbit do
            h:=[];
            h[1]:=1/2*(__cryst__EuclideanNorm((y))^2 - __cryst__EuclideanNorm((vector))^2);
            for i in [1..Length(vector)-1] do
                h[i+1]:=Rat(y[i]-vector[i]);
            od;
            Add(hyperplanes, h);
        od;

        # remove zeroes, as they are not allowed
        while not Position(hyperplanes, [0,0,0,0]) = fail do
            Remove(hyperplanes, Position(hyperplanes, [0,0,0,0]));
        od;

        # get the vertex coordinates with polymake
        polymakeObj:=CreatePolymakeObject();;
        AppendInequalitiesToPolymakeObject(polymakeObj, hyperplanes);;
        coords:=Polymake(polymakeObj, "VERTICES");;
        # get vertices in faces as well
        vif:=Polymake(polymakeObj, "VERTICES_IN_FACETS");;
        return [vif, coords];
    end
);


__cryst__Hyperplaneconversion := __cryst__HyperplaneconversionPolymaking;