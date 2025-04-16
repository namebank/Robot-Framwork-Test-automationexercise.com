* Settings ***
Library    SeleniumLibrary
Resource    ../resources/common_keywords.robot
Resource    ../resources/common_variables.robot

Test Setup    Setup Cart

*** Variables ***
${CHECKOUT_BUTTON}    //a[contains(@class, 'check_out')]
${PLACE_ORDER}    //a[contains(@href, 'payment')]
${CARD_NAME}    //input[@name='name_on_card']
${CARD_NUMBER}    //input[@name='card_number']
${CARD_CVC}    //input[@name='cvc']
${CARD_EXPIRY_MONTH}    //input[@name='expiry_month']
${CARD_EXPIRY_YEAR}    //input[@name='expiry_year']
${VIEW_CART}    //a[contains(@href, 'view_cart')]
*** Keywords ***
Setup Cart

    Scroll And Click    ${VIEW_CART}

Fill Payment Details
    [Arguments]    ${name}    ${number}    ${cvc}    ${expiry_month}  ${expiry_year}
    Input Text    ${CARD_NAME}    ${name}
    Input Text    ${CARD_NUMBER}    ${number}
    Input Text    ${CARD_CVC}    ${cvc}
    Input Text    ${CARD_EXPIRY_MONTH}    ${expiry_month}
    Input Text    ${CARD_EXPIRY_YEAR}    ${expiry_year}

*** Test Cases ***

Checkout Without Payment Details
    Scroll And Click    ${CHECKOUT_BUTTON}
    Scroll And Click    ${PLACE_ORDER}
    Scroll And Click     //button[@id='submit']
    Element Attribute Value Should Be    ${CARD_NAME}    validationMessage    Please fill out this field.
Complete Checkout With Valid Payment
    Scroll And Click    ${CHECKOUT_BUTTON}
    Scroll And Click    ${PLACE_ORDER}
    Fill Payment Details    John Doe    4242424242424242    123    12/25  2030
    Scroll And Click    //button[@id='submit']
    Wait Until Element Is Visible    xpath=//p[text()='Congratulations! Your order has been confirmed!']
    Element Should Contain    xpath=//p[text()='Congratulations! Your order has been confirmed!']    Congratulations! Your order has been confirmed!