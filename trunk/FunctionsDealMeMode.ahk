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
 
 
 
; ***************************************************************************************
; ---------------------------------------------------------------------------------------
; DEAL ME MODE FUNCTIONS
; ---------------------------------------------------------------------------------------
; ***************************************************************************************



; State:  In, Out, Off, and ""
; "" is used for when the hero is not seated or the table is a tournament/sng
DealMeMode(WinId)
{
   global
   local CasinoName, TableFast, State, CheckboxState


      if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      {
         return
      }

      State := DealMeModeState%WinId%
      
      ; return if State is off
      ;        OR hero not seated
      ;        OR tournament table
      if ((NOT HeroSeated(WinId)) OR (NOT TableRingOrTournament(WinId)) )
      {
         DealMeModeState%WinId% := ""
         return
      }
      
      ; the hero is now seated at a ring game
      ; if the hero just sat down, then the state = "", check for a few special condition
      if (DealMeModeState%WinId% == "")
      {
;outputdebug, dealmemode = ""   

         ; if there is a get chips dialog box open, then just return because we might be getting chips for this table.
         ifWinActive, Get Chips ahk_class QWidget
         {
            return
         }
   
         ; if enabled to automatically go to DealMe IN
         if (SetDealMeModeOnInitialBuyInEnabled AND  (NOT(TableHeadsUp(TableId)  AND  DisableDealMeModeWhenHU)  )  )
            DealMeModeState%WinId% := "In"
         else
            DealMeModeState%WinId% := "Off"
            
         ; if enabled to auto post blinds (only on FT tables)
         if (AutoPostBlindsAfterSittingDownEnabled AND (CasinoName == "FT") AND (NOT(TableHeadsUp(TableId)  AND  DisableDealMeModeWhenHU)    )  )
         {
;outputdebug, in dm...   checking APB     
                
            ; repeat this til correct state,  as FT is sometimes not ready to do it
            loop, 20
            {
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               CheckboxState := CheckboxGetState("CheckboxAutoPostBlinds",WinId)
               if (CheckboxState == 1)
                  break
               sleep, 30   

            }
         }
      }




      TableFast := TableFast(WinId)

      ; if FT           
      if (CasinoName == "FT")
      {
         if (State == "In")
         {
            ; if the wait for big blind button is visible, then click it and check that APB is checked
            if (ButtonVisibleUsingImageRecognition("ButtonWaitForBigBlind",WinId) == 1)
            {
;outputdebug, WFBB visible in deal me mode            
               ButtonClick("ButtonWaitForBigBlind",WinId)
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               Return
            }
            ; if the post big blind button is visible, then click APB checkbox
            else if (ButtonVisibleUsingImageRecognition("ButtonPostBigBlind",WinId) == 1)
            {
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               Return
            }
            ; if the post small blind button is visible, then click it and continue
            else if (ButtonVisibleUsingImageRecognition("ButtonPostSmallBlind",WinId) == 1)
            {
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               Return
            }

         }
         else if (State == "Out")
         {

            ; if the post small blind button is visible, then click it
            if (ButtonVisibleUsingImageRecognition("ButtonPostSmallBlind",WinId) == 1)
            {
                  ButtonClick("ButtonPostSmallBlind",WinId)
                  Return
            }
            ; if the sit out button is visible, then click SIT OUT
            else if (ButtonVisibleUsingImageRecognition("ButtonSitOut",WinId) == 1)
            {
                  ButtonClick("ButtonSitOut",WinId)
                  DealMeModeState%WinId% := "Off"
                  Return
            }

         }

      }

      ; if regular poker stars tables
      else if ((CasinoName == "PS") AND NOT TableFast)
      {
         if (State == "In")
         {
            ; if the wait for big blind button is visible, then click it and continue
            if (ButtonVisibleUsingImageRecognition("ButtonWaitForBigBlind",WinId) == 1)
            {
               ButtonClick("ButtonWaitForBigBlind",WinId)
               Return
            }
            ; if the post big blind button is visible, then click autopost blinds checkbox
            else if (ButtonVisibleUsingImageRecognition("ButtonPostBigBlind",WinId) == 1)
            {
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               Return
            }
            ; if the post small blind button is visible, then click the autopost blinds checkbox
            else if (ButtonVisibleUsingImageRecognition("ButtonPostSmallBlind",WinId) == 1)
            {
               CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)
               Return
            }
         }
         else if (State == "Out")
         {
            ; if the post small blind button is visible, then click it
            if (ButtonVisibleUsingImageRecognition("ButtonPostSmallBlind",WinId) == 1)
            {
               ButtonClick("ButtonPostSmallBlind",WinId)
               Return
            }
            ; if the sit out button is visible, then click SIT OUT NEXT HAND checkbox
            else if (ButtonVisibleUsingImageRecognition("ButtonSitOut",WinId) == 1)
            {
               CheckboxSetState(1,"CheckboxSitOutNextHand",WinId)
               ButtonClick("ButtonSitOut",WinId)
               DealMeModeState%WinId% := "Off"
               return
            }
         }
      }
      
/*
      ; if FAST poker stars tables
      else if ((CasinoName == "PS") AND TableFast)
      {
         if (State == "In")
         {

         }
         else if (State == "Out")
         {

         }
      }
*/
      
      else
         return
}



/*
SetDealMeModeOnInitialBuyInEnabled
DealMeModeStatusTooltipEnabled
AutoPostBlindsAfterSittingDownEnabled
DisableDealMeModeWhenHU
CycleDealMeModesOnActiveTableControl
CycleDealMeModesOnAllTablesControl

DealMeInAllControl
DealMeOutAllControl
AutoDealMeInModeEnabled
AutoDealMeOutModeEnabled
*/



CycleDealMeModesOnAllTables(WinId="")
{
   global
   local TableIdList, CasinoName, TableFastFlag, State, Key

   ; the hotkey that got us here, need to do this right away in a functions so that another hotkey doesn't come along
   Key := A_ThisHotkey

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; remove any key modifiers (like Shift, LWin, etc) so that we only look for multiple keypresses from the main key itself
   Key := RemoveKeyModifiers(Key)


   ; wait for the key to go up
   KeyWait, %Key%, t%KeyWaitMaxClickTime%
   ; see if user held button down for too long, is so, treat it as a single key press
   if (errorlevel == 1)
   {
      ;set the amount to the 1click amount for this fixed bet number
      ClickNum := 1
      GoTo, DoneWithKeyWaiting2
   }
   ; wait for the key to go down again, or do a short time out
   KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
   ; check if a second press did NOT occur within short window of time
   If (errorlevel == 1)
   {
      ;set the amount to the 1click amount for this fixed bet number
      ClickNum := 1
      GoTo, DoneWithKeyWaiting2
   }
   else
   {
      ; we have either a double or triple press
      ; wait for the key to go up
      KeyWait, %Key%, t%KeyWaitMaxClickTime%
      ; see if user held button down for 1 second or more, is so, treat it as a double key press
      if (errorlevel == 1)
      {
         ;set the amount to the 2click amount for this fixed bet number
         ClickNum := 2
         GoTo, DoneWithKeyWaiting2
      }
      ; wait for the key to go down again, or time out
      KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
      ; check if a third press did NOT occur within short window of time
      If (errorlevel == 1)
      {
         ;set the amount to the 2click amount for this fixed bet number
         ClickNum := 2
         GoTo, DoneWithKeyWaiting2
      }
      else
      {
         ;set the amount to the 2click amount for this fixed bet number
         ClickNum := 3
         GoTo, DoneWithKeyWaiting2
      }
   }

DoneWithKeyWaiting2:

   ; use the state of the active table, and increment from there
   ;State := DealMeModeState%WinId%

   if (ClickNum == 1)
      State := "In"
   else if (ClickNum == 2)
      State := "Out"
   else
      State := "Off"


   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, TableIdList, List, ahk_group Tables


   ; loop through all of the open tables
   Loop, %TableIdList%
   {
      ; find the next ID of the next FTP table
      WinId := TableIdList%A_Index%
      
      SetDealMeModeState(State, WinId)
   }
   
   ; if enabled show the debug status
   if DealMeModeStatusTooltipEnabled
   {
      CoordMode, Tooltip, Relative
      Tooltip,% "Deal Me: " . State . " "  , %DealMeModeStatusTooltipX%, %DealMeModeStatusTooltipY%, 7
      SetTimer, DealMeToolTipOff, %DealMeToolTipTimerInterval%, %DealMeToolTipTimerPriority%
   }
}




CycleDealMeModesOnActiveTable(WinId="")
{
   global
   local CasinoName, TableFastFlag, State, ClickNum, Key

   ; the hotkey that got us here, need to do this right away in a functions so that another hotkey doesn't come along
   Key := A_ThisHotkey

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   ; remove any key modifiers (like Shift, LWin, etc) so that we only look for multiple keypresses from the main key itself
   Key := RemoveKeyModifiers(Key)


      ; wait for the key to go up
      KeyWait, %Key%, t%KeyWaitMaxClickTime%
      ; see if user held button down for too long, is so, treat it as a single key press
      if (errorlevel == 1)
      {
         ;set the amount to the 1click amount for this fixed bet number
         ClickNum := 1
         GoTo, DoneWithKeyWaiting1
      }
      ; wait for the key to go down again, or do a short time out
      KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
      ; check if a second press did NOT occur within short window of time
      If (errorlevel == 1)
      {
         ;set the amount to the 1click amount for this fixed bet number
         ClickNum := 1
         GoTo, DoneWithKeyWaiting1
      }
      else
      {
         ; we have either a double or triple press
         ; wait for the key to go up
         KeyWait, %Key%, t%KeyWaitMaxClickTime%
         ; see if user held button down for 1 second or more, is so, treat it as a double key press
         if (errorlevel == 1)
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 2
            GoTo, DoneWithKeyWaiting1
         }
         ; wait for the key to go down again, or time out
         KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
         ; check if a third press did NOT occur within short window of time
         If (errorlevel == 1)
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 2
            GoTo, DoneWithKeyWaiting1
         }
         else
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 3
            GoTo, DoneWithKeyWaiting1
         }
      }

DoneWithKeyWaiting1:

   ; use the state of the active table, and increment from there
   ;State := DealMeModeState%WinId%

   if (ClickNum == 1)
      State := "In"
   else if (ClickNum == 2)
      State := "Out"
   else
      State := "Off"

   SetDealMeModeState(State, WinId)
   
   ; if enabled show the debug status
   if DealMeModeStatusTooltipEnabled
   {
      CoordMode, Tooltip, Relative
      Tooltip,% "Deal Me: " . State . " "  , %DealMeModeStatusTooltipX%, %DealMeModeStatusTooltipY%, 7
      SetTimer, DealMeToolTipOff, %DealMeToolTipTimerInterval%, %DealMeToolTipTimerPriority%
   }
}



; State:  In, Out, Off
SetDealMeModeState(State, WinId)
{
   global
   local CasinoName, TableFast


   ; if hero is not seated, then continue
   if NOT HeroSeated(WinId)
   {
      DealMeModeState%WinId% := "Off"
      return
   }
   
   ; if table is not a ring game, then continue
   if NOT TableRingOrTournament(WinId)
   {
      DealMeModeState%WinId% := "Off"
      return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
   {
      DealMeModeState%WinId% := "Off"
      return
   }
   
   TableFast := TableFast(WinId)
   
   ; if FT
   if (CasinoName == "FT")
   {
      if (State == "In")
      {
         CheckboxSetState(0,"CheckboxSitOutNextHand",WinId)
         CheckboxSetState(1,"CheckboxAutoPostBlinds",WinId)

         DealMeModeState%WinId% := "In"
      }
      else if (State == "Out")
      {
         CheckboxSetState(0,"CheckboxAutoPostBlinds",WinId)
         DealMeModeState%WinId% := "Out"
      }
      ; else state is Off
      else
      {
         DealMeModeState%WinId% := "Off"
      }
   }
   

   ; if regular poker stars tables
   else if ((CasinoName == "PS") AND NOT TableFast)
   {
      if (State == "In")
      {
         CheckboxSetState(0,"CheckboxSitOutNextHand",WinId)
         DealMeModeState%WinId% := "In"

      }
      else if (State == "Out")
      {
      
         ; if we were waiting for the big blind, then click out SONH
         if (CheckboxGetState("CheckboxWaitForBigBlind", WinId) == 1)
            CheckboxSetState(1,"CheckboxSitOutNextHand",WinId)

         CheckboxSetState(0,"CheckboxAutoPostBlinds",WinId)
         
         DealMeModeState%WinId% := "Out"
      }
      ; else state is Off
      else
      {
         DealMeModeState%WinId% := "Off"
      }
   }
   ; if FAST poker stars tables
   else if ((CasinoName == "PS") AND TableFast)
   {
      if (State == "In")
      {
         CheckboxSetState(0,"CheckboxSitOutNextHand",WinId)
         CheckboxSetState(0,"CheckboxSitOutNextBlind",WinId)
         DealMeModeState%WinId% := "In"

      }
      else if (State == "Out")
      {
         ; if we were waiting for the big blind, then click out SONH
         if (CheckboxGetState("CheckboxWaitForBigBlind", WinId) == 1)
            CheckboxSetState(1,"CheckboxSitOutNextHand",WinId)
         ; else sit out next blind
         else
            CheckboxSetState(1,"CheckboxSitOutNextBlind",WinId)
            
         DealMeModeState%WinId% := "Out"

      }
      ; else state is Off
      else
      {
         DealMeModeState%WinId% := "Off"
      }
   }
   
   else
      return

}


DealMeToolTipOff:
   Tooltip,,,,7
return


