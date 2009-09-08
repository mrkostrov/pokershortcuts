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
; Notes Functions
; ------------------------------------------------------------------------------
; ******************************************************************************


; open nano notes on table WinId if given, if not then under the table the mouse is over
; This function assumes that the mouse is already over the the correct player's box
; This funciton only works on Full Tilt
; if pWinId == "", then open nano notes under the mouse position
; ColorChangeOnly
;        0  set color to 0 if there are no notes (and put in dash), else no color change if there are notes
;        1  set color to NotesColor (and put in dash if there are no notes) AND close the notes
; NotesColor is the color to set this player to (0=  top color, 14 is at bottom = NONE)
FTNotesNano(ColorChangeOnly, NotesColor, WinId="")
{
   global
   local NotesContent, CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""

   if (CasinoName != "FT")
      return

;outputdebug, FTNotesNano   ColorChangeOnly:%ColorChangeOnly%    NotesColor:%NotesColor%
   ; open the player's notes
   FTNotes(WinId)

   ; wait til the Notes window is active
   WinWait, ahk_group Notes ,, 2
   ;WinActivate, ahk_group FTPNotes
   ifWinActive,   ahk_group Notes
   {
      ; if there are no notes on the player, then set the color to NotesNanoInitialColor and put in a dash
      if (ColorChangeOnly == 0)
      {
         ; if there are no notes on this player, then set his color to the NotesNanoInitialColor
         ControlGetText, NotesContent, Edit1             ; read the notes content
         if ! NotesContent
         {

             ; set the player's color to NotesNanoInitialColor
            ControlSend, ComboBox1, {HOME}
;                  sleep, -1
            Loop, 0x%NotesNanoInitialColor%
            {
               ControlSend, ComboBox1, {Down}
;                     sleep, -1
            }


            ControlFocus, Edit1                 ; make sure focus is in the edit box
;                  sleep, -1
            ControlSend, Edit1, -              ; put a - in text, so next time we enter nano-notes, we won't change the color

         }
         ; else there are some notes there, so just move to the bottom of the notes
         else
         {
            ;move to the end of the text (for easy entry of new text)
            ControlSend, Edit1, {DOWN 20}{END}
         }
      }
      ; Set the color to NotesColor
      else if (ColorChangeOnly == 1)
      {
         ; set the player's color to NotesColor
         ControlSend, ComboBox1, {HOME}
;               sleep, -1
         Loop, 0x%NotesColor%
         {
            ControlSend, ComboBox1, {Down}
;                  sleep, -1
         }
         ; if there are no notes on this player, put in a dash
         ControlGetText, NotesContent, Edit1             ; read the notes content
         if ! NotesContent
         {
            ControlFocus, Edit1                 ; make sure focus is in the edit box
;                  sleep, -1
            ControlSend, Edit1, -              ; put a - in text, so next time we enter nano-notes, we won't change the color

         }
         ; else there are some notes there, so just move to the bottom of the notes
         else
         {
            ;move to the end of the text (for easy entry of new text)
            ControlSend, Edit1, {DOWN 20}{END}
         }
         FTNotesClose()
      }
   }

}


; -----------------------------------------------------------------------------------------------

FTNotesColorUp()
{
   global
      ifWinActive,   ahk_group Notes
      {
         ControlSend, ComboBox1, {Up}      ; move the color up one
         ControlFocus, Edit1                 ; make sure focus is in the edit box
         ;move to the end of the text (for easy entry of new text)
         ControlSend, Edit1, {DOWN 20}{END}
      }
}


; -----------------------------------------------------------------------------------------------

FTNotesColorDown()
{
   global
      ifWinActive,   ahk_group Notes
      {
         ControlSend, ComboBox1, {Down}      ; move the color up one
         ControlFocus, Edit1                 ; make sure focus is in the edit box
         ;move to the end of the text (for easy entry of new text)
         ControlSend, Edit1, {DOWN 20}{END}
      }
}


; -----------------------------------------------------------------------------------------------

FTNotesClose()
{
   ifWinActive,   ahk_group Notes
      ControlClick, FTCSkinButton1,,,,,NA
}


; -----------------------------------------------------------------------------------------------


/*
Notes()
   Purpose: If the user's mouse is over a player's box, then this will open the player's notes
            The software calls the function for the appropriate casino function (which reads the title bar)
   Requires:
            The user must have the mouse over a player's box, in order for this to work
   Returns:
      nothing
   Parameters:
      WinId: window id.
*/
Notes(WinId="")
{
   ; local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""

   ; call the casino specific function
   %CasinoName%Notes(WinId)

}


; if the mouse is over a player's box, then this function will get the player's name
;     by activating the player's notes,
;     and the name will be returned from this function
FTNotes(WinId)
{
   global
   local PlayersName, WinTitle

   ; since we were called by the parent function, we already have a valid WinId for a table

   ; click the right button in the player's box
   MouseClick, Right,
   sleep, 100

   ; send keys to open the player's notes
   Send {Down} {Down} {Enter}


}


; if the mouse is over a player's box, then this function will get the player's name
;     by activating the player's notes,
;     and the name will be returned from this function
PSNotes(WinId)
{
   global
   local PlayersName

   ; since we were called by the parent function, we already have a valid WinId for a table



   ; click the right button in the player's box
   MouseClick, Right,
   sleep, 100

   ; send keys to open the player's notes
   Send {Down} {Enter}

}



; --------------------------------------------------------------------------------------------


; open or view the notes for player PlayerNum 1-10  (use 0 for player 10)
;    if EditNotesFlag ==1, then it opens the players notes box, else if ==0 it just moves cursor to the players box
;        so the notes can be viewed
; if hero is seated, don't try to get notes on hero
; NanoNotesFlag == 1 if we want to open nanonotes, 0 if just regular notes
; EditNotesFlag ==  1   open the player's note box for editing
;                   0   just move the mouse to the player's box for viewing the notes
; ColorChangeOnly
;        0  set color to InitialNanoNotesColor if there are no notes (and put in dash), else no color change if there are notes... leave notes open
;        1  set color to NotesColor (and put in dash if there are no notes) AND close the notes
; NotesColor is the color to set this player to (0=  top color, 14 is at bottom = NONE)
NotesPlayerN(ColorChangeOnly, NotesColor, NanoNotesFlag, PlayerNum, EditNotesFlag,WinId="")
{ 
   global                             ; ??? any globals in here ???
   local TableSeats, HeroSeatedFlag, Pos1, ClientScaleFactor, X, Y, CasinoName, HeroSeatPositionAtTable


   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""
      

   if ((CasinoName != "FT") AND NanoNotesFlag)
      return

   if PlayerNum is Not Number
      return
      
      
   ; if PlayerNum == 0, then it is for Player # 10
   if (PlayerNum == 0)
      PlayerNum := 10

   TableSeats := TableSeats(WinId)
   HeroSeatedFlag := HeroSeated(WinId)
   
   
   if (PlayerNum > TableSeats)
      return
   
   if HeroSeatedFlag
   {
      ; if they tried to open or view notes on the hero, then just return
      ; first get the position of this table in the TableSeatsList
      Pos1 := ListGetPos(%CasinoName%TableSeatsList,TableSeats)
      ; get the hero's seat position at this type of table
      HeroSeatPositionAtTable := ListGetItem(HeroSeatNumList,Pos1)
      ; if the user tries to get the hero's notes, then just return
      if (PlayerNum == HeroSeatPositionAtTable)
         return
   }

   

   
   ; if the user gives a player num that doesn't exist for this table, then return
   ;    we check to see that there is X data for this playernum
   if NOT %CasinoName%PlayerBoxSeats%TableSeats%Seat%PlayerNum%X
      return
   
   ; find the location of the center of stack digits... we'll use that to view/open the stack notes
   X := %CasinoName%PlayerBoxSeats%TableSeats%Seat%PlayerNum%X + %CasinoName%StackCenterOffsetX
   Y := %CasinoName%PlayerBoxSeats%TableSeats%Seat%PlayerNum%Y + %CasinoName%StackCenterOffsetY

   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
   ; move the mouse to this desired seat position
   CoordMode, Mouse, Screen
   MouseMove, X, Y, 0

   if (NanoNotesFlag and EditNotesFlag)
      FTNotesNano(ColorChangeOnly, NotesColor, WinId)
   else if EditNotesFlag
      %CasinoName%Notes(WinId)
   

}

