//%attributes = {}
$text2:="C:\\Users\\thomas.DE4D\\Weitere Dokumente\\tools_TM"
$text:="F:\\Basesv17\\BasesInternes\\Home\\testGit\\SuspendTransactionJL\\Project\\Sources\\"
Use (Storage:C1525)
	Storage:C1525.test:=New shared object:C1526("test";$text)
	Storage:C1525.test2:=New shared object:C1526("test";$text2)
End use 

  //p1
  //p2
  //p3
  //P4
ALERT:C41(Storage:C1525.test.test)
ALERT:C41(Storage:C1525.test2.test)


TRACE:C157
