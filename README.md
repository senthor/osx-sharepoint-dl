# osx-sharepoint-dl
Automator workflow to download all files from currently opened directory in Safari. Tested with SharePoint 2013 on-site (SharePoint 15), Safari 12, macOS 10.14


Installation:

1.  Download release
2.  Decompress
3.  Open in Automator.app
4.  (optional) change URL base for Sharepoint in AppleScript section
5.  Save, close Automator
6.  Move to ~/Library/Services


Usage:
1.  Open Safari
2.  Open SharePoint in Safari; save login-credentials (important!)
3.  Locate folder, in which files that shall be downloaded are located
4.  Click Safari -> Services -> Sharepoint-dl in Menu Bar
5.  Follow instructions


Caveats:
Only the currently displayed files will be downloaded. You can enlarge the number of files displayed in the SharePoint settings. Folders will not be downloaded.
