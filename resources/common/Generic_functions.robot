*** Settings ***
Library         SeleniumLibrary  screenshot_root_directory=${EXECDIR}/Screenshots/
Library         OperatingSystem
Library         String
Library         Collections
Library         Dialogs
Library         DateTime
Library         Process
Library         JSONLibrary
Library         XML


Variables       ${EXECDIR}/config/common_config.yaml
Resource        ${EXECDIR}/resources/common/Setup_Teardown.robot

*** Keywords ***
WAIT UNTIL PAGE CONTAINS ELEMENT AND CLICK
    [Arguments]  ${element}  ${timeout}=10s
    Wait Until Page Contains Element  ${element}  ${timeout}
    Click Element  ${element}

WAIT UNTIL ELEMENT IS CLICKABLE AND CLICK
    [Arguments]  ${element_to_be_clicked}  ${TIMEOUT}=10  ${element_name}=desired
    Wait Until Element Is Visible    ${element_to_be_clicked}  ${TIMEOUT}
    Click Element  ${element_to_be_clicked}
    [Return]  True

SCROLL PAGE TO LOCATION
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

SCROLL BY SWIPE DOWN
    [Arguments]  ${variable}
	${width}  ${height} =  get window size
	${width}  ${newheight} =  Get Window Size
	${height}  Evaluate  ${newheight} / 5
    ${result}  Set Variable   False
    FOR  ${i}  IN RANGE  0  30
        ${result}  run keyword and return status  wait until element is visible  ${variable}  5S
        IF  ${result}  Wait Until Page Contains Element  ${variable}  5S
        Exit For Loop If  '${result}'=='True'
        execute javascript  window.scroll(${x},${height})
        ${x}  Evaluate  ${x} + ${height}
        ${height}  Evaluate  ${x} + ${height}
        builtin.sleep  5
    END
    IF  '${result}'=='True'
        log to console  ${variable} Found
    ELSE
        Fail  ${variable} not-found
    END

SCROLL TO TOP
    Log To Console  Scrolling to top
    Swipe By Percent    50  65  50  95  1000
    Swipe By Percent    50  65  50  95  1000
    Swipe By Percent    50  65  50  95  1000

SCROLL UP AND CLICK
    [Arguments]  ${locator}  ${error_message}
    Log To Console  Scrolling up and clicking on    ${locator}
    FOR  ${i}  IN RANGE  0  50
        ${is_found}  run keyword and return status  Page Should Contain Element  ${locator}
        IF  '${is_found}'=='True'
            Click Element  ${locator}
            BREAK
        END
    END
    IF  '${is_found}'=='False'
        FAIL  Desired Element for ${error_message} not found after 10 scrolls
    END

SCROLL BY SWIPE
    [Arguments]  ${variable}
    ${width}  ${newheight} =  Get Window Size
    ${height}  Evaluate  ${newheight} / 5
    ${result}  Set Variable   False
    FOR  ${i}  IN RANGE  0  30
        ${result}  run keyword and return status  wait until element is visible  ${variable}  5S
        IF  ${result}
            Scroll Element Into View  ${variable}
            Click Element  ${variable}
        END
        Exit For Loop If  '${result}'=='True'
        ${eof} =    Execute JavaScript    return (window.innerHeight + window.scrollY) >= document.body.offsetHeight
        IF  '${eof}'=='True'
            Log To Console  We have reached the end of webpage
            BREAK
        END
        ${x}  Evaluate  ${x} + ${height}
        ${height}  Evaluate  ${x} + ${height}
        execute javascript  window.scroll(${x},${height})
        Sleep  1s
    END
    IF  '${result}'=='True'
        log to console  ${variable} Clicked
    ELSE
        Fail  ${variable} not-found
    END

SCROLL DOWN TO ELEMENT
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=20s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    ${locator}    timeout=20s

ELEMENT SHOULD BE DISABLED
    [Arguments]    ${locator}
    Element Attribute Value Should Be    ${locator}    disabled    true

LAUNCH APPLICATION IN BROWSER
    ${options}=    Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    ${driver}=    Create Webdriver    Chrome    options=${options}
    Maximize Browser Window
    Go To   https://dev.com/
    Set Selenium Speed  0.5s