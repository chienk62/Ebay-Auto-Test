*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/Common/locators.py
Resource  ../../PageObjects/HelpPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Ebay Help Page
Suite Teardown  Close All Browsers

*** Test Cases ***
All Articles On Selling Section Should Be Valid
    [Tags]  test1
    Click On "Selling" Section On Help Page
    Expand All Articles
    Open All Articles And Verify Contents