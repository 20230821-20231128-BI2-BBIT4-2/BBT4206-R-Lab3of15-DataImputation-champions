Business Intelligence Project
================
<Champions>
\<08/10/2023\>

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)
- [Understanding the Dataset (Exploratory Data Analysis
  (EDA))](#understanding-the-dataset-exploratory-data-analysis-eda)
  - [Loading the Dataset](#loading-the-dataset)
    - [Source:](#source)
    - [Reference:](#reference)
  - [Loading the Dataset](#loading-the-dataset-1)
  - [Step 2: Create a subset of the
    variables/features](#step-2-create-a-subset-of-the-variablesfeatures)

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

## Loading the Dataset

student_performance_dataset \<-

readr::read_csv(

“data/student_performance_dataset.csv”, \# nolint

col_types =

readr::cols(

class_group =

readr::col_factor(levels = c(“A”, “B”, “C”)),

gender = readr::col_factor(levels = c(“1”, “0”)),

YOB = readr::col_date(format = “%Y”),

regret_choosing_bi =

readr::col_factor(levels = c(“1”, “0”)),

drop_bi_now =

readr::col_factor(levels = c(“1”, “0”)),

motivator =

readr::col_factor(levels = c(“1”, “0”)),

read_content_before_lecture =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

anticipate_test_questions =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

answer_rhetorical_questions =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

find_terms_I_do_not_know =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

copy_new_terms_in_reading_notebook =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

take_quizzes_and_use_results =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

reorganise_course_outline =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

write_down_important_points =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

space_out_revision =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

studying_in_study_group =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

schedule_appointments =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

goal_oriented =

readr::col_factor(levels =

c(“1”, “0”)),

spaced_repetition =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

testing_and_active_recall =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

interleaving =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

categorizing =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

retrospective_timetable =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

cornell_notes =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

sq3r = readr::col_factor(levels =

c(“1”, “2”, “3”, “4”)),

commute = readr::col_factor(levels =

c(“1”, “2”,

“3”, “4”)),

study_time = readr::col_factor(levels =

c(“1”, “2”,

“3”, “4”)),

repeats_since_Y1 = readr::col_integer(),

paid_tuition = readr::col_factor(levels =

c(“0”, “1”)),

free_tuition = readr::col_factor(levels =

c(“0”, “1”)),

extra_curricular = readr::col_factor(levels =

c(“0”, “1”)),

sports_extra_curricular =

readr::col_factor(levels = c(“0”, “1”)),

exercise_per_week = readr::col_factor(levels =

c(“0”, “1”,

“2”,

“3”)),

meditate = readr::col_factor(levels =

c(“0”, “1”,

“2”, “3”)),

pray = readr::col_factor(levels =

c(“0”, “1”,

“2”, “3”)),

internet = readr::col_factor(levels =

c(“0”, “1”)),

laptop = readr::col_factor(levels = c(“0”, “1”)),

family_relationships =

readr::col_factor(levels =

c(“1”, “2”, “3”, “4”, “5”)),

friendships = readr::col_factor(levels =

c(“1”, “2”, “3”,

“4”, “5”)),

romantic_relationships =

readr::col_factor(levels =

c(“0”, “1”, “2”, “3”, “4”)),

spiritual_wellnes =

readr::col_factor(levels = c(“1”, “2”, “3”,

“4”, “5”)),

financial_wellness =

readr::col_factor(levels = c(“1”, “2”, “3”,

“4”, “5”)),

health = readr::col_factor(levels = c(“1”, “2”,

“3”, “4”,

“5”)),

day_out = readr::col_factor(levels = c(“0”, “1”,

“2”, “3”)),

night_out = readr::col_factor(levels = c(“0”,

“1”, “2”,

“3”)),

alcohol_or_narcotics =

readr::col_factor(levels = c(“0”, “1”, “2”, “3”)),

mentor = readr::col_factor(levels = c(“0”, “1”)),

mentor_meetings = readr::col_factor(levels =

c(“0”, “1”,

“2”, “3”)),

\`Attendance Waiver Granted: 1 = Yes, 0 = No\` =

readr::col_factor(levels = c(“0”, “1”)),

GRADE = readr::col_factor(levels =

c(“A”, “B”, “C”, “D”,

“E”))),

locale = readr::locale())

### Source:

The dataset that was used can be downloaded here:
*\<<https://drive.google.com/drive/folders/1-BGEhfOwquXF6KKXwcvrx7WuZXuqmW9q?usp=sharing>\>*

### Reference:

*\<Cite the dataset here using APA\>  
Refer to the APA 7th edition manual for rules on how to cite datasets:
<https://apastyle.apa.org/style-grammar-guidelines/references/examples/data-set-references>*

## Loading the Dataset

``` student_performance_dataset

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
```

## Step 2: Create a subset of the variables/features

We created a subset of the variables to be included in the new
dataset.We proceeded to rename the variables to read off white spaces in
the variable names.
