# macOSUITesting
Sendbox with macOS UI Testing template using Xcode 8.3.2

## Technical Demo

Application Test Target contains set of tools which are helpfull for macOS UI autotesting:

<img width="250" alt="screen shot 2017-06-11 at 12 58 48 pm" src="https://user-images.githubusercontent.com/3168299/27010154-b5536bee-4ea6-11e7-95e1-8395b5eb5273.png">

This categories incapsulate basic routines for UI.

Target UI is simple, the only purpose was to show how test target interacts with application:

<img width="1045" alt="screen shot 2017-06-11 at 12 59 53 pm" src="https://user-images.githubusercontent.com/3168299/27010195-681eb65c-4ea7-11e7-817b-f38786a9dffb.png">

## Basic steps

The most important part of UI testing is setting accessibility identifiers for elements which need to be tracked during test execution.
So, firstly, create separate header and populate it with ids:

<img width="485" alt="screen shot 2017-06-11 at 1 00 19 pm" src="https://user-images.githubusercontent.com/3168299/27010216-ea7e5904-4ea7-11e7-9898-b1e1ba313bbe.png">

Secondly, setup this ids in your code (the same could be done via UI):

<img width="470" alt="screen shot 2017-06-11 at 1 00 12 pm" src="https://user-images.githubusercontent.com/3168299/27010208-b46e95c2-4ea7-11e7-8c4f-f40b64f56bce.png">

After this steps application is ready to be covered by UI tests. So, add tests for Your application under test target:

<img width="762" alt="screen shot 2017-06-11 at 12 59 09 pm" src="https://user-images.githubusercontent.com/3168299/27010225-1d99e79a-4ea8-11e7-8b25-f2ec4df0d8a0.png">

For more details, please clone this project and investigate "Core" categories implementation.

## CI integration

For best experience, UI tests should be executed automatically via CI system. This demo also includes basic bash script,
which can handle various test target argument and launch/test application via xcodebuild tool.

Example, how to use run_test.sh: 

bash ./run_test.sh ~/Path_to_application_sources -t testLogin

## Instalation

1. Download from the GitHub
2. Launch SSUITestSendox.xcodeproj with Xcode 8.3.2
3. Choose SSUITestSendoxUITests.m
4. Press launch button for test You want to be executed
5. Enjoy!
