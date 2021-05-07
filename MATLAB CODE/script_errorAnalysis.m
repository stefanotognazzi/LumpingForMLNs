%%% Code written by Stefano Tognazzi


clear all


%%% Place the name of the instance (without extension) to analyse
basename = 'out_arenasPLsynth2_100_0'; 


full_species = parse_speciesFromERODEmodels(basename);

be_name = strcat("be_",basename);
be_species = parse_speciesFromERODEmodelsWithSpace(be_name);

fe_name = strcat("fe_",basename);
fe_species = parse_speciesFromERODEmodelsWithSpace(fe_name);

se_name = strcat("se_",basename);
se_species = parse_speciesFromERODEmodelsWithSpace(se_name);


N = size(full_species,2);
be_N = size(be_species,2);
fe_N = size(fe_species,2);
se_N = size(se_species,2);

be_indices = zeros(1,be_N);
fe_indices = zeros(1,fe_N);
se_indices = zeros(1,se_N);


for i = 1:be_N
   be_indices(i) = find( full_species == be_species(i) );  
    
end

for i = 1:fe_N
   fe_indices(i) = find( full_species == fe_species(i) );  
    
end

for i = 1:se_N
   se_indices(i) = find( full_species == se_species(i) );  
    
end


full_fname = strcat("./StochKitOutput/full_",basename,"_output/stats/means.txt");
be_fname = strcat("./StochKitOutput/be_",basename,"_output/stats/means.txt"); 
fe_fname = strcat("./StochKitOutput/fe_",basename,"_output/stats/means.txt"); 
se_fname = strcat("./StochKitOutput/se_",basename,"_output/stats/means.txt"); 


full_data = readmatrix(full_fname, 'FileType', 'text');
be_data = readmatrix(be_fname, 'FileType' , 'text' );
fe_data = readmatrix(fe_fname, 'FileType' , 'text' ); 
se_data = readmatrix(se_fname, 'FileType' , 'text' ); 

full_data = full_data(:,1:(end-1));
be_data = be_data(:,1:(end-1));
fe_data = fe_data(:,1:(end-1));
se_data = se_data(:,1:(end-1));

full_ic = full_data(1,2:end);
be_ic = be_data(1,2:end);
fe_ic = fe_data(1,2:end);
se_ic = se_data(1,2:end);

full_points = full_data(:,2:end);
be_points = be_data(:,2:end);
fe_points = fe_data(:,2:end);
se_points = se_data(:,2:end);

full_ai = zeros(1,N); 
full_us = zeros(1,N);
full_as = zeros(1,N); 
for i = 1:N   
    if isAI(full_species(i)) 
        full_ai(i) = 1; 
    else
        full_ai(i) = 0;
    end
    
    if isUS(full_species(i))
        full_us(i) = 1;
    else
        full_us(i) = 0;
    end
    
    if isAS(full_species(i))
        full_as(i) = 1;
    else
        full_as(i) = 0; 
    end
 
end

be_ai = zeros(1,be_N); 
be_us = zeros(1,be_N);
be_as = zeros(1,be_N); 
for i = 1:be_N   
    if isAI(be_species(i)) 
        be_ai(i) = 1; 
    else
        be_ai(i) = 0;
    end
    
    if isUS(be_species(i))
        be_us(i) = 1;
    else
        be_us(i) = 0;
    end
    
    if isAS(be_species(i))
        be_as(i) = 1;
    else
        be_as(i) = 0; 
    end
 
end

fe_ai = zeros(1,fe_N); 
fe_us = zeros(1,fe_N);
fe_as = zeros(1,fe_N); 
for i = 1:fe_N   
    if isAI(fe_species(i)) 
        fe_ai(i) = 1; 
    else
        fe_ai(i) = 0;
    end
    
    if isUS(fe_species(i))
        fe_us(i) = 1;
    else
        fe_us(i) = 0;
    end
    
    if isAS(fe_species(i))
        fe_as(i) = 1;
    else
        fe_as(i) = 0; 
    end
 
end


se_ai = zeros(1,se_N); 
se_us = zeros(1,se_N);
se_as = zeros(1,se_N); 
for i = 1:se_N   
    if isAI(se_species(i)) 
        se_ai(i) = 1; 
    else
        se_ai(i) = 0;
    end
    
    if isUS(se_species(i))
        se_us(i) = 1;
    else
        se_us(i) = 0;
    end
    
    if isAS(se_species(i))
        se_as(i) = 1;
    else
        se_as(i) = 0; 
    end
 
end


full_stats = zeros(6,3);
for i = 1:6
    full_stats(i,1) = sum(full_points(i,:).*full_ai);
    full_stats(i,2) = sum(full_points(i,:).*full_us);
    full_stats(i,3) = sum(full_points(i,:).*full_as);
    %full_stats(i,:)
end
full_stats


be_stats = zeros(6,3);
for i = 1:6
    be_stats(i,1) = sum(be_points(i,:).*be_ai);
    be_stats(i,2) = sum(be_points(i,:).*be_us);
    be_stats(i,3) = sum(be_points(i,:).*be_as);
end
be_stats

fe_stats = zeros(6,3);
for i = 1:6
    fe_stats(i,1) = sum(fe_points(i,:).*fe_ai);
    fe_stats(i,2) = sum(fe_points(i,:).*fe_us);
    fe_stats(i,3) = sum(fe_points(i,:).*fe_as);
end
fe_stats

se_stats = zeros(6,3);
for i = 1:6
    se_stats(i,1) = sum(se_points(i,:).*se_ai);
    se_stats(i,2) = sum(se_points(i,:).*se_us);
    se_stats(i,3) = sum(se_points(i,:).*se_as);
end
se_stats

abs_error_be = abs(full_stats - be_stats); 
pct_error = abs_error_be./full_stats;
mpe = max(pct_error); 
max(mpe)


%%sum(full_points(1,:).*full_ai) %%% Count the numbers of AI in timepoint 1