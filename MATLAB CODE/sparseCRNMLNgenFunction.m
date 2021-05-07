function [ row ] = sparseCRNMLNgenFunction ( name )

    fname = strcat(name, '.edges'); 
    prefix = strcat( 'crn_' , name ); 
    
    data = readmatrix(fname, 'FileType' , 'text' ); 


    meta_info = max(data);
    temp = size(data(:,1));
    data_length = size(data,1)

    n_layers = meta_info(1)
    n_nodes = max(meta_info(2),meta_info(3));
    n_edges = temp(1)




    filename = strcat(prefix , '._ode');
    fid = fopen(filename, 'w');

    row = ['begin model mod'];
    fprintf(fid, '%s\n' , row);

    row = [ 'begin init'];
    fprintf(fid, '%s\n' , row);

    for i = 1:n_nodes
    row = [ 'x' , num2str(i) , ' = 1' ] ; 
    fprintf(fid, '%s\n' , row);
    end

    for l = 1:n_layers
    row = [ 't' , num2str(l) , ' = 1' ] ; 
    fprintf(fid, '%s\n' , row);
    end

    row = ['end init'];
    fprintf(fid, '%s\n' , row);
    
    row = ['begin partition'];
    fprintf(fid, '%s\n' , row);

    row = ['{']
    for i = 1:n_nodes
        if i < n_nodes    
            row = [ row, 'x' , num2str(i) ,','] ; 
        end
        if i == n_nodes
            row = [ row, 'x' , num2str(i) ] ; 
        end
    end
    row = [row, '},{'];
    for l = 1:n_layers
        if l < n_layers 
            row = [ row , 't' , num2str(l) , ',' ] ; 
        end
        if l == n_layers
            row = [ row , 't' , num2str(l) ];
        end
    end
    
    row = [row, '}']; 
    fprintf(fid, '%s\n' , row);

    row = ['end partition'];
    fprintf(fid, '%s\n' , row);    
    
    
    row = ['begin reactions']; 
    fprintf(fid, '%s\n' , row);

    for i = 1:n_nodes
    row = [ ];

    %% Filtro dalla matrice con i dati solo le cose che mi servono per scrivere le reazioni
    filtro = data(:,2) == i ; 

    useful = data(filtro,:);

    n_useful = size(useful,1);

    for k = 1:n_useful
    row = [ 'x', num2str(useful(k,3)) , ' + t' , num2str(useful(k,1)) , ' -> x' , num2str(useful(k,2)) , ' + x', num2str(useful(k,3)) , ' + t' , num2str(useful(k,1)) , ' , ' , num2str(useful(k,4)) ]; 
    fprintf(fid, '%s\n' , row);
    end


    %%%% lo faccio anche per le altre perche' e' undirected
    filtro = data(:,3) == i ; 

    useful = data(filtro,:);

    n_useful2 = size(useful,1);

    for k = 1:n_useful2
    row = [ 'x', num2str(useful(k,2)) , ' + t' , num2str(useful(k,1)) , ' -> x' , num2str(useful(k,3)) , ' + x', num2str(useful(k,2)) , ' + t' , num2str(useful(k,1)) ' , ' , num2str(useful(k,4)) ]; 
    fprintf(fid, '%s\n' , row);
    end

    end

    for l = 1:n_layers

    row = [ ];

    %%% Qua filtro le righe della matrice che mi servono per scrivere la
    %%% reazioni dei vari layerz 
    filtro = data(:,1) == l ; 

    useful = data(filtro,:); 

    n_useful = size(useful,1); 

    for k = 1:n_useful 
    %%%% Moltiplichiamo per 2 perche' cosi contiamo gia entrambi i versi dell'edge tra k,2 e k,3 che e' undirected 
    row = [ 'x' , num2str(useful(k,2)) , ' + x' , num2str(useful(k,3)) , ' -> t' , num2str(useful(k,1)) , ' + x' , num2str(useful(k,2)) , ' + x' , num2str(useful(k,3)) , ' , ' , num2str( 2*useful(k,4) ) ] ; 
    fprintf(fid, '%s\n' , row);
    end



    end



    row = ['end reactions']; 
    fprintf(fid, '%s\n' , row);



    row = ['end model'];
    fprintf(fid, '%s\n' , row);

    fclose(fid);   
    
end    
