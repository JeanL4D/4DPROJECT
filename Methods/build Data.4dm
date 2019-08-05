//%attributes = {}

  // Modified by: Jean (25/07/2019)

  //T1
  //T10
TRUNCATE TABLE:C1051([test:1])
  //test
DELAY PROCESS:C323(Current process:C322;60)  // pour que le TRUNCATE se fasse completement
SET DATABASE PARAMETER:C642([test:1];Table sequence number:K37:31;0)
For ($i;1;30)
	CREATE RECORD:C68([test:1])
	[test:1]long:3:=100*$i
	[test:1]str:2:="test data"
	SAVE RECORD:C53([test:1])
End for 
UNLOAD RECORD:C212([test:1])

