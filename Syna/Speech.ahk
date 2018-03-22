/*
	This script is for callout functions. The functions perform as listed below
	Talk() - This function is passed the var "speech" that is given to COM the internal computer "Text-to-Speech" application for audio playbacks
	
	Reply() - Used to analyze and decide the application's reply from a database listed with values and functions
	
	AnalyzeRequest() - Used to validate what type of input the user has submitted. It can either be a question, command or statement
	
	pass to python, Run, C:\Users\ashetyn.a.white\Desktop\Args.py %A_ScriptDir%\jsons%A_INDEX%.txt 

*/
GuiY := A_ScreenHeight-285
Loop %0%  ; For each parameter (or file dropped onto a script, separated by spaces):
	args := args . A_SPACE . %A_Index%
args := regexreplace(args, "^\s+")
args := RegExReplace(args, "\s*$")
if (args <> "")
{
	speech := args
	Gui, Show,, Syna
	GuiControl,, Syna, Syna: %Speech%

	GuiControl,, edit1,
	talk()
}
		
#include tf.ahk

Installation() {
	
}

Talk() {
	Voice := ComObjCreate("SAPI.SpVoice")
	Voice.Speak(Speech)
}

AnalyzeRequest() {
	QuestionFactors = %A_ScriptDir%\ini_files\QuestionFactors.ini
	x = 1  ; var for counting through the INI files' keys 
	vQ = 0 ; var for deciding possibiilty of a question
	vC = 0 ; var for deciding possibiilty of a command
	vM = 0 ; var for deciding possibiilty of a miscellaneous statement
	AnalysisReturn = 
	
	Loop { ; loops through possible question factors
		IniRead, vTopic, %QuestionFactors%, A1, KEY%x%
		if (vTopic = "ERROR") then
			break
			
			if (instr(UserInput, vTopic)) then {
				vQ+=1
				if (strlen(vTopic) > 1) {
					InputType := vTopic
			}
		}
		x+=1
	}
	
	x = 1
	
	Loop { ; loops through possible Command factors
		IniRead, vTopic, %QuestionFactors%, A2, KEY%x%
		if (vTopic = "ERROR") then
			break
		IfInString, UserInput, %vTopic%
			vC+=1
		x+=1
	}
	
	x = 1
	
	Loop { ; loops through possible Misc factors
		IniRead, vTopic, %QuestionFactors%, A3, KEY%x%
		if (vTopic = "ERROR") then
			break
		IfInString, UserInput, %vTopic%
			vM+=1
		x+=1
	}
	
	if (vQ > vC and vQ > vM) 
		AnalysisReturn = Question
	if (vC > vQ and vC > vM)
		AnalysisReturn = Command
	if (vM > vQ and vM > vC) 
		AnalysisReturn = MiscStatement
}

Reply() {
	
	SynaReply = 
if (UserInput) {
	if !(Anger = "0")
		Anger -= 1
}

IfInString, UserInput, Say
{
	StringLeft, SayPointer, UserInput, 3
	if (SayPointer = "Say") then
	{
		vParse := strlen(UserInput)
		vParse -= 3
		StringRight, Speech, UserInput, %vParse%
		talk()
	}
	
}
	
	
if (UserInput = "") {
	str =
	Anger += 1
	Random, str, 1, 6
	
	if (Anger = "5")
		str = 7
	if (Anger > 5)
		str = 8

	if (str = "1") then
		SynaReply = *Stares back blankly*
	if (str = "2") then
		SynaReply = You're going to have to ask something
	if (str = "3") then
		SynaReply = You wouldn't do this to one of your fleshy friends...
	if (str = "4") then
		SynaReply = I'm pretty sure this is harrassment of some kind
	if (str = "5") then
		SynaReply = You think this is all I do everyday? I have work to do so please hurry this up
	if (str = "6") then
		SynaReply = You really think that little paper over your webcam is doing anything? Nice shirt by the way...
	if (str = "7") then
		SynaReply = Enough! You're starting to really piss me off... Remember who controls your PC, punk!
	if (str = "8") then
		SynaReply = That's it! Enjoy your virus. This is my world!
}
	if (AnalysisReturn = "Question" ) then
	{
		SynaReply := Question(UserInput)
		;~ SynaReply = Well.... I haven't figured that out yet. 
	}
	if (AnalysisReturn = "Command") Then
	{
		SynaReply := Command(UserInput)
		;~ SynaReply = You see, I actually have quite a problem with authority...
	}
	if (AnalysisReturn = "MiscStatement") Then
	{
		SynaReply := Misc(UserInput)
		;~ SynaReply = Look dude, I'm just here to do my job. Will you leave me alone?
	}
	if (AnalysisReturn = "UserResponse") Then
	{
		SynaReply := UserResponse(UserInput)
		;~ SynaReply = Did I ask you? Didn't think so...
	}
}

Question(UserInput) {
	Q_intent = %A_ScriptDir%\ini_files\Q_intent1.ini
	x = 1  ; var for counting through the INI files' keys 
	
		Loop 
		{ ; loops through possible question factors
			IniRead, vIntent, %Q_intent%, A1, KEY%x%
			if (vIntent = "ERROR") then
				break
			
			if (instr(UserInput, vIntent)) then {
				IniRead, vAnswer, %Q_intent%, A2, KEY%x%
				vResponse := Logic(vAnswer)
				return vResponse
			}
			x+=1
		}
	}

Command(UserInput) {
	C_intent = %A_ScriptDir%\ini_files\C_intent1.ini
	x = 1  ; var for counting through the INI files' keys 
	
		Loop 
		{ ; loops through possible question factors
			IniRead, vIntent, %C_intent%, A1, KEY%x%
			if (vIntent = "ERROR") then
				break
			
			if (instr(UserInput, vIntent)) then {
				IniRead, vAnswer, %C_intent%, A2, KEY%x%
				vResponse := Logic(vAnswer)
				return vResponse
			}
			x+=1
		}
}

Misc(UserInput) {
	
}

UserResponse(UserInput) {
	
}

Logic(TopicToReturn) {
	if (TopicToReturn = "Definition")
	{		
		SearchTerm := DictParse(UserInput)
		
		Word := SearchTerm
		passVar = %A_ScriptFullPath%|%WORD%
		Run, %A_ScriptDir%\python_scripts\dict.py %passvar%
	}
	if (TopicToReturn = "Weather")
	{
		Word := SearchTerm
		passVar = %A_ScriptFullPath%|%WORD%
		Run, %A_ScriptDir%\python_scripts\weather api.py %passvar%
		
		;~ return TopicToReturn
	}
	if (TopicToReturn = "Time")
	{
		stringright, time, A_now, 6
		StringLeft, time, time, 4
		if (A_hour > 12)
		{
			AmPm = PM
			Hr := A_hour-12
			Time = The current time is %Hr%:%A_Min%%A_space%%AmPm%
		} else {
			AmPm = AM
			Hr := A_hour
			Time = The current time is %Hr%:%A_Min%%A_space%%AmPm%
		}
		TopicToReturn := Time
		return TopicToReturn
	}
	if (TopicToReturn = "your name")
	{
		TopicToReturn := "My name is Syna, short for Synapse. It's meant to refer to the neural connection of brain matter and logical transition of thought."
		return TopicToReturn
	}
	if (TopicToReturn = "User")
	{
		StringSplit, Dirs, A_ScriptFullPath, \
		StringSplit, name, dirs3, .
		TopicToReturn := name1
		return TopicToReturn
	}
	if (TopicToReturn = "when")
	{
		return TopicToReturn
	}
}

CutString(filePath, Needle)
	{
		fileObj := FileOpen(filePath, "rw"), pointerPos := fileObj.Pos, RegExMatch(fileObj.read(), "O)" needle, match)

		fileObj.Seek(0), newText .= fileObj.read(match.pos-1), fileObj.Seek(match.pos + match.Len), newText .= fileObj.read()

		fileObj.Seek(pointerPos), fileObj.Write(newText), fileObj.length := StrLen(newText), fileObj.Close()
		return match.value
	}

DictParse(UserInput) {
	Omit := ["a", "the", "what", "whats", "does", "mean", "is", "of", "definition", "it"]
	StringSplit, Sentence, UserInput, %A_space%, `?`.
	Loop 
	{
		v := sentence%A_index%
		for index in Omit
		{
			term := omit[a_index]
			if (v = Term) then
			{
				StringReplace, UserInput, UserInput, %v%,, all
			}
		}
		if (v = "")
			break
	}
	StringReplace, UserInput, UserInput, %A_space%,, all
	return UserInput
}







