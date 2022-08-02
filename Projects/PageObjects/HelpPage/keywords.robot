*** Settings ***
Library  SeleniumLibrary
Library  Collections
Variables  locators.py
Variables  ../Common/locators.py
Resource  ../Common/keywords.robot


*** Variables ***


*** Keywords ***
Open Ebay Help Page
    Open Ebay Page
    Click Element  //*[@id='gh-p-3']/a
    Wait For Condition  return document.readyState=="complete"  30s

Click On "${section}" Section On Help Page
    Click Element  //*[text()='${section}']/../..
    Wait For Condition  return document.readyState=="complete"  30s

Expand All Articles
    ${more articles} =  Get Webelements  //*[contains(text(),'more articles')]
    FOR  ${article}  IN  @{more articles}
        Click Element  ${article}
    END
    Wait For Condition  return document.readyState=="complete"  30s
    #Click Element  //a[text()='Getting Started']

Open All Articles And Verify Contents
    ${all articles} =  Get Webelements  //*[@class='cate_list']//*[@class='columnItem']/a/div[@class='columnHead']
    FOR  ${article}  IN  @{all articles}[:10]
        ${title} =  Get Text  ${article}
        Scroll To Element  ${article}
        Click Element  ${article}  CTRL
        Switch Window  NEW
        Wait For Condition  return document.readyState=="complete"  30s
        ${article title} =  Get Text  //h1
        Should Be Equal As Strings  ${title}  ${article title}
        Page Should Contain Element  //*[@class='article_main_container']//p[text()]
        Close Window
        Switch Window  MAIN
    END

