library(readxl)
library(tidyverse)
library(ggplot2)
library(ggrepel)
amo <- read_excel("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/SS3 q devs and ecovs.xlsx", sheet= "AMO")
run9 <- read_excel("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/SS3 q devs and ecovs.xlsx", sheet= "Run9",skip=2)
orig <- read_excel("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/SS3 q devs and ecovs.xlsx", sheet= "Orig",skip=2)
run8 <- read_excel("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/SS3 q devs and ecovs.xlsx", sheet= "Run8",skip=1)
run100 <- read_excel("C:/Users/cole.carrano/Documents/BFT postdoc/WBFT/Statistics/SS3 q devs and ecovs.xlsx", sheet= "Run100",skip=1)


################################
# Run 9 no env correlation plots
################################
combined_data <- left_join(run9, amo, by = "Yr")
combined_data <- combined_data %>% 
  filter(Fleet==28| Fleet<=33 & Fleet >=31)

# --- NEW: Calculate the regression equations for each Fleet_name ---
# This part calculates the linear model coefficients and formats the equation string.
equations_df <- combined_data %>%
  # IMPORTANT: Filter out rows with NA in 'value' or 'Dev' for accurate model fitting
  drop_na(value, Dev) %>%
  group_by(Fleet_name) %>%
  summarise(
    # Fit the linear model for the current group
    model = list(lm(Dev ~ value, data = cur_data())),
    # Extract coefficients
    intercept = coef(model[[1]])[1],
    slope = coef(model[[1]])[2],
    r_squared = summary(model[[1]])$r.squared,
    p_value = summary(model[[1]])$coefficients[2, 4],
    # Format the equation string
    equation = sprintf("y = %.2fx %s %.2f", slope, ifelse(intercept >= 0, "+", "-"), abs(intercept)),
    x_pos = min(value, na.rm = TRUE) + (max(value, na.rm = TRUE) - min(value, na.rm = TRUE)) * 0.05, # ~5% from left
    y_pos = max(Dev, na.rm = TRUE) - (max(Dev, na.rm = TRUE) - min(Dev, na.rm = TRUE)) * 0.05    # ~5% from top
  ) %>%
  ungroup()

patty_plot <- ggplot(combined_data, aes(x = value, y = Dev)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  # geom_text(data = equations_df,
  #           aes(x = x_pos, y = y_pos, label = equation),
  #           inherit.aes = FALSE, # This is crucial: prevents geom_text from inheriting global aesthetics
  #           hjust = 0, vjust = 1, # Aligns text to top-left of its 'x_pos', 'y_pos'
  #           size = 3.5,          # Adjust font size as needed
  #           color = "red", # Choose a color for the equation text
  #           fontface = "bold") + # Make it bold for emphasis
  
  facet_wrap(~ Fleet_name, scales = "free_y",labeller=labeller(Fleet_name=
                                                                  c("IDX11_US_RR_GT177"= "US >177cm",
                                                                    "IDX14_CAN_SWNS"= "CAN SW Nova Scotia",
                                                                    "IDX15_CAN_GSL"= "CAN Gulf St. Lawrence",
                                                                    "IDX16_CAN_ACOUSTIC"= "CAN Acoustic"))) +
  labs(
    title = "'No Env.' AMO anomaly vs Index residuals",
    x = "AMO Anomaly",
    y = "Index Residual"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5), # Center titles
        strip.text.x = element_text(size = 12)) 

print(patty_plot)
ggsave("Run9 no env amo vs residual.jpg", width = 7, height = 4)


# Calculate RMSE for each ind
rmse_by_fleet <- combined_data %>%
  drop_na(Dev) %>% # Removes rows where Dev is NA before calculation
  group_by(Fleet_name) %>%
  summarise(
    MSE = mean(Dev^2),
    RMSE = sqrt(MSE)
  ) %>%
  ungroup() # 

# Print the table of RMSE values
print(rmse_by_fleet)
################################
# Orig run with AMO correlation plots
################################
combined_data2 <- left_join(orig, amo, by = "Yr")
combined_data2 <- combined_data2 %>% 
  filter(Fleet>=31 & Fleet<=33 | Fleet==28)
# --- NEW: Calculate the regression equations for each Fleet_name ---
# This part calculates the linear model coefficients and formats the equation string.
equations_df <- combined_data2 %>%
  # IMPORTANT: Filter out rows with NA in 'value' or 'Dev' for accurate model fitting
  drop_na(value, Dev) %>%
  group_by(Fleet_name) %>%
  summarise(
    # Fit the linear model for the current group
    model = list(lm(Dev ~ value, data = cur_data())),
    # Extract coefficients
    intercept = coef(model[[1]])[1],
    slope = coef(model[[1]])[2],
    p_value = summary(model[[1]])$coefficients[2, 4],
    # Format the equation string
    equation = sprintf("y = %.2fx %s %.2f", slope, ifelse(intercept >= 0, "+", "-"), abs(intercept)),
    x_pos = min(value, na.rm = TRUE) + (max(value, na.rm = TRUE) - min(value, na.rm = TRUE)) * 0.05, # ~5% from left
    y_pos = max(Dev, na.rm = TRUE) - (max(Dev, na.rm = TRUE) - min(Dev, na.rm = TRUE)) * 0.05    # ~5% from top
  ) %>%
  ungroup()

petey_plot <- ggplot(combined_data2, aes(x = value, y = Dev)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  
  # --- NEW: Add the equation text to each facet ---
  # geom_text(data = equations_df,
  #           aes(x = x_pos, y = y_pos, label = equation),
  #           inherit.aes = FALSE, # This is crucial: prevents geom_text from inheriting global aesthetics
  #           hjust = 0, vjust = 1, # Aligns text to top-left of its 'x_pos', 'y_pos'
  #           size = 3.5,          # Adjust font size as needed
  #           color = "red", # Choose a color for the equation text
  #           fontface = "bold") + # Make it bold for emphasis
  
  facet_wrap(~ Fleet_name, scales = "free_y",labeller=labeller(Fleet_name=
                                                                 c("IDX11_US_RR_GT177"= "US >177cm",
                                                                   "IDX14_CAN_SWNS"= "CAN SW Nova Scotia",
                                                                   "IDX15_CAN_GSL"= "CAN Gulf St. Lawrence",
                                                                   "IDX16_CAN_ACOUSTIC"= "CAN Acoustic"))) +
  labs(
    title = "'Covariate' run (W/ AMO) AMO Anomaly vs Index Residuals",
    x = "AMO Anomaly",
    y = "Index Residual"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),# Center titles
        strip.text.x = element_text(size = 12)) 

print(petey_plot)
ggsave("covariate amo vs residual.jpg", width = 7, height = 4)


# Calculate RMSE for each ind
rmse_by_fleet2 <- combined_data2 %>%
  drop_na(Dev) %>% # Removes rows where Dev is NA before calculation
  group_by(Fleet_name) %>%
  summarise(
    MSE = mean(Dev^2),
    RMSE = sqrt(MSE)
  ) %>%
  ungroup() # 

# Print the table of RMSE values
print(rmse_by_fleet2)
################################
# Run8 us only VAST correlation plots
################################
combined_data3 <- left_join(run8, amo, by = "Yr")
combined_data3 <- combined_data3 %>% 
  filter(Fleet>=31 & Fleet<=33 | Fleet==37)
# --- NEW: Calculate the regression equations for each Fleet_name ---
# This part calculates the linear model coefficients and formats the equation string.
equations_df <- combined_data3 %>%
  # IMPORTANT: Filter out rows with NA in 'value' or 'Dev' for accurate model fitting
  drop_na(value, Dev) %>%
  group_by(Fleet_name) %>%
  summarise(
    # Fit the linear model for the current group
    model = list(lm(Dev ~ value, data = cur_data())),
    # Extract coefficients
    intercept = coef(model[[1]])[1],
    slope = coef(model[[1]])[2],
    # Format the equation string
    equation = sprintf("y = %.2fx %s %.2f", slope, ifelse(intercept >= 0, "+", "-"), abs(intercept)),
    x_pos = min(value, na.rm = TRUE) + (max(value, na.rm = TRUE) - min(value, na.rm = TRUE)) * 0.05, # ~5% from left
    y_pos = max(Dev, na.rm = TRUE) - (max(Dev, na.rm = TRUE) - min(Dev, na.rm = TRUE)) * 0.05    # ~5% from top
  ) %>%
  ungroup()

parker_plot <- ggplot(combined_data3, aes(x = value, y = Dev)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  
  # --- NEW: Add the equation text to each facet ---
  geom_text(data = equations_df,
            aes(x = x_pos, y = y_pos, label = equation),
            inherit.aes = FALSE, # This is crucial: prevents geom_text from inheriting global aesthetics
            hjust = 0, vjust = 1, # Aligns text to top-left of its 'x_pos', 'y_pos'
            size = 3.5,          # Adjust font size as needed
            color = "red", # Choose a color for the equation text
            fontface = "bold") + # Make it bold for emphasis
  
  facet_wrap(~ Fleet_name, scales = "free_y") +
  labs(
    title = "'US only VAST' AMO Anomaly vs Index Residuals",
    x = "AMO Anomaly",
    y = "Index Residual"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) # Center titles

print(parker_plot)
ggsave("run8 us only vast amo vs residual.jpg", width = 7, height = 4)


# Calculate RMSE for each ind
rmse_by_fleet3 <- combined_data3 %>%
  drop_na(Dev) %>% # Removes rows where Dev is NA before calculation
  group_by(Fleet_name) %>%
  summarise(
    MSE = mean(Dev^2),
    RMSE = sqrt(MSE)
  ) %>%
  ungroup() # 

# Print the table of RMSE values
print(rmse_by_fleet3)
################################
# Run100 joint us/can VAST correlation plots
################################
combined_data4 <- left_join(run100, amo, by = "Yr")
combined_data4 <- combined_data4 %>% 
  filter(Fleet>=32 & Fleet<=33 | Fleet==37)
# --- NEW: Calculate the regression equations for each Fleet_name ---
# This part calculates the linear model coefficients and formats the equation string.
equations_df <- combined_data4 %>%
  # IMPORTANT: Filter out rows with NA in 'value' or 'Dev' for accurate model fitting
  drop_na(value, Dev) %>%
  group_by(Fleet_name) %>%
  summarise(
    # Fit the linear model for the current group
    model = list(lm(Dev ~ value, data = cur_data())),
    # Extract coefficients
    intercept = coef(model[[1]])[1],
    slope = coef(model[[1]])[2],
    # Format the equation string
    equation = sprintf("y = %.2fx %s %.2f", slope, ifelse(intercept >= 0, "+", "-"), abs(intercept)),
    x_pos = min(value, na.rm = TRUE) + (max(value, na.rm = TRUE) - min(value, na.rm = TRUE)) * 0.05, # ~5% from left
    y_pos = max(Dev, na.rm = TRUE) - (max(Dev, na.rm = TRUE) - min(Dev, na.rm = TRUE)) * 0.05    # ~5% from top
  ) %>%
  ungroup()

pauly_plot <- ggplot(combined_data4, aes(x = value, y = Dev)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  
  # --- NEW: Add the equation text to each facet ---
  geom_text(data = equations_df,
            aes(x = x_pos, y = y_pos, label = equation),
            inherit.aes = FALSE, # This is crucial: prevents geom_text from inheriting global aesthetics
            hjust = 0, vjust = 1, # Aligns text to top-left of its 'x_pos', 'y_pos'
            size = 3.5,          # Adjust font size as needed
            color = "red", # Choose a color for the equation text
            fontface = "bold") + # Make it bold for emphasis
  
  facet_wrap(~ Fleet_name, scales = "free_y") +
  labs(
    title = "'VAST Joint' AMO Anomaly vs Index Residuals",
    x = "AMO Anomaly",
    y = "Index Residual"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) # Center titles

print(pauly_plot)
ggsave("run100 joint vast amo vs residual.jpg", width = 7, height = 4)

# Calculate RMSE for each ind
rmse_by_fleet4 <- combined_data4 %>%
  drop_na(Dev) %>% # Removes rows where Dev is NA before calculation
  group_by(Fleet_name) %>%
  summarise(
    MSE = mean(Dev^2),
    RMSE = sqrt(MSE)
  ) %>%
  ungroup() # 

# Print the table of RMSE values
print(rmse_by_fleet4)


################################################################################
# Plot my fav indices
replist<-SS_output("~/BFT postdoc/WBFT/Statistics/WBFT_SS3_AltRuns/MASE_test/bft_test/Run100")
indices <- replist$cpue[,c(2,4,10,11)]
fav_ind <- indices %>% 
  filter(Fleet_name="")
