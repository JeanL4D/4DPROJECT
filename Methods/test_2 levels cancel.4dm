//%attributes = {}
Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")
ARRAY LONGINT:C221($al;0)

START TRANSACTION:C239  // L1

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in trans L1"  // ID = 31
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=21)
[test:1]long:3:=-21
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=29)
ASSERT:C1129((Records in selection:C76([test:1])=1);"One record should be found")
DELETE RECORD:C58([test:1])

SUSPEND TRANSACTION:C1385  //L1

QUERY:C277([test:1];[test:1]ID:1=22)
[test:1]long:3:=-22
SAVE RECORD:C53([test:1])

START TRANSACTION:C239  //L2

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in TRANS/SUSP/TRANS"  // ID = 32
[test:1]long:3:=-55
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=30)
ASSERT:C1129((Records in selection:C76([test:1])=1);"One record should be found")
DELETE RECORD:C58([test:1])

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=31 No record should be found")

QUERY:C277([test:1];[test:1]ID:1=29)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=29 One record should be found")

QUERY:C277([test:1];[test:1]ID:1=21)
ASSERT:C1129([test:1]long:3=2100)

QUERY:C277([test:1];[test:1]ID:1=23)
[test:1]long:3:=-23
SAVE RECORD:C53([test:1])

SUSPEND TRANSACTION:C1385  //L2

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in TRANS/SUSP/TRANS/SUSP"  // ID = 33
[test:1]long:3:=-55
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=28)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=28 One record should be found")
DELETE RECORD:C58([test:1])

QUERY:C277([test:1];[test:1]ID:1=24)
[test:1]long:3:=-24
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=23)
ASSERT:C1129([test:1]long:3=-23)

QUERY:C277([test:1];[test:1]ID:1=21)
ASSERT:C1129([test:1]long:3=2100)

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=32 One record should be found")

QUERY:C277([test:1];[test:1]ID:1=30)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=30 No record should be found")

RESUME TRANSACTION:C1386  //L2

QUERY:C277([test:1];[test:1]ID:1=25)
[test:1]long:3:=-25
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=33)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=33 One record should be found")

QUERY:C277([test:1];[test:1]ID:1=28)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=28 No record should be found")
CANCEL TRANSACTION:C241  //L2

QUERY:C277([test:1];[test:1]ID:1=21)
ASSERT:C1129([test:1]long:3=-21)

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129([test:1]long:3=-50;"[test]long should be equal to -50")

QUERY:C277([test:1];[test:1]ID:1=29)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=29 No record should be found")

QUERY:C277([test:1];[test:1]ID:1=26)
[test:1]long:3:=-26
SAVE RECORD:C53([test:1])

RESUME TRANSACTION:C1386  //L1

QUERY:C277([test:1];[test:1]ID:1=27)
[test:1]long:3:=-27
SAVE RECORD:C53([test:1])

CANCEL TRANSACTION:C241  //L1

ALL RECORDS:C47([test:1])
ORDER BY:C49([test:1];[test:1]ID:1)
SELECTION TO ARRAY:C260([test:1]long:3;$al)
If (Asserted:C1132(Size of array:C274($al)=30;"Size of Array for $al should return 30 rather than "+String:C10(Size of array:C274($al))))
	ASSERT:C1129($al{21}=2100)
	ASSERT:C1129($al{22}=-22)
	ASSERT:C1129($al{23}=2300)
	ASSERT:C1129($al{24}=-24)
	ASSERT:C1129($al{25}=2500)
	ASSERT:C1129($al{26}=-26)
	ASSERT:C1129($al{27}=2700)
	ASSERT:C1129($al{29}=3000)
	ASSERT:C1129($al{30}=-55)
End if 
QUERY:C277([test:1];[test:1]ID:1=30)

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=31 No record should be found")
QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=32 No record should be found")
QUERY:C277([test:1];[test:1]ID:1=28)
ASSERT:C1129((Records in selection:C76([test:1])=0);"ID=28 No record should be found")
QUERY:C277([test:1];[test:1]ID:1=29)
ASSERT:C1129((Records in selection:C76([test:1])=1);"ID=29 One record should be found")