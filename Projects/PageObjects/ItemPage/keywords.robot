*** Settings ***
Library  SeleniumLibrary
Library  Collections
Variables  locators.py
Resource  ../SearchPage/keywords.robot
Resource  ../Common/keywords.robot

*** Variables ***
${SEARCH ITEM} =  samsung tab s6 lite


*** Keywords ***
Click "${button}" Button On Item Page
    #IF  '${button}' == 'Add to Watchlist'
    #    Click Element  //*[@id='watch-area']
    #ELSE
    Click Element  //*[@role='button' and contains(text(),'${button}')]
    #END
    Wait For Condition  return document.readyState=="complete"  30s

Click "${checkout option}" Button On Buy It Now Modal
    IF  '${guest or signin}' == 'Close'
        Click Element  //*[@class='clzBtn']
    ELSE
        Click Element  //button[text()='${checkout option}']
        Wait For Condition  return document.readyState=="complete"  30s
    END

Click To "${save or remove}" The First Item On Shopping Cart
    Click Element  (//*[text()='${save or remove}']/../..)[1]
    Wait For Condition  return document.readyState=="complete"  30s

Click "${checkout option}" Button On Checkout Options Modal
    IF  '${guest or signin}' == 'Close'
        Click Element  //*[@class='icon-btn lightbox-dialog__close']
    ELSE
        Click Element  //button[text()='${checkout option}']
        Wait For Condition  return document.readyState=="complete"  30s
    END

Select Variations For Item
    # Check if item has any options
    ${count} =  Get Element Count  (//select[contains(@id,'msku')])

    # If there are options, then select the first one available
    FOR  ${i}  IN RANGE  ${count}
        Click Element  (//select[contains(@id,'msku')])[${i+1}]
        Wait Until Element Is Visible  (//select[contains(@id,'msku')])[${i+1}]/option[not(@disabled) and @id][1]
        Click Element  (//select[contains(@id,'msku')])[${i+1}]/option[not(@disabled) and @id][1]
    END

Verify "${name}" Page is Open
    Page Should Contain Element  //h1[contains(text(),'${name}')]

Check Out As Guest And Verify Item
    ${item page title} =  Get Text  //*[@class='x-item-title__mainTitle']/span
    ${item page price} =  Get Text  //*[@id='prcIsum']
    Click "Buy It Now" Button On Item Page
    Click "Check out as guest" Button On Buy It Now Modal
    Verify "Checkout" Page is Open
    ${checkout item title} =  Get Text  (//*[@class='item-title'])[1]
    ${checkout item price} =  Get Text  (//*[@class='item-price'])[1]
    Should Be Equal As Strings  ${item page title}  ${checkout item title}
    Should Be Equal As Strings  ${item page price}  ${checkout item price}

Add To Cart And Verify Item
    ${item page title} =  Get Text  //*[@class='x-item-title__mainTitle']/span
    ${item page price} =  Get Text  //*[@id='prcIsum']
    Click "Add to cart" Button On Item Page
    Verify "Shopping cart" Page is Open
    ${cart item title} =  Get Text  (//span[@class='BOLD'])[1]
    ${cart item price} =  Get Text  (//*[@class='item-price'])[1]
    Should Be Equal As Strings  ${item page title}  ${cart item title}
    Should Be Equal As Strings  ${item page price}  ${cart item price}

Go To Checkout And Verify Item
    ${cart item title} =  Get Text  (//span[@class='BOLD'])[1]
    ${cart item price} =  Get Text  (//*[@class='item-price'])[1]
    Click Element  //*[text()='Go to checkout']
    Wait Until Element Is Visible  //*[@id='signin-chooser' and @aria-hidden='false']
    Click "Continue as guest" Button On Checkout Options Modal
    Verify "Checkout" Page is Open
    ${checkout item title} =  Get Text  (//*[@class='item-title'])[1]
    ${checkout item price} =  Get Text  (//*[@class='item-price'])[1]
    Should Be Equal As Strings  ${cart item title}  ${checkout item title}
    Should Be Equal As Strings  ${cart item price}  ${checkout item price}

Verify Remove First Item From Shopping Cart
    ${cart item link} =  Get Element Attribute  (//*[@data-test-id='cart-item-link'])[1]  href
    Click To "Remove" The First Item On Shopping Cart
    Wait Until Element Is Not Visible  //*[@data-test-id='cart-item-link' and href='${cart item link}']

Add Item To Watchlist   
    #Verify Yourself
    Click Element  //*[@id='watch-area']
    Wait Until Element Contains  //*[@id='vi-atl-lnk-99']  Watching  30s
    Element Should Be Visible  //*[text()='Added to your ']
        
Verify Item Should Be In Watchlist
    Reload Page
    Wait For Condition  return document.readyState=="complete"  30s
    # Element Should Be Visible  //*[text()='Saved in your ']
    ${title}  ${variations}  ${variation count}  Get Item Title And Variations In Item Page
    Go To Watchlist Page From Item Page  ${title}
    Verify Item In Watchlist  ${title}  ${variations}  ${variation count}

Go To Watchlist Page From Item Page  
    [Arguments]  ${title}
    Click Element  //*[@id='gh-wl-click']
    Wait Until Element Is Visible  //*[@class='rvi__title']/a
    # Element Should Contain  //*[contains(@id,'rvi-carousel-list')]/li[1]//*[@class='gh-info__title']  ${title}
    Click Element  //*[@class='rvi__title']/a
    Wait For Condition  return document.readyState=="complete"  30s

Get Item Title And Variations In Item Page
    ${title} =  Get Text  //*[@class='x-item-title__mainTitle']/span
    ${variations} =  Create List
    ${variation count} =  Get Element Count  (//select[contains(@id,'msku')])
    
    FOR  ${i}  IN RANGE  ${variation count}
        ${variation} =  Get Selected List Label  (//select[contains(@id,'msku')])[${i+1}]
        Append To List  ${variations}  ${variation}
    END
    
    ${variations} =  Evaluate  ' '.join(sorted(@{variations}))
    RETURN  ${title}  ${variations}  ${variation count}

Verify Item In Watchlist
    [Arguments]  ${title}  ${variations}  ${variation count}
    ${variations list} =  Create List
    ${items} =  Set Variable  (//a[text()='${title}']/../../*[@class='item-variations'])
    ${item count} =  Get Element Count  ${items}
    FOR  ${j}  IN RANGE  ${item count}
        ${variations after} =  Create List
        FOR  ${i}  IN RANGE  ${variation count}
            ${variation} =  Get Text  ${items}\[${j+1}\]//li[${i+1}]
            ${variation} =  Evaluate  '${variation}'.split(':')[-1].strip()
            Append To List  ${variations after}  ${variation}
        END
        ${variations after} =  Evaluate  ' '.join(sorted(@{variations after}))
        Append To List  ${variations list}  ${variations after}
    END
    List Should Contain Value  ${variations list}  ${variations}

Select Item Number "${number}" From Watchlist
    IF  '${number}' == 'All'
        Click Element  (//*[@class='m-checkbox'])[1]
    ELSE    
        ${number} =  Evaluate  int(${number})
        Click Element  (//*[@class='m-checkbox'])[${number+1}]
    END

Click "${name}" Button On Watchlist Page
    Click Element  //*[@class='m-cta']/*[text()='${name}']

Verify Item Is Deleted From Watchlist
    Wait Until Element Is Visible  //*[@class='info-msg']
    Element Should Contain  //*[@class='info-msg']  1 item was deleted from Watchlist.

Sort Watchlist By "${type}"
    Click Element  //label[text()='Sort:']/following-sibling::span
    Click Element  //*[@class='menu-button__item m-menu-item']/span[text()='${type}']
    Wait Until Element Is Not Visible  //*[@class='m-throbber middle-wrapper-throbber']

Verify Discount
    Click Element  //*[@class='gh-p' and contains(text(),'Daily Deals')]
    Wait For Condition  return document.readyState=="complete"
    #//*[text()='Fashion for Men']/parent::h2/../following-sibling::*//*[@class='item']
    Select Item Number "2" From Featured Deals Section On Daily Deals
    Sleep  2s

Select Item Number "${number}" From Featured Deals Section On Daily Deals
    #Scroll To Element  (//*[text()='${section}']/parent::h2/../following-sibling::*//*[@itemscope and @data-listing-id])[${number}]/a
    Click Element  (//*[text()='Featured Deals']/parent::h2/../following-sibling::*//*[@itemscope and @data-listing-id]/a/div)[${number}]
    # Click Element  (//*[text()='${section}']/parent::h2/following-sibling::*//*[@itemscope and @data-listing-id]/a/div)[${number}]
    Wait For Condition  return document.readyState=="complete"