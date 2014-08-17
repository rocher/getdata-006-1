# Code Book

Observations:

  - All variables are `numeric` in the range `[-1, 1]`, except the last two
    factors.

  - Factors are:

    + *subject*, in the range `[1, 30]`

    + *activity* is a string. Possible values are `WALKING`, `WALKING_UPSTAIRS`,
      `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING` or `LAYING`

  - Variables 61-66: I have not enough information to write a valid description,
    market with `(?)`

This table describes all the variables included in the tidy data set:

 num | Variable name               | Domain | Descriptor | Units  | Description
----:|:----------------------------|:------:|:----------:|:-------|:----------------------------------------------------
   1 | t_mean_Body_Acc_X           |  time  |    mean    | m/s²   | Mean body acceleration in the X direction
   2 | t_mean_Body_Acc_Y           |  time  |    mean    | m/s²   | Mean body acceleration in the Y direction
   3 | t_mean_Body_Acc_Z           |  time  |    mean    | m/s²   | Mean body acceleration in the Z direction
   4 | t_std_Body_Acc_X            |  time  |     SD     | m/s²   | Standard deviation of body acceleration in the X direction
   5 | t_std_Body_Acc_Y            |  time  |     SD     | m/s²   | Standard deviation of body acceleration in the Y direction
   6 | t_std_Body_Acc_Z            |  time  |     SD     | m/s²   | Standard deviation of body acceleration in the Z direction
   7 | t_mean_Gravity_Acc_X        |  time  |    mean    | m/s²   | Mean gravity acceleration in the X direction
   8 | t_mean_Gravity_Acc_Y        |  time  |    mean    | m/s²   | Mean gravity acceleration in the Y direction
   9 | t_mean_Gravity_Acc_Z        |  time  |    mean    | m/s²   | Mean gravity acceleration in the Z direction
  10 | t_std_Gravity_Acc_X         |  time  |     SD     | m/s²   | Standard deviation of gravity acceleration in the X direction
  11 | t_std_Gravity_Acc_Y         |  time  |     SD     | m/s²   | Standard deviation of gravity acceleration in the Y direction
  12 | t_std_Gravity_Acc_Z         |  time  |     SD     | m/s²   | Standard deviation of gravity acceleration in the Z direction
  13 | t_mean_Body_AccJerk_X       |  time  |    mean    | m/s³   | Mean body jerk in the X direction
  14 | t_mean_Body_AccJerk_Y       |  time  |    mean    | m/s³   | Mean body jerk in the Y direction
  15 | t_mean_Body_AccJerk_Z       |  time  |    mean    | m/s³   | Mean body jerk in the Z direction
  16 | t_std_Body_AccJerk_X        |  time  |     SD     | m/s³   | Standard deviation of body jerk in the X direction
  17 | t_std_Body_AccJerk_Y        |  time  |     SD     | m/s³   | Standard deviation of body jerk in the Y direction
  18 | t_std_Body_AccJerk_Z        |  time  |     SD     | m/s³   | Standard deviation of body jerk in the Z direction
  19 | t_mean_Body_Gyro_X          |  time  |    mean    | rad/s  | Mean angular velocity of body in the X direction
  20 | t_mean_Body_Gyro_Y          |  time  |    mean    | rad/s  | Mean angular velocity of body in the Y direction
  21 | t_mean_Body_Gyro_Z          |  time  |    mean    | rad/s  | Mean angular velocity of body in the Z direction
  22 | t_std_Body_Gyro_X           |  time  |     SD     | rad/s  | Standard deviation of angular velocity of body in the X direction
  23 | t_std_Body_Gyro_Y           |  time  |     SD     | rad/s  | Standard deviation of angular velocity of body in the Y direction
  24 | t_std_Body_Gyro_Z           |  time  |     SD     | rad/s  | Standard deviation of angular velocity of body in the Z direction
  25 | t_mean_Body_GyroJerk_X      |  time  |    mean    | rad/s² | Mean angular acceleration of body in the X direction
  26 | t_mean_Body_GyroJerk_Y      |  time  |    mean    | rad/s² | Mean angular acceleration of body in the Y direction
  27 | t_mean_Body_GyroJerk_Z      |  time  |    mean    | rad/s² | Mean angular acceleration of body in the Z direction
  28 | t_std_Body_GyroJerk_X       |  time  |     SD     | rad/s² | Standard deviation of angular acceleration of body in the X direction
  29 | t_std_Body_GyroJerk_Y       |  time  |     SD     | rad/s² | Standard deviation of angular acceleration of body in the Y direction
  30 | t_std_Body_GyroJerk_Z       |  time  |     SD     | rad/s² | Standard deviation of angular acceleration of body in the Z direction
  31 | t_mean_Body_AccMag          |  time  |    mean    | m/s²   | Mean acceleration magnitude of body
  32 | t_std_Body_AccMag           |  time  |     SD     | m/s²   | Standard deviation of acceleration magnitude of body
  33 | t_mean_Gravity_AccMag       |  time  |    mean    | m/s²   | Mean acceleration magnitude of gravity
  34 | t_std_Gravity_AccMag        |  time  |     SD     | m/s²   | Standard deviation of acceleration magnitude of gravity
  35 | t_mean_Body_AccJerkMag      |  time  |    mean    | m/s³   | Mean jerk magnitude of body
  36 | t_std_Body_AccJerkMag       |  time  |     SD     | m/s³   | Standard deviation of jerk magnitude of body
  37 | t_mean_Body_GyroMag         |  time  |    mean    | rad/s  | Mean angular velocity magnitude of body
  38 | t_std_Body_GyroMag          |  time  |     SD     | rad/s  | standard deviation of angular velocity of body
  39 | t_mean_Body_GyroJerkMag     |  time  |    mean    | rad/s² | Mean angular acceleration magnitude of body
  40 | t_std_Body_GyroJerkMag      |  time  |     SD     | rad/s² | Standard deviation of acceleration magnitude of body
  41 | f_mean_Body_Acc_X           |  freq  |    mean    | Hz     | FFT of measurement 1
  42 | f_mean_Body_Acc_Y           |  freq  |     SD     | Hz     | FFT of measurement 2
  43 | f_mean_Body_Acc_Z           |  freq  |    mean    | Hz     | FFT of measurement 3
  44 | f_std_Body_Acc_X            |  freq  |     SD     | Hz     | FFT of measurement 4
  45 | f_std_Body_Acc_Y            |  freq  |     SD     | Hz     | FFT of measurement 5
  46 | f_std_Body_Acc_Z            |  freq  |     SD     | Hz     | FFT of measurement 6
  47 | f_mean_Body_AccJerk_X       |  freq  |    mean    | Hz     | FFT of measurement 13
  48 | f_mean_Body_AccJerk_Y       |  freq  |    mean    | Hz     | FFT of measurement 14
  49 | f_mean_Body_AccJerk_Z       |  freq  |    mean    | Hz     | FFT of measurement 15
  50 | f_std_Body_AccJerk_X        |  freq  |     SD     | Hz     | FFT of measurement 16
  51 | f_std_Body_AccJerk_Y        |  freq  |     SD     | Hz     | FFT of measurement 17
  52 | f_std_Body_AccJerk_Z        |  freq  |     SD     | Hz     | FFT of measurement 18
  53 | f_mean_Body_Gyro_X          |  freq  |    mean    | Hz     | FFT of measurement 19
  54 | f_mean_Body_Gyro_Y          |  freq  |    mean    | Hz     | FFT of measurement 20
  55 | f_mean_Body_Gyro_Z          |  freq  |    mean    | Hz     | FFT of measurement 21
  56 | f_std_Body_Gyro_X           |  freq  |     SD     | Hz     | FFT of measurement 22
  57 | f_std_Body_Gyro_Y           |  freq  |     SD     | Hz     | FFT of measurement 23
  58 | f_std_Body_Gyro_Z           |  freq  |     SD     | Hz     | FFT of measurement 24
  59 | f_mean_Body_AccMag          |  freq  |    mean    | Hz     | FFT of measurement 31
  60 | f_std_Body_AccMag           |  freq  |     SD     | Hz     | FFT of measurement 32
  61 | f_mean_Body_BodyAccJerkMag  |  freq  |    mean    | Hz     | FFT (?)
  62 | f_std_Body_BodyAccJerkMag   |  freq  |     SD     | Hz     | FFT (?)
  63 | f_mean_Body_BodyGyroMag     |  freq  |    mean    | Hz     | FFT (?)
  64 | f_std_Body_BodyGyroMag      |  freq  |     SD     | Hz     | FFT (?)
  65 | f_mean_Body_BodyGyroJerkMag |  freq  |    mean    | Hz     | FFT (?)
  66 | f_std_Body_BodyGyroJerkMag  |  freq  |     SD     | Hz     | FFT (?)
  67 | subject                     |        |            |        | The ID of the subject performing the activity
  68 | activity                    |        |            |        | The name of the activity performed


<br>
---
The original data set is copyright of its authors:
> *Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.*
> **Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.**
> International Workshop of Ambient Assisted Living (IWAAL 2012).
> Vitoria-Gasteiz, Spain. Dec 2012

<!--
Local Variables:
mode: markdown
mode: flyspell
End:
-->
