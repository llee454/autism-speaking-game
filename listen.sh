# This script starts the hear app which listens to the mic and records
# a transcript of what is heard to a file and restarts it when it
# closes.
#
# This script is supposed to be used in conjunction with the
# Processing Autism app I created for King. It listens to Kings commands
# and records them to a file that the game app can read to see what he
# said. This script should be started by that app and it periodically
# pings the output file.

echo "started $(date)" >> log.txt
while hear > transcript.txt
do
  echo "restarted" >> log.txt
done
echo "finished" >> log.txt
