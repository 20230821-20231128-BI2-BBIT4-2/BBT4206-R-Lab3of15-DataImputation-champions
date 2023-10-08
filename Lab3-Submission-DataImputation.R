# *****************************************************************************
# Lab 3: Data Imputation ----
#
# Course Code: BBT4206
# Course Name: Business Intelligence II
# Semester Duration: 21st August 2023 to 28th November 2023
#
# Lecturer: Allan Omondi
# Contact: aomondi_at_strathmore_dot_edu
#
# Note: The lecture contains both theory and practice. This file forms part of
#       the practice. It has required lab work submissions that are graded for
#       coursework marks.
#
# License: GNU GPL-3.0-or-later
# See LICENSE file for licensing information.
# *****************************************************************************


# **[OPTIONAL] Initialization: Install and use renv ----
# The R Environment ("renv") package helps you create reproducible environments
# for your R projects. This is helpful when working in teams because it makes
# your R projects more isolated, portable and reproducible.

# Further reading:
#   Summary: https://rstudio.github.io/renv/
#   More detailed article: https://rstudio.github.io/renv/articles/renv.html

# "renv" It can be installed as follows:
# if (!is.element("renv", installed.packages()[, 1])) {
# install.packages("renv", dependencies = TRUE,
# repos = "https://cloud.r-project.org") # nolint
# }
# require("renv") # nolint

# Once installed, you can then use renv::init() to initialize renv in a new
# project.

# The prompt received after executing renv::init() is as shown below:
# This project already has a lockfile. What would you like to do?

# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.

# Select option 1 to restore the project from the lockfile
# renv::init() # nolint

# This will set up a project library, containing all the packages you are
# currently using. The packages (and all the metadata needed to reinstall
# them) are recorded into a lockfile, renv.lock, and a .Rprofile ensures that
# the library is used every time you open the project.

# Consider a library as the location where packages are stored.
# Execute the following command to list all the libraries available in your
# computer:
.libPaths()

# One of the libraries should be a folder inside the project if you are using
# renv

# Then execute the following command to see which packages are available in
# each library:
lapply(.libPaths(), list.files)

# This can also be configured using the RStudio GUI when you click the project
# file, e.g., "BBT4206-R.Rproj" in the case of this project. Then
# navigate to the "Environments" tab and select "Use renv with this project".

# As you continue to work on your project, you can install and upgrade
# packages, using either:
# install.packages() and update.packages or
# renv::install() and renv::update()

# You can also clean up a project by removing unused packages using the
# following command: renv::clean()

# After you have confirmed that your code works as expected, use
# renv::snapshot(), AT THE END, to record the packages and their
# sources in the lockfile.

# Later, if you need to share your code with someone else or run your code on
# a new machine, your collaborator (or you) can call renv::restore() to
# reinstall the specific package versions recorded in the lockfile.

# [OPTIONAL]
# Execute the following code to reinstall the specific package versions
# recorded in the lockfile (restart R after executing the command):
# renv::restore() # nolint

# [OPTIONAL]
# If you get several errors setting up renv and you prefer not to use it, then
# you can deactivate it using the following command (restart R after executing
# the command):
# renv::deactivate() # nolint

# If renv::restore() did not install the "languageserver" package (required to
# use R for VS Code), then it can be installed manually as follows (restart R
# after executing the command):

if (!is.element("languageserver", installed.packages()[, 1])) {
  install.packages("languageserver", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("languageserver")

# Introduction ----
# Data imputation, also known as missing data imputation, is a technique used
# in data analysis and statistics to fill in missing values in a dataset.
# Missing data can occur due to various reasons, such as equipment malfunction,
# human error, or non-response in surveys.

# Imputing missing data is important because many statistical analysis methods
# and Machine Learning algorithms require complete datasets to produce accurate
# and reliable results. By filling in the missing values, data imputation helps
# to preserve the integrity and usefulness of the dataset.

## Data Imputation Methods ----

### 1. Mean/Median Imputation ----

# This method involves replacing missing values with the mean or median value
# of the available data for that variable. It is a simple and quick approach
# but does not consider any relationships between variables.

# Unlike the recorded values, mean-imputed values do not include natural
# variance. Therefore, they are less “scattered” and would technically minimize
# the standard error in a linear regression. We would perceive our estimates to
# be more accurate than they actually are in real-life.

### 2. Regression Imputation ----
# In this approach, missing values are estimated by regressing the variable
# with missing values on other variables that are known. The estimated values
# are then used to fill in the missing values.

### 3. Multiple Imputation ----
# Multiple imputation involves creating several plausible imputations for each
# missing value based on statistical models that capture the relationships
# between variables. This technique recognizes the uncertainty associated with
# imputing missing values.

### 4. Machine Learning-Based Imputation ----
# Machine learning algorithms can be used to predict missing values based on
# the patterns and relationships present in the available data. Techniques such
# as K-Nearest Neighbours (KNN) imputation or decision tree-based imputation can
# be employed.

### 5. Hot Deck Imputation ----
# This method involves finding similar cases (referred to as donors) that have
# complete data and using their values to impute missing values in other cases
# (referred to as recipients).

### 6. Multiple Imputation by Chained Equations (MICE) ----
# MICE is flexible and can handle different variable types at once (e.g.,
# continuous, binary, ordinal etc.). For each variable containing missing
# values, we can use the remaining information in the data to train a model
# that predicts what could have been recorded to fill in the blanks.
# To account for the statistical uncertainty in the imputations, the MICE
# procedure goes through several rounds and computes replacements for missing
# values in each round. As the name suggests, we thus fill in the missing
# values multiple times and create several complete datasets before we pool the
# results to arrive at more realistic results.

## Types of Missing Data ----
### 1. Missing Not At Random (MNAR) ----
# Locations of missing values in the dataset depend on the missing values
# themselves. For example, students submitting a course evaluation tend to
# report positive or neutral responses and skip questions that will result in a
# negative response. Such students may systematically leave the following
# question blank because they are uncomfortable giving a bad rating for their
# lecturer: “Classes started and ended on time”.

### 2. Missing At Random (MAR) ----
# Locations of missing values in the dataset depend on some other observed
# data. In the case of course evaluations, students who are not certain about a
# response may feel unable to give accurate responses on a numeric scale, for
# example, the question "I developed my oral and writing skills " may be
# difficult to measure on a scale of 1-5. Subsequently, if such questions are
# optional, they rarely get a response because it depends on another unobserved
# mechanism: in this case, the individual need for more precise
# self-assessments.

### 3. Missing Completely At Random (MCAR) ----
# In this case, the locations of missing values in the dataset are purely
# random and they do not depend on any other data.

# In all the above cases, removing the entire response  because one question
# has missing data may distort the results.

# If the data are MAR or MNAR, imputing missing values is advisable.

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

# STEP 2. Create a subset of the variables/features ----
# We select only the following 13 features to be included in the dataset:
nhanes_long_dataset <- NHANES %>%
  select(Age, AgeDecade, Education, Poverty, Work, LittleInterest, Depressed,
         BMI, Pulse, BPSysAve, BPDiaAve, DaysPhysHlthBad, PhysActiveDays)

#load dataset
student_performance_dataset <-
  readr::read_csv(
    "data/20230412-20230719-BI1-BBIT4-1-StudentPerformanceDataset.CSV", # nolint
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

student_long_dataset <- student_performance_dataset %>%
  
  select(gender,
        #`CAT 2 (8%): x/100 x 100`,`Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5`,
         `Quiz 5 on Concept 5 (Dashboarding) x/10`,
        `Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5`,
         `Quiz 4 on Concept 4 (Non-Linear) x/22`,
         `Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5`,
         `CAT 1 (8%): x/38 x 100`,
         `EXAM: x/60 (60%)`,
         `Lab 1 - 2.c. - (Simple Linear Regression) x/5`,
         `Quiz 3 on Concept 3 (Linear) x/15`,
         `class_group`,
         
         )

#rename columns
student_long_dataset3 <-plyr::rename(student_long_dataset, c("Quiz 5 on Concept 5 (Dashboarding) x/10"="quiz5",
                                      "Quiz 4 on Concept 4 (Non-Linear) x/22"="quiz4",
                                      "Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5"="lab2",
                                      "CAT 1 (8%): x/38 x 100"="cat1",
                                      "EXAM: x/60 (60%)"="exam",
                                      "Lab 1 - 2.c. - (Simple Linear Regression) x/5"="lab1",
                                      "Quiz 3 on Concept 3 (Linear) x/15"="quiz3",
                                      "Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5"="lab3"))


### Subset of rows ----
# We then select 500 random observations to be included in the dataset
# `CAT 2 (8%): x/100 x 100`,`Lab 4 - 2.h. - (Linear Discriminant Analysis) x/5`,
rand_ind <- sample(seq_len(nrow(nhanes_long_dataset)), 500)
nhanes_dataset <- nhanes_long_dataset[rand_ind, ]

# STEP 3. Confirm the "missingness" in the Dataset before Imputation ----
# Are there missing values in the dataset?
any_na(student_long_dataset3)


# How many?
n_miss(student_long_dataset3)

# What is the percentage of missing data in the entire dataset?
prop_miss(student_long_dataset3)

# How many missing values does each variable have?
student_long_dataset3 %>% is.na() %>% colSums()

# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(student_long_dataset3)

# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(student_long_dataset3)

# Which variables contain the most missing values?
gg_miss_var(student_long_dataset3)

# Where are missing values located (the shaded regions in the plot)?
vis_miss(student_long_dataset3) + theme(axis.text.x = element_text(angle = 80))

# Which combinations of variables are missing together?
gg_miss_upset(student_long_dataset3)

# Create a heatmap of "missingness" broken down by "AgeDecade"
# First, confirm that the "AgeDecade" variable is a categorical variable
is.factor(student_long_dataset3$class_group)
# Second, create the visualization
gg_miss_fct(student_long_dataset3, fct = class_group)

# We can also create a heatmap of "missingness" broken down by "gender"
# First, confirm that the "Depressed" variable is a categorical variable
is.factor(student_long_dataset3$gender)
# Second, create the visualization
gg_miss_fct(student_long_dataset3, fct = gender)



# STEP 4. Use the MICE package to perform data imputation ----
# We can use the dplyr::mutate() function inside the dplyr package to add new
# variables that are functions of existing variables

# In this case, it is used to create a new variable called,
# "Median Arterial Pressure (MAP)"
# Further reading:
#   https://en.wikipedia.org/wiki/Mean_arterial_pressure

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
somewhat_correlated_variables_std <- quickpred(student_long_dataset, mincor = 0.3) # nolint

somewhat_correlated_variables_std3 <- quickpred(student_long_dataset3, mincor = 0.3) # nolint

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
student_dataset_mice <- mice(student_long_dataset3, m = 11, method = "pmm",
                            seed = 7,
                            predictorMatrix = somewhat_correlated_variables_std3)

# One can then train a model to predict MAP using BMI and PhysActiveDays or to
# identify the p-Value and confidence intervals between MAP and BMI and
# PhysActiveDays

# We can use multiple scatter plots (a.k.a. strip-plots) to visualize how
# random the imputed data is in each of the 11 datasets.
stripplot(student_dataset_mice,
          `Quiz 5 on Concept 5 (Dashboarding) x/10`,`Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5` ~ `Quiz 4 on Concept 4 (Non-Linear) x/22` | .imp,
          pch = 20, cex = 1)

stripplot(student_dataset_mice,
          quiz3 ~ quiz5 | .imp,
          pch = 20, cex = 1)

stripplot(student_dataset_mice,
          exam ~ quiz5 | .imp,
          pch = 20, cex = 1)

## Impute the missing data ----
# We then create imputed data for the final dataset using the mice::complete()
# function in the mice package to fill in the missing data.
students_dataset_imputed <- mice::complete(student_dataset_mice, 1)

# STEP 5. Confirm the "missingness" in the Imputed Dataset ----
# A textual confirmation that the dataset has no more missing values in any
# feature:
miss_var_summary(students_dataset_imputed)

# A visual confirmation that the dataset has no more missing values in any
# feature:
Amelia::missmap(students_dataset_imputed)

#########################
# Are there missing values in the dataset?
any_na(students_dataset_imputed)

# How many?
n_miss(students_dataset_imputed)

# What is the percentage of missing data in the entire dataset?
prop_miss(students_dataset_imputed)

# How many missing values does each variable have?
students_dataset_imputed %>% is.na() %>% colSums()

# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(students_dataset_imputed)

# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(students_dataset_imputed)

# Which variables contain the most missing values?
gg_miss_var(students_dataset_imputed)

# We require the "ggplot2" package to create more appealing visualizations

# Where are missing values located (the shaded regions in the plot)?
vis_miss(students_dataset_imputed) + theme(axis.text.x = element_text(angle = 80))

# Which combinations of variables are missing together?

# Note: The following command should give you an error stating that at least 2
# variables should have missing data for the plot to be created.
gg_miss_upset(students_dataset_imputed)

# Create a heatmap of "missingness" broken down by "AgeDecade"
# First, confirm that the "AgeDecade" variable is a categorical variable
is.factor(students_dataset_imputed$class_group)
# Second, create the visualization
gg_miss_fct(students_dataset_imputed, fct = class_group)

# We can also create a heatmap of "missingness" broken down by "Depressed"
# First, confirm that the "Depressed" variable is a categorical variable
is.factor(nhanes_dataset_imputed$Depressed)
# Second, create the visualization
gg_miss_fct(nhanes_dataset_imputed, fct = Depressed)

# Additional Dataset for Practice (the Soybean dataset) ----
# An additional dataset that you can use to practice data imputation is the
# "Soybean" dataset for agriculture. It is available in the mlbench package.
# You can load it by executing the following code:

# if (!is.element("mlbench", installed.packages()[, 1])) {
#   install.packages("mlbench", dependencies = TRUE) # nolint
# }
# require("mlbench") # nolint
# data(Soybean) # nolint

# [OPTIONAL] **Deinitialization: Create a snapshot of the R environment ----
# Lastly, as a follow-up to the initialization step, record the packages
# installed and their sources in the lockfile so that other team-members can
# use renv::restore() to re-install the same package version in their local
# machine during their initialization step.
# renv::snapshot() # nolint

# References ----
## United States National Center for Health Statistics (NCHS). (2015). The United States National Health and Nutrition Examination Study (NHANES) (2.1.0) [Dataset]. The Comprehensive R Archive Network [CRAN]. https://cran.r-project.org/package=NHANES # nolint ----

# **Required Lab Work Submission** ----

## Part A ----
# Create a new file called
# "Lab3-Submission-DataImputation.R".
# Provide all the code you have used to perform data imputation on the
# "BI1 Student Performance" dataset provided in class. Perform ALL the data
# imputation steps that have been used in the
# "Lab3-DataImputation.R" file.

## Part B ----
# Upload *the link* to your
# "Lab3-Submission-DataImputation.R" hosted
# on Github (do not upload the .R file itself) through the submission link
# provided on eLearning.

## Part C ----
# Create a markdown file called
# "Lab3-Submission-DataImputation.Rmd"
# and place it inside the folder called "markdown".

## Part D ----
# Knit the R markdown file using knitR in R Studio.
# Upload *the link* to
# "Lab3-Submission-DataImputation.md"
# (not .Rmd) markdown file hosted on Github (do not upload the .Rmd or .md
# markdown files) through the submission link
# provided on eLearning.
