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
; Hero Functions
; -------------------------------------------------------------------------------
; *******************************************************************************

/*
HeroSeated()
   Purpose: This function determines the name of the hero by looking at the title in the main lobby
   Returns:
        hero's name (if logged into main lobby)
        ""  if not logged in
   Parameters:
      WinId: window id of table or lobby
*/
HeroName(WinId)
{
   global
   local LobbyId, CasinoName              ; these are local vars... don't need to declare
   ; for some reason RegexMatch does not work if we declare HeroName here

   ; since the hero name doesn't change
   if HeroName%WinId%
      return HeroName%WinId%

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   LobbyId := LobbyId(CasinoName)
   

   ; capture the hero's name - puts it into the first array element
   RegExMatch(  WinGetTitle("ahk_id" . LobbyId),   "i)Logged in as (.*)$", HeroName)
      
   ; save this global var
   HeroName%WinId% := HeroName1
;outputdebug, in hero name LobbyId:%LobbyId%   hero:%HeroName1%
   return HeroName1

}

/*
HeroSeated()
   Purpose: This function determines if the hero is seated by looking for an active "sit out next hand checkbox"
   Requires: the table must be visible
   Returns:
        1 if seated
        0 if not seated
        -1 can't see table to know if seated or not
   Parameters:
      ByRef CasinoName: casino initials...returns it if not sent
      WinId: window id... returns active window id if not passed
   globals:
      saves  HeroSeated%WinId%
*/
HeroSeated(WinId)
{
   ; local Flag, ReturnedState


   Flag := CheckboxGetState("CheckboxSitOutNextHand", WinId)

;outputdebug, %CasinoName%   %WinId%   Flag:%Flag%

   ; check if we are seated at this table, by seeing if the SitOutNextHand button is visible
   if (Flag >= 0)
      ReturnedState := 1          ; hero is seated
   else if (Flag == -1)
      ReturnedState := 0          ; hero is not seated... checkbox is greyed out
   else
      ReturnedState := -1         ; unknown if seated or not
      
   return ReturnedState
}


/*
HeroStack()
   Purpose: This function determines the number of seats at the table, and then looks in the Hero's position to read the stack size
   Returns:
      Stack # size if found
      S if sitting out
      A if All In
      "" if not found
   Parameters:

      WinId: window id
      
NOTES:   I was thinking that I could keep a global flag on when this var could be updated, but since the poker room can initiate a rebuy of chips,
             the software won't know about this.
         I suppose that in tournaments I could keep a var for when the fold button appears and disappears and use that to update the stack
         Also could use the hand history to update a change in stack size
         Use when a table activates
         When a street changes ???    or when it is preflop ???
      
*/
HeroStack(WinId)
{
   global
   local TableSeats, Stack, DummyByRef, X,Y,W,H, HeroSeatNum, Pos1
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return


   TableSeats := TableSeats(WinId)


   ; get position in the table seats list for our number of table seats
   Pos1 := ListGetPos(%CasinoName%TableSeatsList, TableSeats)
   ; find the hero's seat number
   HeroSeatNum := ListGetItem(%CasinoName%HeroSeatNumList, Pos1)

;outputdebug, Seats:%TableSeats%    Position in table list:%Pos1%    HeroSeatNum:%HeroSeatNum%

   ; find the position to read the stack
   X:= %CasinoName%PlayerBoxSeats%TableSeats%Seat%HeroSeatNum%X + %CasinoName%StackReadOffsetX
   Y:= %CasinoName%PlayerBoxSeats%TableSeats%Seat%HeroSeatNum%Y + %CasinoName%StackReadOffsety
   W:= %CasinoName%StackReadW
   H:= %CasinoName%StackReadH


;outputdebug, TableSeats:%TableSeats%  HeroSeatNum:%HeroSeatNum%  %X%  %Y%  %W%  %H%

;   PSPlayerBoxSeats6Seat3X :=529-45       484+10  494
;   PSPlayerBoxSeats6Seat3Y :=360-23       337+16  353

;   PSStackReadOffsetX := 10
;   PSStackReadOffsetY := 16

   Stack := DigitSearchByPixelCount(X,Y,W,H, "Stack", DummyByRef, WinId)
;outputdebug, tableseats:  %TableSeats%    stack:  %Stack%
   return Stack
}

