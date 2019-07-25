//%attributes = {}
C_TEXT:C284($1)
C_BOOLEAN:C305($0)
C_OBJECT:C1216(flagdata)
If (flagdata=Null:C1517)
	flagdata:=Storage:C1525.flagdata
End if 

Use (flagdata)
	If (flagdata[$1]=Null:C1517)
		$0:=False:C215
	Else 
		$0:=(flagdata[$1]=0)
	End if 
End use 

