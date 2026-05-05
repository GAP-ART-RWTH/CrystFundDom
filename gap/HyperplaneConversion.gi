if not IsBoundGlobal("__cryst__Hyperplaneconversion") then
    if IsPackageMarkedForLoading("oscarinterface", "1.0.0") then
        BindGlobal("__cryst__Hyperplaneconversion",
            function(hyperplanes)
                return "oscarversion";
            end
        );
    elif IsPackageMarkedForLoading("polymaking", "0.8") then
        BindGlobal("__cryst__Hyperplaneconversion",
            function(hyperplanes)
                return "polymakingversion";
            end
        );    
    else
        Error("no method to convert from H-vector to V-vector available. Please either install the polymaking GAP-package or start a GAP session inside OSCAR.");
    fi;
fi;