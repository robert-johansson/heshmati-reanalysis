# Dataset Variables

**RCT Dataset: ISTDP vs. Waitlist for Treatment-Resistant Depression**

This document provides a comprehensive description of all 37 variables in the dataset.

---

## Trial Variables (4)

### 1. Participant ID
- **Variable name**: `ID` or `participant_number`
- **Type**: Numeric
- **Description**: Unique identifier for each participant
- **Range**: 1-86

### 2. Treatment Condition
- **Variable name**: `condition` or `treatment`
- **Type**: Categorical
- **Values**:
  - `1` = ISTDP (Intensive Short-Term Dynamic Psychotherapy)
  - `2` = Waitlist control
- **Description**: Randomly assigned treatment group

### 3. Dropout Status
- **Variable name**: `dropout` or `completer`
- **Type**: Binary
- **Values**:
  - `0` = Completed all assessments
  - `1` = Dropped out before completion
- **Description**: Whether participant completed post-treatment and/or follow-up assessments
- **Note**: Overall dropout rate was 12.8% (11 of 86 participants)

### 4. Therapist Number
- **Variable name**: `therapist` or `therapist_id`
- **Type**: Categorical
- **Values**:
  - `1` = Therapist 1 (treated 22 participants)
  - `2` = Therapist 2 (treated 21 participants)
  - `NA` = Not applicable (waitlist participants)
- **Description**: Identifies which of two ISTDP therapists provided treatment

---

## Demographic Variables (6)

### 5. Age
- **Variable name**: `age`
- **Type**: Continuous
- **Units**: Years
- **Range**: 18-60 years (per inclusion criteria)
- **Sample mean**: 36.9 years (SD = 11.7)
- **Description**: Participant age at baseline

### 6. Gender
- **Variable name**: `gender` or `sex`
- **Type**: Binary
- **Values**:
  - `1` = Male (38.4%, n = 33)
  - `2` = Female (61.6%, n = 53)
- **Description**: Biological sex

### 7. Marital Status
- **Variable name**: `marital_status`
- **Type**: Categorical
- **Values**:
  - `1` = Single (32.6%, n = 28)
  - `2` = Married (55.8%, n = 48)
  - `3` = Divorced/Widowed (11.6%, n = 10)
- **Description**: Current marital status at baseline

### 8. Education Level
- **Variable name**: `education`
- **Type**: Ordinal
- **Values**:
  - `1` = High school graduate (38.4%, n = 33)
  - `2` = Undergraduate degree (43.0%, n = 37)
  - `3` = Graduate degree (18.6%, n = 16)
- **Description**: Highest completed level of education
- **Note**: Minimum high school education was required for inclusion

### 9. Employment Status
- **Variable name**: `employment`
- **Type**: Categorical
- **Values**:
  - `1` = Employed (53.5%, n = 46)
  - `2` = Unemployed (34.9%, n = 30)
  - `3` = Retired (11.6%, n = 10)
- **Description**: Current employment status at baseline

### 10. Socioeconomic Status
- **Variable name**: `SES` or `socioeconomic_status`
- **Type**: Ordinal
- **Values**:
  - `1` = Low (15.1%, n = 13)
    - Personal income < 30 million Iranian Rials (~$710 USD)
  - `2` = Middle (65.1%, n = 56)
    - Personal income 30-80 million Iranian Rials (~$710-$1,890 USD)
  - `3` = High (19.8%, n = 17)
    - Personal income > 80 million Iranian Rials (>~$1,890 USD)
- **Description**: Socioeconomic classification based on personal income

---

## Clinical Characteristics (2)

### 11. Number of Previous Antidepressant Trials
- **Variable name**: `previous_ADM_trials` or `n_previous_trials`
- **Type**: Count/Discrete
- **Range**: 1-4 trials
- **Sample mean**: 1.84 (SD = 0.94)
- **Distribution**:
  - 1 trial: 44.2% (n = 38)
  - 2 trials: 37.2% (n = 32)
  - 3 trials: 9.3% (n = 8)
  - 4 trials: 9.3% (n = 8)
- **Description**: Number of prior adequate antidepressant medication trials that failed for current depressive episode
- **Note**: Minimum of 1 unsuccessful trial required for inclusion (definition of treatment-resistant depression)

### 12. Current Antidepressant Medication Use
- **Variable name**: `current_ADM` or `ADM_use`
- **Type**: Binary
- **Values**:
  - `0` = No (20.9%, n = 18)
  - `1` = Yes (79.1%, n = 68)
- **Description**: Currently taking antidepressant medication at baseline
- **Note**: Medication use was permitted during trial if dosage remained stable

---

## Outcome Measures

All outcome measures were assessed at **three time points**:
- **T1**: Baseline (pre-treatment)
- **T2**: Post-treatment (10 weeks after baseline)
- **T3**: 3-month follow-up (22 weeks after baseline)

Variable naming convention: `[measure]_[timepoint]`
- Example: `WAI_depression_T1`, `WAI_depression_T2`, `WAI_depression_T3`

---

### Weinberger Adjustment Inventory (WAI)

**Overview**: 81-item self-report measure of social and emotional adjustment
- **Response scale**: 5-point Likert scale
  - 1 = "False/Almost Never"
  - 2 = "Mostly False/Sometimes"
  - 3 = "Don't Know/About Half the Time"
  - 4 = "Mostly True/Often"
  - 5 = "True/Always"
- **Scoring**: Items are summed to create subscale and scale scores

#### WAI Scale Scores (3)

### 13-15. Distress Scale
- **Variable names**: `WAI_distress_T1`, `WAI_distress_T2`, `WAI_distress_T3`
- **Type**: Continuous
- **Range**: 29-145 (29 items × 1-5 scale)
- **Subscales**: Sum of Anxiety + Depression + Low Self-Esteem + Low Well-Being
- **Description**: Overall measure of psychological distress
- **Interpretation**: Higher scores = greater distress

### 16-18. Restraint Scale
- **Variable names**: `WAI_restraint_T1`, `WAI_restraint_T2`, `WAI_restraint_T3`
- **Type**: Continuous
- **Range**: 30-150 (30 items × 1-5 scale)
- **Subscales**: Sum of Suppression of Aggression + Impulse Control + Consideration of Others + Responsibility
- **Description**: Measure of behavioral and emotional restraint/self-control
- **Interpretation**: Higher scores = greater restraint

### 19-21. Defensiveness Scale
- **Variable names**: `WAI_defensiveness_T1`, `WAI_defensiveness_T2`, `WAI_defensiveness_T3`
- **Type**: Continuous
- **Range**: 22-110 (22 items × 1-5 scale)
- **Subscales**: Sum of Repressive Defensiveness + Denial of Distress
- **Description**: Measure of defensive coping and response style
- **Interpretation**: Higher scores = greater defensiveness

#### WAI Distress Subscales (4)

### 22-24. Anxiety
- **Variable names**: `WAI_anxiety_T1`, `WAI_anxiety_T2`, `WAI_anxiety_T3`
- **Type**: Continuous
- **Items**: 8
- **Range**: 8-40
- **Description**: Subjective anxiety symptoms
- **Interpretation**: Higher scores = greater anxiety

### 25-27. Depression
- **Variable names**: `WAI_depression_T1`, `WAI_depression_T2`, `WAI_depression_T3`
- **Type**: Continuous
- **Items**: 7
- **Range**: 7-35
- **Sample baseline mean**: 30.23 (SD = 4.16)
- **Description**: Depressive symptoms
- **Example item**: "I feel so down and unhappy that nothing makes me feel much better"
- **Interpretation**: Higher scores = greater depression severity
- **Note**: **Primary outcome measure**
- **Internal consistency**: α = 0.81 (current sample)

### 28-30. Low Self-Esteem
- **Variable names**: `WAI_selfesteem_T1`, `WAI_selfesteem_T2`, `WAI_selfesteem_T3`
- **Type**: Continuous
- **Items**: 7
- **Range**: 7-35
- **Description**: Low self-worth and self-confidence
- **Interpretation**: Higher scores = lower self-esteem

### 31-33. Low Well-Being
- **Variable names**: `WAI_wellbeing_T1`, `WAI_wellbeing_T2`, `WAI_wellbeing_T3`
- **Type**: Continuous
- **Items**: 7
- **Range**: 7-35
- **Description**: Absence of positive psychological functioning
- **Interpretation**: Higher scores = lower well-being

#### WAI Restraint Subscales (4)

### 34-36. Suppression of Aggression
- **Variable names**: `WAI_suppress_aggression_T1`, `WAI_suppress_aggression_T2`, `WAI_suppress_aggression_T3`
- **Type**: Continuous
- **Items**: 7
- **Range**: 7-35
- **Description**: Control over aggressive impulses and behavior
- **Interpretation**: Higher scores = greater suppression of aggression

### 37-39. Impulse Control
- **Variable names**: `WAI_impulse_control_T1`, `WAI_impulse_control_T2`, `WAI_impulse_control_T3`
- **Type**: Continuous
- **Items**: 8
- **Range**: 8-40
- **Description**: Ability to delay gratification and control impulses
- **Interpretation**: Higher scores = better impulse control

### 40-42. Consideration of Others
- **Variable names**: `WAI_consideration_T1`, `WAI_consideration_T2`, `WAI_consideration_T3`
- **Type**: Continuous
- **Items**: 7
- **Range**: 7-35
- **Description**: Empathy and concern for others
- **Interpretation**: Higher scores = greater consideration of others

### 43-45. Responsibility
- **Variable names**: `WAI_responsibility_T1`, `WAI_responsibility_T2`, `WAI_responsibility_T3`
- **Type**: Continuous
- **Items**: 8
- **Range**: 8-40
- **Description**: Sense of duty and reliability
- **Interpretation**: Higher scores = greater responsibility

#### WAI Defensiveness Subscales (2)

### 46-48. Repressive Defensiveness
- **Variable names**: `WAI_repressive_T1`, `WAI_repressive_T2`, `WAI_repressive_T3`
- **Type**: Continuous
- **Items**: 11
- **Range**: 11-55
- **Description**: Tendency to present oneself in overly positive light
- **Example item**: "I never act like I know more about something that I really do"
- **Interpretation**: Higher scores = greater repressive defensiveness
- **Internal consistency**: α = 0.78 (current sample)

### 49-51. Denial of Distress
- **Variable names**: `WAI_denial_T1`, `WAI_denial_T2`, `WAI_denial_T3`
- **Type**: Continuous
- **Items**: 11
- **Range**: 11-55
- **Description**: Denial of negative emotions or problems
- **Interpretation**: Higher scores = greater denial of distress

#### WAI Composite Score

### 52-54. Repressive/Restraint Composite (RRC)
- **Variable names**: `WAI_RRC_T1`, `WAI_RRC_T2`, `WAI_RRC_T3`
- **Type**: Continuous
- **Range**: 21-105
- **Calculation**: (Restraint Scale Score ÷ 3) + Repressive Defensiveness Subscale Score
- **Sample baseline mean**: 77.53 (SD = 8.33)
- **Description**: Measure of emotional repression
- **Interpretation**: Higher scores = greater emotional repression/avoidance
- **Note**: **Primary outcome measure** (theory-specific construct)
- **Internal consistency**:
  - Restraint dimension: α = 0.80 (current sample)
  - Repressive defensiveness: α = 0.78 (current sample)

---

### Positive and Negative Affect Schedule (PANAS)

**Overview**: 20-item self-report measure of positive and negative affect
- **Administration**: Participants rate how they felt during the past week
- **Response scale**: 5-point Likert scale
  - 1 = "Very slightly or not at all"
  - 2 = "A little"
  - 3 = "Moderately"
  - 4 = "Quite a bit"
  - 5 = "Extremely"

### 55-57. Negative Affect (PANAS-NA)
- **Variable names**: `PANAS_NA_T1`, `PANAS_NA_T2`, `PANAS_NA_T3`
- **Type**: Continuous
- **Items**: 10
- **Range**: 10-50
- **Sample baseline mean**: 35.87 (SD = 8.87)
- **Scoring**: Sum of 10 negative affect items
- **Emotion items**: Distressed, upset, guilty, scared, hostile, irritable, ashamed, nervous, jittery, afraid
- **Description**: Subjective experience of negative emotions and distress
- **Interpretation**: Higher scores = greater negative affect
- **Note**: **Primary outcome measure**
- **Internal consistency**: α = 0.91 (current sample)
- **Validity**: Well-established external validity

---

## Helper Variables (10)

These variables facilitate statistical analysis and are derived from the data structure.

### Time Point Dummy Variables (3)

### 58. Baseline Indicator
- **Variable name**: `time_baseline` or `T1`
- **Type**: Binary
- **Values**:
  - `1` = Baseline observation
  - `0` = Not baseline
- **Description**: Indicator for baseline time point

### 59. Post-treatment Indicator
- **Variable name**: `time_post` or `T2`
- **Type**: Binary
- **Values**:
  - `1` = Post-treatment observation (10 weeks)
  - `0` = Not post-treatment
- **Description**: Indicator for post-treatment time point

### 60. Follow-up Indicator
- **Variable name**: `time_followup` or `T3`
- **Type**: Binary
- **Values**:
  - `1` = Follow-up observation (3 months post-treatment)
  - `0` = Not follow-up
- **Description**: Indicator for 3-month follow-up time point

### Time Variable

### 61. Time
- **Variable name**: `time`
- **Type**: Categorical/Ordinal
- **Values**:
  - `0` or `1` = Baseline
  - `1` or `2` = Post-treatment
  - `2` or `3` = Follow-up
- **Description**: Time point indicator for longitudinal analysis

### Interaction Terms (6)

Used in mixed-effects models to test treatment effects at each time point.

### 62. Treatment × Post-treatment
- **Variable name**: `treatment_x_post` or `condition_time_T2`
- **Type**: Binary
- **Values**:
  - `1` = ISTDP group at post-treatment
  - `0` = Otherwise
- **Description**: Interaction between treatment condition and post-treatment time point

### 63. Treatment × Follow-up
- **Variable name**: `treatment_x_followup` or `condition_time_T3`
- **Type**: Binary
- **Values**:
  - `1` = ISTDP group at follow-up
  - `0` = Otherwise
- **Description**: Interaction between treatment condition and follow-up time point

### 64. Waitlist × Post-treatment
- **Variable name**: `waitlist_x_post`
- **Type**: Binary
- **Values**:
  - `1` = Waitlist group at post-treatment
  - `0` = Otherwise
- **Description**: Interaction for waitlist control at post-treatment

### 65. Waitlist × Follow-up
- **Variable name**: `waitlist_x_followup`
- **Type**: Binary
- **Values**:
  - `1` = Waitlist group at follow-up
  - `0` = Otherwise
- **Description**: Interaction for waitlist control at follow-up

### 66-67. Additional Contrasts
- **Description**: Additional dummy-coded variables for specific time comparisons (e.g., post-treatment to follow-up contrast)

---

## Missing Data

- **Pattern**: Monotone missing pattern due to dropout
- **Mechanism**: Missing at random (MAR) assumed
- **Frequency**:
  - Baseline: 0% missing (n = 86)
  - Post-treatment: 12.8% missing (n = 11 dropouts)
  - Follow-up: 12.8% missing (cumulative dropouts)
- **Handling**: Original analysis used mixed-effects models with all available data (intention-to-treat)

---

## Variable Summary by Category

| Category | Count | Variables |
|----------|-------|-----------|
| Trial variables | 4 | ID, condition, dropout, therapist |
| Demographics | 6 | Age, gender, marital status, education, employment, SES |
| Clinical characteristics | 2 | Previous ADM trials, current ADM use |
| WAI scales (×3 time points) | 9 | Distress, Restraint, Defensiveness |
| WAI subscales (×3 time points) | 30 | 10 subscales across 3 time points |
| WAI composite (×3 time points) | 3 | RRC (emotional repression) |
| PANAS (×3 time points) | 3 | Negative affect |
| Helper variables | 10 | Time indicators and interactions |
| **Total** | **67** | (37 unique constructs, 30 are repeated measures) |

---

## Primary Outcomes Summary

The three **primary outcome variables** at each time point:

1. **Depression**: `WAI_depression_T1`, `WAI_depression_T2`, `WAI_depression_T3`
2. **Emotional Repression**: `WAI_RRC_T1`, `WAI_RRC_T2`, `WAI_RRC_T3`
3. **Negative Affect**: `PANAS_NA_T1`, `PANAS_NA_T2`, `PANAS_NA_T3`

---

## References

- **WAI**: Weinberger, D.A., Tublin, S.K., Ford, M.E., & Feldman, S.S. (1990). Preadolescents' social-emotional adjustment and selective attrition in family research. *Child Development*, *61*(5), 1374-1386.

- **PANAS**: Watson, D., Clark, L.A., & Tellegen, A. (1988). Development and validation of brief measures of positive and negative affect: The PANAS scales. *Journal of Personality and Social Psychology*, *54*(6), 1063-1070.

- **Study**: Heshmati, R., Wienicke, F.J., & Driessen, E. (2023). The effects of intensive short-term dynamic psychotherapy on depressive symptoms, negative affect, and emotional repression in single treatment-resistant depression: A randomized controlled trial. *Psychotherapy*, *60*(4), 497-511.
