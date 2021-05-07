# LumpingForMLNs
Accompanying material for the paper "Lumping Reductions for Multispread in Multi-Layer Networks" 
It features the code that can be used to compute Node Equivalence, Backward Equivalence, Forward Equivalence and Stochastic Equivalence on Multiplex Multi-Layer Networks.


Requirements: 
1. MATLAB
2. ERODE ( https://www.erode.eu , to compute reductions )
3. StochKit ( https://cse.cs.ucsb.edu/stochkit , to perform fast SSA simulations)

Size and cost of the reductions:
1. Move the content of "INSTANCES" and "MATLAB CODE" in a MATLAB folder of your preference
2. Place "script_generateExperiments" and "generateERODESpreadingProcessFromMultiplex" in the same folder
3. From MATLAB, run "script_generateExperiments"
  3.1. This should have generated a .ode file, 4 ._ode files (one per instance) and a .sh file
4. In ERODE, create an ERODE project and place the .ode and the ._ode files in the project
5. Open "experiments.ode" and run the file
6. The console displays the results for BE, FE and SE. For each instance 3 files are generated (one per reduction) and they can be discriminated by the prefix (be_ , fe_ , se_ ).

This replicates the results presented in Sections 3.2 and 3.3 of the paper. 

Speeding up the stochastic simulation:
7. From the ERODE Project folder copy the files with .xml extension and paste them in the StochKit-master folder
8. From the MATLAB folder copy "runningSSA.sh" script and past it in the StochKit-master folder (make sure to have permissions to run the script) 
9. From the Terminal, move to your StochKit-master folder and run ./runningSSA.sh 
10. Consult the files with prefix "time_" to obtain the information on the running times of each instance. 

This replicates the results presented in Section 3.4. of the paper. 
  
Approximation of the reduction: 
11. From the ERODE Project folder copy *all* the files with "._ode" extension and paste them into the MATLAB folder
12. Create a Folder in your MATLAB folder named "StochKitOutput"
13. From the StochKit-master folder copy all the folders that were generated as the output of StochKit in the folder created at point 12. 
14. From MATLAB run the script "script_errorAnalysis" 

This replicates the results presented in Section 3.5. of the paper. 


Node Equivalence: 
15. To perform NE, from MATLAB, run "script_generateNEExperiments" 
16. Copy the output files in an ERODE project
17. Run the "experimentsNE.ode" file from ERODE and inspect the results. 

This replicates the results presented in Section 3.6. of the paper. 

In this repository you can find:
- INSTANCES: Contains the 100 nodes MLNs used in the paper (1.)
- MATLAB CODE: Contains the required scripts and functions that are needed in MATLAB (1.) 
- ERODE INPUT: Contains the .ode and ._ode files that can be run in ERODE (4.)
- ERODE OUTPUT: Contains the output of ERODE (6.)
- STOCHKIT INPUT: Contains the input for StochKit (7.)
- STOCHKIT OUTPUT: Contains the output of Stockkit (10.)
