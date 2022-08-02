*** Settings ***
Library  Selenium2Library
Variables  locators.py

*** Variables ***


*** Keywords ***
Search For Item 
    Input Text    ${InputText}   ${SearchText}
    Press Keys  NONE  RETURN
    Sleep  2s

Verify Default Status Search
    Page Should Contain Element  //*[text()='Selected category']/parent::*[text()='All']
    Page Should Not Contain Element  //span[text()='Remove filter']
    Sleep  1s 
    Checkbox Should Not Be Selected  

Choose Gender
    [Arguments]  ${Gender}  
    Click Element  //span[text()='${Gender}']
    Sleep  2s

Choose Condition Of Item
    [Arguments]  ${Conditions}  ${ConditionType}  
    Wait Until Page Contains Element  //span[@class= 'filter-menu-button__button-text' and text()='${Conditions}']
    Click Element  //span[@class= 'filter-menu-button__button-text' and text()='${Conditions}']
    Sleep  2s
    Click Element  //span[@class= 'filter-menu-button__text' and text()='${ConditionType}']
    Sleep  2s

Filter Price Of Item
    [Arguments]  ${BestMatch}  ${ChooseType}
    # Filter Price span[@class='expand-btn__cell']//span[@class='expand-btn__cell']/
    Click Element  //span[text()='${BestMatch}']
    Sleep  2s
    Click Element  //a[@class='fake-menu-button__item']/span[text()='${ChooseType}']
    Sleep  2s

Display Choosed Item
    Click Element  ${PriceSneaker}
    Sleep  2s

Add Item To The Cart
    Switch Window  NEW  
    Sleep  15s
    # Page Should Contain Element  ${AddToCart}
    Click Element  ${AddToCart}
    Sleep  2s
    
Search For 
    [Arguments]  ${searchText}
    Input Text  ${InputText}  ${searchText}
    Press Keys  NONE  RETURN
    Sleep  1s

Open Ebay Default Search Page
    Keywords.Open Ebay Home Page
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
    # Log to console   ${allFilter}
    FOR  ${filter}  IN  @{allFilter}
        Click Element  ${filter}
        ${text}  Get Text  ${filter}
        IF  '${text}' in @{list}  CONTINUE
        Wait Until Page Contains Element  (//*[@type='checkbox'])[1] 
        Sleep  3s
        Page Should Not Contain Element  ${CheckboxChoosed}
    END

Verify Each Category On Search Page
    ${allCatgory}  Get WebElements  ${AllCategory}
    FOR  ${category}  IN  @{allCatgory}
        Click Element  //*[@id='gh-cat-box']
        Sleep  1s
        Click Element  ${category}
        Sleep  1s
        Click Element  //input[@value='Search']  CTRL
        Switch Window  NEW
        Wait Until Element Is Visible  ${TitleName}
        Close Window
        Switch Window  MAIN
    END
