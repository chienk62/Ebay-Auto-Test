***Settings***
Library  Selenium2Library
Resource  ../../PageObjects/SearchPage/keywords.robot
Resource  ../../PageObjects/Common/keywords.robot
Test Setup  Open Ebay Home Page
Test Teardown  Close All Browsers


***Test Cases***
Verify If Search Screen Display Default
    [Tags]  test1
    Search For  Sneaker
    Verify Page Displays Grid View As Default

Verify Page Contains "60" "${ItemsPerPage}" As Default
    [Tags]  test2
    Search For  Sneaker
    Verify Page Contains "60" "${ItemsPerPage}" As Default

Verify Search Page Displays All Listings Buying Format As Default
    [Tags]  test3
    Search For  Sneaker
    Verify Search Page Displays Default Item Location As Default

Verify Search Page Displays Thumbnail Large
    [Tags]  test4
    Search For  Sneaker
    Verify Search Page Displays Thumbnail Large

Verify Search Page Displays Item In New Tab As Default
    [Tags]  test5
    Search For  Sneaker
    Verify Search Page Displays Item In New Tab As Default

Verify Others Values Are Blank and Unchosen
    [Tags]  test6
    Search For  Sneaker
    Verify Others Values Are Blank and Unchosen

Successfully Access Right Search Page Each Catgory
    [Tags]  test7
    Verify Each Category On Search Page

Successfully Search Item And Add To The Cart
    [Tags]  test8
    Search For  Sneaker
    Choose "Women" As Gender
    Choose "New with tags" As Condition Of Item
    Choose "Price + Shipping: highest first" As Filter Price
    View First Item In New Window
    Add Item To The Cart

