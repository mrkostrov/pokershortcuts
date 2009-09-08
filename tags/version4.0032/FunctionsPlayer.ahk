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
; Player Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



/*
PlayersName()
   Purpose: Returns the player's name and also puts it in the clipboard
            The software calls the function for the appropriate casino function (which reads the title bar)
   Requires:
            The user must have the mouse over a player's box, in order for this to work
   Returns:
      The player's name
      Returns the player's name in the clipboard
   Parameters:
      WinId: window id.
*/
PlayersName(WinId="")
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
      
   Return %CasinoName%PlayersName(WinId)

}


; if the mouse is over a player's box, then this function will get the player's name
;     by activating the player's notes,
;     and the name will be returned from this function
FTPlayersName(WinId)
{
   global
   local PlayersName, WinTitle

   ; since we were called by the parent function, we already have a valid WinId for a table





   ; click the right button in the player's box
   MouseClick, Right,
   sleep, 100
   
   ; send keys to open the player's notes
   Send {Down} {Down} {Enter}
   
   
   ; wait til the Notes window is active
   WinWait, ahk_group Notes ,, 2
   ifWinActive,   ahk_group Notes
   {
      WinGetActiveTitle, WinTitle
      StringRight, PlayersName, WinTitle, StrLen(WinTitle) - Instr(WinTitle,":") -1
      WinClose, %WinTitle%
   }

   return PlayersName


}


; if the mouse is over a player's box, then this function will get the player's name
;     by activating the player's notes,
;     and the name will be returned from this function
PSPlayersName(WinId)
{
   global
   local PlayersName

   ; since we were called by the parent function, we already have a valid WinId for a table



   ; click the right button in the player's box
   MouseClick, Right,
   sleep, 100

   ; send keys to open the player's notes
   Send {Down} {Enter}

   sleep, 100

   ; read the player's name in the chat box area
   PlayersName := ControlGetText2("BoxNotePlayersName",WinId)
   
   ; return to the chat mode
   ButtonClick("ButtonChat",WinId)

   return PlayersName

}



; -----------------------------------------------------------------------------------------------

; if the mouse is over a player's name box, capture the name and add it to the SharkList file
PlayersNameToSharkList(WinId="")
{
   global
   local Name, TempList

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   Name := PlayersName(WinId)
   
   ; if the name is too long... then just exit. Something went wrong
   if (Strlen(Name) > 30)
      return
   
   if Name
   {
      ; if the name is not already in the list, add it in
      if !ListGetPos(SharkList,Name)
      {
         ListAddItem(SharkList,Name)
         ; rewrite the entire sharklist to the text file
         FileDelete, Settings\SharkList.txt
         
         FileAppend,
         (
; Close the Poker Shortcuts software before adding shark names here.
; Only put one shark's name per line. Comment lines start with a ;
; No commas are allowed in the Sharks names

         ), Settings\SharkList.txt
         
         ; change to a comma delimeted list to a linefeed delimited list to save to file
         StringReplace, TempList, SharkList, `, , `n, ALL
         FileAppend, %TempList%, Settings\SharkList.txt
      }
   }
}

; -----------------------------------------------------------------------------------------------

; if the mouse is over a player's name box, capture the name and remove it to the SharkList file
PlayersNameFromSharkList(WinId="")
{
   global
   local Name, TempList

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }

   Name := PlayersName(WinId)

   ; if the name is too long... then just exit. Something went wrong
   if (Strlen(Name) > 30)
      return
   
   if Name
   {
      ; if the name is already in the list, remove it
      if ListGetPos(SharkList,Name)
      {
         ListDelItem(SharkList,Name)
         ; rewrite the entire sharklist to the text file
         FileDelete, Settings\SharkList.txt
         

         FileAppend,
         (
; Close the Poker Shortcuts software before adding shark names here.
; Only put one shark's name per line. Comment lines start with a ;
; No commas are allowed in the Sharks names

         ), Settings\SharkList.txt

         
         ; change to a comma delimeted list to a linefeed delimited list to save to file
         StringReplace, TempList, SharkList, `, , `n, ALL
         FileAppend, %TempList%, Settings\SharkList.txt
      }
   }
}


; -------------------------------------------------------------------------------------------------
/*
PlayersStack(n,WinId)
   Purpose: This function determines the stack size of a player n
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
PlayersStack(PlayerNum,WinId)
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
;   HeroSeatNum := ListGetItem(%CasinoName%HeroSeatNumList, Pos1)

;outputdebug, Seats:%TableSeats%    Position in table list:%Pos1%    HeroSeatNum:%HeroSeatNum%

   ; find the position to read the stack
   X:= %CasinoName%PlayerBoxSeats%TableSeats%Seat%PlayerNum%X + %CasinoName%StackReadOffsetX
   Y:= %CasinoName%PlayerBoxSeats%TableSeats%Seat%PlayerNum%Y + %CasinoName%StackReadOffsety
   W:= %CasinoName%StackReadW
   H:= %CasinoName%StackReadH


;outputdebug, TableSeats:%TableSeats%  HeroSeatNum:%HeroSeatNum%  %X%  %Y%  %W%  %H%

;   PSPlayerBoxSeats6Seat3X :=529-45       484+10  494
;   PSPlayerBoxSeats6Seat3Y :=360-23       337+16  353

;   PSStackReadOffsetX := 10
;   PSStackReadOffsetY := 16

   Stack := DigitSearchByPixelCount(X,Y,W,H, "Stack", DummyByRef, WinId)
;outputdebug, tableseats:  %TableSeats%    stack:  %Stack%     pixel digits:%DummyByRef%
   return Stack
}
