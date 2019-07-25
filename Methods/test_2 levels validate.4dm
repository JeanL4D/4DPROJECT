//%attributes = {}
Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")
ARRAY LONGINT:C221($al;0)

ASSERT:C1129(Not:C34(Active transaction:C1387))

START TRANSACTION:C239  //level 1
QUERY:C277([test:1];[test:1]ID:1=11)
[test:1]long:3:=-11
SAVE RECORD:C53([test:1])

ASSERT:C1129(Active transaction:C1387)

SUSPEND TRANSACTION:C1385  //level 1

ASSERT:C1129(Not:C34(Active transaction:C1387))

QUERY:C277([test:1];[test:1]ID:1=12)
[test:1]long:3:=-12
SAVE RECORD:C53([test:1])

START TRANSACTION:C239  //level 2

ASSERT:C1129(Active transaction:C1387)

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129([test:1]long:3=1100)

QUERY:C277([test:1];[test:1]ID:1=13)
[test:1]long:3:=-13
SAVE RECORD:C53([test:1])

SUSPEND TRANSACTION:C1385  //level 2

ASSERT:C1129(Not:C34(Active transaction:C1387))

QUERY:C277([test:1];[test:1]ID:1=14)
[test:1]long:3:=-14
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129([test:1]long:3=-13)

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129([test:1]long:3=1100)

RESUME TRANSACTION:C1386  //level 2

ASSERT:C1129(Active transaction:C1387)

QUERY:C277([test:1];[test:1]ID:1=15)
[test:1]long:3:=-15
SAVE RECORD:C53([test:1])

VALIDATE TRANSACTION:C240  //level 2

ASSERT:C1129(Not:C34(Active transaction:C1387))

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129([test:1]long:3=-11)

QUERY:C277([test:1];[test:1]ID:1=16)
[test:1]long:3:=-16
SAVE RECORD:C53([test:1])

RESUME TRANSACTION:C1386  //level 1

ASSERT:C1129(Active transaction:C1387)

QUERY:C277([test:1];[test:1]ID:1=17)
[test:1]long:3:=-17
SAVE RECORD:C53([test:1])

VALIDATE TRANSACTION:C240  //level 1

ASSERT:C1129(Not:C34(Active transaction:C1387))

ALL RECORDS:C47([test:1])
ORDER BY:C49([test:1];[test:1]ID:1)
SELECTION TO ARRAY:C260([test:1]long:3;$al)
If (Asserted:C1132(Size of array:C274($al)=30;"Size of Array for $al should return 30 rather than "+String:C10(Size of array:C274($al))))
	ASSERT:C1129($al{11}=-11)
	ASSERT:C1129($al{12}=-12)
	ASSERT:C1129($al{13}=-13)
	ASSERT:C1129($al{14}=-14)
	ASSERT:C1129($al{15}=-15)
	ASSERT:C1129($al{16}=-16)
	ASSERT:C1129($al{17}=-17)
End if 
