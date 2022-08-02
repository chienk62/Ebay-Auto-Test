*** Settings ***
Library  SeleniumLibrary
Library  ../../Resources/KeyConverter.py
Variables  locators.py
Variables  ../../Resources/Data.py


*** Variables ***
${URL} =  https://www.ebay.com/
${USERNAME 1} =  vickyy24599@gmail.com
${PASSWORD 1} =  \Abc@12345
${USERNAME 2} =  lumi.thestoryteller@gmail.com
${PASSWORD 2} =  \#Iloveebay


*** Keywords ***
Open Ebay Home Page
    Open Browser  ${URL}  Chrome  options=add_argument("--disable-site-isolation-trials")
    Wait For Condition  return document.readyState=="complete"  30s
    Maximize Browser Window
    Set Selenium Timeout  20s

Login With Valid Credentials
    Click Element  ${LoginBtn}
    Wait For Condition  return document.readyState=="complete" 
    Verify Yourself
    Wait Until Page Contains Element  ${LoginUsername}
    Input Text  ${LoginUsername}  ${USERNAME 1}
    Press Keys  None  RETURN
    Wait Until Page Contains Element  ${LoginPassword}
    Input Password  ${LoginPassword}  ${PASSWORD}
    Press Keys  None  RETURN
    Wait Until Element Is Not Visible  ${LoginPassword}
    Wait For Condition  return document.readyState=="complete"
    ${havePassBtn}  Run Keyword And Return Status  Page Should Contain Element  ${LoginPassword}
    IF  ${havePassBtn} == True
        Input Text  ${LoginPassword}  ${PASSWORD}
        Press Keys  None  RETURN
        ${haveText}  Run Keyword And Return Status  Page Should Contain  ${USERNAME}
        IF  ${haveText} == True
            Click Button  ${GetSecurityCodeByText}
            Wait Until Page Contains Element  ${VerifyBtn}
            Click Element  ${VerifyBtn}
        END
        ${haveNotRememberPassBtn}  Run Keyword And Return Status  Wait Until Page Contains Element  ${NotRememberPass}
        IF  ${haveNotRememberPassBtn} == True  Click Button  ${NotRememberPass}
    END
    ${haveNotRememberPassBtn}  Run Keyword And Return Status  Wait Until Page Contains Element  ${NotRememberPass}
    IF  ${haveNotRememberPassBtn} == True  Click Button  ${NotRememberPass}
    # Click Button  //button[@id='webauthn-maybe-later-link']
    # Wait For Condition  return document.readyState=="complete"  30s

Open Ebay HomePage And Login Successfully
    Open Ebay HomePage
    Login With Valid Credentials

Verify Yourself
    ${verify yourself} =  Run Keyword And Return Status  Page Should Contain  Please verify yourself to continue
    ${verify contact} =  Run Keyword And Return Status  Page Should Contain  Verify your contact info
    # ${verify} =  Evaluate  ${verify yourself} or ${verify contact}
    IF  ${verify yourself} == True or ${verify contact} == True  Sleep  20s
    # IF  ${verify yourself} == True
    #     Wait Until Page Does Not Contain  Please verify yourself to continue
    # ELSE IF  ${verify contact} == True
    #     Wait Until Page Does Not Contain  Verify your contact info
    # END

Scroll To Element
    [Arguments]  ${locator}
    ${x} =  Get Horizontal Position  ${locator}
    ${y} =  Get Vertical Position  ${locator}
    Execute Javascript  window.scrollTo(${x}, ${y})

Open Category Page "${category}" Under "${section}" Section On A New Window
    Mouse Over  //a[text()='${section}']/parent::*[@data-hover-track]
    Wait Until Element Is Visible  //a[text()='${section}']/..//li/a[text()='${category}']
    Click Element  //a[text()='${section}']/..//li/a[text()='${category}']  CTRL
    Switch Window  NEW
    Wait For Condition  return document.readyState=="complete"  30s

Category Page Should Have The Right Page Header
    ${title link} =  Get Locations
    IF  '&_nkw' in '${title link}[1]'
        Page Should Contain Element  //*[@id='mainContent' and contains(@class,'srp-main-content')]
    ELSE
        ${title link} =  Title Matters  ${title link}[1]
        ${page header} =  Get Text  //h1[@class='b-pageheader']
        ${page header} =  Title Matters  ${page header}
        Should Be Equal As Strings  ${page header}  ${title link}
    END

Category Page Should Have Content
    Page Should Contain Element  //*[@id='mainContent']//div

Come Back To Main Window
    Close Window
    Switch Window  MAIN

Verify All Category Pages On Nav Bar
    [Arguments]  ${category}  ${section}
    [Teardown]  Come Back To Main Window
    Open Category Page "${category}" Under "${section}" Section On A New Window
    Category Page Should Have The Right Page Header
    Category Page Should Have Content