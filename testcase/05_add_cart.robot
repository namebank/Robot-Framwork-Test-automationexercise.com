*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/common_keywords.robot
Resource    ../resources/common_variables.robot

Test Setup    Navigate To Products Page

*** Variables ***
${CART_MODAL}    //div[@id='cartModal']
${VIEW_CART}    //a[contains(@href, 'view_cart')]
${CHECKOUT_BUTTON}    //a[contains(@class, 'check_out')]

*** Keywords ***
Add Product To Cart
    [Arguments]    ${product_index}
    Mouse Over    //div[@class='productinfo text-center']/a[@data-product-id="${product_index}"]
    Scroll And Click    //div[@class='productinfo text-center']/a[@data-product-id='${product_index}']
    Wait Until Element Is Visible    ${CART_MODAL}

Navigate To Products Page
    Go To    ${URL}
    Scroll And Click    //a[@href='/products']
    Wait Until Element Is Visible    //div[@class='features_items']

*** Test Cases ***
Add Single Product To Cart
    Add Product To Cart    1
    Scroll And Click    ${VIEW_CART}
    Wait Until Page Contains Element    //table[@id='cart_info_table']
    Page Should Contain Element    //tr[@id='product-1']

Add Multiple Products To Cart
    Add Product To Cart    1
    Scroll And Click    //button[@data-dismiss='modal']
    Add Product To Cart    2
    Scroll And Click    ${VIEW_CART}
    Page Should Contain Element    //tr[@id='product-1']
    Page Should Contain Element    //tr[@id='product-2']

Remove Product From Cart
    Add Product To Cart    1
    Scroll And Click    ${VIEW_CART}
    Scroll And Click    //a[@class='cart_quantity_delete']
    Wait Until Page Does Not Contain Element    //tr[@id='product-1']

Add Product Quantity
    Add Product To Cart    1
    Scroll And Click    ${VIEW_CART}
    Scroll And Click   //a[@href='/product_details/1']
    Input Text    //input[@id='quantity']    2
    Click Button    //button[contains(., 'Add to cart')]
    Wait Until Element Is Visible    //button[contains(., 'Continue Shopping')]
    Click Button    //button[contains(., 'Continue Shopping')]
    # Element Should Contain    //p[@class='cart_total_price']    Updated