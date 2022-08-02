*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/LoginPage/locators.py
Variables  ../../PageObjects/Common/locators.py
Resource  ../../PageObjects/ItemPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Ebay Page
Suite Teardown  Close All Browsers


*** Test Cases ***
Verify Discount Test Case
    Verify Discount