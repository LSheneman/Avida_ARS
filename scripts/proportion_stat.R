### CSE_845 Average Genome Size Stats ###

# set working directory
setwd("~/R/R_wd/cse_845")


#require - load a package into a current R session
require(ggplot2)
require(GGally)
require(reshape)
require(reshape2)
require(plyr)
require(stringr)
require("car")   

#remove all objects from workspace
rm(list = ls())


##############################################
################ Import Data #################
##############################################

#create lists of the locally saved arvhive files which contain the final dominant's genome
files_geno_sm = list.files("~/R/R_wd/cse_845/sm_run/genome", full.names = TRUE)
files_geno_c = list.files("~/R/R_wd/cse_845/cntrl_run/genome", full.names = TRUE)
files_geno_lrg = list.files("~/R/R_wd/cse_845/lrg_run/genome", full.names = TRUE)
# view list of the small world files
files_gest_sm

#load all files from lists into a single/compiled list object and add a unique identifier variable based on unique file names in list
geno_sm = lapply(1:length(files_geno_sm), function(idx) {
  geno_sm =read.table(files_geno_sm[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  geno_sm$file.idx = idx
  geno_sm
})

geno_c = lapply(1:length(files_geno_c), function(idx) {
  geno_c =read.table(files_geno_c[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  geno_c$file.idx = idx
  geno_c
})

geno_lrg = lapply(1:length(files_geno_lrg), function(idx) {
  geno_lrg =read.table(files_geno_lrg[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  geno_lrg$file.idx = idx
  geno_lrg
})



##############################################
######### Create Data Frames and CSV #########
##############################################

# merge all gestation time files for small, control, and large worlds into separate data frames
geno_sm = do.call(rbind, geno_sm)
geno_c = do.call(rbind, geno_c)
geno_lrg = do.call(rbind, geno_lrg)

# rename variables in each data frame
colnames(geno_sm) = c ("instruction", "trial")
colnames(geno_c) = c ("instruction", "trial")
colnames(geno_lrg) = c ("instruction", "trial")

#view first couple and last couple rows of the small world data frame to ensure no errors
head (geno_sm)
tail (geno_sm)

# count the number of each type of instruction used for all trials and write to a data frame
#whole_count = count (geno_c, "instruction",)
#whole_count

# count the number of each type of instruction used within trials for each different world size and add a frequency variable
geno_sm = count (geno_sm, c("trial", "instruction"))
geno_c = count (geno_c, c("trial", "instruction"))
geno_lrg = count (geno_lrg, c("trial", "instruction"))
head(geno_c)



##############################################
##### Change Variable Class / View Data ######
##############################################

#returns headers and class type of each of the variables (in this case for the control world as an example)
lapply(geno_c, class)


#convert trial variable to a factor in each genome data frame
geno_sm$trial = factor (geno_sm$trial)
geno_c$trial = factor (geno_c$trial)
geno_lrg$trial = factor (geno_lrg$trial)


##############################################
############### Summary Stats ################
##############################################

# report summary stats for average genome instructions within each trial for each world size and
# can write summary to csv file if 'write.csv...' is uncommented
geno_sm_sum = ddply(geno_sm, .(trial), summarize,
                    sum = sum(freq),
                    mean = round (mean(freq, na.rm=T), 2),
                    sd = round (sd(freq, na.rm=T), 2),
                    quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                    med = round (quantile(freq, c(.5), na.rm=T),2),
                    quart75 = round (quantile(freq, c(.75), na.rm=T),2))

#index the instructions "sum" and "trial" variables and write to stand alone data frame
sm_sum = data.frame (geno_sm_sum [ , 1:2])
# do an inner join by trial to combine the sum varaible with the individual instruction counts
geno_sm <- merge(sm_sum,geno_sm,by="trial")
#add a proportion variable each instruction count divided by the total instruction count
geno_sm$prop = (geno_sm$freq/geno_sm$sum)

#write.csv(geno_sm, file = "~/R/R_wd/cse_845/sum_stat/geno_sm.csv")


geno_c_sum = ddply(geno_c, .(trial), summarize,
                    sum = sum(freq),
                    mean = round (mean(freq, na.rm=T), 2),
                    sd = round (sd(freq, na.rm=T), 2),
                    quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                    med = round (quantile(freq, c(.5), na.rm=T),2),
                    quart75 = round (quantile(freq, c(.75), na.rm=T),2))

#index the instructions "sum" and "trial" variables and write to stand alone data frame
c_sum = data.frame (geno_c_sum [ , 1:2])
# do an inner join by trial to combine the sum varaible with the individual instruction counts
geno_c <- merge(c_sum,geno_c,by="trial")
#add a proportion variable each instruction count divided by the total instruction count
geno_c$prop = (geno_c$freq/geno_c$sum)

#write.csv(geno_c_sum, file = "~/R/R_wd/cse_845/sum_stat/geno_c_sum.csv")


geno_lrg_sum = ddply(geno_lrg, .(trial), summarize,
                    sum = sum(freq),
                    mean = round (mean(freq, na.rm=T), 2),
                    sd = round (sd(freq, na.rm=T), 2),
                    quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                    med = round (quantile(freq, c(.5), na.rm=T),2),
                    quart75 = round (quantile(freq, c(.75), na.rm=T),2))

#index the instructions "sum" and "trial" variables and write to stand alone data frame
lrg_sum = data.frame (geno_lrg_sum [ , 1:2])
# do an inner join by trial to combine the sum varaible with the individual instruction counts
geno_lrg <- merge(lrg_sum,geno_lrg,by="trial")
#add a proportion variable each instruction count divided by the total instruction count
geno_lrg$prop = (geno_lrg$freq/geno_lrg$sum)

#write.csv(geno_lrg_sum, file = "~/R/R_wd/cse_845/sum_stat/geno_lrg_sum.csv")


# add factor variables to distinguish different world sizes
geno_sm$world = as.factor = 1
geno_c$world = as.factor = 2
geno_lrg$world = as.factor = 3
geno_sm$world_sz = c("Small")
geno_c$world_sz = c("Control")
geno_lrg$world_sz = c("Large")

# merge gestation summary data frames into single data frame to use in one way factorial anlaysis comparing means of 
# gestation time
sum_list = list(geno_sm, geno_c, geno_lrg)
master_geno = do.call(rbind, sum_list)

#change "world" from integer variable to factor 
master_geno <- within(master_geno, {
  world <- factor(world)
})

#write out compiled data into a master data file.
#write.csv(master_geno, file = "~/R/R_wd/cse_845/master_data_files/master_geno.csv")



# report summary stats for average genome instructions length within each world size 
geno_sm_instruct_sum = ddply(geno_sm, .(instruction), summarize,
                    sum = sum(freq),
                    mean = round (mean(freq, na.rm=T), 2),
                    sd = round (sd(freq, na.rm=T), 2),
                    quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                    med = round (quantile(freq, c(.5), na.rm=T),2),
                    quart75 = round (quantile(freq, c(.75), na.rm=T),2))

geno_c_instruct_sum = ddply(geno_c, .(instruction), summarize,
                             sum = sum(freq),
                             mean = round (mean(freq, na.rm=T), 2),
                             sd = round (sd(freq, na.rm=T), 2),
                             quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                             med = round (quantile(freq, c(.5), na.rm=T),2),
                             quart75 = round (quantile(freq, c(.75), na.rm=T),2))

geno_lrg_instruct_sum = ddply(geno_lrg, .(instruction), summarize,
                             sum = sum(freq),
                             mean = round (mean(freq, na.rm=T), 2),
                             sd = round (sd(freq, na.rm=T), 2),
                             quart25 = round (quantile(freq, c(.25), na.rm=T),2),
                             med = round (quantile(freq, c(.5), na.rm=T),2),
                             quart75 = round (quantile(freq, c(.75), na.rm=T),2))

# add a factor variables to distinguish different world sizes
geno_sm_instruct_sum$world = as.factor = 1
geno_c_instruct_sum$world = as.factor = 2
geno_lrg_instruct_sum$world = as.factor = 3
geno_sm_instruct_sum$world_sz = c("Small")
geno_c_instruct_sum$world_sz = c("Control")
geno_lrg_instruct_sum$world_sz = c("Large")




# merge genome instruction count data frames into single master data frame for use in analysis
sum_list = list(geno_sm_instruct_sum, geno_c_instruct_sum, geno_lrg_instruct_sum)
master_geno_instruct_sum = do.call(rbind, sum_list)

#change "world" from integer variable to factor 
master_geno_instruct_sum <- within(master_geno_instruct_sum, {
  world <- factor(world)
})


# create a dummy variable for movement instructions where 0 = other and 1 = movements
master_geno_instruct_sum$move = recode(master_geno_instruct_sum$instruction, "c('move','rotate-l', 'rotate-r', 'tumble', 'explore', 'exploit')='1'; else='0'")

# create a dummy variable for directional movement instructions where 0 = other and 1 = directional movements
master_geno_instruct_sum$dir_move = recode(master_geno_instruct_sum$instruction, "c('rotate-l', 'rotate-r', 'exploit')='1'; else='0'")

# create a dummy variable for wandering movement instructions where 0 = other and 1 = wandering movements
master_geno_instruct_sum$wan_move = recode(master_geno_instruct_sum$instruction, "c('move', 'tumble', 'explore')='1'; else='0'")



# do summary stats of average genome instruction counts across all trial within worlds and separated by movement vs non-move instructions
master_geno_sum = ddply(master_geno_instruct_sum, .(move, world), summarize,
                     sum = sum(mean),
                     mean = round (mean(mean, na.rm=T), 2),
                     sd = round (sd(mean, na.rm=T), 2),
                     quart25 = round (quantile(mean, c(.25), na.rm=T),2),
                     med = round (quantile(mean, c(.5), na.rm=T),2),
                     quart75 = round (quantile(mean, c(.75), na.rm=T),2))


#add naming variables to master genome summary file
master_geno_sum$instruction = factor(master_geno_sum$move,
                                     levels = c(0,1),
                                     labels = c("non-move", "move"))

master_geno_sum$world_sz = factor(master_geno_sum$world,
                    levels = c(1,2,3),
                    labels = c("small", "control", "large"))

# create bar plot to compare the average total movements to average total other instructions
move_graph = ggplot(master_geno_sum, aes(x =instruction, y = sum, fill = as.factor(instruction))) +
  geom_bar(stat = "identity", width = 1) +
  facet_wrap(~world_sz)
move_graph

#do proportion tests on move vs non-move instruction counts in different worlds to test if proportion of movements are 
# dependent on world size
# 3-Way Frequency Table
mytable <- xtabs(sum~move+world, data=master_geno_sum)
ftable(mytable) # print table 
summary(mytable) # chi-square test of indepedence



##############################################
######### Save Script and Workspace ##########
##############################################

save.image("~/R/R_wd/cse_845/scripts/genome.RData")



#write out instruction count by tiral data into a master data file.
write.csv(geno_sum, file = "~/R/R_wd/cse_845/evo_250/geno_sum.csv")

