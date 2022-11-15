## Greetings %username% !

This is a quick manual on what we expect from you during performing the test task.

This will be a simple app that contains two features: Login & Checklist.

* First of all, get to know with the application under test, build the test app and check out its possibilities and bugs. 

* Second of all, we need to evaluate your qa manual background, so create down below:
 - short testplan 
 - list of the testcases
 - list of discovered issues
 
* Third of all, write test automation according test automation purposes  

* And fourth of all, push the whole project to github.com and notice us with a link to your repo on completion. 

Please reachout yvolkova@readdle.com if you have any questions.

## Good Luck!


#YOUR TASK STARTS HERE: 


# TEST PLAN: 

Environment:
Small scaled phones: SE, 8, 12 Mini
Large scaled phones: 7 plus, 11, 13 Pro Max
Ipads: iPad Pro (11 inch), iPad Pro (12.9 inch), iPad (9th generation)

iOS Versions:
- 15.5
- 16.0

What parts of app will be tested:
- Login View
- Tasks View
- Subtasks view

How will be tested:
Automation coverage by positive/negative/e2e tests on devices that specified in Environment

Will be tested by: 
Oleksandr Denysov


# LIST OF TEST CASES: 
// Only summaries of tests: e.g. 

Login Page:

- Successed login/logout
- Perform login with empty password field
- Login with invalid emails - invalid, no domen, spaces
- Keyboard should be hidden after tapping on Return button
- Min/Max limitation on password field should be present
- Login to the system multiple times shouldn't trigger error

Tasks Page:

- Page header is present on the screen
- Logout can be dissmissed
- All tasks should be present for the user
- Check correct multiple tasks completion/uncomplition one-by-one
- Check that task with More Info can be hittable and completed
- Check all tasks sorting
- Check all tasks completion/uncompletion by Complete All/Cancel All button
- Check multiple tasks completion via Complete All button (verify button state changing)
- Check multiple tasks sorting behavior

Subtasks Page:

- Tapping on More Info button redirects user to a subtasks page
- All subtasks should be presented to a user
- Back button should redirect user to the main Tasks screen
- User can perform logout from subtask page
- Complete All/Cancel All behavior isn't changed on Subtasks page
- Sort All behavior isn't changed on Subtasks page

# LIST OF DISCOVERED ISSUES:
// Only summaries of bug reports: e.g.

Login Page:

- Keyboard isn't hidden on text fields
- No password field max/min limitation
- Multiple login process throws Unexpected Error

Tasks Page:

- Another task is completed during multiple tasks completion/uncomplition one-by-one
- Complete All button isn't changed to Cancel All during multiple tapping
- Tasks are not completed during multiple tapping on Complete All button
- Sorting mechanism shuffles tasks during multiple tapping on Sort All
- Sort All button completes all tasks during multiple tapping
- Unneeded disabled chevron element is presented near More Info button

General:

- An app isn't adapted for non-notch iPhones
- [PRODUCT] Rotation mechanism should be disabled?
