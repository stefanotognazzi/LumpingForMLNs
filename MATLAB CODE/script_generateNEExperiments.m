%%% Code written by Stefano Tognazzi
%%% INPUT: - (make sure the .edges file are in the same folder) 
%%% OUTPUT: 
%%% - A .ode file to run with ERODE
%%% - One ._ode file per instance with the model that will be used as an
%%% input by ERODE


files = dir(fullfile('.','*.edges'));
[n,inutile] = size(files);

experimentPrefix = "experimentsNE";

filename = strcat(experimentPrefix , '.ode');
fid = fopen(filename, 'w');

for i = 1:n
    fname = files(i).name;
    disp(i);
    disp(fname);
    C = strsplit(fname,'.');
    baseName = char(C(1));
    disp(baseName);
    
    sparseCRNMLNgenFunction( baseName );
    %%sparseCRNMLNgenFunctionArenasStyleIC( baseName ); 
    %%generateERODEArenas20pctProcessFromMultiplex( baseName ); 
    
    row = ['begin model mod' , num2str(i) ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'load(fileIn="crn_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'reduceBE(reducedFile="ne_', baseName , '._ode",prePartition=USER)' ];  
    fprintf(fid, '%s\n' , row);
    
    row = ['end model' ];
    fprintf(fid, '%s\n' , row);
end