#include "UIAWrappers.au3"

; #INDEX# =======================================================================================================================
; Title .........: Skype Login Automation
; AutoIt Version : 1.0
; Language ......: English
; Description ...: Login to Skype ver 8.23.0.10
; Author ........: Ahmed Shaikh Memon <blog.teemya.com>
; Requirements...: AutoIt v3.3.12, Developed/Tested on Windows 7 Ultimate SP 1
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $cDocument ="controltype:=Document"
; ===============================================================================================================================

; #GLOBAL_VARIABLES# ============================================================================================================
Local $Username	= "YOUR_SKYPE_USERNAME"
Local $Password	= "YOUR_SKYPE_PASSWORD"
; ===============================================================================================================================

;
; Start Skype
;
Local $ProgramFileDir
Switch @OSArch
	Case "X32"
		$ProgramFileDir = "Program Files"
	Case "X64"
		$ProgramFileDir = "Program Files (x86)"
EndSwitch
$ProgramFileDir = @HomeDrive & "\" & $ProgramFileDir
Run($ProgramFileDir & "\Microsoft\Skype for Desktop\Skype.exe")
Sleep(5000)


Local $bIsLoggedIn = False

; Is Skype running?
If Not WinExists("[Class:Chrome_WidgetWin_1]") Then
	ConsoleWrite("Unable to find Skype")
	Exit
EndIf

;
; Get Skype window object
;
Local $oChrome = _UIA_getFirstObjectOfElement($UIA_oDesktop,"class:=Chrome_WidgetWin_1", $treescope_children)
$oChrome.setfocus()
Sleep(1000)

;
; Click Proceed to login form
;
Local $oDocument = _UIA_getFirstObjectOfElement($oChrome, "controltype:=" & $UIA_DocumentControlTypeId, $treescope_subtree)

Local $oAnotherUser = _UIA_getObjectByFindAll($oDocument, "name:=Use another", $treescope_subtree)
If IsObj($oAnotherUser) Then
	_UIA_action($oAnotherUser,"leftclick")
	$bIsLoggedIn = True
Else
	Local $oSignInWithMS = _UIA_getObjectByFindAll($oDocument, "name:=Sign", $treescope_subtree)
	If IsObj($oSignInWithMS) Then
		_UIA_action($oSignInWithMS,"leftclick")
		$bIsLoggedIn = True
	EndIf
EndIf

If Not $bIsLoggedIn Then
	ConsoleWrite("Unable to login")
	Exit
Else
	Sleep(10000)
EndIf

;
; Write Username
;
Local $oDocument = _UIA_action($cDocument, "object")
Local $oElement = _UIA_getObjectByFindAll($oDocument, "controltype:=UIA_EditControlTypeId", $treescope_subtree)

If Not IsObj($oElement) Then
	ConsoleWrite("Unable to get Username element")
	Exit
EndIf

_UIA_action($oElement, "leftclick")
Send("^a")
Send($Username & "{ENTER}")

Sleep(5500)

;
; Write Password
;
Local $oDocument = _UIA_action($cDocument, "object")
Local $oElement = _UIA_getObjectByFindAll($oDocument, "controltype:=UIA_EditControlTypeId", $treescope_subtree)

If Not IsObj($oElement) Then
	ConsoleWrite("Unable to get Username element")
	Exit
EndIf

_UIA_action($oElement, "leftclick")
Send("^a")
Send($Password & "{ENTER}")
Sleep(5500)
