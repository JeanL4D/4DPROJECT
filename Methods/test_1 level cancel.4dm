//%attributes = {}

C_BOOLEAN:C305(vWait)
C_TEXT:C284($handlerToRestore)
C_LONGINT:C283(verror)
verror:=0
vWait:=False:C215
  //$vp:=New process("LaunchInitData";0;"BuildData")

Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")

  //DELAY PROCESS(Current process;60)  // pour que le TRUNCATE se fasse completement

ARRAY LONGINT:C221($al;0)

START TRANSACTION:C239

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in trans L1"
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=3)
[test:1]long:3:=-10
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=30)
ASSERT:C1129((Records in selection:C76([test:1])=1);"One record should be found")
DELETE RECORD:C58([test:1])

SUSPEND TRANSACTION:C1385

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in TRANS/SUSP"  // ID = 31
[test:1]long:3:=-55
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=5)
[test:1]long:3:=-20
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129([test:1]long:3=-50)

QUERY:C277([test:1];[test:1]ID:1=3)
ASSERT:C1129([test:1]long:3=-10)

QUERY:C277([test:1];[test:1]ID:1=30)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=30 No record should be found")

QUERY:C277([test:1];[test:1]ID:1=15)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=15 One record should be found")
DELETE RECORD:C58([test:1])

$handlerToRestore:=Method called on error:C704
ON ERR CALL:C155("MyErrorHandler")
RESUME TRANSACTION:C1386
ON ERR CALL:C155($handlerToRestore)

If (Asserted:C1132(verror=0;"error : "+String:C10(verror)+" The transaction is not suspended"))
	
	
	QUERY:C277([test:1];[test:1]ID:1=7)
	[test:1]long:3:=-30
	SAVE RECORD:C53([test:1])
	
	QUERY:C277([test:1];[test:1]ID:1=31)
	ASSERT:C1129([test:1]long:3=-50)
	
	QUERY:C277([test:1];[test:1]ID:1=30)
	ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=30 No record should be found")
	
	QUERY:C277([test:1];[test:1]ID:1=15)
	ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=15 No record should be found")
End if 
CANCEL TRANSACTION:C241

ALL RECORDS:C47([test:1])
ORDER BY:C49([test:1];[test:1]ID:1)
SELECTION TO ARRAY:C260([test:1]long:3;$al)
If (Asserted:C1132(Size of array:C274($al)=30;"Size of Array for $al should return 30 rather than "+String:C10(Size of array:C274($al))))
	ASSERT:C1129($al{3}=300)
	ASSERT:C1129($al{5}=-20)
	ASSERT:C1129($al{7}=700)
	ASSERT:C1129($al{30}=-55)
End if 
QUERY:C277([test:1];[test:1]ID:1=15)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=15 No record should be found")

