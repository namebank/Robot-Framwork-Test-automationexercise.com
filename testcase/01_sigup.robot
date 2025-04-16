*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Resource    ../resources/common_keywords.robot
Resource   ../resources/common_variables.robot
Suite Setup  Setup and Open Browser 
# Suite Teardown    Close Browser
Test Setup  Page Should Be Ready
#Task Teardown  Clear Sigup Form
*** Variables ***
${BROWSER}    chrome
${URL}  https://automationexercise.com/

${VALID NAME}  chalaemwut

${EXIST EMAIL}  test@test.com
*** Keywords ***
Setup and Open Browser 
    Set Default Timeout
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Fill Signup Form
    [Arguments]    ${name}    ${email}
    Input Text    xpath=//*[@data-qa="signup-name"]     ${name}
    Input Text    xpath=//*[@data-qa="signup-email"]    ${email}
    Click Button  xpath=//*[@data-qa="signup-button"]
Clear Sigup Form
    Clear Element Text    xpath=//*[@data-qa="signup-name"]
    Clear Element Text    xpath=//*[@data-qa="signup-email"]  
    
*** Test Cases ***
Navagator Sigup
    Click Element    //i[contains(@class, 'fa-lock')]
Empty Name
    Fill Signup Form   ${EMPTY}  ${VALID EMAIL}
    ${msg} =    Get Element Attribute    xpath=//*[@data-qa="signup-name"]    validationMessage
    Should Contain   ${msg}    Please fill out this field.
Empty Email
    Fill Signup Form   ${VALID NAME}  ${EMPTY}
    ${msg} =  Get Element Attribute    xpath=//*[@data-qa="signup-email"]    validationMessage
    Should Contain    ${msg}    Please fill out this field.
Empty Name And Email
    Fill Signup Form   ${EMPTY}  ${Empty}
    ${msg} =    Get Element Attribute    xpath=//*[@data-qa="signup-name"]    validationMessage
    Should Contain   ${msg}    Please fill out this field.
Invalid Email Format
    Fill Signup Form   ${VALID NAME}  abc123
    ${msg}=    Execute Javascript    return document.querySelector('[data-qa="signup-email"]').validationMessage;
    Should Contain    ${msg}    include an '@'
Exist Email
    Fill Signup Form   ${VALID NAME}  ${EXIST EMAIL}
    Wait Until Element Is Visible    xpath=//p[contains(text(), 'Email Address already exist!')]
    Element Should Contain    xpath=//p[contains(text(), 'Email Address already exist!')]    Email Address already exist!
Valid Name And Email
    Fill Signup Form   ${VALID NAME}  ${VALID EMAIL}
    Wait Until Page Contains Element    xpath=//b[contains(text(), 'Enter Account Information')]
