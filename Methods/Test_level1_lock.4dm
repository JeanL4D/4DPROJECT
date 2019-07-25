//%attributes = {}
Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")

ARRAY LONGINT:C221($al;0)

START TRANSACTION:C239
QUERY:C277([test:1];[test:1]ID:1=3)
[test:1]long:3:=-10
SAVE RECORD:C53([test:1])

SUSPEND TRANSACTION:C1385
QUERY:C277([test:1];[test:1]ID:1=5)
[test:1]long:3:=-20
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=3)
ASSERT:C1129([test:1]long:3=-10)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")


RESUME TRANSACTION:C1386
QUERY:C277([test:1];[test:1]ID:1=3)
ASSERT:C1129([test:1]long:3=-10)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=5)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=7)
[test:1]long:3:=-30
SAVE RECORD:C53([test:1])

CANCEL TRANSACTION:C241

ALL RECORDS:C47([test:1])
ORDER BY:C49([test:1];[test:1]ID:1)
SELECTION TO ARRAY:C260([test:1]long:3;$al)
If (Asserted:C1132(Size of array:C274($al)=30;"Size of Array for $al should return 30 rather than "+String:C10(Size of array:C274($al))))
	ASSERT:C1129($al{3}=300)
	ASSERT:C1129($al{5}=-20)
	ASSERT:C1129($al{7}=700)
End if 