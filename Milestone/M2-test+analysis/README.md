# Test_Analysis

I worked with Jesse on this milestone.

### Test

We use Istanbul as the coverage tool to help cover javascript unit tests.

The setup follows workshop4 and homework2.

Run Istanbul

	node_modules/.bin/istanbul cover test.js

To ease analysis, we save the results to test.txt.

We use [JsHint](http://jshint.com/docs/) as the static analysis tool.

Install JsHint

        npm install jshint -g

Run JsHint

        jshint subject.js

To ease analysis, we save the results to analysis.txt.

To make JsHint omit certain errors, modify [options](http://jshint.com/docs/options/) of JsHint.

For example, if we want to omit the error that uses '==' to compare with 'null', we can create a .jshintrc file and put the following JsHint options into it.

	{
	  "eqnull": true,
	}

To reject a commit if it fails a minimum testing criteria, we need to config the Github hook by editing .git/hooks/pre-commit. We modify the pre-commit file to run our own script test.sh when a commit is commited in this git repository.

So the content of pre-commit is simple

	#!/bin/sh
	# Refuse to commit files with if failed coverage test by 50% or failed certain analysis rules#
	echo "call test.sh"
	sh ./test.sh

### Analysis

#### The ability to improve testing coverage using one of the techniques covered in class: constraint-based test generation, fuzzing, etc. You can use an existing tool or implement your own approach.

The ability to run an existing static analysis tool on the source code (e.g. FindBugs, PMD, CheckStyle, NCover, Lint, etc.), process its results, and report its findings.

The ability to extend an existing analysis tool with a custom rule, or implement a new analysis. For example, you could write a static analysis that checks for the ratio of comments to code, or finds parse errors in SQL string statements. You could introduce security checks, a dynamic analysis, a data-flow analysis or a data-flow based test coverage.

The ability to reject a commit if it fails a minimum testing criteria (e.g. failed test case, or less than 50% statement coverage) and analysis criteria (e.g. cannot commits that generate a particular FindBugs rule, such as "Method concatenates strings using + in a loop").Less than 50% coverage of any kind in Coverage Report
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
