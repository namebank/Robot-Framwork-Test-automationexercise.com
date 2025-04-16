*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Resource    ../resources/common_keywords.robot
Resource    ../resources/common_variables.robot

Test Setup    Navigate To Login Page
Test Tags  e2e
*** Variables ***

${INVALID_PASSWORD}  12345678 
*** Keywords ***

Navigate To Login Page
    Go To    ${URL}
    Click Element    //i[contains(@class, 'fa-lock')]
    Wait Until Element Is Visible    //h2[contains(text(),'Login to your account')]

Fill Login Form
    [Arguments]    ${email}    ${password}
    Input Text    xpath=//*[@data-qa="login-email"]    ${email}
    Input Text    xpath=//*[@data-qa="login-password"]    ${password}
    Click Button    xpath=//*[@data-qa="login-button"]

Clear Login Form
    Clear Element Text    xpath=//*[@data-qa="login-email"]
    Clear Element Text    xpath=//*[@data-qa="login-password"]

*** Test Cases ***
Setup Browser
    [Tags]    browser
    Set Default Timeout
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Invalid Email
    Fill Login Form    ${INVALID EMAIL}    ${VALID PASSWORD}
    Wait Until Element Is Visible    //p[contains(text(),'Your email or password is incorrect!')]
    Element Should Be Visible    //p[contains(text(),'Your email or password is incorrect!')]

Invalid Password
    Fill Login Form    ${VALID_EMAIL}    ${INVALID_PASSWORD}
    Wait Until Element Is Visible    //p[contains(text(),'Your email or password is incorrect!')]
    Element Should Be Visible    //p[contains(text(),'Your email or password is incorrect!')]

Empty Email
    Fill Login Form    ${EMPTY}    ${VALID_PASSWORD}
    ${msg}=    Get Element Attribute    xpath=//*[@data-qa="login-email"]    validationMessage
    Should Contain    ${msg}    Please fill out this field

Empty Password
    Fill Login Form    ${VALID_EMAIL}    ${EMPTY}
    ${msg}=    Get Element Attribute    xpath=//*[@data-qa="login-password"]    validationMessage
    Should Contain    ${msg}    Please fill out this field

Empty Email And Password
    Fill Login Form    ${EMPTY}    ${EMPTY}
    ${msg}=    Get Element Attribute    xpath=//*[@data-qa="login-email"]    validationMessage
    Should Contain    ${msg}    Please fill out this field

Invalid Email Format
    Fill Login Form    invalid.email    ${VALID_PASSWORD}
    ${msg}=    Execute Javascript    return document.querySelector('[data-qa="login-email"]').validationMessage;
    Should Contain    ${msg}    include an '@'
Valid Login
    Fill Login Form    ${VALID_EMAIL}    ${VALID PASSWORD}
    Wait Until Element Is Visible    //a[contains(text(),' Logged in as')]
    Element Should Be Visible    //a[contains(text(),' Logged in as')]