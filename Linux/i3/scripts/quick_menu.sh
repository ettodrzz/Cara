#!/bin/sh

# ┌───────────┐
# │ Variables │
# └───────────┘

qm_count=`pgrep --full --count "xterm -class quickMenu"`
qm_oldest=`pgrep --full --oldest "xterm -class quickMenu"`

# ┌───────────┐
# │ Functions │
# └───────────┘

qm_init()
{
    if [ "$qm_count" -gt 1 ]
    then
        kill $qm_oldest
        qm_main
    else
        qm_main
    fi
}

qm_main()
{
    # Options
    clear
    echo "[u]: Logout"
    # Waits that user select an option
    while true
    do
        read -a input_main -N 1 -r -s
        case "$input_main" in
            [uU])
                qm_exit
                ;;
            [qQ] | $'\e')
                exit
                ;;
        esac
    done
}

qm_exit()
{
    # Options
    clear
    echo "[s]: Suspend"
    echo "[i]: Logout"
    echo "[r]: Reboot"
    echo "[u]: Shutdown"
    # Waits that user select an option
    while true
    do
        read -a input_logout -N 1 -r -s
        case "$input_logout" in
            [sS])
                systemctl suspend
                exit
                ;;
            [iI])
                i3 exit
                ;;
            [rR])
                clear
                echo "Rebooting..."
                sudo reboot
                ;;
            [uU])
                clear
                echo "Shutting down..."
                sudo shutdown now
                ;;
            [qQ] | $'\e')
                exit
                ;;
        esac
    done
}

# ┌───────────┐
# │ Execution │
# └───────────┘

# Disables the shortcut "ctrl + c"
#trap "" SIGINT

# Hides the cursor
tput civis

# Starts the script with the next function
qm_init
