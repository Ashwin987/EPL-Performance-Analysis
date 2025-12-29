EPL Team Performance Analysis Using Modeling & Visualization

Author: Ashwin Ramaseshan

Project Overview

The English Premier League (EPL) is a highly competitive, financially-driven environment where club success is not always proportional to spending. This project investigates the primary drivers of team success over multiple seasons to identify key performance indicators and uncover teams that efficiently overperform relative to their financial resources.

Data & Methodology

    Data Sources: Team-level statistics were collected from FBref and Transfermarkt.

Preparation: Merged seasonal stats (wins, league position, net spend) with squad metrics (age, value) using R's sqldf package.

Relative Spending Metric: Created a custom variable by dividing a team’s net spend by the league average to create a common scale for meaningful analysis.

Clustering: Applied K-means clustering to identify "efficient buyers" who achieve high win totals despite limited resources.

Modeling: Implemented Poisson Regression models because the target variable, Total Wins, is a count variable.

Key Findings

    Spending Impact: Relative spending is a consistent and statistically significant positive predictor (p<0.001) of total wins.

Squad Age: Older average squad ages showed a statistically significant negative association with total wins.

Consistency vs. Turnover: The full model revealed that Total Players Signed had a negative effect on performance, suggesting that frequent squad changes may hurt team consistency.

Model Fit: Model 3 (Relative Spend + Age + Players Signed) was the best-fitting model with the lowest AIC (6228.9).

Strategic Success: Clubs like Brighton & Hove Albion and Brentford successfully outperform their financial peers through efficient squad management.

Tools Used

    Languages: R (sqldf, glm) 

Visualization: Tableau

Concepts: Poisson Regression, K-Means Clustering, Feature Engineering
