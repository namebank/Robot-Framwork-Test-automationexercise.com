*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/common_keywords.robot
Resource    ../resources/common_variables.robot

Test Setup    Navigate To Products Page

*** Variables ***
${SEARCH_INPUT}    //input[@id='search_product']
${SEARCH_BUTTON}    //button[@id='submit_search']
${PRODUCT_CONTAINER}    //div[@class='features_items']
${BRAND_FILTER}    //div[@class='brands_products']

*** Keywords ***
Navigate To Products Page
    Go To    ${URL}
    Click Element    //a[@href='/products']
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}

Search For Product
    [Arguments]    ${search_term}
    Input Text    ${SEARCH_INPUT}    ${search_term}
    Click Button    ${SEARCH_BUTTON}

*** Test Cases ***
Search For Existing Product
    Search For Product    dress
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}
    Page Should Contain Element    //div[contains(@class, 'productinfo')]
    Page Should Contain    View Product


Search For Non-Existing Product
    Search For Product    xxxxxxxxxxx
    Element Should Not Be Visible    //div[contains(@class, 'productinfo')]
    Page Should Not Contain    View Product

Filter By Brand 
    Scroll And Click   //a[@href='/brand_products/Polo']
    Wait Until Element Is Visible    ${PRODUCT_CONTAINER}
    Page Should Contain Element    //div[contains(@class, 'productinfo')]
