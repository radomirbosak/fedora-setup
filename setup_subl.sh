#!/bin/sh

CORRECT_DLLINK=$(wget https://www.sublimetext.com/3 -O- | \
    grep dl_linux_64 | \
    sed -n -e 's/^.*<a href="\(.*\)">tarball.*$/\1/p')

# download sublime
wget -v https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2 -O sublime_text.tar.bz2
# unpack it
tar xvjf sublime_text.tar.bz2
# install it in /opt/
sudo cp -rv sublime_text_3 /opt/sublime_text
# make a /bin/ link
sudo ln -sv /opt/sublime_text/sublime_text /bin/subl


# install icons
for size in $(ls sublime_text_3/Icon); do
    echo $size
    sudo cp -v sublime_text_3/Icon/$size/sublime-text.png /usr/share/icons/hicolor/$size/apps/sublime-text.png
done

# install desktop shortcuts
cp -v sublime_text_3/sublime_text.desktop ~/Desktop/
chmod u+x ~/Desktop/sublime_text.desktop
sudo cp -v sublime_text_3/sublime_text.desktop /usr/share/applications/

# update icon cache
sudo gtk-update-icon-cache /usr/share/icons/hicolor

# enable icons in gnome
gsettings set org.gnome.desktop.background show-desktop-icons true

# cleanup
rm -r sublime_text.tar.bz2 sublime_text_3