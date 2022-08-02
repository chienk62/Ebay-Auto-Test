*** Settings ***
Library  SeleniumLibrary
#Library  Collections
Variables  ../../PageObjects/Common/locators.py
#Variables  ../../PageObjects/Common/locators.py
Resource  ../../PageObjects/SearchPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Advanced Search Page
Suite Teardown  Close All Browsers


*** Test Cases ***
Successfully Search For Item Using Advanced Search
    [Tags]  test1
    Select "Computers/Tablets & Networking" Category On Advanced Search
    Select Keyword Option "Any words, any order" On Advanced Search
    Select Search Including "Completed listings" On Advanced Search
    Select Buying Format "Buy It Now" On Advanced Search
    Select Condition "Not Specified" On Advanced Search
    Sort By "Price: highest first" On Advanced Search
    Select View Results "All items" On Advanced Search
    Select "120" Results Per Page On Advanced Search
    Click "Search" On Advanced Search

Successfully Clear Options Using Advanced Search
    [Tags]  test2
    Select "Computers/Tablets & Networking" Category On Advanced Search
    Select Keyword Option "Any words, any order" On Advanced Search
    Select Search Including "Completed listings" On Advanced Search
    Select Buying Format "Buy It Now" On Advanced Search
    Select Buying Format "Auction" On Advanced Search
    Select Condition "Not Specified" On Advanced Search
    Select Show Results "Items listed as lots" On Advanced Search
    Select Show Results "Sale items" On Advanced Search
    Select Show Results "Best offer" On Advanced Search
    Select Show Results "eBay for Charity" On Advanced Search
    Select Listings "Ending in more than" "12 hours" On Advanced Search
    Select Multiple Item Listings From "12" To "${EMPTY}" On Advanced Search
    Show Items Priced From "${EMPTY}" To "5000000" On Advanced Search
    Select Free International Shipping On Advanced Search
    Select From Preferred Locations "Worldwide" On Advanced Search
    Sort By "Price: highest first" On Advanced Search
    Select View Results "All items" On Advanced Search
    Select "120" Results Per Page On Advanced Search
    Click "Clear Options" On Advanced Search
    All Options Should Be Clear On Advanced Search
