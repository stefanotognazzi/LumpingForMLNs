function [list_of_species] = parse_speciesFromERODEmodelsWithSpace( basename )

    fname = strcat(basename, '._ode');
    disp(fname)
    fid = fopen(fname);

    filtro_commenti = '//'; 

    filtro_inizio_species = ' begin init'; 
    filtro_fine_species = ' end init' ;
    
    
    linecounter = 1; 
    
    hunt_for_species = 0 ; 
    
    lista = [];
    tline = fgetl(fid);
    
    while ischar(tline)
        
        if strncmpi(filtro_inizio_species,tline,10)
            hunt_for_species = 1;
            linecounter = linecounter+1 ; 
            tline = fgetl(fid); 
        end
        
        while hunt_for_species == 1
            intermediateCell = split(tline);
            s_inter = size( intermediateCell , 1);
            speciesString = string(intermediateCell{2,1});
            lista = [lista, speciesString];
            
            linecounter = linecounter + 1;
            tline = fgetl(fid);
            if strncmpi(filtro_fine_species , tline , 10)
               hunt_for_species = 0;  
            end
        end
        
        linecounter = linecounter+1 ; 
        tline = fgetl(fid); 

    end

    list_of_species = lista;

end