//%attributes = {}
Repeat 
	vWait:=IsFlag ("Wait")
Until (vWait)
SetFlag ("Wait")
build Data 
ClearFlag ("Wait")

ARRAY LONGINT:C221($al;0)
C_OBJECT:C1216($vOlocked)
START TRANSACTION:C239  //level 1

CREATE RECORD:C68([test:1])
[test:1]str:2:="new in trans L1"  // ID = 31
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=11)
[test:1]long:3:=-11
SAVE RECORD:C53([test:1])

SUSPEND TRANSACTION:C1385  //level 1
QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

CREATE RECORD:C68([test:1])
[test:1]str:2:="TRANS/SUSP L1"  // ID = 32
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

  //QUERY([test];[test]ID=12)
  //[test]long:=-12
  //SAVE RECORD([test])

START TRANSACTION:C239  //level 2

CREATE RECORD:C68([test:1])
[test:1]str:2:="TRANSL2"  // ID = 33
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-50)
[test:1]long:3:=-18
[test:1]str:2:="TRANS/SUSP/TRANS L2"
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")
ASSERT:C1129([test:1]long:3=1100)

QUERY:C277([test:1];[test:1]ID:1=13)
[test:1]long:3:=-13
SAVE RECORD:C53([test:1])

SUSPEND TRANSACTION:C1385  //level 2

CREATE RECORD:C68([test:1])
[test:1]str:2:="TRANS2/SUSP L2"  // ID = 34
[test:1]long:3:=-50
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")
ASSERT:C1129([test:1]long:3=-18)

  //QUERY([test];[test]ID=14)
  //[test]long:=-14
  //SAVE RECORD([test])

QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129([test:1]long:3=-13)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129([test:1]long:3=1100)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

RESUME TRANSACTION:C1386  //level 2
  //retour transaction l2
QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=34)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-50)
[test:1]long:3:=-28
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-18)

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

  //QUERY([test];[test]ID=15)
  //[test]long:=-15
  //SAVE RECORD([test])

VALIDATE TRANSACTION:C240  //level 2
  // retour SUSPEND  L1
QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=34)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-18)
SAVE RECORD:C53([test:1])

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129([test:1]long:3=-11)
ASSERT:C1129(Locked:C147([test:1]);"record should be locked")

  //QUERY([test];[test]ID=16)
  //[test]long:=-16
  //SAVE RECORD([test])

RESUME TRANSACTION:C1386  //level 1
  //retour transaction L1
QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-18)

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
ASSERT:C1129([test:1]long:3=-50)

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

  //QUERY([test];[test]ID=17)
  //[test]long:=-17
  //SAVE RECORD([test])

VALIDATE TRANSACTION:C240  //level 1

QUERY:C277([test:1];[test:1]ID:1=11)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=13)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=31)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
  //ASSERT([test]long=-50)

QUERY:C277([test:1];[test:1]ID:1=32)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")
  //ASSERT([test]long=-18)

QUERY:C277([test:1];[test:1]ID:1=33)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

QUERY:C277([test:1];[test:1]ID:1=34)
ASSERT:C1129(Not:C34(Locked:C147([test:1]));"record should not be locked")

  //ALL RECORDS([test])
  //ORDER BY([test];[test]ID)
  //SELECTION TO ARRAY([test]long;$al)

  //ASSERT($al{11}=-11)
  //ASSERT($al{12}=-12)
  //ASSERT($al{13}=-13)
  //ASSERT($al{14}=-14)
  //ASSERT($al{15}=-15)
  //ASSERT($al{16}=-16)
  //ASSERT($al{17}=-17)

