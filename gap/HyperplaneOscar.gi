BindGlobal("__cryst__HyperplaneconversionOscar",
    function(elementsInOrbit, vector)
        local hyperplanes, y, h, i, TV, TM, P, vertices, vif_mat, rhs, r, coords, vif;
        # calculate the hyperplanes necessary for the Dirichlet construction
        # we cut off the last coordinate as it is always 0 because of the trailing 1 from the isometry operations
        # using the formulas presented here: https://math.stackexchange.com/questions/2858815/understanding-formula-for-hyperplanes
        hyperplanes:=[];
        rhs:= [];
        for y in elementsInOrbit do
            h:=[];
            # Note that Oscar's functions for polyhedra use *affine coordinates*,
            # whereas Polymake itself uses *homogeneous coordinates*.
            # That is, we ignore the last component `1` of each vector.
            # (Deal with the situation that the last component is not normalized?)
            for i in [1..Length(vector)-1] do
                h[i]:=Rat(y[i]-vector[i]);
            od;
            r:= 1/2*(__cryst__EuclideanNorm((y))^2
                     - __cryst__EuclideanNorm((vector))^2);
            if not( IsZero( h ) and IsZero( r ) ) then
              Add( hyperplanes, -h );
              Add( rhs, r );
            fi;
        od;

        # get the vertex coordinates with polymake
        # (We work over the field `Oscar.QQ` of Rationals.)
        TV:= JuliaType( Oscar.Vector, [ Oscar.QQFieldElem ] );
        TM:= JuliaType( Oscar.Matrix, [ Oscar.QQFieldElem ] );
        P:= Oscar.polyhedron( Oscar.QQ, GAPToJulia( TM, hyperplanes ),
                                        GAPToJulia( TV, rhs ) );
        vertices:= Oscar.vertices(P);
        coords:= Julia.GapObj(Oscar.point_matrix(vertices));

        # get vertices in faces as well
        vif_mat:= Oscar.pm_object(P).VERTICES_IN_FACETS;# type `IncidenceMatrix`
        vif:= List( [1..Oscar.number_of_rows(vif_mat)],
                    i -> Oscar.GapObj(Oscar.row(vif_mat, i)));

        return [vif, coords];
    end
);

__cryst__Hyperplaneconversion := __cryst__HyperplaneconversionOscar;