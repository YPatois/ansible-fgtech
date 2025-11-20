#!/bin/bash

inotifywait --recursive --monitor --exclude '.git|.idea' --event modify,move,create,delete ./ | while read path action file; do
    echo `date`" - File $file has been $action in $path"
    if  [ -d $path/$file ]; then
	    continue
    fi
    ssh alma@34.155.50.78 mkdir -p /home/alma/fgtech/$path
    file=`echo $file | tr -d '~'`
    rsync -av --delete  --exclude '.git' --exclude-from='.gitignore' $path/$file alma@34.155.50.78:/home/alma/fgtech/$path/$file
    echo "rsync done"
done
