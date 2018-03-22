#include AccLib.ahk
#include ADO_db.ahk
global dbfile:="SynaVocabulary.accdb"
;~ sDbFile = SynaVocabulary.accdb  ; possible utilization for the ADO_db library
sDbFile = %A_ScriptDir%\SynaVocabulary.accdb
;~ global dbpassword:="AO6Aw23@"
nmbr:=
gid:=:

/*
For Windows 10 machines, you must first download the Access Database Engine 2010
https://www.microsoft.com/en-us/download/details.aspx?id=13255
*/


Gui,default
Gui,Add,ListView,x2 y2 w776 h405 ginf vmyl AltSubmit Grid -Multi,ID|EID|Client|Role|Trainer|UID|Status|PrimaryState ;|Tag1|Tag2|Tag3|Tag4
Gui,Add,Button,x795 y33 w85 h22 gadd,Add New
Gui,Add,Button,x795 y60 w85 h22 gedt,Modify (F2)
Gui,Add,Button,x795 y87 w85 h22 gdel,Delete (Del)
Gui,Add,Button,x795 y114 w85 h22 grefresh,Refresh (F5)
Gui,Add,Button,x795 y142 w85 h49 gguiclose,Close
Gui,Show,,[trksyln] - %dbfile%

goto,refresh
~F5::
refresh:
 
 sql := "SELECT * FROM ACN_Employees ORDER BY ID" ; query to return the table data and show in the gui
 
 
 acclib( sql )

 ;~ AccLib("SELECT * FROM ACN_Employees ORDER BY ID")

LV_Delete()
LV_ModifyCol(1,100)
LV_ModifyCol(2,100)
LV_ModifyCol(3,100)
LV_ModifyCol(4,100)
LV_ModifyCol(5,100)
LV_ModifyCol(6,100)
LV_ModifyCol(7,100)
loop,%total%  
  {
  ID := % Read["ID",a_index] ; must be named as the listed column headers in a specific table you want to return/modify
  EID := % Read["EID",A_Index] ; must be named as the listed column headers in a specific table you want to return/modify
  Client := % Read["Client",A_Index] ; must be named as the listed column headers in a specific table you want to return/modify
  Role := % Read["Role",A_Index]
  Trainer := % Read["Trainer",A_Index]
  UID := % Read["UID",A_Index]
  Status := % Read["Status",A_Index]
  PrimaryState := % Read["PrimaryState",A_Index]
  Tag1 := % Read["Tag1",A_Index] ; Although these are not existing in the db, it does not cause an error
  Tag2 := % Read["Tag2",A_Index]
  Tag3 := % Read["Tag3",A_Index]
  Tag4 := % Read["Tag4",A_Index]
  LV_Add("",ID,EID,Client,Role,Trainer,UID,Status,PrimaryState) ;,Tag1,Tag2,Tag3,Tag4)
}
return


GuiClose:
ExitApp


inf:
if A_GuiEvent = Normal ; I literally have no earthly idea what this is
{
  nmbr := LV_GetNext(0,"")
LV_GetText(gid, A_EventInfo,1)
}
return


del:
~DEL::
if (gid =""){
MsgBox, 4096,Error, Select one first!
return
}
LV_Delete(nmbr)
query_del =
(
DELETE From ACN_Employees Where ID=%gid%
)
Acclib(  query_del )
nmbr:=
gid:=
return


add:
gui,addmenu:destroy
Gui,addmenu:Add,Edit,x79 y9 w164 h21 vaWord,
Gui,addmenu:Add,Edit,x79 y34 w164 h21 vaType,
Gui,addmenu:Add,Edit,x79 y59 w164 h21 vaTag1,
Gui,addmenu:Add,Edit,x80 y84 w164 h21 vaTag2,
Gui,addmenu:Add,Edit,x80 y109 w164 h21 valTag3,
Gui,addmenu:Add,Edit,x80 y134 w164 h21 valTag4,
Gui,addmenu:Add,Text,x7 y11 w69 h17,Word:
Gui,addmenu:Add,Text,x8 y37 w69 h17,Type:
Gui,addmenu:Add,Text,x8 y64 w69 h17,Tag1:
Gui,addmenu:Add,Text,x8 y89 w69 h17,Tag2:
Gui,addmenu:Add,Text,x8 y114 w69 h17,Tag3:
Gui,addmenu:Add,Text,x8 y139 w69 h17,Tag4:
Gui,addmenu:Add,Button,x53 y160 w71 h23 Default gaddsave,Save
Gui,addmenu:Add,Button,x138 y160 w71 h23 gaddmenuguiclose,Cancel
Gui,addmenu:Show,,Add
return

addsave:
SetTimer,addsave1,1
return
addsave1:
SetTimer,addsave1,off
gui,addmenu:submit,nohide
;~ if(aWord = "" or aType = "" or aTag1 = "" or aTag2 = "" or alTag3 = "" or alTag4 = ""){
;~ MsgBox, 4096,Error, Fill form first!
;~ return
;~ }
query_add =
(
INSERT INTO ACN_Employees ( EID, Client)
VALUES ( '%aWord%', '%aType%')
)
Acclib(  query_add )

get_id= 
 (
 SELECT * FROM ACN_Employees Order by ID desc
 )
Acclib(get_id )
  id2 := % Read["ID",1]
  LV_Add("",id2,aWord,aType)
 gui,addmenu:destroy
 return
 

edt:
~F2::
if(gid = ""){
MsgBox, 4096,Error, Select one first!
return
}
query_edit= 
 (
 SELECT * FROM ACN_Employees Where ID=%gid%
 )
 AccLib(  query_edit )
  id := % Read["ID",1] ; must be named as the listed column headers in a specific table you want to return/modify
  Word := % Read["EID",1]
  Type := % Read["Client",1]
  Tag1 := % Read["Tag1",1]
  Tag2 := % Read["Tag2",1]
  Tag3 := % Read["Tag3",1]
  Tag4 := % Read["Tag4",1]

 
gui,editmenu:destroy
Gui,editmenu:Add,edit,x7 y11 w69 h17 hidden venm,%nmbr%
Gui,editmenu:Add,edit,x7 y11 w69 h17 hidden veid,%gid%
Gui,editmenu:Add,Edit,x79 y9 w164 h21 veWord,%Word%
Gui,editmenu:Add,Edit,x79 y34 w164 h21 veType,%Type%
Gui,editmenu:Add,Edit,x79 y59 w164 h21 veTag1,%Tag1%
Gui,editmenu:Add,Edit,x80 y84 w164 h21 veTag2,%Tag2%
Gui,editmenu:Add,Edit,x80 y109 w164 h21 velTag3,%Tag3%
Gui,editmenu:Add,Edit,x80 y134 w164 h21 velTag4,%Tag4%
Gui,editmenu:Add,Text,x7 y11 w69 h17,Word:
Gui,editmenu:Add,Text,x8 y37 w69 h17,Type:
Gui,editmenu:Add,Text,x8 y64 w69 h17,Tag1:
Gui,editmenu:Add,Text,x8 y89 w69 h17,Tag2:
Gui,editmenu:Add,Text,x8 y114 w69 h17,Tag3:
Gui,editmenu:Add,Text,x8 y139 w69 h17,Tag4:
Gui,editmenu:Add,Button,x53 y160 w71 h23 geditsave Default,Save
Gui,editmenu:Add,Button,x138 y160 w71 h23 geditmenuguiclose,Cancel
Gui,editmenu:Show,,Edit
nmbr:=
gid:=
return



editsave:
SetTimer,editsave1,1
return
editsave1:
SetTimer,editsave1,off
gui,editmenu:submit,nohide
if(eWord = "" or eType = "" or eTag1 = "" or eTag2 = "" or elTag3 = "" or elTag4 = ""){
MsgBox, 4096,Error, Fill form first!
return
}
query_esave =
(
UPDATE ACN_Employees SET EID='%eWord%', Client='%eType%'
)
LV_Modify(enm,"",eid,eWord,eType,eTag1,eTag2,elTag3,elTag4)
 Acclib(  query_esave )
 gui,editmenu:destroy
 return
 
 
 
editmenuguiclose:
gui,editmenu:destroy
return
addmenuguiclose:
gui,addmenu:destroy
return