library(readxl)
library(dplyr)
library(ggplot2)
library(sqldf)
library(openxlsx)
library(ggrepel) 
library(pROC)
library(performance)

# Preliminaries
# ------------------------------------------------------------------------------------------------------------
rm( list = ls() )




# ------------------------------------------------------------------------------------------------------------
Prefix_Base <- 'C:/UCLA/418/Final Project'


Prefix_Project <- '/Joined_PremierLeague_Data'
setwd("C:/UCLA/418/Final Project")
Data <-read_excel("PremierLeague_FinancialPerformance_2019_2025.xlsx")





#sql joins
# --------------------------------------------------------------------------------------------------------


options(sqldf.driver = "SQLite")

financial <- as.data.frame(read_excel("PremierLeague_FinancialPerformance_2019_2025.xlsx"))
avg_age <- as.data.frame(read_excel("avg_age.xlsx"))

#LEFT JOIN
joined_data <- sqldf("
  SELECT f.*, a.Average_Age, a.Players_signed
  FROM financial AS f
  LEFT JOIN avg_age AS a
  ON f.Season = a.Season AND f.Team = a.Team
")




write.xlsx(joined_data, "Joined_PremierLeague_Data.xlsx")
EPL_Data <-read_excel("Joined_PremierLeague_Data.xlsx")




##Basic EDA
# --------------------------------------------------------------------------------------------------------

head(EPL_Data)

str(EPL_Data)

summary(EPL_Data)


table(EPL_Data $Season)

table(EPL_Data $Team)

table(EPL_Data$Gross_Spend_mil)

table(EPL_Data$Wins)

colnames(EPL_Data)

plot(EPL_Data$Net_Spend_mil)


check_na <- function(EPL_Data)
  if (any(is.na(EPL_Data))) 


    sum(is.na(EPL_Data))

 na.omit(EPL_Data)
 
 
 
 
 
 
 #Avg Age
 hist(EPL_Data$Average_Age,br=10)
 
 #Players Signed
 
 hist(EPL_Data$Players_signed, br=10)
 
 
 #Net Spend
 hist(EPL_Data$Net_Spend_mil, br=10)
 
 
 #ZZQ Relative spending = Teams net spend/ avg net spend in that season
 #Relative Spend
 hist(EPL_Data$Relative_Spending, br=10)
 
 #Wins
 hist(EPL_Data$Wins, br=10)
 
 # Win Percentage
 hist(EPL_Data$Win_Percentage, br = 10)
 
 #Box Plot net spend by season
 boxplot(Net_Spend_mil ~ Season, data = EPL_Data, col = "lightblue", main = "Net Spend by Season")
 
 ###NET SPEND VS WIN PERCENTAGE BY TEAM
 
 Season <- EPL_Data %>% filter(Season == "2019-20")
 
 

 
##Data Filteration
 # --------------------------------------------------------------------------------------------------------
 
unique(EPL_Data$Season)


season_2019_20 <- EPL_Data %>%
  filter(Season == "2019-20")

  
season_2020_21 <- EPL_Data %>%
  filter(Season == "2020-2021")

season_2021_22 <- EPL_Data %>%
  filter(Season == "2021-2022")

season_2022_23 <- EPL_Data %>%
  filter(Season == "2022-2023")

season_2023_24 <- EPL_Data %>%
  filter(Season == "2023-2024")

season_2024_25 <- EPL_Data %>%
  filter(Season == "2024-2025")






# EDA Plots

# --------------------------------------------------------------------------------------------------------

#For 2019

ggplot(season_2019_20, aes(x = reorder(Team, Transfer_Income_mil), y = Transfer_Income_mil)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Premier League Transfer Income by Team (2019-20)",
       x = "Team",
       y = "Transfer Income (£ million)")







ggplot(season_2019_20, aes(x = reorder(Team, Gross_Spend_mil), y = Transfer_Income_mil)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Premier League Transfer Income by Team (2019-20)",
       x = "Team",
       y = "Transfer Income (£ million)")




ggplot(season_2019_20, aes(x = reorder(Team, Net_Spend_mil), y = Net_Spend_mil)) +
  geom_bar(stat = "identity", fill = "thistle") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Premier League Net Spend by Team (2019-20)",
       x = "Team",
       y = "Net Spend (£ million)")

ggplot(season_2019_20, aes(x = reorder(Team, Net_Spend_mil), y = Net_Spend_mil, group = 1)) +
  geom_line(color="lightpink", size =1.2)+
  geom_point(color = "purple", size = 2) +
  theme_minimal() +
  coord_flip() +
  labs(title = "Premier League Net Spend by Team (2019-20)",
       x = "Team",
       y = "Net Spend (£ million)")



#ZZQ: Relative spending measures how much a team spends on transfers compared to the league average (team spend ÷ league average spend).


ggplot(season_2019_20, aes(x = reorder(Team, Relative_Spending), y = Relative_Spending)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  theme_minimal() +
  coord_flip() +
  labs(
    title = "Premier League Relative Spending by Team (2019-20)",
    x = "Team",
    y = "Relative Spending (vs. League Avg = 1)"
  )





ggplot(season_2020_21, aes(x = reorder(Team, Relative_Spending), y = Relative_Spending)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  theme_minimal() +
  coord_flip() +
  labs(title = "Premier League Relative Spending by Team (2020-21)",
       x = "Team",
       y = "Relative Spending (vs. League Avg = 1)")


ggplot(season_2021_22, aes(x = reorder(Team, Relative_Spending), y = Relative_Spending)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  theme_minimal() +
  coord_flip() +
  labs(title = "Premier League Relative Spending by Team (2021-22)",
       x = "Team",
       y = "Relative Spending (vs. League Avg = 1)")

ggplot(season_2024_25, aes(x = reorder(Team, Relative_Spending), y = Relative_Spending)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  theme_minimal() +
  coord_flip() +
  labs(title = "Premier League Relative Spending by Team (2024-25)",
       x = "Team",
       y = "Relative Spending (vs. League Avg = 1)")




ggplot(season_2024_25, aes(x = Wins, y = Relative_Spending, label = Team)) +
  geom_point(color = "darkorange", size = 3) +
  geom_text(vjust = -0.5, size = 3) +
  theme_minimal() +
  labs(title = "Wins vs. Relative Spending by Team (2024-25)",
       x = "Wins",
       y = "Relative Spending")


ggplot(season_2024_25, aes(x = Wins, y = Players_signed, label = Team)) +
  geom_point(color = "darkorange", size = 3) +
  geom_text(vjust = -0.5, size = 3) +
  theme_minimal() +
  labs(title = "Wins vs. Players Signed by Team (2024-25)",
       x = "Wins",
       y = "Players Signed")










# Filtering and Pre-Processing for Clustering
#-------------------------------------------------------------------------------------
##ZZQ Get teams that played in 5 or more seasons
EPL_Data <- as.data.frame(EPL_Data)
teams_5plus <- sqldf("
                    Select Team
                    From EPL_Data
                    Group By Team
                    Having Count(*) >= 5
                     ")

##ZZQ Aggregate Wins,Total Relative spending, players signed
Cluster_Data <- sqldf("
  SELECT Team,
         SUM(Wins) AS Total_Wins,
         AVG(Relative_Spending) AS Avg_Relative_Spending,
         SUM(Players_Signed) AS Total_Players_Signed
  FROM EPL_Data
  WHERE Team IN (SELECT Team FROM teams_5plus)
  GROUP BY Team
")




View(Cluster_Data)

#Modeling
#-------------------------------------------------------------------------------------

#Wins VS Relative Spending by team

CLuster_KM_1 <- Cluster_Data %>%
  select(Total_Wins, Avg_Relative_Spending)
Cluster_Scaled_1 <- scale(CLuster_KM_1)

Cluster_Fit_K_Means_1 <- kmeans(Cluster_Scaled_1, centers =3, nstart=25)
Cluster_Data$K_Means_1 <- -1 * (as.numeric(Cluster_Fit_K_Means_1$cluster) - 2)

ggplot(Cluster_Data, aes(x = Total_Wins, 
                         y = Avg_Relative_Spending, 
                         color = factor(K_Means_1), 
                         label = Team)) +
  geom_point(alpha = 0.8, size = 4) +
  geom_text(vjust = -0.6, size = 3.5) +
  labs(
    title = "K-means Clustering on EPL Data",
    subtitle = "Clusters based on Total Wins and Relative Spending",
    color = "Cluster"
  ) +
  scale_color_brewer(palette = "Set1") +  
  theme_minimal() +
  theme(legend.position = "bottom")



#Wins vs Players Signed
CLuster_KM_1 <- Cluster_Data %>%
  select(Total_Wins, Total_Players_Signed)
Cluster_Scaled_1 <- scale(CLuster_KM_1)

Cluster_Fit_K_Means_1 <- kmeans(Cluster_Scaled_1, centers =3, nstart=25)
Cluster_Data$K_Means_1 <- -1 * (as.numeric(Cluster_Fit_K_Means_1$cluster) - 2)

ggplot(Cluster_Data, aes(x = Total_Wins, 
                         y = Total_Players_Signed, 
                         color = factor(K_Means_1), 
                         label = Team)) +
  geom_point(alpha = 0.8, size = 4) +
  geom_text(vjust = -0.6, size = 3.5) +
  labs(
    title = "K-means Clustering on EPL Data",
    subtitle = "Clusters based on Total Wins and Players Signed",
    color = "Cluster"
  ) +
  scale_color_brewer(palette = "Set1") +  
  theme_minimal() +
  theme(legend.position = "bottom")





#Wins vs Players Signed vs Relative Spend

Cluster_KM_2 <- Cluster_Data %>%
  select(Total_Wins, Avg_Relative_Spending, Total_Players_Signed)

Cluster_Scaled_2 <- scale(Cluster_KM_2)

Cluster_Fit_K_Means_2 <- kmeans(Cluster_Scaled_2, centers = 3, nstart = 25)

Cluster_Data$K_Means_2 <- -1 * (as.numeric(Cluster_Fit_K_Means_2$cluster) - 2)

ggplot(Cluster_Data, aes(x = Total_Wins, y = Avg_Relative_Spending, color = K_Means_2, label = Team)) +
  geom_point(alpha = 0.6, size = 3) +
  geom_text(vjust = -0.5, size = 3) +
  labs(title = "K-means Clustering on EPL Data",
       subtitle = "Clusters based on Wins, Spending, and Players Signed") +
  theme_minimal()





#------------------------------------------------------------------------------------------------
# ZZQ Incorporating Squad Values

squad_values <- data.frame(
  Team = c("Arsenal", "Aston Villa", "Bournemouth", "Brentford", 
           "Brighton & Hove Albion", "Burnley", "Chelsea", "Crystal Palace", 
           "Everton", "Fulham", "Leicester City", "Liverpool", "Manchester City", 
           "Manchester United", "Newcastle United", "Southampton", 
           "Tottenham Hotspur", "West Ham United", "Wolverhampton Wanderers"),
  Squad_Value_M = c(1170, 580, 250, 300, 500, 220, 1320, 410, 
                    420, 330, 370, 990, 1340, 1030, 760, 320, 
                    720, 480, 430)
)

Cluster_Data1 <- sqldf("
  SELECT 
    a.*, 
    b.Squad_Value_M,
    a.Avg_Relative_Spending / b.Squad_Value_M AS Spend_to_Value
  FROM Cluster_Data a
  LEFT JOIN squad_values b
  ON a.Team = b.Team
")


View(Cluster_Data1)

write.csv(Cluster_Data1, "ClusterData1.csv", row.names = FALSE)

#Modeling with new data
# ------------------------------------------------------------------------------------------------------------
#Spending Efficiency
set.seed(118)

Cluster_KM_1 <- Cluster_Data1 %>%
  select(Total_Wins, Spend_to_Value) 
 
Cluster_Scaled_1 <- scale(Cluster_KM_1)

Cluster_Fit_K_Means_1 <- kmeans(Cluster_Scaled_1, centers = 3, nstart = 25)

Cluster_Data1$K_Means_1 <- as.factor(Cluster_Fit_K_Means_1$cluster)

ggplot(Cluster_Data1, aes(x = Total_Wins, 
                                    y = Spend_to_Value, 
                                    color = K_Means_1, 
                                    label = Team)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_text(vjust = -0.5, size = 3) +
  labs(title = "K-means Clustering on EPL Clubs",
       subtitle = "Clusters based on Wins and Spend-to-Squad Value",
       x = "Total Wins",
       y = "Spending Efficiency ( Relative Spend / Squad Value)") +
  theme_minimal()



#Efficient,Over-investing, Underachieving,






#Logistic Regression
#-------------------------------------------------------------------------------------------------

library(performance)

#Left join epl_data (avg age ) onto clusterdata1
Cluster_Data1 <- sqldf("
  SELECT 
    a.*, 
    b.Average_Age
  FROM Cluster_Data1 a
  LEFT JOIN EPL_Data b
  ON a.Team = b.Team
")


pairs(Cluster_Data1[, c("Total_Wins", "Avg_Relative_Spending", "Average_Age", "Total_Players_Signed")])


str(Cluster_Data1)
summary(Cluster_Data1)
write.csv(Cluster_Data1, "Cluster1.csv", row.names = FALSE)


model_Poisson_1 <- glm(Total_Wins ~ Avg_Relative_Spending,
                       data= Cluster_Data1,
                       family = poisson)

model_Poisson_2 <- glm(Total_Wins ~ Avg_Relative_Spending + Average_Age,
                       data= Cluster_Data1,
                       family = poisson)

model_poisson_3 <- glm(Total_Wins ~ Avg_Relative_Spending + Average_Age + Total_Players_Signed,
                     data= Cluster_Data1,
                     family = poisson)


summary(model_Poisson_1)
summary(model_Poisson_2)
summary(model_poisson_3)


model_performance(model_Poisson_1)
model_performance(model_Poisson_2)
model_performance(model_poisson_3)

Cluster_Data1$Pred_Poisson_3 <- predict(model_poisson_3, type = "response")
Cluster_Data1$resid <- residuals(model_poisson_3, type = "pearson")

Team_Summary <- Cluster_Data1 %>%
  group_by(Team) %>%
  summarise(
    Actual_Wins = mean(Total_Wins),  
    Predicted_Wins = mean(Pred_Poisson_3),
    Residual = mean(resid)
  )

write.csv(Team_Summary, "Poisson_Model_Residuals1.csv", row.names = FALSE)

plot(Team_Summary$Predicted_Wins, 
     Team_Summary$Residual,
     xlab = "Predicted Wins (Team Average)", 
     ylab = "Average Residuals", 
     main = "Team-Level Residuals vs Predicted Wins",
     pch = 19, col = "blue")

abline(h = 0, col = "red", lty = 2)
