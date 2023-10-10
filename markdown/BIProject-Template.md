Business Intelligence Project
================
<Champions>
\<08/10/2023\>

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Downloading the Dataset](#downloading-the-dataset)
    - [Source:](#source)
    - [Reference:](#reference)
- [STEP 1 : Install and load all the
  packages](#step-1--install-and-load-all-the-packages)
  - [Loading the Dataset](#loading-the-dataset)
- [STEP 2: Create a subset of the
  variables/features](#step-2-create-a-subset-of-the-variablesfeatures)
- [STEP 3: Confirm the “missingness” in the Dataset before
  Imputation](#step-3-confirm-the-missingness-in-the-dataset-before-imputation)
- [STEP 4. Use the MICE package to perform data
  imputation](#step-4-use-the-mice-package-to-perform-data-imputation)
- [STEP 5. Confirm the “missingness” in the Imputed
  Dataset](#step-5-confirm-the-missingness-in-the-imputed-dataset)

# Student Details

<table style="width:99%;">
<colgroup>
<col style="width: 65%" />
<col style="width: 33%" />
</colgroup>
<tbody>
<tr class="odd">
<td><strong>Student ID Number</strong></td>
<td><p>134111</p>
<p>133996</p>
<p>126761</p>
<p>135859</p>
<p>127707</p></td>
</tr>
<tr class="even">
<td><strong>Student Name</strong></td>
<td><p>Juma Immaculate Haayo</p>
<p>Trevor Ngugi</p>
<p>Virginia Wanjiru</p>
<p>Pauline Wang’ombe</p>
<p>Clarice Gitonga</p></td>
</tr>
<tr class="odd">
<td><strong>BBIT 4.2 Group</strong></td>
<td>B</td>
</tr>
<tr class="even">
<td><strong>BI Project Group Name/ID (if applicable)</strong></td>
<td>Champions</td>
</tr>
</tbody>
</table>

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

# Understanding the Dataset (Exploratory Data Analysis (EDA))

## Downloading the Dataset

### Source:

The dataset that was used can be downloaded here:
*\<<https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>\>*

### Reference:

*\<Omondi,A.(2023).20230412-20230719-BI1-BBIT4-StudentPerformanceDataset.https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

# STEP 1 : Install and load all the packages

We installed all the packages that will enable us execute this lab.

``` r
## dplyr ----
if (!is.element("dplyr", installed.packages()[, 1])) {
  install.packages("dplyr", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("dplyr")
```

    ## Loading required package: dplyr

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
## naniar ----
# Documentation:
#   https://cran.r-project.org/package=naniar or
#   https://www.rdocumentation.org/packages/naniar/versions/1.0.0
if (!is.element("naniar", installed.packages()[, 1])) {
  install.packages("naniar", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("naniar")
```

    ## Loading required package: naniar

``` r
## ggplot2 ----
# We require the "ggplot2" package to create more appealing visualizations
if (!is.element("ggplot2", installed.packages()[, 1])) {
  install.packages("ggplot2", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("ggplot2")
```

    ## Loading required package: ggplot2

``` r
## MICE ----
# We use the MICE package to perform data imputation
if (!is.element("mice", installed.packages()[, 1])) {
  install.packages("mice", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("mice")
```

    ## Loading required package: mice

    ## 
    ## Attaching package: 'mice'

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following objects are masked from 'package:base':
    ## 
    ##     cbind, rbind

``` r
## Amelia ----
if (!is.element("Amelia", installed.packages()[, 1])) {
  install.packages("Amelia", dependencies = TRUE,
                   repos = "https://cloud.r-project.org")
}
require("Amelia")
```

    ## Loading required package: Amelia

    ## Loading required package: Rcpp

    ## ## 
    ## ## Amelia II: Multiple Imputation
    ## ## (Version 1.8.1, built: 2022-11-18)
    ## ## Copyright (C) 2005-2023 James Honaker, Gary King and Matthew Blackwell
    ## ## Refer to http://gking.harvard.edu/amelia/ for more information
    ## ##

## Loading the Dataset

``` r
student_performance_dataset <-
  readr::read_csv(
    "../data/student_performance_dataset.csv", # nolint
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
```

# STEP 2: Create a subset of the variables/features

We created a subset of the variables to be included in the new
dataset.We proceeded to rename the variables to read off white spaces in
the variable names.

``` r
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

# rename columns
student_long_dataset3 <-plyr::rename(student_long_dataset, c("Quiz 5 on Concept 5 (Dashboarding) x/10"="quiz5",
                                      "Quiz 4 on Concept 4 (Non-Linear) x/22"="quiz4",
                                      "Lab 2 - 2.e. -  (Linear Regression using Gradient Descent) x/5"="lab2",
                                      "CAT 1 (8%): x/38 x 100"="cat1",
                                      "EXAM: x/60 (60%)"="exam",
                                      "Lab 1 - 2.c. - (Simple Linear Regression) x/5"="lab1",
                                      "Quiz 3 on Concept 3 (Linear) x/15"="quiz3",
                                      "Lab 3 - 2.g. - (Logistic Regression using Gradient Descent) x/5"="lab3"))
```

# STEP 3: Confirm the “missingness” in the Dataset before Imputation

``` r
# Are there missing values in the dataset?
any_na(student_long_dataset3)
```

    ## [1] TRUE

``` r
# How many?
n_miss(student_long_dataset3)
```

    ## [1] 46

``` r
# What is the percentage of missing data in the entire dataset?
prop_miss(student_long_dataset3)
```

    ## [1] 0.04554455

``` r
# How many missing values does each variable have?
student_long_dataset3 %>% is.na() %>% colSums()
```

    ##      gender       quiz5        lab3       quiz4        lab2        cat1 
    ##           0          12           9           6           6           4 
    ##        exam        lab1       quiz3 class_group 
    ##           4           3           2           0

``` r
# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(student_long_dataset3)
```

    ## # A tibble: 10 × 3
    ##    variable    n_miss pct_miss
    ##    <chr>        <int>    <dbl>
    ##  1 quiz5           12    11.9 
    ##  2 lab3             9     8.91
    ##  3 quiz4            6     5.94
    ##  4 lab2             6     5.94
    ##  5 cat1             4     3.96
    ##  6 exam             4     3.96
    ##  7 lab1             3     2.97
    ##  8 quiz3            2     1.98
    ##  9 gender           0     0   
    ## 10 class_group      0     0

``` r
# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(student_long_dataset3)
```

    ## # A tibble: 101 × 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1     3      4       40
    ##  2    11      4       40
    ##  3    14      3       30
    ##  4    36      3       30
    ##  5    66      3       30
    ##  6     9      2       20
    ##  7    16      2       20
    ##  8    51      2       20
    ##  9    56      2       20
    ## 10    79      2       20
    ## # ℹ 91 more rows

``` r
# Which variables contain the most missing values?
gg_miss_var(student_long_dataset3)
```

![](BIProject-Template_files/figure-gfm/Your%20fourth%20Code%20Chunk-1.png)<!-- -->

``` r
# Where are missing values located (the shaded regions in the plot)?
vis_miss(student_long_dataset3) + theme(axis.text.x = element_text(angle = 80))
```

![](BIProject-Template_files/figure-gfm/Your%20fourth%20Code%20Chunk-2.png)<!-- -->

``` r
# Which combinations of variables are missing together?
gg_miss_upset(student_long_dataset3)
```

![](BIProject-Template_files/figure-gfm/Your%20fourth%20Code%20Chunk-3.png)<!-- -->

``` r
# Create a heatmap of "missingness" broken down by "AgeDecade"
# First, confirm that the "AgeDecade" variable is a categorical variable
is.factor(student_long_dataset3$class_group)
```

    ## [1] TRUE

``` r
# Second, create the visualization
gg_miss_fct(student_long_dataset3, fct = class_group)
```

![](BIProject-Template_files/figure-gfm/Your%20fourth%20Code%20Chunk-4.png)<!-- -->

``` r
# We can also create a heatmap of "missingness" broken down by "gender"
# First, confirm that the "Depressed" variable is a categorical variable
is.factor(student_long_dataset3$gender)
```

    ## [1] TRUE

``` r
# Second, create the visualization
gg_miss_fct(student_long_dataset3, fct = gender)
```

![](BIProject-Template_files/figure-gfm/Your%20fourth%20Code%20Chunk-5.png)<!-- -->

# STEP 4. Use the MICE package to perform data imputation

``` r
# We can use the dplyr::mutate() function inside the dplyr package to add new
# variables that are functions of existing variables


# We finally begin to make use of Multivariate Imputation by Chained
# Equations (MICE). We use 11 multiple imputations.

# To arrive at good predictions for each variable containing missing values, we
# save the variables that are at least "somewhat correlated" (r > 0.3).

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
```

    ## 
    ##  iter imp variable
    ##   1   1  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   2  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   3  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   4  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   5  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   6  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   7  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   8  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   9  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   10  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   1   11  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   1  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   2  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   3  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   4  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   5  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   6  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   7  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   8  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   9  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   10  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   2   11  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   1  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   2  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   3  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   4  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   5  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   6  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   7  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   8  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   9  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   10  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   3   11  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   1  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   2  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   3  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   4  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   5  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   6  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   7  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   8  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   9  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   10  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   4   11  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   1  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   2  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   3  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   4  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   5  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   6  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   7  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   8  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   9  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   10  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3
    ##   5   11  quiz5  lab3  quiz4  lab2  cat1  exam  lab1  quiz3

``` r
# We can use multiple scatter plots (a.k.a. strip-plots) to visualize how
# random the imputed data is in each of the 11 datasets.


stripplot(student_dataset_mice,
          quiz3 ~ quiz5 | .imp,
          pch = 20, cex = 1)
```

![](BIProject-Template_files/figure-gfm/Your%20fifth%20Code%20Chunk-1.png)<!-- -->

``` r
stripplot(student_dataset_mice,
          exam ~ quiz5 | .imp,
          pch = 20, cex = 1)
```

![](BIProject-Template_files/figure-gfm/Your%20fifth%20Code%20Chunk-2.png)<!-- -->

``` r
## Impute the missing data ----
# We then create imputed data for the final dataset using the mice::complete()
# function in the mice package to fill in the missing data.
students_dataset_imputed <- mice::complete(student_dataset_mice, 1)
```

# STEP 5. Confirm the “missingness” in the Imputed Dataset

``` r
# A textual confirmation that the dataset has no more missing values in any
# feature:
miss_var_summary(students_dataset_imputed)
```

    ## # A tibble: 10 × 3
    ##    variable    n_miss pct_miss
    ##    <chr>        <int>    <dbl>
    ##  1 gender           0        0
    ##  2 quiz5            0        0
    ##  3 lab3             0        0
    ##  4 quiz4            0        0
    ##  5 lab2             0        0
    ##  6 cat1             0        0
    ##  7 exam             0        0
    ##  8 lab1             0        0
    ##  9 quiz3            0        0
    ## 10 class_group      0        0

``` r
# A visual confirmation that the dataset has no more missing values in any
# feature:
Amelia::missmap(students_dataset_imputed)
```

![](BIProject-Template_files/figure-gfm/Your%20sixth%20Code%20Chunk-1.png)<!-- -->

``` r
#########################
# Are there missing values in the dataset?
any_na(students_dataset_imputed)
```

    ## [1] FALSE

``` r
# How many?
n_miss(students_dataset_imputed)
```

    ## [1] 0

``` r
# What is the percentage of missing data in the entire dataset?
prop_miss(students_dataset_imputed)
```

    ## [1] 0

``` r
# How many missing values does each variable have?
students_dataset_imputed %>% is.na() %>% colSums()
```

    ##      gender       quiz5        lab3       quiz4        lab2        cat1 
    ##           0           0           0           0           0           0 
    ##        exam        lab1       quiz3 class_group 
    ##           0           0           0           0

``` r
# What is the number and percentage of missing values grouped by
# each variable?
miss_var_summary(students_dataset_imputed)
```

    ## # A tibble: 10 × 3
    ##    variable    n_miss pct_miss
    ##    <chr>        <int>    <dbl>
    ##  1 gender           0        0
    ##  2 quiz5            0        0
    ##  3 lab3             0        0
    ##  4 quiz4            0        0
    ##  5 lab2             0        0
    ##  6 cat1             0        0
    ##  7 exam             0        0
    ##  8 lab1             0        0
    ##  9 quiz3            0        0
    ## 10 class_group      0        0

``` r
# What is the number and percentage of missing values grouped by
# each observation?
miss_case_summary(students_dataset_imputed)
```

    ## # A tibble: 101 × 3
    ##     case n_miss pct_miss
    ##    <int>  <int>    <dbl>
    ##  1     1      0        0
    ##  2     2      0        0
    ##  3     3      0        0
    ##  4     4      0        0
    ##  5     5      0        0
    ##  6     6      0        0
    ##  7     7      0        0
    ##  8     8      0        0
    ##  9     9      0        0
    ## 10    10      0        0
    ## # ℹ 91 more rows

``` r
# Which variables contain the most missing values?
gg_miss_var(students_dataset_imputed)
```

![](BIProject-Template_files/figure-gfm/Your%20sixth%20Code%20Chunk-2.png)<!-- -->

``` r
# We require the "ggplot2" package to create more appealing visualizations

# Where are missing values located (the shaded regions in the plot)?
vis_miss(students_dataset_imputed) + theme(axis.text.x = element_text(angle = 80))
```

![](BIProject-Template_files/figure-gfm/Your%20sixth%20Code%20Chunk-3.png)<!-- -->

``` r
# Which combinations of variables are missing together?



# Create a heatmap of "missingness" broken down by "class_group"
# First, confirm that the "class_group" variable is a categorical variable
is.factor(students_dataset_imputed$class_group)
```

    ## [1] TRUE

``` r
# Second, create the visualization
gg_miss_fct(students_dataset_imputed, fct = class_group)
```

![](BIProject-Template_files/figure-gfm/Your%20sixth%20Code%20Chunk-4.png)<!-- -->
