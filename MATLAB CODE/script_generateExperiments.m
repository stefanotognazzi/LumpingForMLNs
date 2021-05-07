%%% Code written by Stefano Tognazzi
%%% INPUT: - (make sure the .edges file are in the same folder) 
%%% OUTPUT: 
%%% - A .ode file to run with ERODE
%%% - One ._ode file per instance with the model that will be used as an
%%% input by ERODE
%%% - A .sh file that can be used as a script to run SSA with StochKit



files = dir(fullfile('.','*.edges'));
[n,inutile] = size(files);

experimentPrefix = "esperiments";

filename = strcat(experimentPrefix , '.ode');
fid = fopen(filename, 'w');


file2 = 'runningSSA.sh';
fid2 = fopen(file2,'w');

for i = 1:n
    fname = files(i).name;
    disp(i);
    disp(fname);
    C = strsplit(fname,'.');
    baseName = char(C(1));
    disp(baseName);
    
    
    
    generateERODESpreadingProcessFromMultiplex(baseName);
    
    row = ['begin model mod' , num2str(i) ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'load(fileIn="' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    
    row = [ 'reduceBE(prePartition=USER,reducedFile="be_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    row = [ 'reduceFE(prePartition=USER,reducedFile="fe_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    row = [ 'reduceSE(prePartition=USER,reducedFile="se_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'exportStochKit(fileOut="full_',baseName, '.xml")' ]; 
    fprintf(fid, '%s\n' , row);
    
    %row = [ 'simulateCTMC(tEnd=4,repeats=50,method=ssa,viewPlot=NO,csvFile="fullSSAsoluation_' , baseName , '")' ] ; 
    %fprintf(fid, '%s\n' , row);
    
    row = ['end model' ];
    fprintf(fid, '%s\n' , row);
    
    %%% Export BE
    
    row = ['begin model mod' , num2str(i+100) ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'load(fileIn="be_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'exportStochKit(fileOut="be_',baseName, '.xml")' ]; 
    fprintf(fid, '%s\n' , row);
    
    row = ['end model' ];
    fprintf(fid, '%s\n' , row);
    
    %%% Export SE
    
    row = ['begin model mod' , num2str(i+200) ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'load(fileIn="se_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'exportStochKit(fileOut="se_',baseName, '.xml")' ]; 
    fprintf(fid, '%s\n' , row);
    
    row = ['end model' ];
    fprintf(fid, '%s\n' , row);
    
    %%% Export FE 
    
    row = ['begin model mod' , num2str(i+300) ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'load(fileIn="fe_' , baseName , '._ode")' ];
    fprintf(fid, '%s\n' , row);
    
    row = [ 'exportStochKit(fileOut="fe_',baseName, '.xml")' ]; 
    fprintf(fid, '%s\n' , row);
    
    row = ['end model' ];
    fprintf(fid, '%s\n' , row);
    
    
    %%%% Currently set a 5 repetitions of SSA, to change the number of
    %%%% repetitions change the option after -r (refer to StochKit
    %%%% documentation for other options
    row = ['./ssa -m full_', baseName,'.xml -t 10 -r 5 -i 5 -f > time_full_',baseName,'.txt' ] ; 
    fprintf(fid2, '%s\n' , row);
    row = ['./ssa -m be_', baseName,'.xml -t 10 -r 5 -i 5 -f > time_be_',baseName,'.txt' ] ; 
    fprintf(fid2, '%s\n' , row);
    row = ['./ssa -m fe_', baseName,'.xml -t 10 -r 5 -i 5 -f > time_fe_',baseName,'.txt' ] ; 
    fprintf(fid2, '%s\n' , row);
    row = ['./ssa -m se_', baseName,'.xml -t 10 -r 5 -i 5 -f > time_se_',baseName,'.txt' ] ; 
    fprintf(fid2, '%s\n' , row);
    
end