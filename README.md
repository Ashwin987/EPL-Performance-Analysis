# EPL-Performance-Analysis

EPL Team Performance Analysis Using Modeling & Visualization
Project Overview

The English Premier League (EPL) is one of the most competitive and financially-driven soccer leagues globally. While clubs spend millions on player acquisitions, success is not always proportional to investment. This project investigates the true drivers of team success over multiple seasons, identifying key performance indicators and uncovering teams that significantly overperform or underperform relative to their financial resources.

Data Sources & Preparation

The analysis utilizes team-level data collected from FBref and Transfermarkt.

    Primary Dataset: Included seasonal metrics such as wins, final league position, seasonal income, net spend, and win percentage.

Supplementary Dataset: Contained average squad age, number of players signed, and total squad value per season.

Data Cleaning:

    Performed a left join on Team and Season using R's sqldf package.

Aggregated metrics over the last 6 seasons to focus on long-term trends rather than seasonal variability.

Filtered for consistency, including only teams that played in the EPL for at least 5 of the last 6 seasons.

Feature Engineering: Relative Spending

Raw net spend can be misleading, as "Big Six" clubs (like Manchester City) naturally have higher baseline expenditures. To create a common scale, a Relative Spending variable was created:

Relative Spending=League Average Net Spend (Same Season)Team’s Net Spend​

    Value = 1: Team spent exactly the league average.

Value > 1: Above-average spending.

Value < 1: Below-average spending.

Methodology
1. K-Means Clustering

Applied K-means clustering to identify distinct groups of teams based on performance and spending behavior:

    Cluster 1 (Wins vs. Players Signed): Analyzed if high turnover in the squad correlates with winning.

Cluster 2 (Wins vs. Spending Efficiency): Defined as Squad Value (M)Avg Relative Spending​. This identifies "efficient buyers" who achieve high win totals despite limited resources.

2. Poisson Regression Modeling

Poisson models were selected because the target variable, Total Wins, is a count variable (non-negative integers).

    Model 1: Wins predicted by Average Relative Spending.

Model 2: Added Average Squad Age to Relative Spending.

Model 3 (Full Model): Included Relative Spending, Average Squad Age, and Total Players Signed.

Key Insights

    Spending Impact: Relative spending is a consistent and statistically significant predictor of wins (p<0.001).

Squad Age: Older squads show a slight negative correlation with total wins (p<0.005).

Consistency vs. Change: Total Players Signed has a negative effect (Estimate = -0.0128), suggesting that frequent squad changes may hurt team consistency and performance.

Model Fit: Model 3 was the best-fitting model with the lowest AIC (6228.9) and Residual Deviance (2927.2).

Efficiency: Lower-spending clubs like Brighton and Brentford were identified as significantly outperforming their financial peers through efficient management.

Future Work

    Integrate advanced performance metrics such as Expected Goals (xG), goals scored, and goals conceded.

Apply the same modeling framework to other major European leagues (La Liga, Bundesliga) to test the universality of these spending patterns
