library(r4ss)
orig_rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_Orig")
vast1_rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run1")
SS_plots(vast1_rep)
compare <- SSsummarize(list(orig_rep,vast1_rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run1")
SSexecutivesummary(orig_rep)


###################################################################
# likelihood profile # DOESN'T WORK CUZ I DON'T KNOW WHAT I'M DOING
SS_profile(dir="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/orig_duplicate",
           masterctlfile = "control.ss_new", #default
           newctlfile = "control_modified.ss",  #idk what this means
           # linenum = 35, #line number for R0 (i think) in par file? no idea if this is right, this didn't work, something different happened when using string so maybe that worked?
           string = "R0", #alternate to linenum to try to get R0?
           profilevec = seq(5,10,.25) #r0 has bounds in original file
           )
replist <- SSgetoutput(dirvec = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/orig_duplicate",
                       keyvec = seq(1,21,1))
profile_res <- SSsummarize(replist)
SSplotProfile(profile_res)
#####################################################################



retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_Orig",
      years = 0:-5,
      verbose = T,
      exe = "ss")

setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_Orig")
retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T
)

orig_mohns <- SSmohnsrho(retroSummary,
                         endyrvec = endyrvec)
rho_comp <- rbind(vast1_mohns,orig_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(2, 1)]

vast2rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run2")
SS_plots(vast2rep)
View(vast2rep$index_variance_tuning_check)

vast3rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run3")
SS_plots(vast3rep)
View(vast3rep$index_variance_tuning_check)
################################################################################
vast4rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run4")
SS_plots(vast4rep)
View(vast4rep$index_variance_tuning_check)
# retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run4", exe = "ss")
# setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run4")
# retroModels <- SSgetoutput(
#   dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
# )
# retroSummary <- SSsummarize(retroModels)
# endyrvec <- retroSummary[["endyrs"]] + 0:-5
# SSplotComparisons(retroSummary,
#                   plotdir = file.path(getwd(),"retrospectives"),
#                   endyrvec = endyrvec,
#                   legendlabels = paste("Data", 0:-5, "years"),
#                   pdf = T)

################################################################################
vast5rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run5")
SS_plots(vast5rep)
View(vast5rep$index_variance_tuning_check)

compare <- SSsummarize(list(vast1_rep,vast5rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run5")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run5", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run5")

SSexecutivesummary(vast5rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast5_mohns <- SSmohnsrho(retroSummary)
vast5_mohns
rho_comp <- rbind(vast5_mohns, vast1_mohns,orig_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(3, 2, 1)]

################################################################################
vast6rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run6")
SS_plots(vast6rep)


compare <- SSsummarize(list(orig_rep,vast5rep,vast6rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run6")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run6", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run6")

SSexecutivesummary(vast6rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast6_mohns <- SSmohnsrho(retroSummary)
vast6_mohns
rho_comp <- rbind(vast5_mohns, vast6_mohns,orig_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(3, 1, 2)]
################################################################################
vast7rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run7")
SS_plots(vast7rep)


compare <- SSsummarize(list(orig_rep,vast5rep,vast7rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run7")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run7", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run7")

SSexecutivesummary(vast7rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast7_mohns <- SSmohnsrho(retroSummary)
vast7_mohns
rho_comp <- rbind(vast5_mohns, vast7_mohns,orig_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(3, 1, 2)]
################################################################################
vast8rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run8")
SS_plots(vast8rep)


compare <- SSsummarize(list(orig_rep,vast5rep,vast8rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run8")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run8", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run8")

SSexecutivesummary(vast8rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast8_mohns <- SSmohnsrho(retroSummary)
vast8_mohns
rho_comp <- rbind(vast5_mohns, vast8_mohns,orig_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(3, 1, 2)]
################################################################################
vast9rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run9")
SS_plots(vast9rep)


compare <- SSsummarize(list(orig_rep,vast9rep, vast8rep, vast100rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  legendlabels = c("covariate","No env.", "VAST US only", "VAST Joint"),
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run9")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run9", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run9")

SSexecutivesummary(vast9rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast9_mohns <- SSmohnsrho(retroSummary)
vast9_mohns
rho_comp <- rbind(orig_mohns,vast9_mohns, vast8_mohns,vast100_mohns)
rho_comp <- t(rho_comp)
rho_comp <- rho_comp[, c(3, 1, 2)]
################################################################################
vast100rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run100")
SS_plots(vast100rep)


compare <- SSsummarize(list(orig_rep,vast8rep,vast100rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  legendlabels = c("original", "VAST US only", "VAST Joint"),
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run100")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run100", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run100")

SSexecutivesummary(vast100rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast100_mohns <- SSmohnsrho(retroSummary)
vast100_mohns
rho_comp <- rbind(orig_mohns,vast5_mohns,vast8_mohns, vast100_mohns)
rho_comp <- t(rho_comp)
#################################################################################

vast101rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run101")
SS_plots(vast101rep)


compare <- SSsummarize(list(vast100rep,vast101rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  legendlabels = c("VAST joint (SWNS sel)", "VAST joint (PSFB sel)"),
                  indexfleets = c(37),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run101")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run101", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run101")

SSexecutivesummary(vast101rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast101_mohns <- SSmohnsrho(retroSummary)
vast101_mohns
rho_comp <- rbind(orig_mohns,vast8_mohns,vast100_mohns,vast101_mohns)
rho_comp <- t(rho_comp)
#################################################################################

vast200rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run200")
SS_plots(vast200rep)


compare <- SSsummarize(list(orig_rep,vast8rep,vast100rep,vast200rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  # indexfleets = list(c(18,19,22,23,26,27,28,29,31,32,33,34,35,36),c(18,19,22,23,26,27,28,29,31,32,33,34,35,36)),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run200")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run200", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run200")

SSexecutivesummary(vast200rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast200_mohns <- SSmohnsrho(retroSummary)
vast200_mohns
rho_comp <- rbind(orig_mohns,vast5_mohns,vast8_mohns,vast100_mohns,vast200_mohns)
rho_comp <- t(rho_comp)
#################################################################################

vast301rep <- SS_output("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run301")
SS_plots(vast301rep)


compare <- SSsummarize(list(orig_rep,vast8rep,vast100rep,vast301rep))
SSplotComparisons(compare,
                  pdf = TRUE,
                  legendlabels = c("orig","US only VAST", "Joint VAST (SWNS sel)","GoMex SST"),
                  plotdir ="C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run301")

retro(dir = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run301", exe = "ss")
setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run301")

SSexecutivesummary(vast301rep)


retroModels <- SSgetoutput(
  dirvec = file.path(getwd(), "retrospectives", paste("retro", 0:-5, sep = ""))
)
retroSummary <- SSsummarize(retroModels)
endyrvec <- retroSummary[["endyrs"]] + 0:-5
SSplotComparisons(retroSummary,
                  plotdir = file.path(getwd(),"retrospectives"),
                  endyrvec = endyrvec,
                  legendlabels = paste("Data", 0:-5, "years"),
                  pdf = T)
vast301_mohns <- SSmohnsrho(retroSummary)
vast301_mohns
rho_comp <- rbind(orig_mohns,vast5_mohns,vast8_mohns,vast100_mohns,vast301_mohns)
rho_comp <- t(rho_comp)











################################################################################
#     Comparing index fits                                                    #
################################################################################
ind_orig <- orig_rep[["cpue"]]
ind_vast1 <- vast1_rep[["cpue"]]
ind_vast5 <- vast5rep[["cpue"]]

ind_orig <- ind_orig[,c(1,2,4,10,11,14)]
ind_vast1 <- ind_vast1[,c(1,2,4,10,11,14)]
ind_vast5 <- ind_vast5[,c(1,2,4,10,11,14)]

library(ggplot2)
library(dplyr)

prepare_data <- function(df1, df2, model_name1 = "Model 1", model_name2 = "Model 2") {
  common_fleets <- intersect(df1$Fleet, df2$Fleet)
  
  df1_common <- df1 %>%
    filter(Fleet %in% common_fleets) %>%
    mutate(Model = model_name1) %>%
    rename(Exp_1 = Exp) # Rename Exp to Exp_1 in df1_common *before* the join
  
  df2_common <- df2 %>%
    filter(Fleet %in% common_fleets) %>%
    mutate(Model = model_name2)
  
  combined_df <- left_join(df1_common %>% select(Fleet, Fleet_name, Yr, Obs, SE, Exp_1), # Include Exp_1 in select
                           df2_common %>% select(Fleet, Fleet_name, Yr, Exp),       
                           by = c("Fleet", "Fleet_name", "Yr"), suffix = c("_1", "_2")) %>%
    rename(Exp_2 = Exp)  # Rename Exp from df2 to Exp_2 AFTER the join (no suffix needed now)
  
  return(combined_df)
}


plot_data <- prepare_data(ind_vast1, ind_vast5, model_name1 = "ind_vast1", model_name2 = "ind_vast5")

p <- ggplot(plot_data, aes(x = Yr)) +
  geom_point(aes(y = Obs, color = "Observed"), size = 1) +
  geom_errorbar(aes(ymin = Obs - SE, ymax = Obs + SE, color = "Observed"), width = 0.2) + # Correct SE usage
  geom_line(aes(y = Exp_1, color = "ind_vast1")) +
  geom_line(aes(y = Exp_2, color = "ind_vast5")) +
  facet_wrap(~Fleet_name, scales = "free_y") +
  scale_color_manual(values = c("Observed" = "black", "ind_vast1" = "blue", "ind_vast5" = "red")) +
  labs(title = "Index Comparison", x = "Year", y = "Index Value", color = "Legend") +
  theme_bw() +
  theme(legend.position = "bottom")

print(p)

#unmatched indices
unmatched_vast1 <- ind_vast1 %>% filter(!Fleet %in% intersect(ind_vast1$Fleet, ind_vast5$Fleet))
unmatched_vast1 <- unmatched_vast1 %>% 
  mutate(Std_Obs = (Obs - mean(Obs))/sd(Obs), Std_Exp = (Exp - mean(Exp))/sd(Exp))

unmatched_vast5 <- ind_vast5 %>% filter(!Fleet %in% intersect(ind_vast1$Fleet, ind_vast5$Fleet))
unmatched_vast5 <- unmatched_vast5%>% 
  mutate(Std_Obs = (Obs - mean(Obs))/sd(Obs), Std_Exp = (Exp - mean(Exp))/sd(Exp))


if(nrow(unmatched_vast1) > 0) {
  p_unmatched_vast1 <- ggplot(unmatched_vast1, aes(x = Yr)) +
    geom_point(aes(y = Obs), color = "black", size = 3) +
    geom_line(aes(y = Exp), color = "blue", linetype = "dashed", size = 1) +
    facet_wrap(~Fleet_name, scales = "free_y") +
    labs(title = "Unmatched Fleets - ind_vast1", x = "Year", y = "Index Value") +
    theme_bw()
  print(p_unmatched_vast1)
}


if(nrow(unmatched_vast5) > 0) {
  p_unmatched_vast5 <- ggplot(unmatched_vast5, aes(x = Yr)) +
    geom_point(aes(y = Obs), color = "black", size = 3) +
    geom_line(aes(y = Exp), color = "red", linetype = "dashed", size = 1) +
    facet_wrap(~Fleet_name, scales = "free_y") +
    labs(title = "Unmatched Fleets - ind_vast5", x = "Year", y = "Index Value") +
    theme_bw()
  print(p_unmatched_vast5)
}
library(patchwork)
unmatched_plots <- p_unmatched_vast5 / p_unmatched_vast1

ggsave(plot=unmatched_plots, filename = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run1/unmatched indices.png")
ggsave(plot=p, filename = "C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/Run5/index fit comparison.png")
