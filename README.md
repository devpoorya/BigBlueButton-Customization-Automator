# BigBlueButton-Customization-Automator

This is a tool intended for configuring and customizing multiple servers of BigBlueButton with ease.

## What this tool provides
- Updating BigBlueButton properties file and setting welcome messages, etc.
- Deploying recordings post-process scripts to ensure that they are removed after a certain number of days.
- Scheduling recording process phase to ensure that recordings process overnight and not in the peak hours.
- Updating the recordings playback UI with the given HTML, CSS, and JS files.
- Altering the Freeswitch configuration files to disable mute sounds, etc.
- Updating recordings preferences to lower storage consumption and add support for iOS devices.
- Removing the BigBlueButton-Default index page and favicon.
- Changing the default PDF to the desired one.
- Updating HTML5 client title and resetting the Etherpad API key.
- Removing the API Demos to deny un-invited access to server resources.
- Resetting hostname
- Resetting secret ( security salt )
## How to use
Simple.
````
    sudo sh setup.sh -h bbb.example.com -s SECURITY_SALT
````

## File Structure
To understand the file structure you simply need to know the BigBlueButton configuration files. You can dig into the repository and understand the files for yourself with a little time.
