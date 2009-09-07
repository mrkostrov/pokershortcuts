/*
 * Copyright (C) 2007, 2008, 2009 Windy Hill Technology LLC
 *
 * This file is part of Poker Shortcuts.
 *
 * Poker Shortcuts is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Poker Shortcuts is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FT Table Opener.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Project Home: http://code.google.com/p/pokershortcuts/
 */
 
 
 ; ******************************************************************************
; ------------------------------------------------------------------------------
; subroutines for hotkeys
; ------------------------------------------------------------------------------
; ******************************************************************************




;   Suspend Subroutines  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
; there is one special hotkey to disable all hotkeys. Control-Esc

; enable this one hotkey in the FT lobby, FT tables, FT tourney lobbies, and FTSC
; the Suspend command toggles the Suspend State
; then call the AllHotKeysEnabledToggle subroutine below to change the flags and status controls

#IfWinActive ahk_group Lobby
^Esc::
Suspend
Gosub AllHotKeysEnabledToggle
return


#IfWinActive ahk_group Tables
^Esc::
Suspend
Gosub AllHotKeysEnabledToggle
return

#IfWinActive ahk_group PokerShortcuts
^Esc::
Suspend
Gosub AllHotKeysEnabledToggle
return

#IfWinActive ahk_group TournamentLobby
^Esc::
Suspend
Gosub AllHotKeysEnabledToggle
return

ToggleSuspend:
Suspend
Gosub AllHotKeysEnabledToggle
return


; toggle the flag and status indicator for the All Hotkeys Disabled condition
AllHotKeysEnabledToggle:
Gui, 99:Default
if AllHotkeysEnabled
{
   AllHotkeysEnabled := 0
   Gui, Font, cRed bold
   GuiControl, Font, AllHotkeysEnabledStatus
   GuiControl,,AllHotkeysEnabledStatus, %Msg15%
}
else
{
   AllHotkeysEnabled := 1
   Gui, Font, cGreen norm
   GuiControl, Font, AllHotkeysEnabledStatus
   GuiControl,,AllHotkeysEnabledStatus, %Msg14%
}
return



;   Street Bet Subroutines  --------------------------------------------------------------------------------------------------------------------------------------------

StreetBet:
      BetStreetAmount()
Return



;   Inc/Dec Bet Subroutines  ----------------------------------------------------------------------------------------------------------------------------------------
BetModifyUp1:
      BetModify(VarBetAmount1, VarBetUnits1)
Return

BetModifyDown1:
      BetModify(-VarBetAmount1, VarBetUnits1)
Return

BetModifyUp2:
      BetModify(VarBetAmount2, VarBetUnits2)
Return

BetModifyDown2:
      BetModify(-VarBetAmount2, VarBetUnits2)
Return

BetModifyUp3:
      BetModify(VarBetAmount3, VarBetUnits3)
Return

BetModifyDown3:
      BetModify(-VarBetAmount3, VarBetUnits3)
Return

BetModifyUp4:
      BetModify(VarBetAmount4, VarBetUnits4)
Return

BetModifyDown4:
      BetModify(-VarBetAmount4, VarBetUnits4)
Return




;   Fixed Bet Subroutines  ----------------------------------------------------------------------------------------------------------------------------------------
BetFixed1:
      BetFixedAmount(1)
Return

BetFixed2:
      BetFixedAmount(2)
Return

BetFixed3:
      BetFixedAmount(3)
Return

BetFixed4:
      BetFixedAmount(4)
Return

BetFixed5:
      BetFixedAmount(5)
Return

BetMax:
      BetMax()
Return

BetPot:
      BetPot()
Return

; Deal Me  Subroutines  -----------------------------------------------------------------------------------------------------------------------------------------
CycleDealMeModesOnActiveTable:
      CycleDealMeModesOnActiveTable()
Return

CycleDealMeModesOnAllTables:
      CycleDealMeModesOnAllTables()
Return



; SnG A  Subroutines  ------------------------------------------------------------------------------------------------------------------------------------------


; ???????????????????????????????????????????????????????????????????????????????????????????????????   what should we do with these global variables
Sng1Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(1, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng2Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(2, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng3Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(3, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng4Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(4, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng5Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(5, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng6Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(6, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng7Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(7, StatusNum, SngTournamentNum, SngLobbyId)
Return

/*
Sng8Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(8, StatusNum, SngTournamentNum, SngLobbyId)
Return

Sng9Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   FTSngOpen(9, StatusNum, SngTournamentNum, SngLobbyId)
Return
*/

Sng11Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(11, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng12Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(12, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng13Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(13, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng14Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(14, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng15Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(15, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng16Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(16, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return

Sng17Open:
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0
   PSSngOpen(17, StatusNum, SngTournamentNum, SngLobbyId)
;outputdebug, Sng1Open      StatusNum:%StatusNum%   SngTournamentNum:%SngTournamentNum%
Return



; open a sng based on the number inputted by the user
;SngOpen:

/*
   SettingsUpdateHotkeys(0)      ; disable hotkeys during input command below, so that the numbers 0-9 can be used even if they are a hotkey
   ; open the sng, based on the input number specified by the user
   SngOpen(Input("L1 T3","",""),0)
   SettingsUpdateHotkeys(1)
*/

;Return

; SnG B  Subroutines  --------------------------------------------------------------------------------------------------------------------------------

;SngContinuouslyOpenToggle:

/*
   SngContinuouslyOpenEnabled := NOT SngContinuouslyOpenEnabled
   Gui, 99:Default
   GuiControl,, SngContinuouslyOpenEnabled, %SngContinuouslyOpenEnabled%

   if SngContinuouslyOpenEnabled
   {
      SngContinuouslyOpenSet(1)
   }
   else
   {
      SngContinuouslyOpenSet(0)
   }
*/

;Return

SngStart:
   SngContinuouslyOpenSet(2)
Return
SngStop:
   SngContinuouslyOpenSet(0)
Return
SngPause:
   SngContinuouslyOpenSet(3)
Return
SngResume:
   SngContinuouslyOpenSet(1)
Return



; SnG T  Subroutines  --------------------------------------------------------------------------------------------------------------------------------


PSSngOpenHighlighted:
   ; get the id of the Stars lobby
   WinId := LobbyId("PS")
   ButtonClick("ButtonMainLobbyRegister", WinId)
Return

FTSngOpenHighlighted:
   ; get the id of the FT lobby
   WinId := LobbyId("FT")   
   ButtonClick("ButtonMainLobbyRegister", WinId)
Return

; Actions1 Subroutines  -----------------------------------------------------------------------------------------------------------------------------

ClickFoldCheck:
;outputdebug, in fold check
      ClickFoldCheck()
Return


; click the Fold or Check button on the "active table"
; Also this will click the I'M back button and similiarily numbered buttons
ClickFoldCheck(WinId="")
{
   ;local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   %CasinoName%ClickFoldCheck(WinId)
}


/*
FTClickFoldCheck(WinId)
{
   global

   ; if the button is visible, then click it
   if (ButtonVisible("ButtonImBack", WinId) == 1)
   {
      ButtonClick("ButtonImBack", WinId)
   }
   ; if the fold button is visible, then click it
   else if (ButtonVisible("ButtonFold", WinId) == 1 or ButtonVisible("ButtonCheck", WinId) == 1  )
   {
      ButtonClick("ButtonCheck", WinId)
   }
   ; else check if the option is enabled to click the PRE-ACTION checkbox
   else if PreActionFoldControlEnabled
   {
      ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
      if (CheckboxGetState("CheckboxFold", WinId) >= 0 )
      {
         CheckboxSetState(2, "CheckboxFold", WinId)
         return
      }   
   }
   ; else just click the left button position... could be the post big blind button
   ;ButtonClick("ButtonFold", WinId)   
   
}
*/

FTClickFoldCheck(WinId)
{
   global
   
   ; check if the checkbox is visible (>= 0), 
   if (CheckboxGetState("CheckboxFold", WinId) >= 0 )
   {
      ; if enabled to click this checkbox, then click it
      if PreActionFoldControlEnabled   
         CheckboxSetState(2, "CheckboxFold", WinId)
         
      ; return since the checkbox is visible... we won't be clicking any buttons   
      return   
   
   }
   
   ButtonClick("ButtonFold", WinId)   
   
}


PSClickFoldCheck(WinId)
{
   global

   ; need to check if the "Check" button is visible... if so, click it instead
   if (ButtonVisible("ButtonCheck", WinId) == 1)
   {
      ButtonClick("ButtonCheck", WinId)
      return
   }
   ; else if the button is visible, then click it
   else if (ButtonVisible("ButtonFold", WinId) == 1)
   {
      ButtonClick("ButtonFold", WinId)
      return
   }
   ; if the button is visible, then click it
   else if (ButtonVisible("ButtonImBack", WinId) == 1)
   {
      ButtonClick("ButtonImBack", WinId)
      return
   }
   ; else check if the option is enabled to click the PRE-ACTION checkbox
   else if PreActionFoldControlEnabled
   {
      ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
      if (CheckboxGetState("CheckboxFold", WinId) >= 0 )
      {
         CheckboxSetState(2, "CheckboxFold", WinId)
         return
      }
      ; on some sites, one or the other of these boxes will be visible
      ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
      if (CheckboxGetState("CheckboxCheckFold", WinId) >= 0 )
      {
         CheckboxSetState(2, "CheckboxCheckFold", WinId)
         return
      }
   }
   ; else just click the left button position... could be the post big blind button
   ButtonClick("ButtonFold", WinId)
}







ClickCall:
   ClickCall()
Return


; click the Call button on the "active table"
ClickCall(WinId="")
{
   ; local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   ; get the casino name
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   %CasinoName%ClickCall(WinId)
}


/*
FTClickCall(WinId)
{
   global

   ; if the button is visible, then click it
   if (ButtonVisible("ButtonCall", WinId) == 1)
   {
      ButtonClick("ButtonCall", WinId)
      return
   }
   ; else check if the option is enabled to click the PRE-ACTION checkbox
   else if PreActionCallControlEnabled
   {
      ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
      if (CheckboxGetState("CheckboxCall", WinId) >= 0 )
      {
         CheckboxSetState(2, "CheckboxCall", WinId)
         return
      }
   }
   ; if the check button is visible, since the CALL button is not visible, so then click it
   if (ButtonVisible("ButtonCheck", WinId) == 1)
   {
      ButtonClick("ButtonCheck", WinId)
      return
   }
   ; else just click the middle button
   ButtonClick("ButtonCall", WinId)
   
}
*/

FTClickCall(WinId)
{
   global
   
   ; if the call checkbox is visible
   if (CheckboxGetState("CheckboxCall", WinId) >= 0 )
   {
      ; and we are enabled to click it
      if PreActionCallControlEnabled
      {
         CheckboxSetState(2, "CheckboxCall", WinId)
      }
      ; return since the checkbox is visible
      return
   }   

   ; if the check button is visible, since the CALL button is not visible, so then click it
   if (ButtonVisible("ButtonCheck", WinId) == 1)
   {
      ButtonClick("ButtonCheck", WinId)
      return
   }
   ; else just click the middle button
   ButtonClick("ButtonCall", WinId)
   
}


PSClickCall(WinId)
{
   global
   
   ; need to check if the button is visible... if so, click it instead
   if (ButtonVisible("ButtonCheck", WinId) == 1)
   {
      ButtonClick("ButtonCheck", WinId)
      return
   }
   ; need to check if the button is visible... if so, click it instead
   else if (ButtonVisible("ButtonCall", WinId) == 1)
   {
      ButtonClick("ButtonCall", WinId)
      return
   }
   ; else check if the option is enabled to click the PRE-ACTION checkbox
   else if PreActionCallControlEnabled
   {
      ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
      if (CheckboxGetState("CheckboxCall", WinId) >= 0 )
      {
         CheckboxSetState(2, "CheckboxCall", WinId)
         return
      }
   }
   ; else just click the middle button position... could be the post small blind button
   ButtonClick("ButtonCall", WinId)

}







ClickBetRaise:
   ClickBetRaise()
Return



; click the Bet or Raise button on the "active table"
ClickBetRaise(WinId="")
{
   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   

   ButtonClick("ButtonRaise", WinId)
}





; toggle preaction check/fold
ClickLeftCheckbox:
   ClickLeftCheckbox()
Return


ClickLeftCheckbox(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxFold", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxFold", WinId)

   ; on some sites, one or the other of these boxes will be visible
   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxCheckFold", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxCheckFold", WinId)
}

; toggle pre-action check/call
ClickMiddleCheckbox:
   ClickMiddleCheckbox()
return

ClickMiddleCheckbox(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxCall", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxCall", WinId)
}



ClickCallAnyCheckbox:
   ClickCallAnyCheckbox()
return

ClickCallAnyCheckbox(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxCallAny", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxCallAny", WinId)
}



ClickRaiseMinCheckbox:
   ClickRaiseMinCheckbox()
Return

ClickRaiseMinCheckbox(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxRaiseMin", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxRaiseMin", WinId)
}



ClickRaiseAnyCheckbox:
   ClickRaiseAnyCheckbox()
return


ClickRaiseAnyCheckbox(WinId="")
{
   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxRaiseAny", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxRaiseAny", WinId)
}





BetWindowClear:
   BetWindowClear()
Return






ClickFoldToAnyBetCheckbox:
   ClickFoldToAnyBetCheckbox()
Return


ClickFoldToAnyBetCheckbox(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxFoldToAnyBet", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxFoldToAnyBet", WinId)
}


; Actions2 Subroutines  ----------------------------------------------------------------------------------------------------------------------



PlayersName:
      clipboard := PlayersName()
Return

;PlayersNameToSharkList:
;      PlayersNameToSharkList()
;Return

;PlayersNameFromSharkList:
;      PlayersNameFromSharkList()
;Return

TableTournamentId:
      clipboard := TableNameOrNumber()
Return

ReloadChips:
   ReloadChips()
Return

ReloadAll:
;      ReloadAll()
Return


TableMoveToFromChat:
   TableMoveToFromChat()
Return

ClickTimer:
   ClickTimer()
Return

; click the Timer button on the specified table
;     if pWinId = "" then activate the table under the mouse, and click that table's timer button
; return 0 if successful, return 1 if not successful
ClickTimer(WinId="")
{

   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   if (ButtonVisible("ButtonTime", WinId) == 1)
   {
      ButtonClick("ButtonTime", WinId)
   }

}

ClickTimerAll:
   ClickTimerAll()
Return


ClickTimerAll()
{
   local WinId, TableIdList

   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, TableIdList, List, ahk_group Tables

   ; loop through all of the open tables
   Loop, %TableIdList%
   {

      ; find the next ID of the next FTP table
      WinId := TableIdList%A_Index%

      if (ButtonVisible("ButtonTime", WinId) == 1)
      {
         ButtonClick("ButtonTime", WinId)
      }
   }
}



TableLastHand:
   TableLastHand()
Return



; NOTE: right now Full Tilt has different button names for this depending upon being a Ring or tournament.
;       if this ever changes (like when they go to a graphics table), then we can change this routine to not have the 2 cases.
TableLastHand(WinId="")
{
   global
   local PreviousWinId, TableRingOrTournament

  ; if a previous last hand window exists, then close it
  ; else click the last hand button on the active table
  PreviousWinId := WinExist("ahk_group LastHand")
  if PreviousWinId
  {
    PostMessage, 0x112, 0xF060,,,ahk_group LastHand
  }
   else
   {
      ; if a WinId waas not specified, use the Table under the mouse
      if ! WinId
      {
         WinId := TableActivateUnderMouse()
         if ! WinId
            return
      }
      ; the last hand button is dependent on being a ring our tournament game
      if (TableRingOrTournament(WinId))
      {
         ; if ring game
         ; click the last hand button on the table
         ButtonClick("ButtonRingLastHand",WinId)
      }
      else
      {
         ; else tournament
         ; click the last hand button on the table
         ButtonClick("ButtonTournamentLastHand",WinId)
      }

   }
}



TableTourneyInfo:
   TableTourneyInfo()
return

/*
  ; if a tournament info window exists, then close it
  ; else click the last hand button on the active table
  WinId := WinExist("Tournament Status")
  if WinId
  {
    ;PostMessage, 0x112, 0xF060,,,Tournament Status
    WinClose, Tournament Status ahk_class #32770
  }
  else
  {
    WinId := WinExist("A")
    ; if this table is a Tournament table, then click on the tournament info
    if (NOT TableRingOrTournament(WinId))
      ControlClick, %TournamentInfoButton%,,,,,NA
  }
*/

TableTourneyInfo(WinId="")
{
   global
   local CasinoName, PreviousWinId

  ; if a previous window exists, then close it
  ; else click the last hand button on the active table
  PreviousWinId := WinExist("ahk_group TournamentInfo")
  if PreviousWinId
  {
    PostMessage, 0x112, 0xF060,,,ahk_group TournamentInfo
  }
   else
   {
      ; if a WinId waas not specified, use the Table under the mouse
      if ! WinId
      {
         WinId := TableActivateUnderMouse()
         if ! WinId
            return
      }
      ; click the tourney info button on the table
      ButtonClick("ButtonTournamentInfo",WinId)
   }
}


Notes:
      Notes()
Return







; open notes for player N
NotesOpenPlayerN:
   SettingsUpdateHotkeys(0)      ; disable hotkeys during input command below, so that the numbers 1-9 can be used even if they are a hotkey
   ; NotesPlayerN(ColorChangeOnly, NotesColor, NanoNotesFlag, PlayerNum, EditNotesFlag,WinId="")
   NotesPlayerN(0,0,0,Input("L1 T3","",""),1,"")
   SettingsUpdateHotkeys(1)
Return


; view notes for player N
NotesPlayerN:
   SettingsUpdateHotkeys(0)      ; disable hotkeys during input command below, so that the numbers 1-9 can be used even if they are a hotkey
   ; NotesPlayerN(ColorChange, NotesColor, NanoNotesFlag, PlayerNum, EditNotesFlag,WinId="")
   NotesPlayerN(0,0,0,Input("L1 T3","",""),0,"")
   SettingsUpdateHotkeys(1)
Return


NotesNano:
      ; FTNotesNano(ColorChangeOnly, NotesColor, WinId="")
      FTNotesNano(0,0,"")
Return


NotesNanoPlayerN:
   SettingsUpdateHotkeys(0)      ; disable hotkeys during input command below, so that the numbers 1-9 can be used even if they are a hotkey
   ; NotesPlayerN(ColorChangeOnly, NotesColor, NanoNotesFlag, PlayerNum, EditNotesFlag,WinId="")
   NotesPlayerN(0,0,1,Input("L1 T3","",""),1,"")
   SettingsUpdateHotkeys(1)
Return


NotesColorN:
   SettingsUpdateHotkeys(0)            ; disable hotkeys
   ;FTNotesNano(ColorChangeOnly, NotesColor, WinId="")
   ; we input the color number to change to (for the player under the mouse)
   FTNotesNano(1,Input("L1 T5 I", "", ""),"")
   SettingsUpdateHotkeys(1)            ; enable hotkeys
return

NotesColorUp:
   FTNotesColorUp()
Return

NotesColorDown:
   FTNotesColorDown()
Return


NotesClose:
   FTNotesClose()
Return






; Actions3 Subroutines  ---------------------------------------------------------------------------------------------------------------------------------

ToggleSitOut:
   ToggleSitOut()
Return

ToggleSitOut(WinId="")
{

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxSitOutNextHand", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxSitOutNextHand", WinId)
}


ClickSitInAll:
   ClickSitInAll()
Return

ClickSitInAll()
{
   local WinId, TableIdList

   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, TableIdList, List, ahk_group Tables

   ; loop through all of the open tables
   Loop, %TableIdList%
   {

      ; find the next ID of the next FTP table
      WinId := TableIdList%A_Index%

      CheckboxSetState(0, "CheckboxSitOutNextHand", WinId)
   }
}

ClickSitOutAll:
   ClickSitOutAll()
Return

ClickSitOutAll()
{
   local WinId, TableIdList

   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, TableIdList, List, ahk_group Tables

   ; loop through all of the open tables
   Loop, %TableIdList%
   {

      ; find the next ID of the next FTP table
      WinId := TableIdList%A_Index%

      CheckboxSetState(1, "CheckboxSitOutNextHand", WinId)
   }
}


ToggleAPB:
   ToggleAPB()
Return

ToggleAPB(WinId="")
{
   local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; we need an exception case for Poker Stars. On their fast ring game tables, there isn't an APB checkbox
   ; so just return
   if TableFast(WinId)
      return
   
   ; check if the checkbox is visible (>= 0), if so then toggle the checkbox
   if (CheckboxGetState("CheckboxAutoPostBlinds", WinId) >= 0 )
      CheckboxSetState(2, "CheckboxAutoPostBlinds", WinId)

}



TableCloseActive:
   ; close Active table
   TableClose(1)
Return

TableCloseActiveWithoutHero:
   ; close active table if without the hero
   TableCloseWithoutHero(1)
Return

TableCloseAll:
   ; close ALL tables
   TableClose(0)
Return

TableCloseAllWithoutHero:
   ; close ALL tables without the hero
   TableCloseWithoutHero(0)
Return


TableMinimizeAll:
   ; Minimize ALL tables
   TableMinimize(0)
Return

TableMinimizeAllWithoutHero:
   ; Minimize ALL tables without the hero
   TableMinimizeWithoutHero(0)
Return


LobbyTournamentClose:
   ; close ALL open tournament lobbies
   LobbyTournamentClose(1)
Return

;TableCloseAllTournamentTablesWithoutHeroDelayed:
;   TableCloseAllTournamentTablesWithoutHeroDelayed()
;Return


LobbyTournamentMinimize:
   ; Minimize ALL open tournament lobbies
   LobbyTournamentMinimize(0)
Return



TableNext:
      TableNext()
Return

TablePrevious:
      TablePrevious()
Return




TableLeft:
      TableLeft()
Return

TableRight:
      TableRight()
Return

TableUp:
      TableUp()
Return

TableDown:
      TableDown()
Return



TableNextInStack:
      TableNextInStack()
Return

TableBottomOfStack:
      TableBottomOfStack()
Return


; Pass parameter HotKeyFlag == 1, so that the TablePending() functions knows we called this fcn from the press of a hotkey
TablePending:

   TablePending(1)
Return









TableLayout1:
   TableLayout1()
Return

TableLayout1(WinId="")
{
   global
   local CasinoName, TX, TY, ClientScaleFactor

   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
   WinActivate, ahk_id%WinId%


            ; move the mouse to home
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
            CoordMode, Mouse, Screen
            ;if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P") OR GetKeyState("LShift", "P") OR GetKeyState("RShift", "P"))
   
            MouseMove,TX,Ty,0



   ; click the layout button on the table
   ButtonClick("ButtonLayout",WinId)
     
   sleep, 100
   

   loop, %  %CasinoName%ButtonLayoutCustomLayout1Offset
   {
      Send, ^{Down}
      sleep, 100
   }
   Send,, {enter}
   
}

TableLayout2:
   TableLayout2()
Return

TableLayout2()
{
   global
   local CasinoName, TX, TY, ClientScaleFactor

   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
   WinActivate, ahk_id%WinId%


            ; move the mouse to home
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
            CoordMode, Mouse, Screen
            ;if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P") OR GetKeyState("LShift", "P") OR GetKeyState("RShift", "P"))
   
            MouseMove,TX,Ty,0


   ; click the layout button on the table
   ButtonClick("ButtonLayout",WinId)
     
   sleep, 100
   

   loop, %  %CasinoName%ButtonLayoutCustomLayout2Offset
   {
      Send, ^{Down}
      sleep, 100
   }
   Send,, {enter}
}







TablesCascade:
   TablesCascade()
Return



TablesCascade()
{
   global
   local CasinoName, TX, TY, ClientScaleFactor

   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   WinActivate, ahk_id%WinId%


            ; move the mouse to home
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
            CoordMode, Mouse, Screen
            ;if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P") OR GetKeyState("LShift", "P") OR GetKeyState("RShift", "P"))
   
            MouseMove,TX,Ty,0

   ; click the layout button on the table
   ButtonClick("ButtonLayout",WinId)
        
   sleep, 100


   loop, %  %CasinoName%ButtonLayoutCascadeTablesOffset
   {
      Send, ^{Down}
      sleep, 100
   }
   Send,, {enter}
}

TablesTile:
   TablesTile()
Return


TablesTile(WinId="")
{
   global
   local CasinoName, TX, TY, ClientScaleFactor

   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   WinActivate, ahk_id%WinId%


            ; move the mouse to home
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
            CoordMode, Mouse, Screen
            ;if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P") OR GetKeyState("LShift", "P") OR GetKeyState("RShift", "P"))
   
            MouseMove,TX,Ty,0

   ; click the layout button on the table
   ButtonClick("ButtonLayout",WinId)
      
   sleep, 100


   loop, %  %CasinoName%ButtonLayoutTileTablesOffset
   {
      Send, ^{Down}
      sleep, 100
   }
   Send,, {enter}
}





OpenCashier:
   LobbyOpenCashier()
Return


; Displays Subroutines  -------------------------------------------------------
RefreshOSD1:


   WinId := TableActivateUnderMouse()
   if ! WinId
       return
;outputdebug, refresh
   DisplayOsd1(WinId)
return



; Chips Subroutines  -------------------------------------------------------

; Table1 Subroutines  -------------------------------------------------------

ManualMoveTable:
   TableManualMove()
return

ManualMoveTable2:
   Table2ManualMove()
return

; Table2 Subroutines  -------------------------------------------------------

; Dialogs Subroutines  -------------------------------------------------------


;PlaySound:
;   SoundPlay, Sounds\%TableAvailableWaveFile%
;Return



RejectSeat:
   RejectSeatIfSeatAvailableEnabled := NOT RejectSeatIfSeatAvailableEnabled
   Gui, 99:Default
   GuiControl,, RejectSeatIfSeatAvailableEnabled, %RejectSeatIfSeatAvailableEnabled%
Return


; Misc Subroutines  -------------------------------------------------------



; Calib Subroutines  -------------------------------------------------------

FTColorSample9m:
   FTColorSampleSeats(9)
   ; save the new colors to the Table theme .ini file
   IniWriteTableThemeCalibration(FTTableTheme, "FT")
Return

FTColorSample8m:
   FTColorSampleSeats(8)
   ; save the new colors to the Table theme .ini file
   IniWriteTableThemeCalibration(FTTableTheme, "FT")
Return

FTColorSample6m:
   FTColorSampleSeats(6)
   ; save the new colors to the Table theme .ini file
   IniWriteTableThemeCalibration(FTTableTheme, "FT")
Return

FTColorSample2m:
   FTColorSampleSeats(2)
   ; save the new colors to the Table theme .ini file
   IniWriteTableThemeCalibration(FTTableTheme, "FT")
Return

PSColorSampleStreets:
   ColorSampleStreets("PS")
   IniWriteTableThemeCalibration(PSTableTheme, "PS")
Return

FTColorSampleStreets:
   ColorSampleStreets("FT")
   IniWriteTableThemeCalibration(FTTableTheme, "FT")
Return



; Reg Subroutines  -------------------------------------------------------


; Setup Subroutines  -------------------------------------------------------

SelectPSHHFolder:
   FileSelectFolder, PSHHFolder, *%PSHHFolder%, 3, Select the Stars Hand History Folder
   if ! ErrorLevel
   {
      Gui, 99:Default
      GuiControl,,PSHHFolder, %PSHHFolder%
   }
Return

SelectFTHHFolder:
   FileSelectFolder, FTHHFolder,*%FTHHFolder%, 3, Select the Full Tilt Hand History Folder
   if ! ErrorLevel
   {
      Gui, 99:Default
      GuiControl,,FTHHFolder, %FTHHFolder%
   }
Return

SelectPSSettingsFolder:
   FileSelectFolder, PSSettingsFolder,*%PSSettingsFolder%,3, Select the Poker Stars Settings Folder
   if ! ErrorLevel
   {
      Gui, 99:Default
      GuiControl,,PSSettingsFolder, %PSSettingsFolder%
   }
Return

; modify the Poker Stars user.ini file with the settings we need
ModifyPSUserFile:

   ; check if poker stars lobby is open... if so, tell user to exit Stars first
   ifWinExist, ahk_group PSLobby
   {
		MsgBox,,,You need to close the Poker Stars main lobby before doing this operation!,30
		return
   }

   FileName := PSSettingsFolder . "\user.ini"
   ; check if we can see the user.ini file
	IfNotExist, %FileName%				;The log file does not Exist
	{
		MsgBox,,,Path to the Poker Stars user.ini File:`n"%FileName%"`nis not valid.`Double check the "Poker Stars Setting Folder" location on the Setup tab.,30
		return
	}

   ; write the f5redrawtable value to the user.ini file
   IniWrite,1, %FileName%, Options,f5redrawtable
   
   
   IniRead, TestVar, %FileName%, Options,f5redrawtable
   if (TestVar == 1)
		MsgBox,,,The Poker Stars user.ini file has been successfully updated.,30
   else
   	MsgBox,,,The Poker Stars user.ini file was NOT successfully updated..`Double check the "Poker Stars Setting Folder" location on the Setup tab.,30

return

; Gary tab Subroutines  -------------------------------------------------------

NotesNanoAll:
;   NanoNotesAll(WinActive("A"))
Return


;NotesNanoSetSharkScopeColorAll:
;   NotesNanoSetSharkScopeColorAll(WinActive("A"))
;Return











; ******************************************************************************
; ------------------------------------------------------------------------------
; subroutines for menu items
; ------------------------------------------------------------------------------
; ******************************************************************************


MinimizeToTray:
   WinHide, ahk_group PokerShortcuts
return

; ------------------------------------------------------------------------------

Restore:
   WinShow, ahk_group PokerShortcuts
   WinActivate, ahk_group PokerShortcuts
   WinRestore, ahk_group PokerShortcuts
return


; ------------------------------------------------------------------------------

Close:
   WinShow, ahk_group PokerShortcuts
   WinActivate, ahk_group PokerShortcuts
   WinRestore, ahk_group PokerShortcuts
   Goto, ExitSub
; ------------------------------------------------------------------------------

;Minimize-Button
99GuiSize:
if Errorlevel = 1   ;Is '1' when Minimize-Button was pressed
{
   WinHide, ahk_group PokerShortcuts
}
return

; ------------------------------------------------------------------------------

; Display About Message box for menu item "About"
About:
   MsgBox %Title% `nVersion %Ver%  `nCopyright 2007-2009 by Contributors `nLicensed under GNU GPL v3
Return

; ------------------------------------------------------------------------------

; Open this web page for menu item "Help"
;Documentation:
;   Run %WebAddress%
;Return


; ------------------------------------------------------------------------------




; jump to the website to see if we have the latest version
;CheckForNewVersionFromWeb:
;   
;return


; ******************************************************************************
; ------------------------------------------------------------------------------
; subroutines for timers
; ------------------------------------------------------------------------------
; ******************************************************************************

; Main Timer Routine
; Check for Timed Features if enabled
TimerFast:
   TimerFast()
Return



; Medium Timer Routine
; Check for Timed Features if enabled
TimerMedium:
   TimerMedium()
Return

; Slower Timer Routine
; Check for Timed Features if enabled
TimerSlow:
   TimerSlow()
Return

; this is called by the sng timer
SngContinuouslyOpen:
   SngContinuouslyOpen()
return

; ******************************************************************************
; ------------------------------------------------------------------------------
; subroutines - MISC
; ------------------------------------------------------------------------------
; ******************************************************************************


; was this next one implemented?  I don't see it in GUI

LobbyToggleAutoMuckHands:
   LobbyToggleAutoMuckHands()
Return



; set flag to indicate when a left click occurred
;  this hotkey code is only used during critical sections of the code
LeftClick:
;      LeftMouseClickOccurredFlag := 1
      ; save the win id and control that the mouse is currently over (so we can be sure we are still over it when
      ; this software re-clicks the mouse there)
;      if (!LeftMouseClickOccurredFlag)
;         MouseGetPos,,, LeftClickWinId, LeftClickControl
Return


LeftClickCheck()
{
      global


      ;if the mouse has not been clicked left clicked already, and the left button is currently down
      ; then set flag indicated it was clicked and save the window and control the mouse was over


      ; save the win id and control that the mouse is currently over (so we can be sure we are still over it when
      ; this software re-clicks the mouse there)
      if ((!LeftMouseClickOccurredFlag)  AND (GetKeyState("LButton", "P")))
      {
         MouseGetPos,,, LeftClickWinId, LeftClickControl
         LeftMouseClickOccurredFlag := 1
      }
}



SettingsUpdateHotkeys:
   SettingsUpdateHotkeys(-1)
Return

SettingsWrite:
   SettingsWrite(CurrentSetNum)
return


; any change made to the gui will call this and this will write the contents of each gui to its corresponding variable
; this gets called if the user updates a gui item, or if software updates a gui item.
; if the software is updating the gui, we usually don't need to update the associated variables, so in software
;     we can set the GuiSoftwareUpdateFlag to true, and then we just return from this subroutine.
; this code also checks to see if a change was made to some variable that has dependencies, and then calls the SettingsUpdateDependentVariables() function.
SettingsSubmitVariables:

outputdebug,  in gosub SettingsSubmitVariables     A_GuiControl:%A_GuiControl%

   ; GuiSoftwareUpdateFlag is true if in software we are updating the gui
   if GuiSoftwareUpdateFlag
      return

   ; since the user made some change, set up to save the settings to the hard drive
   SetTimer, SettingsWrite, %SaveSettingsInterval%, %SaveSettingsPriority%

   ; copy all GUI values to their corresponding variables
   Gui, 99:Default
   GUI, Submit, NoHide
   
   
   ; these variables need to be edited in case the user messes up
   ; remove all of the spaces out of these vars
   StringReplace,KeyListToDisableShortcuts,KeyListToDisableShortcuts,%A_Space%,,All

   
;outputdebug, sng11game:%sng11game%
   
   ; if changes are made to some specific gui elements (that have things that are dependent on them, then we need to call the SettingsUpdateDependentVariables()
   ;    function that will make the proper changes needed.
   ; call that function to see if any dependent items need updating
   
   ; if we add another if case here, then also add it to:  SettingsUpdateDependentVariables()
   
   if  (    (instr(A_GuiControl,"Sng") AND  instr(A_GuiControl,"Description"))
         OR instr(A_GuiControl,"Theme")
         OR instr(A_GuiControl,"JoyNum")
         OR instr(A_GuiControl,"ProcessPriority")   )
   {
      SettingsUpdateDependentVariables(A_GuiControl)
   }
return


UpdateGary1:

return


; ------------------------------------------------------------------------------

; When exiting this program, save preferences.
99GuiClose:
ExitSub:

outputdebug, in exitsub

   SetTitleMatchMode, 3

   ; restore the program in case it is hidden
   WinShow, ahk_group PokerShortcuts
   WinRestore, ahk_group PokerShortcuts
   WinActivate, ahk_group PokerShortcuts
   WinWaitActive, ahk_group PokerShortcuts

   ; save preferences in the .ini file
   SettingsWrite(CurrentSetNum)

;soundbeep

ExitApp