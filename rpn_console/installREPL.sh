echo Starting...
echo "#!/usr/bin/env xdg-open" > ~/Desktop/RPN.desktop
echo "[Desktop Entry]" >> ~/Desktop/RPN.desktop
echo "Version=0.5" >> ~/Desktop/RPN.desktop
echo "Type=Application" >> ~/Desktop/RPN.desktop
echo "Terminal=true" >> ~/Desktop/RPN.desktop
echo "Exec=$(pwd)/rpn repl" >> ~/Desktop/RPN.desktop
echo "Name=RPN REPL" >> ~/Desktop/RPN.desktop
echo "Comment=REPL of RPN Calculator – PapajScript interpreter." >> ~/Desktop/RPN.desktop
echo "Icon=$(pwd)/rpn.ico" >> ~/Desktop/RPN.desktop
chmod +x ~/Desktop/RPN.desktop
echo The shortcut of RPN REPL has been created on Desktop.
