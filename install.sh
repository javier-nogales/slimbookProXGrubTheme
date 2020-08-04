#!/bin/bash

INSTALL_MSG="You going to install grub theme. Do you want to CONTINUE? (Y/n)"

# set -x			# activate debugging from here

echo "**************************************************"
echo "* Wellcome to SLIMBOOK PROX grub theme installer *"
echo "*                             by @_javiernogales *"
echo "**************************************************"
echo ""

count=0
while [ $count -lt 3 ]
do 
    # echo "count = $count"
    echo $INSTALL_MSG
    read CONTINUE
    if [ -z $CONTINUE ]
    then
        CONTINUE="Y"
    fi
    if [ $CONTINUE = 'N' ] || [ $CONTINUE = 'n' ] || [ $CONTINUE = 'Y' ] || [ $CONTINUE = 'y' ]
    then    
        break
    fi
    count=$((count+1))
done

if [ $CONTINUE != 'Y' ] || [ $CONTINUE = 'y' ]
then
    echo "Installation canceled"
    exit 0
fi

echo "Installation CONTINUE"

#ROOT_PATH="/develop/projects/slimbookProXTheme"

# set +x			# stop debugging from here