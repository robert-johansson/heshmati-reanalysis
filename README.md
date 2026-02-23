# Effects of Intensive Short-Term Dynamic Psychotherapy on Depression: A Reanalysis of Heshmati et al.'s Data

[![DOI](https://img.shields.io/badge/DOI-10.17605%2FOSF.IO%2F75PU8-blue)](https://doi.org/10.17605/OSF.IO/75PU8)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Pages](https://img.shields.io/badge/presentation-live-success)](https://robert-johansson.github.io/heshmati-reanalysis/presentation/)

## Overview

This repository contains a complete reanalysis of data from a randomized controlled trial examining the effects of Intensive Short-Term Dynamic Psychotherapy (ISTDP) versus waitlist control on depressive symptoms in individuals with treatment-resistant depression.

**Authors:** Robert Johansson & Peter Lilliengren, Department of Psychology, Stockholm University, Stockholm, Sweden

**Original Study:**
> Heshmati, R., Wienicke, F. J., & Driessen, E. (2023). The effects of intensive short-term dynamic psychotherapy on depressive symptoms, negative affect, and emotional repression in single treatment-resistant depression: A randomized controlled trial. *Psychotherapy*, *60*(4), 497-511. https://doi.org/10.1037/pst0000500 ([preprint](https://repository.ubn.ru.nl/bitstream/handle/2066/298912/1/298912.pdf))

## Presentations

**View the research presentation online:**
- **HTML Slides (Web):** [View online](https://robert-johansson.github.io/heshmati-reanalysis/presentation/) - Interactive xaringan presentation
- **PDF Slides:** [Download PDF](https://github.com/robert-johansson/heshmati-reanalysis/raw/main/presentation-beamer.pdf) - Beamer slides for printing

## Repository Structure

```
heshmati-reanalysis/
├── README.md                  # This file
├── LICENSE                    # License information
├── .gitignore                # Git ignore rules
├── check-analyses.R          # Run all validation tests
├── data/
│   ├── RCT Dataset...sav     # Original SPSS data file
│   └── README.md             # Data dictionary and codebook
├── docs/
│   ├── index.html            # GitHub Pages landing page
│   ├── presentation/         # Web presentation
│   │   ├── presentation.Rmd  # xaringan source
│   │   ├── index.html        # Generated HTML slides
│   │   ├── custom.css        # Custom styling
│   │   └── libs/             # xaringan dependencies
│   ├── testing.md            # Testing framework documentation
│   ├── presentation-guide.md # Presentation usage guide
│   ├── github-pages-setup.md # GitHub Pages setup guide
│   └── VARIABLES.md          # Variable descriptions
├── manuscript.Rmd            # Main R Markdown manuscript (reproduces all analyses)
├── manuscript.pdf            # Generated manuscript (APA format)
├── presentation-beamer.Rmd   # Beamer presentation source
├── presentation-beamer.pdf   # PDF presentation
├── figures/                  # Auto-generated figures
│   ├── trajectories-1.pdf
│   └── process-trajectories-1.pdf
├── tests/                    # Comprehensive test suite (75 tests)
│   ├── testthat/
│   │   ├── test-data-integrity.R
│   │   ├── test-transformations.R
│   │   ├── test-models.R
│   │   ├── test-results.R
│   │   ├── test-reproducibility.R
│   │   └── test-original-comparison.R
│   └── testthat.R
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
  "mediation",   # Causal mediation analysis
  "patchwork",   # Combine plots
  "kableExtra",  # Enhanced tables
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
git clone https://github.com/robert-johansson/heshmati-reanalysis.git
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
   - Process measure trajectories
5. **Calculate estimated marginal means** (Table 2)
6. **Perform pairwise comparisons** (within- and between-groups)
7. **Compute effect sizes** (Cohen's d with 95% CIs)
8. **Perform mediation and cross-lagged analyses** for process measures
9. **Generate APA-formatted manuscript** (`manuscript.pdf`)

## Key Findings

- **Baseline**: Groups were balanced (Cohen's d = 0.08, p = .73)
- **Post-treatment (10 weeks)**: Large effect favoring ISTDP (d = 1.68, 95% CI [1.15, 2.22], p < .001)
- **Follow-up (3 months)**: Very large effect favoring ISTDP (d = 2.50, 95% CI [1.88, 3.11], p < .001)
- **Within-group changes:**
  - ISTDP: 8.40-point reduction at post-treatment, 12.87-point reduction at follow-up (both p < .001)
  - Waitlist: Minimal, non-significant changes (all ps > .10)
- **Mediation:** Neither emotional repression nor negative affect significantly mediated depression improvement. Distress showed apparent mediation, but a sensitivity analysis removing the overlapping Depression subscale eliminated this effect.
- **Temporal precedence:** Cross-lagged analyses revealed no evidence that process changes preceded depression changes, suggesting concurrent rather than sequential change.

## Dataset

### Description
- **Sample size:** N = 86 (43 ISTDP, 43 waitlist control)
- **Population:** Iranian adults with treatment-resistant depression
- **Design:** Randomized controlled trial
- **Treatment:** ISTDP (20 sessions over 10 weeks) vs. waitlist
- **Primary outcome:** Depression (Weinberger Adjustment Inventory Depression subscale)
- **Assessment points:** Baseline, post-treatment (10 weeks), 3-month follow-up
- **Attrition:** 12.8% overall (7 ISTDP [16.3%], 4 waitlist [9.3%])
- **Missing data:** 8.5% (22 of 258 observations) due to dropout

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

**Mechanism Analyses:**
- Bootstrap mediation analysis (5,000 resamples, BCa CIs) using the `mediation` package
- Cross-lagged panel analyses with standardized coefficients for temporal precedence testing

**Sensitivity Analyses:**
- Distress without Depression subscale (to address construct overlap)
- Therapist effects (fixed effect for therapist in LMM)
- Baseline mediator control in mediation models

## Testing and Validation

This project includes a comprehensive testing framework to ensure reproducibility and statistical validity.

### Overview

- **75 automated tests** validate all analyses
- **Two-tier approach:** Inline assertions (run during knitting) + comprehensive test suite
- **100% pass rate** ✅
- Full documentation: [`docs/testing.md`](docs/testing.md)

### Quick Test

Run all validation tests:

```bash
Rscript check-analyses.R
```

Expected output:
```
✅ All tests passed! Statistical analyses are validated.
```

### What's Tested

| Category | Tests | Validates |
|----------|-------|-----------|
| **Data Integrity** | 15 | Sample size, missing data, variable types, scale ranges |
| **Transformations** | 10 | Variable coding, change scores, format conversions |
| **Model Validity** | 12 | LMM convergence, structure, assumptions, diagnostics |
| **Results** | 20 | Effect sizes, EMMs, treatment effects, significance tests |
| **Reproducibility** | 8 | Identical results across runs, bootstrap consistency |
| **Original Study** | 10 | Demographics, effects match Heshmati et al. (2023) |

### Test Files

```
tests/
├── testthat/
│   ├── test-data-integrity.R       # Data structure validation
│   ├── test-transformations.R      # Variable coding checks
│   ├── test-models.R               # Statistical model validation
│   ├── test-results.R              # Results plausibility checks
│   ├── test-reproducibility.R      # Reproducibility verification
│   └── test-original-comparison.R  # Cross-validation with original study
└── testthat.R                      # Test runner
```

### For Reviewers

To verify reproducibility:

1. Clone this repository
2. Install R packages (see Requirements above)
3. Run: `Rscript check-analyses.R`
4. All 75 tests should pass ✅

This demonstrates:
- **Reproducibility:** Analyses produce identical results (seed = 2025)
- **Validity:** All statistical assumptions verified
- **Transparency:** Complete test code available
- **Best practices:** Modern research software engineering standards

For details, see [`docs/testing.md`](docs/testing.md).

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
Johansson, R., & Lilliengren, P. (2026). Effectiveness and mechanisms of intensive short-term dynamic
psychotherapy for treatment-resistant depression: A reanalysis of a randomized controlled trial.
https://github.com/robert-johansson/heshmati-reanalysis
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
- Robert Johansson: robert.johansson@psychology.su.se

For questions about the original data:
- Rasoul Heshmati: psy.heshmati@tabrizu.ac.ir
- Frederik J. Wienicke: fritz.wienicke@ru.nl
- Ellen Driessen: ellen.driessen@ru.nl

## Ethics

- Original study ethics approval: Research Ethics Committee, University of Tabriz (IR.TABRIZU.REC.1400.012)
- All data are de-identified
- Original study registration: https://osf.io/v46gy

## Acknowledgments

This reanalysis uses publicly available data generously shared by Heshmati, Wienicke, and Driessen. We thank the authors for their commitment to open science and data sharing. We also thank Professor Allan Abbass for helpful comments and suggestions on the manuscript.

## Version History

- **v1.1** (2026-02-23): Corrected dropout numbers, added mediation and cross-lagged analyses to key findings, added sensitivity analyses (distress without depression, therapist effects, baseline mediator control), expanded WAI description, added Heshmati et al. (2021) reference
- **v1.0** (2025-10-10): Initial release with complete reanalysis

## Issues and Contributions

If you find any issues with this reanalysis or have suggestions for improvements, please open an issue on GitHub or contact the author directly.
