	Global Read,total
	ComObjError( 0 )
	AccLib(Query_Statement) {
	IfNotExist,%dbfile%
	MsgBox, 4096,Error,Database file not found!
	
	;~ dbcon=
	;~ (
	;~ Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%dbfile%;Jet OLEDB:Database Password=%dbpassword%;
	;~ )
	dbcon = 
	(
	Provider=Microsoft.ACE.OLEDB.12.0;Password="";User ID=Admin;Data Source=%dbfile%
	)
	;~ dbcon = 
	;~ (
	;~ Provider=Microsoft.Jet.OLEDB.4.0;Password="";User ID=Admin;Data Source=%dbfile%
	;~ )
	;~ dbcon = 
	;~ (
	;~ Provider=Microsoft.ACE.OLEDB.10.0;Password="";User ID=Admin;Data Source=%dbfile%
	;~ )
	Con := ComObjCreate( "ADODB.Connection" )
	Con.ConnectionTimeout := 3
	Con.CursorLocation := 3
	Con.CommandTimeout := 900
	Con.Open(dbcon)
	MsgBox, % dbfile

	;~ if a_lasterror
	;~ MsgBox, 4096,Error,Failed to connect database!

	oRec := Con.execute( Query_Statement )	
	;~ if a_lasterror{
	;~ StringLeft,err,Query_Statement,6
	;~ MsgBox, 4096,Error,%err% Failed!
	;~ }
		oFld := oRec.Fields
		oTbl.Insert( Read := [] )
		While !oRec.EOF
		{
		total=%A_Index%
		Loop % cols := oFld.Count
		{
		tablo := oFld.Item( A_Index - 1 ).name
		Read[ tablo,total ] := oFld.Item( A_Index - 1 ).Value					
		global EOF = oRec.EOF
		}
		oRec.MoveNext()
		if(oRec.EOF = ""){
		break
		}
		}
		if(total=""){
		total=0
		}
		Con.Close()
}