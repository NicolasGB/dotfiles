#!/usr/bin/env nu

mut bookmark = (jj log -r @ --no-graph -T 'bookmarks' 
    | str trim)

if ($bookmark | is-empty ) {
    print "The current change does not have a bookmark."
    print "Checking for @- commit."

    $bookmark = (jj log -r @- --no-graph -T 'bookmarks' | str trim)

    if ($bookmark | is-empty ) {
        print "The @- commit also does not have a bookmark."
        exit 1
    } else {
        print $"Found bookmark '($bookmark)' on @- commit."
    }
}

$bookmark | str trim -c "*"

let raw_url = (jj git remote list 
    | lines 
    | where ($it | str contains "origin") 
    | first 
    | split row " " 
    | get 1 
    | str replace --regex '\.git$' "")

# If the repo was cloned by ssh
let repo_url = if ($raw_url | str starts-with "git@") {
    let repo_path = ($raw_url | split row ":" | get 1)
    $"https://github.com/($repo_path)"
} else {
    $raw_url
}

let encoded_bookmark = ($bookmark | url encode)

let pr_url = $"($repo_url)/compare/($encoded_bookmark)?expand=1"

xdg-open $pr_url | null

