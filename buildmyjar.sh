# Check directory structure 
# src contains source java files
# bin contains compiled class files
# lib contains classpath library files such as jars
# META-INF contains metafile

#Command Syntax
# buildmyjar.sh $1 $2
# where $1 is project name and name of class containing main function
# and $2 is name of jar file to export. 

#Example command
#./buildmyjar.sh HelloWorld hello.jar


if [[ -d ./src ]]
then
     echo "Directory src exists with "$(ls ./src | wc -l)" files"
else
     echo "Directory src does not exist"
fi
if [[ -d ./bin ]]
then
     echo "Directory bin exists with "$(ls ./bin | wc -l)" files"
else
     echo "Directory bin does not exist"
fi
if [[ -d ./lib ]]
then
     echo "Directory lib exists with "$(ls ./lib | wc -l)" files"
else
     echo "Directory lib does not exist"
fi
if [[ -d ./META-INF ]]
then
     echo "Directory META-INF exists with "$(ls ./META-INF | wc -l)" files"
else
     echo "Directory META-INF does not exist"
fi

projectname=$1
echo "Project name: "$projectname
mainjava=$1".java"
echo "Main java file: "$mainjava



# Compile Java files with classpath if required. 
# check src directory contains Java file of same name as the project directory name.
if [[ -f "./src/$mainjava" ]]
then
     if [[ -d ./lib ]]
     then
          if [[ $(ls ./lib | wc -l) -gt 0 ]]
          then 
               #get all files in lib directory
               echo "Compile with all files in lib directory"
               #sudo javac -d bin ./src/$mainjava
               sudo javac -d bin ./src/$mainjava -classpath 'ls ./lib/*'
          else
               echo "Compile java file only, no libs"
               sudo javac -d bin ./src/$mainjava
          fi
     else
	      echo "Compile java file only, no libs"
          sudo javac -d bin ./src/$mainjava
     fi
else
     echo "No Java file to compile."
fi

# Create a temp directory to assemble files.
if [[ -d ./bin ]]
then
     if [[ $(ls ./bin/*.class | wc -l) -gt 0 ]]
     then
          echo "Assemble jar file"
          sudo mkdir temp-dir 
          sudo cp -r ./bin/*.class ./temp-dir
          if [[ $(ls ./lib/*.jar | wc -l) -gt 0 ]]
          then
               #extract all lib jar files for their class files and clean up
               sudo cp -r ./lib/*.jar ./temp-dir
               #jar-list-dir=./lib
               cd temp-dir
               for jarname in ./*.jar
               do
                    echo "jar file: "$jarname
                    sudo jar xf $jarname
                    sudo rm $jarname
               done
               cd ..
          fi

          # Create an executable jar file and clean up.
          if [[ -f "./META-INF/MANIFEST.MF" ]]
          then
               echo "Using Manifest file to create jar"
               sudo jar cvfm $2 META-INF/MANIFEST.MF -C ./temp-dir/ .
          else
               echo "Creating dummy Manifest file"
               sudo jar cvfe $2 $1 -C ./temp-dir/ .
          fi
          sudo chmod a+x $2
          sudo rm -r temp-dir
     else
          echo "No class files compiled"
     fi
fi

