

FILENAME=`echo $1 |cut -d'.' -f1 | sed -e "s|/|_|g"`
TARGET=${FILENAME}_run
ALLOVSR_BUILD=0
CMAKE_FLAGS="-DBUILD_ALLOGLV=0 -DBUILD_GLV=0 -DBUILD_VSR=0 -DBUILD_GAMMA=0"


if [ -f $1 ]
then
  TARGET_FLAG="-DBUILD_APP_FILE=$1 -DBUILD_DIR=0"
elif [ -d $1 ]
then
  TARGET_FLAG="-DBUILD_APP_DIR=$1 -DBUILD_DIR=1"
else
  echo Aborting: $1 is neither a file nor directory
  exit 1
fi

#rm CMakeCache.txt
#rm AlloSystem/CMakeCache.txt
cmake . ${CMAKE_FLAGS} ${TARGET_FLAG} -DNO_EXAMPLES=1 -DNO_PROJECTS=1

make $TARGET -j4 $*