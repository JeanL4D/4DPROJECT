//%attributes = {}
C_TEXT:C284($1)
C_OBJECT:C1216(flagdata)
If (flagdata=Null:C1517)
	flagdata:=Storage:C1525.flagdata
End if 

Use (flagdata)
	flagdata[$1]:=0
End use 