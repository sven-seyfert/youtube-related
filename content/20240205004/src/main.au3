#pragma compile(FileVersion, 0.1.0)
#pragma compile(LegalCopyright, © Sven Seyfert (SOLVE-SMART))
#pragma compile(ProductVersion, 0.1.0 - 2024-02-05)

#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y

Global $bButtonsDisplayed

_Main()

Func _Main()
    Local $mButtons[]

    Local $hGui = GUICreate('gui-demo', 400, 300)

    GUICtrlCreateLabel('test label 1', 15, 15)
    GUICtrlCreateLabel('test label 2', 15, 40)

    $mButtons.Button1 = GUICtrlCreateButton('button 1', 210, 230, 85, 25)
    $mButtons.Button2 = GUICtrlCreateButton('button 2', 300, 230, 85, 25)
    $mButtons.Button3 = GUICtrlCreateButton('button 3', 210, 260, 85, 25)
    $mButtons.Button4 = GUICtrlCreateButton('button 4', 300, 260, 85, 25)

    $bButtonsDisplayed = True
    _HideButtons($mButtons)

    GUISetState(@SW_SHOW, $hGui)

    Local Const $iCloseEventFlag = -3
    Local Const $iMouseDownFlag  = -7

    While True
        Switch GUIGetMsg()
            Case $iCloseEventFlag
                ExitLoop
            Case $iMouseDownFlag
                _ToggleButtons($hGui, $mButtons)
            Case $mButtons.Button1
                MsgBox('', '', 'button 1')
            Case $mButtons.Button2
                MsgBox('', '', 'button 2')
        EndSwitch
    WEnd
EndFunc

Func _ToggleButtons($hGui, ByRef $mButtons)
    Switch GUIGetCursorInfo($hGui)[4]
        Case $mButtons.Button1, _
             $mButtons.Button2, _
             $mButtons.Button3, _
             $mButtons.Button4
            Return
    EndSwitch

    $bButtonsDisplayed = Not $bButtonsDisplayed

    If Not $bButtonsDisplayed Then
        _ShowButtons($mButtons)
        Return
    EndIf

    _HideButtons($mButtons)
EndFunc

Func _HideButtons(ByRef $mButtons)
    Local Const $iHideControlFlag = 32

    GUICtrlSetState($mButtons.Button1, $iHideControlFlag)
    GUICtrlSetState($mButtons.Button2, $iHideControlFlag)
    GUICtrlSetState($mButtons.Button3, $iHideControlFlag)
    GUICtrlSetState($mButtons.Button4, $iHideControlFlag)
EndFunc

Func _ShowButtons(ByRef $mButtons)
    Local Const $iShowControlFlag = 16

    GUICtrlSetState($mButtons.Button1, $iShowControlFlag)
    GUICtrlSetState($mButtons.Button2, $iShowControlFlag)
    GUICtrlSetState($mButtons.Button3, $iShowControlFlag)
    GUICtrlSetState($mButtons.Button4, $iShowControlFlag)
EndFunc
