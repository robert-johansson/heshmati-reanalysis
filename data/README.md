# Data Dictionary

## Dataset Overview

**File**: `RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav`

**Format**: SPSS (.sav) binary file

**Structure**: Long format (repeated measures)

**Sample**: 86 Iranian adults with treatment-resistant depression
- ISTDP group: n = 43
- Waitlist control: n = 43

**Time points**:
- Baseline (T1): Pre-treatment
- Post-treatment (T2): 10 weeks after baseline
- Follow-up (T3): 3-month follow-up (22 weeks after baseline)

**Total observations**: 258 (86 participants × 3 time points)

**Missing data**: 22 observations (8.5%) due to dropout

---

## Variable List

### Trial Variables

| Variable | Type | Description | Values/Range |
|----------|------|-------------|--------------|
| `id` | Numeric | Unique participant identifier | 1-86 |
| `Tx_condition` | Categorical | Treatment assignment | "ISTDP" or "Control" |
| `Dropout` | Binary | Dropout status | 0 = Completed, 1 = Dropped out |
| `therapist` | Categorical | Therapist number (ISTDP only) | 1, 2, or NA |
| `Time` | Categorical | Assessment time point | "Baseline", "Post-treatment", "Follow-up" |

### Demographics (Baseline)

| Variable | Type | Description | Values/Range |
|----------|------|-------------|--------------|
| `age` | Continuous | Age in years | 18-60 |
| `gender` | Categorical | Biological sex | "male", "female" |
| `marriage` | Categorical | Marital status | "single", "married", "widow.divorced" |
| `education` | Categorical | Education level | "highschool", "undergraduate", "graduate" |
| `job` | Categorical | Employment status | "employed", "unemployed", "retiered" [sic] |
| `SES` | Categorical | Socioeconomic status | "low", "middle", "high" |

### Clinical Characteristics (Baseline)

| Variable | Type | Description | Values/Range |
|----------|------|-------------|--------------|
| `previoustreatment` | Count | Number of prior failed antidepressant trials | 1-4 |
| `medicationreceiving` | Binary | Currently taking antidepressants | "yes", "no" |

### Primary Outcome Measures (Repeated Measures)

**Depression** (WAI Depression subscale)
- **Variable**: `Depression`
- **Type**: Continuous
- **Range**: 7-35 (7 items, 1-5 scale)
- **Interpretation**: Higher = more depressed
- **Baseline mean**: ISTDP 30.1 (SD=4.6), Control 30.4 (SD=3.7)

**Emotional Repression** (WAI Repressive/Restraint Composite)
- **Variable**: `WAI_RRC`
- **Type**: Continuous
- **Range**: 21-105
- **Calculation**: (Restraint Scale ÷ 3) + Repressive Defensiveness
- **Interpretation**: Higher = greater emotional repression

**Negative Affect** (PANAS Negative Affect subscale)
- **Variable**: `PANAS_NA`
- **Type**: Continuous
- **Range**: 10-50 (10 items, 1-5 scale)
- **Interpretation**: Higher = more negative emotions

### Additional WAI Measures (Repeated Measures)

All WAI variables are continuous, measured at each time point:

**Scale Scores:**
- `Distress`: Sum of 4 subscales (range: 29-145)
- `Restraint`: Sum of 4 subscales (range: 30-150)
- `Defensiveness`: Sum of 2 subscales (range: 22-110)

**Distress Subscales:**
- `Anxiety`: 8 items (range: 8-40)
- `Low_self_esteem`: 7 items (range: 7-35)
- `Low_well_being`: 7 items (range: 7-35)

**Restraint Subscales:**
- `Suppression_of_aggression`: 7 items (range: 7-35)
- `Impulse_control`: 8 items (range: 8-40)
- `Consideration_of_others`: 7 items (range: 7-35)
- `Responsibility`: 8 items (range: 8-40)

**Defensiveness Subscales:**
- `Repressive_Defensiveness`: 11 items (range: 11-55)
- `Denial_of_distress`: 11 items (range: 11-55)

### Helper Variables

| Variable | Type | Description | Values |
|----------|------|-------------|--------|
| `Time1` | Binary | Baseline indicator | 0 or 1 |
| `Time2` | Binary | Post-treatment indicator | 0 or 1 |
| `Time1PF` | Binary | Time contrast | 0 or 1 |
| `Time2PF` | Binary | Time contrast | 0 or 1 |
| `Inter1` | Binary | Interaction: Tx × Post-treatment | 0 or 1 |
| `Inter2` | Binary | Interaction: Tx × Follow-up | 0 or 1 |
| `Inter1PF` | Binary | Interaction term | 0 or 1 |
| `Inter2PF` | Binary | Interaction term | 0 or 1 |
| `Interaction_term` | Binary | General interaction term | 0 or 1 |

---

## Data Quality

### Missing Data

**Pattern**: Monotone (dropout-related)

**Frequency by time point**:
- Baseline: 0% missing (n = 86)
- Post-treatment: ~14% missing (n = 11-12 dropouts)
- Follow-up: ~14% missing (cumulative)

**Assumption**: Missing at random (MAR)

**Handling**: Use all available data in mixed-effects models

### Sample Characteristics (Baseline, N = 86)

| Characteristic | ISTDP (n=43) | Control (n=43) | Total (N=86) |
|----------------|--------------|----------------|--------------|
| **Age, M (SD)** | 36.5 (12.3) | 37.3 (11.3) | 36.9 (11.7) |
| **Female, %** | 65.1 | 58.1 | 61.6 |
| **Married, %** | 51.2 | 60.5 | 55.8 |
| **Undergraduate+, %** | 58.1 | 65.1 | 61.6 |
| **Employed, %** | 41.9 | 65.1 | 53.5 |
| **Middle SES, %** | 65.1 | 65.1 | 65.1 |
| **Prior ADM trials, M (SD)** | 1.81 (1.01) | 1.86 (0.89) | 1.84 (0.95) |
| **Current ADM use, %** | 76.7 | 81.4 | 79.1 |

---

## Reading the Data

### R
```r
library(haven)
data <- read_sav("RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")

# Convert factors
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    gender = as_factor(gender),
    # etc.
  )
```

### Python
```python
import pandas as pd
df = pd.read_spss("RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
```

### SPSS
```
GET FILE='RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav'.
```

---

## Inclusion Criteria

Participants were included if they:
- Were aged 18-60 years
- Met DSM-IV criteria for Major Depressive Disorder
- Had failed ≥1 adequate antidepressant medication trial
- Had minimum high school education
- Provided informed consent

---

## Study Design

**Type**: Randomized controlled trial (1:1 allocation)

**Recruitment**: April-May 2020 (Tabriz, Iran)

**Treatment period**: June-August 2020

**Follow-up assessment**: November 2020

**Intervention**:
- **ISTDP**: 20 individual sessions over 10 weeks (twice weekly)
- **Control**: Waitlist (no study treatment)

**Therapists**: 2 certified ISTDP therapists
- Each treated approximately 21-22 participants
- Mean 8 years of ISTDP experience

---

## Ethics

- **Ethics approval**: Research Ethics Committee, University of Tabriz (IR.TABRIZU.REC.1400.012)
- **Data privacy**: All data are de-identified
- **Registration**: Retrospectively registered at OSF (https://osf.io/v46gy)
- **Consent**: Written informed consent obtained from all participants

---

## Data Source

**Original data available at**: https://doi.org/10.17605/OSF.IO/75PU8

**Publications**:

1. **Primary article**:
   > Heshmati, R., Wienicke, F. J., & Driessen, E. (2023). The effects of intensive short-term dynamic psychotherapy on depressive symptoms, negative affect, and emotional repression in single treatment-resistant depression: A randomized controlled trial. *Psychotherapy*, *60*(4), 497-511. https://doi.org/10.1037/pst0000500

2. **Data descriptor**:
   > Heshmati, R., Wienicke, F. J., & Driessen, E. (2025). Dataset from a randomized controlled trial comparing intensive short-term dynamic psychotherapy to waitlist for treatment-resistant depression. *Data in Brief*, *63*, 112126. https://doi.org/10.1016/j.dib.2025.112126

---

## Measurement Instruments

### Weinberger Adjustment Inventory (WAI)
- **Items**: 81
- **Response scale**: 5-point Likert (1 = False/Almost Never to 5 = True/Always)
- **Internal consistency**: α = 0.78-0.91 (current sample)
- **Reference**: Weinberger et al. (1990)

### Positive and Negative Affect Schedule (PANAS)
- **Items**: 20 (10 positive, 10 negative)
- **Response scale**: 5-point Likert (1 = Very slightly or not at all to 5 = Extremely)
- **Timeframe**: Past week
- **Internal consistency**: α = 0.91 for Negative Affect (current sample)
- **Reference**: Watson, Clark, & Tellegen (1988)

---

## Contact

For questions about the data:
- Rasoul Heshmati: psy.heshmati@tabrizu.ac.ir
- Frederik J. Wienicke: fritz.wienicke@ru.nl
- Ellen Driessen: ellen.driessen@ru.nl

---

## License

This reanalysis code and documentation are available under the MIT License.

The original data are made available by the authors under their own terms. Please cite the original publications when using these data (see above).
