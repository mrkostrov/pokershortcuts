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
 
 
 ; *******************************************************************************
; -------------------------------------------------------------------------------
; Checkbox Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



/*
CheckboxGetState (.25ms)
   Purpose:
      Checks the state of a checkbox on a table, using image recognition.
      The table must be visible on the screen and the checkboxes must not be overlapped.
   Returns:
      1 if checkbox is checked
      0 if not checked
      -1 if checkbox is not enabled, but the table appears to be valid
      -2 table does not seem to be visible or it is overlapped
   Parameters:
      CheckboxName of the checkbox
      WinId - window id
*/
CheckboxGetState(CheckboxName, WinId)
{
   global            ; we need some of the settings
   local X,Y,CheckColor,BackColor
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return -2


   ; on FT tables for a few checkboxes, we need to change the name of the checkbox (since checkboxes can be on one of several positions on the table, depending on table type)
   CheckboxName := CheckboxChangeName(CheckboxName,WinId)

   ; get the particulars for the checkbox
   X := %CasinoName%%CheckboxName%X
   Y := %CasinoName%%CheckboxName%Y
   CheckColor := %CasinoName%%CheckboxName%CheckColor
   BackColor := %CasinoName%%CheckboxName%BackColor

   ; if something is wrong with the casino name or checkbox name, then return -1
   if !X
   {
;      Debug(A_ThisFunc,"This variable was not found/valid:" . CasinoName . CheckboxName . "X")
      return -2
   }

   ; check for a valid checkbox at this XY position and return it's state
   return CheckboxGetStateXY(X,Y,CheckColor,BackColor,WinId)


}




; Sometimes the checkboxes are at different positions on the table, depending on what type of table it is (Ring, Final Table Tournament, Rebuy Tournament, etc.)
; This function checks if we need to change from one checkbox name to another... e.g.   CheckboxSitOutNextHand -> CheckboxRebuySitOutNextHand
; At the moment, this only occurs on FT tables for a couple of different checkboxes.
; if the name needs to be changed, then the name is returned as the corrected name.
; if the name does not need to be changed, it is returned as the same name as was passed in the parameter list
CheckboxChangeName(CheckboxName,WinId)
{
   global
   local X,Y,CheckColor,BackColor,CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return -2

   ; Full Tilt tables have several checkboxes in different position depending on what type of table it is
   ; if this is a "FT" "TOURNAMENT" table, and one of the checkboxes we need to change positions on, then
   if (  (CasinoName == "FT")  AND (   (CheckboxName == "CheckboxSitOutNextHand")  OR  (CheckboxName == "CheckboxFoldToAnyBet")  OR  (CheckboxName == "CheckboxAutoPostBlinds"))   AND  (NOT TableRingOrTournament(WinId))   )
   {
  
      ; check if this is a rebuy tournament, by checking if the Max Rebuy checkbox is visible on the table
      X := FTCheckboxAutoRebuyMaxX
      Y := FTCheckboxAutoRebuyMaxY
      CheckColor := FTCheckboxAutoRebuyMaxCheckColor
      BackColor := FTCheckboxAutoRebuyMaxBackColor 
           
      ; if this checkbox is checked or not checked (>=0) then this checkbox is visible
      if  (CheckboxGetStateXY(X,Y,CheckColor,BackColor,WinId) >= 0)
      {
;outputdebug, Rebuy table found !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!      
         if (CheckboxName == "CheckboxSitOutNextHand")
            CheckboxName := "CheckboxRebuySitOutNextHand"
         else if (CheckboxName == "CheckboxFoldToAnyBet")
            CheckboxName := "CheckboxRebuyFoldToAnyBet"
         else if (CheckboxName == "CheckboxAutoPostBlinds")
            CheckboxName := ""            
      }   
   
      ; check if this is a Final table, by checking if the bottom checkbox (CheckboxFinalSitOutNextHand) checkbox is visible (on a ring or non-final table, this box is the
      ;     autopost blinds checkbox, which is always NOT visible on tournament tables)
      ;    
      else
      {
         X := FTCheckboxFinalSitOutNextHandX
         Y := FTCheckboxFinalSitOutNextHandY
         CheckColor := FTCheckboxFinalSitOutNextHandCheckColor
         BackColor := FTCheckboxFinalSitOutNextHandBackColor  
            
         ; if this checkbox is checked or not checked (>=0) then this checkbox is visible
         if  (CheckboxGetStateXY(X,Y,CheckColor,BackColor,WinId) >= 0)
         {
            if (CheckboxName == "CheckboxSitOutNextHand")
               CheckboxName := "CheckboxFinalSitOutNextHand"
            else if (CheckboxName == "CheckboxFoldToAnyBet")
               CheckboxName := "CheckboxFinalFoldToAnyBet"
            else if (CheckboxName == "CheckboxAutoPostBlinds")
               CheckboxName := ""                    
         }        
      
      }
         
   
   
      ; else this must be a tournament table that is not a rebuy OR final table...  and we don't need to change the name of the checkbox for this condition (this is the same as a ring game)
   
   
   }

   return CheckboxName

}



; this function checks for a valid checkbox at location X,Y, with colors of CheckColor and BackColor
; return 1 if checkbox is checked
;        0 if checkbox is not checked
;        -1 if checkbox colors were not found (checkbox not visible)
CheckboxGetStateXY(X,Y,CheckColor,BackColor,WinId)
{
   local ClientScaleFactor,Delta

   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
   ; if this window is not the top  window and this XY position, then return 0
   ; this checks to make sure that WinId is on the top of the stack at position X,Y
   if WindowIsOverlayedAtXY(X,Y,WinId)
      return -2   

   ; look for check mark in +- 5 pixel area, but scale the size based on our current table size
   Delta := Round(5 * ClientScaleFactor)

;Outputdebug, check1   x=%X%  y=%Y%   cc=%CheckColor%   bc=%BackColor%   cn=%CasinoName%   cbn=%CheckboxName%  id=%WinId%  errorlevel=%Errorlevel%    color=%CheckColor%

   ; search for a check, return 1 if check is found
   CoordMode,Pixel,Screen
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, CheckColor ,5, Fast RGB
   If NOT Errorlevel
      return 1

   ; search for the background color, return 0 if it is found
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, BackColor ,5, Fast RGB
   If NOT Errorlevel
      return 0

   ; else it must not be enabled
   return -1


}


/*
CheckboxSetState (30ms if it actually clicks the mouse)
   Purpose:
      Sets the state of a checkbox on a table to State (1=checked, 0= unchecked.
      The table must be visible on the screen and the checkboxes must not be overlapped IF you want to set to a specific state
      The table does not need to be visible to toggle the state
   Returns:

      0  normally
      -1 if checkbox is not enabled, but the table appears to be valid
      -2 table does not seem to be visible or is overlapped, and we needed to know the state to set the state
   Parameters:
      State:
         0 means to uncheck the checkbox
         1 means to check the checkbox
         2 means to toggle the checkbox
      CheckboxName of the checkbox
      WinId - window id
*/
CheckboxSetState(State, CheckboxName,  WinId)
{

   ; local CurrentState


   ; on FT tables for a few checkboxes, we need to change the name of the checkbox (since checkboxes can be on one of several positions on the table, depending on table type)
   CheckboxName := CheckboxChangeName(CheckboxName,WinId)


   ; if we are toggling the state, then do it
   if (State == 2)
   {
      MouseClickItemLocation(CheckBoxName,WinId)
      return 0
   }
   
   ; removed the following cuz we check if we can see the table in the CheckboxGetState() function
   ; if the table is minimized, then return -1, unknown
   ;WinGet, MinimizedFlag,MinMax, ahk_id%WinId%
   ;if (MinimizedFlag == -1)
   ;   return -2

   ; get the current state of the checkbox
   CurrentState := CheckboxGetState(CheckboxName, WinId)

   ; if the current state matches, then return
   if (CurrentState == State)
      return CurrentState

   ; if the current state is -1 or -2, then return CurrentState
   if (CurrentState < 0)
      return CurrentState

   ; else we need to toggle the state, so click on the checkbox


   ; click the the checkbox
   MouseClickItemLocation(CheckBoxName,WinId)
   return 0


   /*
      ; for casinos like full tilt, you can actually click the control by name...
      ; But since the other method works too... I won't use this method

      CheckboxControlName := %CasinoName%%CheckboxName%
      ; click on the Control name
      ControlClick, %CheckboxControlName%, ahk_id%WinId%,,,,NA

   */


}
