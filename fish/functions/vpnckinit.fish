function vpnckinit
    echo "Connecting to VPN. Enter VPN PIN+Token"
    sudo vpnc
    echo -e "\n"

    echo "Obtaining kerberos ticket. Enter kerberos password"
    kinit
end