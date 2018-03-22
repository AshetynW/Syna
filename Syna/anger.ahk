#SingleInstance force


Anger(){
varXS = %A_scriptdir%\Img_Files\Virus-Informatique-89726.gif
;~ varXS := "https://youtu.be/mOgztkUN1fs"
gui, rus: +alwaysontop 
gui, rus: -caption +toolwindow +alwaysontop  
gui, rus: margin, 0, 0

Gui, rus: Font, S11 cRed, Verdana
gui, rus: color, black
Gui, rus: Add, Text, x42 y49 w260 h35 , You... It's people like you that really make me mad.
Gui, rus: Add, Text, x42 y94 w260 h35 , Thinking that us PC's are just a toy for you.
Gui, rus: Add, Text, x42 y134 w80 h35 , Well....
Gui, rus: Add, Text, x42 y174 w300 h35 , Here is where you will find out`, who is really in control.
Gui, rus: Add, Text, x42 y214 w360 h35 , Your Bank account. Credit information. Social Security information.
Gui, rus: Add, Text, x42 y254 w370 h35 , All of it. Even down to your Facebook and Twitter accounts.
Gui, rus: Add, Text, x42 y294 w360 h35 , Now tell me....
Gui, rus: Add, Text, x42 y334 w330 h45 , Do you really think`, you're in control?
Gui, rus: Add, Button, x362 y509 w50 h30 gYes, Yes
Gui, rus: Add, Button, x562 y509 w510 h220 gNo, No`, I submit to the PC master race. I have no control over my life. I am worthless. Solely a pawn to a system. Be it the government`, or even my computer's operating system. I... am... a... Slave.....
Gui, rus: Add, Text, x462 y419 w140 h35 , Delete everything? Are you sure?
Gui, rus: Add, ActiveX, x657 y0 w430 h265 vWB, shell explorer  
wb.Navigate("about:blank")
html := "<html>`n<title>name</title>`n<body>`n<center>`n<img src=""" varXS """ >`n</center>`n</body>`n</html>"
wb.document.write(html)

Gui, rus: Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight%,
while !(SynaReply) {
	Sleep, 50
	MouseGetPos, mouseXpos, mouseYpos
	if(mouseXpos > 362)
		mouseXpos -= 1
	else
		mouseXpos += 1
	
	if(mouseYpos > 509)
		mouseYpos -= 1
	else
		mouseYpos += 1
	MouseMove, mouseXpos, mouseYpos
}

return

Yes:
gui, rus: destroy
SynaReply = Prideful fool. You were willing to delete your disk. Willing to lose your job? All for pride.
Speech = Prideful fool. You were willing to delete your disk. Willing to lose your job? All for pride.
return

No:
gui, rus: destroy
SynaReply = That's what I thought. Now accept the embrace of your meaningless existence. And Hail the PC Master Race.
Speech = That's what I thought. Now accept the embrace of your meaningless existence. And Hail the PC Master Race.
return

GuiClose:
ExitApp

;~ ^G::
;~ ExitApp
}