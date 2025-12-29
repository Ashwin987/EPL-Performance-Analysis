# ⚽ EPL Team Performance Analysis Using Modeling & Visualization

**Author:** Ashwin Ramaseshan  

## Overview
The English Premier League (EPL) is a highly competitive, financially driven environment where club success is not always proportional to spending. This project investigates the primary drivers of team success over multiple seasons to identify key performance indicators and uncover teams that efficiently outperform relative to their financial resources.

## Data & Methodology
- **Data Sources:** Team-level statistics collected from FBref and Transfermarkt
- **Preparation:** Merged seasonal performance metrics (wins, league position, net spend) with squad characteristics (age, value) using R’s `sqldf` package
- **Relative Spending Metric:** Created a normalized spending measure by dividing each team’s net spend by the league average
- **Clustering:** Applied K-means clustering to identify “efficient buyers” that achieve high win totals despite limited resources
- **Modeling:** Implemented Poisson regression models, as total wins are a count-based outcome

## Key Findings
- **Spending Impact:** Relative spending is a consistent and statistically significant positive predictor of total wins
- **Squad Age:** Older average squad age showed a statistically significant negative association with performance
- **Consistency vs. Turnover:** Higher numbers of players signed negatively impacted performance, suggesting reduced squad cohesion
- **Model Fit:** The best-performing model included Relative Spend, Squad Age, and Players Signed (lowest AIC)
- **Strategic Success:** Clubs such as Brighton & Hove Albion and Brentford outperform financial peers through efficient squad management

## Tools
- **Languages:** R (`sqldf`, `glm`)
- **Visualization:** Tableau

## Notes
This project focuses on understanding efficiency and performance drivers in the EPL using statistical modeling and clustering techniques.
