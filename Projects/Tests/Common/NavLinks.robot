*** Settings ***
Library  SeleniumLibrary
Library  ../../Resources/KeyConverter.py
Variables  ../../PageObjects/Common/locators.py
Variables  ../../Resources/Data.py
Resource  ../../PageObjects/Common/keywords.robot

Suite Setup  Open Ebay Page
Suite Teardown  Close All Browsers

*** Test Cases ***
Each Category Page Should Be Valid
    [Tags]  test2
    [Template]  Verify All Category Pages On Nav Bar
    FOR  ${section}  IN  @{CATEGORIES}
        FOR  ${category}  IN  @{CATEGORIES}[${section}]
            ${category}  ${section}
        END
    END
