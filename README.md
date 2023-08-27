# MenuExt

MenuExt is a [Hammerspoon](http://hammerspoon.org) that allows you to get spoken info about all your menu extras with simple global hotkeys.

## Installation

First, download and install Hammerspoon. You can do so either [from their Github](https://github.com/Hammerspoon/hammerspoon/releases/latest), or if you have it installed, through homebrew simply by running:

```bash
$ brew install Hammerspoon
```

in Terminal. Once you have it installed, run it, and follow the prompts to grant accessibility permissions (I also choose to hide the app from the dock here so it stays out of your command-tab switcher)

If you're a VoiceOver user, you also need to allow external apps to control VoiceOver through Apple Script. To do so, open VoiceOver utility with VO + f8, navigate to the "General" section and check the "Allow VoiceOver to be controlled with AppleScript" checkbox.

Once Hammerspoon is installed and configured, navigate into the folder where you cloned this repository with Finder or another file manager, and open "MenuExt.spoon" which should cause Hammerspoon to install it into the right place. Finally, from the Hammerspoon menu extra select the open configuration option which should open your default text editor with your init.lua file. To make MenuExt work and do its thing, simply add the following 2 lines:

```lua
hs.loadSpoon("MenuExt")
spoon.MenuExt:start()
```

Save the file, return to the Hammerspoon menu extra but this time click the reload configuration option for your new changes to take effect. Mac OS will warn you that Hammerspoon is trying to control Voice Over. Grant it permission and the spoon should start working.

## Keys.

Use control+command+1-0 to get information about the menu extra in that slot.

## Credits

* Instillation instructions adapted from [Indent Beeper](https://github.com/pitermach/IndentBeeper).
* Initial code for getting the text of each menu extra by [Mikolaj Holysz](https://www.github.com/mikolysz).
