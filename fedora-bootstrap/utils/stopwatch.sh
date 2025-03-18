#!/bin/bash

function stopwatch_start {
    echo ""
    echo "---------------------------"
    echo "[.] Stopwatch started"
    echo "---------------------------"
    echo ""
    start_time=$(date +%s)
}


# Function to display the elapsed time
function stopwatch_elapsed {
    local elapsed=$((end_time - start_time))
    local days=$((elapsed/60/60/24))
    local hours=$((elapsed/60/60%24))
    local minutes=$((elapsed/60%60))
    local seconds=$((elapsed%60))
    echo ""
    echo "---------------------------"
    printf "Time Elapsed: %02d:%02d\n" $minutes $seconds
    echo "---------------------------"
    echo ""
}

# Function to end the stopwatch
function stopwatch_end {
    end_time=$(date +%s)
    echo ""
    echo "---------------------------"
    echo "[.] Stopwatch stopped"
    echo "---------------------------"
    echo ""
    stopwatch_elapsed
}

# Prevent the script from executing when sourced
return 0 2>/dev/null
exit 0
