*** Settings ***
Library    SeleniumLibrary
Library    ${EXECDIR}/resources/common/NetworkLoggingKeywords.py
Resource   ${EXECDIR}/resources/common/Generic_functions.robot

Suite Setup     SUITE SETUP
Suite Teardown  SUITE TEARDOWN

Test Setup      TEST SETUP
Test Teardown   Run Keyword If Test Failed  TEST TEARDOWN

*** Test Cases ***

TC1: Verify HomePage Launch
    [Tags]    TC1
    Start Network Logging
    ${requests}=    Get Network Requests
    Log    ${requests}
    Save Network Traffic As Har    test_traffic.har
    Stop Network Logging

