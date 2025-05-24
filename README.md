# Non-stationary Temperature Extremes with ProNEVA

This project analyzes extreme temperature trends in Paris and Detroit using the ProNEVA (Process-informed Nonstationary Extreme Value Analysis) framework. The goal is to compare stationary and non-stationary GEV models and understand how climate change affects temperature extremes.

## Contents

- Final Report: `Non_stationary_Temperature_Extremes_with_ProNEVA.pdf`
- MATLAB code: ProNEVA toolbox with custom settings
- Data: Annual maximum temperature series (1901–2024) from CRU TS v4.09
- Custom scripts: 
  - `run_GUI_for_ProNEVA.m` (sets random seed for reproducibility)
  - `PLOTS.m` (adjusted forecast horizon)

## Key Findings

- **Paris** shows a significant warming trend. A non-stationary GEV model with a quadratic trend in the location parameter fits best.
- **Detroit** shows no significant trend. The stationary GEV model is more appropriate.

## How to Reproduce

1. Open MATLAB and run `run_GUI_for_ProNEVA.m`
2. Load temperature data and configure model settings as shown in the report
3. Run MCMC and plot results

## Citation

Zhang, Z. (2025). *Modeling Non-stationary Temperature Extremes with ProNEVA: A Case Study of Paris and Detroit*. University of Waterloo.

---

For questions, contact: zehao.zhang@uwaterloo.ca
