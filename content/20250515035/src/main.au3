#pragma compile(FileVersion, 0.1.0)
#pragma compile(LegalCopyright, © Sven Seyfert (SOLVE-SMART))
#pragma compile(ProductVersion, 0.1.0 - 2025-05-15)

#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

#include-once
#include <Array.au3>

; 🧩 category-sort

_Main()

Func _Main()
    ;~ 1. prepare data
    Local Const $aTextsList  = _GetTexts()
    Local Const $aCategories = _GetCategories()

    ;~ 2. create 2D array (table) sorted by category
    Local Const $aCategoryTable = _ArraySwapAndAddColumn($aCategories, 'Unexpected')
    Local Const $aSortedTable   = _FillTableSortedByCategory($aCategoryTable, $aTextsList)

    ;~ 3. print as sorted list
    _PrintSortedList($aSortedTable)
EndFunc

Func _GetTexts()
    Local Const $aList[] = _
        [ _
            'Testing: Automated testing catches bugs early.', _
            'Architecture: A robust architecture supports scalable systems.', _
            'Deployment: Rapid deployment boosts market competitiveness.', _
            'Performance: Tuning enhances user satisfaction.', _
            'Development: Peer reviews improve overall development quality.', _
            'Security: Encryption is key in modern security.', _
            'Testing: Unit tests ensure component quality.', _
            'Architecture: Strategic planning drives smart architecture.', _
            'Deployment: Containerization simplifies deployment tasks.', _
            'Development: Automated builds speed up development cycles.', _
            'Performance: Caching elevates overall performance.', _
            'Testing: Testing validates system functionality.', _
            'Security: Regular audits maintain robust security.', _
            'Development: Writing efficient code fuels rapid development.', _
            'Deployment: Smooth deployment enhances user experience.', _
            'Testing: Thorough testing guarantees software reliability.', _
            'Performance: Metrics guide system improvements.', _
            'Architecture: Good architecture balances flexibility and structure.', _
            'Development: Collaboration drives continuous development.', _
            'Deployment: Blue-green deployment reduces downtime.', _
            'Security: Security practices must adapt to new threats.', _
            'Testing: Regression tests protect against new errors.', _
            'Architecture: Architecture influences maintainability and performance.', _
            'Deployment: Rollback plans are vital during deployment.', _
            'Agile methods enhance iterative development.', _
            'Performance: Load testing reveals performance limits.', _
            'Deployment: Deployment pipelines speed up releases.', _
            'Security: Strong security protects sensitive data.', _
            'Performance: Efficiency boosts scalability.', _
            'Testing: Integration tests check system coherence.', _
            'Development: Development thrives on innovation and feedback.', _
            'Testing: Continuous testing fosters agile development.', _
            'Collaboration is key in DevOps.', _
            'Performance: Optimized performance ensures fast responses.', _
            'Development: Refactoring is essential for solid development.', _
            'Deployment: Automation improves deployment consistency.', _
            'Development: Consistent documentation supports sustainable development.', _
            'Development: New frameworks spark fresh development approaches.', _
            'Development: Unit testing ensures reliable development outcomes.', _
            'Development: Modern tools accelerate development processes.', _
            'Deployment: Automated deployment minimizes errors.', _
            'Automation streamlines DevOps processes.', _
            'Deployment: Monitoring tracks release performance.' _
        ]

    Return $aList
EndFunc

Func _GetCategories()
    Local Const $aList[] = _
        [ _
            'Architecture', _
            'Deployment', _
            'Development', _
            'Performance', _
            'Security', _
            'Testing' _
        ]

    Return $aList
EndFunc

Func _ArraySwapAndAddColumn($aArray, $sColumnName)
    _ArrayTranspose($aArray)

    _ArrayColInsert($aArray, UBound($aArray, 2))
    $aArray[0][UBound($aArray, 2) - 1] = $sColumnName

    Return $aArray
EndFunc

Func _FillTableSortedByCategory($aCategoryTable, $aTextsList)
    Local $sFoundCategory
    Local $iColumn

    For $iRow = 0 To UBound($aTextsList) - 1
        $sFoundCategory = _ExtractCategory($aTextsList[$iRow])
        $iColumn        = _GetColumnIndex($sFoundCategory, $aCategoryTable)

        _ArrayAddRow($aCategoryTable)
        _FillTable($aCategoryTable, $aTextsList, $iRow, $iColumn)
    Next

    _ArrayRemoveEmptyLines($aCategoryTable)

    Return $aCategoryTable
EndFunc

Func _ExtractCategory($sText)
    Local Const $sRegExPattern = '^(\w+):'
    Local Const $aMatch = StringRegExp($sText, $sRegExPattern, 1)
    Return @error ? '-' : $aMatch[0]
EndFunc

Func _GetColumnIndex($sFoundCategory, $aTable)
    Local $iColumn

    For $i = 0 To UBound($aTable, 2) - 1
        If $sFoundCategory == $aTable[0][$i] Then
            Return $i
        EndIf
        $iColumn = UBound($aTable, 2) - 1 ; column "Unexpected", because $sFoundCategory == '-'
    Next

    Return $iColumn
EndFunc

Func _ArrayAddRow(ByRef $aArray)
    Local Const $iRows    = UBound($aArray)
    Local Const $iColumns = UBound($aArray, 2)
    ReDim $aArray[$iRows + 1][$iColumns]
EndFunc

Func _FillTable(ByRef $aTable, ByRef $aList, $iRow, $iColumn)
    Local Const $iRowCount = UBound($aTable) - 1

    For $i = 0 To $iRowCount
        If $aTable[$i][$iColumn] == '' Then ; is table cell empty
            $aTable[$i][$iColumn] = $aList[$iRow]
            ExitLoop
        EndIf
    Next
EndFunc

Func _ArrayRemoveEmptyLines(ByRef $aTable)
    Local $bRowIsEmpty

    For $i = UBound($aTable) - 1 To 0 Step - 1
        For $j = 0 To UBound($aTable, 2) - 1
            If $aTable[$i][$j] <> '' Then
                $bRowIsEmpty = False
                ExitLoop
            EndIf
            $bRowIsEmpty = True
        Next

        If $bRowIsEmpty Then
            _ArrayDelete($aTable, $i)
        EndIf
    Next
EndFunc

Func _PrintSortedList($aSortedTable)
    Local $sLine
    For $iCol = 0 To Ubound($aSortedTable, 2) - 1
        For $iRow = 1 To Ubound($aSortedTable) - 1
            $sLine = $aSortedTable[$iRow][$iCol]
            If $sLine == '' Then
                ContinueLoop
            EndIf
            ConsoleWrite($aSortedTable[$iRow][$iCol] & @CRLF)
        Next
    Next
EndFunc
