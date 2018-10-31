#!/bin/zsh

# Usage: battstat [options] format
# Credit: https://github.com/imwally/battstat
#
# options:
#     -h, --help                display help information
#     -c, --charging-icon       string to display in icon's place when battery is charging
#     -d, --discharging-icon    string to display in icon's place when battery is discharging
#     --percent-when-charged    only display percent when charged

# format:
#     {i}    display icon
#     {t}    display time remaining
#     {p}    display percent
# Note: There must be a space between each format token

battstat() {

    exit_no_battery() {
        return
    }

    get_darwin_details() {
        battery_details=$(pmset -g batt)

        # Exit if no battery exists.
        if ! echo -n "$battery_details" | grep -q InternalBattery; then
            exit_no_battery
        fi
        
        charged=$(echo -n "$battery_details" | grep -w 'charged')
        charging=$(echo -n "$battery_details" | grep -w 'AC Power')
        discharging=$(echo -n "$battery_details" | grep -w 'Battery Power')
        time=$(echo -n "$battery_details" | grep -Eo '([0-9][0-9]|[0-9]):[0-5][0-9]')
        percent=$(echo -n "$battery_details" | grep -o "[0-9]*"%)
    }

    get_linux_details() {
        battery_details=$(LC_ALL=en_US.UTF-8 upower -i $(upower -e | grep 'BAT'))
        
        # Exit if no batery exists.
        if [[ -z "$battery_details" ]]; then
            exit_no_battery
        fi
        
        charged=$(echo -n "$battery_details" | grep 'state' | grep -w 'fully-charged')
        charging=$(echo -n "$battery_details" | grep 'state' | grep -w 'charging')
        discharging=$(echo -n "$battery_details" | grep 'state' | grep -w 'discharging')
        percent=$(echo -n "$battery_details"| grep 'percentage' | awk '{print $2}')
        
        case $(echo -n "$battery_details" | grep 'time' | awk '{print $5}') in
        "hours")
            hours=$(echo -n "$battery_details" | grep 'time' | awk '{print $4}' | cut -d . -f1)
            minutes=$(echo -n "$battery_details" | grep 'time' | awk '{print $4}' | cut -d . -f2)
            minutes=$(echo -n .$minutes \* 60 | bc -l | cut -d. -f1)
            ;;
        "minutes")
            minutes=$(echo -n "$battery_details" | grep 'time' | awk '{print $4}' | cut -d . -f1)
            ;;
        esac

        # Diplay 0 in the hours spot when only minutes remain.
        if [[ -z "$hours" ]]; then
            hours="0"
        fi

        # Prefix 0 when minutes drop below 10.
        if [[ ${#minutes} -eq '1' ]]; then
            minutes="0$minutes"
        fi
        
        time=$hours:$minutes
    }

    get_openbsd_details() {
        battery_details=$(apm)

        # Exit if no battery exists.
        if [[ -z "$battery_details" ]]; then
        exit_no_battery
        fi

        charging=$(echo -n $battery_details | grep -w 'state: connected')
        discharging=$(echo -n $battery_details | grep -w 'state: not connected')
        percent=$(echo -n $battery_details | grep -o '[0-9]*%')
        full_minutes=$(echo -n $battery_details | grep -o ' [0-9]* ')

        # Battery is considered charged when AC is connected and 100%
        if [[ ! -z "$charging" ]] && [[ $percent = "100%" ]]; then
            charged="charged"
        fi
    
        # Only compute time when available
        if [[ ! -z "$full_minutes" ]]; then
            hours=$(($full_minutes/60))
            minutes=$(($full_minutes%60))

            # Prefix 0 when minutes drop below 10.
            if [[ ${#minutes} -eq '1' ]]; then
            minutes="0$minutes"
            fi
            
            time=$hours:$minutes
        fi
    }

    hide_percent_until_charged() {
        if [[ -z "$charged" ]]; then
            percent=""
        fi
    }   

    print_icon() {
        if [[ ! -z "$charging" ]] || [[ ! -z "$charged" ]]; then
            icon=$charging_icon
        elif [[ ! -z "$discharging" ]]; then
            icon=$discharging_icon
        fi
        
        [[ $GAUDI_ENABLE_SYMBOLS == true ]] && echo -n "$icon "
    }

    print_time() {
        # Display "calc..." when calculating time remaining.
        if [[ -z "$time" ]] || [[ $time = "0:00" ]]; then
          time="calculating..."
        fi

        # Hide time when fully charged.
        if [[ ! -z "$charged" ]]; then
            time=""
        fi
        
        if [[ ! -z "$time" ]]; then
            printf " %s " $time
        fi

    }

    print_background() {
        # Remove trailing % and symbols for comparison
        battery_percent="$(echo -n $percent | tr -d '%[,;]')"
        # Change color based on battery percentage
        if [[ $battery_percent == 100 || ! -z "$charged" ]]; then
            echo -n "$GREEN"
        elif [[ $battery_percent -lt $threshold ]]; then
            echo -n "$RED"
        else
            echo -n "$YELLOW"
        fi
    }

    print_percent() {
        if [[ ! -z "$percent" ]]; then
            echo -n "$percent %%"
        fi
    }

    case $(uname) in
        "Darwin")
        get_darwin_details
        ;;
        "Linux")
        get_linux_details
        ;;
        "OpenBSD")
        get_openbsd_details
        ;;
        *)
        echo -n "N/A"
        return
        ;;
    esac

    if [[ $# -eq 0 ]]; then
        print_background
        print_time
        print_percent
        print_icon
    fi

    while test $# -gt 0; do
        case "$1" in
        --percent-when-charged)
            hide_percent_until_charged
            shift
            ;;
        -c|--charging-icon)
            charging_icon="$2"
            shift
            shift
            ;;
        -d|--discharging-icon)
            discharging_icon="$2"
            shift
            shift
            ;;
        -t|--threshold)
            threshold="$2"
            shift
            shift
            ;;
        {b})
            print_background
            shift
            ;;         
        {i})
            print_icon
            shift
            ;;
        {t})
            print_time
            shift
            ;;
        {p})
            print_percent
            shift
            ;;
        *)
            print_help
            break
            ;;
        esac
    done
}