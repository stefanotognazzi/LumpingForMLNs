function [] = generateERODESpreadingProcessFromMultiplex ( name ) 
    
    fname = strcat(name, '.edges');
    data = readmatrix(fname, 'FileType' , 'text' );

    meta_info = max(data);
    min_info = min(data);
    temp = size(data(:,1));
    
    n_nodes = max(meta_info(2),meta_info(3));
    n_edges = temp(1)

    layers = data(:,1); 
    sources = data(:,2);
    targets = data(:,3);
    
    l = layers;
    x = sources;
    y = targets;
    w = data(:,4);

    
    delta = 0.6;
    mu = 0.4;
    lambda = 0.15;
    betaA = 0.01;
    betaU = 0.4;
    
    filename = strcat(name, '._ode');
    fid = fopen(filename, 'w');
    
    row = ['begin model mod'];
    fprintf(fid, '%s\n' , row);


    row = [ 'begin parameters'];
    fprintf(fid, '%s\n' , row); 

    row = [ 'del = ' , num2str(delta) ];
    fprintf(fid, '%s\n' , row); 

    row = [ 'mu = ' , num2str(mu) ];
    fprintf(fid, '%s\n' , row); 

    row = [ 'lambda = ' , num2str(lambda) ];
    fprintf(fid, '%s\n' , row); 
    
    row = [ 'betaA = ' , num2str(betaA) ];
    fprintf(fid, '%s\n' , row); 
    
    row = [ 'betaU = ' , num2str(betaU) ];
    fprintf(fid, '%s\n' , row); 
    
    row = [ 'end parameters'];
    fprintf(fid, '%s\n' , row);
     
    row = [ 'begin init'];
    fprintf(fid, '%s\n' , row);

    for i = 1:n_nodes
        row = [ 'ai' , num2str(i) , ' = 1' ] ;
        fprintf(fid, '%s\n' , row);
    end    
    for i = 1:n_nodes    
        row = [ 'as' , num2str(i) , ' = 0' ] ; 
        fprintf(fid, '%s\n' , row);
    end
    for i = 1:n_nodes    
        row = [ 'us' , num2str(i) , ' = 0' ] ; 
        fprintf(fid, '%s\n' , row);
    end

    row = [ 'end init'];
    fprintf(fid, '%s\n' , row);
    
    
    row = ['begin partition'];
    fprintf(fid, '%s\n' , row);

    row = ['{'];
    for i = 1:n_nodes
        if i < n_nodes    
            row = [ row, 'ai' , num2str(i) ,','] ; 
        end
        if i == n_nodes
            row = [ row, 'ai' , num2str(i) ] ; 
        end
    end
    row = [row, '},{'];
    for i = 1:n_nodes
        if i < n_nodes    
            row = [ row, 'as' , num2str(i) ,','] ; 
        end
        if i == n_nodes
            row = [ row, 'as' , num2str(i) ] ; 
        end
    end
    row = [row, '},{'];
    for i = 1:n_nodes
        if i < n_nodes    
            row = [ row, 'us' , num2str(i) ,','] ; 
        end
        if i == n_nodes
            row = [ row, 'us' , num2str(i) ] ; 
        end
    end
    
    row = [row, '}']; 
    fprintf(fid, '%s\n' , row);

    row = ['end partition'];
    fprintf(fid, '%s\n' , row); 
    
    
    
    

    row = ['begin reactions']; 
    fprintf(fid, '%s\n' , row);

    for i = 1:n_nodes
        %row = ['ai' , num2str(i) , ' -> us' , num2str(i) , ' , delta*mu' ];
        %fprintf(fid, '%s\n' , row);
        
        row = ['ai' , num2str(i) , ' -> as' , num2str(i) , ' , mu' ];
        fprintf(fid, '%s\n' , row);
        
        row = ['as' , num2str(i) , ' -> us' , num2str(i) , ' , del' ];
        fprintf(fid, '%s\n' , row);
    end
    
    for i = 1:n_edges
       %%%%%% 1: Physical Layer
       %%%%%% 2: Virtual layer
       if l(i) == 1 
            row = [ 'as' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' -> ai' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' , betaA ' ] ; 
            fprintf(fid, '%s\n' , row);
            row = [ 'us' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' -> ai' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' , betaU ' ] ; 
            fprintf(fid, '%s\n' , row);
            
            %%%% The other side of undirected
            row = [ 'as' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' -> ai' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' , betaA ' ] ; 
            fprintf(fid, '%s\n' , row);
            row = [ 'us' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' -> ai' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' , betaU ' ] ; 
            fprintf(fid, '%s\n' , row);
       end
       
       if l(i) == 2
           row = [ 'us' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' -> as' , num2str(x(i)) , ' + ai' , num2str(y(i)) , ' , lambda ' ] ;
           fprintf(fid, '%s\n' , row);
           row = [ 'us' , num2str(x(i)) , ' + as' , num2str(y(i)) , ' -> as' , num2str(x(i)) , ' + as' , num2str(y(i)) , ' , lambda ' ] ;
           fprintf(fid, '%s\n' , row);
           
           %%%% The other side of undirected
           row = [ 'us' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' -> as' , num2str(y(i)) , ' + ai' , num2str(x(i)) , ' , lambda ' ] ;
           fprintf(fid, '%s\n' , row);
           row = [ 'us' , num2str(y(i)) , ' + as' , num2str(x(i)) , ' -> as' , num2str(y(i)) , ' + as' , num2str(x(i)) , ' , lambda ' ] ;
           fprintf(fid, '%s\n' , row);
       end
        
        
    end
    
    row = ['end reactions']; 
    fprintf(fid, '%s\n' , row);

    row = ['end model'];
    fprintf(fid, '%s\n' , row);


end