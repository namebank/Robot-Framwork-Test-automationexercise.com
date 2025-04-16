*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Set Default Timeout
    Set Selenium Speed    0s
    Set Selenium Timeout    10s  #defuelt 10
Page Should Be Ready
    Execute Javascript    return document.readyState == "complete";
Java Click Element
    [Arguments]    ${xpath}
    ${el}=    Execute Javascript    return document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue
    Execute Javascript    arguments[0].click();    ${el}
Scroll And Click
    [Arguments]  ${locator}
    Wait Until Element Is Visible   ${locator}
    Scroll Element Into View   ${locator}
    Sleep    0.5s
    Execute Javascript    var el = document.evaluate("${locator}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; el.click();
