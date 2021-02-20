#!/bin/bash
if [ `whoami` != 'root' ]
  then
    echo "You should run this tool using sudo."
    exit
fi

while getopts h:s: flag
do
    case "${flag}" in
        h) HOSTNAME=${OPTARG};;
        s) SECRET=${OPTARG};;
    esac
done

#Credit
echo "This tool was created by Poorya Abbasi - https://github.com/poorya-abbasi"

#Properties
echo "Updating properties - Setting welcome message and etc."
cp bigbluebutton.properties /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#Post Process Scripts
echo "Deploying recordings post-process scripts"
cp post_publish_z.rb /usr/local/bigbluebutton/core/scripts/post_publish/post_publish_z.rb

#Recordings Process Scheduling
echo "Scheduling recordings process phase"
cp override.conf /etc/systemd/system/bbb-record-core.timer.d/override.conf
mkdir /etc/systemd/system/bbb-record-core.timer.d/

echo "Reloading daemon"
systemctl daemon-reload

#Recording Playback HTML
echo "Updating recording playback HTML and resources"
cp playback/* /var/bigbluebutton/playback/presentation/2.0

#Recording Auto Removal Cron Job
echo "Setting up a cron job for recordings auto removal"
cp bbb-recording-cleanup /etc/cron.daily/bbb-recording-cleanup

#Disabling Sounds
echo "Updaing freeswitch configuration and disabling sounds"
cp conference.conf.xml /opt/freeswitch/etc/freeswitch/autoload_configs/conference.conf.xml

#Recordings Support For iOS
echo "Updating recordings prefrences to support iOS"
cp presentation.yml /usr/local/bigbluebutton/core/scripts/presentation.yml

#Removing Favicon and HTML
echo "Removing Favicon and default HTML"
rm /var/www/bigbluebutton-default/favicon.ico
touch /var/www/bigbluebutton-default/favicon.ico
rm /var/www/bigbluebutton-default/index.html
touch /var/www/bigbluebutton-default/index.html

#Default PDF
echo "Updating Default PDF"
cp default.pdf /var/www/bigbluebutton-default/default.pdf

CURRENT_ETHER_KEY="$(sudo cat /usr/share/etherpad-lite/APIKEY.txt)"

#Client Title
echo "Updating Client Title"
cp settings.yml /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
sed  "s/apikey: .*/apikey: $CURRENT_ETHER_KEY/" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml -i

#API Demos
echo "Removing API Demos"
yes | apt-get remove bbb-demo

#Setting Hostname
echo "Setting Hostname: $HOSTNAME"
bbb-conf --setip $HOSTNAME

#Setting Secret
echo "Setting Secret: $SECRET"
bbb-conf --setsecret $SECRET

echo "Restarting ..."
bbb-conf --restart 

#Done
echo "Done!"