*** Settings ***
Library  Selenium2Library
Variables  ./locators.py
Resource  ../../PageObjects/Common/keywords.robot

*** Variables ***


*** Keywords ***
Open Message Screen
    Wait Until Page Contains Element  ${MyEbayBtn}  30s
    Mouse Over  ${MyEbayBtn}
    Wait Until Element Is Visible  ${MessageBtn}
    Click Element  ${MessageBtn}
    Sleep  1s

Open Ebay Message Screen
    Open Ebay HomePage
    Login With Valid Credentials
    Open Message Screen

Verify Message Screen Displays All Messages As Default
    Page Should Contain Element  ${AllMessageBtn}

Verify Message Screen Displays UnSelected Checkbox
    ${checkBox}  Get WebElements  ${Checkbox}
    FOR  ${checkbox}  IN  @{checkBox}
        Checkbox Should Not Be Selected  ${checkbox}
    END

Inbox Is Not Blank
    Page Should Not Contain  You do not have any messages

Click All Message Checkbox
    ${passed}  Run Keyword And Return Status  Inbox Is Not Blank
    IF  ${passed} == True  Click Element  ${CheckboxAll}

Successfully Select All Checkbox
    ${checkBox}  Get WebElements  ${Checkbox}
    FOR  ${checkBox}  IN  @{checkBox}
        Checkbox Should Be Selected  ${checkBox}
    END

Open Message Content
    [Arguments]  ${message}
    ${passed}  Run Keyword And Return Status  Inbox Is Not Blank
    IF  ${passed} == True  Click Element  ${message}
    Sleep  1s

Return To Main Message Screen
    Click Element  ${BackInbox}
    Sleep  1s

Open Each Mail And Verify Its Subject
    ${indexMsg}  Get Element Count  ${AllMsg}
    FOR  ${index}  IN RANGE  1  ${indexMsg}
        ${subject}  Get Text  (${AllMsg})[${index}]
        Open Message Content  (${AllMsg})[${index}]
        Wait Until Page Contains  ${subject}
        Return To Main Message Screen
    END

Click Delete Button
    Click Element  ${DelBtn}
    Wait For Condition  return document.readyState=="complete"

Verify Unsuccessful Delete Message With Unselected Checkbox
    Page Should Contain  No message is selected
    Sleep  1s

Click Checkbox Of First Message
    ${passed}  Run Keyword And Return Status  Inbox Is Not Blank
    IF  ${passed} == True  Click Element  (${Checkbox})[1]
    Checkbox Should Be Selected  ${checkBox}
    ${ID}  Get Element Attribute  (${Checkbox})[1]  id
    Set Test Variable  ${ID}

Successfully Delete A Message
    Page Should Contain  You moved one or more messages to folder "Trash"

Verify If Delete Message Go To Trash
    Click Element  ${TrashBtn}
    Wait For Condition  return document.readyState=="complete"
    # Sleep  2s
    Element Should Be Visible  //input[@id='${ID}']

Successfully Delete All Messages
    Page Should Contain  You do not have any messages
