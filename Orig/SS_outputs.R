setwd("~/BFT postdoc/WBFT/Statistics/WBFT_SS3")
library(r4ss)
mydir <- getwd()
SS_wbft <- SS_output(dir=mydir)

SSplotCatch(SS_wbft)
SSplotAgeMatrix(SS_wbft,option = 1)
SS_wbft[["ALK"]]
View(SS_wbft[["ALK"]])
SSplotNumbers(SS_wbft, )
SSplotComps(SS_wbft )


SS_plots(SS_wbft, plot=c(12:17))
comps_code <- getAnywhere(SSplotComps)
SS_plots(SS_wbft, plot=18)

SSplotComps(SS_wbft, subplot=22, verbose = TRUE)

SS_wbft[["agedbase"]]
agedbase <- SS_wbft[["agedbase"]]
SS_wbft[["condbase"]]
condbase <- SS_wbft[["condbase"]]
SS_wbft[["ghostagedbase"]]

alk <- condbase %>% 
  select(Yr,Fleet,Lbin_lo, Lbin_hi, Bin, Obs, Pearson)

alk2 <- alk[alk$Fleet==2,]
alk3 <- alk[alk$Fleet==3,]
alk6 <- alk[alk$Fleet==6,]

library(ggplot2)


#### plotting pearson aal residuals
########################################
# Function to create a plot for a specific year
plot_year <- function(year) {
  year_data <- alk2[alk2$Yr == year,]
  
  ggplot(year_data, aes(x = Bin, y = Lbin_lo, size = abs(Pearson))) +
    geom_point(aes(shape = Pearson > 0), color = "black") +
    scale_shape_manual(values = c(16, 21)) +
    labs(title = paste("Year", year),
         x = "Age",
         y = "Length")
}

# Create a list of plots for each unique year
plot_list <- lapply(unique(alk2$Yr), plot_year)

# Display the plots
do.call(gridExtra::grid.arrange, plot_list)

plot_list[17]

#####    plotting obs aal heatmap
alk6 <- alk6 %>%
  mutate(std_Obs = scale(Obs))

# Create the heatmap
ggplot(alk6, aes(x = Bin, y = Yr, fill = std_Obs)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "darkred") +
  labs(x = "Age", y = "Year", fill = "Standardized Obs")


obs_caa <- condbase[, c(1, 6, 10, 14:18)]
write.csv(obs_caa, file="observed_caa_SS.csv")
