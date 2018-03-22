User = % Username
SetMouseDelay,-1
AutoTrim, On
#SingleInstance force
Sendmode, input
Setkeydelay, 0
#WinActivateForce
DetectHiddenWindows, On
DetectHiddenText, On
#Persistent
Coordmode, Relative
SetFormat float, 0.2
;~ SetTitleMatchMode, 2
;********************************************************************************************************
/*
												((((
Authors: Ashetyn White 							((((
		 Robert Voiles						 	))))
											  _ .---.
											 ( |`---'|
											  \|     |
											  : .___, :
											   `-----'
*/
;*********************************************************************************************************

global speech
global SynaReply
global UserInput
global AnalysisReturn
global InputType
global Anger
global varXS
global wb

#include Speech.ahk
#include AccLib.ahk
#include ADO_db.ahk
#include Anger.ahk

Start:

speech := 
SynaReply :=
UserInput :=
InputType :=
Anger := 0

GuiY := A_ScreenHeight-285
;============

global sdbfile:="SynaVocabulary.accdb"
global dbFile
dbFile = %A_ScriptDir%\SynaVocabulary.accdb
nmbr:=
gid:=:

;================
Gui, Font, S13 CDefault, Verdana
Gui, -caption +AlwaysOnTop
Gui, Add, Text, x12 y10 w450 h130 vSyna,Syna: %SynaReply%
Gui, Font, S8 CDefault, Verdana
Gui, Add, Edit, x12 y160 w430 h60 vUserInput,
Gui, Add, Button, x452 y190 w90 h30 gAsk, Submit
Gui, Show, x0 y%GuiY% w548 h242, Syna
return

ExitApp

Ask:
Gui, Submit

UserInput := Trim(UserInput)

AnalyzeRequest()

Reply() ; function found in the Speech.ahk file

speech := SynaReply
if (Anger > 5) then
	gui, color, red

if (Anger < 5) then
	gui, color, Default


Gui, Show, x0 y%guiY% w548 h242, Syna
GuiControl,, Syna, Syna: %SynaReply%

GuiControl,, edit1,
Talk() ; function found in the Speech.ahk file

if (anger = "6")
{
	SynaReply =
	anger()
	Anger = 0
	gui, color, Default
	GuiControl,, Syna, Syna: %SynaReply%
	GuiControl,, edit1,
	Talk() ; function found in the Speech.ahk file

}

return