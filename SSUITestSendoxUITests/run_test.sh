#!/bin/bash -xve

programname=$0

function usage {
    echo "usage: $programname <APP_PATH> [-h] [-p xcodeproject] [-c class] [-t testcase] [-b <Debug | Release>]"
    echo "  APP_PATH            path to xcode project"
    echo "  -p                  xcodeproject name. By default fetched from from existing project inside APP_PATH. Testing target will have UITests suffix"
    echo "  -c                  class Name where tests will be run from. By default equals to xcodeproject name + UITests suffix (e.g. AppKineticsUITests)"
    echo "  -t                  testcase to run (e.g. testLogin). Ommit this option to run all tests."
    echo "  -b                  Build type"
    exit 1
}

# get_product_name
# get app name having path in format ..Samples/com.good.gd.example.${APP_NAME_lowercase}/APP_NAME.xcodeproj
# $1 path where xcode project is
# $2 name of variable where app name will be written
get_app_name()
{
    APP_PATH="$1"
    APP_NAME="$2"
    PROJECT_PATH=$(find "${APP_PATH}" -name '*.xcodeproj' -maxdepth 2)
    BASENAME=`basename "$PROJECT_PATH"`
    eval $APP_NAME="${BASENAME%%.*}"
}

# get_app_target
# gets target of specified app
# takes APP_NAME as an argument
# $1 path to an app
# $2 variable name where target name will be written
get_app_target()
{
    APP_PATH="$1"
    APP_TARGET="$2"
    PROJECT_PATH=$(find "${APP_PATH}" -name '*.xcodeproj' -maxdepth 2)
    BASENAME=`basename "$PROJECT_PATH"`
    APP_NAME="${BASENAME%%.*}"
    eval $APP_TARGET="${APP_NAME}UITests"
}

#Usage
if [[ $# -lt 1 ]]
    then
    usage
    exit 1
fi

#Convert long arguments to short one, so getopts can parse it later

APP_PATH="$1"
shift

BUILD_TYPE="Debug"
APP_TARGET=
APP_NAME=
TESTCASE=
CLASS=

#build default values from passed application's path
get_app_name "${APP_PATH}" 'APP_NAME'
get_app_target "${APP_PATH}" 'APP_TARGET'

#parse options
while getopts p:c:t:b: option
do
        case "${option}"
        in
            p) APP_NAME=${OPTARG}
               APP_TARGET="${APP_NAME}UITests";;
            c) CLASS=${OPTARG};;
            t) TESTCASE=${OPTARG};;
            b) BUILD_TYPE=${OPTARG};;
        esac
done

# if -c option is not provided, set default CLASS name
if [ -z ${CLASS} ]
then
  CLASS=$APP_TARGET
fi


echo 'Script arguments:'
echo APP_PATH $APP_PATH
echo APP_TARGET $APP_TARGET
echo APP_NAME $APP_NAME
echo CLASS $CLASS
echo TESTCASE $TESTCASE

XCODE_PROJ_PATH="${APP_PATH}/${APP_NAME}.xcodeproj"

DESTINATION="platform=OS X"
SDK_TYPE="macosx10.12"
CODE_SIGN="iPhone Developer"

echo DESTINATION = "${DESTINATION}"

echo 'Building xcodebuild command'

build_cmd=(xcodebuild test -project ${XCODE_PROJ_PATH} -scheme ${APP_NAME})
build_cmd+=(-sdk "${SDK_TYPE}")
build_cmd+=(-configuration "${BUILD_TYPE}" DEVELOPMENT_TEAM="S99QSEYL6F")
#build_cmd+=(CODE_SIGN_IDENTITY="${CODE_SIGN}")
build_cmd+=(CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES=YES)
build_cmd+=(-destination "$DESTINATION")

if [ ${TESTCASE} ]
then
  build_cmd+=(-only-testing:${APP_TARGET}/${CLASS}/${TESTCASE})
else
  build_cmd+=(-only-testing:${APP_TARGET}/${CLASS})
fi

echo "${build_cmd[@]}"


echo 'Running test'

"${build_cmd[@]}"
