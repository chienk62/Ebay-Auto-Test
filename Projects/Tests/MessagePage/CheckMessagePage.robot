***Settings***
Library  SeleniumLibrary
Resource  ../../PageObjects/Common/keywords.robot
Resource  ../../PageObjects/MessagePage/keywords.robot
Test Setup  Open Ebay Message Screen
Test Teardown  Close All Browsers


***Test Cases***
Verify Message Screen Displays Default
    [Tags]  test1
    Verify Message Screen Displays All Messages As Default
    Verify Message Screen Displays UnSelected Checkbox

Successfully Select All Checkbox
    [Tags]  test2
    Click All Message Checkbox
    Successfully Select All Checkbox

Verify Email With Exact Subject
    [Tags]  test3
    Open Each Mail And Verify Its Subject

Unsuccessfully Delete Message With Checkbox UnSelected
    [Tags]  test4
    Click Delete Button
    Verify Unsuccessful Delete Message With Unselected Checkbox

Successfully Delete A Message
    [Tags]  test5
    Click Checkbox Of First Message
    Click Delete Button
    Successfully Delete A Message
    Verify If Delete Message Go To Trash 

Successfully Delete All Messages
    [Tags]  test6
    Click All Message Checkbox
    Click Delete Button
    Successfully Delete All Messages