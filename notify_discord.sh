#!/bin/bash

# Define your webhook URL
WEBHOOK_URL="<WEBHOOK URL>"

if [ "$1" == "SERVICE" ]; then
    if [ "$6" == "WARNING" ]; then
        state="WARNING :warning:"
        colour=16776960
    elif [ "$6" == "CRITICAL" ]; then
        state="CRITICAL :exclamation:"
        colour=16711680
    elif [ "$6" == "OK" ]; then
        state="OK :white_check_mark:"
        colour=25600
    else
        state="UNKNOWN :question:"
        colour=16753920
    fi
    # Define JSON payload
    PAYLOAD='{
        "tts": false,
        "embeds": [
            {
                "title": "Nagios Monitoring Notification",
                "color": '$colour',
                "fields": [
                    {
                    "name": "Notification Type",
                    "value": "'$2'"
                    },
                    {
                    "name": "Service Details",
                    "value": "Service: '$3'\nHostSystem: '$4'\nAddress: '$5'\nState: '$state'"
                    },
                    {
                    "name": "Status Information",
                    "value": "'$8'"
                    },
                    {
                    "name": "Duration",
                    "value": "'$9'"
                    },
                    {
                    "name": "Time & Date",
                    "value": "Checked: '$7'"
                    }
                ]
            }
        ]
    }'
else
    if [ "$5" == "UP" ]; then
        state="UP :arrow_up:"
        colour=25600
    elif [ "$5" == "UNREACHABLE" ]; then
        state="UNREACHABLE :electric_plug:"
        colour=9109504
    else
        state="DOWN :arrow_down:"
        colour=0
    fi
    # Define JSON payload
    PAYLOAD='{
        "tts": false,
        "embeds": [
            {
                "title": "Nagios Monitoring Notification",
                "color": '$colour',
                "fields": [
                    {
                    "name": "Notification Type",
                    "value": "'$2'"
                    },
                    {
                    "name": "Host System Details",
                    "value": "System: '$3'\nAddress: '$4'\nState: '$state'"
                    },
                    {
                    "name": "Status Information",
                    "value": "'$7'"
                    },
                    {
                    "name": "Duration",
                    "value": "'$8'"
                    },
                    {
                    "name": "Time & Date",
                    "value": "Checked: '$6'"
                    }
                ]
            }
        ]
    }'
fi

# Send POST request to Discord webhook URL
curl -sS -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "$WEBHOOK_URL"