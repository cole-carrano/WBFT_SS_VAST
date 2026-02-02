# ss3 Diagnostics - follows Carvalho et al. 2021
# developed suring cod RT 2023
# Alex Hansell
####################################################

# Load Packages
library(r4ss)
library(devtools)
install_github("jabbamodel/ss3diags")
library(ss3diags)
library(ggplot2)

# set directory
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run100")
mydir <- "~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run100"
plotdir <- "~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run100/plots"

# Step 1: Convergence
# base plots - helps to identify problems and check plausibality 
replist<-SS_output("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run100")
SS_plots(replist)#, pdf = TRUE, png = FALSE)

# calculate AIC 
2*(replist$N_estimated_parameters) - 2*replist$likelihoods_used[1,1]

# run retro and extract model output we want 
# retrospective analysis 

SS_doRetro(
  masterdir = mydir,
  oldsubdir = "",
  newsubdir = "retrospectives",
  years = 0:-7
)

retroModels <- SSgetoutput(
  dirvec = file.path(mydir, "retrospectives", paste("retro", 0:-4, sep = ""))
)

retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-7
save(retroSummary, retroModels, file="retro7.Rdata")

##################################################

#Load retro output for plotting
load("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run8/retro7.Rdata")

# Reference run
ss3rep = retroModels[[1]]
save(ss3rep, file="bftref.Rdata")

# Step 2: Goodness of fit 
# RMSE of < 30% is a reasonably percise fit to the data (Winker et al. 2018)
sspar(mfrow=c(1,2),plot.cex = 0.8)
SSplotJABBAres(ss3rep,subplots="cpue",add=T,indexselect = 12,col=sscol(3)[c(1,3,2)])
SSplotJABBAres(ss3rep,subplots="len",add=T,col=sscol(3)[c(1,3,2)])
SSplotJABBAres(ss3rep,subplots="age",add=T,col=sscol(3)[c(1,3,2)])
dev.print(jpeg,paste0("plotdiags/RMSE.jpg"), width = 8, height = 3.5, res = 300, units = "in")

# Check Runs Test and Joint residuals option for mean composition data
sspar(mfrow=c(2,2),plot.cex = 0.8)
SSplotRunstest(ss3rep,subplots="cpue",add=T,legendcex = 0.6,indexselect = c(7,9,10,11) ,mixing="two.sided")
#SSplotRunstest(ss3rep,subplots="len",add=T,legendcex = 0.6, mixing="two.sided")
SSplotRunstest(ss3rep,subplots="len",add=T,legendcex = 0.6, mixing="less")
dev.print(jpeg,paste0("Plotdiags/RunsTestResiduals.jpg"), width = 8, height = 7, res = 300, units = "in")



# Step 3: Model consistency 
# retrospective analysis 
sspar(mfrow=c(2,2),plot.cex = 0.8)
SSplotRetro(retroSummary,forecastrho = F,add=T,subplots="SSB",endyrvec = 2021:2014,legend = F)
SSplotRetro(retroSummary,forecastrho = F,add=T,legend = T,xmin=2014,endyrvec = 2021:2014,legendcex = 0.8)
SSplotRetro(retroSummary,forecastrho = F, subplots = "F",add=T,legendloc = "left",legend = F)
SSplotRetro(retroSummary,subplots = "F", xmin=2004,forecastrho = F,add=T,legend = T,legendcex = 0.8)
dev.print(jpeg,paste0("Plotdiags/RetroForecast.jpg"), width = 8, height = 9, res = 300, units = "in")


# step 4: prediction skill (MASE)
# Lower MASE is better. Bad > 1

hcc = SSsummarize(retroModels) # summarize index fits
hccomps = ss3diags::SSretroComps(retroModels) # summarize composition fits

sspar(mfrow=c(1,2),plot.cex = 0.7)
SSplotHCxval(hcc,add=T,print = T, png = T,plotdir = plotdir, subplots = "cpue",legendloc="topleft",indexUncertainty = TRUE,legendcex = 0.6)
SSplotHCxval(hccomps,add=T,subplots = "len",legendloc="topleft",legendcex = 0.6, ylim=c(0.5,3.5))
dev.print(jpeg,paste0("Plotdiags/MASE.jpg"), width = 8, height = 6, res = 300, units = "in")


# back to Step 1: Convergence (Jitter analysis)
#SAVE SOMEWHERE ELSE BEFORE RUNNING! 
mydir <- "~/Cod/SS3_revised/jitter/"


numjitter <- 200
jit.likes <- SS_RunJitter(
  mydir = mydir, Njitter = numjitter,
  jitter_fraction = 0.1
)

run<-seq(1:numjitter)

jit.plot<-as.data.frame(cbind(run,jit.likes))

ggplot(jit.plot,aes( x = run,y= jit.likes))+
  geom_point()+ ylab("Total Likelihood")+
  theme_bw()

dev.print(jpeg,paste0("Plotdiags/jitter.jpg"), width = 8, height = 9, res = 300, units = "in")


# Extra plots

# Kobe
# Approximate uncertainty with MVLN (hessian)

# Check starter file
starter = SSsettingsBratioF(ss3rep)
# Get uncertainty from MVLN for F/F_Btrg with Run8inal F setting F_abs

sspar(mfrow=c(1,1),plot.cex = 0.9)
#Fref = c("Ftrg") #to change from FMSY to Ftrg
mvn = SSdeltaMVLN(ss3rep,plot = T, Fref = c("Btgt"))
kbproj = data.frame(mvn$kb)
#labels = mvn$labels
SSplotKobe(kbproj,fill=T,joint=F,posterior="kernel",ylab=expression(F/F[trg]),xlab=expression(SSB/SSB[trg]))

mvn$labels <- expression(SSB/SSB[trg], "F/F"[SB ~ 35], "SSB", 
                         "F", "Recruits", "Catch")
dev.print(jpeg,paste0("Plotdiags/Kobe_",Runs,".jpg"), width = 6.5, height = 6.5, res = 300, units = "in")




