*** Settings ***
Library  SeleniumLibrary
Resource  ../../PageObjects/SearchPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot
Resource  ../../PageObjects/ItemPage/keywords.robot
Suite Setup  Open Ebay Home Page
Suite Teardown  Close All Browsers


*** Test Cases ***
Search Page Should Display As "Grid View" By Default
    [Tags]  test1
    Search For "Sneaker" In "All Categories"
    Verify Page Displays Grid View As Default

Search Page Should Contain "60" Items Per Page By Default
    [Tags]  test2
    Search For "Sneaker" In "All Categories"
    Verify Page Contains "60" "${ItemsPerPage}" As Default

Search Page Should Displays "All Listings" Buying Format By Default
    [Tags]  test3
    Search For "Sneaker" In "All Categories"
    Verify Search Page Displays Default Item Location As Default

Search Page Should Display Large Item Thumbnail By Default
    [Tags]  test4
    Search For "Sneaker" In "All Categories"
    Verify Search Page Displays Thumbnail Large

Search Page Should Switch To New Tab When Selecting Item By Default
    [Tags]  test5
    Search For "Sneaker" In "All Categories"
    Verify Search Page Displays Item In New Tab As Default

All Variation Aspects On Search Page Should Be Blank And Unchecked
    [Tags]  test6
    Search For "Sneaker" In "All Categories"
    Verify Others Values Are Blank and Unchosen

Each Category Page From Search Dropdown Menu Should Be Valid
    [Tags]  test7
    Verify Each Category On Search Page

Successfully Search For Item And Add To The Cart
    [Tags]  test8
    # Search For Item
    Search For "Sneaker" In "All Categories"
    Select Subcategory "Women" On Search Page 
    Filter By Condition "New with tags" On Search Page
    Sort Items By "Price + Shipping: highest first"    
    Select And Verify Item Number "1" From Search Results
    Select Variations For Item
    Add To Cart And Verify Item

