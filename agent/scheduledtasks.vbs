'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :		Retrieve scheduled tasks and parse in XML
' Version :		1.10
' Date :		23/08/2017
' Author :		Guillaume PRIOU
' Contributor :	Stéphane PAUTREL (acb78.com)
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows XP		[X]	[ ]
'	Windows Vista	[X]	[X]
'	Windows 7		[X]	[X]
'	Windows 8.1		[X]	[X]	
'	Windows 10		[X]	[X]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' Function to list scheduled tasks in a temporary txt file
' ---------------------------------------------------------
On Error Resume Next

Dim Message
Set Message = CreateObject("WsCript.Shell")


Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")

' Méthode différente pour Windows Vista et W7 (merci Microsoft !)
For Each objOperatingSystem in colOperatingSystems
	If InStr(objOperatingSystem.version,"6.0.")<>0 Or InStr(objOperatingSystem.version,"6.1.")<>0 Then
		Message.run "CMD /c SCHTASKS /Query /FO CSV /V > %TEMP%\LISTTASK.txt",0,true
	Else
		Message.run "CMD /c SCHTASKS /Query /FO CSV /NH /V > %TEMP%\LISTTASK.txt",0,true
	End If
Next


Message.run "CMD /c SCHTASKS /Query /FO CSV /V > %TEMP%\LISTTASK.txt",0,true

'Function to convert OEM to ANSI
Dim oem
oem=array( _
"00","01","02","03","04","05","06","07","08","09","0A","0B","0C","0D","0E","0F", _
"10","11","12","13","14","15","16","17","18","19","1A","1B","1C","1D","1E","1F", _
"20","21","22","23","24","25","26","27","28","29","2A","2B","2C","2D","2E","2F", _
"30","31","32","33","34","35","36","37","38","39","3A","3B","3C","3D","3E","3F", _
"40","41","42","43","44","45","46","47","48","49","4A","4B","4C","4D","4E","4F", _
"50","51","52","53","54","55","56","57","58","59","5A","5B","5C","5D","5E","5F", _
"60","61","62","63","64","65","66","67","68","69","6A","6B","6C","6D","6E","6F", _
"70","71","72","73","74","75","76","77","78","79","7A","7B","7C","7D","7E","7F", _
"C7","FC","E9","E2","E4","E0","E5","E7","EA","EB","E8","EF","EE","EC","C4","C5", _
"C9","E6","C6","F4","F6","F2","FB","F9","FF","D6","DC","F8","A3","D8","D7","83", _
"E1","ED","F3","FA","F1","D1","AA","BA","BF","AE","AC","BD","BC","A1","AB","BB", _
"A6","A6","A6","A6","A6","C1","C2","C0","A9","A6","A6","2B","2B","A2","A5","2B", _
"2B","2D","2D","2B","2D","2B","E3","C3","2B","2B","2D","2D","A6","2D","2B","A4", _
"F0","D0","CA","CB","C8","69","CD","CE","CF","2B","2B","A6","5F","A6","CC","AF", _
"D3","DF","D4","D2","F5","D5","B5","FE","DE","DA","DB","D9","FD","DD","AF","B4", _
"AD","B1","3D","BE","B6","A7","F7","B8","B0","A8","B7","B9","B3","B2","A6","A0")

ForReading = 1
ForWriting = 2

Dim args, fso, fsrce, fdest
Set fso   = WScript.CreateObject("Scripting.FileSystemObject")
Set args  = Wscript.Arguments

Pipe=false
srce=fso.GetSpecialFolder(2) & "\LISTTASK.txt"
dest=fso.GetSpecialFolder(2) & "\LISTTASKANSI.txt"
Set fsrce=fso.OpenTextFile(srce, ForReading)
Set fdest=fso.OpenTextFile(dest, ForWriting, true)
While not fsrce.AtEndOfStream
	oldline=fsrce.ReadLine
	newline=""
	For i = 1 To len(oldline)
		oldc=asc(mid(oldline,i,1))
		newc=oem(oldc)
		newline=newline & chr(hextobyte(newc))
	Next

	' Détection entête de colonne (spécifique à Vista et W7)
	If InStr(newline, "Nom de la") <> 0 Then
		' Pas d'écriture, passage à la ligne suivante
	Else
		fdest.WriteLine newline
	End If
Wend
fdest.close
fsrce.close

' Utilitaires de conversion hexadécimale
' -------------------------------------
Function hextobyte(s)
	c1=Left(s,1)
	c2=Right(s,1)
	hextobyte=hextobin(c1)*16+hextobin(c2)
End Function
' -------------------------------------
Function hextobin(c)
	Select Case c
		Case "0","1","2","3","4","5","6","7","8","9"
			hextobin=asc(c)-asc("0")
		Case else
			hextobin=asc(c)-asc("A")+10
	End Select
End Function

'Function to read CSV file and parse it in XML format
Dim fCsv
Dim tb
Set fCsv = fso.OpenTextFile(fso.GetSpecialFolder(2) & "\LISTTASKANSI.txt", ForReading)

If Not fCsv.AtEndOfStream Then fCsv.ReadLine ' read line by line

While Not fCsv.AtEndOfStream
  tb = split(fCsv.ReadLine, """,""")
	Wscript.echo _
		"<SCHEDULEDTASKS>" & VbCrLf &_
		"<NAME>" & tb(1) & "</NAME>" & VbCrLf &_
		"<NEXT_EXEC_HOUR>" & tb(2) & "</NEXT_EXEC_HOUR>" & VbCrLf &_
		"<STATE>" & tb(3) & "</STATE>" & VbCrLf &_
		"<LAST_EXEC_HOUR>" & tb(5) & "</LAST_EXEC_HOUR>" & VbCrLf &_
		"<LAST_RESULT>" & tb(6) & "</LAST_RESULT>" & VbCrLf &_
		"<CREATOR>" & tb(7) & "</CREATOR>" & VbCrLf &_
		"<PLANNING>" & tb(17) & "</PLANNING>" & VbCrLf &_
		"<TASK_TO_EXECUTE>" & tb(8) & "</TASK_TO_EXECUTE>" & VbCrLf &_
		"<START_IN>" & tb(9) & "</START_IN>" & VbCrLf &_
		"<COMMENT>" & tb(10) & "</COMMENT>" & VbCrLf &_
		"<TASK_STATUS>" & tb(11) & "</TASK_STATUS>" & VbCrLf &_
		"<TYPE>" & tb(18) & "</TYPE>" & VbCrLf &_
		"<BEGIN_HOUR>" & tb(19) & "</BEGIN_HOUR>" & VbCrLf &_
		"<BEGIN_DATE>" & tb(20) & "</BEGIN_DATE>" & VbCrLf &_
		"<END_DATE>" & tb(21) & "</END_DATE>" & VbCrLf &_
		"<DAY>" & tb(22) & "</DAY>" & VbCrLf &_
		"<MONTH>" & tb(23) & "</MONTH>" & VbCrLf &_
		"<EXECUTE_AS>" & tb(14) & "</EXECUTE_AS>" & VbCrLf &_
		"<DEL_TASK>" & tb(15) & "</DEL_TASK>" & VbCrLf &_
		"<STOP_TASK_AFTER>" & tb(16) & "</STOP_TASK_AFTER>" & VbCrLf &_
		"</SCHEDULEDTASKS>"
Wend