### CSE_845 ARS Average Gestation Time Stats ###

# set working directory
setwd("~/R/R_wd/cse_845")


#require - load a package into a current R session
require(ggplot2)
require(GGally)
require(reshape)
require(reshape2)
require(plyr)
require(stringr)
require(lsmeans)
require("car")  
require(pgirmess)


#remove all objects from workspace
rm(list = ls())


##############################################
####### Import Data Gestation Data ###########
##############################################

#create lists of the locally saved deme_average.dat files which contain avg gestation time
files_gest_sm <- list.files("~/R/R_wd/cse_845/sm_run/gesttime", full.names = TRUE)
files_gest_c <- list.files("~/R/R_wd/cse_845/cntrl_run/gesttime", full.names = TRUE)
files_gest_lrg <- list.files("~/R/R_wd/cse_845/lrg_run/gesttime", full.names = TRUE)
# view list the small files
files_gest_sm

#load all files from lists into a single/compiled list object and add a unique identifier variable based on file names in list
gesttime_sm <- lapply(1:length(files_gest_sm), function(idx) {
  gest_sm <-read.table(files_gest_sm[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  gest_sm$file.idx <- idx
  gest_sm
})

gesttime_c <- lapply(1:length(files_gest_c), function(idx) {
  gest_c <-read.table(files_gest_c[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  gest_c$file.idx <- idx
  gest_c
})

gesttime_lrg <- lapply(1:length(files_gest_lrg), function(idx) {
  gest_lrg <-read.table(files_gest_lrg[idx], , quote="\"", check.names = FALSE)
  # if you want the file index
  gest_lrg$file.idx <- idx
  gest_lrg
})



##############################################
#### Create Gestation Data Frames and CSV ####
##############################################

# merge all gestation time files for small, medium, and large worlds into separate data frames
gesttime_sm <- do.call(rbind, gesttime_sm)
gesttime_c <- do.call(rbind, gesttime_c)
gesttime_lrg <- do.call(rbind, gesttime_lrg)

#view first couple and last couple rows of the small world data frame to ensure no errors
head (gesttime_sm)
tail (gesttime_sm)

# rename variables in each data frame
colnames(gesttime_sm) = c ("update", "count", "age", "births", "organisms", "generation", "birth_last_rep", "organism_last_rep", "merit", "gestation_time", "time_used", "generations_btwn_founders", "events_kill", "attemp_kill", "trial")
colnames(gesttime_c) = c ("update", "count", "age", "births", "organisms", "generation", "birth_last_rep", "organism_last_rep", "merit", "gestation_time", "time_used", "generations_btwn_founders", "events_kill", "attemp_kill", "trial")
colnames(gesttime_lrg) = c ("update", "count", "age", "births", "organisms", "generation", "birth_last_rep", "organism_last_rep", "merit", "gestation_time", "time_used", "generations_btwn_founders", "events_kill", "attemp_kill", "trial")

#view data frame variable renaming
head (gesttime_sm)

# merge gesttime data frames into single data frame
gest_list = list(gesttime_sm, gesttime_c, gesttime_lrg)
master_gest = do.call(rbind, gest_list)

# uncomment line below to write data frarm out to a .csv file
#write.csv(master_gest, file = "~/R/R_wd/cse_845/master_data_files/master_gest.csv")


##############################################
##### Change Variable Class / View Data ######
##############################################

lapply(gesttime_lrg, class)

#change "trials" from integer variables to factors in each world for purpose of graphing
gesttime_sm <- within(gesttime_sm, {
  evo_trial <- factor(trial)
})
 
gesttime_c <- within(gesttime_c, {
  evo_trial <- factor(trial)
})
 
gesttime_lrg <- within(gesttime_lrg, {
  evo_trial <- factor(trial)
})





##########################################################################
#### AVERAGE CHANGE GESTATION TIME (last/first) UPDATES ACROSS TRIALS ####
############## Modify Data Frames, Figures, and Stats ####################
##########################################################################

# CREATE data frames for just the gestation time change between the last update compared to first update

## Step 1 ##
# create a logical vector where trial update is equal to "1000" and "2500000"

first_sm = gesttime_sm$update == '1000'
last_sm = gesttime_sm$update == '250000'

first_c = gesttime_c$update == '1000'
last_c = gesttime_c$update == '250000'

first_lrg = gesttime_lrg$update == '1000'
last_lrg = gesttime_lrg$update == '250000'

## Step 2 ## # index out a sub data set from each world size including elements from logical vector created above
# from data frame by world size where update = "1000" and "250000"
gesttime_sm_first = gesttime_sm [first_sm, ]
gesttime_sm_last = gesttime_sm [last_sm, ]  

gesttime_c_first = gesttime_c [first_c, ]
gesttime_c_last = gesttime_c [last_c, ] 

gesttime_lrg_first = gesttime_lrg [first_lrg, ]
gesttime_lrg_last = gesttime_lrg [last_lrg, ] 


# add a factor variable to distinguish different world sizes within each data frame  
gesttime_sm_last$world = as.factor = 1
gesttime_c_last$world = as.factor = 2
gesttime_lrg_last$world = as.factor = 3
gesttime_sm_last$world_sz = c("Small")
gesttime_c_last$world_sz = c("Medium")
gesttime_lrg_last$world_sz = c("Large")

# add a varialbe for each world size i.e. GESTTIME_sm/c/lrg_last data frame which is change in gestation time between last and first update
gesttime_sm_last$gest_first_last = (gesttime_sm_last$gestation_time /gesttime_sm_first$gestation_time)
gesttime_c_last$gest_first_last = (gesttime_c_last$gestation_time /gesttime_c_first$gestation_time)
gesttime_lrg_last$gest_first_last = (gesttime_lrg_last$gestation_time /gesttime_lrg_first$gestation_time)

# remove temporary data frames to clean up global environment
#rm(list = (gesttime_sm_first, gesttime_c_first, gesttime_lrg_first))

# summarize the change in average gestation time (Last update/first update) by trial for each world size
gest_sm_last_sum = ddply(gesttime_sm_last, .(trial), summarize, 
                         mean = round (mean(gest_first_last, na.rm=T), 2),
                         sd = round (sd(gest_first_last, na.rm=T), 2),
                         quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                         med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                         quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_sm_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_sm_sum.csv")

gest_c_last_sum = ddply(gesttime_c_last, .(trial), summarize, 
                        mean = round (mean(gest_first_last, na.rm=T), 2),
                        sd = round (sd(gest_first_last, na.rm=T), 2),
                        quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                        med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                        quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_c_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_c_sum.csv")

gest_lrg_last_sum = ddply(gesttime_lrg_last, .(trial), summarize, 
                          mean = round (mean(gest_first_last, na.rm=T), 2),
                          sd = round (sd(gest_first_last, na.rm=T), 2),
                          quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                          med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                          quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_lrg_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_lrg_sum.csv")




#############################################################
######### Set up Data Frame For Fisher's Exact Test #########
############ Measuring Differnece in "Success" ##############
##################### FIG and TABLE 1 #######################
#############################################################


# determine the cut-off for successful and unsuccessful trials (based on gesttime) using (avg across 30 trials) of medium world median values
cut = mean(gest_c_last_sum$med)

# add a binary variable of successful=1 and unsuccessful = 0 trials based on gestime to each world size
gesttime_sm_last$success = factor (with (gesttime_sm_last, ifelse ((gest_first_last <= cut), 1, 0)))
gesttime_c_last$success = factor (with (gesttime_c_last, ifelse ((gest_first_last <= cut), 1, 0)))
gesttime_lrg_last$success = factor (with (gesttime_lrg_last, ifelse ((gest_first_last <= cut), 1, 0)))

# count the number of each type of instruction used within trials for each different world size and add a frequency variable
gest_sm_success = count (gesttime_sm_last, c("success"))
gest_c_success = count (gesttime_c_last, c("success"))
gest_lrg_success = count (gesttime_lrg_last, c("success"))

# add a factor variable to distinguish different world sizes within each summary data frame of successful vs unsuccessful counts
gest_sm_success$world = as.factor = 1
gest_c_success$world = as.factor = 2
gest_lrg_success$world = as.factor = 3
gest_sm_success$world_sz = c("Small")
gest_c_success$world_sz = c("Medium")
gest_lrg_success$world_sz = c("Large")


# merge gestation success count data frames from each world size into single data frame to use in Fisher's Exact test
success_list = list(gest_sm_success,gest_c_success, gest_lrg_success)
master_gest_success = do.call(rbind, success_list)
#change "world" from integer variable to factor 
master_gest_success <- within(master_gest_success, {
  world <- factor(world)
})

# fisher's exact test to compare sucess vs non-success across worlds
gest_success_table = xtabs(freq~success+world, data=master_gest_success)
ftable(gest_success_table) # print table 
fisher.test(gest_success_table)

# merge gestation summary data frames from each world size into single data frame to use in one way factorial anlaysis 
# comparing means of gestation time
last_sum_list = list(gesttime_sm_last,gesttime_c_last, gesttime_lrg_last)
master_gest_last = do.call(rbind, last_sum_list)
#change "world" from integer variable to factor 
master_gest_last <- within(master_gest_last, {
  world <- factor(world)
})


# make Side by side box plots of mean gestation time averaged across all 30 trials for each world size
# to write graph out and save as a pdf, uncomment first and last line of each graph script
#pdf('avg_gest_boxplot.pdf')
boxplot(gest_first_last~world_sz,data=master_gest_last, main = "Avg Final Gestation Time by World Size",
        xlab = "World Size", ylab = "Avg Gestation Time", horizontal=F, 
        col=terrain.colors(3))
#dev.off()


##############################################
########## Import Geno Length Data ###########
############## FIG and TABLE 2 ###############
##############################################

#create lists of the locally saved arvhive files which contain the final dominant's genome
files_geno_sm = list.files("~/R/R_wd/cse_845/sm_run/genome", full.names = TRUE)
files_geno_c = list.files("~/R/R_wd/cse_845/cntrl_run/genome", full.names = TRUE)
files_geno_lrg = list.files("~/R/R_wd/cse_845/lrg_run/genome", full.names = TRUE)
# view list the small files
files_gest_sm

#load all files from lists into a single/compiled list object and add a unique identifier variable based on file names in list
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
### Create Geno Length Data Frames and CSV ###
##############################################

# merge all genome length files for small, Medium, and large worlds into separate data frames
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

# count the number of each type of instruction used within trials for each different world size and add a frequency variable
geno_sm = count (geno_sm, c("trial", "instruction"))
geno_c = count (geno_c, c("trial", "instruction"))
geno_lrg = count (geno_lrg, c("trial", "instruction"))
head(geno_c)

# merge genome instruction count data frames into single master data frame  
geno_list = list(geno_sm, geno_c, geno_lrg)
master_geno = do.call(rbind, geno_list)


##############################################
##### Change Variable Class / View Data ######
##############################################

#returns headers and class type of each of these variables
lapply(geno_c, class)


#convert trial to a factor in each genome data frame
geno_sm$trial = factor (geno_sm$trial)
geno_c$trial = factor (geno_c$trial)
geno_lrg$trial = factor (geno_lrg$trial)


##############################################
######## Geno Lenght Summary Stats ###########
##############################################

# summation of average genome instruction length within each trial for each world size
# can write summary to csv file if 'write.csv...' is uncommented
geno_sm_sum = ddply(geno_sm, .(trial), summarize,
                    mean = (mean(freq)),
                    sum = sum(freq))
#write.csv(geno_sm, file = "~/R/R_wd/cse_845/sum_stat/geno_sm.csv")

geno_c_sum = ddply(geno_c, .(trial), summarize,
                   mean = (mean(freq)),
                   sum = sum(freq))
#write.csv(geno_c_sum, file = "~/R/R_wd/cse_845/sum_stat/geno_c_sum.csv")

geno_lrg_sum = ddply(geno_lrg, .(trial), summarize,
                     mean = (mean(freq)),
                     sum = sum(freq))
#write.csv(geno_lrg_sum, file = "~/R/R_wd/cse_845/sum_stat/geno_lrg_sum.csv")


# add a factor variables to distinguish different world sizes
geno_sm_sum$world = as.factor = 1
geno_c_sum$world = as.factor = 2
geno_lrg_sum$world = as.factor = 3
geno_sm_sum$world_sz = c("Small")
geno_c_sum$world_sz = c("Medium")
geno_lrg_sum$world_sz = c("Large")

# merge genome instruction summary data frames into single data frame to use in 
sum_list = list(geno_sm_sum, geno_c_sum, geno_lrg_sum)
master_geno = do.call(rbind, sum_list)

#change "world" from integer variable to factor class 
master_geno <- within(master_geno, {
  world <- factor(world)
})

#write out compiled data into a master data file.
#write.csv(master_geno, file = "~/R/R_wd/cse_845/master_data_files/master_geno.csv")

# make Side by side box plots of mean gestation time averaged across all 30 trials for each world size
# to write graph out and save as a pdf, uncomment first and last line of each graph script

#pdf('avg_genome_boxplot.pdf')
boxplot(mean~world_sz, data=master_geno, 
        col=terrain.colors(3), main="Average Genome Length by World Size", 
        xlab="World Size", ylab = "Avg Instruction Count")
#dev.off()







############################################################
##### Reshape Data, Check Residuals and Transform Data #####
######## Data Step for Multiple Variable Regression ########
##################### FIG and TABLE 3 ######################
############################################################


#report summary stats for average gestation time at last/first update across trials for each world size and write summary to csv file
# to write tables out and save as a csv, uncomment last line of each summary script
gest_sm_last_sum = ddply(gesttime_sm_last, .(world), summarize, 
                         mean = round (mean(gest_first_last, na.rm=T), 2),
                         sd = round (sd(gest_first_last, na.rm=T), 2),
                         quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                         med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                         quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_sm_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_sm_sum.csv")

gest_c_last_sum = ddply(gesttime_c_last, .(world), summarize, 
                        mean = round (mean(gest_first_last, na.rm=T), 2),
                        sd = round (sd(gest_first_last, na.rm=T), 2),
                        quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                        med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                        quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_c_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_c_sum.csv")

gest_lrg_last_sum = ddply(gesttime_lrg_last, .(world), summarize, 
                          mean = round (mean(gest_first_last, na.rm=T), 2),
                          sd = round (sd(gest_first_last, na.rm=T), 2),
                          quart25 = round (quantile(gest_first_last, c(.25), na.rm=T),2),
                          med = round (quantile(gest_first_last, c(.5), na.rm=T),2),
                          quart75 = round (quantile(gest_first_last, c(.75), na.rm=T),2))
#write.csv(gest_lrg_sum, file = "~/R/R_wd/cse_845/sum_stat/gest_lrg_sum.csv")

# add a factor variable to distinguish different world sizes within each summary data frame
gest_sm_last_sum$world = as.factor = 1
gest_c_last_sum$world = as.factor = 2
gest_lrg_last_sum$world = as.factor = 3
gest_sm_last_sum$world_sz = c("Small")
gest_c_last_sum$world_sz = c("Medium")
gest_lrg_last_sum$world_sz = c("Large")



######## GESTATION ##########


# run ANOVA to for the purpose of looking at residual diagnostics
anova <-aov(gest_first_last~world,data=master_gest_last)
summary(anova)

# plot residuals against predicted values
plot(anova$fitted.values,anova$residuals, xlab= "Predicted values (sample means)", ylab = "Residuals")

# Check heterogeneity of residual variance and normality assumptions
gesttime_lm = lm(gest_first_last~world,data=master_gest_last)
summary (gesttime_lm)
# uncomment plot function to view residual diagnostics and normality plots
#plot(gesttime_lm)

# Natural log transformation on outcome of interested to improve upon unequal vairance and normality violations
master_gest_last$log_gest_first_last = log(master_gest_last$gest_first_last)

# Re-check heterogeneity of residual variance and normality assumptions
gesttime_lm = lm(log_gest_first_last~world,data=master_gest_last)
summary (gesttime_lm)
# uncomment plot function to view residual diagnostics and normality plots
#plot(gesttime_lm)

# One-way ANOVA on Natural Log transformed outcome
anova_log <-aov(log_gest_first_last~world,data=master_gest_last)
summary(anova_log)

#write out ANOVA table to a file
#write.csv(anova_log_sum, file = "~/R/R_wd/cse_845/sum_stat/anova_log_sum.csv")

# Tukey based 95% CI
post_hoc = TukeyHSD(anova_log, "world", ordered = TRUE)
post_hoc

#estimated means on transformed scale
estimates = lm(log_gest_first_last~world-1,data=master_gest_last)
estimates

#back transform means
backtrans <-exp(estimates$coeff)
backtrans



########## GENOME #########

# run ANOVA to for the purpose of looking at residual diagnostics where sum is total average genome length, and wor
anova <-aov(sum~world,data=master_geno)
summary(anova)

# plot residuals agains predicted values
plot(anova$fitted.values,anova$residuals, xlab= "Predicted values (sample means)", ylab = "Residuals")

# Check heterogeneity of residual variance and normality assumptions
gesttime_lm = lm(sum~world,data=master_geno)
summary (gesttime_lm)
# uncomment plot function to view residual diagnostics
#plot(gesttime_lm)

# Natural log transformation on outcome of interested to improve upon unequal vairance and normality violations
master_geno$log_sum = log(master_geno$sum)

# Re-check heterogeneity of residual variance and normality assumptions
gesttime_lm = lm(log_sum~world,data=master_geno)
summary (gesttime_lm)
# uncomment plot function to view residual diagnostics
#plot(gesttime_lm)

#ANOVA on Natural Log transformed outcome
anova_log <-aov(log_sum~world,data=master_geno)
summary(anova_log)

#write out ANOVA table to a file
#write.csv(anova_log_sum, file = "~/R/R_wd/cse_845/sum_stat/anova_log_sum.csv")

# Tukey based 95% CI
post_hoc = TukeyHSD(anova_log, "world", ordered = TRUE)
post_hoc 

plot(TukeyHSD(anova_log))

#estimated means on transformed scale
estimates = lm(log_sum~world-1,data=master_geno)
estimates

#back transform means
backtrans <-exp(estimates$coeff)
backtrans


##################################################################
###### AVERAGE GESTATION TIME AT LAST UPDATE ACROSS TRIALS #######
#### USING MULTIPLE LINEAR REGRESSION (GESTATION AND GENOME) #####
##################################################################

####need to run this only after running geno_stats script
#merge data frames'master_geno' and 'master_gest_sum'

#rename mean in master_geno file to avoid duplicate variable names
master_geno = rename(master_geno, c("mean"="mean_instruct"))

#merge = merge(master_geno, master_gest_sum, by= c("trial","world"))
merge = cbind(master_geno, master_gest_last)


ggplot(merge, aes(x=log_sum, y=log_gest_first_last, color=world_sz)) + geom_point(shape=1) +
  scale_colour_hue(l=50) + # Use a slightly darker palette than normal
  geom_smooth(method=lm) +   # Add linear regression lines
              #se=T)    # add shaded SEM instead of 95% confidence region
  labs(title = "Average Gestation Time by Genome Lenght: 
       Across Different World Sizes") +
  ylab("Log Avg Gestation Time") +
  xlab("Log Dominant Genome Length")


# Multiple Linear Regression  
fit <- lm(log_gest_first_last ~ log_sum + world + log_sum*world, data=merge)
summary(fit) # show results

# Other useful functions 
coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 
influence(fit) # regression diagnostics


#marginal mean comparisons (because interaction was not significant...see 'fit' model)
fit.lm <- lm(log_gest_first_last ~ log_sum + world, data=merge)
ref.grid(fit.lm)
# Covariate-adjusted means and comparisons
lsmeans(fit.lm, pairwise ~ world)






###############################################
###### Other Parametric Stats and Graphs ######
###### Based on Geno by Gest Data (above) #####
###############################################

# This data frame calculates statistics for each treatment with log transformed outcome.
geno_summary <- data.frame(
  treatment=levels(master_geno$world),
  mean=tapply(master_geno$log_sum, master_geno$world, mean),
  n=tapply(master_geno$log_sum, master_geno$world, length),
  sd=tapply(master_geno$log_sum, master_geno$world, sd)
)

# Precalculate standard error of the mean (SEM)
geno_summary$sem <- geno_summary$sd/sqrt(geno_summary$n)

# Precalculate margin of error for confidence interval
geno_summary$me <- qt(1-0.5/2, df=geno_summary$n)*geno_summary$sem

# Use ggplot to draw the bar plot using the precalculated 95% CI.
#png('barplot-ci.png') # Write to PNG
ggplot(geno_summary, aes(x = treatment, y = mean)) +  
  geom_bar(position = position_dodge(), stat="identity", fill="blue") + 
  geom_errorbar(aes(ymin=mean-me, ymax=mean+me)) +
  ggtitle("Bar plot with 95% confidence intervals") + # plot title
  theme_bw() + # remove grey background (because Tufte said so)
  theme(panel.grid.major = element_blank()) # remove x and y major grid lines (because Tufte said so)
#dev.off() # Close PNG

# Bar Plot of Avg Geno Lenght and 95% CI
ggplot(geno_summary, aes(x = treatment, y = mean)) +  
  geom_bar(position = position_dodge(), stat="identity", fill="blue") + 
  geom_errorbar(aes(ymin=mean-me, ymax=mean+me)) +
  ggtitle("Bar plot with 95% confidence intervals") + # plot title
  theme_bw() + # remove grey background (because Tufte said so)
  theme(panel.grid.major = element_blank()) # remove x and y major grid lines 


#simple linear regression comparing gestation time across worlds
fit.gest <- lm(log_gest_first_last ~ world, data=merge)
ref.grid(fit.gest)
summary(fit.gest)
lsmeans(fit.gest, pairwise ~ world)


#simple linear regression comparing genome length across worlds
fit.sum <- lm(sum ~ world, data=merge)
ref.grid(fit.sum)
summary(fit.sum)
lsmeans(fit.sum, pairwise ~ world)

#simple linear regression comparing genome length and gestation time
fit.sum_gest <- lm(gest_first_last ~ sum , data=merge)
ref.grid(fit.sum_gest)
summary(fit.sum_gest)

## Kruskal-Wallis rank sum test ...non-parametric equivalet to ANOVA
kruskal.test(sum ~ world, data=master_geno)

# Post-hoc pairwise comparisons of geno length between world sizes
kruskal_geno = kruskalmc(sum ~ world,master_geno, probs = 0.05) # multiple-comparison test
print(kruskal_geno)

##############################################
########## Gestation Summary Plots ###########
##############################################


# Create faceted graphs of avg gesttime time by updates for each replicate (1-30) in small, medium, and large worlds
# Geoms and stats are automatically split by aesthetics that are factors
# Divide by trial, going horizontally and wrapping with 3 columns
# to write graphs out and save as a pdf, uncomment first and last line of each graph script

#pdf('avg_gest_time_sm.pdf')
c <- ggplot(gesttime_sm, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth() + geom_point() + facet_wrap( ~ trial, ncol=3) +
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Small World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()

#pdf('avg_gest_time_cntrl.pdf')
c <- ggplot(gesttime_c, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth() + geom_point() + facet_wrap( ~ trial, ncol=3) +
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Medium World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()

#pdf('avg_gest_time_lrg.pdf')
c <- ggplot(gesttime_lrg, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth() + geom_point() + facet_wrap( ~ trial, ncol=3) +
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Large World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()


# Create graphs of avg gesttime time by updates for each replicate (1-30) in small, medium, and large worlds
# to write graphs out and save as a pdf, uncomment first and last line of each graph script

#pdf('avg_gest_time_sm.pdf')
c <- ggplot(gesttime_sm, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth() +
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Small World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()

#pdf('avg_gest_time_cntrl.pdf')
c <- ggplot(gesttime_c, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth()+
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Medium World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()

#pdf('avg_gest_time_lrg.pdf')
c <- ggplot(gesttime_lrg, aes(y=gestation_time, x=c(update), colour=factor(trial)))
c + stat_smooth()+
  labs(title = "Average Gestation Time for Evolved Avidians: 
       Large World Independent Trials") +
  ylab("Mean Gestation Time") +
  xlab("Updates (per 1000)")
#dev.off()



##############################################
######### Save Script and Workspace ##########
##############################################

save.image("~/R/R_wd/cse_845/scripts/optimal_search.RData")






