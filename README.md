# javabuildscript
Script for building java projects on raspberry pi

To make building java projects quicker on raspberry pi using any text editor and library files

Currently working with:
  - simple manifest file showing main class.
  - include library jar files contained in classpath from lib folder.

Directory Structure of project to compile and make executable jar file must contain:
  - src directory for all java files.
  - lib directory (optional and if required) for all library jar files.
  - META-INF directory (optional) for MANIFEST.MF file.

Usage Example of script:
   > ./buildmyjar.sh MainJavaFile namejarfile.jar

Script works as is, as long as appropriate structure and usage is as required by script.

It is understood that the script can be made more efficient, but is in currently working condition.
