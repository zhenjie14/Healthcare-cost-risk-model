# Healthcare Claim Severity Modeling and Actuarial Risk Segmentation

## Overview

Accurate claim severity estimation is a core actuarial function used to price policies, set reserves, and segment risk exposure. This project builds an end-to-end actuarial analytics pipeline that estimates expected healthcare expenditures across 1,338 policyholders and segments them into interpretable risk tiers using demographic and behavioral risk factors.

The project applies Gamma Generalized Linear Models (GLMs), the industry standard approach for modeling positive and right skewed claim distributions, alongside SQL portfolio analytics and quantile based risk classification.

---

## Key Results

| Metric | Linear Regression (Baseline) | Gamma GLM |
| ------ | ---------------------------: | --------: |
| MAE    | $4,311.33                    | $4,387.79 |
| RMSE   | $5,825.28                    | $7,711.95 |
| R²     | 0.781                        | 0.594     |

The mean claim in this portfolio was $13,270. An MAE of $4,388 represents roughly 33% of average claim size, which reflects realistic prediction uncertainty in healthcare given hidden medical factors and individual tail risk. The Gamma GLM trades raw predictive accuracy for actuarially appropriate distributional assumptions, making it better suited for reserve estimation and pricing even where R² is lower.

---

## Key Findings

**Smoking status was the dominant cost driver.**
Smokers averaged $32,050 in annual claims compared to $8,434 for non-smokers, a 3.8x difference in raw averages. The Gamma GLM estimated a 4.48x multiplicative effect after controlling for age, BMI, and region, meaning smoking alone increased expected claim severity by approximately 348%.

**Obesity compounded the smoking effect significantly.**
Among non-smokers, moving from low BMI to high BMI increased average claims from $7,547 to $8,853, a modest 17% increase. Among smokers, the same BMI shift increased average claims from $19,839 to $41,693, a 110% increase. This interaction effect suggests obese smokers represent disproportionate tail risk in the portfolio.

**Age showed a consistent positive relationship with claim severity.**
Charges increased steadily with age across both smokers and non-smokers, consistent with actuarial expectations for health insurance pricing.

**Risk segmentation produced clearly separated tiers.**

| Risk Tier     | Policyholders | Average Actual Claims |
| ------------- | ------------: | --------------------: |
| Low Risk      | 335 (25%)     | $4,273                |
| Moderate Risk | 334 (25%)     | $7,582                |
| High Risk     | 334 (25%)     | $12,154               |
| Severe Risk   | 335 (25%)     | $29,052               |

Severe risk policyholders averaged 6.8x the claims of low risk policyholders, demonstrating that the model successfully separates risk exposure across the portfolio.

---

## Project Workflow

```text
Raw Healthcare Data (1,338 policyholders)
        ↓
Exploratory Data Analysis
        ↓
Feature Engineering (BMI categories, encoding)
        ↓
Linear Regression Benchmark
        ↓
Gamma GLM Severity Model (log link)
        ↓
Multiplicative Risk Factor Analysis
        ↓
Quantile Based Risk Tier Segmentation
        ↓
SQL Portfolio Analytics
        ↓
Visualizations and Reporting
```

---

## Visualizations

### Actual vs Predicted Healthcare Charges
![Actual vs Predicted](visuals/actual_vs_predicted_charges.png)

### Healthcare Costs by BMI Group and Smoking Status
![BMI Smoking Analysis](visuals/charges_by_bmi_and_smoking_status.png)

### Healthcare Charges by Age and Smoking Status
![Age Smoking Analysis](visuals/charges_vs_age_smoking.png)

---

## SQL Analytics

The modeled dataset was loaded into SQLite to support portfolio level reporting. Key findings from the SQL analysis:

- Smokers generated 4x higher average costs than non-smokers despite representing a minority of policyholders
- The Severe Risk tier, while 25% of policyholders by count, accounted for a disproportionate share of total portfolio claims
- High severity policyholder profiles consistently combined smoking status with high BMI and older age

---

<<<<<<< HEAD
=======
## Limitations

The model does not capture chronic condition history, prescription drug use, or prior claims, all of which would improve severity estimates in a real underwriting context. Individual prediction errors remain high (RMSE of $7,712), which is expected in healthcare claims modeling due to the inherently unpredictable nature of individual health events. Results are based on a single cross sectional dataset and should not be interpreted as causal.

---

## Technologies

Python, Pandas, NumPy, Scikit-Learn, Statsmodels, SQL, SQLite, Matplotlib, Jupyter Notebook

---
>>>>>>> 5a20f84 (fixing readme)

