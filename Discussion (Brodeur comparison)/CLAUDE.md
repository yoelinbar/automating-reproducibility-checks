# Project Instructions

## Statistical Reproduction Guidelines

When reproducing statistical analyses from published papers:

**Any deviation in statistics beyond rounding errors is VERY meaningful**, even if the results are in the same direction or maintain the same significance level. All deviations must be:

1. **Flagged as high importance** in reports
2. **Prominently displayed** at the top of reproduction reports (not buried in tables)
3. **Categorized by severity:**
   - **Critical:** Significance changed (e.g., p < .05 became p > .05 or vice versa)
   - **High:** Large magnitude differences (>10%) even if significance unchanged
   - **Moderate:** Small differences (.01-.02) that exceed rounding error

4. **Documented with:**
   - Exact paper value vs reproduced value
   - Percentage or absolute difference
   - Potential explanations to investigate

Do not dismiss discrepancies as "minor" or attribute them to "software differences" without investigation. Matching effect sizes with mismatched test statistics is a red flag requiring explanation.
