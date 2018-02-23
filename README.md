# ScreenRez
(aka xrx-output)

A simple plasmoid to change the resolution of your primary display. It uses a simple shell script to query 'xrandr' and get the available display resolutions. It has a configuration page to select which aspect ratios (16:10, 16:9, etc.) you prefer, and filters the list accordingly.

To install, download the entire **org.kde.xrandr** directory into your personal plasmoid directory, which is

    $HOME/.local/share/plasma/plasmoids
    
Once copied, run this command to register it with the system:

    kpackagetool5 --install org.kde.xrandr
    
It's meant for a horizontal panel (I keep it on top). 

You may need to set the shell script to executable; that setting may not survive the round-trip to github and back.

    chmod +x org.kde.xrandr/contents/ui/parse-xrx-output.sh
   
Like all open-source software, you can look at this shell script and see that it's not doing anything nefarious to your system. 

Feel free to post any issues. Remember it comes with a money-back guarantee. 
