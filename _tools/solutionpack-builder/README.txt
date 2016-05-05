1- Build a full solution pack
	java -jar build-solutionpack-cli.jar <path to solution pack folder> <name of the solution pack>

	<path to solution pack folder> : the solution pack folder is the folder that contains the "blocks" and "images" directories 
	and the description, meta, licences and logo files.

	<name of the solution pack> : the name of the solution pack will be used as the name of the package file. Any spaces before 
	and after the name will be withdraw and any spaces, _ or . characters in the name will be replace by an - character.

	You can change the system property that tells the builder where to find the solutions packs question locales files. If you give a relative
	path, it will be relative to the <path to solution pack folder>. By default this system property is set to ../.. (two folders back). 
	-Dsolutionpack.builder.solutionpacks.root=<new path>.

	The generated package file will be put in the "pkg" folder.
	
2- Build a solution pack block.
	java -jar build-solutionpack-cli.jar <path to solution pack block folder> <name of the solution pack block>
	
	<path to solution pack block folder> : the solution pack folder is the folder that contains the files.
	
	<name of the solution pack block> : the name of the solution pack block that will be used as the name of the package file. Any spaces before 
	and after the name will be withdraw and any spaces, _ or . characters in the name will be replace by an - character.
	
3- Answer update scripts are now supported for modules and solution pack blocks:
   - Javascript syntax is used.
   - Recorded answers are stored in the answers object.
   - Typical case: move content from answers.a.b to answers.c:
   {{{
   		answers.c = answers.a.b;
   		delete answers.a.b;
   }}} 
   - Update script file naming convention: answers-v([0-9]+){1}\\.([0-9]+){1}(u[0-9]+)?-updater.js  (answers-v1.0u1-updater.js)
   - Update script files must be present in the same directory as the module questions.txt.
   	