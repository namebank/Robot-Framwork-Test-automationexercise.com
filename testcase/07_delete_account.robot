*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Resource    ../resources/common_keywords.robot
Resource    ../resources/common_variables.robot

Test Tags  e2e
*** Variables ***
${DELETE_ACCOUNT_BUTTON}    //a[contains(@href, 'delete_account')]
${ACCOUNT_DELETED_MESSAGE}    //b[contains(text(),'Account Deleted!')]
${CONTINUE_BUTTON}    //a[@data-qa='continue-button']

*** Keywords ***



Login With Valid Account
    Go To    ${URL}
    Click Element    //i[contains(@class, 'fa-lock')]
    Wait Until Element Is Visible    //h2[contains(text(),'Login to your account')]
    Input Text    xpath=//*[@data-qa="login-email"]    ${VALID_EMAIL}
    Input Text    xpath=//*[@data-qa="login-password"]    ${VALID_PASSWORD}
    Click Button    xpath=//*[@data-qa="login-button"]
    Wait Until Element Is Visible    //a[contains(text(),' Logged in as')]

Delete Account
    Login With Valid Account
    Click Element    ${DELETE_ACCOUNT_BUTTON}
    Wait Until Element Is Visible    ${ACCOUNT_DELETED_MESSAGE}
    Element Should Be Visible    ${ACCOUNT_DELETED_MESSAGE}

*** Test Cases ***
Setup Browser
    [Tags]    browser
    Set Default Timeout
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
Delete Successfully
    Delete Account
    Element Should Be Visible    ${ACCOUNT_DELETED_MESSAGE}
    Element Should Be Visible    ${CONTINUE_BUTTON}
    Click Element    ${CONTINUE_BUTTON}
    Wait Until Location Contains    ${URL}
    
Cannot Access After Delete
    Click Element    //i[contains(@class, 'fa-lock')]
    Wait Until Element Is Visible    //h2[contains(text(),'Login to your account')]
    Input Text    xpath=//*[@data-qa="login-email"]    ${VALID_EMAIL}
    Input Text    xpath=//*[@data-qa="login-password"]    ${VALID_PASSWORD}
    Click Button    xpath=//*[@data-qa="login-button"]
    Wait Until Element Is Visible    //p[contains(text(),'Your email or password is incorrect!')]
    Element Should Be Visible    //p[contains(text(),'Your email or password is incorrect!')]