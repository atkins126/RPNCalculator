@echo off
set /A directory=value
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%userprofile%\Desktop\RPN REPL.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%cd%\rpn.exe" >> CreateShortcut.vbs
echo oLink.Arguments = "repl" >> CreateShortcut.vbs 
echo oLink.WorkingDirectory = "%cd%" >> CreateShortcut.vbs
echo oLink.Description = "Run RPN Calculator REPL" >> CreateShortcut.vbs
echo oLink.IconLocation = "%cd%\rpn.ico" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs
echo The shortcut of RPN REPL has been created on Desktop.
pause
