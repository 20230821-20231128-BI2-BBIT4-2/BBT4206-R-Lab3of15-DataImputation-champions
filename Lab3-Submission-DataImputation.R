# STEP 1. Install and Load the Required Packages ----
# The following packages should be installed and loaded before proceeding to the
# subsequent steps.

## NHANES ----
# The dataset we will use (for educational purposes) is the US National Health
# and Nutrition Examination Study (NHANES) dataset created from 1999 to 2004.

# Documentation of NHANES:
#   https://cran.r-project.org/package=NHANES or
#   https://cran.r-project.org/web/packages/NHANES/NHANES.pdf or
#   http://www.cdc.gov/nchs/nhanes.htm

# This requires the "NHANES" package available in R

if (!is.element("NHANES", installed.packages()[, 1])) {
  install.packages("NHANES", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("NHANES")

## dplyr ----
if (!is.element("dplyr", installed.packages()[, 1])) {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("dplyr")

## naniar ----
# Documentation:
#   https://cran.r-project.org/package=naniar or
#   https://www.rdocumentation.org/packages/naniar/versions/1.0.0
if (!is.element("naniar", installed.packages()[, 1])) {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("naniar")

## ggplot2 ----
# We require the "ggplot2" package to create more appealing visualizations
if (!is.element("ggplot2", installed.packages()[, 1])) {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("ggplot2")

## MICE ----
# We use the MICE package to perform data imputation
if (!is.element("mice", installed.packages()[, 1])) {
  install.packages("mice", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("mice")

## Amelia ----
if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("Amelia")

student_performance_dataset <-
  readr::read_csv(
    "data/student_performance_dataset.csv", # nolint
    col_types =
      readr::cols(
        class_group =
          readr::col_factor(levels = c("A", "B", "C")),
        gender = readr::col_factor(levels = c("1", "0")),
        YOB = readr::col_date(format = "%Y"),
        regret_choosing_bi =
          readr::col_factor(levels = c("1", "0")),
        drop_bi_now =
          readr::col_factor(levels = c("1", "0")),
        motivator =
          readr::col_factor(levels = c("1", "0")),
        read_content_before_lecture =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        anticipate_test_questions =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        answer_rhetorical_questions =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        find_terms_I_do_not_know =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        copy_new_terms_in_reading_notebook =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        take_quizzes_and_use_results =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        reorganise_course_outline =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        write_down_important_points =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        space_out_revision =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        studying_in_study_group =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        schedule_appointments =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        goal_oriented =
          readr::col_factor(levels =
                              c("1", "0")),
        spaced_repetition =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        testing_and_active_recall =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        interleaving =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        categorizing =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        retrospective_timetable =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        cornell_notes =
          readr::col_factor(levels =
                              c("1", "2", "3", "4")),
        sq3r = readr::col_factor(levels =
                                   c("1", "2", "3", "4")),
        commute = readr::col_factor(levels =
                                      c("1", "2",
                                        "3", "4")),
        study_time = readr::col_factor(levels =
                                         c("1", "2",
                                           "3", "4")),
        repeats_since_Y1 = readr::col_integer(),
        paid_tuition = readr::col_factor(levels =
                                           c("0", "1")),
        free_tuition = readr::col_factor(levels =
                                           c("0", "1")),
        extra_curricular = readr::col_factor(levels =
                                               c("0", "1")),
        sports_extra_curricular =
          readr::col_factor(levels = c("0", "1")),
        exercise_per_week = readr::col_factor(levels =
                                                c("0", "1",
                                                  "2",
                                                  "3")),
        meditate = readr::col_factor(levels =
                                       c("0", "1",
                                         "2", "3")),
        pray = readr::col_factor(levels =
                                   c("0", "1",
                                     "2", "3")),
        internet = readr::col_factor(levels =
                                       c("0", "1")),
        laptop = readr::col_factor(levels = c("0", "1")),
        family_relationships =
          readr::col_factor(levels =
                              c("1", "2", "3", "4", "5")),
        friendships = readr::col_factor(levels =
                                          c("1", "2", "3",
                                            "4", "5")),
        romantic_relationships =
          readr::col_factor(levels =
                              c("0", "1", "2", "3", "4")),
        spiritual_wellnes =
          readr::col_factor(levels = c("1", "2", "3",
                                       "4", "5")),
        financial_wellness =
          readr::col_factor(levels = c("1", "2", "3",
                                       "4", "5")),
        health = readr::col_factor(levels = c("1", "2",
                                              "3", "4",
                                              "5")),
        day_out = readr::col_factor(levels = c("0", "1",
                                               "2", "3")),
        night_out = readr::col_factor(levels = c("0",
                                                 "1", "2",
                                                 "3")),
        alcohol_or_narcotics =
          readr::col_factor(levels = c("0", "1", "2", "3")),
        mentor = readr::col_factor(levels = c("0", "1")),
        mentor_meetings = readr::col_factor(levels =
                                              c("0", "1",
                                                "2", "3")),
        `Attendance Waiver Granted: 1 = Yes, 0 = No` =
          readr::col_factor(levels = c("0", "1")),
        GRADE = readr::col_factor(levels =
                                    c("A", "B", "C", "D",
                                      "E"))),
    locale = readr::locale())

View(student_performance_dataset)

# STEP 2. Create a subset of the variables/features ----
# We select only the following 13 features to be included in the dataset:
student_long_dataset <- student_performance_dataset %>%
  select(`CAT 2 (8%): x/100 x 100`, `Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5`,
         `Quiz 5 on Concept 5 (Dashboarding) x/10`, 
         `Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5`, 
         `Quiz 4 on Concept 4 (Non-Linear) x/22` , 
         `Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5`, 
         `CAT 1 (8%): x/38 x 100`,
         `class_group`,
         `EXAM: x/60 (60%)`,`Lab 1 - 2.c. - (Simple Linear Regression) x/5` , `Quiz 3 on Concept 3 (Linear) x/15`, )
View( student_performance_dataset )

data_new<- plyr::rename(student_long_dataset, c("CAT 2 (8%): x/100 x 100" = "CAT2",
                                 "Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5" = "Lab4",    
                                 "Quiz 5 on Concept 5 (Dashboarding) x/10" = "Quiz5",
                                 "Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5" = "Lab3",    
                                 "Quiz 4 on Concept 4 (Non-Linear) x/22" = "Quiz4",
                                 "Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5" = "Lab2",   
                                 "CAT 1 (8%): x/38 x 100" = "CAT1",
                                 "EXAM: x/60 (60%)" = "Exam",   
                                 "Lab 1 - 2.c. - (Simple Linear Regression) x/5" = "Lab1",
                                 "Quiz 3 on Concept 3 (Linear) x/15" = "Quiz3" ))
                                   


### Subset of rows ----
# We then select 500 random observations to be included in the dataset
##rand_ind <- sample(seq_len(nrow(student_long_dataset)), 500)
##student_performance_dataset  <- student_long_dataset[rand_ind, ]


# STEP 3. Confirm the "missingness" in the Dataset before Imputation ----
# Are there missing values in the dataset?
any_na(student_long_dataset)

# How many?
n_miss(student_long_dataset)

# What is the percentage of missing data in the entire dataset?
prop_miss(student_long_dataset)

# How many missing values does each variable have?
student_long_dataset%>% is.na() %>% colSums()

# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(student_long_dataset)

# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(student_long_dataset)

# Which variables contain the most missing values?
gg_miss_var(student_long_dataset)

# Where are missing values located (the shaded regions in the plot)?
vis_miss(student_long_dataset) + theme(axis.text.x = element_text(angle = 80))

# Which combinations of variables are missing together?
gg_miss_upset(student_long_dataset)

# Create a heatmap of "missingness" broken down by "class_group"
# First, confirm that the "class_group" variable is a categorical variable
is.factor(student_long_dataset$class_group)
# Second, create the visualization
gg_miss_fct(student_long_dataset, fct =class_group)

#STEP 4. Use the MICE package to perform data imputation ----
  # We can use the dplyr::mutate() function inside the dplyr package to add new
  # variables that are functions of existing variables

# In this case, it is used to create a new variable called,
# "Median Arterial Pressure (MAP)"

nhanes_dataset <- nhanes_dataset %>%
  mutate(MAP = BPDiaAve + (1 / 3) * (BPSysAve - BPDiaAve))

# MAP can be positively correlated with "BMI", unfortunately, BMI was reported
# to have approximately 4.8% missing values.

# MAP can also be negatively correlated with "PhysActiveDays" which had
# approximately 55% missing data.

# We finally begin to make use of Multivariate Imputation by Chained
# Equations (MICE). We use 11 multiple imputations.

# To arrive at good predictions for each variable containing missing values, we
# save the variables that are at least "somewhat correlated" (r > 0.3).
somewhat_correlated_variables <- quickpred(data_new, mincor = 0.3) # nolint

# m = 11 Specifies that the imputation (filling in the missing data) will be
#         performed 11 times (multiple times) to create several complete
#         datasets before we pool the results to arrive at a more realistic
#         final result. The larger the value of "m" and the larger the dataset,
#         the longer the data imputation will take.
# seed = 7 Specifies that number 7 will be used to offset the random number
#         generator used by mice. This is so that we get the same results
#         each time we run MICE.
# meth = "pmm" Specifies the imputation method. "pmm" stands for "Predictive
#         Mean Matching" and it can be used for numeric data.
#         Other methods include:
#         1. "logreg": logistic regression imputation; used
#            for binary categorical data
#         2. "polyreg": Polytomous Regression Imputation for unordered
#            categorical data with more than 2 categories, and
#         3. "polr": Proportional Odds model for ordered categorical
#            data with more than 2 categories.

student_long_mice<- mice(data_new, m = 11, method = "pmm",
                            seed = 7,
                            predictorMatrix = somewhat_correlated_variables)

## Impute the missing data ----
# We then create imputed data for the final dataset using the mice::complete()
# function in the mice package to fill in the missing data.
student_long_dataset_imputed <- mice::complete(student_long_mice, 1)

# STEP 5. Confirm the "missingness" in the Imputed Dataset ----
# A textual confirmation that the dataset has no more missing values in any
# feature:
miss_var_summary(student_long_dataset_imputed)

# A visual confirmation that the dataset has no more missing values in any
# feature:
Amelia::missmap(student_long_dataset_imputed)

#########################
# Are there missing values in the dataset?
any_na(student_long_dataset_imputed)

# How many?
n_miss(student_long_dataset_imputed)

# What is the percentage of missing data in the entire dataset?
prop_miss(student_long_dataset_imputed)

# How many missing values does each variable have?
student_long_dataset_imputed %>% is.na() %>% colSums()

# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(student_long_dataset_imputed)

# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(student_long_dataset_imputed)

# Which variables contain the most missing values?
gg_miss_var(student_long_dataset_imputed)

# We require the "ggplot2" package to create more appealing visualizations

# Where are missing values located (the shaded regions in the plot)?
vis_miss(student_long_dataset_imputed) + theme(axis.text.x = element_text(angle = 80))

# Which combinations of variables are missing together?

# Note: The following command should give you an error stating that at least 2
# variables should have missing data for the plot to be created.
gg_miss_upset(student_long_dataset_imputed)


# We can also create a heatmap of "missingness" broken down by "class_group"
# First, confirm that the "class_group" variable is a categorical variable
is.factor(student_long_dataset_imputed$class_group)
# Second, create the visualization
gg_miss_fct(student_long_dataset_imputed, fct = class_group)
