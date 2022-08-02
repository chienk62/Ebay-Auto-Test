*** Settings ***
Library  Selenium2Library
Variables  locators.py
Resource  ../../PageObjects/Common/keywords.robot

*** Variables ***


*** Keywords ***
Search For 
    [Arguments]  ${searchText}
    Input Text  ${InputText}  ${searchText}
    Press Keys  NONE  RETURN
    Sleep  1s

Open Ebay Default Search Page
    Open Ebay Home Page
    Search For  Sneaker

Verify Page Displays Grid View As Default
    Page Should Contain Element  ${GridView}

Verify Page Contains "${number}" "${itemsPerPage}" As Default
    ${numberItemPerPage}  Get Element Count  ${itemsPerPage}
    Should Be Equal As Numbers  ${numberItemPerPage}  ${number}

Verify Search Page Displays All Listings Buying Format As Default
    Page Should Contain Radio Button  ${RadioBuyingFormatChecked}

Verify Search Page Displays Default Item Location As Default
    Page Should Contain Radio Button  ${RadioItemFormatChecked}

Verify Search Page Displays Thumbnail Large
    Wait Until Page Contains Element  ${GridView}
    Click Element  ${GridView}
    Sleep  1s
    Click Element  ${Settings}
    Wait Until Page Contains Element  ${ThumbnailLarge}

Verify Search Page Displays Item In New Tab As Default
    Wait Until Page Contains Element  ${OpenInNewTab}
    Click Element  ${CloseCustomize}
    ${firstItem}  Get Text  ${FirstItem}
    Click Element  ${FirstItem}
    Switch Window  NEW
    Page Should Contain  ${firstItem}
    Close Window
    Switch Window  MAIN

Verify Others Values Are Blank and Unchosen
    Click Element  ${USShoesSize}
    Wait Until Element Is Visible  ${AllFilter}
    ${allFilter}  Get WebElements  ${AllFilter}
    ${list}  Create List  Buying Format  Item Location  
    FOR  ${filter}  IN  @{allFilter}
        Click Element  ${filter}
        ${text}  Get Text  ${filter}
        IF  '${text}' in @{list}  CONTINUE
        Wait Until Page Contains Element  SearchPFirstCheckboxFeature
        Sleep  3s
        Page Should Not Contain Element  ${CheckboxChoosed}
    END

Click Category Box
    Click Element  ${CategoryBox}
    Sleep  1s

Click Search Icon
    Click Element  ${SearchIcon}  CTRL

Verify Each Category On Search Page
    ${allCatgory}  Get WebElements  ${AllCategory}
    FOR  ${category}  IN  @{allCatgory}
        Click Category Box
        Click Element  ${category}
        Sleep  1s
        Click Search Icon
        Switch Window  NEW
        Wait Until Element Is Visible  ${TitleName}
        Close Window
        Switch Window  MAIN
    END

Choose "${gender}" As Gender
    Click Element  //span[text()='${gender}']
    Sleep  2s

Choose "${conditionType}" As Condition Of Item
    [Arguments]  ${Conditions}
    Wait Until Page Contains Element  ${ConditionBtn}
    Click Element  ${ConditionBtn}
    Wait Until Page Contains Element  //span[@class= 'filter-menu-button__text' and text()='${conditionType}']
    Click Element  //span[@class= 'filter-menu-button__text' and text()='${conditionType}']
    Sleep  2s

Choose "${price}" As Filter Price
    Click Element  ${BestMatch}
    Wait Until Page Contains Element  //a[@class='fake-menu-button__item']/span[text()='${price}']
    Click Element  //a[@class='fake-menu-button__item']/span[text()='${price}']
    Sleep  1s

View First Item In New Window
    Click Element  ${PriceSneaker}
    Switch Window  NEW
    Sleep  1s

Add Item To The Cart
    Wait Until Page Contains Element  ${AddToCart}
    Click Element  ${AddToCart}
    Sleep  2s