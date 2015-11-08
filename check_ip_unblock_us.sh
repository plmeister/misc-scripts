#!/bin/sh

USERNAME="xxxxxx"
PASSWORD="xxxxxx"

echo "Checking current IP"
touch /tmp/current.ip.tmp
CURRENT_IP=$(/usr/bin/curl ifconfig.me/ip)
OLD_IP=$(cat /tmp/current.ip.tmp)

if [ "$CURRENT_IP" != "$OLD_IP" ]; then
        if [ "$CURRENT_IP" = ""]; then
                echo "Current IP unavailable"
        else
                if [ "$OLD_IP" = "" ]; then
                        echo "IP has changed from $OLD_IP to $CURRENT_IP"
                else
                        echo "Current IP is $CURRENT_IP"
                fi
                echo "$CURRENT_IP" > /tmp/current.ip.tmp
                echo "Updating Unblock-US with new IP ${CURRENT_IP}"
                RESPONSE=$(/usr/bin/curl "https://api.unblock-us.com/login?${USERNAME}:${PASSWORD}")
                echo "Unblock-US response was: ${RESPONSE}"
        fi
fi
