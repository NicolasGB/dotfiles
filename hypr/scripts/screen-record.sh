#!/bin/env nu

# Check if wf-recorder is already running
let recorder_process = (ps | where name == "wf-recorder")

if not ($recorder_process | is-empty) {
    let recorder_process = $recorder_process | first
    # If running, send SIGINT to stop it gracefully
    try {
        kill $recorder_process.pid
        # Give it a moment to finish writing the file
        sleep 500ms
        # Using 'dialog-ok' or 'emblem-ok' icon
        notify-send -i dialog-ok -h string:wf-recorder:record -t 1000 "Finished Recording"
    } catch {
        |err|
        # Using 'dialog-error' icon
        notify-send -i dialog-error -h string:wf-recorder:record -t 2000 "Error stopping recorder, killing all." $err.msg
        killall "wf-recorder"
    }
    exit 0
}


# Get screen region selection from slurp
let geometry = (slurp | str trim)

# Exit if no region was selected (slurp cancelled)
if ($geometry | is-empty) {
    # Using 'dialog-warning' icon
    notify-send -i dialog-warning -h string:wf-recorder:record -t 2000 "Recording Cancelled" "No region selected."
    exit 1
}

# Countdown notifications
notify-send -i video-record -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#90a4f4' font='32px'><i><b>3</b></i></span>"
sleep 1sec

notify-send -i video-record -h string:wf-recorder:record -t 1000 "Recording in:" "<span color='#90a4f4' font='32px'><i><b>2</b></i></span>"
sleep 1sec

notify-send -i video-record -h string:wf-recorder:record -t 950 "Recording in:" "<span color='#90a4f4' font='32px'><i><b>1</b></i></span>"
sleep 950ms

# Prepare filename with timestamp
let dateTime = (date now | format date '%m-%d-%Y-%H:%M:%S')
let output_file = $"($env.HOME)/Videos/($dateTime).gif"

# Start wf-recorder
# Using 'media-record' icon
notify-send -i media-record -h string:wf-recorder:record -t 1000 "<b>Recording Started</b>" $"Saving to:\n<i>($output_file)</i>"
sleep 1sec
wf-recorder --bframes max_b_frames -g $geometry -f $output_file -F fps=30 -c gif

