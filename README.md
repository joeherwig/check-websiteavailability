# check-websiteavailability
is a set of scripts for checking whether a list of websites work correct.

# Why?
We're running applications wich are connected to tenths of Websites to be used in the clients processes. Manual checking whether the sites are available or whether the credentials still suit, is quite annoying, time consuming and not very fault tolerant. Due to that i created a small set of scripts for doing this automatically. If course it can be easily extended for other / more websites, and even further web-automation can be easily implemented.

## Installation
just download the folder as zip, deflate, and execute the check-webaccess.ps1 powershell script.

It will run over all ps1 within the 'test'-folder execute them in parallel as background-jobs and collect their results for being displayed at the command line.

## config
you only need to add 'your' website-checks as separate files underneath the 'test' path.
See the moodle-examples included in this repo.
