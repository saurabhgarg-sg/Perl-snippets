strComputer = "."

Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colOperatingSystems = objWMIService.ExecQuery _
    ("Select * From Win32_PerfFormattedData_PerfOS_System")
 
For Each objOS in colOperatingSystems
    intSystemUptime = Int(objOS.SystemUpTime / 60)
    Wscript.Echo intSystemUptime & " minutes"
Next