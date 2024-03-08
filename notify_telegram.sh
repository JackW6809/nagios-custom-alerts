#!/bin/bash

# Define your Telegram bot token
TELEGRAM_BOT_TOKEN="<BOT TOKEN>"

# Define your Telegram chat ID
TELEGRAM_CHAT_ID="<CHAT ID>"

# Check if the notification is for a service
if [ "$1" == "SERVICE" ]; then
    if [ "$6" == "WARNING" ]; then
        state="WARNING ⚠️"
    elif [ "$6" == "CRITICAL" ]; then
        state="CRITICAL ❗️"
    elif [ "$6" == "OK" ]; then
        state="OK ✅"
    else
        state="UNKNOWN ❓"
    fi

    # Construct message for service notification
    message="Notification Type: $2\nService: $3\nHostSystem: $4\nAddress: $5\nState: $state\nStatus Information: $8\n\nDuration: $9\nTime & Date: Checked: $7"
else
    if [ "$5" == "UP" ]; then
        state="UP ⬆️"
    elif [ "$5" == "UNREACHABLE" ]; then
        state="UNREACHABLE 🔌"
    else
        state="DOWN ⬇️"
    fi

    # Construct message for host notification
    message="Notification Type: $2\nSystem: $3\nAddress: $4\nState: $state\nStatus Information: $7\n\nDuration: $8\nTime & Date: Checked: $6"
fi

# Define JSON payload
PAYLOAD='{"chat_id": "'"$TELEGRAM_CHAT_ID"'", "text": "*Nagios Monitoring Notification*\n'"$message"'", "parse_mode": "Markdown"}'

# Send POST request to Telegram Bot API
curl -sS -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

