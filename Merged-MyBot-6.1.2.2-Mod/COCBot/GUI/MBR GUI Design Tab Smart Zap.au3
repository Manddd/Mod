; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design Tab MOD
; Description ...: This file Includes GUI Design
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........: LunaEclipse(February, 2016);
; Modified ......: Modified by CDudz (June 2016)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

; SmartZap GUI variables - Added by CDudz
Global $ichkSmartZap = 1
Global $ichkSmartZapDB = 1
Global $ichkSmartZapSaveHeroes = 1
Global $itxtMinDE = 250

; SmartZap stats - Added by CDudz
Global $smartZapGain = 0
Global $numLSpellsUsed = 0

; SmartZap Array to hold Total Amount of DE available from Drill at each level (1-6) - Added by CDudz
Global Const $drillLevelHold[6] = [120, _
								   225, _
								   405, _
								   630, _
								   960, _
								   1350]

; SmartZap Array to hold Amount of DE available to steal from Drills at each level (1-6) - Added by CDudz
Global Const $drillLevelSteal[6] = [59, _
                                    102, _
								    172, _
								    251, _
								    343, _
								    479]


;$hGUI_MOD = GUICtrlCreateTabItem("MOD")
$hGUI_ModSmartZap = GUICreate("", $_GUI_MAIN_WIDTH - 28, $_GUI_MAIN_HEIGHT - 255 - 28, 5, 25, BitOR($WS_CHILD, $WS_TABSTOP), -1, $hGUI_MOD)
GUISetBkColor($COLOR_WHITE, $hGUI_ModSmartZap)
;GUISwitch($hGUI_ModSmartZap)


	; SmartZap Settings
	Local $x = 26, $y = 22
    $grpStatsMisc = GUICtrlCreateGroup("SmartZap", $x - 20, $y - 20, 440, 115)
		GUICtrlCreateIcon($pIconLib, $eIcnLightSpell, $x - 10, $y + 20, 24, 24)
		GUICtrlCreateIcon($pIconLib, $eIcnDrill, $x - 10, $y - 7, 24, 24)
		$chkSmartLightSpell = GUICtrlCreateCheckbox("Use Lightning Spells to Zap Drills", $x + 20, $y - 5, -1, -1)
			$txtTip = "Check this to drop Lightning Spells on top of Dark Elixir Drills." & @CRLF & @CRLF & _
					  "Remember to go to the tab 'troops' and put the maximum capacity " & @CRLF & _
					  "of your spell factory and the number of spells so that the bot " & @CRLF & _
					  "can function perfectly."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSmartLightSpell")
			GUICtrlSetState(-1, $GUI_UNCHECKED)
		$chkSmartZapDB = GUICtrlCreateCheckbox("Only Zap Drills in Dead Bases", $x + 20, $y + 21, -1, -1)
			$txtTip = "It is recommended you only zap drills in dead bases as most of the " & @CRLF & _
					  "Dark Elixir in a live base will be in the storage."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSmartZapDB")
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$lblSmartZap = GUICtrlCreateLabel("Min. amount of Dark Elixir:", $x - 10, $y + 48, 160, -1, $SS_RIGHT)
		$txtMinDark = GUICtrlCreateInput("478", $x + 155, $y + 45, 35, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
		    $txtTip = "The value here depends a lot on what level your Town Hall is, " & @CRLF & _
					  "and what level drills you most often see."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetLimit(-1, 4)
			GUICtrlSetOnEvent(-1, "txtMinDark")
			GUICtrlSetState(-1, $GUI_DISABLE)
		$chkSmartZapSaveHeroes = GUICtrlCreateCheckbox("Don't Zap on Town Hall Snipe when Heroes Deployed", $x + 20, $y + 69, -1, -1)
			$txtTip = "This will stop SmartZap from zapping a base on a Town Hall Snipe " & @CRLF & _
					  "if your heroes were deployed. " & @CRLF & @CRLF & _
					  "This protects their health so they will be ready for battle sooner!"
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlSetOnEvent(-1, "chkSmartZapSaveHeroes")
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
	Local $x = 236, $y = 22
		$picSmartZap = GUICtrlCreateIcon($pIconLib, $eIcnDark, $x + 160, $y + 3, 24, 24)
		$lblSmartZap = GUICtrlCreateLabel("0", $x + 60, $y + 5, 80, 30, $SS_RIGHT)
			GUICtrlSetFont(-1, 16, $FW_BOLD, Default, "arial", $CLEARTYPE_QUALITY)
			GUICtrlSetColor(-1, 0x279B61)
			$txtTip = "Number of dark elixir zapped during the attack with lightning."
			GUICtrlSetTip(-1, $txtTip)
			GUICtrlCreateIcon($pIconLib, $eIcnLightSpell, $x + 160, $y + 40, 24, 24)
		$lblLightningUsed = GUICtrlCreateLabel("0", $x + 60, $y + 40, 80, 30, $SS_RIGHT)
			GUICtrlSetFont(-1, 16, $FW_BOLD, Default, "arial", $CLEARTYPE_QUALITY)
			GUICtrlSetColor(-1, 0x279B61)
			$txtTip = "Amount of used spells."
			GUICtrlSetTip(-1, $txtTip)
	GUICtrlCreateGroup("", -99, -99, 1, 1)
