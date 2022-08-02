*** Settings ***
Library  SeleniumLibrary
Variables  locators.py


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

Select Subcategory "${subcategory}" On Search Page
    Click Element  //li[@class='srp-refine__category__item']//*[text()='${subcategory}']
    Wait For Condition  return document.readyState=="complete"

Choose Condition Of Item
    [Arguments]  ${Conditions}  ${ConditionType}  
    Wait Until Page Contains Element  //span[@class= 'filter-menu-button__button-text' and text()='${Conditions}']
    Click Element  //span[@class= 'filter-menu-button__button-text' and text()='${Conditions}']
    Sleep  2s
    Click Element  //span[@class= 'filter-menu-button__text' and text()='${ConditionType}']
    Sleep  2s

Filter By Condition "${condition}" On Search Page
    Click Element  //*[text()='Condition']/../parent::button
    Wait Until Element Is Visible  //*[text()='${condition}']/parent::*[@role='menuitemcheckbox']
    Click Element  //*[text()='${condition}']/parent::*[@role='menuitemcheckbox']
    Wait Until Element Is Not Visible  //*[text()='${condition}']/parent::*[@role='menuitemcheckbox']

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

Search For "${input}" In "${category}"
    Wait Until Element Is Visible  //*[@id='gh-btn']
    Input Text  ${InputText}  ${input}
    IF  '${category}' != 'All Categories'
        Select From List By Label  //*[@id='gh-cat']  ${category}
    END
    Click Element  //*[@id='gh-btn']
    Wait For Condition  return document.readyState=="complete"  30s

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


Select "${category}" Category On Advanced Search
    Select From List By Label  //*[@id='e1-1']  ${category}

Select Keyword Option "${option}" On Advanced Search
    Select From List By Label  //*[@id='_in_kw']  ${option}

# Click Search Button And Verify Results
    
    # ${elements} =  Get Webelements  //*[@id='ListViewInner']//h3
    # FOR  ${element}  IN  @{elements}
    #     ${title} =  Get Text  ${element}
    #     Should Match Regexp  ${title}  (?i)(?=.*samsung.*tab.*s.*6.*lite)
    # END

# Click "Clear Options" On Advanced Search
    # Click Element  //*[contains(text(),'Clear options')]
    # Wait For Condition  return document.readyState=="complete"  30s

Click "${button}" On Advanced Search
    IF  '${button}' == 'Search'
        Click Element  (//button[text()='Search'])[1]
        Wait For Condition  return document.readyState=="complete"  30s
    ELSE IF  '${button}' == 'Clear Options'
        Click Element  //*[contains(text(),'Clear options')]
        Wait For Condition  return document.readyState=="complete"  30s
    END

Select Search Including "${include}" On Advanced Search
    Click Element  //label[contains(text()[2],'${include}')]

Select Buying Format "${format}" On Advanced Search
    Click Element  //label[contains(text()[2],'${format}')]

Select Condition "${condition}" On Advanced Search
    Click Element  //label[contains(text()[2],'${condition}')]

Select View Results "${type}" On Advanced Search
    Select From List By Label  //*[@id='LH_VIEW_RESULTS_AS']  ${type}

Sort By "${type of sorting}" On Advanced Search
    Select From List By Label  //*[@id='LH_SORT_BY']  ${type of sorting}

Select "${number}" Results Per Page On Advanced Search
    Select From List By Label  //*[@id='LH_IPP']  ${number}

Select Show Results "${option}" On Advanced Search
    Click Element  //label[contains(text()[2],'${option}')]

Select Listings "${ending within}" "${period}" On Advanced Search
    Select Checkbox  //*[@id='LH_Time']
    Select From List By Label  //*[@name='_ftrt']  ${ending within}
    Select From List By Label  //*[@name='_ftrv']  ${period}

Select Number Of Bids From "${lower number}" To "${upper number}" On Advanced Search
    Select Checkbox  //*[@id='LH_NOB']
    Input Text  //*[@id='_sabdlo']  ${lower number}
    Input Text  //*[@id='_sabdhi']  ${upper number}

Select Multiple Item Listings From "${lower number}" To "${upper number}" On Advanced Search
    Select Checkbox  //*[@id='LH_MIL']
    Input Text  //*[@id='_samilow']  ${lower number}
    Input Text  //*[@id='_samihi']  ${upper number}

Show Items Priced From "${lower price}" To "${upper price}" On Advanced Search
    Select Checkbox  //*[@id='_mPrRngCbx']
    Input Text  //*[@name='_udlo']  ${lower price}
    Input Text  //*[@name='_udhi']  ${upper price}

Select Free International Shipping On Advanced Search
    Select Checkbox  //*[@id='LH_FS']

Select Located "${number}" Miles Of "${location}" On Advanced Search
    Select Radio Button  _fsradio2  &LH_PrefLoc=99
    Select From List By Label  //*[@id='_sadis']  ${number}
    Input Text  //*[@id='_stpos']  ${location}

Select From Preferred Locations "${location}" On Advanced Search
    Select Radio Button  _fsradio2  &LH_PrefLoc=1
    Select From List By Label  //*[@id='_sargnSelect']  ${location}

Select Located In "${location}" On Advanced Search
    Select Radio Button  _fsradio2  &LH_LocatedIn=1
    Select From List By Label  //*[@id='_salicSelect']  ${location}

All Options Should Be Clear On Advanced Search
    ${checkboxes} =  Get Webelements  //*[@type='checkbox']
    FOR  ${checkbox}  IN  @{checkboxes}
        Checkbox Should Not Be Selected  ${checkbox}
    END
    ${textfields} =  Get Webelements  //*[@type='text']
    FOR  ${textfield}  IN  @{textfields}
        Element Text Should Be  ${textfield}  ${EMPTY}
    END
    List Selection Should Be  //*[@id='_in_kw']  All words, any order
    List Selection Should Be  //*[@id='e1-1']  All Categories
    List Selection Should Be  //*[@name='_ftrt']  Ending within
    List Selection Should Be  //*[@name='_ftrv']  1 hour
    List Selection Should Be  //*[@id='_sadis']  15
    List Selection Should Be  //*[@id='_sargnSelect']  US Only
    List Selection Should Be  //*[@id='_salicSelect']  United States
    List Selection Should Be  //*[@id='_saslop']  Include
    List Selection Should Be  //*[@id='LH_SORT_BY']  Best Match
    List Selection Should Be  //*[@id='LH_VIEW_RESULTS_AS']  All items
    List Selection Should Be  //*[@id='LH_IPP']  60
    Radio Button Should Not Be Selected  _fsradio2
    Radio Button Should Be Set To  _fsradio  &LH_SpecificSeller=1

Verify Searching In Different Categories With Option To Exclude Words
    [Arguments]  ${category}
    [Teardown]  Close Browser
    Open Advanced Search Page
    #Wait For Condition  return document.readyState=="complete"  30s
    #Clear Element Text  ${AdvSearchInput}
    #Clear Element Text  ${AdvSearchExclude}
    #Select From List By Label  ${AdvSearchCategories}  Cell Phones & Accessories
    Select From List By Label  ${AdvSearchCategories}  ${category}
    Click Element  ${AdvSearchSubmit}
    Wait For Condition  return document.readyState=="complete"  30s
    ${no result} =  Run Keyword And Return Status  Page Should Contain Element  ${SearchPageWarnMessage}
    IF  ${no result} == False 
        ${text} =  Get Text  ${SearchPageFirstItem}
        #Should Contain  ${text}  ${ADVSEARCH TEXT}  ignore_case=true
        Should Not Contain  ${text}  ${ADVSEARCH EXCLUDE TEXT}  ignore_case=True
        Should Match Regexp  ${text}  (?i)(?=.*watch)(?=.*smart)
        #Page Should Contain Element  //span[text()='${category}' and @tabindex]
    ELSE
        Page Should Contain Element  ${SearchPageWarnMessage}
        Page Should Not Contain Element  //*[@class='searchInAllCats' ]/a
    END

Verify ${text} Does Not Contain @{words}
    FOR  ${word}  IN  @{words}
        Should Not Contain  ${text}  ${word}
    END

Open Advanced Search Page
    Open Browser  ${ADVSEARCH URL}  chrome
    Wait For Condition  return document.readyState=="complete"  30s
    Maximize Browser Window
    Input Text  ${AdvSearchInput}  ${ADVSEARCH TEXT}
    # Input Text  ${AdvSearchExclude}  ${ADVSEARCH EXCLUDE TEXT}

Get A List
    ${CATEGORIES} =  Create List
    ${elements} =  Get Webelements  //*[@id='e1-1']/*
    FOR  ${element}  IN  @{elements}
        ${text} =  Get Text  ${element}
        Append To List  ${CATEGORIES}  ${text}
    END 
    Set Suite Variable  ${CATEGORIES}

Filter Items By Type: "${type of listing}"
    ${type of listing} =  Lookup Table  ${type of listing}
    Click Element  //span[@class='srp-format-tabs-h2' and text()='${type of listing}']/..
    Wait For Condition  return document.readyState=="complete"  30s

Filter Items By Condition: "${conditon}"
    Click Element  //span[@class='filter-menu-button__text' and text()='${condition}']/..
    Wait For Condition  return document.readyState=="complete"  30s

Sort Items By "${type of sorting}"
    IF  '${type of sorting}' != 'Best Match'
        Click Element  //*[@class='srp-controls__sort-label']/..
        Click Element  //span[text()='${type of sorting}']/parent::*[@class='fake-menu-button__item']
        Wait For Condition  return document.readyState=="complete"  30s
    END

Select And Verify Item Number "${number}" From Search Results
    ${list item title} =  Get Text  (//*[@id='srp-river-results']//h3)[${number}]
    Click Element  (//*[@id='srp-river-results']//h3/parent::a)[${number}]
    Switch Window  NEW
    Wait For Condition  return document.readyState=="complete"  30s
    ${item page title} =  Get Text  //*[@class='x-item-title__mainTitle']/span
    Should Be Equal As Strings  ${list item title}  ${item page title}