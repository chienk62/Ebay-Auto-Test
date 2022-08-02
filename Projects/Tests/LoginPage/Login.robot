*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/LoginPage/locators.py
Variables  ../../PageObjects/Common/locators.py
Resource  ../../PageObjects/LoginPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Ebay Page
Suite Teardown  Close All Browsers


*** Test Cases ***
Open Login Page
    Login With Valid Credentials
    Open Account Settings Page
    Change Password