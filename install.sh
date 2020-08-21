#!/bin/bash

install_msg="You going to install grub theme. Do you want to CONTINUE? (Y/n)"
installatin_canceled_msg="Installation canceled"
grub_path=/boot/grub
# grub_path=/home/jnogales/develop/temp/grub_test
themes_path=$grub_path/themes
slimbook_prox_theme_path=$themes_path/slimbook_prox
grub_cgf_path=/etc/default/grub
# grub_cfg_path=/home/jnogales/develop/temp/grub_test/cfg/grub

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
    echo $install_msg
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
    echo $installatin_canceled_msg
    exit 0
fi

#grub path
if [ ! -d $grub_path ]
then
    echo $installatin_canceled_msg
    echo "grub is not installed"
    exit 1
fi

#themes path
if [ ! -d $themes_path ]
then
    echo "creating themes folder..."
    sudo mkdir $themes_path
fi

################
if [ -d $slimbook_prox_theme_path ]
then
    echo "slimbook_prox_theme_path exists= $slimbook_prox_theme_path"
else
    echo "slimbook_prox_theme_path NOT exists= $slimbook_prox_theme_path"
fi
################

#slimbook_prox theme path
if [ -d $slimbook_prox_theme_path ]
then
    echo "remove old slimbook_prox theme folder"
    sudo rm -R $slimbook_prox_theme_path
fi
echo "creating slimbook_prox theme folder..."
sudo mkdir $slimbook_prox_theme_path

echo "loading fonts..."
sudo cp ./src/fonts/* $slimbook_prox_theme_path

echo "loadin OS icons..."
sudo cp -r ./src/icons $slimbook_prox_theme_path

echo "loading images..."
sudo cp -r ./src/images $slimbook_prox_theme_path
sudo cp -r ./src/pixmap $slimbook_prox_theme_path

echo "copying theme.txt..."
sudo cp ./src/theme.txt $slimbook_prox_theme_path/theme.txt

#grub config
echo "modifying grub config..."
# 

if grep -q "^GRUB_GFXMODE" $grub_cgf_path
then
    # case a: afiable GRUB_GFXMODE uncomented found
    echo "vafiable GRUB_GFXMODE uncomented found."
    sed -i -e '/^GRUB_GFXMODE*/c\GRUB_GFXMODE=1920x1080x32' $grub_cgf_path
else
    if grep -q "^#GRUB_GFXMODE" $grub_cgf_path
    then
        # case b: vafiable GRUB_GFXMODE comented found
        echo "vafiable GRUB_GFXMODE comented found."
        sed -i -e '/^#GRUB_GFXMODE*/c\GRUB_GFXMODE=1920x1080x32' $grub_cgf_path
    else
        # case c: variable GRUB_GFXMODE not found
        echo "writting GRUB_GFXMODE value..."
        echo "GRUB_GFXMODE=1920x1080x32" | sudo tee -a $grub_cgf_path
    fi
fi

if grep -q "^GRUB_THEME" $grub_cgf_path
then
    # case a: afiable GRUB_THEME uncomented found
    echo "vafiable GRUB_THEME uncomented found!"
    sed -i -e '/^GRUB_THEME*/c\GRUB_THEME="/boot/grub/themes/slimbook_prox/theme.txt"' $grub_cgf_path
else
    if grep -q "^#GRUB_THEME" $grub_cgf_path
    then
        # case b: vafiable GRUB_THEME comented found
        echo "vafiable GRUB_THEME comented found!"
        sed -i -e '/^#GRUB_THEME*/c\GRUB_THEME="/boot/grub/themes/slimbook_prox/theme.txt"' $grub_cgf_path
    else
        # case c: variable GRUB_THEME not found
        echo "writting GRUB_THEME value..."
        echo 'GRUB_THEME="/boot/grub/themes/slimbook_prox/theme.txt"' | sudo tee -a $grub_cgf_path
    fi
fi

echo "updating grub..."
sudo update-grub

# set +x			# stop debugging from here