USE ocd;

-- 1. Count & Pct of F vs M that have OCD & Average Obsession Score by Gender

-- Purpose: To analyze the gender distribution (count and percentage).
-- Symbolism: This highlights potential gender-based differences in OCD prevalence and severity, enabling gender-specific analysis or interventions.

WITH data AS (
    SELECT
        Gender,
        COUNT(`Patient ID`) AS patient_count,
        ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score
    FROM 
        ocd_patient_dataset_csv
    GROUP BY 
        Gender
)
SELECT
    SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) AS count_female,
    SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) AS count_male,
    ROUND(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) / 
    (SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS pct_female,
    ROUND(SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) / 
    (SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) * 100, 2) AS pct_male
FROM 
    data;

-- 2. Count of Patients by Ethnicity and their respective Average Obsession Score
-- Purpose: To explore the distribution of OCD patients across ethnic groups and their average scores.
-- Symbolism: Ethnic-based insights can help understand cultural or demographic trends in OCD diagnosis and severity.

SELECT 
    Ethnicity,
    COUNT(`Patient ID`) AS patient_count,
    ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score,
    ROUND(AVG(`Y-BOCS Score (Compulsions)`), 2) AS avg_comp_score
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    Ethnicity
ORDER BY 
    patient_count;

-- 3. Number of people diagnosed with OCD per Month

-- Purpose: To calculate the number of new OCD diagnoses per month.
-- Symbolism: This shows temporal patterns, potentially correlating diagnoses with external factors like awareness campaigns or stress-inducing global events.

SELECT 
    DATE_FORMAT(STR_TO_DATE(`OCD Diagnosis Date`, '%Y-%m-%d'), '%Y-%m-01 00:00:00') AS month,
    COUNT(`Patient ID`) AS patient_count
FROM 
    ocd_patient_dataset_csv
WHERE 
    `OCD Diagnosis Date` IS NOT NULL
GROUP BY 
    month
ORDER BY 
    month;

-- 4. What is the most common Obsession Type (Count) & its respective Average Obsession Score

-- Purpose: To identify the most frequently reported obsession and compulsion types and their severity.
-- Symbolism: This helps prioritize areas of focus in OCD treatment based on the most prevalent symptoms.

SELECT 
    `Obsession Type`,
    COUNT(`Patient ID`) AS patient_count,
    ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS obs_score
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    `Obsession Type`
ORDER BY 
    patient_count;

-- 5. What is the most common Compulsion Type (Count) & its respective Average Obsession Score
SELECT 
    `Compulsion Type`,
    COUNT(`Patient ID`) AS patient_count,
    ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS obs_score
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    `Compulsion Type`
ORDER BY 
    patient_count;

-- 6. What are the most common medications for OCD patients

-- Purpose: To find the most prescribed medications for OCD patients.
-- Symbolism: Indicates treatment trends and guides clinical decisions.

SELECT 
    `Medications`,
    COUNT(`Patient ID`) AS patient_count
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    `Medications`
ORDER BY 
    patient_count DESC;

-- 7. How much common is depression and anxiety for OCD patients

-- Purpose: To analyze how common depression and anxiety are among OCD patients.
-- Symbolism: Highlights mental health intersections, offering a picture of OCD's psychological impact.

SELECT 
    SUM(CASE WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'Yes' THEN 1 ELSE 0 END) AS both_depression_anxiety_count,
    ROUND(SUM(CASE WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'Yes' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_both_depression_anxiety,
    SUM(CASE WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'No' THEN 1 ELSE 0 END) AS only_depression_count,
    ROUND(SUM(CASE WHEN `Depression Diagnosis` = 'Yes' AND `Anxiety Diagnosis` = 'No' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_only_depression,
    SUM(CASE WHEN `Depression Diagnosis` = 'No' AND `Anxiety Diagnosis` = 'Yes' THEN 1 ELSE 0 END) AS only_anxiety_count,
    ROUND(SUM(CASE WHEN `Depression Diagnosis` = 'No' AND `Anxiety Diagnosis` = 'Yes' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_only_anxiety,
    SUM(CASE WHEN `Depression Diagnosis` = 'No' AND `Anxiety Diagnosis` = 'No' THEN 1 ELSE 0 END) AS neither_count,
    ROUND(SUM(CASE WHEN `Depression Diagnosis` = 'No' AND `Anxiety Diagnosis` = 'No' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_neither
FROM 
    ocd_patient_dataset_csv;

-- 8. How much common is OCD with family history

-- Purpose: To determine how prevalent OCD is among people with a family history.
-- Symbolism: Links genetic or hereditary factors to OCD prevalence, supporting research work.

SELECT 
    SUM(CASE WHEN `Family History of OCD` = 'Yes' THEN 1 ELSE 0 END) AS family_history_count,
    ROUND(SUM(CASE WHEN `Family History of OCD` = 'Yes' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_family_history,
    SUM(CASE WHEN `Family History of OCD` = 'No' THEN 1 ELSE 0 END) AS no_family_history_count,
    ROUND(SUM(CASE WHEN `Family History of OCD` = 'No' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_no_family_history
FROM 
    ocd_patient_dataset_csv;

-- 9. How many had a previously diagnosed history of diseases (including PTSD, Others, and None)

-- Purpose: To analyze the distribution of previous diagnoses like PTSD, MDD, or none.
-- Symbolism: Helps understand the history of other disorders that might co-occur with OCD or act as risk factors.

SELECT 
    SUM(CASE WHEN `Previous Diagnoses` = 'PTSD' THEN 1 ELSE 0 END) AS ptsd_count,
    ROUND(SUM(CASE WHEN `Previous Diagnoses` = 'PTSD' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_ptsd,
    SUM(CASE WHEN `Previous Diagnoses` = 'MDD' THEN 1 ELSE 0 END) AS mdd_count,
    ROUND(SUM(CASE WHEN `Previous Diagnoses` = 'MDD' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_mdd,
    SUM(CASE WHEN `Previous Diagnoses` = 'None' THEN 1 ELSE 0 END) AS no_count,
    ROUND(SUM(CASE WHEN `Previous Diagnoses` = 'None' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_no,
    SUM(CASE WHEN `Previous Diagnoses` = 'GAD' THEN 1 ELSE 0 END) AS gad_count,
    ROUND(SUM(CASE WHEN `Previous Diagnoses` = 'GAD' THEN 1 ELSE 0 END) / COUNT(`Patient ID`) * 100, 2) AS pct_gad
FROM 
    ocd_patient_dataset_csv;

-- 10. Social standing of person using marital status and college

-- Purpose: To explore OCD prevalence based on marital status and education.
-- Symbolism: Provides a socio-economic perspective on how life circumstances relate to OCD.

SELECT 
    `Marital Status`,
    `Education Level`,
    COUNT(`Patient ID`) AS patient_count,
    ROUND(COUNT(`Patient ID`) / (SELECT COUNT(`Patient ID`) FROM ocd_patient_dataset_csv) * 100, 2) AS pct_total
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    `Marital Status`, `Education Level`
ORDER BY 
    patient_count DESC;

-- 11. Count of People in Each Age Group and their Average Obsession and compulsion Score

-- Purpose: To categorize patients into age groups and analyze their average obsession and compulsion scores.
-- Symbolism: Helps identify age-related trends, crucial for targeting age-specific treatments or interventions

SELECT 
    CASE 
        WHEN `Age` BETWEEN 18 AND 25 THEN '18-25'
        WHEN `Age` BETWEEN 26 AND 35 THEN '26-35'
        WHEN `Age` BETWEEN 36 AND 45 THEN '36-45'
        WHEN `Age` BETWEEN 46 AND 55 THEN '46-55'
        WHEN `Age` BETWEEN 56 AND 65 THEN '56-65'
        WHEN `Age` > 65 THEN '66+'
        ELSE 'Unknown Age'
    END AS age_group,
    COUNT(`Patient ID`) AS patient_count,
    ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score,
    ROUND(AVG(`Y-BOCS Score (Compulsions)`), 2) AS avg_obs_score
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    age_group
ORDER BY 
    age_group;
    
    -- 12 , 13 Count of Patients in Each Y-BOCS Obsession and Compulsion Severity Category
    
--   Purpose: To classify patients into severity levels based on Y-BOCS scores for obsessions and compulsions.
--   Symbolism: Provides a clinical perspective on how severe OCD symptoms are across the population, aiding resource allocation for severe cases.
    
SELECT 
    CASE 
        WHEN `Y-BOCS Score (Obsessions)` BETWEEN 0 AND 7 THEN 'Subclinical (0-7)'
        WHEN `Y-BOCS Score (Obsessions)` BETWEEN 8 AND 15 THEN 'Mild (8-15)'
        WHEN `Y-BOCS Score (Obsessions)` BETWEEN 16 AND 23 THEN 'Moderate (16-23)'
        WHEN `Y-BOCS Score (Obsessions)` BETWEEN 24 AND 31 THEN 'Severe (24-31)'
        WHEN `Y-BOCS Score (Obsessions)` BETWEEN 32 AND 40 THEN 'Extreme (32-40)'
        ELSE 'Unknown'
    END AS obsession_severity,
    COUNT(`Patient ID`) AS patient_count_obsession 
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    obsession_severity
;

SELECT 
    CASE 
        WHEN `Y-BOCS Score (Compulsions)` BETWEEN 0 AND 7 THEN 'Subclinical (0-7)'
        WHEN `Y-BOCS Score (Compulsions)` BETWEEN 8 AND 15 THEN 'Mild (8-15)'
        WHEN `Y-BOCS Score (Compulsions)` BETWEEN 16 AND 23 THEN 'Moderate (16-23)'
        WHEN `Y-BOCS Score (Compulsions)` BETWEEN 24 AND 31 THEN 'Severe (24-31)'
        WHEN `Y-BOCS Score (Compulsions)` BETWEEN 32 AND 40 THEN 'Extreme (32-40)'
        ELSE 'Unknown'
    END AS compulsion_severity,
    COUNT(`Patient ID`) AS patient_count_obsession 
FROM 
    ocd_patient_dataset_csv
GROUP BY 
    compulsion_severity
;
