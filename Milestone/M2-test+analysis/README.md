# Test_Analysis

I worked with Jesse on this milestone.

### Test

#### The ability to improve testing coverage using one of the techniques covered in class: constraint-based test generation, fuzzing, etc.

We use constraint-based test generation method to automatically generate test cases. We use Istanbul as the coverage tool to help cover javascript unit tests.

Setup follows workshop4 and homework2.

Run

	node main.js

	node_modules/.bin/istanbul cover test.js

To ease future analysis, we save the results to test.txt.

#### The ability to run an existing static analysis tool on the source code (e.g. FindBugs, PMD, CheckStyle, NCover, Lint, etc.), process its results, and report its findings.

We use [JsHint](http://jshint.com/docs/) as the static analysis tool.

Install JsHint

        npm install jshint -g

Run JsHint

        jshint subject.js

To ease future analysis, we save the results to analysis.txt.

#### The ability to extend an existing analysis tool with a custom rule, or implement a new analysis.

We extend JsHint to omit certain errors by modifying [options](http://jshint.com/docs/options/) of JsHint.

To do so, we create a .jshintrc file and put the customized JsHint options into it.

For example, if we want to omit the error that uses '===' to compare with 'null', we create a .jshintrc file and put the following JsHint options into it.

	{
	  "eqnull": true,
	}

#### The ability to reject a commit if it fails a minimum testing criteria and analysis criteria.

To reject a commit if it fails a minimum testing criteria, we need to config the Github hook by editing .git/hooks/pre-commit. We modify the pre-commit file to run our own script test.sh when a commit is commited in this git repository.

So the content of pre-commit is simple

	#!/bin/sh
	# Refuse to commit files with if failed coverage test by 50% or failed certain analysis rules#
	echo "call test.sh"
	sh ./test.sh

The testing criteria we set is to ensure more than 50% coverage of any kinds in the coverage report, and the analysis criteria we set is to ensure no error of "missing semicolon" is passed.

If there is any coverage that is less than 50%, we reject that commit and print the error message. 

If there is any error that is about "missing semicolon", we reject that commit and print the error message.





### Analysis

#### The ability to improve testing coverage using one of the techniques covered in class: constraint-based test generation, fuzzing, etc.

	=============================== Coverage summary ===============================
	Statements   : 100% ( 14/14 )
	Branches     : 100% ( 4/4 )
	Functions    : 100% ( 1/1 )
	Lines        : 100% ( 13/13 )
	================================================================================

#### The ability to run an existing static analysis tool on the source code (e.g. FindBugs, PMD, CheckStyle, NCover, Lint, etc.), process its results, and report its findings.

	subject.js: line 3, col 9, Use '===' to compare with 'null'.
	subject.js: line 3, col 21, Missing semicolon.
	subject.js: line 6, col 14, Missing semicolon.
	subject.js: line 8, col 18, Missing semicolon.
	4 errors

#### The ability to extend an existing analysis tool with a custom rule, or implement a new analysis. For example, you could write a static analysis that checks for the ratio of comments to code, or finds parse errors in SQL string statements. You could introduce security checks, a dynamic analysis, a data-flow analysis or a data-flow based test coverage.

	subject.js: line 3, col 21, Missing semicolon.
	subject.js: line 6, col 14, Missing semicolon.
	subject.js: line 8, col 18, Missing semicolon.
	3 errors

#### The ability to reject a commit if it fails a minimum testing criteria and analysis criteria.

Output if cannot pass the criteria

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

Output if pass the criteria

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
