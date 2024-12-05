*** Keywords ***
TEST SETUP
    VERIFY HOMEPAGE

TEST TEARDOWN
    Capture Page Screenshot

SUITE SETUP
    LAUNCH APPLICATION IN BROWSER
    SIGN IN

SUITE TEARDOWN
    Close Browser