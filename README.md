# Effects of Intensive Short-Term Dynamic Psychotherapy on Depression: A Reanalysis of Heshmati et al.'s Data

[![DOI](https://img.shields.io/badge/DOI-10.17605%2FOSF.IO%2F75PU8-blue)](https://doi.org/10.17605/OSF.IO/75PU8)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

This repository contains a complete reanalysis of data from a randomized controlled trial examining the effects of Intensive Short-Term Dynamic Psychotherapy (ISTDP) versus waitlist control on depressive symptoms in individuals with treatment-resistant depression.

**Author:** Robert Johansson

**Original Study:**
> Heshmati, R., Wienicke, F. J., & Driessen, E. (2023). The effects of intensive short-term dynamic psychotherapy on depressive symptoms, negative affect, and emotional repression in single treatment-resistant depression: A randomized controlled trial. *Psychotherapy*, *60*(4), 497-511. https://doi.org/10.1037/pst0000500

## Repository Structure

```
heshmati-reanalysis/
├── README.md                  # This file
├── LICENSE                    # License information
├── .gitignore                # Git ignore rules
├── data/
│   ├── RCT Dataset...sav     # Original SPSS data file
│   └── README.md             # Data dictionary and codebook
├── docs/
│   ├── Heshmati et al 2023 RCT.pdf              # Original paper
│   ├── Heshmati Wienicke Driessen 2025.pdf      # Data descriptor
│   └── VARIABLES.md          # Variable descriptions
├── manuscript.Rmd            # Main R Markdown manuscript (reproduces all analyses)
├── manuscript.pdf            # Generated manuscript (APA format)
├── figures/                  # Auto-generated figures
│   ├── trajectories-1.pdf
│   └── effect-sizes-1.pdf
└── sessionInfo.txt           # R package versions used
```

## Reproducibility

This project is **fully reproducible**. The entire manuscript, including all statistical analyses, tables, and figures, is generated from a single R Markdown file.

### Requirements

**Software:**
- R (≥ 4.0.0)
- RStudio (recommended, not required)
- LaTeX distribution (for PDF output)
  - macOS: MacTeX
  - Windows: MiKTeX
  - Linux: TeX Live

**R Packages:**
```r
install.packages(c(
  "papaja",      # APA manuscript formatting
  "haven",       # Read SPSS files
  "dplyr",       # Data manipulation
  "tidyr",       # Data tidying
  "ggplot2",     # Plotting
  "lme4",        # Mixed-effects models
  "lmerTest",    # Tests for lme4
  "emmeans",     # Estimated marginal means
  "effsize",     # Effect size calculations
  "knitr",       # R Markdown
  "rmarkdown"    # R Markdown
))
```

### Quick Start

**Option 1: RStudio (Recommended)**
1. Clone this repository
2. Open `manuscript.Rmd` in RStudio
3. Click "Knit" button
4. Wait for compilation (1-2 minutes)
5. `manuscript.pdf` will be generated

**Option 2: Command Line**
```bash
# Clone repository
git clone https://github.com/yourusername/heshmati-reanalysis.git
cd heshmati-reanalysis

# Install R packages (if needed)
Rscript -e "install.packages(c('papaja', 'haven', 'dplyr', 'tidyr', 'ggplot2', 'lme4', 'lmerTest', 'emmeans', 'effsize', 'knitr', 'rmarkdown'), repos='https://cloud.r-project.org')"

# Render manuscript
Rscript -e "rmarkdown::render('manuscript.Rmd')"
```

### What Gets Generated

Running `manuscript.Rmd` will:
1. **Load and prepare data** from the SPSS file
2. **Calculate demographics** (Table 1)
3. **Fit linear mixed-effects model** with random intercepts
4. **Generate figures:**
   - Mean depression trajectories with 95% CIs
   - Between-group effect sizes over time
5. **Calculate estimated marginal means** (Table 2)
6. **Perform pairwise comparisons** (within- and between-groups)
7. **Compute effect sizes** (Cohen's d with 95% CIs)
8. **Generate APA-formatted manuscript** (`manuscript.pdf`)

## Key Findings

- **Baseline**: Groups were balanced (Cohen's d = 0.08, p = .73)
- **Post-treatment (10 weeks)**: Large effect favoring ISTDP (d = 1.68, 95% CI [1.15, 2.22], p < .001)
- **Follow-up (3 months)**: Very large effect favoring ISTDP (d = 2.50, 95% CI [1.88, 3.11], p < .001)
- **Within-group changes:**
  - ISTDP: 8.40-point reduction at post-treatment, 12.87-point reduction at follow-up (both p < .001)
  - Waitlist: Minimal, non-significant changes (all ps > .10)

## Dataset

### Description
- **Sample size:** N = 86 (43 ISTDP, 43 waitlist control)
- **Population:** Iranian adults with treatment-resistant depression
- **Design:** Randomized controlled trial
- **Treatment:** ISTDP (20 sessions over 10 weeks) vs. waitlist
- **Primary outcome:** Depression (Weinberger Adjustment Inventory Depression subscale)
- **Assessment points:** Baseline, post-treatment (10 weeks), 3-month follow-up
- **Missing data:** 8.5% (22 of 258 observations)

### Data Access
The original dataset is publicly available on the Open Science Framework:
- **DOI:** https://doi.org/10.17605/OSF.IO/75PU8
- **Direct link:** https://osf.io/wxg8p

### Data Dictionary
See `data/README.md` for complete variable descriptions and `docs/VARIABLES.md` for detailed coding information.

## Statistical Methods

**Primary Analysis:**
- Linear mixed-effects model with random intercepts
- Fixed effects: Time (3 levels) × Treatment (2 levels)
- Missing data: Handled via REML estimation (missing at random assumption)
- Software: R packages `lme4` and `lmerTest`

**Model Selection:**
- Random intercept model was chosen over random intercept + slope model based on BIC comparison and parsimony considerations

**Post-hoc Comparisons:**
- Estimated marginal means with Kenward-Roger degrees of freedom
- Pairwise comparisons with Tukey adjustment for multiple testing
- Effect sizes: Cohen's d with 95% confidence intervals

## Citations

### Original Study
```bibtex
@article{heshmati2023,
  author = {Heshmati, Rasoul and Wienicke, Frederik J. and Driessen, Ellen},
  title = {The effects of intensive short-term dynamic psychotherapy on depressive symptoms, negative affect, and emotional repression in single treatment-resistant depression: A randomized controlled trial},
  journal = {Psychotherapy},
  volume = {60},
  number = {4},
  pages = {497--511},
  year = {2023},
  doi = {10.1037/pst0000500}
}
```

### Data Descriptor
```bibtex
@article{heshmati2025,
  author = {Heshmati, Rasoul and Wienicke, Frederik J. and Driessen, Ellen},
  title = {Dataset from a randomized controlled trial comparing intensive short-term dynamic psychotherapy to waitlist for treatment-resistant depression},
  journal = {Data in Brief},
  volume = {63},
  pages = {112126},
  year = {2025},
  doi = {10.1016/j.dib.2025.112126}
}
```

### This Reanalysis
If you use this reanalysis, please cite:
```
Johansson, R. (2025). Effects of Intensive Short-Term Dynamic Psychotherapy on Depression: A Reanalysis of Heshmati et al.'s Data. GitHub repository: https://github.com/yourusername/heshmati-reanalysis
```

## License

This work is licensed under the [MIT License](https://opensource.org/licenses/MIT).

You are free to:
- Use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the software
- Use the work for any purpose, including commercial purposes

The only requirement is:
- **Attribution** — Include the original copyright notice and license in any copies or substantial portions of the work

## Contact

For questions about this reanalysis:
- Robert Johansson: robert.johansson@university.edu

For questions about the original data:
- Rasoul Heshmati: psy.heshmati@tabrizu.ac.ir
- Frederik J. Wienicke: fritz.wienicke@ru.nl
- Ellen Driessen: ellen.driessen@ru.nl

## Ethics

- Original study ethics approval: Research Ethics Committee, University of Tabriz (IR.TABRIZU.REC.1400.012)
- All data are de-identified
- Original study registration: https://osf.io/v46gy

## Acknowledgments

This reanalysis uses publicly available data generously shared by Heshmati, Wienicke, and Driessen. We thank the authors for their commitment to open science and data sharing.

## Version History

- **v1.0** (2025-10-10): Initial release with complete reanalysis

## Issues and Contributions

If you find any issues with this reanalysis or have suggestions for improvements, please open an issue on GitHub or contact the author directly.
