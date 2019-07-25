//%attributes = {}
Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")

ARRAY LONGINT:C221($al;0)

START TRANSACTION:C239
CREATE RECORD:C68([test:1])
[test:1]str:2:="new in trans L1"
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=2)
[test:1]long:3:=-1
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=30)
ASSERT:C1129((Records in selection:C76([test:1])=1);"One record should be found")
DELETE RECORD:C58([test:1])

SUSPEND TRANSACTION:C1385

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in TRANS/SUSP"  // ID = 31
[test:1]long:3:=-55
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=4)
[test:1]long:3:=-2
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=2)
ASSERT:C1129([test:1]long:3=-1)

RESUME TRANSACTION:C1386

QUERY:C277([test:1];[test:1]ID:1=6)
[test:1]long:3:=-3
SAVE RECORD:C53([test:1])

VALIDATE TRANSACTION:C240

ALL RECORDS:C47([test:1])
ORDER BY:C49([test:1];[test:1]ID:1)
SELECTION TO ARRAY:C260([test:1]long:3;$al)
If (Asserted:C1132(Size of array:C274($al)=31;"Size of Array for $al should return 31 rather than "+String:C10(Size of array:C274($al))))
	ASSERT:C1129($al{2}=-1)
	ASSERT:C1129($al{4}=-2)
	ASSERT:C1129($al{6}=-3)
	ASSERT:C1129($al{30}=-50;"ID=31 - [test]ID should equal to -50")
	ASSERT:C1129($al{31}=-55;"ID=32 - [test]ID should equal to -55")
End if 