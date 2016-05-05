' Copyright (c) 2013 EMC Watch4net
'
' Permission to use, copy, modify, and distribute this software for any
' purpose with or without fee is hereby granted, provided that the above
' copyright notice and this permission notice appear in all copies.
'
' THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
' WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
' MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
' ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
' WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
' ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
' OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
Sub CreateCSV()

    'This macro will copy all rows from the first sheet
    '(including headers)
    'and on the next sheets will copy only the data
    '(starting on row 2)

    Dim bulk As String
    Dim i As Integer
    Dim j As Long
    Dim k As Integer
    Dim SheetCnt As Integer
    Dim firstRow1 As Long
    Dim lstRow1 As Long
    Dim lstRow2 As Long
    Dim lstCol As Integer
    Dim previousRow2 As Long
    Dim ws1 As Worksheet
    Dim myName As String
    Dim WRKDIR As String
        
    'change this to reflect where would you like to save the files
    WRKDIR = Environ$("Userprofile") & "\Desktop\PoC"
    'create the WRKDIR if it does not exist
    If Dir(WRKDIR, vbDirectory) = "" Then
        MkDir "WRKDIR"
    End If
    
    'save current name. to be used later
    myName = ActiveWorkbook.Name
    
    With Application
        .DisplayAlerts = False
        .EnableEvents = False
        .ScreenUpdating = False
    End With

    On Error Resume Next

    'Delete the Target Sheet on the document (in case it exists)
    Sheets("Target").Delete
    'Count the number of sheets on the Workbook
    SheetCnt = Worksheets.Count

    'Add the Target Sheet
    Sheets.Add after:=Worksheets(SheetCnt)
    ActiveSheet.Name = "Target"
    'Set ws1 = Sheets("Target")
    lstRow2 = 1
    'Define the row where to start copying
    '(first sheet will be row 1 to include headers)
    j = 2

    'Combine the sheets
    For i = 1 To SheetCnt
        'skip the Control sheet
        If (Worksheets(i).Name <> "Notes") Then
            If (Worksheets(i).Name <> "Control") Then

            Worksheets(i).Select

            'check what is the last column with data
            lstCol = ActiveSheet.Cells(1, ActiveSheet.Columns.Count).End(xlToLeft).Column

            'check what is the last row with data
            lstRow1 = ActiveSheet.Cells(ActiveSheet.Rows.Count, "A").End(xlUp).Row
                   
            'Define the range to copy
            Range("A" & j, Cells(lstRow1, lstCol)).Select

            'Copy the data
            Selection.Copy
            Sheets("Target").Range("B" & lstRow2).PasteSpecial
            Application.CutCopyMode = False

            'Define the new last row on the Target sheet
            firstRow1 = lstRow2 + 1
            lstRow2 = Sheets("Target").Cells(65536, "B").End(xlUp).Row + 1
            
            'Define the row where to start copying
            '(2nd sheet onwards will be row 2 to only get data)
            j = 2
                
            'write the name of the tab in the first row
            Sheets("Target").Range("A" & firstRow1, "A" & (lstRow2 - 1)) = ActiveSheet.Name
    
            'ws1 => Target sheet
            'key=value loop
            Dim colidx As Long
    
            For colidx = 2 To (lstCol + 1)
                 For k = firstRow1 To (lstRow2 - 1)
                         bulk = Sheets("Target").Cells(k, colidx).Value
                         Sheets("Target").Cells(k, colidx).Value = "questions." & ActiveCell.Cells(0, colidx - 1) & "=" & bulk
                 Next
            Next
            End If
            End If
        Next
    
       Dim rowidx As Integer
    
        'clean the headers away
        Sheets("Target").Columns("A").SpecialCells(xlCellTypeBlanks).EntireRow.Delete

        With Application
            .DisplayAlerts = True
            .EnableEvents = True
            .ScreenUpdating = True
        End With

        Sheets("Target").Select
        Cells.EntireColumn.AutoFit
        Range("B1").Select

        'Exporting Target as a CSV file
        Application.DisplayAlerts = False
        Sheets("Target").SaveAs Filename:=WRKDIR & "\" & "w4n_poc", FileFormat:=xlCSV
        
        'Restore the filename. This is necessary otherwise Excel
        'will show the current workbook as "Target" which might
        'cause confusion
        ActiveWorkbook.SaveAs Filename:=WRKDIR & "\" & myName, FileFormat:=52, ConflictResolution:=xlLocalSessionChanges
        
        ActiveSheet.Name = "Target"
            
        Application.DisplayAlerts = True
        MsgBox "CSV file created with success!", vbInformation, "Success"
        
        Sheets("Control").Activate
End Sub
' Copyright (c) 2013 EMC Watch4net
'
' Permission to use, copy, modify, and distribute this software for any
' purpose with or without fee is hereby granted, provided that the above
' copyright notice and this permission notice appear in all copies.
'
' THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
' WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
' MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
' ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
' WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
' ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
' OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
Sub FTP()
'this function requires the presense of WinSCP so it's likely to no work everywhere.
    Dim csvFile As String
    Dim SFTPBIN As String
    Dim SFTP_HOST As String
    Dim SFTP_USERNAME As String
    Dim SFTP_PASSWORD As String
    Dim WRKDIR As String
    
    SFTBIN = "C:\Program Files (x86)\WinSCP\WinSCP.exe"
    SFTP_USERNAME = Sheets("Control").Range("E7")
    SFTP_PASSWORD = Sheets("Control").passwordBox.Value
    SFTP_HOST = Sheets("Control").Range("E9")
    WRKDIR = Environ$("Userprofile") & "\Desktop\PoC"
    csvFile = "w4n_poc.csv"
    
    'create the WRKDIR if it does not exist
    If Dir(WRKDIR, vbDirectory) = "" Then
        MkDir "WRKDIR"
    End If
       
    'Mounting file command for ftp.exe
    fh = FreeFile()
    Open WRKDIR & "\sftp_control.txt" For Output As #fh
    Print #fh, "open sftp://" & SFTP_USERNAME & ":" & SFTP_PASSWORD & "@" & SFTP_HOST
    Print #fh, "rm PoC/" & csvFile
    Print #fh, "put " & WRKDIR & "\" & csvFile & " /opt/APG/PoC/" & csvFile
    Print #fh, "close" ' close connection
    Print #fh, "exit" ' Quit ftp program Close
    Close #fh
   
    Shell "C:\Program Files (x86)\WinSCP\WinSCP.exe" & " /script=" & WRKDIR & "\sftp_control.txt /log=" & WRKDIR & "\sftp_log.txt", vbNormalNoFocus
    SetAttr WRKDIR & "\sftp_control.txt", vbNormal
    'Kill WRKDIR & "\sftp_control.txt"
    
    MsgBox csvFile & " transfered to " & SFTP_HOST & " with success", vbInformationm, "File Transfer"
    
End Sub

