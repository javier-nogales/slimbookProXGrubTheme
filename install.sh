#!/bin/bash

INSTALL_MSG="You going to install grub theme. Do you want to CONTINUE? (Y/n)"
BASE_PATH=/home/jnogales/develop/temp
THEME_PATH=$BASE_PATH/slimbook_prox_theme

# set -x			# activate debugging from here

###############################################################################
# INFO
###############################################################################
echo "**************************************************"
echo "* Wellcome to SLIMBOOK PROX grub theme installer *"
echo "*                             by @_javiernogales *"
echo "**************************************************"
echo ""
###############################################################################
# INSTALLATION CONTINUE QUESTION
###############################################################################
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

# theme folder
echo "creating theme folder..."
sudo mkdir $THEME_PATH

echo "loading fonts..."
sudo cp ./src/fonts/* $THEME_PATH

echo "loadin OS icons..."
sudo cp -r ./src/icons $THEME_PATH

echo "loading images..."
sudo cp -r ./src/images $THEME_PATH
sudo cp -r ./src/pixmap $THEME_PATH

echo "copying theme.txt..."
sudo cp ./src/theme.txt $THEME_PATH/theme.txt

# set +x			# stop debugging from here