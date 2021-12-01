*** Settings ***
Library   Process

*** Variables ***


*** Keywords ***

Get local ip
    [Documentation]    Get local machine ip address eth1 or eth0
    ${rc}  ${ip}=    Run And Return Rc And Output    %{IDEATE_DIR}/lib/base/bin/get_local_ip.sh
    Should Be Equal As Integers   ${rc}   0
    Should Not Be Equal As Strings   ${ip}   error    get_local_ip.sh return 'error'
    [Return]  ${ip}
取得本机ip地址
    ${ip}=   Get local ip
    [Return]   ${ip}
 
