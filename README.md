Data replication:

Set up Avida:

Download the source code by executing the following for commands:
	
	$ git clone https://github.com/LSheneman/avida.git
	$ cd avida
	$ git submodule init
	$ git submodule update

Next you will need to compile the code, see the documentation on Compiling at https://github.com/devosoft/avida/wiki/Development-%7C-Getting-Started.

To obtain the exact results from "See No Evil, Smell No Evil, Feel No Evil" (Sheneman, et al.), first clone the tutorial:
	
	$ git clone https://github.com/LSheneman/Avida_ARS
	
Next, you will need to change into the Avida_ARS folder:
	
	$ cd Avida_ARS

You now have two options. The first is to replicate the three treatments with one command (please note this will take several days to complete):
	
	$ make

Or you can choose to replicate a specific treatment (i.e. control_world, small_world, large_world). For example you want to get the data for the control world, you can use the following command:

	$ make control_world

Please note that the "control world" is the medium sized world.

Data Preparation for Analyses with R Scripts:

This script compiles data from the Avida output files. From each evolutionary trial the associated deme_average.dat file per run, needs to be saved to a local directory and saved as a text file that can be named "gest_1, gest_2...gest_30". This is the data used for all analyses pertaining to gestation time. 

Also for each evolutionary trial, all the data files named ‘xxxx.org’ need to manually saved as text files from each run’s archive into a separate local directory. These text files can be named “geno_1", "geno_2.txt"…"geno_30.txt"). This is the data used for all analyses pertaining to genome length. Each experimental world size should have its own parent directory containing the gestation and genome sub-directores of raw Avida data saved as text files. 

Optimal Search Statistics 

Once the local directory of raw Avida data is stored as text files this R script can be run to reshape data and organize for analyses. 
All a statistical procedures, outputs and graphical results pertaining to figures 1 ("Average Final Gestation Time by World Size"), 2 ("Average Genome Length by World Size"), and 4 ("Average Gestion Time by Genome Length") are generated from this R script.

In the context of this tutorial, the "geno_XX.txt" files can be found in the docs/data directory. To run the scripts from the command line we must first place them in the same folder as the data.
	
	$ cd docs/data
	$ cp ../../scripts/* .

You can run the script to obtain optimal search statistics:
	$ Rscript search_stats.R

Instruction Propertions Stats 

This script re-compiles data from the Avida output files and the using the genome text files already saved in local directories (see above). This R script can be run to reshape data and organize for analyses. All a statistical procedures, outputs and graphical results pertaining to figure 3 ("Propertions of Non-Movement Instructions") is generated from this R script.

To run it, ensure that you are in the docs/data folder.
	$ pwd 

will output your current directory. Make sure this path ends with "/docs/data".

Now you can produce a visual of the instruction propertion stats by typing:
	$ Rscript proportion_stat.R

Note: Run these two scripts separately as they both utilize and reshape the data unique to the analysis.
