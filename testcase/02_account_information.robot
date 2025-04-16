*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/common_keywords.robot
Resource   ../resources/common_variables.robot
Test Setup    Page Should Be Ready
*** Keywords ***
Fill Account Information
    [Arguments]    ${title}=id_gender1    ${password}=${VALID PASSWORD}   
    ...    ${day}=1    ${month}=1    ${year}=2000
    Wait Until Element Is Visible    xpath=//b[contains(text(), 'Enter Account Information')]
    Click Element    id=${title}
    Input Password    //*[@data-qa="password"]    ${password}
    Select From List By Value    //*[@data-qa="days"]    ${day}
    Select From List By Value    //*[@data-qa="months"]    ${month}
    Select From List By Value    //*[@data-qa="years"]    ${year}

Fill Address Information
    [Arguments]    ${first_name}=chalaemwut    ${last_name}=phasomsup    ${company}=edd    
    ...    ${address1}=address1    ${address2}=address2    ${country}=Canada    ${state}=state    
    ...    ${city}=city    ${zipcode}=zipcode    ${mobile}=0620902883
    Input Text    //*[@data-qa="first_name"]    ${first_name}
    Input Text    //*[@data-qa="last_name"]    ${last_name}
    Input Text    //*[@data-qa="company"]    ${company}
    Input Text    //*[@data-qa="address"]    ${address1}
    Input Text    //*[@data-qa="address2"]    ${address2}
    Select From List By Value    //*[@data-qa="country"]    ${country}
    Input Text    //*[@data-qa="state"]    ${state}
    Input Text    //*[@data-qa="city"]    ${city}
    Input Text    //*[@data-qa="zipcode"]    ${zipcode}
    Input Text    //*[@data-qa="mobile_number"]    ${mobile}

Subscribe Newsletter
    Select Checkbox    id=newsletter

Subscribe Special Offers
    Select Checkbox    id=optin

Create Account
    Execute Javascript    document.querySelector('[data-qa="create-account"]').click();
*** Test Cases ***
Check Enter Account Info Page
    Wait Until Page Contains    Enter Account Information
    Element Should Be Visible    xpath=//b[contains(text(), 'Enter Account Information')]

Missing Password
    Click Element    xpath=//*[@id="id_gender1"]
    Create Account
    ${msg}=    Get Element Attribute    xpath=//*[@data-qa="password"]    validationMessage
    Should Contain    ${msg}    fill out this field
Valid Account Info
    Fill Account Information
    Fill Address Information
    Create Account
    Wait Until Page Contains    Account Created!
    Wait Until Element Is Visible    xpath=//a[contains(text(), 'Continue')]   
    Scroll Element Into View    xpath=//a[contains(text(), 'Continue')] 
    Click Element  xpath=//a[contains(text(), 'Continue')]