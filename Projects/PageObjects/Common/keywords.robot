***Settings***
Library  Selenium2Library
Variables  ./locators.py


***Variables***
${USERNAME} =  vickyy24599@gmail.com
${PASSWORD} =  \Abc@12345

***Keywords***
Open Ebay Home Page
    Open Browser  ${URL}  Chrome  options=add_argument("--disable-site-isolation-trials")
    Sleep  1s
    Maximize Browser Window

Login With Valid Credentials
    Click Element  ${LoginBtn}
    Wait Until Page Contains Element  ${LoginUsername}  15s
    Input Text  ${LoginUsername}  ${USERNAME}
    Press Keys  None  RETURN
    Sleep  1s
    Wait Until Page Contains Element  ${LoginPassword}  15s
    Input Password  ${LoginPassword}  ${PASSWORD}
    Press Keys  None  RETURN
    Wait Until Element Is Not Visible  ${LoginPassword}
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
    # Wait For Condition  return document.readyState=="complete"  30s

Open Ebay HomePage And Login Successfully
    Open Ebay HomePage
    Login With Valid Credentials
