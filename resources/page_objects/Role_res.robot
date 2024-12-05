*** Settings ***
Resource        ${EXECDIR}/resources/common/Generic_functions.robot
Variables       ${EXECDIR}/config/common_config.yaml


*** Keywords ***
VERIFY ROLE MANAGEMENT
    WAIT UNTIL PAGE CONTAINS ELEMENT AND CLICK  ${ROLE_MANAGEMENT}
    Wait Until Page Contains ${ROLE_MANAGEMENT}