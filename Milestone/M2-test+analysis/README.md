# Test_Analysis

I worked with Jesse on this milestone.

### Test
### Unit Test & Coverage Report

We are using the Homework 2(Test Generation) as our test sample, subject.js. Therefore we are using Istanbul as our tool to monitor the test coverage.
We saved it into a test.txt file for the script to check the coverage in Analysis Section.

	node_modules/.bin/istanbul cover test.js
		
The following are the results of Istanbul. 

	=============================== Coverage summary ===============================
	Statements   : 100% ( 14/14 )
	Branches     : 100% ( 4/4 )
	Functions    : 100% ( 1/1 )
	Lines        : 100% ( 13/13 )
	================================================================================
	
### Improve testing coverage using constraint-based test generation
We have used the constraint-based test generation method to automatically generate the test cases. The automatically generated test cases are stored in test.js file.
The generated test cases will make the coverage to 100%. In order to automatically generate the test case. You can run the following command.

	node main.js
However, if we change the code in subject.js without running this command. We can get the newly edited code's coverage simply by running the following command to check whether the new code passed all the test cases.

	node_modules/.bin/istanbul cover test.js

## Analysis

### Run the static analysis tool JsHint on the source code 
We have used the static code analysis tool JsHint to run the analyse the subject.js. The info about JsHint can be found [here](http://jshint.com/docs/).
You can install it by the following command.

	npm install jshint -g
You can running the JsHint by the following command.

	jshint subject.js
	
The following are the errors found by JsHint. We have saved the result into a analysis.txt for scripts using.

	subject.js: line 3, col 9, Use '===' to compare with 'null'.
	subject.js: line 3, col 21, Missing semicolon.
	subject.js: line 6, col 14, Missing semicolon.
	subject.js: line 8, col 18, Missing semicolon.
	4 errors

#### Configure the options of JsHint
We can see that there are 4 erros which are found by JsHint. We can modify the [options](http://jshint.com/docs/options/) of the JsHint to omit certain errors found by JsHint.
For example, we want to omit the first error which is using '==' to compare with 'null'.
We can create a .jshintrc file and put the JsHint options into it. The list of the JsHint options can be found here. To omit the above the error,we can put the following into the file.

	{
	  "eqnull": true,
	}
When we configured the JsHint, we rerun the JsHint, we can get the following the result, which is exactly what we want.

	subject.js: line 3, col 21, Missing semicolon.
	subject.js: line 6, col 14, Missing semicolon.
	subject.js: line 8, col 18, Missing semicolon.
	3 errors
### Reject a commit if it fails a minimum testing criteria
We need to configure the Github Hook to reject a commit. We can do it by editing the file in .git/hooks. In this directory, there is a pre-commit.sample file. What we need to do is to rename it into pre-commit and put our logic into it. We have made the pre-commit file to call our own script test.sh file to run when a commit is commited in this git repository. 
In our case, we only put the following into the pre-commit, as we only need it to call test.sh.
	#!/bin/sh
	# Refuse to commit files with if failed coverage test by 50% or failed certain analysis rules#
	echo "call test.sh"
	sh ./test.sh

#### Less than 50% coverage of any kind in Coverage Report
We have used the Shell Script to get the result from test.txt, as mentioned in Test Section. If there is some coverage which is lower than 50%. We deny that commit and output the error infomation.
The following are the sample result:

	Check Commit Script start now
	--------Running Istanbul
	=============================================================================
	Writing coverage object [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage/coverage.json]
	Writing coverage reports at [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage]
	=============================================================================
	Istanbul Finished

	--------Running Static Analysis tool Jshint!!

	--------Checking whether Analysis Result Satisfy Requirements~~~~~~

	Passed the Analysis Result Satisfy Requirements 
	--------Checking whether coverage Satisfy Requirements~~~~~~

	Statements Coverage is higher than  50 %! Pass!
	Branches Coverage is less than  50 %.
	!!!Failed to commit!!! Please check the test.txt for references

#### Failed the Analysis Criteria 
We have used the Shell Script to get the result from analysis.txt, as mentioned in JsHint Section. If there is certain errors which are found by jshint, we will deny the commit and show the error infomation, in our case is the "missing semicolon". 
The following are the sample result:

	Check Commit Script start now
	--------Running Istanbul
	=============================================================================
	Writing coverage object [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage/coverage.json]
	Writing coverage reports at [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage]
	=============================================================================
	Istanbul Finished

	--------Running Static Analysis tool Jshint!!
	subject.js: line 3, col 21, Missing semicolon.
	subject.js: line 6, col 14, Missing semicolon.
	subject.js: line 8, col 18, Missing semicolon.

	3 errors

	--------Checking whether Analysis Result Satisfy Requirements~~~~~~

	!!!Failed to commit!!! There is missing semicolon problems in your program
##Result
If you passed all the criteria, you will be able to commit, as the following shows.

	Jesses-MacBook-Air:Test_Analysis jessexu$ git add -A
	Jesses-MacBook-Air:Test_Analysis jessexu$ git commit -m "test2"
	call test.sh
	Check Commit Script start now
	--------Running Istanbul
	=============================================================================
	Writing coverage object [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage/coverage.json]
	Writing coverage reports at [/Users/jessexu/Documents/North Carolina State University/Courses/CSC591 DevOp/Test_Analysis/coverage]
	=============================================================================
	Istanbul Finished

	--------Running Static Analysis tool Jshint!!

	--------Checking whether Analysis Result Satisfy Requirements~~~~~~

	Passed the Analysis Result Satisfy Requirements 
	--------Checking whether coverage Satisfy Requirements~~~~~~

	Statements Coverage is higher than  50 %! Pass!
	Branches Coverage is higher than  50 %! Pass!
	Functions Coverage is higher than  50 %! Pass!
	Lines Coverage is higher than  50 %! Pass!

	[master 0aacf71] test2
	 8 files changed, 87 insertions(+), 40 deletions(-)
	 rewrite README.md (63%)
