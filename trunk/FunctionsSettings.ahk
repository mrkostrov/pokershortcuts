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






; update items that are dependent on other variables
; ControlThatChanged contains the name of the gui control that changed... we will check to see if that control variable has any dependencies
; if ControlThatChanged == "All" then update everything since we have changed to a new Set
SettingsUpdateDependentVariables(ControlThatChanged)
{
   global
   local UpdateAllFlag
   
   
outputdebug, in SettingsUpdateDependentVariables
   
   ; since we are updating items in the gui from software, set GuiSoftwareUpdateFlag true, so that the gosub g-subroutine from the gui items won't continually
   ; do the gui submit in the SettingsSubmitVariables subroutine
   GuiSoftwareUpdateFlag := 1
   
   
   if (ControlThatChanged == "All")
      UpdateAllFlag := 1
   else
      UpdateAllFlag := 0
   
   
   Gui, 99:Default
   
   
   ; check if a variable has changed that has other dependent variables, if so update the dependent variables

   
   ; These description items write to the gui... but the g-subroutine will not be called on these because the DescriptionB edit boxes do not list the g-subroutine
   if ((instr(ControlThatChanged,"Sng") AND  instr(ControlThatChanged,"Description")) OR UpdateAllFlag)
   {
   
      ; copy these descriptions to the SnG B tab, incase one of them changed
;      GuiControl,, Sng1DescriptionB, %Sng1Description%
;      GuiControl,, Sng2DescriptionB, %Sng2Description%
;      GuiControl,, Sng3DescriptionB, %Sng3Description%
;      GuiControl,, Sng4DescriptionB, %Sng4Description%
;      GuiControl,, Sng5DescriptionB, %Sng5Description%
;      GuiControl,, Sng6DescriptionB, %Sng6Description%
;      GuiControl,, Sng7DescriptionB, %Sng7Description%
;      GuiControl,, Sng8DescriptionB, %Sng8Description%
;      GuiControl,, Sng9DescriptionB, %Sng9Description%
      GuiControl,, Sng11DescriptionB, %Sng11Description%
      GuiControl,, Sng12DescriptionB, %Sng12Description%
      GuiControl,, Sng13DescriptionB, %Sng13Description%
      GuiControl,, Sng14DescriptionB, %Sng14Description%
      GuiControl,, Sng15DescriptionB, %Sng15Description%
      GuiControl,, Sng16DescriptionB, %Sng16Description%
      GuiControl,, Sng17DescriptionB, %Sng17Description%

   }
   ; This section takes care of changes to the theme...   reads in the lobby and table .ini files, and creates the list of sng tables for the ps lobby
   if (instr(ControlThatChanged,"Theme") OR UpdateAllFlag)
   {
      ; since the user may have changed one of the themes, we need to read in the control variables again
      IniReadAllThemes()
;outputdebug, here 2   sng11game:%sng11game%
      ; write the new dropdown list of files
      GuiControl,,Sng11Game,%PSSngFileList%
      GuiControl,,Sng12Game,%PSSngFileList%
      GuiControl,,Sng13Game,%PSSngFileList%
      GuiControl,,Sng14Game,%PSSngFileList%
      GuiControl,,Sng15Game,%PSSngFileList%
      GuiControl,,Sng16Game,%PSSngFileList%
      GuiControl,,Sng17Game,%PSSngFileList%


      ; select the current file to use
      GuiControl, ChooseString, Sng11Game, % Sng11Game
      GuiControl, ChooseString, Sng12Game, % Sng12Game
      GuiControl, ChooseString, Sng13Game, % Sng13Game
      GuiControl, ChooseString, Sng14Game, % Sng14Game
      GuiControl, ChooseString, Sng15Game, % Sng15Game
      GuiControl, ChooseString, Sng16Game, % Sng16Game
      GuiControl, ChooseString, Sng17Game, % Sng17Game


      ; update the table themes in use on the calib tab
      GuiControl,, PSTableTheme1, %PSTableTheme%
      GuiControl,, FTTableTheme1, %FTTableTheme%

      GuiControl +Background%PSFlopColor%, PSFlopColorDisplay
      GuiControl +Background%PSTurnColor%, PSTurnColorDisplay
      GuiControl +Background%PSRiverColor%, PSRiverColorDisplay
      GuiControl +Background%PSTestColor%, PSTestColorDisplay

      GuiControl +Background%FTFlopColor%, FTFlopColorDisplay
      GuiControl +Background%FTTurnColor%, FTTurnColorDisplay
      GuiControl +Background%FTRiverColor%, FTRiverColorDisplay
      GuiControl +Background%FTTestColor%, FTTestColorDisplay

      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat1%, FTPlayerEmptySeatColorSeats9Seat1Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat2%, FTPlayerEmptySeatColorSeats9Seat2Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat3%, FTPlayerEmptySeatColorSeats9Seat3Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat4%, FTPlayerEmptySeatColorSeats9Seat4Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat5%, FTPlayerEmptySeatColorSeats9Seat5Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat6%, FTPlayerEmptySeatColorSeats9Seat6Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat7%, FTPlayerEmptySeatColorSeats9Seat7Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat8%, FTPlayerEmptySeatColorSeats9Seat8Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat9%, FTPlayerEmptySeatColorSeats9Seat9Display

      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat1%, FTPlayerEmptySeatColorSeats8Seat1Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat2%, FTPlayerEmptySeatColorSeats8Seat2Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat3%, FTPlayerEmptySeatColorSeats8Seat3Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat4%, FTPlayerEmptySeatColorSeats8Seat4Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat5%, FTPlayerEmptySeatColorSeats8Seat5Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat6%, FTPlayerEmptySeatColorSeats8Seat6Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat7%, FTPlayerEmptySeatColorSeats8Seat7Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat8%, FTPlayerEmptySeatColorSeats8Seat8Display

      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat1%, FTPlayerEmptySeatColorSeats6Seat1Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat2%, FTPlayerEmptySeatColorSeats6Seat2Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat3%, FTPlayerEmptySeatColorSeats6Seat3Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat4%, FTPlayerEmptySeatColorSeats6Seat4Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat5%, FTPlayerEmptySeatColorSeats6Seat5Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat6%, FTPlayerEmptySeatColorSeats6Seat6Display

      GuiControl +Background%FTPlayerEmptySeatColorSeats2Seat1%, FTPlayerEmptySeatColorSeats2Seat1Display
      GuiControl +Background%FTPlayerEmptySeatColorSeats2Seat2%, FTPlayerEmptySeatColorSeats2Seat2Display

   }

   if (instr(ControlThatChanged,"JoyNum") OR UpdateAllFlag)
   {
      ; if joystick is enabled, then enable a timer for it
      if JoyNum
         SetTimer, WatchJoystick, %TimerWatchJoystickInterval%, %TimerWatchJoystickPriority%
      else
         SetTimer, WatchJoystick, Off
   }



   ;NOTE: we set the process priority for FT and PS in TimerSlow (in case the user does not have PS or FT running already)

   if (instr(ControlThatChanged,"ProcessPriority") OR UpdateAllFlag)
   {

      if (ShortcutsProcessPriority <> "NoChange")
      {
         Process, Exist
         if (ErrorLevel)
         {
            Process, Priority, %ErrorLevel%, %ShortcutsProcessPriority%
         }
      }
      
   }

   ; if we add another if case here, then also add it to:  gosub  SettingsSubmitVariables
   
   ; reset this flag since we are done updating
   UpdateAllFlag := 0

   ; we are done updating gui items in software
   GuiSoftwareUpdateFlag := 0
}



; ***************************************************************************************
; ***************************************************************************************
;  SettingsUpdateHotkeys()
; ***************************************************************************************
; ***************************************************************************************


; Update variables when a GUI variable changes or to enable or disable the controls
;     if EnableControls
;           =0   disable all of the hotkey controls (probably cuz mouse is in chat area)
;           =1    enable all of the hotkey controls
;           =-1   look at the variable "ControlsEnabled" and leave the hotkeys in this state
;                    in other words, don't change the conditions of the hotkeys
SettingsUpdateHotkeys(EnableControls)
{
   global
   local FileList, FileName
   static HotkeyListString := ""                   ; this is a list of all hotkeys, seperated by |
                                                   ; this is used to turn off all hotkeys that are in string

outputdebug,    in SettingsUpdateHotkeys   A_GuiControl:%A_GuiControl%     EnableControls:%EnableControls%

   ; if we are doing a mass update of the gui, then don't bother with this function
   if GuiSoftwareUpdateFlag
      return

   ; erase the Joystick lists, as we will rebuild them in this function
   JoystickHotkeyList := ""
   JoystickGosubList := ""

   ; DISABLE ALL OF THE CURRENT HOT KEYS SINCE THE GUI HAS CHANGED

;outputdebug I= %HotkeyListString%

   ; turn off all hot keys, to be turned on after the variables are updated.
   ; this is needed to disable old hot keys as the user makes changes to the edit boxes defining the keys
   ; this prevents us from defining a large number of keys that are not needed.
   ; they are turned off for each group, just in case they were defined

   Hotkey, IfWinActive, ahk_group LastHand
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group Cashier
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group Notes
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group PokerShortcuts
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group Lobby
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group TournamentLobby
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off

   Hotkey, IfWinActive, ahk_group Tables
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off


   Hotkey, IfWinActive, ahk_group TournamentInfo
   Loop, Parse, HotkeyListString, |
      if A_LoopField
         Hotkey, %A_LoopField%, , UseErrorLevel Off




   ; Copy GUI selections to variables
   Gui, 99:Default
   GUI, Submit, NoHide

   ; NOW TURN THE HOT KEYS BACK ON TO THE CHANGED VARIABLES

   ; reset the current list of hotkeys, as we will now built the list
   HotkeyListString := ""

   ; allow these hot keys only on a "Tournament Status (info)" window
   Hotkey, IfWinActive, ahk_group TournamentInfo
      HotkeySet(TourneyInfoControl, "TableTourneyInfo", HotkeyListString)

   ; allow these hot keys only on a "Last Hand" window
   Hotkey, IfWinActive, ahk_group LastHand
      HotkeySet(LastHandControl, "TableLastHand", HotkeyListString)

   ; allow these hot keys only on a Cashier window
   Hotkey, IfWinActive, ahk_group Cashier
      HotkeySet(OpenCashierControl, "OpenCashier", HotkeyListString)

   ; allow these hot keys only on a Player's notes window
   Hotkey, IfWinActive, ahk_group Notes
      HotkeySet(NotesNanoColorUpControl, "NotesColorUp", HotkeyListString)
      HotkeySet(NotesNanoColorDownControl, "NotesColorDown", HotkeyListString)
      HotkeySet(NotesCloseControl, "NotesClose", HotkeyListString)


   ; allow these hot keys only on a Poker Shortcuts
   Hotkey, IfWinActive, ahk_group PokerShortcuts
;      HotkeySet(SngContinuouslyOpenToggleControl, "SngContinuouslyOpenToggle", HotkeyListString)
      HotkeySet(RejectSeatControl, "RejectSeat", HotkeyListString)
      HotkeySet(OpenCashierControl, "OpenCashier", HotkeyListString)
      HotkeySet(LobbyToggleAutoMuckHandsControl, "LobbyToggleAutoMuckHands", HotkeyListString)
      
   ; allow these hot keys only on a Lobby
   Hotkey, IfWinActive, ahk_group Lobby
      HotkeySet(Sng11OpenControl, "Sng11Open", HotkeyListString)
      HotkeySet(PSSngOpenHighlightedControl, "PSSngOpenHighlighted", HotkeyListString)
      HotkeySet(FTSngOpenHighlightedControl, "FTSngOpenHighlighted", HotkeyListString)
      
      
;      HotkeySet(Sng1OpenControl, "Sng1Open", HotkeyListString)
      HotkeySet(LobbyTournamentCloseControl, "LobbyTournamentClose", HotkeyListString)
;      HotkeySet(SngContinuouslyOpenToggleControl, "SngContinuouslyOpenToggle", HotkeyListString)
;      HotkeySet(ToggleAutoMuckHandsControl, "LobbyToggleAutoMuckHands", HotkeyListString)
      HotkeySet(RejectSeatControl, "RejectSeat", HotkeyListString)
      HotkeySet(OpenCashierControl, "OpenCashier", HotkeyListString)
      HotkeySet(LobbyToggleAutoMuckHandsControl, "LobbyToggleAutoMuckHands", HotkeyListString)
         
   ; allow these hot keys only on a Tournament Lobby
   Hotkey, IfWinActive, ahk_group TournamentLobby
      HotkeySet(LobbyTournamentCloseControl, "LobbyTournamentClose", HotkeyListString)
      HotkeySet(LobbyTournamentMinimizeControl, "LobbyTournamentMinimize", HotkeyListString)
      
    

      ; define all of the hotkeys IF
      ;     we were told to enable them
      ;     OR    we were told to leave them enabled if they were enabled already
      if (EnableControls OR ((EnableControls == -1) AND (ControlsEnabled == 1)))
      {
         ControlsEnabled := 1


         ;allow these hot keys only on a Stars table
         Hotkey, IfWinActive, ahk_group PSTables  
         HotkeySet(VarBetControlUp1, "BetModifyUp1", HotkeyListString)
         HotkeySet(VarBetControlDown1, "BetModifyDown1", HotkeyListString)

         ; allow these hot keys only on a table
         Hotkey, IfWinActive, ahk_group Tables


         ; Street Bet
         HotkeySet(StreetBetControl, "StreetBet", HotkeyListString)
         ; Inc/Dec Bet
         
         ; moved these two up to be Stars only
;         HotkeySet(VarBetControlUp1, "BetModifyUp1", HotkeyListString)
;         HotkeySet(VarBetControlDown1, "BetModifyDown1", HotkeyListString)
         HotkeySet(VarBetControlUp2, "BetModifyUp2", HotkeyListString)
         HotkeySet(VarBetControlDown2, "BetModifyDown2", HotkeyListString)
         HotkeySet(VarBetControlUp3, "BetModifyUp3", HotkeyListString)
         HotkeySet(VarBetControlDown3, "BetModifyDown3", HotkeyListString)
         HotkeySet(VarBetControlUp4, "BetModifyUp4", HotkeyListString)
         HotkeySet(VarBetControlDown4, "BetModifyDown4", HotkeyListString)
         ; Fixed Bet
         HotkeySet(BetFixedControl1, "BetFixed1", HotkeyListString)
         HotkeySet(BetFixedControl2, "BetFixed2", HotkeyListString)
         HotkeySet(BetFixedControl3, "BetFixed3", HotkeyListString)
         HotkeySet(BetFixedControl4, "BetFixed4", HotkeyListString)
         HotkeySet(BetFixedControl5, "BetFixed5", HotkeyListString)
         HotkeySet(BetMaxControl, "BetMax", HotkeyListString)
         HotkeySet(BetPotControl, "BetPot", HotkeyListString)
         ; Deal Me
         HotkeySet(CycleDealMeModesOnActiveTableControl, "CycleDealMeModesOnActiveTable", HotkeyListString)
         HotkeySet(CycleDealMeModesOnAllTablesControl, "CycleDealMeModesOnAllTables", HotkeyListString)
         ; SnG A

         ; SnG T

;         HotkeySet(Sng1OpenControl, "Sng1Open", HotkeyListString)
         HotkeySet(Sng11OpenControl, "Sng11Open", HotkeyListString)         
         HotkeySet(PSSngOpenHighlightedControl, "PSSngOpenHighlighted", HotkeyListString)
         HotkeySet(FTSngOpenHighlightedControl, "FTSngOpenHighlighted", HotkeyListString)
         
;         HotkeySet(SngContinuouslyOpenToggleControl, "SngContinuouslyOpenToggle", HotkeyListString)
         ; Actions1  --  if the betting controls are enabled, then create a hot key for them
;         if BettingControlsEnabled
;         {
            HotkeySet(FoldCheckControl, "ClickFoldCheck", HotkeyListString)
            HotkeySet(CallControl, "ClickCall", HotkeyListString)
            HotkeySet(BetRaiseControl, "ClickBetRaise", HotkeyListString)
            HotkeySet(LeftCheckboxControl, "ClickLeftCheckbox", HotkeyListString)
            HotkeySet(MiddleCheckboxControl, "ClickMiddleCheckbox", HotkeyListString)

            HotkeySet(CallAnyControl, "ClickCallAnyCheckbox", HotkeyListString)
            HotkeySet(RaiseMinControl, "ClickRaiseMinCheckbox", HotkeyListString)
            HotkeySet(RaiseAnyControl, "ClickRaiseAnyCheckbox", HotkeyListString)
            HotkeySet(BetWindowClearControl, "BetWindowClear", HotkeyListString)
            HotkeySet(FoldToAnyBetControl, "ClickFoldToAnyBetCheckbox", HotkeyListString)


;         }
         ; Actions2
         HotkeySet(PlayersNameControl, "PlayersName", HotkeyListString)
;         HotkeySet(PlayersNameToSharkListControl, "PlayersNameToSharkList", HotkeyListString)
;         HotkeySet(PlayersNameFromSharkListControl, "PlayersNameFromSharkList", HotkeyListString)
         HotkeySet(TableTournamentIdControl, "TableTournamentId", HotkeyListString)
         HotkeySet(ReloadChipsControl, "ReloadChips", HotkeyListString)
         HotkeySet(LobbyToggleAutoMuckHandsControl, "LobbyToggleAutoMuckHands", HotkeyListString)
;         HotkeySet(ReloadAllControl, "ReloadAll", HotkeyListString)
         HotkeySet(TimerControl, "ClickTimer", HotkeyListString)
         HotkeySet(TimerAllControl, "ClickTimerAll", HotkeyListString)
         HotkeySet(LastHandControl, "TableLastHand", HotkeyListString)
         HotkeySet(TourneyInfoControl, "TableTourneyInfo", HotkeyListString)
   ;      HotkeySet(ToggleAutoMuckHandsControl, "LobbyToggleAutoMuckHands", HotkeyListString)
         HotkeySet(NotesControl, "Notes", HotkeyListString)
         HotkeySet(NotesPlayerNControl, "NotesPlayerN", HotkeyListString)
         HotkeySet(NotesOpenPlayerNControl, "NotesOpenPlayerN", HotkeyListString)
         HotkeySet(NotesNanoControl, "NotesNano", HotkeyListString)
         HotkeySet(NotesNanoPlayerNControl, "NotesNanoPlayerN", HotkeyListString)
         HotkeySet(NotesColorNControl, "NotesColorN", HotkeyListString)
         
         
         ; Actions3
         HotkeySet(ToggleSitOutControl, "ToggleSitOut", HotkeyListString)
         HotkeySet(SitInOnAllControl, "ClickSitInAll", HotkeyListString)
         HotkeySet(SitOutOnAllControl, "ClickSitOutAll", HotkeyListString)
         HotkeySet(ToggleAPBControl, "ToggleAPB", HotkeyListString)
         HotkeySet(TableCloseActiveControl, "TableCloseActive", HotkeyListString)
         HotkeySet(TableCloseActiveWithoutHeroControl, "TableCloseActiveWithoutHero", HotkeyListString)
         HotkeySet(TableCloseAllControl, "TableCloseAll", HotkeyListString)
         HotkeySet(TableCloseAllWithoutHeroControl, "TableCloseAllWithoutHero", HotkeyListString)
         HotkeySet(TableMinimizeAllControl, "TableMinimizeAll", HotkeyListString)
         HotkeySet(TableMinimizeAllWithoutHeroControl, "TableMinimizeAllWithoutHero", HotkeyListString)
         HotkeySet(OpenCashierControl, "OpenCashier", HotkeyListString)
         HotkeySet(LobbyTournamentCloseControl, "LobbyTournamentClose", HotkeyListString)
         HotkeySet(LobbyTournamentMinimizeControl, "LobbyTournamentMinimize", HotkeyListString)
         
         HotkeySet(TableNextControl, "TableNext", HotkeyListString)
         HotkeySet(TablePreviousControl, "TablePrevious", HotkeyListString)
         HotkeySet(TableLeftControl, "TableLeft", TableLeft)
         HotkeySet(TableRightControl, "TableRight", HotkeyListString)
         HotkeySet(TableUpControl, "TableUp", HotkeyListString)
         HotkeySet(TableDownControl, "TableDown", HotkeyListString)
         
         HotkeySet(TableBottomOfStackControl, "TableBottomOfStack", HotkeyListString)
         HotkeySet(TableNextInStackControl, "TableNextInStack", HotkeyListString)
         
         HotkeySet(TablePendingControl, "TablePending", HotkeyListString)
         HotkeySet(TableLayout1Control, "TableLayout1", HotkeyListString)
         HotkeySet(TableLayout2Control, "TableLayout2", HotkeyListString)
         HotkeySet(TablesCascadeControl, "TablesCascade", HotkeyListString)
         HotkeySet(TablesTileControl, "TablesTile", HotkeyListString)

         ; Displays
         HotkeySet(RefreshOSD1Control, "RefreshOSD1", HotkeyListString)         


         ; Table1
         HotkeySet(ManualMoveTableControl, "ManualMoveTable", HotkeyListString)
         HotkeySet(ManualMoveTable2Control, "ManualMoveTable2", HotkeyListString)
         ;Table2

         ; Dialogs
         HotkeySet(RejectSeatControl, "RejectSeat", HotkeyListString)


         ; Misc
         ;HotkeySet(ColorSampleStreetsControl, "ColorSampleStreets", HotkeyListString)
         ; Gary
;         if (CodeType == 8088)
;         {
;            HotkeySet(NotesNanoAllControl, "NotesNanoAll", HotkeyListString)
;            HotkeySet(NotesNanoSetSharkScopeColorAllControl, "NotesNanoSetSharkScopeColorAll", HotkeyListString)
;         }
      }
      ; else we should not enable all of the hotkey controls
      else
      {
         ControlsEnabled := 0
      }




   ; the move mouse from chat box is always active, so that we can get out the
   ;     chat box with a keystroke
   HotkeySet(TableMoveToFromChatControl, "TableMoveToFromChat", HotkeyListString)


   ; return focus to this checkbox, to prevent accidentally changing other GUI controls when
   ;  the user is working with other windows and FTTO pops back up when the timer runs.
   ;  Then scrolling actions won't change any of our controls, because focus will
   ;  be on this "dummy" control, and it won't matter
   ;  BUT, if we were in an edit box, then just stay there
   ControlGetFocus, Temp
   if (NOT InStr(Temp,"Edit"))
      GuiControl, Focus, KeepFocusHere


   ; if one of our settings has changed, then save them to disk in one minute (so we don't keep doing it too often)
   if (EnableControls == -1)
      SetTimer, SettingsWrite, %SaveSettingsInterval%, %SaveSettingsPriority%



}





; ---------------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------------
;  End of SettingsUpdateHotkeys()
; ---------------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------------


; keep a list of all hotkeys in pList and create a new Hotkey for this item (may be multiple hotkeys seperated by |)
HotkeySet(pControl,pLabel,ByRef pList)
{
   global

   ; pControl is a list of keystrokes seperated by | for this Hotkey
   ; parse out each one, remove the extra spaces
   ; create a hotkey for each one with the gosub being pLabel for each
   ; add each hotkey to the list pList (which we can use the easily delete all the hotkeys later)
   ; if the hotkey contains the word "Joystick" then this is a special one for our joystick features... add the hotkey and
   ;     the gosub to special lists for just these special hotkeys
	Loop, Parse, pControl, |
	{
	   temp := A_LoopField
	   ; remove all spaces from the code
	   StringReplace, temp, temp, %A_Space%,,All
	   StringReplace, temp, temp, &,%A_Space%&%A_Space%,All

	   ; check if this is a special joystick hotkey
	   if (instr(temp,"JOYXY") OR instr(temp,"JOYZR") OR instr(temp,"JOYUV") OR instr(temp,"JOYPOV") OR )
	   {
         StringUpper, temp, temp
         ListAddItem(JoystickHotkeyList,temp)
         ListAddItem(JoystickGosubList,pLabel)
      }
      ; else this is a normal hotkey
      else
      {
    		Hotkey, %temp%, %pLabel%, UseErrorLevel On
         ListAddItem(pList,temp,"|")         ; add this new key to the list of hotkeys
      }
	}
}










SettingsGui()
{

   global
   local Pos, DropList

   ; The main GUI will have a Gui number of 99
   Gui, 99:Default


   ; use this icon if it exists, if so, put the icon in the system tray
   IfExist, PokerShortcuts.ico
      Menu, Tray, Icon, PokerShortcuts.ico



   ; System Tray items
   if A_IsCompiled
      Menu, Tray, NoStandard                          ; don't put standard tray options in the compiled version

   Menu, Tray, add
   Menu, Tray, add, Toggle Disable All (Ctrl Esc), ToggleSuspend
   Menu, Tray, add, Minimize To Tray, MinimizeToTray
   Menu, Tray, add, Restore
   Menu, Tray, add
   Menu, Tray, add, Close, Close

   Menu, Tray, Default, Restore                       ; make this the option when the user double clicks the tray icon
   Menu, Tray, Click, 2                               ; require a double click to do a restore

   ;Menu, Tray, MainWindow



   ; Define the Menu Bar
   ; Create the sub-menus for the menu bar:
   Menu, FileMenu, Add, E&xit, ExitSub
   ;Menu, FileMenu, Add                ; Separator line.

;   Menu, HelpMenu, Add, &Check for New Version, CheckForNewVersionFromWeb
;   Menu, HelpMenu, Add, &Documentation, Documentation
   Menu, HelpMenu, Add, &About, About



   ; Create the menu bar by attaching the sub-menus to it:
   Menu, MyMenuBar, Add, &File, :FileMenu
   Menu, MyMenuBar, Add, &Help, :HelpMenu


   ; Attach the menu bar to the window:
   Gui, Menu, MyMenuBar



   Gui, Add, CheckBox, x1000 y7 w120 h20 vKeepFocusHere, Focus Kept here

   Gui, Add, Text, x20 y395 w540 h40 cBlack, When pressing any keys, the mouse MUST be over a poker table AND outside of the chat box.`n Hold the "Shift" key down to temporarily disable many features.
   Gui, Font, bold
   Gui, Add, Text, x500 y395 w250 h40 cGreen Center vAllHotkeysEnabledStatus, %Msg14%                       ; All Hotkeys are DISABLED !!`n(See Misc tab)
   Gui, Font, normal


      Gui, Add, Tab2, x0 y0 w760 h390 , Street Bet Ring|Street Bet Trny|Inc/Dec Bet|Fixed Bet|Deal Me|SnG A|SnG B|SnG / T|Actions1|Actions2|Actions3|Displays|Table1|Table2|Dialogs|Misc|Calib|Setup


   Gui, Tab, Street Bet Ring
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w750 h40 Center, Street Betting - Ring Games`n(Define your normal bet amounts for each street and the software will enter it in the betting box)

   Gui, Font, bold,
   Gui, Add, Text, x16 y123 w40 h20 center, 3 +
   Gui, Add, Text, x16 y183 w40 h20 center, 2
   Gui, Add, Text, x16 y90 w60 h30 cBlack, # Plyrs`nat Table
   Gui, Add, Text, x66 y100 w60 h20 cBlack center, PreFlop*
   Gui, Add, Text, x146 y100 w60 h20 cBlack center, PreFlop**
   Gui, Add, Text, x226 y100 w60 h20 cBlack center, Flop**
   Gui, Add, Text, x306 y100 w60 h20 cBlack center, Turn**
   Gui, Add, Text, x386 y100 w60 h20 cBlack center, River**
   Gui, Add, Text, x456 y100 w110 h20 cBlack, Amount IF:
   Gui, Font, norm,
   Gui, Add, Text, x456 y123 w110 h20 cBlack, 1st to Raise/Bet
   Gui, Add, Text, x456 y143 w110 h20 cBlack, NOT 1st to Raise/Bet
   Gui, Add, Text, x456 y183 w110 h20 cBlack, 1st to Raise/Bet
   Gui, Add, Text, x456 y203 w110 h20 cBlack, NOT 1st to Raise/Bet

   Gui, Add, Edit, x76 y120 w40 h20 right vStreetBetPreFlopAmountAct1Click1R gSettingsSubmitVariables, %StreetBetPreFlopAmountAct1Click1R%
   Gui, Add, Edit, x236 y120 w40 h20 right vStreetBetFlopAmountAct1Click1R gSettingsSubmitVariables, %StreetBetFlopAmountAct1Click1R%
   Gui, Add, Edit, x316 y120 w40 h20 right vStreetBetTurnAmountAct1Click1R gSettingsSubmitVariables, %StreetBetTurnAmountAct1Click1R%
   Gui, Add, Edit, x396 y120 w40 h20 right vStreetBetRiverAmountAct1Click1R gSettingsSubmitVariables, %StreetBetRiverAmountAct1Click1R%
   Gui, Add, Edit, x156 y140 w40 h20 right vStreetBetPreFlopAmountAct0Click1R gSettingsSubmitVariables, %StreetBetPreFlopAmountAct0Click1R%
   Gui, Add, Edit, x236 y140 w40 h20 right vStreetBetFlopAmountAct0Click1R gSettingsSubmitVariables, %StreetBetFlopAmountAct0Click1R%
   Gui, Add, Edit, x316 y140 w40 h20 right vStreetBetTurnAmountAct0Click1R gSettingsSubmitVariables, %StreetBetTurnAmountAct0Click1R%
   Gui, Add, Edit, x396 y140 w40 h20 right vStreetBetRiverAmountAct0Click1R gSettingsSubmitVariables, %StreetBetRiverAmountAct0Click1R%
   Gui, Add, Edit, x76 y180 w40 h20 right vStreetBetPreFlopAmountAct1Click2R gSettingsSubmitVariables, %StreetBetPreFlopAmountAct1Click2R%
   Gui, Add, Edit, x236 y180 w40 h20 right vStreetBetFlopAmountAct1Click2R gSettingsSubmitVariables, %StreetBetFlopAmountAct1Click2R%
   Gui, Add, Edit, x316 y180 w40 h20 right vStreetBetTurnAmountAct1Click2R gSettingsSubmitVariables, %StreetBetTurnAmountAct1Click2R%
   Gui, Add, Edit, x396 y180 w40 h20 right vStreetBetRiverAmountAct1Click2R gSettingsSubmitVariables, %StreetBetRiverAmountAct1Click2R%
   Gui, Add, Edit, x156 y200 w40 h20 right vStreetBetPreFlopAmountAct0Click2R gSettingsSubmitVariables, %StreetBetPreFlopAmountAct0Click2R%
   Gui, Add, Edit, x236 y200 w40 h20 right vStreetBetFlopAmountAct0Click2R gSettingsSubmitVariables, %StreetBetFlopAmountAct0Click2R%
   Gui, Add, Edit, x316 y200 w40 h20 right vStreetBetTurnAmountAct0Click2R gSettingsSubmitVariables, %StreetBetTurnAmountAct0Click2R%
   Gui, Add, Edit, x396 y200 w40 h20 right vStreetBetRiverAmountAct0Click2R gSettingsSubmitVariables, %StreetBetRiverAmountAct0Click2R%
   Gui, Add, Text, x16 y230 w550 h20 cBlack, * Enter number of Big Blinds to raise to (1 BB per limper will be added)          ** Enter the `% of Pot to Bet/Raise
   Gui, Add, CheckBox, x16 y260 w520 h20 Checked%AutoSetBetRingEnabled% vAutoSetBetRingEnabled gSettingsSubmitVariables cBlue, Automatically put the street bet amount in the betting box (Recommended)

   Gui, Add, Text, x106 y283 w480 h20 cBlack, Keyboard or Mouse Code to manually put the street bet amount in the betting box
   Gui, Add, Edit, x16 y280 w80 h20 vStreetBetControl gSettingsUpdateHotkeys, %StreetBetControl%

   Gui, Add, CheckBox, x56 y300 w520 h20 Checked%ClickBetAfterSettingStreetBetRingEnabled% vClickBetAfterSettingStreetBetRingEnabled gSettingsSubmitVariables cBlack, Auto-Click the Bet/Raise button AFTER manually putting the street bet amount in the betting box
   Gui, Add, Edit, x176 y320 w40 h20 center vRoundStreetBetRingToSmallBlindMultiple gSettingsSubmitVariables, %RoundStreetBetRingToSmallBlindMultiple%
   Gui, Add, Text, x16 y323 w160 h20 cBlack, Round all bets to be a multiple of
   Gui, Add, Text, x226 y323 w230 h20 cBlack, times the Small Blind (0 to disable rounding)
   Gui, Add, Text, x16 y363 w700 h20 cRed, NOTE: In order for these Street Bet features to work, be sure that you have calibrated the software to your table felt colors (on the Calib tab).



   Gui, Tab, Street Bet Trny
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w750 h40 Center, Street Betting - Tournaments`n(Define your normal bet amounts for each street and the software will enter it in the betting box)

   Gui, Add, Text, x16 y123 w40 h20 center, 3 +
   Gui, Add, Text, x16 y183 w40 h20 center, 2
   Gui, Add, Text, x16 y90 w60 h30 cBlack, # Plyrs`nat Table
   Gui, Add, Text, x66 y100 w60 h20 cBlack center, PreFlop*
   Gui, Add, Text, x146 y100 w60 h20 cBlack center, PreFlop**
   Gui, Add, Text, x226 y100 w60 h20 cBlack center, Flop**
   Gui, Add, Text, x306 y100 w60 h20 cBlack center, Turn**
   Gui, Add, Text, x386 y100 w60 h20 cBlack center, River**
   Gui, Add, Text, x456 y100 w110 h20 cBlack, Amount IF:
   Gui, Font, norm,
   Gui, Add, Text, x456 y123 w110 h20 cBlack, 1st to Raise/Bet
   Gui, Add, Text, x456 y143 w110 h20 cBlack, NOT 1st to Raise/Bet
   Gui, Add, Text, x456 y183 w110 h20 cBlack, 1st to Raise/Bet
   Gui, Add, Text, x456 y203 w110 h20 cBlack, NOT 1st to Raise/Bet

   Gui, Add, Edit, x76 y120 w40 h20 right vStreetBetPreFlopAmountAct1Click1T gSettingsSubmitVariables, %StreetBetPreFlopAmountAct1Click1T%
   Gui, Add, Edit, x236 y120 w40 h20 right vStreetBetFlopAmountAct1Click1T gSettingsSubmitVariables, %StreetBetFlopAmountAct1Click1T%
   Gui, Add, Edit, x316 y120 w40 h20 right vStreetBetTurnAmountAct1Click1T gSettingsSubmitVariables, %StreetBetTurnAmountAct1Click1T%
   Gui, Add, Edit, x396 y120 w40 h20 right vStreetBetRiverAmountAct1Click1T gSettingsSubmitVariables, %StreetBetRiverAmountAct1Click1T%
   Gui, Add, Edit, x156 y140 w40 h20 right vStreetBetPreFlopAmountAct0Click1T gSettingsSubmitVariables, %StreetBetPreFlopAmountAct0Click1T%
   Gui, Add, Edit, x236 y140 w40 h20 right vStreetBetFlopAmountAct0Click1T gSettingsSubmitVariables, %StreetBetFlopAmountAct0Click1T%
   Gui, Add, Edit, x316 y140 w40 h20 right vStreetBetTurnAmountAct0Click1T gSettingsSubmitVariables, %StreetBetTurnAmountAct0Click1T%
   Gui, Add, Edit, x396 y140 w40 h20 right vStreetBetRiverAmountAct0Click1T gSettingsSubmitVariables, %StreetBetRiverAmountAct0Click1T%
   Gui, Add, Edit, x76 y180 w40 h20 right vStreetBetPreFlopAmountAct1Click2T gSettingsSubmitVariables, %StreetBetPreFlopAmountAct1Click2T%
   Gui, Add, Edit, x236 y180 w40 h20 right vStreetBetFlopAmountAct1Click2T gSettingsSubmitVariables, %StreetBetFlopAmountAct1Click2T%
   Gui, Add, Edit, x316 y180 w40 h20 right vStreetBetTurnAmountAct1Click2T gSettingsSubmitVariables, %StreetBetTurnAmountAct1Click2T%
   Gui, Add, Edit, x396 y180 w40 h20 right vStreetBetRiverAmountAct1Click2T gSettingsSubmitVariables, %StreetBetRiverAmountAct1Click2T%
   Gui, Add, Edit, x156 y200 w40 h20 right vStreetBetPreFlopAmountAct0Click2T gSettingsSubmitVariables, %StreetBetPreFlopAmountAct0Click2T%
   Gui, Add, Edit, x236 y200 w40 h20 right vStreetBetFlopAmountAct0Click2T gSettingsSubmitVariables, %StreetBetFlopAmountAct0Click2T%
   Gui, Add, Edit, x316 y200 w40 h20 right vStreetBetTurnAmountAct0Click2T gSettingsSubmitVariables, %StreetBetTurnAmountAct0Click2T%
   Gui, Add, Edit, x396 y200 w40 h20 right vStreetBetRiverAmountAct0Click2T gSettingsSubmitVariables, %StreetBetRiverAmountAct0Click2T%
   Gui, Add, Text, x16 y230 w550 h20 cBlack, * Enter number of Big Blinds to raise to (1 BB per limper will be added)          ** Enter the `% of Pot to Bet/Raise
   Gui, Add, CheckBox, x16 y260 w520 h20 Checked%AutoSetBetTrnyEnabled% vAutoSetBetTrnyEnabled gSettingsSubmitVariables cBlue, Automatically put the street bet amount in the betting box (Recommended)
   Gui, Add, Text, x16 y283 w650 h20 cBlack, Note: To manually put the street bet amount in the betting box, use the same key/mouse code as defined on the Street Bet Ring tab
   Gui, Add, CheckBox, x56 y300 w520 h20 Checked%ClickBetAfterSettingStreetBetTrnyEnabled% vClickBetAfterSettingStreetBetTrnyEnabled gSettingsSubmitVariables cBlack, Auto-Click the Bet/Raise button AFTER manually putting the street bet amount in the betting box
   Gui, Add, Edit, x176 y320 w40 h20 center vRoundStreetBetTrnyToSmallBlindMultiple gSettingsSubmitVariables, %RoundStreetBetTrnyToSmallBlindMultiple%
   Gui, Add, Text, x16 y323 w160 h20 cBlack, Round all bets to be a multiple of
   Gui, Add, Text, x226 y323 w230 h20 cBlack, times the Small Blind (0 to disable rounding)
   Gui, Add, Text, x16 y363 w700 h20 cRed, NOTE: In order for these Street Bet features to work, be sure that you have calibrated the software to your table felt colors (on the Calib tab).


   Gui, Tab, Inc/Dec Bet
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w550 h40 center, Increase / Decrease Bet Amount - Ring Games and Tournaments`n(Define keys and mouse buttons to quickly inc/dec your bet size by a incremental amount)
   Gui, Add, Text, x26 y90 w140 h30 cBlack, Increase Bet`nEnter Key/Mouse Code
   Gui, Add, Text, x196 y90 w140 h30 cBlack, Decrease Bet`nEnter Key/Mouse Code
   Gui, Add, Text, x366 y90 w70 h30 cBlack, Inc/Dec Amount
   Gui, Add, Text, x476 y90 w50 h20 cBlack, Units
   Gui, Font, norm,
   Gui, Add, Edit, x26 y120 w140 h20 vVarBetControlUp1 gSettingsUpdateHotkeys, %VarBetControlUp1%
   Gui, Add, Edit, x195 y120 w140 h20 vVarBetControlDown1 gSettingsUpdateHotkeys, %VarBetControlDown1%
   Gui, Add, Edit, x366 y120 w70 h20 right vVarBetAmount1 gSettingsSubmitVariables, %VarBetAmount1%
   DropList := "SB|BB|$|`%Pot"
   Pos := ListGetPos(DropList,VarBetUnits1,"|")
   Gui, Add, DropDownList, x466 y120 w80 h21 vVarBetUnits1 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   Gui, Add, Text, x556 y125 w200 h20, NOTE: Top row works on PS only
   
   Gui, Add, Edit, x26 y140 w140 h20 vVarBetControlUp2 gSettingsUpdateHotkeys, %VarBetControlUp2%
   Gui, Add, Edit, x195 y140 w140 h20 vVarBetControlDown2 gSettingsUpdateHotkeys, %VarBetControlDown2%
   Gui, Add, Edit, x366 y140 w70 h20 right vVarBetAmount2 gSettingsSubmitVariables, %VarBetAmount2%
   Pos := ListGetPos(DropList,VarBetUnits2,"|")
   Gui, Add, DropDownList, x466 y140 w80 h21 vVarBetUnits2 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   Gui, Add, Edit, x26 y160 w140 h20 vVarBetControlUp3 gSettingsUpdateHotkeys, %VarBetControlUp3%
   Gui, Add, Edit, x195 y160 w140 h20 vVarBetControlDown3 gSettingsUpdateHotkeys, %VarBetControlDown3%
   Gui, Add, Edit, x366 y160 w70 h20 right vVarBetAmount3 gSettingsSubmitVariables, %VarBetAmount3%
   Pos := ListGetPos(DropList,VarBetUnits3,"|")
   Gui, Add, DropDownList, x466 y160 w80 h21 vVarBetUnits3 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   Gui, Add, Edit, x26 y180 w140 h20 vVarBetControlUp4 gSettingsUpdateHotkeys, %VarBetControlUp4%
   Gui, Add, Edit, x195 y180 w140 h20 vVarBetControlDown4 gSettingsUpdateHotkeys, %VarBetControlDown4%
   Gui, Add, Edit, x366 y180 w70 h20 right vVarBetAmount4 gSettingsSubmitVariables, %VarBetAmount4%
   Pos := ListGetPos(DropList,VarBetUnits4,"|")
   Gui, Add, DropDownList, x466 y180 w80 h21 vVarBetUnits4 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   ;Gui, Add, CheckBox, x126 y300 w320 h20 Checked%RoundVarBetToSmallBlindMultiple% vRoundVarBetToSmallBlindMultiple gSettingsSubmitVariables cBlue, Round all bet sizes to be a multiple of the Small Blind
   Gui, Add, Edit, x185 y210 w40 h20 center vRoundVarBetToSmallBlindMultiple gSettingsSubmitVariables, %RoundVarBetToSmallBlindMultiple%
   Gui, Add, Text, x25 y213 w160 h20, Round all bets to be a multiple of
   Gui, Add, Text, x235 y213 w230 h20, times the Small Blind (0 to disable rounding)
;   Gui, Add, CheckBox, x25 y250 w680 h20 Checked%MouseWheelOnFullTiltDisabled% vMouseWheelOnFullTiltDisabled gSettingsSubmitVariables cBlue, Disable Mouse Wheel on FT tables (we recommend that you check this and use mouse wheel features in the FT software instead)   

   
   Gui, Add, Text, x25 y303 w650 h20 cBlack, NOTE: Using this feature, you can easily change your bet size by a small or large amount.
   Gui, Add, Text, x25 y333 w730 h30 cRed, NOTE: Do not put "WheelUp" or "WheelDown" in the bottom three rows above. `nOn Full Tilt, use the Mouse Wheel feature in FT Lobby...Options...Bet Slider Options
   
   
   Gui, Tab, Fixed Bet
   ; BetFixAmountXY   where X is which fixed bet it is 1-5, and Y is the number of times the key was clicked 1-3
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w650 h40 center, Fixed Bets - Ring Games and Tournaments`n(Define keys and mouse buttons to put predefined bet amounts in the betting box)
   Gui, Add, Text, x86 y100 w100 h30 center, Enter Key or`nMouse Code
   Gui, Add, Text, x226 y100 w60 h30 center, 1 Click Amount
   Gui, Add, Text, x296 y100 w60 h30 center, 2 Click Amount
   Gui, Add, Text, x366 y100 w60 h30 center, 3 Click Amount
   Gui, Add, Text, x446 y110 w50 h20 center, Units
   Gui, Font, norm,
   Gui, Add, Edit, x66 y130 w140 h20 vBetFixedControl1 gSettingsUpdateHotkeys, %BetFixedControl1%
   Gui, Add, Edit, x236 y130 w40 h20 right vBetFixedAmount11 gSettingsSubmitVariables, %BetFixedAmount11%
   Gui, Add, Edit, x306 y130 w40 h20 right vBetFixedAmount12 gSettingsSubmitVariables, %BetFixedAmount12%
   Gui, Add, Edit, x376 y130 w40 h20 right vBetFixedAmount13 gSettingsSubmitVariables, %BetFixedAmount13%
   DropList := "SB|BB|$|`%Pot"
   Pos := ListGetPos(DropList,BetFixedUnits1,"|")
   Gui, Add, DropDownList, x446 y130 w80 h21 vBetFixedUnits1 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   
   Gui, Add, Edit, x66 y150 w140 h20 vBetFixedControl2 gSettingsUpdateHotkeys, %BetFixedControl2%
   Gui, Add, Edit, x236 y150 w40 h20 right vBetFixedAmount21 gSettingsSubmitVariables, %BetFixedAmount21%
   Gui, Add, Edit, x306 y150 w40 h20 right vBetFixedAmount22 gSettingsSubmitVariables, %BetFixedAmount22%
   Gui, Add, Edit, x376 y150 w40 h20 right vBetFixedAmount23 gSettingsSubmitVariables, %BetFixedAmount23%
   Pos := ListGetPos(DropList,BetFixedUnits2,"|")
   Gui, Add, DropDownList, x446 y150 w80 h21 vBetFixedUnits2 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   
   Gui, Add, Edit, x66 y170 w140 h20 vBetFixedControl3 gSettingsUpdateHotkeys, %BetFixedControl3%
   Gui, Add, Edit, x236 y170 w40 h20 right vBetFixedAmount31 gSettingsSubmitVariables, %BetFixedAmount31%
   Gui, Add, Edit, x306 y170 w40 h20 right vBetFixedAmount32 gSettingsSubmitVariables, %BetFixedAmount32%
   Gui, Add, Edit, x376 y170 w40 h20 right vBetFixedAmount33 gSettingsSubmitVariables, %BetFixedAmount33%
   Pos := ListGetPos(DropList,BetFixedUnits3,"|")
   Gui, Add, DropDownList, x446 y170 w80 h21 vBetFixedUnits3 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   
   Gui, Add, Edit, x66 y190 w140 h20 vBetFixedControl4 gSettingsUpdateHotkeys, %BetFixedControl4%
   Gui, Add, Edit, x236 y190 w40 h20 right vBetFixedAmount41 gSettingsSubmitVariables, %BetFixedAmount41%
   Gui, Add, Edit, x306 y190 w40 h20 right vBetFixedAmount42 gSettingsSubmitVariables, %BetFixedAmount42%
   Gui, Add, Edit, x376 y190 w40 h20 right vBetFixedAmount43 gSettingsSubmitVariables, %BetFixedAmount43%
   Pos := ListGetPos(DropList,BetFixedUnits4,"|")
   Gui, Add, DropDownList, x446 y190 w80 h21 vBetFixedUnits4 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   
   Gui, Add, Edit, x66 y210 w140 h20 vBetFixedControl5 gSettingsUpdateHotkeys, %BetFixedControl5%
   Gui, Add, Edit, x236 y210 w40 h20 right vBetFixedAmount51 gSettingsSubmitVariables, %BetFixedAmount51%
   Gui, Add, Edit, x306 y210 w40 h20 right vBetFixedAmount52 gSettingsSubmitVariables, %BetFixedAmount52%
   Gui, Add, Edit, x376 y210 w40 h20 right vBetFixedAmount53 gSettingsSubmitVariables, %BetFixedAmount53%
   Pos := ListGetPos(DropList,BetFixedUnits5,"|")
   Gui, Add, DropDownList, x446 y210 w80 h21 vBetFixedUnits5 gSettingsSubmitVariables R4 Choose%Pos%, %DropList%
   
   Gui, Add, Edit, x66 y240 w140 h20 vBetPotControl gSettingsUpdateHotkeys, %BetPotControl%
   Gui, Add, Text, x216 y245 w300 h20 cBlack, Bet Pot
   Gui, Add, Edit, x66 y260 w140 h20 vBetMaxControl gSettingsUpdateHotkeys, %BetMaxControl%
   Gui, Add, Text, x216 y265 w300 h20 cBlack, All In (or max allowed bet)
   Gui, Add, CheckBox, x176 y290 w420 h20 Checked%ClickBetAfterSettingBetFixedEnabled% vClickBetAfterSettingBetFixedEnabled gSettingsSubmitVariables cBlack, Auto-Click the Bet/Raise button AFTER putting the fixed bet in the betting box
   Gui, Add, CheckBox, x176 y310 w350 h20 Checked%FixedBetMultiClickDisabled% vFixedBetMultiClickDisabled gSettingsSubmitVariables cBlack, Disable 2 Click and 3 Click above (improves speed of 1 Click)
   ;Gui, Add, CheckBox, x176 y300 w320 h20 Checked%RoundFixedBetToSmallBlindMultiple% vRoundFixedBetToSmallBlindMultiple gSettingsSubmitVariables cBlack, Round all bet sizes to be a multiple of the Small Blind
   Gui, Add, Edit, x285 y330 w40 h20 center vRoundFixedBetToSmallBlindMultiple gSettingsSubmitVariables, %RoundFixedBetToSmallBlindMultiple%
   Gui, Add, Text, x125 y333 w160 h20, Round all bets to be a multiple of
   Gui, Add, Text, x335 y333 w230 h20, times the Small Blind (0 to disable rounding)


   Gui, Tab, Deal Me
   Gui, Font, bold,
   Gui, Add, Text, x6 y60 w550 h40 cBlack center, Deal Me In and Out - Ring Games Only `n(This feature handles the task of waiting for big blind for both sitting In and Out)
;   Gui, Add, Text, x376 y100 w120 h30 cBlack, Enter Key or`nMouse Code
   Gui, Font, norm,
   Gui, Add, CheckBox, x50 y100 w600 h20 Checked%SetDealMeModeOnInitialBuyInEnabled% vSetDealMeModeOnInitialBuyInEnabled gSettingsSubmitVariables cBlue, Set Deal Me Mode to "In" with initial chip buy-in (else mode will be set to "Off") (Recommended)
   Gui, Add, CheckBox, x50 y120 w600 h20 Checked%AutoPostBlindsAfterSittingDownEnabled% vAutoPostBlindsAfterSittingDownEnabled gSettingsSubmitVariables cBlue, Automatically Check "Auto-Post Blinds" Checkbox after Sitting Down at Table (Full Tilt only) (Recommended)
   Gui, Add, CheckBox, x50 y140 w600 h20 Checked%DisableDealMeModeWhenHU% vDisableDealMeModeWhenHU gSettingsSubmitVariables cBlack, Disable the above two features on all Heads Up Tables
   Gui, Add, CheckBox, x50 y160 w600 h20 Checked%DealMeModeStatusTooltipEnabled% vDealMeModeStatusTooltipEnabled gSettingsSubmitVariables cBlue, Enable Deal Me status tooltip for 10 seconds when status changes (Recommended)

   
   Gui, Add, Edit, x50 y190 w120 h20 vCycleDealMeModesOnActiveTableControl gSettingsUpdateHotkeys, %CycleDealMeModesOnActiveTableControl%
   Gui, Add, Text, x180 y195 w550 h20 cBlack, Active Table Mode Toggle: Key to cycle through the 3 modes (In,Out,Off) on ACTIVE table  (if seated)
   Gui, Add, Edit, x50 y210 w120 h20 vCycleDealMeModesOnAllTablesControl gSettingsUpdateHotkeys, %CycleDealMeModesOnAllTablesControl%
   Gui, Add, Text, x180 y215 w550 h20 cBlack, All Tables Mode Toggle: Key to cycle through the 3 modes (In,Out,Off) on ALL tables (if seated)
   Gui, Add, Text, x50 y235 w600 h20 cBlack, Press the above keys once for Deal Me "In" mode, quickly twice for "Out", and quickly 3 times for "Off" mode

   Gui, Add, Text, x50 y260 w620 h115 cBlack, Quick Setup: Check the top four checkboxes and sit down at a Ring game table.`nThe Auto-Post Blinds checkbox will be checked for you automatically (Full Tilt only).`nThe software will post your big blind when the big blind comes around to you.`nChange state to Deal Me "Out" if you want to sit out when the BB gets around to you.`nUse the above two keys to change between the 3 states: Deal me -  "In", "Out", and "Off".`nUse OSD3 and OSD4 on the Displays tab to continuously show the Deal Me mode on each table.`nNote: On Poker Stars "FAST" tables, the software will NOT post your small blind in Deal Me "Out" mode (it will sit you out instead).`nSee webpage documentation for more info.





   Gui, Tab, SnG A
Gui, Font, bold,
Gui, Add, Text, x10 y45 w740 h20 center, SnG A - Set Criteria here for Opening SnG Tournaments using the SnG B tab (which must be visible in the poker Lobby)
Gui, Add, Text, x10 y65 w740 h20 center, Poker Stars only
Gui, Font, norm,


/*
;Gui, Add, Text, x156 y55 w280 h20 cRed center, Warning: These will buy-in to SnGs with your money!
;Gui, Add, Text, x10 y60 w70 h40 +Center, Buttons to Open SnG (Tries Once)
Gui, Add, Text, x10 y103 w50 h20 , FT SnG 1
Gui, Add, Text, x10 y123 w50 h20 , FT SnG 2
Gui, Add, Text, x10 y143 w50 h20 , FT SnG 3
Gui, Add, Text, x10 y163 w50 h20 , FT SnG 4
Gui, Add, Text, x10 y183 w50 h20 , FT SnG 5
Gui, Add, Text, x10 y203 w50 h20 , FT SnG 6
Gui, Add, Text, x10 y223 w50 h20 , FT SnG 7
;Gui, Add, Text, x10 y243 w50 h20 , FT SnG 8
;Gui, Add, Text, x10 y263 w50 h20 , FT SnG 9
*/

Gui, Add, Text, x10 y248 w50 h20 , PS SnG 1
Gui, Add, Text, x10 y268 w50 h20 , PS SnG 2
Gui, Add, Text, x10 y288 w50 h20 , PS SnG 3
Gui, Add, Text, x10 y308 w50 h20 , PS SnG 4
Gui, Add, Text, x10 y328 w50 h20 , PS SnG 5
Gui, Add, Text, x10 y348 w50 h20 , PS SnG 6
Gui, Add, Text, x10 y368 w50 h20 , PS SnG 7


Gui, Add, Text, x70 y210 w80 h30 +Center, Your own `nDescription
/*
Gui, Add, Edit, x70 y100 w70 h20 cBlue vSng1Description gSettingsSubmitVariables, %Sng1Description%
Gui, Add, Edit, x70 y120 w70 h20 cBlue vSng2Description gSettingsSubmitVariables, %Sng2Description%
Gui, Add, Edit, x70 y140 w70 h20 cBlue vSng3Description gSettingsSubmitVariables, %Sng3Description%
Gui, Add, Edit, x70 y160 w70 h20 cBlue vSng4Description gSettingsSubmitVariables, %Sng4Description%
Gui, Add, Edit, x70 y180 w70 h20 cBlue vSng5Description gSettingsSubmitVariables, %Sng5Description%
Gui, Add, Edit, x70 y200 w70 h20 cBlue vSng6Description gSettingsSubmitVariables, %Sng6Description%
Gui, Add, Edit, x70 y220 w70 h20 cBlue vSng7Description gSettingsSubmitVariables, %Sng7Description%
;Gui, Add, Edit, x70 y240 w70 h20 cBlue vSng8Description gSettingsSubmitVariables, %Sng8Description%
;Gui, Add, Edit, x70 y260 w70 h20 cBlue vSng9Description gSettingsSubmitVariables, %Sng9Description%
*/

Gui, Add, Edit, x70 y245 w70 h20 cBlue vSng11Description gSettingsSubmitVariables, %Sng11Description%
Gui, Add, Edit, x70 y265 w70 h20 cBlue vSng12Description gSettingsSubmitVariables, %Sng12Description%
Gui, Add, Edit, x70 y285 w70 h20 cBlue vSng13Description gSettingsSubmitVariables, %Sng13Description%
Gui, Add, Edit, x70 y305 w70 h20 cBlue vSng14Description gSettingsSubmitVariables, %Sng14Description%
Gui, Add, Edit, x70 y325 w70 h20 cBlue vSng15Description gSettingsSubmitVariables, %Sng15Description%
Gui, Add, Edit, x70 y345 w70 h20 cBlue vSng16Description gSettingsSubmitVariables, %Sng16Description%
Gui, Add, Edit, x70 y365 w70 h20 cBlue vSng17Description gSettingsSubmitVariables, %Sng17Description%


Gui, Add, Text, x150 y220 w80 h20 +Center, Game
/*
DropList := "Hold'em|Omaha Hi|Omaha H/L|7-Stud|7-Stud H/L|Razz|HORSE|HA"
Pos := ListGetPos(DropList,Sng1Game,"|")
Gui, Add, DropDownList, x150 y100 w80 h21 vSng1Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng2Game,"|")
Gui, Add, DropDownList, x150 y120 w80 h21 vSng2Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng3Game,"|")
Gui, Add, DropDownList, x150 y140 w80 h21 vSng3Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng4Game,"|")
Gui, Add, DropDownList, x150 y160 w80 h21 vSng4Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng5Game,"|")
Gui, Add, DropDownList, x150 y180 w80 h21 vSng5Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng6Game,"|")
Gui, Add, DropDownList, x150 y200 w80 h21 vSng6Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng7Game,"|")
Gui, Add, DropDownList, x150 y220 w80 h21 vSng7Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng8Game,"|")
;Gui, Add, DropDownList, x150 y240 w80 h21 vSng8Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng9Game,"|")
;Gui, Add, DropDownList, x150 y260 w80 h21 vSng9Game gSettingsSubmitVariables R8 Choose%Pos%, %DropList%
*/

DropList := PSSngFileList
Pos := ListGetPos(DropList,Sng11Game,"|")
Gui, Add, DropDownList, x150 y245 w280 h21 vSng11Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng12Game,"|")
Gui, Add, DropDownList, x150 y265 w280 h21 vSng12Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng13Game,"|")
Gui, Add, DropDownList, x150 y285 w280 h21 vSng13Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng14Game,"|")
Gui, Add, DropDownList, x150 y305 w280 h21 vSng14Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng15Game,"|")
Gui, Add, DropDownList, x150 y325 w280 h21 vSng15Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng16Game,"|")
Gui, Add, DropDownList, x150 y345 w280 h21 vSng16Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%
Pos := ListGetPos(DropList,Sng17Game,"|")
Gui, Add, DropDownList, x150 y365 w280 h21 vSng17Game gSettingsSubmitVariables R5 Choose%Pos%, %PSSngFileList%

/*
Gui, Add, Text, x240 y80 w50 h20 +Center, Options
DropList := "None|T|M|M T|DS|R A T|SO|SO T|KO DS T"
Pos := ListGetPos(DropList,Sng1Options,"|")
Gui, Add, DropDownList, x240 y100 w80 h21 vSng1Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng2Options,"|")
Gui, Add, DropDownList, x240 y120 w80 h21 vSng2Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng3Options,"|")
Gui, Add, DropDownList, x240 y140 w80 h21 vSng3Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng4Options,"|")
Gui, Add, DropDownList, x240 y160 w80 h21 vSng4Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng5Options,"|")
Gui, Add, DropDownList, x240 y180 w80 h21 vSng5Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng6Options,"|")
Gui, Add, DropDownList, x240 y200 w80 h21 vSng6Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng7Options,"|")
Gui, Add, DropDownList, x240 y220 w80 h21 vSng7Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng8Options,"|")
;Gui, Add, DropDownList, x240 y240 w80 h21 vSng8Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng9Options,"|")
;Gui, Add, DropDownList, x240 y260 w80 h21 vSng9Options gSettingsSubmitVariables R9 Choose%Pos%, %DropList%
*/

/*
Gui, Add, Text, x330 y80 w50 h20 +Center, Type
DropList := "NL|PL|Limit"
Pos := ListGetPos(DropList,Sng1Type,"|")
Gui, Add, DropDownList, x330 y100 w50 h21 vSng1Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng2Type,"|")
Gui, Add, DropDownList, x330 y120 w50 h21 vSng2Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng3Type,"|")
Gui, Add, DropDownList, x330 y140 w50 h21 vSng3Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng4Type,"|")
Gui, Add, DropDownList, x330 y160 w50 h21 vSng4Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng5Type,"|")
Gui, Add, DropDownList, x330 y180 w50 h21 vSng5Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng6Type,"|")
Gui, Add, DropDownList, x330 y200 w50 h21 vSng6Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng7Type,"|")
Gui, Add, DropDownList, x330 y220 w50 h21 vSng7Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng8Type,"|")
;Gui, Add, DropDownList, x330 y240 w50 h21 vSng8Type gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng9Type,"|")
;Gui, Add, DropDownList, x330 y260 w50 h21 vSng9Type gSettingsSubmitVariables R3 Choose%Pos%,%DropList%
*/

/*
Gui, Add, Text, x390 y70 w40 h30 +Center, Total Buy-In $
Gui, Add, Edit, x390 y100 w40 h20 vSng1Cost gSettingsSubmitVariables, %Sng1Cost%
Gui, Add, Edit, x390 y120 w40 h20 vSng2Cost gSettingsSubmitVariables, %Sng2Cost%
Gui, Add, Edit, x390 y140 w40 h20 vSng3Cost gSettingsSubmitVariables, %Sng3Cost%
Gui, Add, Edit, x390 y160 w40 h20 vSng4Cost gSettingsSubmitVariables, %Sng4Cost%
Gui, Add, Edit, x390 y180 w40 h20 vSng5Cost gSettingsSubmitVariables, %Sng5Cost%
Gui, Add, Edit, x390 y200 w40 h20 vSng6Cost gSettingsSubmitVariables, %Sng6Cost%
Gui, Add, Edit, x390 y220 w40 h20 vSng7Cost gSettingsSubmitVariables, %Sng7Cost%
;Gui, Add, Edit, x390 y240 w40 h20 vSng8Cost gSettingsSubmitVariables, %Sng8Cost%
;Gui, Add, Edit, x390 y260 w40 h20 vSng9Cost gSettingsSubmitVariables, %Sng9Cost%
*/

/*
Gui, Add, Text, x440 y70 w40 h30 , Seats/ Table
DropList := "2|6|8/9"
Pos := ListGetPos(DropList,Sng1Seats,"|")
Gui, Add, DropDownList, x437 y100 w40 h21 vSng1Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng2Seats,"|")
Gui, Add, DropDownList, x437 y120 w40 h21 vSng2Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng3Seats,"|")
Gui, Add, DropDownList, x437 y140 w40 h21 vSng3Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng4Seats,"|")
Gui, Add, DropDownList, x437 y160 w40 h21 vSng4Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng5Seats,"|")
Gui, Add, DropDownList, x437 y180 w40 h21 vSng5Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng6Seats,"|")
Gui, Add, DropDownList, x437 y200 w40 h21 vSng6Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng7Seats,"|")
Gui, Add, DropDownList, x437 y220 w40 h21 vSng7Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng8Seats,"|")
;Gui, Add, DropDownList, x437 y240 w40 h21 vSng8Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng9Seats,"|")
;Gui, Add, DropDownList, x437 y260 w40 h21 vSng9Seats gSettingsSubmitVariables R3 Choose%Pos%, %DropList%
*/

/*
Gui, Add, Text, x480 y70 w30 h30 +Center, Total Plyrs
Gui, Add, Edit, x480 y100 w30 h20 vSng1NumPlayers gSettingsSubmitVariables number, %Sng1NumPlayers%
Gui, Add, Edit, x480 y120 w30 h20 vSng2NumPlayers gSettingsSubmitVariables number, %Sng2NumPlayers%
Gui, Add, Edit, x480 y140 w30 h20 vSng3NumPlayers gSettingsSubmitVariables number, %Sng3NumPlayers%
Gui, Add, Edit, x480 y160 w30 h20 vSng4NumPlayers gSettingsSubmitVariables number, %Sng4NumPlayers%
Gui, Add, Edit, x480 y180 w30 h20 vSng5NumPlayers gSettingsSubmitVariables number, %Sng5NumPlayers%
Gui, Add, Edit, x480 y200 w30 h20 vSng6NumPlayers gSettingsSubmitVariables number, %Sng6NumPlayers%
Gui, Add, Edit, x480 y220 w30 h20 vSng7NumPlayers gSettingsSubmitVariables number, %Sng7NumPlayers%
;Gui, Add, Edit, x480 y240 w30 h20 vSng8NumPlayers gSettingsSubmitVariables number, %Sng8NumPlayers%
;Gui, Add, Edit, x480 y260 w30 h20 vSng9NumPlayers gSettingsSubmitVariables number, %Sng9NumPlayers%
Gui, Add, Text, x520 y60 w50 h40 +Center, Min # Reg. Plyrs (0=NA)
Gui, Add, Edit, x520 y100 w50 h20 vSng1NumRegPlayersMin gSettingsSubmitVariables number, %Sng1NumRegPlayersMin%
Gui, Add, Edit, x520 y120 w50 h20 vSng2NumRegPlayersMin gSettingsSubmitVariables number, %Sng2NumRegPlayersMin%
Gui, Add, Edit, x520 y140 w50 h20 vSng3NumRegPlayersMin gSettingsSubmitVariables number, %Sng3NumRegPlayersMin%
Gui, Add, Edit, x520 y160 w50 h20 vSng4NumRegPlayersMin gSettingsSubmitVariables number, %Sng4NumRegPlayersMin%
Gui, Add, Edit, x520 y180 w50 h20 vSng5NumRegPlayersMin gSettingsSubmitVariables number, %Sng5NumRegPlayersMin%
Gui, Add, Edit, x520 y200 w50 h20 vSng6NumRegPlayersMin gSettingsSubmitVariables number, %Sng6NumRegPlayersMin%
Gui, Add, Edit, x520 y220 w50 h20 vSng7NumRegPlayersMin gSettingsSubmitVariables number, %Sng7NumRegPlayersMin%
;Gui, Add, Edit, x520 y240 w50 h20 vSng8NumRegPlayersMin gSettingsSubmitVariables number, %Sng8NumRegPlayersMin%
;Gui, Add, Edit, x520 y260 w50 h20 vSng9NumRegPlayersMin gSettingsSubmitVariables number, %Sng9NumRegPlayersMin%
Gui, Add, Text, x580 y60 w50 h40 +Center, Max # Sharks (100=NA)
Gui, Add, Edit, x580 y100 w50 h20 vSng1NumSharksMax gSettingsSubmitVariables number, %Sng1NumSharksMax%
Gui, Add, Edit, x580 y120 w50 h20 vSng2NumSharksMax gSettingsSubmitVariables number, %Sng2NumSharksMax%
Gui, Add, Edit, x580 y140 w50 h20 vSng3NumSharksMax gSettingsSubmitVariables number, %Sng3NumSharksMax%
Gui, Add, Edit, x580 y160 w50 h20 vSng4NumSharksMax gSettingsSubmitVariables number, %Sng4NumSharksMax%
Gui, Add, Edit, x580 y180 w50 h20 vSng5NumSharksMax gSettingsSubmitVariables number, %Sng5NumSharksMax%
Gui, Add, Edit, x580 y200 w50 h20 vSng6NumSharksMax gSettingsSubmitVariables number, %Sng6NumSharksMax%
Gui, Add, Edit, x580 y220 w50 h20 vSng7NumSharksMax gSettingsSubmitVariables number, %Sng7NumSharksMax%
;Gui, Add, Edit, x580 y240 w50 h20 vSng8NumSharksMax gSettingsSubmitVariables number, %Sng8NumSharksMax%
;Gui, Add, Edit, x580 y260 w50 h20 vSng9NumSharksMax gSettingsSubmitVariables number, %Sng9NumSharksMax%
Gui, Add, Text, x640 y60 w50 h40 +Center cGreen, Special Lobby Text **
Gui, Add, Edit, x640 y100 w50 h20 vSng1LobbyText gSettingsSubmitVariables, %Sng1LobbyText%
Gui, Add, Edit, x640 y120 w50 h20 vSng2LobbyText gSettingsSubmitVariables, %Sng2LobbyText%
Gui, Add, Edit, x640 y140 w50 h20 vSng3LobbyText gSettingsSubmitVariables, %Sng3LobbyText%
Gui, Add, Edit, x640 y160 w50 h20 vSng4LobbyText gSettingsSubmitVariables, %Sng4LobbyText%
Gui, Add, Edit, x640 y180 w50 h20 vSng5LobbyText gSettingsSubmitVariables, %Sng5LobbyText%
Gui, Add, Edit, x640 y200 w50 h20 vSng6LobbyText gSettingsSubmitVariables, %Sng6LobbyText%
Gui, Add, Edit, x640 y220 w50 h20 vSng7LobbyText gSettingsSubmitVariables, %Sng7LobbyText%
;Gui, Add, Edit, x640 y240 w50 h20 vSng8LobbyText gSettingsSubmitVariables, %Sng8LobbyText%
;Gui, Add, Edit, x640 y260 w50 h20 vSng9LobbyText gSettingsSubmitVariables, %Sng9LobbyText%
Gui, Add, Text, x700 y70 w50 h40 +Center, Pay`nUsing

DropList := "$|T$|Token|FTP|Play"
Pos := ListGetPos(DropList,Sng1PaymentType,"|")
Gui, Add, DropDownList, x700 y100 w50 h21 vSng1PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng2PaymentType,"|")
Gui, Add, DropDownList, x700 y120 w50 h21 vSng2PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng3PaymentType,"|")
Gui, Add, DropDownList, x700 y140 w50 h21 vSng3PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng4PaymentType,"|")
Gui, Add, DropDownList, x700 y160 w50 h21 vSng4PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng5PaymentType,"|")
Gui, Add, DropDownList, x700 y180 w50 h21 vSng5PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng6PaymentType,"|")
Gui, Add, DropDownList, x700 y200 w50 h21 vSng6PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
Pos := ListGetPos(DropList,Sng7PaymentType,"|")
Gui, Add, DropDownList, x700 y220 w50 h21 vSng7PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng8PaymentType,"|")
;Gui, Add, DropDownList, x700 y240 w50 h21 vSng8PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
;Pos := ListGetPos(DropList,Sng9PaymentType,"|")
;Gui, Add, DropDownList, x700 y260 w50 h21 vSng9PaymentType gSettingsSubmitVariables R5 Choose%Pos%, %DropList%
*/

Gui, Add, Text, x440 y260 w300 h80 cBlack, Notes: `n1. The Poker Stars Lobby must be it's MINIMUM physical size.`n2. Only Hold'em SnGs are included for Poker Stars.
Gui, Add, Text, x440 y338 w300 h30 cGreen, ** Set this to differentiate between two otherwise identical SnGs (see documentation)





Gui, Tab, SnG B
Gui, Font, bold,
Gui, Add, Text, x50 y45 w280 h20 center, Select SnG to Open as defined on SnG A tab
Gui, Add, Text, x50 y65 w280 h20 center, Poker Stars Only
Gui, Add, Text, x440 y45 w280 h20 center, Configure for Automatic Opening of SnGs
Gui, Add, Text, x440 y65 w280 h20 center, Poker Stars Only
Gui, Font, norm,
Gui, Add, Text, x430 y85 w320 h20 cRed center, Warning: These features will buy-in to SnGs with your money!

Gui, Add, Text, x10 y205 w70 h40 +Center, Manually Open SnG (one try)







/*
Gui, Add, Button, x10 y100 w75 h20 gSng1Open, FT SnG 1
Gui, Add, Button, x10 y120 w75 h20 gSng2Open, FT SnG 2
Gui, Add, Button, x10 y140 w75 h20 gSng3Open, FT SnG 3
Gui, Add, Button, x10 y160 w75 h20 gSng4Open, FT SnG 4
Gui, Add, Button, x10 y180 w75 h20 gSng5Open, FT SnG 5
Gui, Add, Button, x10 y200 w75 h20 gSng6Open, FT SnG 6
Gui, Add, Button, x10 y220 w75 h20 gSng7Open, FT SnG 7
;Gui, Add, Button, x10 y240 w75 h20 gSng8Open, FT SnG 8
;Gui, Add, Button, x10 y260 w75 h20 gSng9Open, FT SnG 9
*/
Gui, Add, Button, x10 y245 w75 h20 gSng11Open, PS SnG 1
Gui, Add, Button, x10 y265 w75 h20 gSng12Open, PS SnG 2
Gui, Add, Button, x10 y285 w75 h20 gSng13Open, PS SnG 3
Gui, Add, Button, x10 y305 w75 h20 gSng14Open, PS SnG 4
Gui, Add, Button, x10 y325 w75 h20 gSng15Open, PS SnG 5
Gui, Add, Button, x10 y345 w75 h20 gSng16Open, PS SnG 6
Gui, Add, Button, x10 y365 w75 h20 gSng17Open, PS SnG 7



Gui, Add, Text, x85 y215 w80 h30 +Center, Your Own `Description
/*
Gui, Add, Edit, x90 y100 w80 h20 cBlue  readonly vSng1DescriptionB , %Sng1Description%
Gui, Add, Edit, x90 y120 w80 h20 cBlue  readonly vSng2DescriptionB , %Sng2Description%
Gui, Add, Edit, x90 y140 w80 h20 cBlue  readonly vSng3DescriptionB , %Sng3Description%
Gui, Add, Edit, x90 y160 w80 h20 cBlue  readonly vSng4DescriptionB , %Sng4Description%
Gui, Add, Edit, x90 y180 w80 h20 cBlue  readonly vSng5DescriptionB , %Sng5Description%
Gui, Add, Edit, x90 y200 w80 h20 cBlue  readonly vSng6DescriptionB , %Sng6Description%
Gui, Add, Edit, x90 y220 w80 h20 cBlue  readonly vSng7DescriptionB , %Sng7Description%
;Gui, Add, Edit, x90 y240 w80 h20 cBlue  readonly vSng8DescriptionB , %Sng8Description%
;Gui, Add, Edit, x90 y260 w80 h20 cBlue  readonly vSng9DescriptionB , %Sng9Description%
*/
Gui, Add, Edit, x90 y245 w80 h20 cBlue  readonly vSng11DescriptionB , %Sng11Description%
Gui, Add, Edit, x90 y265 w80 h20 cBlue  readonly vSng12DescriptionB , %Sng12Description%
Gui, Add, Edit, x90 y285 w80 h20 cBlue  readonly vSng13DescriptionB , %Sng13Description%
Gui, Add, Edit, x90 y305 w80 h20 cBlue  readonly vSng14DescriptionB , %Sng14Description%
Gui, Add, Edit, x90 y325 w80 h20 cBlue  readonly vSng15DescriptionB , %Sng15Description%
Gui, Add, Edit, x90 y345 w80 h20 cBlue  readonly vSng16DescriptionB , %Sng16Description%
Gui, Add, Edit, x90 y365 w80 h20 cBlue  readonly vSng17DescriptionB , %Sng17Description%


Gui, Add, Text, x160 y215 w70 h30 +Center, Enable for Auto Opening
/*
Gui, Add, CheckBox, x185 y100 w10 h20 Checked%Sng1ContinuouslyEnabled% vSng1ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y120 w10 h20 Checked%Sng2ContinuouslyEnabled% vSng2ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y140 w10 h20 Checked%Sng3ContinuouslyEnabled% vSng3ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y160 w10 h20 Checked%Sng4ContinuouslyEnabled% vSng4ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y180 w10 h20 Checked%Sng5ContinuouslyEnabled% vSng5ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y200 w10 h20 Checked%Sng6ContinuouslyEnabled% vSng6ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y220 w10 h20 Checked%Sng7ContinuouslyEnabled% vSng7ContinuouslyEnabled gSettingsSubmitVariables
;Gui, Add, CheckBox, x185 y240 w10 h20 Checked%Sng8ContinuouslyEnabled% vSng8ContinuouslyEnabled gSettingsSubmitVariables
;Gui, Add, CheckBox, x185 y260 w10 h20 Checked%Sng9ContinuouslyEnabled% vSng9ContinuouslyEnabled gSettingsSubmitVariables
*/
Gui, Add, CheckBox, x185 y245 w10 h20 Checked%Sng11ContinuouslyEnabled% vSng11ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y265 w10 h20 Checked%Sng12ContinuouslyEnabled% vSng12ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y285 w10 h20 Checked%Sng13ContinuouslyEnabled% vSng13ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y305 w10 h20 Checked%Sng14ContinuouslyEnabled% vSng14ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y325 w10 h20 Checked%Sng15ContinuouslyEnabled% vSng15ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y345 w10 h20 Checked%Sng16ContinuouslyEnabled% vSng16ContinuouslyEnabled gSettingsSubmitVariables
Gui, Add, CheckBox, x185 y365 w10 h20 Checked%Sng17ContinuouslyEnabled% vSng17ContinuouslyEnabled gSettingsSubmitVariables



Gui, Add, Text, x250 y225 w50 h20 +Center, Status
/*
Gui, Add, Edit, x210 y100 w140 h20 cBlue vSng1Status -wrap readonly
Gui, Add, Edit, x210 y120 w140 h20 cBlue vSng2Status -wrap  readonly
Gui, Add, Edit, x210 y140 w140 h20 cBlue vSng3Status -wrap  readonly
Gui, Add, Edit, x210 y160 w140 h20 cBlue vSng4Status -wrap  readonly
Gui, Add, Edit, x210 y180 w140 h20 cBlue vSng5Status -wrap  readonly
Gui, Add, Edit, x210 y200 w140 h20 cBlue vSng6Status -wrap  readonly
Gui, Add, Edit, x210 y220 w140 h20 cBlue vSng7Status -wrap  readonly
;Gui, Add, Edit, x210 y240 w140 h20 cBlue vSng8Status -wrap  readonly
;Gui, Add, Edit, x210 y260 w140 h20 cBlue vSng9Status -wrap  readonly
*/
Gui, Add, Edit, x210 y245 w140 h20 cBlue vSng11Status -wrap  readonly
Gui, Add, Edit, x210 y265 w140 h20 cBlue vSng12Status -wrap  readonly
Gui, Add, Edit, x210 y285 w140 h20 cBlue vSng13Status -wrap  readonly
Gui, Add, Edit, x210 y305 w140 h20 cBlue vSng14Status -wrap  readonly
Gui, Add, Edit, x210 y325 w140 h20 cBlue vSng15Status -wrap  readonly
Gui, Add, Edit, x210 y345 w140 h20 cBlue vSng16Status -wrap  readonly
Gui, Add, Edit, x210 y365 w140 h20 cBlue vSng17Status -wrap  readonly


Gui, Add, Button, x450 y100 w100 h20 vSngStart gSngStart, Start New Session
Gui, Add, Button, x450 y120 w50 h20 vSngResume gSngResume, Resume
Gui, Add, Button, x500 y120 w50 h20 vSngPause gSngPause, Pause
Gui, Add, Button, x450 y140 w100 h20 vSngStop gSngStop, Stop Session


Gui, Add, Text, x350 y183 w150 h40 right, # of SnGs to KEEP open
Gui, Add, Text, x350 y203 w150 h40 right, Max # of SnGs to open
Gui, Add, Text, x350 y223 w150 h40 right, Session Time Limit (min)
Gui, Add, Text, x350 y243 w150 h40 right, Opening SnG Interval (sec)
Gui, Add, Text, x350 y263 w150 h40 right, Inactivity Timeout (min)

Gui, Add, Edit, x510 y180 w40 h20 center number vSngContinuouslyOpenNumber gSettingsSubmitVariables,%SngContinuouslyOpenNumber%
Gui, Add, Edit, x510 y200 w40 h20 center number vSngStopOpeningAfterNum gSettingsSubmitVariables,%SngStopOpeningAfterNum%
Gui, Add, Edit, x510 y220 w40 h20 center number vSngContinuouslyOpenPlayTime gSettingsSubmitVariables,%SngContinuouslyOpenPlayTime%
Gui, Add, Edit, x510 y240 w40 h20 center number vSngContinuouslyOpenTimerInterval gSettingsSubmitVariables,%SngContinuouslyOpenTimerInterval%
Gui, Add, Edit, x510 y260 w40 h20 center number vSngContinuouslyOpenFailSafeTime gSettingsSubmitVariables,%SngContinuouslyOpenFailSafeTime%


Gui, Add, Edit, x580 y100 w160 h20 center cBlue vSngContinuousStatus  readonly
Gui, Add, Edit, x580 y180 w160 h20 center cBlue vSngOpenstatus  readonly
Gui, Add, Edit, x580 y200 w160 h20 center cBlue vSngOpenedThisSessionStatus  readonly
Gui, Add, Edit, x580 y220 w160 h20 center cBlue vSngTimeLeftStatus  readonly

;Gui, Add, Edit, x580 y100 w160 h20 +Center ReadOnly cBlue vSngContinuousStatus gSettingsSubmitVariables
;Gui, Add, Edit, x580 y180 w160 h20 +Center ReadOnly cBlue vSngOpenstatus gSettingsSubmitVariables
;Gui, Add, Edit, x580 y200 w160 h20 +Center ReadOnly cBlue vSngOpenedThisSessionStatus gSettingsSubmitVariables
;Gui, Add, Edit, x580 y220 w160 h20 +Center ReadOnly cBlue vSngTimeLeftStatus gSettingsSubmitVariables


Gui, Add, CheckBox, x370 y290 w350 h30 Checked%ClickOkForSngEnabled% vClickOkForSngEnabled gSettingsSubmitVariables cRed, Auto-Click the final Buy In button when Session is Running`n(Warning!! Commits your $$$!)



Gui, Tab, SnG / T
Gui, Font, bold,
Gui, Add, Text, x50 y45 w560 h20 center, Miscellaneous Settings for SnGs and Tournaments
Gui, Font, norm,


Gui, Add, CheckBox, x16 y70 w550 h30 Checked%AutoClickImBackButtonEnabled% vAutoClickImBackButtonEnabled gSettingsSubmitVariables cBlack, Auto-Click the I'm Back Button when it appears in SnGs and Tournaments. The "I'm Back" button must be fully visible, or else the button will not be clicked.
Gui, Add, CheckBox, x16 y100 w550 h20 Checked%ClickImReadyEnabled% vClickImReadyEnabled gSettingsSubmitVariables cBlack, Auto-Click the I'm Ready button (Full Tilt tables only)
Gui, Add, CheckBox, x16 y120 w550 h20 Checked%AutoCloseTournamentLobbyEnabled% vAutoCloseTournamentLobbyEnabled gSettingsSubmitVariables cBlack, Auto-Close SnG and Tournament Lobbies (when the register button is NOT visible)
Gui, Add, CheckBox, x16 y140 w550 h20 Checked%MinimizeSngLobbyEnabled% vMinimizeSngLobbyEnabled gSettingsSubmitVariables cBlack, Minimize SnG Lobby after automated SnG registering
Gui, Add, CheckBox, x16 y160 w550 h20 Checked%UseCriticalMethodDisabled% vUseCriticalMethodDisabled gSettingsSubmitVariables cBlack, Use slower (less interferring) method to open SnGs (Full Tilt Only)
Gui, Add, CheckBox, x16 y180 w434 h20 Checked%AutoClickInfoRefreshEnabled% vAutoClickInfoRefreshEnabled gSettingsSubmitVariables cBlack, Auto-Click the Info Refresh Button (when visible) (Poker Stars Only) - Interval (seconds):
Gui, Add, Edit, x450 y180 w30 h20 vAutoClickInfoRefreshInterval gSettingsSubmitVariables number center, %AutoClickInfoRefreshInterval%

Gui, Add, CheckBox, x16 y200 w550 h30 Checked%CloseFinishedSngTablesEnabled% vCloseFinishedSngTablesEnabled gSettingsSubmitVariables cBlack, Auto-Close SnG and Tournament Tables that Hero has finished`n(Works with Tiled, Stacked, or Cascaded tables.)
Gui, Add, CheckBox, x16 y230 w550 h30 Checked%CloseTourneyTablesIfNotSeatedEnabled% vCloseTourneyTablesIfNotSeatedEnabled gSettingsSubmitVariables cBlack, Auto-Close SnG and Tournament Tables if Hero is NOT seated`n(Tables must be visible and not overlapped.)
Gui, Add, Edit, x16 y260 w30 h20 vCloseTableTimeDelay gSettingsSubmitVariables number center, %CloseTableTimeDelay%
Gui, Add, Text, x51 y263 w550 h20, second delay before closing tables (when one or both of the above 2 checkboxes is checked)



/*
Gui, Add, Text, x66 y323 w110 h20 right, Key to Open FT SnG 1
Gui, Add, Edit, x16 y320 w40 h20 vSng1OpenControl gSettingsUpdateHotkeys, %Sng1OpenControl%
*/
Gui, Add, Text, x66 y293 w230 h20 , Key to Open PS SnG 1 (on SnG B tab)
Gui, Add, Edit, x16 y290 w40 h20 vSng11OpenControl gSettingsUpdateHotkeys, %Sng11OpenControl%

Gui, Add, Text, x66 y323 w230 h20 , Key to open SnG highlighted in PS lobby
Gui, Add, Edit, x16 y320 w40 h20 vPSSngOpenHighlightedControl gSettingsUpdateHotkeys, %PSSngOpenHighlightedControl%

Gui, Add, Text, x66 y343 w230 h20 , Key to open SnG highlighted in FT lobby
Gui, Add, Edit, x16 y340 w40 h20 vFTSngOpenHighlightedControl gSettingsUpdateHotkeys, %FTSngOpenHighlightedControl%

Gui, Add, CheckBox, x320 y300 w400 h55 Checked%OneClickSngRegisteringEnabled% vOneClickSngRegisteringEnabled gSettingsSubmitVariables cRed,  Auto-Click the final Buy In button ANYTIME the "Tournament Registration" dialog is visible, EXCEPT when the Session is Running (on SnG B tab). `nWarning!! Commits your $$$! Read the documentation to fully understand the implications of this feature.





   Gui, Tab, Actions1
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w750 h30 +Center cBlack, Keyboard and Mouse Actions (1)`n(Define keys or mouse buttons to perform specific actions on the table)
   Gui, Add, Text, x116 y110 w50 h20 , Action
   Gui, Add, Text, x176 y100 w100 h40 center, Enter Key`nor Mouse Code
   Gui, Font, norm,
   Gui, Add, Text, x10 y133 w165 h30 +Right cBlack, Click Left Button (e.g. Fold)
   Gui, Add, Text, x10 y158 w165 h30 +Right cBlack, Click Middle Button (e.g. Call) ***
   Gui, Add, Text, x10 y183 w165 h30 +Right cBlack, Click Right Button (e.g. Bet)
   Gui, Add, Text, x10 y208 w165 h30 +Right cBlack, Toggle pre-action Check/Fold
   Gui, Add, Text, x05 y233 w170 h30 +Right cBlack, Toggle pre-action Check/Call

   Gui, Add, Text, x05 y258 w170 h30 +Right cBlack, Toggle pre-action Call Any
   Gui, Add, Text, x05 y283 w170 h30 +Right cBlack, Toggle pre-action Raise Min
   Gui, Add, Text, x05 y308 w170 h30 +Right cBlack, Toggle pre-action Raise Any
   Gui, Add, Text, x10 y333 w165 h20 +Right cBlack, Clear Betting Window
   Gui, Add, Text, x10 y358 w165 h20 +Right cBlack, Toggle Fold to Any Bet Checkbox


;   Gui, Add, CheckBox, x86 y80 w160 h20 Checked%BettingControlsEnabled% vBettingControlsEnabled gSettingsSubmitVariables cBlack, Enable These Controls Below

   Gui, Add, Edit, x186 y130 w80 h20 vFoldCheckControl gSettingsUpdateHotkeys, %FoldCheckControl%
   Gui, Add, Edit, x186 y155 w80 h20 vCallControl gSettingsUpdateHotkeys, %CallControl%
   Gui, Add, Edit, x186 y180 w80 h20 vBetRaiseControl gSettingsUpdateHotkeys, %BetRaiseControl%
   Gui, Add, Edit, x186 y205 w80 h20 vLeftCheckboxControl gSettingsUpdateHotkeys, %LeftCheckboxControl%
   Gui, Add, Edit, x186 y230 w80 h20 vMiddleCheckboxControl gSettingsUpdateHotkeys, %MiddleCheckboxControl%

   Gui, Add, Edit, x186 y255 w80 h20 vCallAnyControl gSettingsUpdateHotkeys, %CallAnyControl%
   Gui, Add, Edit, x186 y280 w80 h20 vRaiseMinControl gSettingsUpdateHotkeys, %RaiseMinControl%
   Gui, Add, Edit, x186 y305 w80 h20 vRaiseAnyControl gSettingsUpdateHotkeys, %RaiseAnyControl%

   Gui, Add, Edit, x186 y330 w80 h20 vBetWindowClearControl gSettingsUpdateHotkeys, %BetWindowClearControl%
   Gui, Add, Edit, x186 y355 w80 h20 vFoldToAnyBetControl gSettingsUpdateHotkeys, %FoldToAnyBetControl%

;   Gui, Add, CheckBox, x306 y90 w420 h30 Checked%PreActionControlsEnabled% vPreActionControlsEnabled gSettingsSubmitVariables cGreen, Enable the Left and Middle Hotkeys to also check these Pre-Action Controls`n(Use with caution. See documentation.)
;   Gui, Add, Text, x286 y113 w270 h20 cRed, Note carefully which keys activate these checkboxes!!!

   Gui, Add, CheckBox, x281 y130 w440 h20 Checked%PreActionFoldControlEnabled% vPreActionFoldControlEnabled gSettingsSubmitVariables cBlack, Enable the key at left to toggle the pre-action Left Checkbox (Check/Fold or Fold)
   Gui, Add, CheckBox, x281 y155 w440 h20 Checked%PreActionCallControlEnabled% vPreActionCallControlEnabled gSettingsSubmitVariables cBlack, Enable the key at left to toggle the pre-action Middle Checkbox (Check or Call)
;   Gui, Add, Text, x271 y133 w430 h20 cGreen, -> Also checks the pre-action Left Checkbox if enabled above (Check/Fold or Fold)
;   Gui, Add, Text, x271 y158 w430 h20 cGreen, -> Also checks the pre-action Middle Checkbox if enabled above (Check or Call)

   Gui, Add, Text, x421 y220 w320 h150 cBlack +E0x80, Key Codes - Quick Summary:`n^ = Control key (e.g. use ^s for control-s)`n! = Alt (e.g. use !s for alt-s)`n# = Windows key (e.g. use #s for Win-s)`n+ = shift (e.g. use +s for shift-s)`nUse | between 2 codes to allow both codes to work`n       (e.g. s|a allows both the s and the a key to perform action`nSee "Key Codes" web documentation for full list of codes.


   Gui, Add, Text, x321 y360 w290 h20 cBlack, *** This key will click "Check" if "Call" is not visible.






   Gui, Tab, Actions2
   Gui, Font, bold,
   Gui, Add, Text, x6 y40 w750 h30 +Center cBlack, Keyboard and Mouse Actions (2)`n(Define keys or mouse buttons to perform specific actions on the table)
   Gui, Add, Text, x96 y80 w50 h20 , Action
   Gui, Add, Text, x156 y80 w140 h20 +center, Enter Key/Mouse Code
   Gui, Add, Text, x366 y80 w50 h20 , Action
   Gui, Add, Text, x416 y80 w140 h20 +Center, Enter Key/Mouse Code
   Gui, Font, norm,

   Gui, Add, Text, x4 y105 w152 h20 +Right cBlack, Copy Player's Name to ClipBrd
   Gui, Add, Edit, x166 y100 w120 h20 vPlayersNameControl gSettingsUpdateHotkeys, %PlayersNameControl%
;   Gui, Add, Text, x4 y125 w152 h20 +Right cBlack, Add Player to SharkList
;   Gui, Add, Edit, x166 y120 w120 h20 vPlayersNameToSharkListControl gSettingsUpdateHotkeys, %PlayersNameToSharkListControl%
;   Gui, Add, Text, x4 y145 w152 h20 +Right cBlack, Remove Player from SharkList
;   Gui, Add, Edit, x166 y140 w120 h20 vPlayersNameFromSharkListControl gSettingsUpdateHotkeys, %PlayersNameFromSharkListControl%
   Gui, Add, Text, x4 y165 w152 h20 +Right cBlack, Copy Tournament Id to ClipBrd
   Gui, Add, Edit, x166 y160 w120 h20 vTableTournamentIdControl gSettingsUpdateHotkeys, %TableTournamentIdControl%
   Gui, Add, Text, x26 y185 w130 h20 +Right cBlack, Get More Chips
   Gui, Add, Edit, x166 y180 w120 h20 vReloadChipsControl gSettingsUpdateHotkeys, %ReloadChipsControl%
   
   Gui, Add, Text, x26 y205 w130 h20 +Right cBlack, Toggle Auto Muck Hands
   Gui, Add, Edit, x166 y200 w120 h20 vLobbyToggleAutoMuckHandsControl gSettingsUpdateHotkeys, %LobbyToggleAutoMuckHandsControl%
;   Gui, Add, Text, x16 y205 w140 h20 +Right cBlack, Manual Reload All Tables
;   Gui, Add, Edit, x166 y200 w120 h20 vReloadAllControl gSettingsUpdateHotkeys, %ReloadAllControl%
   Gui, Add, Text, x8 y225 w146 h20 +Right cBlack, Move Mouse In/Out of Chat
   Gui, Add, Edit, x166 y220 w120 h20 vTableMoveToFromChatControl gSettingsUpdateHotkeys, %TableMoveToFromChatControl%
   Gui, Add, Text, x16 y245 w140 h20 +Right cBlack, Click Time on Active Table
   Gui, Add, Edit, x166 y240 w120 h20 vTimerControl gSettingsUpdateHotkeys, %TimerControl%
   Gui, Add, Text, x16 y265 w140 h20 +Right cBlack, Click Time on ALL Tables
   Gui, Add, Edit, x166 y260 w120 h20 vTimerAllControl gSettingsUpdateHotkeys, %TimerAllControl%
   Gui, Add, Text, x4 y285 w152 h20 +Right cBlack, Open/Close Last Hand Window
   Gui, Add, Edit, x166 y280 w120 h20 vLastHandControl gSettingsUpdateHotkeys, %LastHandControl%
   Gui, Add, Text, x1 y305 w155 h20 +Right cBlack, Open/Close Tourn Info Window
   Gui, Add, Edit, x166 y300 w120 h20 vTourneyInfoControl gSettingsUpdateHotkeys, %TourneyInfoControl%

;   Gui, Add, Text, x4 y305 w152 h20 +Right cBlack, Toggle Auto Muck Hands
;   Gui, Add, Edit, x166 y300 w120 h20 vToggleAutoMuckHandsControl gSettingsUpdateHotkeys, %ToggleAutoMuckHandsControl%




   Gui, Add, Text, x286 y105 w140 h20 +Right cBlack, Open Notes under mouse
   Gui, Add, Edit, x436 y100 w120 h20 vNotesControl gSettingsUpdateHotkeys, %NotesControl%

   
   Gui, Add, Text, x286 y125 w140 h20 +Right  cBlack, Open Notes - Player N
   Gui, Add, Edit, x436 y120 w120 h20 vNotesOpenPlayerNControl gSettingsUpdateHotkeys, %NotesOpenPlayerNControl%
   Gui, Add, Text, x286 y145 w140 h20 +Right  cBlack, View Notes - Player N (FT)
   Gui, Add, Edit, x436 y140 w120 h20 vNotesPlayerNControl gSettingsUpdateHotkeys, %NotesPlayerNControl%
   Gui, Add, Text, x286 y165 w140 h20 +Right cBlack, nano-Notes - mouse (FT)
   Gui, Add, Edit, x436 y160 w120 h20 vNotesNanoControl gSettingsUpdateHotkeys, %NotesNanoControl%
   Gui, Add, Text, x286 y185 w140 h20  +Right  cBlack, nano-Notes - Player N (FT)
   Gui, Add, Edit, x436 y180 w120 h20 vNotesNanoPlayerNControl gSettingsUpdateHotkeys, %NotesNanoPlayerNControl%
   Gui, Add, Text, x286 y205 w140 h20  +Right  cBlack, Initial nano-Notes Color (FT)
   DropList := "0|1|2|3|4|5|6|7|8|9|a|b|c|d|e"
   Pos := ListGetPos(DropList,NotesNanoInitialColor,"|")
   Gui, Add, DropDownList, x436 y200 w60 h20 vNotesNanoInitialColor gSettingsSubmitVariables R15 Choose%Pos%, %DropList%
   Gui, Add, Text, x286 y225 w140 h20  +Right  cBlack, Set Note Color to N (FT)
   Gui, Add, Edit, x436 y220 w120 h20 vNotesColorNControl gSettingsUpdateHotkeys, %NotesColorNControl%
   Gui, Add, Text, x286 y245 w140 h20  +Right  cBlack, Note Color Up (FT)
   Gui, Add, Edit, x436 y240 w120 h20 vNotesNanoColorUpControl gSettingsUpdateHotkeys, %NotesNanoColorUpControl%
   Gui, Add, Text, x286 y265 w140 h20  +Right  cBlack, Note Color Down (FT)
   Gui, Add, Edit, x436 y260 w120 h20 vNotesNanoColorDownControl gSettingsUpdateHotkeys, %NotesNanoColorDownControl%
   Gui, Add, Text, x286 y285 w140 h20  +Right  cBlack, Close Active Note (FT)
   Gui, Add, Edit, x436 y280 w120 h20 vNotesCloseControl gSettingsUpdateHotkeys, %NotesCloseControl%
   Gui, Add, Text, x321 y360 w290 h20 cBlack, FT = Full Tilt Only

 Gui, Tab, Actions3
   Gui, Font, bold,
   Gui, Add, Text, x6 y40 w750 h30 +Center cBlack, Keyboard and Mouse Actions (3)`n(Define keys or mouse buttons to perform specific actions on the table)
   Gui, Add, Text, x96 y80 w50 h20 , Action
   Gui, Add, Text, x196 y70 w80 h30 +center, Enter Key/`nMouse Code
   Gui, Add, Text, x366 y80 w50 h20 , Action
   Gui, Add, Text, x476 y70 w80 h30 +Center, Enter Key/`nMouse Code
   Gui, Font, norm,
   Gui, Add, Text, x16 y105 w170 h20 +Right cBlack, Toggle Sit Out on Active Table
   Gui, Add, Edit, x196 y100 w80 h20 vToggleSitOutControl gSettingsUpdateHotkeys, %ToggleSitOutControl%
   Gui, Add, Text, x16 y125 w170 h20 +Right cGreen, Sit In on ALL Tables
   Gui, Add, Edit, x196 y120 w80 h20 vSitInOnAllControl gSettingsUpdateHotkeys, %SitInOnAllControl%
   Gui, Add, Text, x16 y145 w170 h20 +Right cGreen, Sit Out on ALL Tables
   Gui, Add, Edit, x196 y140 w80 h20 vSitOutOnAllControl gSettingsUpdateHotkeys, %SitOutOnAllControl%
   Gui, Add, Text, x2 y165 w194 h20 +Right cBlack, Toggle Auto-Post Blinds on Active Table
   Gui, Add, Edit, x196 y160 w80 h20 vToggleAPBControl gSettingsUpdateHotkeys, %ToggleAPBControl%

   Gui, Add, Text, x16 y185 w170 h20  +Right cBlack, Close Active Table
   Gui, Add, Edit, x196 y180 w80 h20 vTableCloseActiveControl gSettingsUpdateHotkeys, %TableCloseActiveControl%
   Gui, Add, Text, x6 y205 w180 h20  +Right cGreen, Close Active Table if without Hero **
   Gui, Add, Edit, x196 y200 w80 h20 vTableCloseActiveWithoutHeroControl gSettingsUpdateHotkeys, %TableCloseActiveWithoutHeroControl%

   Gui, Add, Text, x16 y225 w170 h20  +Right cBlack, Close All Tables
   Gui, Add, Edit, x196 y220 w80 h20 vTableCloseAllControl gSettingsUpdateHotkeys, %TableCloseAllControl%
   Gui, Add, Text, x16 y245 w170 h20  +Right cGreen, Close All Tables if without Hero **
   Gui, Add, Edit, x196 y240 w80 h20 vTableCloseAllWithoutHeroControl gSettingsUpdateHotkeys, %TableCloseAllWithoutHeroControl%
   Gui, Add, Text, x16 y265 w170 h20  +Right cBlack, Minimize All Tables
   Gui, Add, Edit, x196 y260 w80 h20 vTableMinimizeAllControl gSettingsUpdateHotkeys, %TableMinimizeAllControl%
   Gui, Add, Text, x06 y285 w180 h20  +Right cGreen, Minimize All Tables if without Hero **
   Gui, Add, Edit, x196 y280 w80 h20 vTableMinimizeAllWithoutHeroControl gSettingsUpdateHotkeys, %TableMinimizeAllWithoutHeroControl%
   Gui, Add, Text, x06 y305 w170 h20  +Right cBlack, Open/Close Cashier Window
   Gui, Add, Edit, x196 y300 w80 h20 vOpenCashierControl gSettingsUpdateHotkeys, %OpenCashierControl%
   Gui, Add, Text, x06 y325 w170 h20  +Right cBlack, Close All Tourney/SnG Lobbies
   Gui, Add, Edit, x196 y320 w80 h20 vLobbyTournamentCloseControl gSettingsUpdateHotkeys, %LobbyTournamentCloseControl%
   Gui, Add, Text, x06 y345 w170 h20  +Right cBlack, Minimize All Tourney/SnG Lobbies
   Gui, Add, Edit, x196 y340 w80 h20 vLobbyTournamentMinimizeControl gSettingsUpdateHotkeys, %LobbyTournamentMinimizeControl%


   Gui, Add, Text, x276 y105 w190 h20 +Right cBlack, Activate Next Table -> Bottom/Right
   Gui, Add, Edit, x476 y100 w80 h20 vTableNextControl gSettingsUpdateHotkeys, %TableNextControl%
   Gui, Add, Text, x296 y125 w170 h20 +Right cBlack, Activate Next Table -> Top/Left
   Gui, Add, Edit, x476 y120 w80 h20 vTablePreviousControl gSettingsUpdateHotkeys, %TablePreviousControl%
   Gui, Add, Text, x296 y145 w170 h20 +Right cBlack, Activate Next Table -> Right
   Gui, Add, Edit, x476 y140 w80 h20 vTableRightControl gSettingsUpdateHotkeys, %TableRightControl%
   Gui, Add, Text, x296 y165 w170 h20 +Right cBlack, Activate Next Table -> Left
   Gui, Add, Edit, x476 y160 w80 h20 vTableLeftControl gSettingsUpdateHotkeys, %TableLeftControl%
   Gui, Add, Text, x296 y185 w170 h20  +Right cBlack, Activate Next Table -> Up
   Gui, Add, Edit, x476 y180 w80 h20 vTableUpControl gSettingsUpdateHotkeys, %TableUpControl%
   Gui, Add, Text, x296 y205 w170 h20  +Right cBlack, Activate Next Table -> Down
   Gui, Add, Edit, x476 y200 w80 h20 vTableDownControl gSettingsUpdateHotkeys, %TableDownControl%

   Gui, Add, Text, x296 y225 w170 h20  +Right cBlack, Activate Next Table in Stack
   Gui, Add, Edit, x476 y220 w80 h20 vTableNextInStackControl gSettingsUpdateHotkeys, %TableNextInStackControl%
   Gui, Add, Text, x296 y245 w170 h20  +Right cBlack, Activate Bottom Table in Stack
   Gui, Add, Edit, x476 y240 w80 h20 vTableBottomOfStackControl gSettingsUpdateHotkeys, %TableBottomOfStackControl%



   Gui, Add, Text, x296 y265 w170 h20 +Right cBlack, Activate Next Pending Action Table
   Gui, Add, Edit, x476 y260 w80 h20 vTablePendingControl gSettingsUpdateHotkeys, %TablePendingControl%
   Gui, Add, Text, x296 y285 w170 h20  +Right cBlack, Select Custom Table Layout 1
   Gui, Add, Edit, x476 y280 w80 h20 vTableLayout1Control gSettingsUpdateHotkeys, %TableLayout1Control%
   Gui, Add, Text, x296 y305 w170 h20  +Right cBlack, Select Custom Table Layout 2
   Gui, Add, Edit, x476 y300 w80 h20 vTableLayout2Control gSettingsUpdateHotkeys, %TableLayout2Control%

   Gui, Add, Text, x296 y325 w170 h20  +Right cBlack, Cascade All Tables
   Gui, Add, Edit, x476 y320 w80 h20 vTablesCascadeControl gSettingsUpdateHotkeys, %TablesCascadeControl%
   Gui, Add, Text, x296 y345 w170 h20  +Right cBlack, Tile All Tables
   Gui, Add, Edit, x476 y340 w80 h20 vTablesTileControl gSettingsUpdateHotkeys, %TablesTileControl%


;   Gui, Add, Text, x16 y305 w620 h20 cGreen, ** Hero's tables must be visible and NOT completely overlapped (else they will be closed/minimized EVEN IF HERO IS SEATED)
   Gui, Add, Text, x16 y365 w720 h20 cGreen, ** Table(s) must be visible for this feature to work correctly.


   Gui, Tab, Displays
Gui, Font, bold,
Gui, Add, Text, x6 y45 w750 h30 center, On Screen Displays (OSD)`n(Enable and customize a variety of on screen displays)
Gui, Font, norm,
;Gui, Add, Text, x160 y65 w100 h20 , Pos X
;Gui, Add, Text, x220 y65 w100 h20 , Pos Y
Gui, Add, Text, x280 y85 w100 h20 , Color
Gui, Add, Text, x440 y85 w60 h20 , Font Size
Gui, Add, Text, x500 y85 w100 h20 , Font
Gui, Add, Text, x560 y85 w60 h45 , Custom Text
Gui, Add, Text, x10 y85 w100 h20 , Enable Display
Gui, Add, CheckBox, x10 y105 w250 h20 Checked%OsdBettingInfoEnabled% vOsdBettingInfoEnabled gSettingsSubmitVariables cBlack, OSD 1 - Bet info (set position on Setup tab)
;Gui, Add, Edit, x160 y85 w40 h20 vOsdBettingInfoPosX gSettingsSubmitVariables number, %OsdBettingInfoPosX%
;Gui, Add, Edit, x220 y85 w40 h20 vOsdBettingInfoPosY gSettingsSubmitVariables number, %OsdBettingInfoPosY%
Gui, Add, Edit, x270 y105 w160 h20 vOsdBettingInfoColor gSettingsSubmitVariables, %OsdBettingInfoColor%
Gui, Add, Edit, x440 y105 w40 h20 vOsdBettingInfoFontSize gSettingsSubmitVariables number, %OsdBettingInfoFontSize%
Gui, Add, Edit, x500 y105 w40 h20 vOsdBettingInfoFont gSettingsSubmitVariables, %OsdBettingInfoFont%
Gui, Add, Edit, x560 y105 w180 h20 vOsdBettingInfoText gSettingsSubmitVariables, %OsdBettingInfoText%
;Gui, Add, CheckBox, x10 y105 w140 h20 Checked%TooltipBettingInfoEnabled% vTooltipBettingInfoEnabled gSettingsSubmitVariables cBlack, OSD 2 - Betting Tooltip
;Gui, Add, Edit, x160 y105 w40 h20 vTooltipBettingInfoPosX gSettingsSubmitVariables number, %TooltipBettingInfoPosX%
;Gui, Add, Edit, x220 y105 w40 h20 vTooltipBettingInfoPosY gSettingsSubmitVariables number, %TooltipBettingInfoPosY%
;Gui, Add, Edit, x460 y105 w100 h20 vTooltipBettingInfoText gSettingsSubmitVariables, %TooltipBettingInfoText%
Gui, Add, CheckBox, x10 y125 w250 h20 Checked%DisplayOsd3Enabled% vDisplayOsd3Enabled gSettingsSubmitVariables cBlack, OSD 3 - Stack info (set position on Setup tab)
;Gui, Add, Edit, x160 y125 w40 h20 vDisplayOsd3PosX gSettingsSubmitVariables number, %DisplayOsd3PosX%
;Gui, Add, Edit, x220 y125 w40 h20 vDisplayOsd3PosY gSettingsSubmitVariables number, %DisplayOsd3PosY%
Gui, Add, Edit, x270 y125 w160 h20 vDisplayOsd3Color gSettingsSubmitVariables, %DisplayOsd3Color%
Gui, Add, Edit, x440 y125 w40 h20 vDisplayOsd3FontSize gSettingsSubmitVariables number, %DisplayOsd3FontSize%
Gui, Add, Edit, x500 y125 w40 h20 vDisplayOsd3Font gSettingsSubmitVariables, %DisplayOsd3Font%
Gui, Add, Edit, x560 y125 w180 h20 vDisplayOsd3Text gSettingsSubmitVariables, %DisplayOsd3Text%
Gui, Add, CheckBox, x10 y145 w250 h20 Checked%DisplayOsd4Enabled% vDisplayOsd4Enabled gSettingsSubmitVariables cBlack, OSD 4 - Stack info (set position on Setup tab)
;Gui, Add, Edit, x160 y145 w40 h20 vDisplayOsd4PosX gSettingsSubmitVariables number, %DisplayOsd4PosX%
;Gui, Add, Edit, x220 y145 w40 h20 vDisplayOsd4PosY gSettingsSubmitVariables number, %DisplayOsd4PosY%
Gui, Add, Edit, x270 y145 w160 h20 vDisplayOsd4Color gSettingsSubmitVariables, %DisplayOsd4Color%
Gui, Add, Edit, x440 y145 w40 h20 vDisplayOsd4FontSize gSettingsSubmitVariables number, %DisplayOsd4FontSize%
Gui, Add, Edit, x500 y145 w40 h20 vDisplayOsd4Font gSettingsSubmitVariables, %DisplayOsd4Font%
Gui, Add, Edit, x560 y145 w180 h20 vDisplayOsd4Text gSettingsSubmitVariables, %DisplayOsd4Text%
Gui, Add, CheckBox, x10 y165 w250 h20 Checked%DisplayOsd5Enabled% vDisplayOsd5Enabled gSettingsSubmitVariables cBlack, OSD 5 - Stack info about player by mouse
;  Gui, Add, Edit, x160 y145 w40 h20 vDisplayOsd5PosX gSettingsSubmitVariables number, %DisplayOsd5PosX%
;  Gui, Add, Edit, x220 y145 w40 h20 vDisplayOsd5PosY gSettingsSubmitVariables number, %DisplayOsd5PosY%
Gui, Add, Edit, x270 y165 w160 h20 vDisplayOsd5Color gSettingsSubmitVariables, %DisplayOsd5Color%
Gui, Add, Edit, x440 y165 w40 h20 vDisplayOsd5FontSize gSettingsSubmitVariables number, %DisplayOsd5FontSize%
Gui, Add, Edit, x500 y165 w40 h20 vDisplayOsd5Font gSettingsSubmitVariables, %DisplayOsd5Font%
Gui, Add, Edit, x560 y165 w180 h20 vDisplayOsd5Text gSettingsSubmitVariables, %DisplayOsd5Text%

;Gui, Add, CheckBox, x10 y165 w140 h20 Checked%TooltipStackInfoEnabled% vTooltipStackInfoEnabled gSettingsSubmitVariables cBlack, OSD 5 - Stack Tooltip
;Gui, Add, Edit, x460 y165 w100 h20 vTooltipStackInfoText gSettingsSubmitVariables, %TooltipStackInfoText%


Gui, Add, CheckBox, x20 y185 w300 h20 Checked%DisplayOsdBetInfoInLimitGamesEnabled% vDisplayOsdBetInfoInLimitGamesEnabled gSettingsSubmitVariables cBlack, Enable OSD 1 in Limit Games
Gui, Add, CheckBox, x20 y205 w300 h20 Checked%DisplayOsdStackInfoInRingGamesEnabled% vDisplayOsdStackInfoInRingGamesEnabled gSettingsSubmitVariables cBlack, Enable OSD 3-4 in Ring Games
Gui, Add, CheckBox, x20 y225 w300 h20 Checked%DisplayOsd3AllTablesEnabled% vDisplayOsd3AllTablesEnabled gSettingsSubmitVariables cBlack, Enable OSD 3 for all tables (not just active table)
Gui, Add, CheckBox, x20 y245 w300 h20 Checked%DisplayOsd4AllTablesEnabled% vDisplayOsd4AllTablesEnabled gSettingsSubmitVariables cBlack, Enable OSD 4 for all tables (not just active table)




   Gui, Add, CheckBox, x430 y205 w220 h20 Checked%DisplayDebugInfoEnabled% vDisplayDebugInfoEnabled gSettingsSubmitVariables cBlack, Enable Debug Display at position - (X,Y):
   Gui, Add, Edit, x650 y205 w40 h20 vDebugTooltipPosX gSettingsSubmitVariables , %DebugTooltipPosX%
   Gui, Add, Edit, x700 y205 w40 h20 vDebugTooltipPosY gSettingsSubmitVariables , %DebugTooltipPosY%

   Gui, Add, CheckBox, x430 y225 w300 h20 Checked%ChatWarningEnabled% vChatWarningEnabled gSettingsSubmitVariables cBlack, Enable Chat Warning Tooltip (over the Chat Box area)
   
   Gui, Add, Edit, x430 y245 w80 h20 vRefreshOSD1Control gSettingsSubmitVariables, %RefreshOSD1Control%   
   Gui, Add, Text, x520 y248 w200 h20 , Key or mouse code to refresh OSD1  

Gui, Add, Text, x20 y270 w730 h115 , %Msg4%


/*

   Gui, Tab, Chips
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w550 h20 center, Getting Chips
   Gui, Font, norm,

;   Gui, Add, CheckBox, x40 y80 w500 h20 Checked%AutoClickOkOnGetChipsDialogEnabled% vAutoClickOkOnGetChipsDialogEnabled gSettingsSubmitVariables cBlack, Auto-Click on "OK" in the Get Chips dialog box, whenever you buy chips.



   Gui, Add, Text, x196 y110 w90 h20 , NL/PL Tables
   Gui, Add, Text, x306 y110 w120 h20 , Capped Tables
   Gui, Add, Text, x446 y110 w90 h20 , Limit Tables

;   Gui, Add, Text, x16 y90 w150 h30 right, Initial Buyin Amount`n(set to 0 to disable)
   Gui, Add, Text, x16 y130 w150 h30 right, Manual Reload To Amount`n(set to 0 to disable)
;   Gui, Add, Text, x6 y170 w160 h30 right, Auto Reload (to max) Point`n(set to 0 to disable)
;   Gui, Add, Text, x16 y210 w150 h30 right, All In Auto ReBuy Amount`n(set to 0 to disable)

   Gui, Font, norm,





;   Gui, Add, Edit, x186 y95 w50 h20 vNLBuyin gSettingsSubmitVariables right, %NLBuyin%
   Gui, Add, Edit, x186 y135 w50 h20 vNLReloadAmount gSettingsSubmitVariables right, %NLReloadAmount%
;   Gui, Add, Edit, x186 y175 w50 h20 vNLReloadPoint gSettingsSubmitVariables right, %NLReloadPoint%
;   Gui, Add, Edit, x186 y215 w50 h20 vNLAllInAmount gSettingsSubmitVariables right, %NLAllInAmount%

;   Gui, Add, Text, x246 y98 w40 h20 , `% Max
   Gui, Add, Text, x246 y138 w40 h20 , `% Max
;   Gui, Add, Text, x246 y178 w40 h20 , `% Max
;   Gui, Add, Text, x290 y178 w200 h60 , <--|`n    |<-----  At least one of these must be 0`n    |              (see documentation)`n<--|
;   Gui, Add, Text, x246 y218 w40 h20 , `% Max

;   Gui, Add, Edit, x296 y95 w50 h20 vCapBuyin gSettingsSubmitVariables right, %CapBuyin%
   Gui, Add, Edit, x296 y135 w50 h20 vCapReloadAmount gSettingsSubmitVariables right, %CapReloadAmount%
;   Gui, Add, Text, x356 y98 w70 h20 , # Big Blinds
   Gui, Add, Text, x356 y138 w70 h20 , # Big Blinds
;   Gui, Add, Edit, x436 y95 w50 h20 vLimitBuyin gSettingsSubmitVariables right, %LimitBuyin%
   Gui, Add, Edit, x436 y135 w50 h20 vLimitReloadAmount gSettingsSubmitVariables right, %LimitReloadAmount%
;   Gui, Add, Text, x496 y98 w60 h20 , # Big Bets
   Gui, Add, Text, x496 y138 w60 h20 , # Big Bets



   Gui, Add, CheckBox, x40 y170 w400 h20 Checked%ManualReloadWhenGetChipsIsClicked% vManualReloadWhenGetChipsIsClicked gSettingsSubmitVariables cBlack, Perform a Manual Reload when Get Chips button is clicked (by user)
   Gui, Add, CheckBox, x40 y190 w400 h20 Checked%AssumeStackIs0WhenSittingOutEnabled% vAssumeStackIs0WhenSittingOutEnabled gSettingsSubmitVariables cBlack, For Manual Reloads, assume the stack = 0 if user is Sitting Out
   Gui, Add, Text, x40 y220 w540 h45, Manual Reload: reloads your stack TO this amount when you press one of the reload keys (see Actions2 tab).
   Gui, Add, Text, x16 y280 w650 h45 center, Full Tilt now has initial chip buy-in and auto-reload capability in their software. Go to the FT lobby...Options...Set Buy-In Preferences
*/



   Gui, Tab, Table1
   Gui, Font, bold,
   Gui, Add, Text, x10 y50 w720 h20 +Center cBlack, Table 1 Options - Key features to Highlight, Activate and Move tables with Pending Action
   Gui, Font, norm,

   ; put these at top so they get focus when user tabs to this tab
   Gui, Add, Text, x275 y70 w100 h20 , Color
   Gui, Add, Text, x315 y70 w100 h20 , Transparency
   Gui, Add, Text, x395 y70 w100 h20 , Size

   Gui, Add, CheckBox, x11 y90 w260 h20 Checked%ActiveTableHighlighterEnabled% vActiveTableHighlighterEnabled gSettingsSubmitVariables cBlack, Highlight the Active Table without Pending Action
   Gui, Add, Edit, x270 y90 w40 h20 vActiveTableHighlighterColor gSettingsSubmitVariables, %ActiveTableHighlighterColor%
   Gui, Add, Edit, x330 y100 w40 h20 vTableHighlighterTransperancy gSettingsSubmitVariables number, %TableHighlighterTransperancy%
   Gui, Add, Edit, x390 y100 w40 h20 vTableHighlighterSize gSettingsSubmitVariables, %TableHighlighterSize%

   Gui, Add, CheckBox, x11 y110 w260 h20 Checked%ActiveTableAndPendingHighlighterEnabled% vActiveTableAndPendingHighlighterEnabled gSettingsSubmitVariables cBlue, Highlight the Active Table with Pending Action
   Gui, Add, Edit, x270 y110 w40 h20 vActiveTableAndPendingHighlighterColor gSettingsSubmitVariables, %ActiveTableAndPendingHighlighterColor%

;   Gui, Add, CheckBox, x11 y130 w260 h20 Checked%PendingActionHighlighterEnabled% vPendingActionHighlighterEnabled gSettingsSubmitVariables cBlack, Highlight (non-active) Tables with Pending Action
;   Gui, Add, Edit, x270 y130 w40 h20 vPendingActionHighlighterColor gSettingsSubmitVariables, %PendingActionHighlighterColor%


   Gui, Add, Radio, x11 y160 w700 h20 Checked%TableAutoActivateDisabled% vTableAutoActivateDisabled gSettingsSubmitVariables cBlack, Do not Automatically Activate Tables (you then rely on what the poker client software does)
   Gui, Add, Radio, x11 y180 w700 h20 Checked%ActivateTableOnMouseOverEnabled% vActivateTableOnMouseOverEnabled gSettingsSubmitVariables cBlack, Auto-Activate the Table which the Mouse is Over (and you rely on the poker client software)
   Gui, Add, Radio, x11 y200 w700 h20 Checked%AutoActivateNextPendingTableEnabled% vAutoActivateNextPendingTableEnabled gSettingsSubmitVariables cBlue, Auto-Activate the next table with Pending Action (Recommended) (See documentation for required configuration details)
   Gui, Add, Checkbox, x41 y220 w300 h20 Checked%MoveTableEnabled% vMoveTableEnabled gSettingsSubmitVariables cBlack, Additionally, temporarily move this table to this position:
   Gui, Add, CheckBox, x41 y240 w650 h20 Checked%MouseToHomeEnabled% vMouseToHomeEnabled gSettingsSubmitVariables cBlue, Additionally, move mouse to it's home position (Recommended) (Set the mouse home position X,Y on the Setup tab.)
   Gui, Add, CheckBox, x41 y260 w650 h20 Checked%ActivateTableOnMouseOverIfMouseToHomeEnabled% vActivateTableOnMouseOverIfMouseToHomeEnabled gSettingsSubmitVariables cBlue, Additionally, Auto-Activate the Table the Mouse is Over (Recommended)

;   Gui, Add, Radio, x11 y220 w600 h20 Checked%PutImBackButtonTablesIntoPendingListEnabled% vPutImBackButtonTablesIntoPendingListEnabled gSettingsSubmitVariables cBlack, Activate the Next Table with Pending Action AND tournament tables with I'm Back Button Visible (use with Tiled Tables)
;   Gui, Add, Radio, x11 y240 w330 h20 Checked%AutoActivateTopTableEnabled% vAutoActivateTopTableEnabled gSettingsSubmitVariables cBlack, Automatically Activate Top Table (use with Cascaded Tables)

;   Gui, Add, Text, x485 y200 w90 h40 , Table`nHome X
;   Gui, Add, Text, x535 y200 w90 h40 , Table`nHome Y
;   Gui, Add, Text, x585 y200 w90 h40 , Table`nWidth
;   Gui, Add, Edit, x485 y230 w40 h20 vMoveTablePosX gSettingsSubmitVariables, %MoveTablePosX%
;   Gui, Add, Edit, x535 y230 w40 h20 vMoveTablePosY gSettingsSubmitVariables, %MoveTablePosY%
;   Gui, Add, Edit, x585 y230 w40 h20 vMoveTableWidth gSettingsSubmitVariables, %MoveTableWidth%

   Gui, Add, Text, x355 y224 w15 h20 ,X:
   Gui, Add, Text, x435 y224 w15 h20 ,Y:
   Gui, Add, Text, x515 y224 w15 h20 ,W:
   Gui, Add, Edit, x370 y220 w60 h20 vMoveTablePosX gSettingsSubmitVariables, %MoveTablePosX%
   Gui, Add, Edit, x450 y220 w60 h20 vMoveTablePosY gSettingsSubmitVariables, %MoveTablePosY%
   Gui, Add, Edit, x530 y220 w60 h20 vMoveTableWidth gSettingsSubmitVariables, %MoveTableWidth%



;   Gui, Add, CheckBox, x11 y160 w500 h20 Checked%AutoActivateNextPendingTableEnabled% vAutoActivateNextPendingTableEnabled gSettingsSubmitVariables cBlack, Automatically Activate the Next Table with Pending Action (use with Tiled Tables)
;   Gui, Add, CheckBox, x30 y180 w540 h20 Checked%PutImBackButtonTablesIntoPendingListEnabled% vPutImBackButtonTablesIntoPendingListEnabled gSettingsSubmitVariables cBlack, Also Activate/Highlight Tournament tables with I'm Back Button Visible
;   Gui, Add, CheckBox, x11 y210 w400 h20 Checked%utoActivateTopTableEnabled% vAutoActivateTopTableEnabled gSettingsSubmitVariables cBlack, Automatically Activate Top Table (use with Cascaded Tables)



;   Gui, Add, Text, x370 y255 w100 h40 , Full Tilt`nHome Position`nfor Mouse - X
;   Gui, Add, Text, x450 y255 w90 h40 , Full Tilt`nHome Position`nfor Mouse - Y
;   Gui, Add, Text, x530 y255 w100 h40 , Poker Stars`nHome Position`nfor Mouse - X
;   Gui, Add, Text, x610 y255 w90 h40 , Poker Stars`nHome Position`nfor Mouse - Y

;   Gui, Add, Edit, x370 y300 w60 h20 vFTMouseHomePosX gSettingsSubmitVariables, %FTMouseHomePosX%
;   Gui, Add, Edit, x450 y300 w60 h20 vFTMouseHomePosY gSettingsSubmitVariables, %FTMouseHomePosY%
;   Gui, Add, Edit, x530 y300 w60 h20 vPSMouseHomePosX gSettingsSubmitVariables, %PSMouseHomePosX%
;   Gui, Add, Edit, x610 y300 w60 h20 vPSMouseHomePosY gSettingsSubmitVariables, %PSMouseHomePosY%

   Gui, Add, Text, x11 y314 w700 h20 ,Temporary table positions: You can define 2 different table positions to move tables to (that you want to watch the action on)

   Gui, Add, Text, x355 y334 w15 h20 ,X:
   Gui, Add, Text, x435 y334 w15 h20 ,Y:
   Gui, Add, Text, x515 y334 w15 h20 ,W:
   Gui, Add, Edit, x11 y330 w60 h20 vManualMoveTableControl gSettingsSubmitVariables, %ManualMoveTableControl%
   Gui, Add, Text, x81 y334 w270 h20 , Keycode to move/return active table to this position:
   Gui, Add, Edit, x370 y330 w60 h20 vManualMoveTablePosX gSettingsSubmitVariables, %ManualMoveTablePosX%
   Gui, Add, Edit, x450 y330 w60 h20 vManualMoveTablePosY gSettingsSubmitVariables, %ManualMoveTablePosY%
   Gui, Add, Edit, x530 y330 w60 h20 vManualMoveTableWidth gSettingsSubmitVariables, %ManualMoveTableWidth%

   Gui, Add, Text, x355 y354 w15 h20 ,X:
   Gui, Add, Text, x435 y354 w15 h20 ,Y:
   Gui, Add, Text, x515 y354 w15 h20 ,W:
   Gui, Add, Edit, x11 y350 w60 h20 vManualMoveTable2Control gSettingsSubmitVariables, %ManualMoveTable2Control%
   Gui, Add, Text, x81 y354 w270 h20 , Keycode to move/return active table to this position:
   Gui, Add, Edit, x370 y350 w60 h20 vManualMoveTable2PosX gSettingsSubmitVariables, %ManualMoveTable2PosX%
   Gui, Add, Edit, x450 y350 w60 h20 vManualMoveTable2PosY gSettingsSubmitVariables, %ManualMoveTable2PosY%
   Gui, Add, Edit, x530 y350 w60 h20 vManualMoveTable2Width gSettingsSubmitVariables, %ManualMoveTable2Width%

   Gui, Tab, Table2
   Gui, Font, bold,
   Gui, Add, Text, x10 y50 w720 h20 +Center cBlack, Table 2 Options - Automatic resizing of the tables
   Gui, Font, norm,
   Gui, Add, Text, x200 y163 w320 h160 cBlack, %Msg9%
   Gui, Add, Text, x20 y163 w60 h20 Right, Table Size
   DropList := "None|A|B|C|D|E|F"
   Pos := ListGetPos(DropList,TableSize,"|")
   Gui, Add, DropDownList, x100 y160 w50 h21 vTableSize gSettingsSubmitVariables R7 Choose%Pos%, %DropList%

   Gui, Add, Text, x20 y193 w60 h20 Right, Table A
   Gui, Add, Edit, x100 y190 w50 h20 vTableWidthA gSettingsSubmitVariables, %TableWidthA%
   Gui, Add, Text, x20 y213 w60 h20 Right, Table B
   Gui, Add, Edit, x100 y210 w50 h20 vTableWidthB gSettingsSubmitVariables, %TableWidthB%
   Gui, Add, Text, x20 y233 w60 h20 Right, Table C
   Gui, Add, Edit, x100 y230 w50 h20 vTableWidthC gSettingsSubmitVariables, %TableWidthC%
   Gui, Add, Text, x20 y253 w60 h20 Right, Table D
   Gui, Add, Edit, x100 y250 w50 h20 vTableWidthD gSettingsSubmitVariables, %TableWidthD%
   Gui, Add, Text, x20 y273 w60 h20 Right, Table E
   Gui, Add, Edit, x100 y270 w50 h20 vTableWidthE gSettingsSubmitVariables, %TableWidthE%
   Gui, Add, Text, x20 y293 w60 h20 Right, Table F
   Gui, Add, Edit, x100 y290 w50 h20 vTableWidthF gSettingsSubmitVariables, %TableWidthF%



   Gui, Tab, Dialogs
   Gui, Font, bold,
   Gui, Add, Text, x10 y50 w750 h30 +Center cBlack, Dialog Boxes`n(Automatically close dialog boxes that continually pop up)
   Gui, Font, norm,
   
   Gui, Add, CheckBox, x16 y80 w350 h20 Checked%CloseOneButtonStarsDialogsEnabled% vCloseOneButtonStarsDialogsEnabled gSettingsSubmitVariables cBlack, Close MOST Poker Stars Dialog Boxes with only "OK" button (PS)
   Gui, Add, CheckBox, x16 y100 w350 h20 Checked%CloseOneButtonFullTiltDialogsEnabled% vCloseOneButtonFullTiltDialogsEnabled gSettingsSubmitVariables cBlack, Close MOST Full Tilt Dialog Boxes with only "OK" button (FT)

   Gui, Add, CheckBox, x16 y120 w270 h20 Checked%AutoLogInEnabled% vAutoLogInEnabled gSettingsSubmitVariables cBlack, Login and Close "Log In" Dialog Box (FT,PS)
   Gui, Add, CheckBox, x16 y140 w300 h20 Checked%DenyReLoginAttemptedEnabled% vDenyReLoginAttemptedEnabled gSettingsSubmitVariables cBlack, Deny and Close "Re-Login Attemted" Dialog Box (FT)

   Gui, Add, CheckBox, x16 y160 w270 h20 Checked%CloseAnnouncementsDialogEnabled% vCloseAnnouncementsDialogEnabled gSettingsSubmitVariables cBlack, Close "Announcements/News" Dialog Box (FT,PS)
   Gui, Add, CheckBox, x16 y180 w290 h20 Checked%CloseFoldCallDialogEnabled% vCloseFoldCallDialogEnabled gSettingsSubmitVariables cBlack, Auto-Click "Check" on the Fold/Check Dialog Box (PS)
;   Gui, Add, CheckBox, x16 y160 w270 h20 Checked%CloseRemovedFromWaitingListDialogEnabled% vCloseRemovedFromWaitingListDialogEnabled gSettingsSubmitVariables cBlack, Close "Removed From Waiting List" Dialog Box (F)

;   Gui, Add, CheckBox, x16 y190 w260 h20 Checked%BeepIfSeatAvailableEnabled% vBeepIfSeatAvailableEnabled gSettingsSubmitVariables cBlack, Play Sound If "Seat Available" Dialog Box Appears
;   Gui, Add, Text, x46 y213 w110 h40 , Sound File:
;   Gui, Add, Edit, x106 y210 w100 h20 vTableAvailableWaveFile gSettingsSubmitVariables, %TableAvailableWaveFile%
;   Gui, Add, Button, x220 y210 w40 h20 gPlaySound, Play

   Gui, Add, CheckBox, x16 y200 w320 h20 Checked%RejectSeatIfSeatAvailableEnabled% vRejectSeatIfSeatAvailableEnabled gSettingsSubmitVariables cBlack, Click on "NO" If "Seat Available" Dialog Box Appears (FT,PS)
   Gui, Add, Text, x156 y223 w250 h40 , Key to Toggle above checkbox:
   Gui, Add, Edit, x46 y220 w100 h20 vRejectSeatControl gSettingsUpdateHotkeys, %RejectSeatControl%
   Gui, Add, CheckBox, x16 y240 w350 h20 Checked%TakeSeatIfSeatAvailableEnabled% vTakeSeatIfSeatAvailableEnabled gSettingsSubmitVariables cBlack, Click on "YES" If "Seat Available" Dialog Box Appears (FT,PS,D)
   Gui, Add, CheckBox, x16 y260 w350 h20 Checked%PopSeatAvailDialogToTopEnabled% vPopSeatAvailDialogToTopEnabled gSettingsSubmitVariables cBlack, Automatically move the Seat Available dialog box to the forefront (FT)
   Gui, Add, CheckBox, x16 y280 w270 h20 Checked%CloseAutoPostBlindsDialogEnabled% vCloseAutoPostBlindsDialogEnabled gSettingsSubmitVariables cBlack, Close "Auto-Post Blinds" Dialog Box (FT)
   Gui, Add, CheckBox, x16 y300 w270 h20 Checked%CloseLeaveTableDialogEnabled% vCloseLeaveTableDialogEnabled gSettingsSubmitVariables cBlack, Close "Leave Table" Dialog Box (FT,PS)
   Gui, Add, CheckBox, x16 y320 w270 h20 Checked%CloseLeaveSeatDialogEnabled% vCloseLeaveSeatDialogEnabled gSettingsSubmitVariables cBlack, Close "Leave Seat" Dialog Box (FT)
   Gui, Add, CheckBox, x16 y340 w270 h20 Checked%CloseEducationalTableDialogEnabled% vCloseEducationalTableDialogEnabled gSettingsSubmitVariables cBlack, Close "Educational Table" Dialog Box (FT)
   Gui, Add, CheckBox, x16 y360 w270 h20 Checked%CloseTableHasBeenClosedEnabled% vCloseTableHasBeenClosedEnabled gSettingsSubmitVariables cBlack, Close "Table has been closed" Dialog Box (PS)

;   Gui, Add, CheckBox, x386 y100 w350 h20 Checked%CloseWereSorryRegClosedDialogEnabled% vCloseWereSorryRegClosedDialogEnabled gSettingsSubmitVariables cBlack, Close "Registration for this tournament closed" Dialog Box (F)

Gui, Add, CheckBox, x386 y120 w280 h20 Checked%CloseYouFinishedTheTournamentDialogEnabled% vCloseYouFinishedTheTournamentDialogEnabled gSettingsSubmitVariables cBlack, Close "You Finished the Tournament" Dialog Box (FT)
Gui, Add, Edit, x426 y140 w30 h20 vCloseDialogDelay gSettingsSubmitVariables number center, %CloseDialogDelay%
Gui, Add, Text, x466 y143 w250 h20, second delay before closing this dialog box (FT)
;Gui, Add, CheckBox, x56 y275 w330 h30 Checked%CheckCloseCompletedTournamentEnabled% vCheckCloseCompletedTournamentEnabled gSettingsSubmitVariables cBlack, Also Check the "Close Completed Tournament" checkBox (F)`n(which will close the finished Sng table)

   Gui, Add, CheckBox, x386 y160 w350 h20 Checked%AutoClickOkOnGetChipsDialogEnabled% vAutoClickOkOnGetChipsDialogEnabled gSettingsSubmitVariables cBlack, Auto-Click on "OK" in the Get Chips dialog box (FT, PS).

;   Gui, Add, CheckBox, x386 y180 w280 h20 Checked%CloseTooManyWindowsOpenDialogEnabled% vCloseTooManyWindowsOpenDialogEnabled gSettingsSubmitVariables cBlack, Close "Too Many Windows Open" Dialog Box (F)
;   Gui, Add, CheckBox, x386 y200 w280 h20 Checked%CloseYouCannotRegisterMoreTrnysDialogEnabled% vCloseYouCannotRegisterMoreTrnysDialogEnabled gSettingsSubmitVariables cBlack, Close "Cannot Register More Trnys" Dialog Box (F)



;   Gui, Add, CheckBox, x386 y260 w280 h40 Checked%CloseDialogBoxesUsingImageRecogEnabled% vCloseDialogBoxesUsingImageRecogEnabled gSettingsSubmitVariables cBlack, * Close These Dialog Boxes using Image Recognition`n(leave unchecked unless you have problems closing dialog boxes)
   Gui, Add, Text, x386 y300 w280 h20, FT = Full Tilt
   Gui, Add, Text, x386 y320 w280 h20, PS = Poker Stars
   Gui, Add, Text, x386 y340 w280 h20, D = See Documentation for special considerations
   
   
   
   
   Gui, Tab, Misc
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w550 h20 center, Miscellaneous Settings
   Gui, Font, norm,


   Gui, Add, CheckBox, x16 y100 w150 h20 cBlue Checked%AutoClickTimerIfBetBoxEnabled% vAutoClickTimerIfBetBoxEnabled gSettingsSubmitVariables, Auto-Click the Time Button
   Gui, Add, Edit, x165 y100 w30 h20 vTimeButtonIfPendingActionWaitTime gSettingsSubmitVariables number center, %TimeButtonIfPendingActionWaitTime%
   Gui, Add, Text, x200 y103 w510 h20 cBlue , seconds after the betting box appears (PS only) or the lower right corner of the Raise button appears (FT,PS)
   Gui, Add, Text, x46 y123 w500 h30,  Note: This is useful for cascaded tables, but the lower right corner of the Raise button must be visible on each table. 10 seconds recommended.

   Gui, Add, CheckBox, x16 y160 w150 h20 cBlue Checked%AutoClickTimerEnabled% vAutoClickTimerEnabled gSettingsSubmitVariables, Auto-Click the Time Button
   Gui, Add, Edit, x165 y160 w30 h20 vTimeButtonWaitTime gSettingsSubmitVariables number center, %TimeButtonWaitTime%
   Gui, Add, Text, x200 y163 w160 h20 cBlue , seconds after it appears (FT,PS)
   Gui, Add, Text, x46 y183 w380 h30, The time button must be fully visible on every table for this feature to work (e.g. not stacked tables). 5 secs or less recommended.
   
;   Gui, Add, Edit, x55 y170 w30 h20 vCloseTableTimeDelay gSettingsSubmitVariables number center, %CloseTableTimeDelay%
;   Gui, Add, Text, x90 y173 w200 h20, second delay before closing each table
   Gui, Add, CheckBox, x16 y210 w320 h20 Checked%MinimizeShortcutsEnabled% vMinimizeShortcutsEnabled gSettingsSubmitVariables cBlack, Minimize Poker Shortcuts at startup
   Gui, Add, CheckBox, x16 y230 w620 h20 Checked%UseMouseMovementToClickButtonsEnabled% vUseMouseMovementToClickButtonsEnabled gSettingsSubmitVariables cBlack, Use Mouse Movement method to click buttons on Full Tilt (check this unless you see mouse movement flicker)
   
   Gui, Add, Text, x16 y263 w250 h20, Enable Joystick Number (0 to disable Joysticks):
   DropList := "0|1|2|3|4|5|6|7|8|9"
   Pos := ListGetPos(DropList,JoyNum,"|")
   Gui, Add, DropDownList, x250 y260 w40 h21 vJoyNum gSettingsSubmitVariables R10 Choose%Pos%, %DropList%
   Gui, Add, CheckBox, x16 y280 w280 h20 Checked%ShowJoystickValueEnabled% vShowJoystickValueEnabled gSettingsSubmitVariables cBlack, Show Joystick values here (disable this when finished)
   Gui, Add, Edit, x296 y280 w70 h20 vJoystickValue center, %JoystickValue%

   Gui, Add, Text, x16 y320 w400 h20, List of keys/buttons that will temporarily disable many features (See Documentation)
   Gui, Add, Edit, x36 y340 w330 h20 vKeyListToDisableShortcuts gSettingsSubmitVariables center, %KeyListToDisableShortcuts%

;   Gui, Add, Text, x36 y150 w320 h50 cRed, The above is an Experimental feature - use with Caution!!!`nIn previous versions it would sometimes close a table too.`nIt is now being tested to see if it works correctly.


   
   
;   Gui, Add, Text, x430 y188 w140 h30, Safety Delay 1`n(See Documentation)
;   Gui, Add, Edit, x550 y190 w40 h20 vSafetyDelay5 gSettingsSubmitVariables number, %SafetyDelay5%
;   Gui, Add, Text, x430 y218 w140 h30 , Safety Delay 2`n(See Documentation)
;   Gui, Add, Edit, x550 y220 w40 h20 vSafetyDelay6 gSettingsSubmitVariables number, %SafetyDelay6%

   Gui, Add, Text, x425 y255 w200 h20 right, Select Process Priority for Shortcuts
   Gui, Add, Text, x425 y275 w200 h20 right, Select Process Priority for Full Tilt
   Gui, Add, Text, x425 y295 w200 h20 right, Select Process Priority for Poker Stars
   DropList := "NoChange|Realtime|High|AboveNormal|Normal|BelowNormal|Low"
   Pos := ListGetPos(DropList,ShortcutsProcessPriority,"|")
   Gui, Add, DropDownList, x630 y250 w100 h21 vShortcutsProcessPriority gSettingsSubmitVariables R7 Choose%Pos%, %DropList%
   Pos := ListGetPos(DropList,FullTiltProcessPriority,"|")
   Gui, Add, DropDownList, x630 y270 w100 h21 vFullTiltProcessPriority gSettingsSubmitVariables R7 Choose%Pos%, %DropList%
   Pos := ListGetPos(DropList,PokerStarsProcessPriority,"|")
   Gui, Add, DropDownList, x630 y290 w100 h21 vPokerStarsProcessPriority gSettingsSubmitVariables R7 Choose%Pos%, %DropList%

;   Gui, Add, Text, x16 y305 w720 h20 cGreen, ** The "Sit Out Next Hand" checkbox and the "S" next to it must be visible (not overlapped) on all tables for this feature to work correctly.

   Gui, Tab, Calib
   Gui, Font, bold,
   Gui, Add, Text, x10 y50 w740 h30 center, Calibrate Poker Shortcuts to your Table Colors`n(This MUST be done anytime you change the colors used on your table)
   Gui, Font, norm,
   
   Gui, Add, Text, x370 y80 w330 h60 cBlack, %Msg17%
   Gui, Add, Text, x10 y93 w180 h20 right cBlack, Current Poker Stars Table Theme:
   Gui, Add, Edit, x200 y90 w150 h20 vPSTableTheme1 ReadOnly, %PSTableTheme%
   Gui, Add, Text, x10 y113 w180 h20 right cBlack, Current Full Tilt Table Theme:
   Gui, Add, Edit, x200 y110 w150 h20 vFTTableTheme1 ReadOnly, %FTTableTheme%

   Gui, Font, bold,
   Gui, Add, Text, x10 y140 w740 h20 center  cBlack, Calibrate Table Felt Colors (this must be done in order for the Street Bets to work properly)
   Gui, Font, norm,
   Gui, Add, Text, x200 y160 w25 h20 , Flop
   Gui, Add, Text, x240 y160 w25 h20 , Turn
   Gui, Add, Text, x280 y160 w25 h20 , River
   Gui, Add, Text, x320 y160 w25 h20 , Mid
   Gui, Add, Button, x10 y180 w180 h20 gPSColorSampleStreets, Calibrate Felt Colors - Poker Stars
   Gui, Add, Progress, x200 y180 w20 h20 cGreen background%PSFlopColor% vPSFlopColorDisplay
   Gui, Add, Progress, x240 y180 w20 h20 cGreen background%PSTurnColor% vPSTurnColorDisplay
   Gui, Add, Progress, x280 y180 w20 h20 cGreen background%PSRiverColor% vPSRiverColorDisplay
   Gui, Add, Progress, x320 y180 w20 h20 cGreen background%PSTestColor% vPSTestColorDisplay
   
   Gui, Add, Button, x10 y210 w180 h20 gFTColorSampleStreets, Calibrate Felt Colors - Full Tilt
   Gui, Add, Progress, x200 y210 w20 h20 cGreen background%FTFlopColor% vFTFlopColorDisplay
   Gui, Add, Progress, x240 y210 w20 h20 cGreen background%FTTurnColor% vFTTurnColorDisplay
   Gui, Add, Progress, x280 y210 w20 h20 cGreen background%FTRiverColor% vFTRiverColorDisplay
   Gui, Add, Progress, x320 y210 w20 h20 cGreen background%FTTestColor% vFTTestColorDisplay

   Gui, Add, Text, x370 y160 w330 h100 , %Msg7%


   Gui, Font, bold,
   Gui, Add, Text, x10 y255 w740 h20 center cBlack, Calibrate Empty Seat Colors (Full Tilt Only - this is needed to count the # seats and players at the table)
   Gui, Font, norm,
   
   Gui, Add, Text, x10 y275 w180 h20 right, Empty Seat Number
   Gui, Add, Text, x200 y275 w20 h20 center,1
   Gui, Add, Text, x220 y275 w20 h20 center,2
   Gui, Add, Text, x240 y275 w20 h20 center,3
   Gui, Add, Text, x260 y275 w20 h20 center,4
   Gui, Add, Text, x280 y275 w20 h20 center,5
   Gui, Add, Text, x300 y275 w20 h20 center,6
   Gui, Add, Text, x320 y275 w20 h20 center,7
   Gui, Add, Text, x340 y275 w20 h20 center,8
   Gui, Add, Text, x360 y275 w20 h20 center,9
                        
   Gui, Add, Button, x10 y290 w180 h20 gFTColorSample9m, Calibrate 9 seat table - Full Tilt
   Gui, Add, Button, x10 y310 w180 h20 gFTColorSample8m, Calibrate 8 seat table - Full Tilt
   Gui, Add, Button, x10 y330 w180 h20 gFTColorSample6m, Calibrate 6 seat table - Full Tilt
   Gui, Add, Button, x10 y350 w180 h20 gFTColorSample2m, Calibrate 2 seat table - Full Tilt

   Gui, Add, Progress, x200 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat1% vFTPlayerEmptySeatColorSeats9Seat1Display,
   Gui, Add, Progress, x220 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat2% vFTPlayerEmptySeatColorSeats9Seat2Display,
   Gui, Add, Progress, x240 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat3% vFTPlayerEmptySeatColorSeats9Seat3Display,
   Gui, Add, Progress, x260 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat4% vFTPlayerEmptySeatColorSeats9Seat4Display,
   Gui, Add, Progress, x280 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat5% vFTPlayerEmptySeatColorSeats9Seat5Display,
   Gui, Add, Progress, x300 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat6% vFTPlayerEmptySeatColorSeats9Seat6Display,
   Gui, Add, Progress, x320 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat7% vFTPlayerEmptySeatColorSeats9Seat7Display,
   Gui, Add, Progress, x340 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat8% vFTPlayerEmptySeatColorSeats9Seat8Display,
   Gui, Add, Progress, x360 y290 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats9Seat9% vFTPlayerEmptySeatColorSeats9Seat9Display,

   Gui, Add, Progress, x200 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat1% vFTPlayerEmptySeatColorSeats8Seat1Display,
   Gui, Add, Progress, x220 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat2% vFTPlayerEmptySeatColorSeats8Seat2Display,
   Gui, Add, Progress, x240 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat3% vFTPlayerEmptySeatColorSeats8Seat3Display,
   Gui, Add, Progress, x260 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat4% vFTPlayerEmptySeatColorSeats8Seat4Display,
   Gui, Add, Progress, x280 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat5% vFTPlayerEmptySeatColorSeats8Seat5Display,
   Gui, Add, Progress, x300 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat6% vFTPlayerEmptySeatColorSeats8Seat6Display,
   Gui, Add, Progress, x320 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat7% vFTPlayerEmptySeatColorSeats8Seat7Display,
   Gui, Add, Progress, x340 y310 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats8Seat8% vFTPlayerEmptySeatColorSeats8Seat8Display,

   Gui, Add, Progress, x200 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat1% vFTPlayerEmptySeatColorSeats6Seat1Display,
   Gui, Add, Progress, x220 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat2% vFTPlayerEmptySeatColorSeats6Seat2Display,
   Gui, Add, Progress, x240 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat3% vFTPlayerEmptySeatColorSeats6Seat3Display,
   Gui, Add, Progress, x260 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat4% vFTPlayerEmptySeatColorSeats6Seat4Display,
   Gui, Add, Progress, x280 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat5% vFTPlayerEmptySeatColorSeats6Seat5Display,
   Gui, Add, Progress, x300 y330 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats6Seat6% vFTPlayerEmptySeatColorSeats6Seat6Display,

   Gui, Add, Progress, x200 y350 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats2Seat1% vFTPlayerEmptySeatColorSeats2Seat1Display,
   Gui, Add, Progress, x220 y350 w20 h20 cGreen background%FTPlayerEmptySeatColorSeats2Seat2% vFTPlayerEmptySeatColorSeats2Seat2Display,

   Gui, Add, Text, x400 y275 w350 h110, %Msg8%


   Gui, Tab, Setup
   Gui, Font, bold,
   Gui, Add, Text, x6 y50 w740 h20 +Center cBlack, Main Setup - Settings Bank, Lobby and Table Themes, and Folder Locations
   Gui, Font, norm,

   ; leave this one first, so that the auto focus does not go to the current settings box
   ;Gui, Add, Text, x530 y68 w120 h30 Right, Code Type`n(leave at "1")
   ;Gui, Add, Edit, x660 y70 w40 h20 number vCodeType gSettingsSubmitVariables , %CodeType%

   ; leave this one first, so that the auto focus does not go to the current settings box
   Gui, Add, Edit, x255 y70 w150 h20 vCurrentSetDescription  gSettingsSubmitVariables,  %CurrentSetDescription%
   Gui, Add, Text, x26 y75 w120 h20, Current Settings Bank:
   DropList := "1|2|3|4|5|6|7|8|9"
   Pos := ListGetPos(DropList,ChangeToNewCurrentSetNum,"|")
   Gui, Add, DropDownList, x140 y70 w40 h21 vChangeToNewCurrentSetNum gSettingsUpdateCurrentSetNum R9 Choose%Pos%, %DropList%
   Gui, Add, Text, x190 y68 w60 h30 Center, Bank Description:

   Gui, Add, Button, x96 y100 w200 h20 gSettingsCopy, Copy Current Settings to Bank #  --->

   ; ****************  NO LIST ON THIS ONE  ***************************
   Gui, Add, DropDownList, x300 y100 w40 h21 vCopyToSetNum R9 , 1|2||3|4|5|6|7|8|9
   
   
   Gui, Add, Text, x430 y70 w320 h30 cRed, Note: The settings on this tab are critical to the proper operation of the software. See the web documentation for setup details.
   
   
   Gui, Font, bold,
   Gui, Add, Text, x10 y140 w100 h20 Right, Casino Setup:
   Gui, Add, Text, x120 y140 w150 h20 Center, Full Tilt
   Gui, Add, Text, x330 y140 w150 h20 Center, Poker Stars
   Gui, Font, norm,


   ; first column
   Gui, Add, Text, x10 y164 w100 h20 Right, Lobby Theme
   Gui, Add, Text, x10 y184 w100 h20 Right, Table Theme
   Gui, Add, Text, x10 y204 w100 h20 Right, Mouse Home (XY)
   Gui, Add, Text, x10 y224 w100 h20 Right, OSD 1 POS (XY)
   Gui, Add, Text, x10 y244 w100 h20 Right, OSD 3 POS (XY)
   Gui, Add, Text, x10 y264 w100 h20 Right, OSD 4 POS (XY)
   Gui, Add, Text, x10 y284 w100 h20 Right, OSD 5 POS (XY)
   ; 2nd column
   Droplist := FTLobbyThemeList
   Pos := ListGetPos(DropList,FTLobbyTheme,"|")
   Gui, Add, DropDownList, x130 y160 w210 h20 vFTLobbyTheme gSettingsSubmitVariables R5 Choose%Pos%, %FTLobbyThemeList%
   Droplist := FTTableThemeList
   Pos := ListGetPos(DropList,FTTableTheme,"|")
   Gui, Add, DropDownList, x130 y180 w210 h20 vFTTableTheme gSettingsSubmitVariables R5 Choose%Pos%, %FTTableThemeList%
   Gui, Add, Edit, x130 y200 w50 h20 vFTMouseHomePosX gSettingsSubmitVariables, %FTMouseHomePosX%
   Gui, Add, Edit, x190 y200 w50 h20 vFTMouseHomePosY gSettingsSubmitVariables, %FTMouseHomePosY%

   Gui, Add, Edit, x130 y220 w50 h20 vFTOsdBettingInfoPosX gSettingsSubmitVariables, %FTOsdBettingInfoPosX%
   Gui, Add, Edit, x190 y220 w50 h20 vFTOsdBettingInfoPosY gSettingsSubmitVariables, %FTOsdBettingInfoPosY%
   Gui, Add, Edit, x130 y240 w50 h20 vFTDisplayOsd3PosX gSettingsSubmitVariables, %FTDisplayOsd3PosX%
   Gui, Add, Edit, x190 y240 w50 h20 vFTDisplayOsd3PosY gSettingsSubmitVariables, %FTDisplayOsd3PosY%
   Gui, Add, Edit, x130 y260 w50 h20 vFTDisplayOsd4PosX gSettingsSubmitVariables, %FTDisplayOsd4PosX%
   Gui, Add, Edit, x190 y260 w50 h20 vFTDisplayOsd4PosY gSettingsSubmitVariables, %FTDisplayOsd4PosY%
   Gui, Add, Edit, x130 y280 w50 h20 vFTDisplayOsd5PosX gSettingsSubmitVariables, %FTDisplayOsd5PosX%
   Gui, Add, Edit, x190 y280 w50 h20 vFTDisplayOsd5PosY gSettingsSubmitVariables, %FTDisplayOsd5PosY%
   
   ; 3rd column
   Droplist := PSLobbyThemeList
   Pos := ListGetPos(DropList,PSLobbyTheme,"|")
   Gui, Add, DropDownList, x360 y160 w210 h20 vPSLobbyTheme gSettingsSubmitVariables R5 Choose%Pos%, %PSLobbyThemeList%
   Droplist := PSTableThemeList
   Pos := ListGetPos(DropList,PSTableTheme,"|")
   Gui, Add, DropDownList, x360 y180 w210 h20 vPSTableTheme gSettingsSubmitVariables R5 Choose%Pos%, %PSTableThemeList%
   Gui, Add, Edit, x360 y200 w50 h20 vPSMouseHomePosX gSettingsSubmitVariables, %PSMouseHomePosX%
   Gui, Add, Edit, x420 y200 w50 h20 vPSMouseHomePosY gSettingsSubmitVariables, %PSMouseHomePosY%

   Gui, Add, Edit, x360 y220 w50 h20 vPSOsdBettingInfoPosX gSettingsSubmitVariables, %PSOsdBettingInfoPosX%
   Gui, Add, Edit, x420 y220 w50 h20 vPSOsdBettingInfoPosY gSettingsSubmitVariables, %PSOsdBettingInfoPosY%
   Gui, Add, Edit, x360 y240 w50 h20 vPSDisplayOsd3PosX gSettingsSubmitVariables, %PSDisplayOsd3PosX%
   Gui, Add, Edit, x420 y240 w50 h20 vPSDisplayOsd3PosY gSettingsSubmitVariables, %PSDisplayOsd3PosY%
   Gui, Add, Edit, x360 y260 w50 h20 vPSDisplayOsd4PosX gSettingsSubmitVariables, %PSDisplayOsd4PosX%
   Gui, Add, Edit, x420 y260 w50 h20 vPSDisplayOsd4PosY gSettingsSubmitVariables, %PSDisplayOsd4PosY%
   Gui, Add, Edit, x360 y280 w50 h20 vPSDisplayOsd5PosX gSettingsSubmitVariables, %PSDisplayOsd5PosX%
   Gui, Add, Edit, x420 y280 w50 h20 vPSDisplayOsd5PosY gSettingsSubmitVariables, %PSDisplayOsd5PosY%


   Gui, Add, Text, x10 y305 w120 h20 Center, Select Folder Location
   Gui, Add, Text, x140 y305 w150 h20 Center, Folder Location
   Gui, Add, Button, x5 y320 w150 h20 gSelectPSSettingsFolder vSelectPSSettingsFolderButton center, Poker Stars Settings Folder
   Gui, Add, Edit, x160 y320 w270 h20 vPSSettingsFolder gSettingsSubmitVariables, %PSSettingsFolder%
   Gui, Add, Button, x5 y340 w150 h20 gSelectPSHHFolder vSelectPSHHButton center, Poker Stars HH Folder
   Gui, Add, Edit, x160 y340 w520 h20 vPSHHFolder gSettingsSubmitVariables, %PSHHFolder%
   Gui, Add, Button, x5 y360 w150 h20 gSelectFTHHFolder vSelectFTHHFolderButton center, Full Tilt HH Folder
   Gui, Add, Edit, x160 y360 w520 h20 vFTHHFolder gSettingsSubmitVariables, %FTHHFolder%

   Gui, Add, Button, x450 y310 w300 h20 gModifyPSUserFile vModifyPSUserFileButton center, Modify Poker Stars User.ini file (Exit Poker Stars FIRST)






}



















; *******************************************************************************
; -------------------------------------------------------------------------------
; Settings Functions
; -------------------------------------------------------------------------------
; *******************************************************************************

; the user has changed the current set num...  read the new settings and update the variables
SettingsUpdateCurrentSetNum:
   SettingsUpdateCurrentSetNum()
Return

SettingsUpdateCurrentSetNum()
{
   global

   ; Copy GUI selections to variables
   Gui, 99:Default
   GUI, Submit, NoHide

;outputdebug, in SettingsUpdate()   ChangeToNewCurrentSetNum= %ChangeToNewCurrentSetNum%     CurrentSetNum= %CurrentSetNum%


   ; if the user didn't really change to a new set num
   if (ChangeToNewCurrentSetNum == CurrentSetNum)
      return

   ; save the current settings in case they weren't saved before we change them
   SettingsWrite(CurrentSetNum)

   ; set the new CurrentSetNum, that the user selected
   CurrentSetNum := ChangeToNewCurrentSetNum

;outputdebug, in SettingsUpdateCurrentSetNum()   CurrentSetNum= %CurrentSetNum%


   ; read in the main settings for this new batch of settings
   SettingsRead(CurrentSetNum)
   
   ; the theme valuse are done in the  SettingsUpdateDependentVariables("All")   function below
   ; read in the theme variables, since we might have a new theme in this SetNum
   ; NOTE: we call this here, to get the PSSngFileList which is needed in the next function   SettingsWriteToGui()
   ;     even though the themes are read again in the function   SettingsUpdateDependentVariables("All")   below
   IniReadAllThemes()

   
   ; write the settings to the GUI
   SettingsWriteToGui()
   
   ; update the hotkeys to the new settings
   SettingsUpdateHotkeys(-1)
   
   ; update the dependent items, which also reads in the THEME.ini files in case there has been a theme change
   ; this also updates things like the Joystick timer and the System priorities
   SettingsUpdateDependentVariables("All")
}








; copy the current settings to [Section]CopyToSetNum
SettingsCopy:
   SettingsCopy(CopyToSetNum)
Return

SettingsCopy(pCopyToSetNum)
{
   ; save the current settings, incase they haven't been saved yet
   ; write the current settings
   SettingsWrite(pCopyToSetNum)
}


; read the settings for the desired setting number 1-9
; if the setting number is 0, then read the settings from the OLD group called Prefs
SettingsRead(SettingNum)
{
   global
   local SectionLabel

   ; if settingnum is 1-9
   if SettingNum
   {
      SectionLabel := "Section" . SettingNum
   }
   ; else if it is 0
   else
   {
      SectionLabel := "Prefs"
   }





   ; Setup Tab
   IniRead, CurrentSetDescription, Settings\PokerShortcuts.ini, %SectionLabel%, CurrentSetDescription, My Description
;   IniRead, CodeType, Settings\PokerShortcuts.ini, %SectionLabel%, CodeType, 1

   IniRead, FTLobbyTheme, Settings\PokerShortcuts.ini, %SectionLabel%, FTLobbyTheme, FTLobbyClassic
   IniRead, FTTableTheme, Settings\PokerShortcuts.ini, %SectionLabel%, FTTableTheme, FTTableClassic
   IniRead, FTMouseHomePosX, Settings\PokerShortcuts.ini, %SectionLabel%, FTMouseHomePosX, 545          ; over fold button is 545
   IniRead, FTMouseHomePosY, Settings\PokerShortcuts.ini, %SectionLabel%, FTMouseHomePosY, 505          ; over fold button is 505
   IniRead, FTOsdBettingInfoPosX, Settings\PokerShortcuts.ini, %SectionLabel%, FTOsdBettingInfoPosX, 461
   IniRead, FTOsdBettingInfoPosY, Settings\PokerShortcuts.ini, %SectionLabel%, FTOsdBettingInfoPosY, 425
   IniRead, FTDisplayOsd3PosX, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd3PosX, 240
   IniRead, FTDisplayOsd3PosY, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd3PosY, 1
   IniRead, FTDisplayOsd4PosX, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd4PosX, 550
   IniRead, FTDisplayOsd4PosY, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd4PosY, 1
   IniRead, FTDisplayOsd5PosX, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd5PosX, 10
   IniRead, FTDisplayOsd5PosY, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd5PosY, 60
   
   IniRead, PSLobbyTheme, Settings\PokerShortcuts.ini, %SectionLabel%, PSLobbyTheme, PSLobbyBlack
   IniRead, PSTableTheme, Settings\PokerShortcuts.ini, %SectionLabel%, PSTableTheme, PSTableHyperSimple
   IniRead, PSMouseHomePosX, Settings\PokerShortcuts.ini, %SectionLabel%, PSMouseHomePosX, 545          ; over fold button is 545
   IniRead, PSMouseHomePosY, Settings\PokerShortcuts.ini, %SectionLabel%, PSMouseHomePosY, 505          ; over fold button is 505
   IniRead, PSOsdBettingInfoPosX, Settings\PokerShortcuts.ini, %SectionLabel%, PSOsdBettingInfoPosX, 461
   IniRead, PSOsdBettingInfoPosY, Settings\PokerShortcuts.ini, %SectionLabel%, PSOsdBettingInfoPosY, 425
   IniRead, PSDisplayOsd3PosX, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd3PosX, 240
   IniRead, PSDisplayOsd3PosY, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd3PosY, 1
   IniRead, PSDisplayOsd4PosX, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd4PosX, 550
   IniRead, PSDisplayOsd4PosY, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd4PosY, 1
   IniRead, PSDisplayOsd5PosX, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd5PosX, 10
   IniRead, PSDisplayOsd5PosY, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd5PosY, 60


   ; Misc tab



   IniRead, AutoClickTimerEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickTimerEnabled, 0
   IniRead, TimeButtonWaitTime, Settings\PokerShortcuts.ini, %SectionLabel%, TimeButtonWaitTime, 5
   IniRead, AutoClickTimerIfBetBoxEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickTimerIfBetBoxEnabled, 0
   IniRead, TimeButtonIfPendingActionWaitTime, Settings\PokerShortcuts.ini, %SectionLabel%, TimeButtonIfPendingActionWaitTime, 15



   IniRead, MinimizeShortcutsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, MinimizeShortcutsEnabled, 0
   IniRead, UseMouseMovementToClickButtonsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, UseMouseMovementToClickButtonsEnabled, 1   
   
   
   IniRead, JoyNum, Settings\PokerShortcuts.ini, %SectionLabel%, JoyNum, 0
   
   IniRead, KeyListToDisableShortcuts, Settings\PokerShortcuts.ini, %SectionLabel%, KeyListToDisableShortcuts,LButton,RButton,Shift,Alt,Ctrl,LWin
   
   
   ; on startup this value is disabled
   ShowJoystickValueEnabled := 0



;   IniRead, SafetyDelay5, Settings\PokerShortcuts.ini, %SectionLabel%, SafetyDelay5, 250
;   IniRead, SafetyDelay6, Settings\PokerShortcuts.ini, %SectionLabel%, SafetyDelay6, 50
   IniRead, ShortcutsProcessPriority, Settings\PokerShortcuts.ini, %SectionLabel%, ShortcutsProcessPriority, High
   IniRead, FullTiltProcessPriority, Settings\PokerShortcuts.ini, %SectionLabel%, FullTiltProcessPriority, High
   IniRead, PokerStarsProcessPriority, Settings\PokerShortcuts.ini, %SectionLabel%, PokerStarsProcessPriority, Normal




   ; Street Bet - Ring games


   IniRead, StreetBetControl, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetControl, not set
   IniRead, StreetBetPreFlopAmountAct1Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click1R, 4
   IniRead, StreetBetFlopAmountAct1Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click1R, 75
   IniRead, StreetBetTurnAmountAct1Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click1R, 66
   IniRead, StreetBetRiverAmountAct1Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click1R, 50
   IniRead, StreetBetPreFlopAmountAct0Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click1R, 100
   IniRead, StreetBetFlopAmountAct0Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click1R, 100
   IniRead, StreetBetTurnAmountAct0Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click1R, 100
   IniRead, StreetBetRiverAmountAct0Click1R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click1R, 100

   IniRead, StreetBetPreFlopAmountAct1Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click2R, 3
   IniRead, StreetBetFlopAmountAct1Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click2R, 50
   IniRead, StreetBetTurnAmountAct1Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click2R, 50
   IniRead, StreetBetRiverAmountAct1Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click2R, 50
   IniRead, StreetBetPreFlopAmountAct0Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click2R, 50
   IniRead, StreetBetFlopAmountAct0Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click2R, 50
   IniRead, StreetBetTurnAmountAct0Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click2R, 50
   IniRead, StreetBetRiverAmountAct0Click2R, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click2R, 50
   IniRead, AutoSetBetRingEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoSetBetBetRingEnabled, 1
   IniRead, ClickBetAfterSettingStreetBetRingEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingStreetBetRingEnabled, 0
   IniRead, RoundStreetBetRingToSmallBlindMultiple, Settings\PokerShortcuts.ini, %SectionLabel%, RoundStreetBetRingToSmallBlindMultiple, 1


   ; Street Bet - Tournaments and Sng
   IniRead, StreetBetPreFlopAmountAct1Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click1T, 3
   IniRead, StreetBetFlopAmountAct1Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click1T, 75
   IniRead, StreetBetTurnAmountAct1Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click1T, 66
   IniRead, StreetBetRiverAmountAct1Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click1T, 50
   IniRead, StreetBetPreFlopAmountAct0Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click1T, 100
   IniRead, StreetBetFlopAmountAct0Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click1T, 100
   IniRead, StreetBetTurnAmountAct0Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click1T, 100
   IniRead, StreetBetRiverAmountAct0Click1T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click1T, 100
   IniRead, StreetBetPreFlopAmountAct1Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click2T, 2.5

   IniRead, StreetBetFlopAmountAct1Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click2T, 50
   IniRead, StreetBetTurnAmountAct1Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click2T, 50
   IniRead, StreetBetRiverAmountAct1Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click2T, 50
   IniRead, StreetBetPreFlopAmountAct0Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click2T, 50
   IniRead, StreetBetFlopAmountAct0Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click2T, 50
   IniRead, StreetBetTurnAmountAct0Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click2T, 50
   IniRead, StreetBetRiverAmountAct0Click2T, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click2T, 50
   IniRead, AutoSetBetTrnyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoSetBetTrnyEnabled, 1
   IniRead, ClickBetAfterSettingStreetBetTrnyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingStreetBetTrnyEnabled, 0
   IniRead, RoundStreetBetTrnyToSmallBlindMultiple, Settings\PokerShortcuts.ini, %SectionLabel%, RoundStreetBetTrnyToSmallBlindMultiple, 1


   ; Inc/Dec Bet
  
   IniRead, VarBetControlUp1, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp1, WheelUp
   IniRead, VarBetControlDown1, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown1, WheelDown
   IniRead, VarBetAmount1, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount1, 1
   IniRead, VarBetUnits1, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits1, SB
   IniRead, VarBetControlUp2, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp2, Up
   IniRead, VarBetControlDown2, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown2, Down
   IniRead, VarBetAmount2, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount2, 1
   IniRead, VarBetUnits2, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits2, SB
   IniRead, VarBetControlUp3, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp3,!u
   IniRead, VarBetControlDown3, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown3,!d
   IniRead, VarBetAmount3, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount3, 1
   IniRead, VarBetUnits3, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits3, SB
   IniRead, VarBetControlUp4, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp4,!Up
   IniRead, VarBetControlDown4, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown4,!Down
   IniRead, VarBetAmount4, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount4, 1
   IniRead, VarBetUnits4, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits4, SB
   IniRead, RoundVarBetToSmallBlindMultiple, Settings\PokerShortcuts.ini, %SectionLabel%, RoundVarBetToSmallBlindMultiple, 1
;   IniRead, MouseWheelOnFullTiltDisabled, Settings\PokerShortcuts.ini, %SectionLabel%, MouseWheelOnFullTiltDisabled, 1

   ; Fixed Bet
   IniRead, BetFixedControl1, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl1, not set
   IniRead, BetFixedAmount11, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount11, 33
   IniRead, BetFixedAmount12, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount12, 50
   IniRead, BetFixedAmount13, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount13, 66
   IniRead, BetFixedUnits1, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits1, `%Pot
   
   IniRead, BetFixedControl2, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl2, not set
   IniRead, BetFixedAmount21, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount21, 50
   IniRead, BetFixedAmount22, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount22, 75
   IniRead, BetFixedAmount23, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount23, 100
   IniRead, BetFixedUnits2, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits2, BB
   
   IniRead, BetFixedControl3, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl3, not set
   IniRead, BetFixedAmount31, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount31, 66
   IniRead, BetFixedAmount32, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount32, 100
   IniRead, BetFixedAmount33, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount33, 125
   IniRead, BetFixedUnits3, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits3, SB
   
   IniRead, BetFixedControl4, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl4, not set
   IniRead, BetFixedAmount41, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount41, 75
   IniRead, BetFixedAmount42, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount42, 100
   IniRead, BetFixedAmount43, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount43, 135
   IniRead, BetFixedUnits4, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits4, $
   
   IniRead, BetFixedControl5, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl5, not set
   IniRead, BetFixedAmount51, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount51, 100
   IniRead, BetFixedAmount52, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount52, 150
   IniRead, BetFixedAmount53, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount53, 200
   IniRead, BetFixedUnits5, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits5, `%Pot
   
   IniRead, ClickBetAfterSettingBetFixedEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingBetFixedEnabled, 0
   IniRead, BetMaxControl, Settings\PokerShortcuts.ini, %SectionLabel%, BetMaxControl, not set
   IniRead, BetPotControl, Settings\PokerShortcuts.ini, %SectionLabel%, BetPotControl, not set
   IniRead, FixedBetMultiClickDisabled, Settings\PokerShortcuts.ini, %SectionLabel%, FixedBetMultiClickDisabled, 1
   IniRead, RoundFixedBetToSmallBlindMultiple, Settings\PokerShortcuts.ini, %SectionLabel%, RoundFixedBetToSmallBlindMultiple, 1


   ; Deal Me Mode
   IniRead, SetDealMeModeOnInitialBuyInEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, SetDealMeModeOnInitialBuyInEnabled, 0
   IniRead, DealMeModeStatusTooltipEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DealMeModeStatusTooltipEnabled, 0
   IniRead, CycleDealMeModesOnActiveTableControl, Settings\PokerShortcuts.ini, %SectionLabel%, CycleDealMeModesOnActiveTableControl, Alt & t
   IniRead, CycleDealMeModesOnAllTablesControl, Settings\PokerShortcuts.ini, %SectionLabel%, CycleDealMeModesOnAllTablesControl, Alt & a
   IniRead, AutoPostBlindsAfterSittingDownEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoPostBlindsAfterSittingDownEnabled, 0
   IniRead, DisableDealMeModeWhenHU, Settings\PokerShortcuts.ini, %SectionLabel%, DisableDealMeModeWhenHU, 0

   ; SnG A

/*
   IniRead, Sng1Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Description, $10 Turb
   IniRead, Sng2Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Description, Put
   IniRead, Sng3Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Description, In
   IniRead, Sng4Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Description, Your
   IniRead, Sng5Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Description, Own
   IniRead, Sng6Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Description, Desc
   IniRead, Sng7Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Description, Here
;   IniRead, Sng8Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Description, In
;   IniRead, Sng9Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Description, Here
*/
   IniRead, Sng11Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11Description, Stars 1
   IniRead, Sng12Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12Description, Stars 2
   IniRead, Sng13Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13Description, Stars 3
   IniRead, Sng14Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14Description, Stars 4
   IniRead, Sng15Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15Description, Stars 5
   IniRead, Sng16Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16Description, Stars 6
   IniRead, Sng17Description, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17Description, Stars 7

/*   
   IniRead, Sng1Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Game, Hold'em
   IniRead, Sng2Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Game, Hold'em
   IniRead, Sng3Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Game, Hold'em
   IniRead, Sng4Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Game, Hold'em
   IniRead, Sng5Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Game, Hold'em
   IniRead, Sng6Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Game, Hold'em
   IniRead, Sng7Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Game, Hold'em
;   IniRead, Sng8Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Game, Hold'em
;   IniRead, Sng9Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Game, Hold'em
*/
   IniRead, Sng11Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11Game
   IniRead, Sng12Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12Game
   IniRead, Sng13Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13Game
   IniRead, Sng14Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14Game
   IniRead, Sng15Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15Game
   IniRead, Sng16Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16Game
   IniRead, Sng17Game, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17Game

/*
   IniRead, Sng1Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Options, None
   IniRead, Sng2Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Options, None
   IniRead, Sng3Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Options, None
   IniRead, Sng4Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Options, None
   IniRead, Sng5Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Options, None
   IniRead, Sng6Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Options, None
   IniRead, Sng7Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Options, None
;   IniRead, Sng8Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Options, None
;   IniRead, Sng9Options, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Options, None

   IniRead, Sng1Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Type, NL
   IniRead, Sng2Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Type, NL
   IniRead, Sng3Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Type, NL
   IniRead, Sng4Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Type, NL
   IniRead, Sng5Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Type, NL
   IniRead, Sng6Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Type, NL
   IniRead, Sng7Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Type, NL
;   IniRead, Sng8Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Type, NL
;   IniRead, Sng9Type, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Type, NL
   IniRead, Sng1Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Cost, 11
   IniRead, Sng2Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Cost, 12
   IniRead, Sng3Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Cost, 22
   IniRead, Sng4Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Cost, 1
   IniRead, Sng5Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Cost, 1
   IniRead, Sng6Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Cost, 1
   IniRead, Sng7Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Cost, 1
;   IniRead, Sng8Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Cost, 1
;   IniRead, Sng9Cost, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Cost, 1

   IniRead, Sng1Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Seats, 8/9
   IniRead, Sng2Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Seats, 8/9
   IniRead, Sng3Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Seats, 8/9
   IniRead, Sng4Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Seats, 8/9
   IniRead, Sng5Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Seats, 8/9
   IniRead, Sng6Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Seats, 8/9
   IniRead, Sng7Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Seats, 8/9
;   IniRead, Sng8Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Seats, 8/9
;   IniRead, Sng9Seats, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Seats, 8/9

   IniRead, Sng1NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumPlayers, 9
   IniRead, Sng2NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumPlayers, 9
   IniRead, Sng3NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumPlayers, 9
   IniRead, Sng4NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumPlayers, 9
   IniRead, Sng5NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumPlayers, 9
   IniRead, Sng6NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumPlayers, 9
   IniRead, Sng7NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumPlayers, 9
;   IniRead, Sng8NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumPlayers, 9
;   IniRead, Sng9NumPlayers, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumPlayers, 9
   IniRead, Sng1NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumRegPlayersMin, 0
   IniRead, Sng2NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumRegPlayersMin, 0
   IniRead, Sng3NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumRegPlayersMin, 0
   IniRead, Sng4NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumRegPlayersMin, 0
   IniRead, Sng5NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumRegPlayersMin, 0
   IniRead, Sng6NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumRegPlayersMin, 0
   IniRead, Sng7NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumRegPlayersMin, 0
;   IniRead, Sng8NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumRegPlayersMin, 0
;   IniRead, Sng9NumRegPlayersMin, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumRegPlayersMin, 0
   IniRead, Sng1NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumSharksMax, 100
   IniRead, Sng2NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumSharksMax, 100
   IniRead, Sng3NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumSharksMax, 100
   IniRead, Sng4NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumSharksMax, 100
   IniRead, Sng5NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumSharksMax, 100
   IniRead, Sng6NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumSharksMax, 100
   IniRead, Sng7NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumSharksMax, 100
;   IniRead, Sng8NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumSharksMax, 100
;   IniRead, Sng9NumSharksMax, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumSharksMax, 100
   IniRead, Sng1LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1LobbyText,%A_Space%
   IniRead, Sng2LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2LobbyText,%A_Space%
   IniRead, Sng3LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3LobbyText,%A_Space%
   IniRead, Sng4LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4LobbyText,%A_Space%
   IniRead, Sng5LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5LobbyText,%A_Space%
   IniRead, Sng6LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6LobbyText,%A_Space%
   IniRead, Sng7LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7LobbyText,%A_Space%
;   IniRead, Sng8LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8LobbyText,%A_Space%
;   IniRead, Sng9LobbyText, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9LobbyText,%A_Space%

   IniRead, Sng1PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1PaymentType, $
   IniRead, Sng2PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2PaymentType, $
   IniRead, Sng3PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3PaymentType, $
   IniRead, Sng4PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4PaymentType, Play
   IniRead, Sng5PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5PaymentType, FTP
   IniRead, Sng6PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6PaymentType, $
   IniRead, Sng7PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7PaymentType, $
;   IniRead, Sng8PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8PaymentType, $
;   IniRead, Sng9PaymentType, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9PaymentType, $
*/


   ; SnG B

/*
   IniRead, Sng1ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1ContinuouslyEnabled, 0
   IniRead, Sng2ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2ContinuouslyEnabled, 0
   IniRead, Sng3ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3ContinuouslyEnabled, 0
   IniRead, Sng4ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4ContinuouslyEnabled, 0
   IniRead, Sng5ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5ContinuouslyEnabled, 0
   IniRead, Sng6ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6ContinuouslyEnabled, 0
   IniRead, Sng7ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7ContinuouslyEnabled, 0
;   IniRead, Sng8ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8ContinuouslyEnabled, 0
;   IniRead, Sng9ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9ContinuouslyEnabled, 0
*/
   IniRead, Sng11ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11ContinuouslyEnabled, 0
   IniRead, Sng12ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12ContinuouslyEnabled, 0
   IniRead, Sng13ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13ContinuouslyEnabled, 0
   IniRead, Sng14ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14ContinuouslyEnabled, 0
   IniRead, Sng15ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15ContinuouslyEnabled, 0
   IniRead, Sng16ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16ContinuouslyEnabled, 0
   IniRead, Sng17ContinuouslyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17ContinuouslyEnabled, 0

   
   IniRead, SngContinuouslyOpenNumber, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenNumber, 0
   IniRead, SngStopOpeningAfterNum, Settings\PokerShortcuts.ini, %SectionLabel%, SngStopOpeningAfterNum, 50
   IniRead, SngContinuouslyOpenPlayTime, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenPlayTime, 10
   IniRead, SngContinuouslyOpenTimerInterval, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenTimerInterval, 5
   IniRead, SngContinuouslyOpenFailSafeTime, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenFailSafeTime, 2
   

   IniRead, ClickOkForSngEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ClickOkForSngEnabled, 0






   ; SnG C
   
   IniRead, AutoClickImBackButtonEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickImBackButtonEnabled, 0
   IniRead, ClickImReadyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ClickImReadyEnabled, 0
   IniRead, AutoCloseTournamentLobbyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoCloseTournamentLobbyEnabled, 0
   IniRead, MinimizeSngLobbyEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, MinimizeSngLobbyEnabled, 1
   IniRead, UseCriticalMethodDisabled, Settings\PokerShortcuts.ini, %SectionLabel%, UseCriticalMethodDisabled, 0
   IniRead, AutoClickInfoRefreshEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickInfoRefreshEnabled, 0
   IniRead, AutoClickInfoRefreshInterval, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickInfoRefreshInterval, 30
   IniRead, CloseFinishedSngTablesEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseFinishedSngTablesEnabled, 0
   IniRead, CloseTourneyTablesIfNotSeatedEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTourneyTablesIfNotSeatedEnabled, 0
   IniRead, CloseTableTimeDelay, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTableTimeDelay, 10

 
;   IniRead, Sng1OpenControl, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1OpenControl, not set
   IniRead, Sng11OpenControl, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11OpenControl, not set   
   IniRead, PSSngOpenHighlightedControl, Settings\PokerShortcuts.ini, %SectionLabel%, PSSngOpenHighlightedControl, not set   
   IniRead, FTSngOpenHighlightedControl, Settings\PokerShortcuts.ini, %SectionLabel%, FTSngOpenHighlightedControl, not set   

   IniRead, OneClickSngRegisteringEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, OneClickSngRegisteringEnabled, 0   


   
   ; Actions1
;   IniRead, BettingControlsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, BettingControlsEnabled, 0
   IniRead, FoldCheckControl, Settings\PokerShortcuts.ini, %SectionLabel%, FoldCheckControl, not set
   IniRead, CallControl, Settings\PokerShortcuts.ini, %SectionLabel%, CallControl, not set
   IniRead, BetRaiseControl, Settings\PokerShortcuts.ini, %SectionLabel%, BetRaiseControl, not set
   IniRead, LeftCheckboxControl, Settings\PokerShortcuts.ini, %SectionLabel%, LeftCheckboxControl, not set
   IniRead, MiddleCheckboxControl, Settings\PokerShortcuts.ini, %SectionLabel%, MiddleCheckboxControl, not set
   IniRead, CallAnyControl, Settings\PokerShortcuts.ini, %SectionLabel%, CallAnyControl, not set
   IniRead, RaiseMinControl, Settings\PokerShortcuts.ini, %SectionLabel%, RaiseMinControl, not set
   IniRead, RaiseAnyControl, Settings\PokerShortcuts.ini, %SectionLabel%, RaiseAnyControl, not set
   IniRead, BetWindowClearControl, Settings\PokerShortcuts.ini, %SectionLabel%, BetWindowClearControl, not set
   IniRead, FoldToAnyBetControl, Settings\PokerShortcuts.ini, %SectionLabel%, FoldToAnyBetControl, not set
;   IniRead, PreActionControlsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionControlsEnabled, 0
   IniRead, PreActionFoldControlEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionFoldControlEnabled, 0
   IniRead, PreActionCallControlEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionCallControlEnabled, 0
   


   ; Actions2
   IniRead, PlayersNameControl, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameControl, not set
;   IniRead, PlayersNameToSharkListControl, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameToSharkListControl, not set
;   IniRead, PlayersNameFromSharkListControl, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameFromSharkListControl, not set
   IniRead, TableTournamentIdControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableTournamentIdControl, not set
   IniRead, ReloadChipsControl, Settings\PokerShortcuts.ini, %SectionLabel%, ReloadChipsControl, not set
   IniRead, LobbyToggleAutoMuckHandsControl, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyToggleAutoMuckHandsControl, not set
;   IniRead, ReloadAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, ReloadAllControl, not set
   IniRead, TableMoveToFromChatControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableMoveToFromChatControl, not set
   IniRead, TimerControl, Settings\PokerShortcuts.ini, %SectionLabel%, TimerControl, not set
   IniRead, TimerAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, TimerAllControl, not set
   IniRead, LastHandControl, Settings\PokerShortcuts.ini, %SectionLabel%, LastHandControl, not set
   IniRead, TourneyInfoControl, Settings\PokerShortcuts.ini, %SectionLabel%, TourneyInfoControl, not set
   IniRead, NotesControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesControl, not set
   IniRead, NotesNanoControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoControl, not set
   IniRead, NotesPlayerNControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesPlayerNControl, not set
   IniRead, NotesOpenPlayerNControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesOpenPlayerNControl, not set
   IniRead, NotesNanoPlayerNControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoPlayerNControl, not set
   IniRead, NotesNanoInitialColor, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoInitialColor, 0
   IniRead, NotesColorNControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesColorNControl, not set
   IniRead, NotesNanoColorUpControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoColorUpControl, not set
   IniRead, NotesNanoColorDownControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoColorDownControl, not set
   IniRead, NotesCloseControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesCloseControl, not set


   ; Actions3
   IniRead, ToggleSitOutControl, Settings\PokerShortcuts.ini, %SectionLabel%, ToggleSitOutControl, not set
   IniRead, SitInOnAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, SitInOnAllControl, not set
   IniRead, SitOutOnAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, SitOutOnAllControl, not set
   IniRead, ToggleAPBControl, Settings\PokerShortcuts.ini, %SectionLabel%, ToggleAPBControl, not set
   IniRead, TableCloseActiveControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseActiveControl, not set
   IniRead, TableCloseActiveWithoutHeroControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseActiveWithoutHeroControl, not set
   IniRead, TableCloseAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseAllControl, not set
   IniRead, TableCloseAllWithoutHeroControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseAllWithoutHeroControl, not set
   IniRead, TableMinimizeAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableMinimizeAllControl, not set
   IniRead, TableMinimizeAllWithoutHeroControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableMinimizeAllWithoutHeroControl, not set
   IniRead, OpenCashierControl, Settings\PokerShortcuts.ini, %SectionLabel%, OpenCashierControl, not set
   IniRead, LobbyTournamentCloseControl, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyTournamentCloseControl, not set
   IniRead, LobbyTournamentMinimizeControl, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyTournamentMinimizeControl, not set

   IniRead, TableNextControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableNextControl, not set
   IniRead, TablePreviousControl, Settings\PokerShortcuts.ini, %SectionLabel%, TablePreviousControl, not set
   IniRead, TableLeftControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableLeftControl, not set
   IniRead, TableRightControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableRightControl, not set
   IniRead, TableUpControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableUpControl, not set
   IniRead, TableDownControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableDownControl, not set
   
   IniRead, TableBottomOfStackControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableBottomOfStackControl, not set
   IniRead, TableNextInStackControl, Settings\PokerShortcuts.ini, %SectionLabel%, TableNextInStackControl, not set
   IniRead, TablePendingControl, Settings\PokerShortcuts.ini, %SectionLabel%, TablePendingControl, not set
   IniRead, TableLayout1Control, Settings\PokerShortcuts.ini, %SectionLabel%, TableLayout1Control, not set
   IniRead, TableLayout2Control, Settings\PokerShortcuts.ini, %SectionLabel%, TableLayout2Control, not set
   IniRead, TablesCascadeControl, Settings\PokerShortcuts.ini, %SectionLabel%, TablesCascadeControl, not set
   IniRead, TablesTileControl, Settings\PokerShortcuts.ini, %SectionLabel%, TablesTileControl, not set

   ; Gary's code
;   IniRead, NotesNanoAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoAllControl, not set
;   IniRead, NotesNanoSetSharkScopeColorAllControl, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoSetSharkScopeColorAllControl, not set

   ; Displays
   IniRead, OsdBettingInfoEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoEnabled, 1

   IniRead, OsdBettingInfoColor, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoColor, White
   IniRead, OsdBettingInfoFontSize, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoFontSize, 15
   IniRead, OsdBettingInfoFont, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoFont, Arial
   IniRead, OsdBettingInfoText, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoText, $!x!r!y`%
;   IniRead, TooltipBettingInfoEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoEnabled, 1
;   IniRead, TooltipBettingInfoPosX, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoPosX, 695
;   IniRead, TooltipBettingInfoPosY, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoPosY, 466
;   IniRead, TooltipBettingInfoText, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoText, !y `% of Pot!rPot Bet/Raise= !z
   IniRead, DisplayOsd3Enabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Enabled, 1
   IniRead, DisplayOsd3Color, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Color, !n,7,Red,12,Purple,17,Yellow,Lime
   IniRead, DisplayOsd3FontSize, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3FontSize, 15
   IniRead, DisplayOsd3Font, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Font, Arial
   IniRead, DisplayOsd3Text, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Text, !n BB  @!s/!b
   
   IniRead, DisplayOsd4Enabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Enabled, 1
   IniRead, DisplayOsd4Color, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Color, !p,3,Purple,4,Red,5,Yellow,Lime
   IniRead, DisplayOsd4FontSize, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4FontSize, 15
   IniRead, DisplayOsd4Font, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Font, Arial
   IniRead, DisplayOsd4Text, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Text, !p Plyrs
   
   IniRead, DisplayOsd5Enabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Enabled, 1
   IniRead, DisplayOsd5Color, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Color, !n,7,Red,12,Purple,17,Yellow,Lime
   IniRead, DisplayOsd5FontSize, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5FontSize, 15
   IniRead, DisplayOsd5Font, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Font, Arial
   IniRead, DisplayOsd5Text, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Text, !n BB!rM: !m
   
;   IniRead, TooltipStackInfoEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipStackInfoEnabled, 1
;   IniRead, TooltipStackInfoText, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipStackInfoText, Stack: !$!r # BB:  !n!r      M:  !m!r eff M: !e
   IniRead, DisplayOsdStackInfoInRingGamesEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsdStackInfoInRingGamesEnabled, 1
   IniRead, DisplayOsdBetInfoInLimitGamesEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsdBetInfoInLimitGamesEnabled, 0
   IniRead, ChatWarningEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ChatWarningEnabled, 1
   IniRead, DisplayOsd3AllTablesEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3AllTablesEnabled, 1
   IniRead, DisplayOsd4AllTablesEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4AllTablesEnabled, 1
   IniRead, DisplayDebugInfoEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayDebugInfoEnabled, 0
   IniRead, DebugTooltipPosX, Settings\PokerShortcuts.ini, %SectionLabel%, DebugTooltipPosX, 30
   IniRead, DebugTooltipPosY, Settings\PokerShortcuts.ini, %SectionLabel%, DebugTooltipPosY, 30
   IniRead, RefreshOSD1Control, Settings\PokerShortcuts.ini, %SectionLabel%, RefreshOSD1Control, not set   
   


/*
   ; Chips
   IniRead, AutoClickOkOnGetChipsDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickOkOnGetChipsDialogEnabled, 0
   IniRead, NLReloadAmount, Settings\PokerShortcuts.ini, %SectionLabel%, NLReloadAmount, 100
   IniRead, CapReloadAmount, Settings\PokerShortcuts.ini, %SectionLabel%, CapReloadAmount, 100
   IniRead, LimitReloadAmount, Settings\PokerShortcuts.ini, %SectionLabel%, LimitReloadAmount, 50
   IniRead, ManualReloadWhenGetChipsIsClicked, Settings\PokerShortcuts.ini, %SectionLabel%, ManualReloadWhenGetChipsIsClicked, 0
   IniRead, AssumeStackIs0WhenSittingOutEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AssumeStackIs0WhenSittingOutEnabled, 0
*/

   ; Table1
   IniRead, ActiveTableHighlighterEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableHighlighterEnabled, 0
   IniRead, ActiveTableHighlighterColor, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableHighlighterColor, Lime
   IniRead, TableHighlighterTransperancy, Settings\PokerShortcuts.ini, %SectionLabel%, TableHighlighterTransperancy, 255
   IniRead, TableHighlighterSize, Settings\PokerShortcuts.ini, %SectionLabel%, TableHighlighterSize, 5
   IniRead, ActiveTableAndPendingHighlighterEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableAndPendingHighlighterEnabled, 1
   IniRead, ActiveTableAndPendingHighlighterColor, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableAndPendingHighlighterColor, Red
;   IniRead, PendingActionHighlighterEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PendingActionHighlighterEnabled, 0
;   IniRead, PendingActionHighlighterColor, Settings\PokerShortcuts.ini, %SectionLabel%, PendingActionHighlighterColor, Yellow
   IniRead, TableAutoActivateDisabled, Settings\PokerShortcuts.ini, %SectionLabel%, TableAutoActivateDisabled, 0
   IniRead, ActivateTableOnMouseOverEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ActivateTableOnMouseOverEnabled, 0
   IniRead, AutoActivateNextPendingTableEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoActivateNextPendingTableEnabled, 1
   IniRead, MoveTableEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTableEnabled, 0
   IniRead, MoveTablePosX, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTablePosX, 200
   IniRead, MoveTablePosY, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTablePosY, 20
   IniRead, MoveTableWidth, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTableWidth, 632
   IniRead, MouseToHomeEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, MouseToHomeEnabled, 1
   IniRead, ActivateTableOnMouseOverIfMouseToHomeEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, ActivateTableOnMouseOverIfMouseToHomeEnabled, 1
;   IniRead, PutImBackButtonTablesIntoPendingListEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PutImBackButtonTablesIntoPendingListEnabled, 0
;   IniRead, AutoActivateTopTableEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoActivateTopTableEnabled, 0


   IniRead, ManualMoveTableControl, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTableControl, not set
   IniRead, ManualMoveTablePosX, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTablePosX, 100
   IniRead, ManualMoveTablePosY, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTablePosY, 100
   IniRead, ManualMoveTableWidth, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTableWidth, 500

   IniRead, ManualMoveTable2Control, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2Control, not set
   IniRead, ManualMoveTable2PosX, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2PosX, 600
   IniRead, ManualMoveTable2PosY, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2PosY, 100
   IniRead, ManualMoveTable2Width, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2Width, 500
   
   



   ; Table2
   IniRead, TableSize, Settings\PokerShortcuts.ini, %SectionLabel%, TableSize, None
   IniRead, TableWidthA, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthA, 500
   IniRead, TableWidthB, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthB, 600
   IniRead, TableWidthC, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthC, 700
   IniRead, TableWidthD, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthD, 800
   IniRead, TableWidthE, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthE, 900
   IniRead, TableWidthF, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthF, 1000






   ; Dialog boxes
   IniRead, AutoLogInEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoLogInEnabled, 0
   IniRead, DenyReLoginAttemptedEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, DenyReLoginAttemptedEnabled, 0
   IniRead, CloseAnnouncementsDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseAnnouncementsDialogEnabled, 1
   IniRead, CloseFoldCallDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseFoldCallDialogEnabled, 1
;   IniRead, CloseRemovedFromWaitingListDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseRemovedFromWaitingListDialogEnabled, 1
   IniRead, RejectSeatIfSeatAvailableEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, RejectSeatIfSeatAvailableEnabled, 0
   IniRead, RejectSeatControl, Settings\PokerShortcuts.ini, %SectionLabel%, RejectSeatControl, not set
   IniRead, TakeSeatIfSeatAvailableEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, TakeSeatIfSeatAvailableEnabled, 0
   IniRead, PopSeatAvailDialogToTopEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, PopSeatAvailDialogToTopEnabled, 1
   IniRead, CloseAutoPostBlindsDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseAutoPostBlindsDialogEnabled, 1
   IniRead, CloseLeaveTableDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseLeaveTableDialogEnabled, 1
   IniRead, CloseLeaveSeatDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseLeaveSeatDialogEnabled, 1
   IniRead, CloseEducationalTableDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseEducationalTableDialogEnabled, 0
   IniRead, CloseTableHasBeenClosedEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTableHasBeenClosedEnabled, 0
   
;   IniRead, CloseWereSorryRegClosedDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseWereSorryRegClosedDialogEnabled, 0
   IniRead, CloseYouFinishedTheTournamentDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseYouFinishedTheTournamentDialogEnabled, 0
   IniRead, CloseDialogDelay, Settings\PokerShortcuts.ini, %SectionLabel%, CloseDialogDelay, 5
   
;   IniRead, CloseTooManyWindowsOpenDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTooManyWindowsOpenDialogEnabled, 0
;   IniRead, CloseYouCannotRegisterMoreTrnysDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseYouCannotRegisterMoreTrnysDialogEnabled, 0
   IniRead, CloseOneButtonStarsDialogsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseOneButtonStarsDialogsEnabled, 0
   IniRead, CloseOneButtonFullTiltDialogsEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseOneButtonFullTiltDialogsEnabled, 0
  
;   IniRead, CloseDialogBoxesUsingImageRecogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, CloseDialogBoxesUsingImageRecogEnabled, 0

   IniRead, AutoClickOkOnGetChipsDialogEnabled, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickOkOnGetChipsDialogEnabled, 0



   ; Calib






}



; write the new settings to the gui after new settings have been read in (usually from another set 1-9)
; we must have re-created the PSSngFileList  before calling this function (by calling the function   IniReadAllThemes()  )
SettingsWriteToGui()
{
   global


outputdebug, in SettingsWriteToGui()



; set flag that we are updating the gui
GuiSoftwareUpdateFlag := 1

;   Thread, Priority, -200
;   Critical

   ; also save the preferences from the .ini file to the GUI controls
   Gui, 99:Default




   ; Street Bet - Ring games


      GuiControl,, StreetBetControl, %StreetBetControl%
      GuiControl,, StreetBetPreFlopAmountAct1Click1R, %StreetBetPreFlopAmountAct1Click1R%
      GuiControl,, StreetBetFlopAmountAct1Click1R, %StreetBetFlopAmountAct1Click1R%
      GuiControl,, StreetBetTurnAmountAct1Click1R, %StreetBetTurnAmountAct1Click1R%
      GuiControl,, StreetBetRiverAmountAct1Click1R, %StreetBetRiverAmountAct1Click1R%
      GuiControl,, StreetBetPreFlopAmountAct0Click1R, %StreetBetPreFlopAmountAct0Click1R%
      GuiControl,, StreetBetFlopAmountAct0Click1R, %StreetBetFlopAmountAct0Click1R%
      GuiControl,, StreetBetTurnAmountAct0Click1R, %StreetBetTurnAmountAct0Click1R%
      GuiControl,, StreetBetRiverAmountAct0Click1R, %StreetBetRiverAmountAct0Click1R%

      GuiControl,, StreetBetPreFlopAmountAct1Click2R, %StreetBetPreFlopAmountAct1Click2R%
      GuiControl,, StreetBetFlopAmountAct1Click2R, %StreetBetFlopAmountAct1Click2R%
      GuiControl,, StreetBetTurnAmountAct1Click2R, %StreetBetTurnAmountAct1Click2R%
      GuiControl,, StreetBetRiverAmountAct1Click2R, %StreetBetRiverAmountAct1Click2R%
      GuiControl,, StreetBetPreFlopAmountAct0Click2R, %StreetBetPreFlopAmountAct0Click2R%
      GuiControl,, StreetBetFlopAmountAct0Click2R, %StreetBetFlopAmountAct0Click2R%
      GuiControl,, StreetBetTurnAmountAct0Click2R, %StreetBetTurnAmountAct0Click2R%
      GuiControl,, StreetBetRiverAmountAct0Click2R, %StreetBetRiverAmountAct0Click2R%
      GuiControl,, AutoSetBetRingEnabled, %AutoSetBetRingEnabled%
      GuiControl,, ClickBetAfterSettingStreetBetRingEnabled, %ClickBetAfterSettingStreetBetRingEnabled%
      GuiControl,, RoundStreetBetRingToSmallBlindMultiple, %RoundStreetBetRingToSmallBlindMultiple%



   ; Street Bet - Tournaments and Sng
      GuiControl,, StreetBetPreFlopAmountAct1Click1T, %StreetBetPreFlopAmountAct1Click1T%
      GuiControl,, StreetBetFlopAmountAct1Click1T, %StreetBetFlopAmountAct1Click1T%
      GuiControl,, StreetBetTurnAmountAct1Click1T, %StreetBetTurnAmountAct1Click1T%
      GuiControl,, StreetBetRiverAmountAct1Click1T, %StreetBetRiverAmountAct1Click1T%
      GuiControl,, StreetBetPreFlopAmountAct0Click1T, %StreetBetPreFlopAmountAct0Click1T%
      GuiControl,, StreetBetFlopAmountAct0Click1T, %StreetBetFlopAmountAct0Click1T%
      GuiControl,, StreetBetTurnAmountAct0Click1T, %StreetBetTurnAmountAct0Click1T%
      GuiControl,, StreetBetRiverAmountAct0Click1T, %StreetBetRiverAmountAct0Click1T%
      GuiControl,, StreetBetPreFlopAmountAct1Click2T, %StreetBetPreFlopAmountAct1Click2T%

      GuiControl,, StreetBetFlopAmountAct1Click2T, %StreetBetFlopAmountAct1Click2T%
      GuiControl,, StreetBetTurnAmountAct1Click2T, %StreetBetTurnAmountAct1Click2T%
      GuiControl,, StreetBetRiverAmountAct1Click2T, %StreetBetRiverAmountAct1Click2T%
      GuiControl,, StreetBetPreFlopAmountAct0Click2T, %StreetBetPreFlopAmountAct0Click2T%
      GuiControl,, StreetBetFlopAmountAct0Click2T, %StreetBetFlopAmountAct0Click2T%
      GuiControl,, StreetBetTurnAmountAct0Click2T, %StreetBetTurnAmountAct0Click2T%
      GuiControl,, StreetBetRiverAmountAct0Click2T, %StreetBetRiverAmountAct0Click2T%
      GuiControl,, AutoSetBetTrnyEnabled, %AutoSetBetTrnyEnabled%
      GuiControl,, ClickBetAfterSettingStreetBetTrnyEnabled, %ClickBetAfterSettingStreetBetTrnyEnabled%
      GuiControl,, RoundStreetBetTrnyToSmallBlindMultiple, %RoundStreetBetTrnyToSmallBlindMultiple%



   ; Inc/Dec Bet
      GuiControl,, VarBetControlUp1, %VarBetControlUp1%
      GuiControl,, VarBetControlDown1, %VarBetControlDown1%
      GuiControl,, VarBetAmount1, %VarBetAmount1%
      GuiControl, ChooseString, VarBetUnits1, % VarBetUnits1
      GuiControl,, VarBetControlUp2, %VarBetControlUp2%
      GuiControl,, VarBetControlDown2, %VarBetControlDown2%
      GuiControl,, VarBetAmount2, %VarBetAmount2%
      GuiControl, ChooseString, VarBetUnits2, % VarBetUnits2
      GuiControl,, VarBetControlUp3, %VarBetControlUp3%
      GuiControl,, VarBetControlDown3, %VarBetControlDown3%
      GuiControl,, VarBetAmount3, %VarBetAmount3%
      GuiControl, ChooseString, VarBetUnits3, % VarBetUnits3
      GuiControl,, VarBetControlUp4, %VarBetControlUp4%
      GuiControl,, VarBetControlDown4, %VarBetControlDown4%
      GuiControl,, VarBetAmount4, %VarBetAmount4%
      GuiControl, ChooseString, VarBetUnits4, % VarBetUnits4
      GuiControl,, RoundVarBetToSmallBlindMultiple, %RoundVarBetToSmallBlindMultiple%
;      GuiControl,, MouseWheelOnFullTiltDisabled, %MouseWheelOnFullTiltDisabled%

   ; Fixed Bet
      GuiControl,, BetFixedControl1, %BetFixedControl1%
      GuiControl,, BetFixedAmount11, %BetFixedAmount11%
      GuiControl,, BetFixedAmount12, %BetFixedAmount12%
      GuiControl,, BetFixedAmount13, %BetFixedAmount13%
      GuiControl,, BetFixedControl2, %BetFixedControl2%
      GuiControl, ChooseString, BetFixedUnits1, % BetFixedUnits1
      GuiControl,, BetFixedAmount21, %BetFixedAmount21%
      GuiControl,, BetFixedAmount22, %BetFixedAmount22%
      GuiControl,, BetFixedAmount23, %BetFixedAmount23%
      GuiControl, ChooseString, BetFixedUnits2, % BetFixedUnits2
      GuiControl,, BetFixedControl3, %BetFixedControl3%
      GuiControl,, BetFixedAmount31, %BetFixedAmount31%
      GuiControl,, BetFixedAmount32, %BetFixedAmount32%
      GuiControl,, BetFixedAmount33, %BetFixedAmount33%
      GuiControl, ChooseString, BetFixedUnits3, % BetFixedUnits3
      GuiControl,, BetFixedControl4, %BetFixedControl4%
      GuiControl,, BetFixedAmount41, %BetFixedAmount41%
      GuiControl,, BetFixedAmount42, %BetFixedAmount42%
      GuiControl,, BetFixedAmount43, %BetFixedAmount43%
      GuiControl, ChooseString, BetFixedUnits4, % BetFixedUnits4
      GuiControl,, BetFixedControl5, %BetFixedControl5%
      GuiControl,, BetFixedAmount51, %BetFixedAmount51%
      GuiControl,, BetFixedAmount52, %BetFixedAmount52%
      GuiControl,, BetFixedAmount53, %BetFixedAmount53%
      GuiControl, ChooseString, BetFixedUnits5, % BetFixedUnits5
      GuiControl,, ClickBetAfterSettingBetFixedEnabled, %ClickBetAfterSettingBetFixedEnabled%
      GuiControl,, BetMaxControl, %BetMaxControl%
      GuiControl,, BetPotControl, %BetPotControl%
      GuiControl,, FixedBetMultiClickDisabled, %FixedBetMultiClickDisabled%
      GuiControl,, RoundFixedBetToSmallBlindMultiple, %RoundFixedBetToSmallBlindMultiple%

   ; Deal Me Mode
      GuiControl,, SetDealMeModeOnInitialBuyInEnabled, %SetDealMeModeOnInitialBuyInEnabled%
      GuiControl,, DealMeModeStatusTooltipEnabled, %DealMeModeStatusTooltipEnabled%
      GuiControl,, CycleDealMeModesOnActiveTableControl, %CycleDealMeModesOnActiveTableControl%
      GuiControl,, CycleDealMeModesOnAllTablesControl, %CycleDealMeModesOnAllTablesControl%
      GuiControl,, AutoPostBlindsAfterSittingDownEnabled, %AutoPostBlindsAfterSittingDownEnabled%
      GuiControl,, DisableDealMeModeWhenHU, %DisableDealMeModeWhenHU%

   ; SnG A

/*
      GuiControl,, Sng1Description, %Sng1Description%
      GuiControl,, Sng2Description, %Sng2Description%
      GuiControl,, Sng3Description, %Sng3Description%
      GuiControl,, Sng4Description, %Sng4Description%
      GuiControl,, Sng5Description, %Sng5Description%
      GuiControl,, Sng6Description, %Sng6Description%
      GuiControl,, Sng7Description, %Sng7Description%
;      GuiControl,, Sng8Description, %Sng8Description%
;      GuiControl,, Sng9Description, %Sng9Description%
*/
      GuiControl,, Sng11Description, %Sng11Description%
      GuiControl,, Sng12Description, %Sng12Description%
      GuiControl,, Sng13Description, %Sng13Description%
      GuiControl,, Sng14Description, %Sng14Description%
      GuiControl,, Sng15Description, %Sng15Description%
      GuiControl,, Sng16Description, %Sng16Description%
      GuiControl,, Sng17Description, %Sng17Description%


/*      
      GuiControl, ChooseString, Sng1Game, % Sng1Game
      GuiControl, ChooseString, Sng2Game, % Sng2Game
      GuiControl, ChooseString, Sng3Game, % Sng3Game
      GuiControl, ChooseString, Sng4Game, % Sng4Game
      GuiControl, ChooseString, Sng5Game, % Sng5Game
      GuiControl, ChooseString, Sng6Game, % Sng6Game
      GuiControl, ChooseString, Sng7Game, % Sng7Game
      GuiControl, ChooseString, Sng8Game, % Sng8Game
      GuiControl, ChooseString, Sng9Game, % Sng9Game
*/

/*
      ; ?????????????????????????????????????????????????????????????????????????????     can't we use    PSSngFileList here  ?????
      ; we need to create the string of PS Sng types for the SngXGame dropdown box
      ; we will read all the .bmp files in the PS theme folder
      FileList := ""
      Files := A_WorkingDir . "\Themes\" . PSLobbyTheme . "\SngImages\*.bmp"
      Loop, %Files%,0,0
      {
         FileList .= "|" . A_LoopFileName
         ; remove the ".bmp" from file name
         StringTrimRight, FileList, FileList, 4
      }
*/

      ; we must have re-created the PSSngFileList  before calling this function

      GuiControl,,Sng11Game,%PSSngFileList%
      GuiControl,,Sng12Game,%PSSngFileList%
      GuiControl,,Sng13Game,%PSSngFileList%
      GuiControl,,Sng14Game,%PSSngFileList%
      GuiControl,,Sng15Game,%PSSngFileList%
      GuiControl,,Sng16Game,%PSSngFileList%
      GuiControl,,Sng17Game,%PSSngFileList%


      GuiControl, ChooseString, Sng11Game, % Sng11Game
      GuiControl, ChooseString, Sng12Game, % Sng12Game
      GuiControl, ChooseString, Sng13Game, % Sng13Game
      GuiControl, ChooseString, Sng14Game, % Sng14Game
      GuiControl, ChooseString, Sng15Game, % Sng15Game
      GuiControl, ChooseString, Sng16Game, % Sng16Game
      GuiControl, ChooseString, Sng17Game, % Sng17Game


/*
      GuiControl, ChooseString, Sng1Options, % Sng1Options
      GuiControl, ChooseString, Sng2Options, % Sng2Options
      GuiControl, ChooseString, Sng3Options, % Sng3Options
      GuiControl, ChooseString, Sng4Options, % Sng4Options
      GuiControl, ChooseString, Sng5Options, % Sng5Options
      GuiControl, ChooseString, Sng6Options, % Sng6Options
      GuiControl, ChooseString, Sng7Options, % Sng7Options
;      GuiControl, ChooseString, Sng8Options, % Sng8Options
;      GuiControl, ChooseString, Sng9Options, % Sng9Options
      GuiControl, ChooseString, Sng1Type, % Sng1Type
      GuiControl, ChooseString, Sng2Type, % Sng2Type
      GuiControl, ChooseString, Sng3Type, % Sng3Type
      GuiControl, ChooseString, Sng4Type, % Sng4Type
      GuiControl, ChooseString, Sng5Type, % Sng5Type
      GuiControl, ChooseString, Sng6Type, % Sng6Type
      GuiControl, ChooseString, Sng7Type, % Sng7Type
;      GuiControl, ChooseString, Sng8Type, % Sng8Type
;      GuiControl, ChooseString, Sng9Type, % Sng9Type
      GuiControl,, Sng1Cost, %Sng1Cost%
      GuiControl,, Sng2Cost, %Sng2Cost%
      GuiControl,, Sng3Cost, %Sng3Cost%
      GuiControl,, Sng4Cost, %Sng4Cost%
      GuiControl,, Sng5Cost, %Sng5Cost%
      GuiControl,, Sng6Cost, %Sng6Cost%
      GuiControl,, Sng7Cost, %Sng7Cost%
;      GuiControl,, Sng8Cost, %Sng8Cost%
;      GuiControl,, Sng9Cost, %Sng9Cost%

      GuiControl, ChooseString, Sng1Seats, % Sng1Seats
      GuiControl, ChooseString, Sng2Seats, % Sng2Seats
      GuiControl, ChooseString, Sng3Seats, % Sng3Seats
      GuiControl, ChooseString, Sng4Seats, % Sng4Seats
      GuiControl, ChooseString, Sng5Seats, % Sng5Seats
      GuiControl, ChooseString, Sng6Seats, % Sng6Seats
      GuiControl, ChooseString, Sng7Seats, % Sng7Seats
;      GuiControl, ChooseString, Sng8Seats, % Sng8Seats
;      GuiControl, ChooseString, Sng9Seats, % Sng9Seats

      GuiControl,, Sng1NumPlayers, %Sng1NumPlayers%
      GuiControl,, Sng2NumPlayers, %Sng2NumPlayers%
      GuiControl,, Sng3NumPlayers, %Sng3NumPlayers%
      GuiControl,, Sng4NumPlayers, %Sng4NumPlayers%
      GuiControl,, Sng5NumPlayers, %Sng5NumPlayers%
      GuiControl,, Sng6NumPlayers, %Sng6NumPlayers%
      GuiControl,, Sng7NumPlayers, %Sng7NumPlayers%
;      GuiControl,, Sng8NumPlayers, %Sng8NumPlayers%
;      GuiControl,, Sng9NumPlayers, %Sng9NumPlayers%
      GuiControl,, Sng1NumRegPlayersMin, %Sng1NumRegPlayersMin%
      GuiControl,, Sng2NumRegPlayersMin, %Sng2NumRegPlayersMin%
      GuiControl,, Sng3NumRegPlayersMin, %Sng3NumRegPlayersMin%
      GuiControl,, Sng4NumRegPlayersMin, %Sng4NumRegPlayersMin%
      GuiControl,, Sng5NumRegPlayersMin, %Sng5NumRegPlayersMin%
      GuiControl,, Sng6NumRegPlayersMin, %Sng6NumRegPlayersMin%
      GuiControl,, Sng7NumRegPlayersMin, %Sng7NumRegPlayersMin%
;      GuiControl,, Sng8NumRegPlayersMin, %Sng8NumRegPlayersMin%
;      GuiControl,, Sng9NumRegPlayersMin, %Sng9NumRegPlayersMin%
      GuiControl,, Sng1NumSharksMax, %Sng1NumSharksMax%
      GuiControl,, Sng2NumSharksMax, %Sng2NumSharksMax%
      GuiControl,, Sng3NumSharksMax, %Sng3NumSharksMax%
      GuiControl,, Sng4NumSharksMax, %Sng4NumSharksMax%
      GuiControl,, Sng5NumSharksMax, %Sng5NumSharksMax%
      GuiControl,, Sng6NumSharksMax, %Sng6NumSharksMax%
      GuiControl,, Sng7NumSharksMax, %Sng7NumSharksMax%
;      GuiControl,, Sng8NumSharksMax, %Sng8NumSharksMax%
;      GuiControl,, Sng9NumSharksMax, %Sng9NumSharksMax%
      GuiControl,, Sng1LobbyText, %Sng1LobbyText%
      GuiControl,, Sng2LobbyText, %Sng2LobbyText%
      GuiControl,, Sng3LobbyText, %Sng3LobbyText%
      GuiControl,, Sng4LobbyText, %Sng4LobbyText%
      GuiControl,, Sng5LobbyText, %Sng5LobbyText%
      GuiControl,, Sng6LobbyText, %Sng6LobbyText%
      GuiControl,, Sng7LobbyText, %Sng7LobbyText%
;      GuiControl,, Sng8LobbyText, %Sng8LobbyText%
;      GuiControl,, Sng9LobbyText, %Sng9LobbyText%

      GuiControl, ChooseString, Sng1PaymentType, % Sng1PaymentType
      GuiControl, ChooseString, Sng2PaymentType, % Sng2PaymentType
      GuiControl, ChooseString, Sng3PaymentType, % Sng3PaymentType
      GuiControl, ChooseString, Sng4PaymentType, % Sng4PaymentType
      GuiControl, ChooseString, Sng5PaymentType, % Sng5PaymentType
      GuiControl, ChooseString, Sng6PaymentType, % Sng6PaymentType
      GuiControl, ChooseString, Sng7PaymentType, % Sng7PaymentType
;      GuiControl, ChooseString, Sng8PaymentType, % Sng8PaymentType
;      GuiControl, ChooseString, Sng9PaymentType, % Sng9PaymentType
*/


   ; SnG B

/*
      GuiControl,, Sng1DescriptionB, %Sng1Description%
      GuiControl,, Sng2DescriptionB, %Sng2Description%
      GuiControl,, Sng3DescriptionB, %Sng3Description%
      GuiControl,, Sng4DescriptionB, %Sng4Description%
      GuiControl,, Sng5DescriptionB, %Sng5Description%
      GuiControl,, Sng6DescriptionB, %Sng6Description%
      GuiControl,, Sng7DescriptionB, %Sng7Description%
;      GuiControl,, Sng8DescriptionB, %Sng8Description%
;      GuiControl,, Sng9DescriptionB, %Sng9Description%
*/

      GuiControl,, Sng11DescriptionB, %Sng11Description%
      GuiControl,, Sng12DescriptionB, %Sng12Description%
      GuiControl,, Sng13DescriptionB, %Sng13Description%
      GuiControl,, Sng14DescriptionB, %Sng14Description%
      GuiControl,, Sng15DescriptionB, %Sng15Description%
      GuiControl,, Sng16DescriptionB, %Sng16Description%
      GuiControl,, Sng17DescriptionB, %Sng17Description%

/*      
      GuiControl,, Sng1ContinuouslyEnabled, %Sng1ContinuouslyEnabled%
      GuiControl,, Sng2ContinuouslyEnabled, %Sng2ContinuouslyEnabled%
      GuiControl,, Sng3ContinuouslyEnabled, %Sng3ContinuouslyEnabled%
      GuiControl,, Sng4ContinuouslyEnabled, %Sng4ContinuouslyEnabled%
      GuiControl,, Sng5ContinuouslyEnabled, %Sng5ContinuouslyEnabled%
      GuiControl,, Sng6ContinuouslyEnabled, %Sng6ContinuouslyEnabled%
      GuiControl,, Sng7ContinuouslyEnabled, %Sng7ContinuouslyEnabled%
;      GuiControl,, Sng8ContinuouslyEnabled, %Sng8ContinuouslyEnabled%
;      GuiControl,, Sng9ContinuouslyEnabled, %Sng9ContinuouslyEnabled%
*/
      GuiControl,, Sng11ContinuouslyEnabled, %Sng11ContinuouslyEnabled%
      GuiControl,, Sng12ContinuouslyEnabled, %Sng12ContinuouslyEnabled%
      GuiControl,, Sng13ContinuouslyEnabled, %Sng13ContinuouslyEnabled%
      GuiControl,, Sng14ContinuouslyEnabled, %Sng140ContinuouslyEnabled%
      GuiControl,, Sng15ContinuouslyEnabled, %Sng15ContinuouslyEnabled%
      GuiControl,, Sng16ContinuouslyEnabled, %Sng16ContinuouslyEnabled%
      GuiControl,, Sng17ContinuouslyEnabled, %Sng17ContinuouslyEnabled%

      
      
      GuiControl,, SngContinuouslyOpenNumber, %SngContinuouslyOpenNumber%
      GuiControl,, SngStopOpeningAfterNum, %SngStopOpeningAfterNum%
      GuiControl,, SngContinuouslyOpenPlayTime, %SngContinuouslyOpenPlayTime%
      GuiControl,, SngContinuouslyOpenTimerInterval, %SngContinuouslyOpenTimerInterval%
      GuiControl,, SngContinuouslyOpenFailSafeTime, %SngContinuouslyOpenFailSafeTime%
      

      GuiControl,, ClickOkForSngEnabled, %ClickOkForSngEnabled%




      
      
 
      ; SnG C
      
      GuiControl,, AutoClickImBackButtonEnabled, %AutoClickImBackButtonEnabled%
      GuiControl,, ClickImReadyEnabled, %ClickImReadyEnabled%
      GuiControl,, AutoCloseTournamentLobbyEnabled, %AutoCloseTournamentLobbyEnabled%
      GuiControl,, MinimizeSngLobbyEnabled, %MinimizeSngLobbyEnabled%
      GuiControl,, UseCriticalMethodDisabled, %UseCriticalMethodDisabled%
      GuiControl,, AutoClickInfoRefreshEnabled, %AutoClickInfoRefreshEnabled%
      GuiControl,, AutoClickInfoRefreshInterval, %AutoClickInfoRefreshInterval%
      GuiControl,, CloseFinishedSngTablesEnabled, %CloseFinishedSngTablesEnabled%
      GuiControl,, CloseTourneyTablesIfNotSeatedEnabled, %CloseTourneyTablesIfNotSeatedEnabled%
      GuiControl,, CloseTableTimeDelay, %CloseTableTimeDelay%


   
;      GuiControl,, Sng1OpenControl, %Sng1OpenControl%
      GuiControl,, Sng11OpenControl, %Sng11OpenControl%
      GuiControl,, PSSngOpenHighlightedControl, %PSSngOpenHighlightedControl%
      GuiControl,, FTSngOpenHighlightedControl, %FTSngOpenHighlightedControl%      
      
      GuiControl,, OneClickSngRegisteringEnabled, %OneClickSngRegisteringEnabled%      
      

      
      
   ; Actions1
;      GuiControl,, BettingControlsEnabled, %BettingControlsEnabled%
      GuiControl,, FoldCheckControl, %FoldCheckControl%
      GuiControl,, CallControl, %CallControl%
      GuiControl,, BetRaiseControl, %BetRaiseControl%
      GuiControl,, LeftCheckboxControl, %LeftCheckboxControl%
      GuiControl,, MiddleCheckboxControl, %MiddleCheckboxControl%
      GuiControl,, CallAnyControl, %CallAnyControl%
      GuiControl,, RaiseMinControl, %RaiseMinControl%
      GuiControl,, RaiseAnyControl, %RaiseAnyControl%
      GuiControl,, BetWindowClearControl, %BetWindowClearControl%
      GuiControl,, FoldToAnyBetControl, %FoldToAnyBetControl%
;      GuiControl,, PreActionControlsEnabled, %PreActionControlsEnabled%
      GuiControl,, PreActionFoldControlEnabled, %PreActionFoldControlEnabled%
      GuiControl,, PreActionCallControlEnabled, %PreActionCallControlEnabled%

   ; Actions2
      GuiControl,, PlayersNameControl, %PlayersNameControl%
;      GuiControl,, PlayersNameToSharkListControl, %PlayersNameToSharkListControl%
;      GuiControl,, PlayersNameFromSharkListControl, %PlayersNameFromSharkListControl%
      GuiControl,, TableTournamentIdControl, %TableTournamentIdControl%
      GuiControl,, ReloadChipsControl, %ReloadChipsControl%
      GuiControl,, LobbyToggleAutoMuckHandsControl, %LobbyToggleAutoMuckHandsControl%
;      GuiControl,, ReloadAllControl, %ReloadAllControl%
      GuiControl,, TableMoveToFromChatControl, %TableMoveToFromChatControl%
      GuiControl,, TimerControl, %TimerControl%
      GuiControl,, TimerAllControl, %TimerAllControl%
      GuiControl,, LastHandControl, %LastHandControl%
      GuiControl,, TourneyInfoControl, %TourneyInfoControl%
      GuiControl,, NotesControl, %NotesControl%
      GuiControl,, NotesNanoControl, %NotesNanoControl%
      GuiControl,, NotesPlayerNControl, %NotesPlayerNControl%
      GuiControl,, NotesOpenPlayerNControl, %NotesOpenPlayerNControl%
      GuiControl,, NotesNanoPlayerNControl, %NotesNanoPlayerNControl%
      GuiControl, ChooseString, NotesNanoInitialColor, % NotesNanoInitialColor
      GuiControl,, NotesColorNControl, %NotesColorNControl%
      GuiControl,, NotesNanoColorUpControl, %NotesNanoColorUpControl%
      GuiControl,, NotesNanoColorDownControl, %NotesNanoColorDownControl%
      GuiControl,, NotesCloseControl, %NotesCloseControl%


   ; Actions3
      GuiControl,, ToggleSitOutControl, %ToggleSitOutControl%
      GuiControl,, SitInOnAllControl, %SitInOnAllControl%
      GuiControl,, SitOutOnAllControl, %SitOutOnAllControl%
      GuiControl,, ToggleAPBControl, %ToggleAPBControl%
      GuiControl,, TableCloseActiveControl, %TableCloseActiveControl%
      GuiControl,, TableCloseActiveWithoutHeroControl, %TableCloseActiveWithoutHeroControl%
      GuiControl,, TableCloseAllControl, %TableCloseAllControl%
      GuiControl,, TableCloseAllWithoutHeroControl, %TableCloseAllWithoutHeroControl%
      GuiControl,, TableMinimizeAllControl, %TableMinimizeAllControl%
      GuiControl,, TableMinimizeAllWithoutHeroControl, %TableMinimizeAllWithoutHeroControl%
      GuiControl,, OpenCashierControl, %OpenCashierControl%
      GuiControl,, LobbyTournamentCloseControl, %LobbyTournamentCloseControl%
      GuiControl,, LobbyTournamentMinimizeControl, %LobbyTournamentMinimizeControl%
      
      GuiControl,, TableNextControl, %TableNextControl%
      GuiControl,, TablePreviousControl, %TablePreviousControl%
      GuiControl,, TableLeftControl, %TableLeftControl%
      GuiControl,, TableRightControl, %TableRightControl%
      GuiControl,, TableUpControl, %TableUpControl%
      GuiControl,, TableDownControl, %TableDownControl%
      GuiControl,, TableBottomOfStackControl, %TableBottomOfStackControl%
      GuiControl,, TableNextInStackControl, %TableNextInStackControl%

      GuiControl,, TablePendingControl, %TablePendingControl%
      GuiControl,, TableLayout1Control, %TableLayout1Control%
      GuiControl,, TableLayout2Control, %TableLayout2Control%
      GuiControl,, TablesCascadeControl, %TablesCascadeControl%
      GuiControl,, TablesTileControl, %TablesTileControl%


   ; Gary's code
;      GuiControl,, NotesNanoAllControl, %NotesNanoAllControl%
;      GuiControl,, NotesNanoSetSharkScopeColorAllControl, %NotesNanoSetSharkScopeColorAllControl%

   ; Displays
      GuiControl,, OsdBettingInfoEnabled, %OsdBettingInfoEnabled%
      GuiControl,, OsdBettingInfoPosX, %OsdBettingInfoPosX%
      GuiControl,, OsdBettingInfoPosY, %OsdBettingInfoPosY%
      GuiControl,, OsdBettingInfoColor, %OsdBettingInfoColor%
      GuiControl,, OsdBettingInfoFontSize, %OsdBettingInfoFontSize%
      GuiControl,, OsdBettingInfoFont, %OsdBettingInfoFont%
      GuiControl,, OsdBettingInfoText, %OsdBettingInfoText%
;      GuiControl,, TooltipBettingInfoEnabled, %TooltipBettingInfoEnabled%
;      GuiControl,, TooltipBettingInfoPosX, %TooltipBettingInfoPosX%
;      GuiControl,, TooltipBettingInfoPosY, %TooltipBettingInfoPosY%
;      GuiControl,, TooltipBettingInfoText, %TooltipBettingInfoText%
      GuiControl,, DisplayOsd3Enabled, %DisplayOsd3Enabled%
      GuiControl,, DisplayOsd3PosX, %DisplayOsd3PosX%
      GuiControl,, DisplayOsd3PosY, %DisplayOsd3PosY%
      GuiControl,, DisplayOsd3Color, %DisplayOsd3Color%
      GuiControl,, DisplayOsd3FontSize, %DisplayOsd3FontSize%
      GuiControl,, DisplayOsd3Font, %DisplayOsd3Font%
      GuiControl,, DisplayOsd3Text, %DisplayOsd3Text%
      GuiControl,, DisplayOsd4Enabled, %DisplayOsd4Enabled%
      GuiControl,, DisplayOsd4PosX, %DisplayOsd4PosX%
      GuiControl,, DisplayOsd4PosY, %DisplayOsd4PosY%
      GuiControl,, DisplayOsd4Color, %DisplayOsd4Color%
      GuiControl,, DisplayOsd4FontSize, %DisplayOsd4FontSize%
      GuiControl,, DisplayOsd4Font, %DisplayOsd4Font%
      GuiControl,, DisplayOsd4Text, %DisplayOsd4Text%
      
      GuiControl,, DisplayOsd5Enabled, %DisplayOsd5Enabled%
      GuiControl,, DisplayOsd5PosX, %DisplayOsd5PosX%
      GuiControl,, DisplayOsd5PosY, %DisplayOsd5PosY%
      GuiControl,, DisplayOsd5Color, %DisplayOsd5Color%
      GuiControl,, DisplayOsd5FontSize, %DisplayOsd5FontSize%
      GuiControl,, DisplayOsd5Font, %DisplayOsd5Font%
      GuiControl,, DisplayOsd5Text, %DisplayOsd5Text%
      
;      GuiControl,, TooltipStackInfoEnabled, %TooltipStackInfoEnabled%
;      GuiControl,, TooltipStackInfoText, %TooltipStackInfoText%
      GuiControl,, DisplayOsdStackInfoInRingGamesEnabled, %DisplayOsdStackInfoInRingGamesEnabled%
      GuiControl,, DisplayOsdBetInfoInLimitGamesEnabled, %DisplayOsdBetInfoInLimitGamesEnabled%
      GuiControl,, ChatWarningEnabled, %ChatWarningEnabled%
      GuiControl,, DisplayOsd3AllTablesEnabled, %DisplayOsd3AllTablesEnabled%
      GuiControl,, DisplayOsd4AllTablesEnabled, %DisplayOsd4AllTablesEnabled%
      GuiControl,, DisplayDebugInfoEnabled, %DisplayDebugInfoEnabled%
      GuiControl,, DebugTooltipPosX, %DebugTooltipPosX%
      GuiControl,, DebugTooltipPosY, %DebugTooltipPosY%
      GuiControl,, RefreshOSD1Control, %RefreshOSD1Control%

/*
   ; Chips
      GuiControl,, AutoClickOkOnGetChipsDialogEnabled, %AutoClickOkOnGetChipsDialogEnabled%
      GuiControl,, NLReloadAmount, %NLReloadAmount%
      GuiControl,, CapReloadAmount, %CapReloadAmount%
      GuiControl,, LimitReloadAmount, %LimitReloadAmount%
      GuiControl,, ManualReloadWhenGetChipsIsClicked, %ManualReloadWhenGetChipsIsClicked%
      GuiControl,, AssumeStackIs0WhenSittingOutEnabled, %AssumeStackIs0WhenSittingOutEnabled%
*/

   ; Table1
      GuiControl,, ActiveTableHighlighterEnabled, %ActiveTableHighlighterEnabled%
      GuiControl,, ActiveTableHighlighterColor, %ActiveTableHighlighterColor%
      GuiControl,, TableHighlighterTransperancy, %TableHighlighterTransperancy%
      GuiControl,, TableHighlighterSize, %TableHighlighterSize%
      GuiControl,, ActiveTableAndPendingHighlighterEnabled, %ActiveTableAndPendingHighlighterEnabled%
      GuiControl,, ActiveTableAndPendingHighlighterColor, %ActiveTableAndPendingHighlighterColor%
;      GuiControl,, PendingActionHighlighterEnabled, %PendingActionHighlighterEnabled%
;      GuiControl,, PendingActionHighlighterColor, %PendingActionHighlighterColor%
      GuiControl,, TableAutoActivateDisabled, %TableAutoActivateDisabled%
      GuiControl,, ActivateTableOnMouseOverEnabled, %ActivateTableOnMouseOverEnabled%

      GuiControl,, AutoActivateNextPendingTableEnabled, %AutoActivateNextPendingTableEnabled%
;      GuiControl,, PutImBackButtonTablesIntoPendingListEnabled, %PutImBackButtonTablesIntoPendingListEnabled%
;      GuiControl,, AutoActivateTopTableEnabled, %AutoActivateTopTableEnabled%
      GuiControl,, MoveTableEnabled, %MoveTableEnabled%
      GuiControl,, MoveTablePosX, %MoveTablePosX%
      GuiControl,, MoveTablePosY, %MoveTablePosY%
      GuiControl,, MoveTableWidth, %MoveTableWidth%
      GuiControl,, MouseToHomeEnabled, %MouseToHomeEnabled%
      GuiControl,, ActivateTableOnMouseOverIfMouseToHomeEnabled, %ActivateTableOnMouseOverIfMouseToHomeEnabled%
      GuiControl,, ManualMoveTableControl, %ManualMoveTableControl%
      GuiControl,, ManualMoveTablePosX, %ManualMoveTablePosX%
      GuiControl,, ManualMoveTablePosY, %ManualMoveTablePosY%
      GuiControl,, ManualMoveTableWidth, %ManualMoveTableWidth%

      GuiControl,, ManualMoveTable2Control, %ManualMoveTable2Control%
      GuiControl,, ManualMoveTable2PosX, %ManualMoveTable2PosX%
      GuiControl,, ManualMoveTable2PosY, %ManualMoveTable2PosY%
      GuiControl,, ManualMoveTable2Width, %ManualMoveTable2Width%



   ; Table2
      GuiControl, ChooseString, TableSize, % TableSize
      GuiControl,, TableWidthA, %TableWidthA%
      GuiControl,, TableWidthB, %TableWidthB%
      GuiControl,, TableWidthC, %TableWidthC%
      GuiControl,, TableWidthD, %TableWidthD%
      GuiControl,, TableWidthE, %TableWidthE%
      GuiControl,, TableWidthF, %TableWidthF%





   ; Dialog boxes
      GuiControl,, AutoLogInEnabled, %AutoLogInEnabled%
      GuiControl,, DenyReLoginAttemptedEnabled, %DenyReLoginAttemptedEnabled%
      GuiControl,, CloseAnnouncementsDialogEnabled, %CloseAnnouncementsDialogEnabled%
      GuiControl,, CloseFoldCallDialogEnabled, %CloseFoldCallDialogEnabled%
;      GuiControl,, CloseRemovedFromWaitingListDialogEnabled, %CloseRemovedFromWaitingListDialogEnabled%
      GuiControl,, RejectSeatIfSeatAvailableEnabled, %RejectSeatIfSeatAvailableEnabled%
      GuiControl,, RejectSeatControl, %RejectSeatControl%
      GuiControl,, TakeSeatIfSeatAvailableEnabled, %TakeSeatIfSeatAvailableEnabled%
      GuiControl,, PopSeatAvailDialogToTopEnabled, %PopSeatAvailDialogToTopEnabled%
      GuiControl,, CloseAutoPostBlindsDialogEnabled, %CloseAutoPostBlindsDialogEnabled%
      GuiControl,, CloseLeaveTableDialogEnabled, %CloseLeaveTableDialogEnabled%
      GuiControl,, CloseLeaveSeatDialogEnabled, %CloseLeaveSeatDialogEnabled%
      GuiControl,, CloseEducationalTableDialogEnabled, %CloseEducationalTableDialogEnabled%
      GuiControl,, CloseTableHasBeenClosedEnabled, %CloseTableHasBeenClosedEnabled%
      
;      GuiControl,, CloseWereSorryRegClosedDialogEnabled, %CloseWereSorryRegClosedDialogEnabled%
      GuiControl,, CloseYouFinishedTheTournamentDialogEnabled, %CloseYouFinishedTheTournamentDialogEnabled%
      GuiControl,, CloseDialogDelay, %CloseDialogDelay%
      
;      GuiControl,, CloseTooManyWindowsOpenDialogEnabled, %CloseTooManyWindowsOpenDialogEnabled%
;      GuiControl,, CloseYouCannotRegisterMoreTrnysDialogEnabled, %CloseYouCannotRegisterMoreTrnysDialogEnabled%
      GuiControl,, CloseOneButtonStarsDialogsEnabled, %CloseOneButtonStarsDialogsEnabled%
      GuiControl,, CloseOneButtonFullTiltDialogsEnabled, %CloseOneButtonFullTiltDialogsEnabled%

      GuiControl,, AutoClickOkOnGetChipsDialogEnabled, %AutoClickOkOnGetChipsDialogEnabled%



;      GuiControl,, CloseDialogBoxesUsingImageRecogEnabled, %CloseDialogBoxesUsingImageRecogEnabled%


   ; Misc tab



      GuiControl,, AutoClickTimerEnabled, %AutoClickTimerEnabled%
      GuiControl,, TimeButtonWaitTime, %TimeButtonWaitTime%
      GuiControl,, AutoClickTimerIfBetBoxEnabled, %AutoClickTimerIfBetBoxEnabled%
      GuiControl,, TimeButtonIfPendingActionWaitTime, %TimeButtonIfPendingActionWaitTime%



      GuiControl,, MinimizeShortcutsEnabled, %MinimizeShortcutsEnabled%
      GuiControl,, UseMouseMovementToClickButtonsEnabled, %UseMouseMovementToClickButtonsEnabled%      
      
      GuiControl, ChooseString, JoyNum, % JoyNum
      GuiControl,, ShowJoystickValueEnabled, %ShowJoystickValueEnabled%
      GuiControl,, KeyListToDisableShortcuts, %KeyListToDisableShortcuts%
      


;      GuiControl,, SafetyDelay5, %SafetyDelay5%
;      GuiControl,, SafetyDelay6, %SafetyDelay6%
      GuiControl, ChooseString, ShortcutsProcessPriority, % ShortcutsProcessPriority
      GuiControl, ChooseString, FullTiltProcessPriority, % FullTiltProcessPriority
      GuiControl, ChooseString, PokerStarsProcessPriority, % PokerStarsProcessPriority


   ; Calib

   ; the calibration tab just contains color progress bars that are defined in the table theme .ini files

;      GuiControl +Background%ColorBehindFlopCard%, ColorFlop
;PlayerEmptySeatColorSeats9Seat1Display    9,8,6,2
;PSTableTheme1
;FTTableTheme1
;PSFlopColorDisplay  4
;FTFlopColorDisplay  4

;outputdebug, flopcolor:%FTFlopColor%

   GuiControl,, PSTableTheme1, %PSTableTheme%
   GuiControl,, FTTableTheme1, %FTTableTheme%
   
   GuiControl +Background%PSFlopColor%, PSFlopColorDisplay
   GuiControl +Background%PSTurnColor%, PSTurnColorDisplay
   GuiControl +Background%PSRiverColor%, PSRiverColorDisplay
   GuiControl +Background%PSTestColor%, PSTestColorDisplay

   GuiControl +Background%FTFlopColor%, FTFlopColorDisplay
   GuiControl +Background%FTTurnColor%, FTTurnColorDisplay
   GuiControl +Background%FTRiverColor%, FTRiverColorDisplay
   GuiControl +Background%FTTestColor%, FTTestColorDisplay

   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat1%, FTPlayerEmptySeatColorSeats9Seat1Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat2%, FTPlayerEmptySeatColorSeats9Seat2Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat3%, FTPlayerEmptySeatColorSeats9Seat3Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat4%, FTPlayerEmptySeatColorSeats9Seat4Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat5%, FTPlayerEmptySeatColorSeats9Seat5Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat6%, FTPlayerEmptySeatColorSeats9Seat6Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat7%, FTPlayerEmptySeatColorSeats9Seat7Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat8%, FTPlayerEmptySeatColorSeats9Seat8Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats9Seat9%, FTPlayerEmptySeatColorSeats9Seat9Display

   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat1%, FTPlayerEmptySeatColorSeats8Seat1Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat2%, FTPlayerEmptySeatColorSeats8Seat2Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat3%, FTPlayerEmptySeatColorSeats8Seat3Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat4%, FTPlayerEmptySeatColorSeats8Seat4Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat5%, FTPlayerEmptySeatColorSeats8Seat5Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat6%, FTPlayerEmptySeatColorSeats8Seat6Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat7%, FTPlayerEmptySeatColorSeats8Seat7Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats8Seat8%, FTPlayerEmptySeatColorSeats8Seat8Display

   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat1%, FTPlayerEmptySeatColorSeats6Seat1Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat2%, FTPlayerEmptySeatColorSeats6Seat2Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat3%, FTPlayerEmptySeatColorSeats6Seat3Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat4%, FTPlayerEmptySeatColorSeats6Seat4Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat5%, FTPlayerEmptySeatColorSeats6Seat5Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats6Seat6%, FTPlayerEmptySeatColorSeats6Seat6Display

   GuiControl +Background%FTPlayerEmptySeatColorSeats2Seat1%, FTPlayerEmptySeatColorSeats2Seat1Display
   GuiControl +Background%FTPlayerEmptySeatColorSeats2Seat2%, FTPlayerEmptySeatColorSeats2Seat2Display






   ; Setup tab
      GuiControl,, CurrentSetDescription, %CurrentSetDescription%
;      GuiControl,, CodeType, %CodeType%
   
      GuiControl,, FTMouseHomePosX, %FTMouseHomePosX%
      GuiControl,, FTMouseHomePosY, %FTMouseHomePosY%

      GuiControl,, FTOsdBettingInfoPosX, %FTOsdBettingInfoPosX%
      GuiControl,, FTOsdBettingInfoPosY, %FTOsdBettingInfoPosY%
      GuiControl,, FTDisplayOsd3PosX, %FTDisplayOsd3PosX%
      GuiControl,, FTDisplayOsd3PosY, %FTDisplayOsd3PosY%
      GuiControl,, FTDisplayOsd4PosX, %FTDisplayOsd4PosX%
      GuiControl,, FTDisplayOsd4PosY, %FTDisplayOsd4PosY%
      GuiControl,, FTDisplayOsd5PosX, %FTDisplayOsd5PosX%
      GuiControl,, FTDisplayOsd5PosY, %FTDisplayOsd5PosY%
      
      GuiControl,, PSMouseHomePosX, %PSMouseHomePosX%
      GuiControl,, PSMouseHomePosY, %PSMouseHomePosY%

      GuiControl,, PSOsdBettingInfoPosX, %PSOsdBettingInfoPosX%
      GuiControl,, PSOsdBettingInfoPosY, %PSOsdBettingInfoPosY%
      GuiControl,, PSDisplayOsd3PosX, %PSDisplayOsd3PosX%
      GuiControl,, PSDisplayOsd3PosY, %PSDisplayOsd3PosY%
      GuiControl,, PSDisplayOsd4PosX, %PSDisplayOsd4PosX%
      GuiControl,, PSDisplayOsd4PosY, %PSDisplayOsd4PosY%
      GuiControl,, PSDisplayOsd5PosX, %PSDisplayOsd5PosX%
      GuiControl,, PSDisplayOsd5PosY, %PSDisplayOsd5PosY%
      
      GuiControl,, PSSettingsFolder, %PSSettingsFolder%
      GuiControl,, PSHHFolder, %PSHHFolder%
      GuiControl,, FTHHFolder, %FTHHFolder%




      ; update variables that are dependent on other gui variables
      ;SettingsUpdateDependentVariables("All")

; reset flag since we are done updating the gui
GuiSoftwareUpdateFlag := 0

;   Critical, Off


}


; read the settings for the desired setting number 1-9
; if the setting number is 0, then read the settings from the OLD group called Prefs
SettingsWrite(pSettingNum)
{
   global
   local SectionLabel, vX, vY, vW, vH

;outputdebug, in settings write

   ; turn off the timer that may have been used to save the settings (from SettingsUpdateHotkeys())
   SetTimer, SettingsWrite, Off



   ; if settingnum is 1-9
   if pSettingNum
   {
      SectionLabel := "Section" . pSettingNum
   }
   ; else if it is 0
   else
   {
      SectionLabel := "Prefs"
   }



   ; save items to the [Prefs] section

   ;get the current window position and size

   WinGetPos, vX, vY, vW, vH, Poker Shortcuts ahk_class AutoHotkeyGUI

;outputdebug, x=%vX%  y=%vY%  title=%Title%

   IniWrite, %vX%, Settings\PokerShortcuts.ini, Prefs, GuiX
   IniWrite, %vY%, Settings\PokerShortcuts.ini, Prefs, GuiY


   ; save the unlock code


   ; save the current version in the preferences
   IniWrite , %Ver%, Settings\PokerShortcuts.ini, Prefs, Ver

   IniWrite , %CurrentSetNum%, Settings\PokerShortcuts.ini, Prefs, CurrentSetNum

   IniWrite , %PSSettingsFolder%, Settings\PokerShortcuts.ini, Prefs, PSSettingsFolder
   IniWrite , %PSHHFolder%, Settings\PokerShortcuts.ini, Prefs, PSHHFolder
   IniWrite , %FTHHFolder%, Settings\PokerShortcuts.ini, Prefs, FTHHFolder



   ; save items to the [SectionX] section


   ; Street Bet - Ring Games
   IniWrite , %StreetBetControl%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetControl
   IniWrite , %StreetBetPreFlopAmountAct1Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click1R
   IniWrite , %StreetBetFlopAmountAct1Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click1R
   IniWrite , %StreetBetTurnAmountAct1Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click1R
   IniWrite , %StreetBetRiverAmountAct1Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click1R
   IniWrite , %StreetBetPreFlopAmountAct0Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click1R
   IniWrite , %StreetBetFlopAmountAct0Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click1R
   IniWrite , %StreetBetTurnAmountAct0Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click1R
   IniWrite , %StreetBetRiverAmountAct0Click1R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click1R
   IniWrite , %StreetBetPreFlopAmountAct1Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click2R
   IniWrite , %StreetBetFlopAmountAct1Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click2R
   IniWrite , %StreetBetTurnAmountAct1Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click2R
   IniWrite , %StreetBetRiverAmountAct1Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click2R
   IniWrite , %StreetBetPreFlopAmountAct0Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click2R
   IniWrite , %StreetBetFlopAmountAct0Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click2R
   IniWrite , %StreetBetTurnAmountAct0Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click2R
   IniWrite , %StreetBetRiverAmountAct0Click2R%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click2R
   IniWrite , %AutoSetBetRingEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoSetBetBetRingEnabled
   IniWrite , %ClickBetAfterSettingStreetBetRingEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingStreetBetRingEnabled
   IniWrite , %RoundStreetBetRingToSmallBlindMultiple%, Settings\PokerShortcuts.ini, %SectionLabel%, RoundStreetBetRingToSmallBlindMultiple


   ; Street Bet - Tournaments and SnGs
   IniWrite , %StreetBetPreFlopAmountAct1Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click1T
   IniWrite , %StreetBetFlopAmountAct1Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click1T
   IniWrite , %StreetBetTurnAmountAct1Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click1T
   IniWrite , %StreetBetRiverAmountAct1Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click1T
   IniWrite , %StreetBetPreFlopAmountAct0Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click1T
   IniWrite , %StreetBetFlopAmountAct0Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click1T
   IniWrite , %StreetBetTurnAmountAct0Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click1T
   IniWrite , %StreetBetRiverAmountAct0Click1T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click1T
   IniWrite , %StreetBetPreFlopAmountAct1Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct1Click2T
   IniWrite , %StreetBetFlopAmountAct1Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct1Click2T
   IniWrite , %StreetBetTurnAmountAct1Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct1Click2T
   IniWrite , %StreetBetRiverAmountAct1Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct1Click2T
   IniWrite , %StreetBetPreFlopAmountAct0Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetPreFlopAmountAct0Click2T
   IniWrite , %StreetBetFlopAmountAct0Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetFlopAmountAct0Click2T
   IniWrite , %StreetBetTurnAmountAct0Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetTurnAmountAct0Click2T
   IniWrite , %StreetBetRiverAmountAct0Click2T%, Settings\PokerShortcuts.ini, %SectionLabel%, StreetBetRiverAmountAct0Click2T
   IniWrite , %AutoSetBetTrnyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoSetBetTrnyEnabled
   IniWrite , %ClickBetAfterSettingStreetBetTrnyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingStreetBetTrnyEnabled
   IniWrite , %RoundStreetBetTrnyToSmallBlindMultiple%, Settings\PokerShortcuts.ini, %SectionLabel%, RoundStreetBetTrnyToSmallBlindMultiple

   ; Inc/Dec Bet
   ; these first 2 are now not changeable by user
   IniWrite , %VarBetControlUp1%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp1
   IniWrite , %VarBetControlDown1%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown1
   IniWrite , %VarBetAmount1%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount1
   IniWrite , %VarBetUnits1%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits1
   IniWrite , %VarBetControlUp2%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp2
   IniWrite , %VarBetControlDown2%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown2
   IniWrite , %VarBetAmount2%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount2
   IniWrite , %VarBetUnits2%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits2
   IniWrite , %VarBetControlUp3%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp3
   IniWrite , %VarBetControlDown3%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown3
   IniWrite , %VarBetAmount3%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount3
   IniWrite , %VarBetUnits3%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits3
   IniWrite , %VarBetControlUp4%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlUp4
   IniWrite , %VarBetControlDown4%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetControlDown4
   IniWrite , %VarBetAmount4%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetAmount4
   IniWrite , %VarBetUnits4%, Settings\PokerShortcuts.ini, %SectionLabel%, VarBetUnits4
   IniWrite , %RoundVarBetToSmallBlindMultiple%, Settings\PokerShortcuts.ini, %SectionLabel%, RoundVarBetToSmallBlindMultiple
;   IniWrite , %MouseWheelOnFullTiltDisabled%, Settings\PokerShortcuts.ini, %SectionLabel%, MouseWheelOnFullTiltDisabled

   ; Fixed Bet
   IniWrite , %BetFixedControl1%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl1
   IniWrite , %BetFixedAmount11%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount11
   IniWrite , %BetFixedAmount12%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount12
   IniWrite , %BetFixedAmount13%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount13
   IniWrite , %BetFixedUnits1%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits1
   
   IniWrite , %BetFixedControl2%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl2
   IniWrite , %BetFixedAmount21%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount21
   IniWrite , %BetFixedAmount22%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount22
   IniWrite , %BetFixedAmount23%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount23
   IniWrite , %BetFixedUnits2%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits2
   
   IniWrite , %BetFixedControl3%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl3
   IniWrite , %BetFixedAmount31%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount31
   IniWrite , %BetFixedAmount32%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount32
   IniWrite , %BetFixedAmount33%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount33
   IniWrite , %BetFixedUnits3%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits3
   
   IniWrite , %BetFixedControl4%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl4
   IniWrite , %BetFixedAmount41%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount41
   IniWrite , %BetFixedAmount42%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount42
   IniWrite , %BetFixedAmount43%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount43
   IniWrite , %BetFixedUnits4%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits4
   
   IniWrite , %BetFixedControl5%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedControl5
   IniWrite , %BetFixedAmount51%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount51
   IniWrite , %BetFixedAmount52%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount52
   IniWrite , %BetFixedAmount53%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedAmount53
   IniWrite , %BetFixedUnits5%, Settings\PokerShortcuts.ini, %SectionLabel%, BetFixedUnits5
   
   IniWrite , %ClickBetAfterSettingBetFixedEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ClickBetAfterSettingBetFixedEnabled
   IniWrite , %FixedBetMultiClickDisabled%, Settings\PokerShortcuts.ini, %SectionLabel%, FixedBetMultiClickDisabled
   IniWrite , %BetMaxControl%, Settings\PokerShortcuts.ini, %SectionLabel%, BetMaxControl
   IniWrite , %BetPotControl%, Settings\PokerShortcuts.ini, %SectionLabel%, BetPotControl
   IniWrite , %RoundFixedBetToSmallBlindMultiple%, Settings\PokerShortcuts.ini, %SectionLabel%, RoundFixedBetToSmallBlindMultiple

   ; Deal Me Mode
   IniWrite , %SetDealMeModeOnInitialBuyInEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, SetDealMeModeOnInitialBuyInEnabled
   IniWrite , %DealMeModeStatusTooltipEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DealMeModeStatusTooltipEnabled
   IniWrite , %CycleDealMeModesOnActiveTableControl%, Settings\PokerShortcuts.ini, %SectionLabel%, CycleDealMeModesOnActiveTableControl
   IniWrite , %CycleDealMeModesOnAllTablesControl%, Settings\PokerShortcuts.ini, %SectionLabel%, CycleDealMeModesOnAllTablesControl
   IniWrite , %AutoPostBlindsAfterSittingDownEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoPostBlindsAfterSittingDownEnabled
   IniWrite , %DisableDealMeModeWhenHU%, Settings\PokerShortcuts.ini, %SectionLabel%, DisableDealMeModeWhenHU


   ; SnG A
   
/*   
   IniWrite , %Sng1Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Description
   IniWrite , %Sng2Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Description
   IniWrite , %Sng3Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Description
   IniWrite , %Sng4Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Description
   IniWrite , %Sng5Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Description
   IniWrite , %Sng6Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Description
   IniWrite , %Sng7Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Description
;   IniWrite , %Sng8Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Description
;   IniWrite , %Sng9Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Description
*/

   IniWrite , %Sng11Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11Description
   IniWrite , %Sng12Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12Description
   IniWrite , %Sng13Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13Description
   IniWrite , %Sng14Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14Description
   IniWrite , %Sng15Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15Description
   IniWrite , %Sng16Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16Description
   IniWrite , %Sng17Description%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17Description


/*
   IniWrite , %Sng1Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Game
   IniWrite , %Sng2Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Game
   IniWrite , %Sng3Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Game
   IniWrite , %Sng4Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Game
   IniWrite , %Sng5Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Game
   IniWrite , %Sng6Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Game
   IniWrite , %Sng7Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Game
;   IniWrite , %Sng8Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Game
;   IniWrite , %Sng9Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Game
*/

   IniWrite , %Sng11Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11Game
   IniWrite , %Sng12Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12Game
   IniWrite , %Sng13Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13Game
   IniWrite , %Sng14Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14Game
   IniWrite , %Sng15Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15Game
   IniWrite , %Sng16Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16Game
   IniWrite , %Sng17Game%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17Game

/*   
   IniWrite , %Sng1Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Options
   IniWrite , %Sng2Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Options
   IniWrite , %Sng3Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Options
   IniWrite , %Sng4Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Options
   IniWrite , %Sng5Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Options
   IniWrite , %Sng6Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Options
   IniWrite , %Sng7Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Options
;   IniWrite , %Sng8Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Options
;   IniWrite , %Sng9Options%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Options
   IniWrite , %Sng1Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Type
   IniWrite , %Sng2Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Type
   IniWrite , %Sng3Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Type
   IniWrite , %Sng4Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Type
   IniWrite , %Sng5Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Type
   IniWrite , %Sng6Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Type
   IniWrite , %Sng7Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Type
;   IniWrite , %Sng8Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Type
;   IniWrite , %Sng9Type%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Type
   IniWrite , %Sng1Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Cost
   IniWrite , %Sng2Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Cost
   IniWrite , %Sng3Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Cost
   IniWrite , %Sng4Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Cost
   IniWrite , %Sng5Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Cost
   IniWrite , %Sng6Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Cost
   IniWrite , %Sng7Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Cost
;   IniWrite , %Sng8Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Cost
;   IniWrite , %Sng9Cost%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Cost

   IniWrite , %Sng1Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1Seats
   IniWrite , %Sng2Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2Seats
   IniWrite , %Sng3Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3Seats
   IniWrite , %Sng4Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4Seats
   IniWrite , %Sng5Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5Seats
   IniWrite , %Sng6Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6Seats
   IniWrite , %Sng7Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7Seats
;   IniWrite , %Sng8Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8Seats
;   IniWrite , %Sng9Seats%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9Seats

   IniWrite , %Sng1NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumPlayers
   IniWrite , %Sng2NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumPlayers
   IniWrite , %Sng3NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumPlayers
   IniWrite , %Sng4NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumPlayers
   IniWrite , %Sng5NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumPlayers
   IniWrite , %Sng6NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumPlayers
   IniWrite , %Sng7NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumPlayers
;   IniWrite , %Sng8NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumPlayers
;   IniWrite , %Sng9NumPlayers%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumPlayers
   IniWrite , %Sng1NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumRegPlayersMin
   IniWrite , %Sng2NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumRegPlayersMin
   IniWrite , %Sng3NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumRegPlayersMin
   IniWrite , %Sng4NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumRegPlayersMin
   IniWrite , %Sng5NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumRegPlayersMin
   IniWrite , %Sng6NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumRegPlayersMin
   IniWrite , %Sng7NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumRegPlayersMin
;   IniWrite , %Sng8NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumRegPlayersMin
;   IniWrite , %Sng9NumRegPlayersMin%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumRegPlayersMin
   IniWrite , %Sng1NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1NumSharksMax
   IniWrite , %Sng2NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2NumSharksMax
   IniWrite , %Sng3NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3NumSharksMax
   IniWrite , %Sng4NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4NumSharksMax
   IniWrite , %Sng5NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5NumSharksMax
   IniWrite , %Sng6NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6NumSharksMax
   IniWrite , %Sng7NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7NumSharksMax
;   IniWrite , %Sng8NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8NumSharksMax
;   IniWrite , %Sng9NumSharksMax%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9NumSharksMax
   IniWrite , %Sng1LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1LobbyText
   IniWrite , %Sng2LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2LobbyText
   IniWrite , %Sng3LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3LobbyText
   IniWrite , %Sng4LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4LobbyText
   IniWrite , %Sng5LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5LobbyText
   IniWrite , %Sng6LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6LobbyText
   IniWrite , %Sng7LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7LobbyText
;   IniWrite , %Sng8LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8LobbyText
;   IniWrite , %Sng9LobbyText%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9LobbyText

   IniWrite , %Sng1PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1PaymentType
   IniWrite , %Sng2PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2PaymentType
   IniWrite , %Sng3PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3PaymentType
   IniWrite , %Sng4PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4PaymentType
   IniWrite , %Sng5PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5PaymentType
   IniWrite , %Sng6PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6PaymentType
   IniWrite , %Sng7PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7PaymentType
;   IniWrite , %Sng8PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8PaymentType
;   IniWrite , %Sng9PaymentType%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9PaymentType
*/


;   IniWrite , %TournamentDollarType%, Settings\PokerShortcuts.ini, %SectionLabel%, TournamentDollarType



   ;SnG B tab

/*   
   IniWrite , %Sng1ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1ContinuouslyEnabled
   IniWrite , %Sng2ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng2ContinuouslyEnabled
   IniWrite , %Sng3ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng3ContinuouslyEnabled
   IniWrite , %Sng4ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng4ContinuouslyEnabled
   IniWrite , %Sng5ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng5ContinuouslyEnabled
   IniWrite , %Sng6ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng6ContinuouslyEnabled
   IniWrite , %Sng7ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng7ContinuouslyEnabled
;   IniWrite , %Sng8ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng8ContinuouslyEnabled
;   IniWrite , %Sng9ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng9ContinuouslyEnabled
*/

   IniWrite , %Sng11ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11ContinuouslyEnabled
   IniWrite , %Sng12ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng12ContinuouslyEnabled
   IniWrite , %Sng13ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng13ContinuouslyEnabled
   IniWrite , %Sng14ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng14ContinuouslyEnabled
   IniWrite , %Sng15ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng15ContinuouslyEnabled
   IniWrite , %Sng16ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng16ContinuouslyEnabled
   IniWrite , %Sng17ContinuouslyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng17ContinuouslyEnabled

   
   
   IniWrite , %SngContinuouslyOpenNumber%, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenNumber
   IniWrite , %SngStopOpeningAfterNum%, Settings\PokerShortcuts.ini, %SectionLabel%, SngStopOpeningAfterNum
   IniWrite , %SngContinuouslyOpenPlayTime%, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenPlayTime
   IniWrite , %SngContinuouslyOpenTimerInterval%, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenTimerInterval
   IniWrite , %SngContinuouslyOpenFailSafeTime%, Settings\PokerShortcuts.ini, %SectionLabel%, SngContinuouslyOpenFailSafeTime


   IniWrite , %ClickOkForSngEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ClickOkForSngEnabled




   ; Sng C
   
   IniWrite , %AutoClickImBackButtonEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickImBackButtonEnabled
   IniWrite , %ClickImReadyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ClickImReadyEnabled
   IniWrite , %AutoCloseTournamentLobbyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoCloseTournamentLobbyEnabled
   IniWrite , %MinimizeSngLobbyEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, MinimizeSngLobbyEnabled
   IniWrite , %UseCriticalMethodDisabled%, Settings\PokerShortcuts.ini, %SectionLabel%, UseCriticalMethodDisabled
   IniWrite , %AutoClickInfoRefreshEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickInfoRefreshEnabled
   IniWrite , %AutoClickInfoRefreshInterval%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickInfoRefreshInterval
   IniWrite , %CloseFinishedSngTablesEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseFinishedSngTablesEnabled
   IniWrite , %CloseTourneyTablesIfNotSeatedEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTourneyTablesIfNotSeatedEnabled
   IniWrite , %CloseTableTimeDelay%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTableTimeDelay


;   IniWrite , %Sng1OpenControl%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng1OpenControl
   IniWrite , %Sng11OpenControl%, Settings\PokerShortcuts.ini, %SectionLabel%, Sng11OpenControl
   IniWrite , %PSSngOpenHighlightedControl%, Settings\PokerShortcuts.ini, %SectionLabel%, PSSngOpenHighlightedControl
   IniWrite , %FTSngOpenHighlightedControl%, Settings\PokerShortcuts.ini, %SectionLabel%, FTSngOpenHighlightedControl
   
   IniWrite , %OneClickSngRegisteringEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, OneClickSngRegisteringEnabled   

   ; Actions1
;   IniWrite , %BettingControlsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, BettingControlsEnabled
   IniWrite , %FoldCheckControl%, Settings\PokerShortcuts.ini, %SectionLabel%, FoldCheckControl
   IniWrite , %CallControl%, Settings\PokerShortcuts.ini, %SectionLabel%, CallControl
   IniWrite , %BetRaiseControl%, Settings\PokerShortcuts.ini, %SectionLabel%, BetRaiseControl
   IniWrite , %LeftCheckboxControl%, Settings\PokerShortcuts.ini, %SectionLabel%, LeftCheckboxControl
   IniWrite , %MiddleCheckboxControl%, Settings\PokerShortcuts.ini, %SectionLabel%, MiddleCheckboxControl

   IniWrite , %CallAnyControl%, Settings\PokerShortcuts.ini, %SectionLabel%, CallAnyControl
   IniWrite , %RaiseMinControl%, Settings\PokerShortcuts.ini, %SectionLabel%, RaiseMinControl
   IniWrite , %RaiseAnyControl%, Settings\PokerShortcuts.ini, %SectionLabel%, RaiseAnyControl
   IniWrite , %BetWindowClearControl%, Settings\PokerShortcuts.ini, %SectionLabel%, BetWindowClearControl
   IniWrite , %FoldToAnyBetControl%, Settings\PokerShortcuts.ini, %SectionLabel%, FoldToAnyBetControl
;   IniWrite , %PreActionControlsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionControlsEnabled
   IniWrite , %PreActionFoldControlEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionFoldControlEnabled
   IniWrite , %PreActionCallControlEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PreActionCallControlEnabled

   ; Actions2
   IniWrite , %PlayersNameControl%, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameControl
;   IniWrite , %PlayersNameToSharkListControl%, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameToSharkListControl
;   IniWrite , %PlayersNameFromSharkListControl%, Settings\PokerShortcuts.ini, %SectionLabel%, PlayersNameFromSharkListControl
   IniWrite , %TableTournamentIdControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableTournamentIdControl
   IniWrite , %ReloadChipsControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ReloadChipsControl
   IniWrite , %LobbyToggleAutoMuckHandsControl%, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyToggleAutoMuckHandsControl
;   IniWrite , %ReloadAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ReloadAllControl
   IniWrite , %TableMoveToFromChatControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableMoveToFromChatControl
   IniWrite , %TimerControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TimerControl
   IniWrite , %TimerAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TimerAllControl
   IniWrite , %LastHandControl%, Settings\PokerShortcuts.ini, %SectionLabel%, LastHandControl
   IniWrite , %TourneyInfoControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TourneyInfoControl
;   IniWrite , %ToggleAutoMuckHandsControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ToggleAutoMuckHandsControl
   IniWrite , %NotesControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesControl
   IniWrite , %NotesNanoControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoControl
   IniWrite , %NotesPlayerNControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesPlayerNControl
   IniWrite , %NotesOpenPlayerNControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesOpenPlayerNControl
   IniWrite , %NotesNanoPlayerNControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoPlayerNControl
   IniWrite , %NotesNanoInitialColor%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoInitialColor
   IniWrite , %NotesColorNControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesColorNControl
   IniWrite , %NotesNanoColorUpControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoColorUpControl
   IniWrite , %NotesNanoColorDownControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoColorDownControl
   IniWrite , %NotesCloseControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesCloseControl


   ; Actions3
   IniWrite , %ToggleSitOutControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ToggleSitOutControl
   IniWrite , %SitInOnAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, SitInOnAllControl
   IniWrite , %SitOutOnAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, SitOutOnAllControl
   IniWrite , %ToggleAPBControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ToggleAPBControl
   IniWrite , %TableCloseActiveControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseActiveControl
   IniWrite , %TableCloseActiveWithoutHeroControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseActiveWithoutHeroControl
   IniWrite , %TableCloseAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseAllControl
   IniWrite , %TableCloseAllWithoutHeroControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableCloseAllWithoutHeroControl
   IniWrite , %TableMinimizeAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableMinimizeAllControl
   IniWrite , %TableMinimizeAllWithoutHeroControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableMinimizeAllWithoutHeroControl
   IniWrite , %OpenCashierControl%, Settings\PokerShortcuts.ini, %SectionLabel%, OpenCashierControl
   IniWrite , %LobbyTournamentCloseControl%, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyTournamentCloseControl
   IniWrite , %LobbyTournamentMinimizeControl%, Settings\PokerShortcuts.ini, %SectionLabel%, LobbyTournamentMinimizeControl
   
   IniWrite , %TableNextControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableNextControl
   IniWrite , %TablePreviousControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TablePreviousControl
   IniWrite , %TableLeftControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableLeftControl
   IniWrite , %TableRightControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableRightControl
   IniWrite , %TableUpControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableUpControl
   IniWrite , %TableDownControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableDownControl
   IniWrite , %TableBottomOfStackControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableBottomOfStackControl
   IniWrite , %TableNextInStackControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TableNextInStackControl

   IniWrite , %TablePendingControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TablePendingControl
   IniWrite , %TableLayout1Control%, Settings\PokerShortcuts.ini, %SectionLabel%, TableLayout1Control
   IniWrite , %TableLayout2Control%, Settings\PokerShortcuts.ini, %SectionLabel%, TableLayout2Control
   IniWrite , %TablesCascadeControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TablesCascadeControl
   IniWrite , %TablesTileControl%, Settings\PokerShortcuts.ini, %SectionLabel%, TablesTileControl


   ; Displays
;   IniWrite , %TooltipBettingInfoEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoEnabled
;   IniWrite , %TooltipBettingInfoPosX%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoPosX
;   IniWrite , %TooltipBettingInfoPosY%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoPosY
;   IniWrite , %TooltipBettingInfoText%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipBettingInfoText
   IniWrite , %OsdBettingInfoEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoEnabled
   IniWrite , %OsdBettingInfoPosX%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoPosX
   IniWrite , %OsdBettingInfoPosY%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoPosY
   IniWrite , %OsdBettingInfoColor%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoColor
   IniWrite , %OsdBettingInfoFontSize%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoFontSize
   IniWrite , %OsdBettingInfoFont%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoFont
   IniWrite , %OsdBettingInfoText%, Settings\PokerShortcuts.ini, %SectionLabel%, OsdBettingInfoText
   IniWrite , %DisplayOsd3Enabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Enabled
   IniWrite , %DisplayOsd3PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3PosX
   IniWrite , %DisplayOsd3PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3PosY
   IniWrite , %DisplayOsd3Color%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Color
   IniWrite , %DisplayOsd3FontSize%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3FontSize
   IniWrite , %DisplayOsd3Font%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Font
   IniWrite , %DisplayOsd3Text%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3Text
   
   IniWrite , %DisplayOsd4Enabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Enabled
   IniWrite , %DisplayOsd4PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4PosX
   IniWrite , %DisplayOsd4PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4PosY
   IniWrite , %DisplayOsd4Color%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Color
   IniWrite , %DisplayOsd4FontSize%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4FontSize
   IniWrite , %DisplayOsd4Font%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Font
   IniWrite , %DisplayOsd4Text%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4Text
   
   IniWrite , %DisplayOsd5Enabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Enabled
   IniWrite , %DisplayOsd5PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5PosX
   IniWrite , %DisplayOsd5PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5PosY
   IniWrite , %DisplayOsd5Color%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Color
   IniWrite , %DisplayOsd5FontSize%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5FontSize
   IniWrite , %DisplayOsd5Font%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Font
   IniWrite , %DisplayOsd5Text%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd5Text
   
;   IniWrite , %TooltipStackInfoEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipStackInfoEnabled
;   IniWrite , %TooltipStackInfoText%, Settings\PokerShortcuts.ini, %SectionLabel%, TooltipStackInfoText
   IniWrite , %DisplayOsdStackInfoInRingGamesEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsdStackInfoInRingGamesEnabled
   IniWrite , %DisplayOsdBetInfoInLimitGamesEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsdBetInfoInLimitGamesEnabled
   IniWrite , %ChatWarningEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ChatWarningEnabled
   IniWrite , %DisplayOsd3AllTablesEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd3AllTablesEnabled
   IniWrite , %DisplayOsd4AllTablesEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayOsd4AllTablesEnabled
   IniWrite , %DisplayDebugInfoEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DisplayDebugInfoEnabled
   IniWrite , %DebugTooltipPosX%, Settings\PokerShortcuts.ini, %SectionLabel%, DebugTooltipPosX
   IniWrite , %DebugTooltipPosY%, Settings\PokerShortcuts.ini, %SectionLabel%, DebugTooltipPosY
   IniWrite , %RefreshOSD1Control%, Settings\PokerShortcuts.ini, %SectionLabel%, RefreshOSD1Control

/*
   ; Chips
   IniWrite , %AutoClickOkOnGetChipsDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickOkOnGetChipsDialogEnabled
;   IniWrite , %NLBuyin%, Settings\PokerShortcuts.ini, %SectionLabel%, NLBuyin
   IniWrite , %NLReloadAmount%, Settings\PokerShortcuts.ini, %SectionLabel%, NLReloadAmount
;   IniWrite , %NLReloadPoint%, Settings\PokerShortcuts.ini, %SectionLabel%, NLReloadPoint
;   IniWrite , %NLAllInAmount%, Settings\PokerShortcuts.ini, %SectionLabel%, NLAllInAmount
;   IniWrite , %CapBuyin%, Settings\PokerShortcuts.ini, %SectionLabel%, CapBuyin
   IniWrite , %CapReloadAmount%, Settings\PokerShortcuts.ini, %SectionLabel%, CapReloadAmount
;   IniWrite , %LimitBuyin%, Settings\PokerShortcuts.ini, %SectionLabel%, LimitBuyin
   IniWrite , %LimitReloadAmount%, Settings\PokerShortcuts.ini, %SectionLabel%, LimitReloadAmount
   IniWrite , %ManualReloadWhenGetChipsIsClicked%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualReloadWhenGetChipsIsClicked
   IniWrite , %AssumeStackIs0WhenSittingOutEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AssumeStackIs0WhenSittingOutEnabled
*/


   ;Table1
   IniWrite , %ActiveTableHighlighterEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableHighlighterEnabled
   IniWrite , %ActiveTableHighlighterColor%, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableHighlighterColor
   IniWrite , %TableHighlighterTransperancy%, Settings\PokerShortcuts.ini, %SectionLabel%, TableHighlighterTransperancy
   IniWrite , %TableHighlighterSize%, Settings\PokerShortcuts.ini, %SectionLabel%, TableHighlighterSize
   IniWrite , %ActiveTableAndPendingHighlighterEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableAndPendingHighlighterEnabled
   IniWrite , %ActiveTableAndPendingHighlighterColor%, Settings\PokerShortcuts.ini, %SectionLabel%, ActiveTableAndPendingHighlighterColor
;   IniWrite , %PendingActionHighlighterEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PendingActionHighlighterEnabled
;   IniWrite , %PendingActionHighlighterColor%, Settings\PokerShortcuts.ini, %SectionLabel%, PendingActionHighlighterColor

   IniWrite , %TableAutoActivateDisabled%, Settings\PokerShortcuts.ini, %SectionLabel%, TableAutoActivateDisabled
   IniWrite , %ActivateTableOnMouseOverEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ActivateTableOnMouseOverEnabled
   IniWrite , %AutoActivateNextPendingTableEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoActivateNextPendingTableEnabled
;   IniWrite , %AutoActivateTopTableEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoActivateTopTableEnabled
;   IniWrite , %PutImBackButtonTablesIntoPendingListEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PutImBackButtonTablesIntoPendingListEnabled
   IniWrite , %MoveTableEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTableEnabled
   IniWrite , %MoveTablePosX%, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTablePosX
   IniWrite , %MoveTablePosY%, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTablePosY
   IniWrite , %MoveTableWidth%, Settings\PokerShortcuts.ini, %SectionLabel%, MoveTableWidth
   IniWrite , %MouseToHomeEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, MouseToHomeEnabled
   IniWrite , %ActivateTableOnMouseOverIfMouseToHomeEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, ActivateTableOnMouseOverIfMouseToHomeEnabled

   IniWrite , %ManualMoveTableControl%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTableControl
   IniWrite , %ManualMoveTablePosX%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTablePosX
   IniWrite , %ManualMoveTablePosY%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTablePosY
   IniWrite , %ManualMoveTableWidth%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTableWidth
   
   IniWrite , %ManualMoveTable2Control%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2Control
   IniWrite , %ManualMoveTable2PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2PosX
   IniWrite , %ManualMoveTable2PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2PosY
   IniWrite , %ManualMoveTable2Width%, Settings\PokerShortcuts.ini, %SectionLabel%, ManualMoveTable2Width

   ; Table2
   IniWrite , %TableSize%, Settings\PokerShortcuts.ini, %SectionLabel%, TableSize
   IniWrite , %TableWidthA%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthA
   IniWrite , %TableWidthB%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthB
   IniWrite , %TableWidthC%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthC
   IniWrite , %TableWidthD%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthD
   IniWrite , %TableWidthE%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthE
   IniWrite , %TableWidthF%, Settings\PokerShortcuts.ini, %SectionLabel%, TableWidthF



   ; Dialog boxes
   IniWrite , %AutoLogInEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoLogInEnabled
   IniWrite , %DenyReLoginAttemptedEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, DenyReLoginAttemptedEnabled
   IniWrite , %CloseAnnouncementsDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseAnnouncementsDialogEnabled
   IniWrite , %CloseFoldCallDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseFoldCallDialogEnabled
;   IniWrite , %CloseRemovedFromWaitingListDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseRemovedFromWaitingListDialogEnabled
   IniWrite , %RejectSeatIfSeatAvailableEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, RejectSeatIfSeatAvailableEnabled
   IniWrite , %RejectSeatControl%, Settings\PokerShortcuts.ini, %SectionLabel%, RejectSeatControl
   IniWrite , %TakeSeatIfSeatAvailableEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, TakeSeatIfSeatAvailableEnabled
   IniWrite , %PopSeatAvailDialogToTopEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, PopSeatAvailDialogToTopEnabled
   IniWrite , %CloseAutoPostBlindsDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseAutoPostBlindsDialogEnabled
   IniWrite , %CloseLeaveTableDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseLeaveTableDialogEnabled
   IniWrite , %CloseLeaveSeatDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseLeaveSeatDialogEnabled
   IniWrite , %CloseEducationalTableDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseEducationalTableDialogEnabled
   IniWrite , %CloseTableHasBeenClosedEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTableHasBeenClosedEnabled

;   IniWrite , %CloseWereSorryRegClosedDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseWereSorryRegClosedDialogEnabled
   IniWrite , %CloseYouFinishedTheTournamentDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseYouFinishedTheTournamentDialogEnabled
   IniWrite , %CloseDialogDelay%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseDialogDelay
;   IniWrite , %CloseTooManyWindowsOpenDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTooManyWindowsOpenDialogEnabled
;   IniWrite , %CloseYouCannotRegisterMoreTrnysDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseYouCannotRegisterMoreTrnysDialogEnabled
   IniWrite , %CloseOneButtonStarsDialogsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseOneButtonStarsDialogsEnabled
   IniWrite , %CloseOneButtonFullTiltDialogsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseOneButtonFullTiltDialogsEnabled

;   IniWrite , %CloseDialogBoxesUsingImageRecogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseDialogBoxesUsingImageRecogEnabled

   IniWrite , %AutoClickOkOnGetChipsDialogEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickOkOnGetChipsDialogEnabled


   ; Misc

   
   IniWrite , %AutoClickTimerEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickTimerEnabled
   IniWrite , %TimeButtonWaitTime%, Settings\PokerShortcuts.ini, %SectionLabel%, TimeButtonWaitTime
   IniWrite , %AutoClickTimerIfBetBoxEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, AutoClickTimerIfBetBoxEnabled
   IniWrite , %TimeButtonIfPendingActionWaitTime%, Settings\PokerShortcuts.ini, %SectionLabel%, TimeButtonIfPendingActionWaitTime

;   IniWrite , %CloseTableTimeDelay%, Settings\PokerShortcuts.ini, %SectionLabel%, CloseTableTimeDelay
   IniWrite , %MinimizeShortcutsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, MinimizeShortcutsEnabled
   IniWrite , %UseMouseMovementToClickButtonsEnabled%, Settings\PokerShortcuts.ini, %SectionLabel%, UseMouseMovementToClickButtonsEnabled   
   
   IniWrite , %JoyNum%, Settings\PokerShortcuts.ini, %SectionLabel%, JoyNum
   IniWrite , %KeyListToDisableShortcuts%, Settings\PokerShortcuts.ini, %SectionLabel%, KeyListToDisableShortcuts
   
;outputdebug, in write, joynum= %JoyNum%

;   IniWrite , %SafetyDelay5%, Settings\PokerShortcuts.ini, %SectionLabel%, SafetyDelay5
;   IniWrite , %SafetyDelay6%, Settings\PokerShortcuts.ini, %SectionLabel%, SafetyDelay6


   IniWrite , %ShortcutsProcessPriority%, Settings\PokerShortcuts.ini, %SectionLabel%, ShortcutsProcessPriority
   IniWrite , %FullTiltProcessPriority%, Settings\PokerShortcuts.ini, %SectionLabel%, FullTiltProcessPriority
   IniWrite , %PokerStarsProcessPriority%, Settings\PokerShortcuts.ini, %SectionLabel%, PokerStarsProcessPriority

   ; Calib





   ; Setup

   IniWrite , %CurrentSetDescription%, Settings\PokerShortcuts.ini, %SectionLabel%, CurrentSetDescription
;   IniWrite , %CodeType%, Settings\PokerShortcuts.ini, %SectionLabel%, CodeType

   IniWrite , %FTLobbyTheme%, Settings\PokerShortcuts.ini, %SectionLabel%, FTLobbyTheme
   IniWrite , %FTTableTheme%, Settings\PokerShortcuts.ini, %SectionLabel%, FTTableTheme
   IniWrite , %FTMouseHomePosX%, Settings\PokerShortcuts.ini, %SectionLabel%, FTMouseHomePosX
   IniWrite , %FTMouseHomePosY%, Settings\PokerShortcuts.ini, %SectionLabel%, FTMouseHomePosY
   IniWrite , %FTOsdBettingInfoPosX%, Settings\PokerShortcuts.ini, %SectionLabel%, FTOsdBettingInfoPosX
   IniWrite , %FTOsdBettingInfoPosY%, Settings\PokerShortcuts.ini, %SectionLabel%, FTOsdBettingInfoPosY
   IniWrite , %FTDisplayOsd3PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd3PosX
   IniWrite , %FTDisplayOsd3PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd3PosY
   IniWrite , %FTDisplayOsd4PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd4PosX
   IniWrite , %FTDisplayOsd4PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd4PosY
   IniWrite , %FTDisplayOsd5PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd5PosX
   IniWrite , %FTDisplayOsd5PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, FTDisplayOsd5PosY

   IniWrite , %PSLobbyTheme%, Settings\PokerShortcuts.ini, %SectionLabel%, PSLobbyTheme
   IniWrite , %PSTableTheme%, Settings\PokerShortcuts.ini, %SectionLabel%, PSTableTheme
   IniWrite , %PSMouseHomePosX%, Settings\PokerShortcuts.ini, %SectionLabel%, PSMouseHomePosX
   IniWrite , %PSMouseHomePosY%, Settings\PokerShortcuts.ini, %SectionLabel%, PSMouseHomePosY
   IniWrite , %PSOsdBettingInfoPosX%, Settings\PokerShortcuts.ini, %SectionLabel%, PSOsdBettingInfoPosX
   IniWrite , %PSOsdBettingInfoPosY%, Settings\PokerShortcuts.ini, %SectionLabel%, PSOsdBettingInfoPosY
   IniWrite , %PSDisplayOsd3PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd3PosX
   IniWrite , %PSDisplayOsd3PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd3PosY
   IniWrite , %PSDisplayOsd4PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd4PosX
   IniWrite , %PSDisplayOsd4PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd4PosY
   IniWrite , %PSDisplayOsd5PosX%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd5PosX
   IniWrite , %PSDisplayOsd5PosY%, Settings\PokerShortcuts.ini, %SectionLabel%, PSDisplayOsd5PosY
   ; Gary
;   IniWrite , %NotesNanoAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoAllControl
;   IniWrite , %NotesNanoSetSharkScopeColorAllControl%, Settings\PokerShortcuts.ini, %SectionLabel%, NotesNanoSetSharkScopeColorAllControl




}


