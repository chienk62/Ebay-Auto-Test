*** Settings ***
Library  SeleniumLibrary
Variables  ../../PageObjects/LoginPage/locators.py


*** Variables ***
${EBAY URL} =  https://www.ebay.com/
${USERNAME} =  lumi.thestoryteller@gmail.com
${PASSWORD} =  \#Iloveebay


*** keywords ***
Open Account Settings Page
    Click Button  ${AccountBtn}
    Wait Until Element Is Visible  ${AccountSettingsLink}
    Click Element  ${AccountSettingsLink}
    Wait For Condition  return document.readyState=="complete"  30s

Change Password
    Wait Until Element Is Visible  ${AccSettingsSecurity}  30s
    Click Element  ${AccSettingsSecurity}
    Wait Until Element Is Visible  ${AccSettingsEditPass}  30s
    Click Element  ${AccSettingsEditPass}
    Sleep  2s
    Input Password  ${AccSettingsEditPassCur}  ${PASSWORD}
    Input Password  ${AccSettingsEditPassNew}  \#Iloveebay
    Input Password  ${AccSettingsEditPassRe}  \#Iloveebay
    Click Element  ${AccSettingsEditPassSaveBtn}
    Sleep  5s
