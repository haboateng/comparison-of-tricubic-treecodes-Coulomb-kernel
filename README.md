# Comparison-of-tricubic-treecodes-Coulomb-kernel
Code for three different tricubic treecodes with different global smoothness : C-1 continuous, C-0 continuous and discontinuous

!
!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  Authors:

  	Henry A. Boateng  (boateng@sfsu.edu) 
  	Department of Mathematics
  	San Francisco State University
  	San Francisco, CA
     
  	Svetlana Tlupova (tlupovs@farmingdale.edu)
  	Department of Mathematics
  	Farmingdale State College, SUNY
  	Farmingdale, NY
  
  This material is based upon work partially supported by the 
  National Science Foundation under Grant Nos. CHE-1800181 and DMS-2012371
  and U.S. Department of Energy, Office of Science, Office of Work- force 
  Development for Teachers and Scientists (WDTS) under the Visiting Faculty Program.
  
!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   NOTE: Please include the following references in any work that
         utilizes this code:
         
         (1) Boateng. H. A., Tlupova, S.: The effect of smoothness on
         the accuracy of treecode approximations
            Communications in Computer Physics, submitted, (2022)  
		 
        (2) Boateng. H. A., Tlupova, S.: A treecode algorithm based on 
            tricubic interpolation with global $\mathbb{C}^1$ continuity
            Communications in Computer Physics, submitted, (2022)  
	    
Summary of files :
------------------

      rand*.txt       : Files containing the coordinates of the particles
                        distributed in [-5.0,5.0]x[-5.0,5.0]x[0.0,10.0].
                        The files rand_10000.txt, rand_80000.txt and rand_640000.txt
                        correspond to 10000, 80000, and 640000 particles respectively.
                        
      lambda*.txt      : Files containing the weights of the particles in the
                         corresponding rand*.txt
                        
                      

!!!!!!!
! .cpp and .h FILES 
      direct_sum.cpp : C++ file for exact computation of the potential and field. 
      
      Tricubic_C1.cpp   : Main C++ program for the global-C1 tricubic treecode.
      			  This version uses analytical derivatives of the kernel.
                          The same code is provided in our repository:
			  https://github.com/haboateng/C-1-tricubic-treecode
      
      Tricubic_C0.cpp   : Main program for the global-C0 tricubic treecode
                          This version uses analytical derivatives of the kernel.
			
      Tricubic_DC.cpp   : Main program for the discontinuous tricubic treecode. 
                          Tricubic_DC.cpp can use either analytical derivatives of the kernel or 
			  finite difference depending on the option specified in the input file.
			  Use option 0 for analytical derivatives and option 1 for finite differences
			  
			  
                       The main programs direct_sum.cpp, Tricubic_C1.cpp, Tricubic_C0.cpp and
		       Tricubic_DC.cpp depend on the following helper files 
		       (utilities.h, utilities.cpp, kernel_utils.h,
                       kernel_utils.cpp, tree_utils.h, tree_utils.cpp, tricubic_utils.h,
                       tricubic_utils.cpp)
      
      makefile       : A makefile for compiling the direct sum and tricubic treecodes. 
                       It produces the executables direct_sum and Tricubic_C1,
		       Tricubic_C0, Tricubic_DC

      input_params.txt   : Input file for the both direct_sum and tricubic treecodes


Input for direct_sum and tricubics :
-----------------------------------

      input_params.txt specifies the following required options in
      the given order:
      
#// Treecode method to be used: Particle-Cluster

	Particle-Cluster    #// (This option picks particle-cluster)
 
#// Kernel name below: Coulomb, ScreenedCoulomb, RSEwaldSum

	Coulomb // (This option picks the  Coulomb kernel)
 
// number of particles 

	10000   // (If the system has 10000 particles)
 
// N0, leaf size 

	1000     // Pick N0 = 1000
 
// parameter to choose the type of MAC (0 - Regular MAC, 1 - Spherical MAC)

	0   // Use Regular MAC
 
// theta, MAC parameter (Should be less than 1 for Regular MAC, ideally greater than 1 for Spherical MAC)

	0.5  //theta = 0.5
 
// 1 if finite differences should be used, 0 otherwise (This only applies to the discontinuous treecode: Tricubic_DC.cpp)

	0  // Use analytical derivatives
 
// mgrid, any value when finite differences are not used. Do not delete.

	20  # Grid size for 3-point interpolation of the kernel. Can be varied for varying accuracy
 
// hgrid, any value when finite differences are not used. Do not delete.

	0.01 # step-size for finite differences

Output for the executable direct_sum :
-------------------------------------

The output is the file exact_sum_kernelName_Nnumberofparticles. 
Example: The output for the Coulomb sum with 10000 particles is exact_sum_Coulomb_N10000

For a system of size N, the file has N+1 lines. The first N lines correspond to data for
the N particles. Each of the first N lines has 5 entries:

	Particle number, particle potential, x-component of gradient of potential, y-component of gradient of potential, z-component of gradient of potential
   
The N+1 line is the time the computation took in 10^(-2) seconds (i.e. centiseconds)


Output for the executables Tricubic_C1, Tricubic_C0, Tricubic_DC  :
-------------------------------------------------------------------

Running Tricubic_C1 generates two files : output.txt and tricubic_sum_kernalName_C1_Nnumberofparticles
Running Tricubic_C0 generates two files : output.txt and tricubic_sum_kernalName_C0_Nnumberofparticles
Running Tricubic_DC generates two files : output.txt and tricubic_sum_kernalName_DC_Nnumberofparticles

The file output.txt has the following entries:

	Number of particles (N_cube), Maximum number of particles in a leaf (N0), MAC (theta), relative 2-norm error in potential (E), relative 2-norm error in field (FE), relative 1-norm error in potential (eL1), relative 1-norm error in field, time for direct sum in centiseconds, treecode time in centiseconds

For the files tricubic_sum_kernalName_C1_Nnumberofparticles, tricubic_sum_kernalName_C0_Nnumberofparticles,  or 
tricubic_sum_kernalName_DC_Nnumberofparticles:

    The first line has the data:
    cpu time for direct sum (in centiseconds), cpu time for treecode (in centiseconds)
    
    Following the first line are direct sum and the treecode approximation for the potential and fields in the sample format:
    
    particle number,  exact potential, treecode approximation of potential
    x-component of exact gradient of potential, y-component of exact gradient of potential, z-component of exact gradient of potential
    tree approximation of x-component of gradient of potential, treecode approximation of y-component of gradient of potential, treecode approximation of of z-component of gradient of potential



		 
