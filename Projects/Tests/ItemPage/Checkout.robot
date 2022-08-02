*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/ItemPage/locators.py
Variables  ../../PageObjects/Common/locators.py
Resource  ../../PageObjects/ItemPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Ebay Page
Suite Teardown  Close All Browsers

*** Test Cases ***
Successfully Check Out Item As Guest Without Adding It To Cart
    [Tags]  test1
    Search For "${SEARCH ITEM}" In "All Categories"
    Filter Items By Type: "buy it now"
    Sort Items By "Best Match"
    Select And Verify Item Number "3" From Search Results
    Select Variations For Item
    Check Out As Guest And Verify Item

Successfully Check Out Item As Guest After Adding It To Cart
    [Tags]  test2
    Search For "${SEARCH ITEM}" In "All Categories"
    Filter Items By Type: "Buy It Now"
    Sort Items By "Best Match"
    Select And Verify Item Number "2" From Search Results
    Select Variations For Item
    Add To Cart And Verify Item
    Go To Checkout And Verify Item

Successfully Remove Item As Guest After Adding It To Cart
    [Tags]  test3
    Search For "${SEARCH ITEM}" In "All Categories"
    Filter Items By Type: "Buy It Now"
    Sort Items By "Best Match"
    Select And Verify Item Number 4 From Search Results
    Select Variations For Item
    Add To Cart And Verify Item
    Verify Remove First Item From Shopping Cart