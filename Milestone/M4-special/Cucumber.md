### Cucumber
Cucumber is a flagship Behavior Driven Development (BDD) tool.

#### Code

#### Video

#### Description
Behavior Driven Development (BDD) is a rising methodology to test and check your code. In BDD, whatever developers write must go into Given-When-Then steps, and thus covers all possible test cases and can be easily modified to accommodate more. 

In BDD, users (business analysts, product owners) first write scenarios or acceptance tests that describes the behavior of the system from the customers' perspective, for review and sign-off by the project owners before developers write their code.

Cucumber tool offers a way to write tests that anybody can understand, regardless of their technical knowledge. It is more like writing documentation. It has five main benefits:

* helps to involve business stakeholders to easily understand code
* focuses on end-user experience
* style of writing tests allow for easier reuse of code in the tests
* quick and easy set up and execution
* efficient tool for testing

##### Cucumber Installation
Install Ruby

	go to http://rubyinstaller.org/downloads/
 
Install Ruby Development Kit

	go to http://rubyinstaller.org/downloads/

Install Cucumber

	gem install cucumber
	cucumber -version

Install Ansicon
Install Watir
Install rspec

##### Cucumber Basics
Two files (Features and Step Definition) are needed to execute a Cucumber test scenario. Feature file contains high level description of the test scenario in simple language. Step definition file contains the actual code to execute the test scenario in the Features file.

Directory

	features
		---- step_definition
		---- support directories

Feature file consists of the following components

* Feature: A feature would describethe current test script which has to be executed.
* Scenario: Scenario describes the steps and expected outcome for a particular test case.
* Scenario Outline: Same scenario an be executed for multiple sets of data using scenario outline. The data is provided by a tabular structure.
* Given: It specifies the context of the text to be executed. By using datatables "Given", step can also be parameterized.
* When: "When" specifies the test action that has to be performed.
* Then: The expected outcome of the test can be represented by "Then"

Step definition maps the test case steps in the feature files (Given/When/Then) to code, which executes and checks the outcomes from the system under test. For a step definition to be executed, it must match the given component in a feature. Step definition is defined in ruby files under "features/step_definitions/*_steps.rb".

 
#### Extended Analysis

#### References
http://www.guru99.com/introduction-to-cucumber.html
