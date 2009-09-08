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


; move mouse to (and activate) the next FT table that is slightly further away from the
; top left corner of the virtual screen
TableNext()
{
   global
   local vTableIdList, vFlag
   local vScreentX, vScreenY              ; pixel position of upper left of screen
   local vActiveId, vActiveDist           ; active table id and distance from upper left of screen
   local vShortId, vShortDist             ; closest table to the upper left of screen
   local vNextId, vNextDist               ; table that we should move to next
   local vTestId, vTestDist               ; table being analyzed out of all the ft tables
   local vTableX, vTableY                 ; a table's x and y screen position
   local vTX, vTY                         ; where to position the mouse after jumping to new table
   local ClientScaleFactor, CasinoName

   ;get the pixel position of the upper left corner of the virtual screen
   Sysget,vScreenX,76
   SysGet,vScreenY,77

   ; activate the table under the mouse
   vActiveId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT vActiveId)
      return

   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, vTableIdList, List, ahk_group Tables

   ; get the current table's screen position and Distance from top left of screen
   WinGetPos, vTableX,vTableY,,, ahk_id%vActiveId%
   vActiveDist := Distance(vTableX,vTableY,vScreenX,vScreenY)

   ; initialize the shortest table (from the upper left of screen) and
   ; the Next table that we will jump to
   ; init them to the active table, and they will be changed in the loop below
   vShortId := vActiveId
   vShortDist := vActiveDist
   vNextId := vActiveId
   vNextDist := vActiveDist


   ;loop until we get to a table that we are seated at
   loop, %vTableIdList%
   {
      ; get the id of the next table in the list
      vTestID := vTableIdList%A_index%

      ; check if we our test table is the active table, if so ignore it
      if (vTestId == vActiveId)
         continue

      ; check if the test table is minimized, if so then ignore it
      WinGet, vFlag,MinMax, ahk_id%vTestId%
      if (vFlag == -1)
         continue

      ; check if we are seated at this table
      ; if NOT seated, then ignore this table
      ;ControlGet, vFlag,Visible,,%SitOutNextHandCheckbox%, ahk_id%vTestId%
      ;if (NOT vFlag)
      ;   Continue
      ;if (HeroSeated(vTestId) == 0)
      ;  continue


      ; get the position and distance for this test table
      WinGetPos, vTableX,vTableY,,, ahk_id%vTestId%
      vTestDist := Distance(vTableX,vTableY,vScreenX,vScreenY)

      ; if vNextDist == vActiveDist, then we haven't found a further table yet
      if (vNextDist == vActiveDist)
      {
         ; see if the test table is further than the Next table
         if (vTestDist > vNextDist)
         {
            vNextId := vTestId
            vNextDist := vTestDist
         }
      }
      ; else vNextDist must be > vActiveDist
      else
      {
         if ((vTestDist > vActiveDist) AND (vTestDist < vNextDist))
         {
            vNextId := vTestId
            vNextDist := vTestDist
         }
      }

      if (vTestDist < vShortDist)
      {
         vShortId := vTestId
         vShortDist := vTestDist
      }
   }

   ; check if we are already at the furthest table, if so make the next table the shortest dist table
   if (vNextDist == vActiveDist)
   {
      vNextId := vShortId
   }

   WinActivate, ahk_id%vNextId%

   if NOT (CasinoName := CasinoName(vNextId,A_ThisFunc))
      return



   ; move the mouse to next to the betting box
   vTX := %CasinoName%MouseHomePosX
   vTY := %CasinoName%MouseHomePosY
;outputdebug,  in table next CasinoName:%CasinoName%   X:%vTX%   Y:%vTX%
   WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", vNextId)

   CoordMode, Mouse, Screen
   MouseMove,vTX,vTy,0
}


; ------------------------------------------------------------------------------

; move mouse to (and activate) the previous FT table that is slightly closer to the
; top left corner of the virtual screen
TablePrevious()
{
   global                                                   ;???  any globals in here ???
   local vTableIdList, vFlag
   local vScreentX, vScreenY              ; pixel position of upper left of screen
   local vActiveId, vActiveDist           ; active table id and distance from upper left of screen
   local vLongId, vLongDist             ; furthest table to the upper left of screen
   local vNextId, vNextDist               ; table that we should move to next
   local vTestId, vTestDist               ; table being analyzed out of all the ft tables
   local vTableX, vTableY                 ; a table's x and y screen position
   local vTX, vTY                         ; where to position the mouse after jumping to new table
   local ClientScaleFactor, CasinoName

   ;get the pixel position of the upper left corner of the virtual screen
   Sysget,vScreenX,76
   SysGet,vScreenY,77

   ; activate the table under the mouse
   vActiveId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT vActiveId)
      return

   ;make a list of all the open table IDs, excluding Lobby
   ;WinGet puts the table count in the variable TableIdList,
   WinGet, vTableIdList, List, ahk_group Tables

   ; get the current table's screen position and Distance from top left of screen
   WinGetPos, vTableX,vTableY,,, ahk_id%vActiveId%
   vActiveDist := Distance(vTableX,vTableY,vScreenX,vScreenY)

   ; initialize the Longest table (from the upper left of screen) and
   ; the Next table that we will jump to
   ; init them to the active table, and they will be changed in the loop below
   vLongId := vActiveId
   vLongDist := vActiveDist
   vNextId := vActiveId
   vNextDist := vActiveDist


   ;loop until we get to a table that we are seated at
   loop, %vTableIdList%
   {
      ; get the id of the next table in the list
      vTestID := vTableIdList%A_index%

      ; check if we our test table is the active table, if so ignore it
      if (vTestId == vActiveId)
         continue

      ; check if the test table is minimized, if so then ignore it
      WinGet, vFlag,MinMax, ahk_id%vTestId%
      if (vFlag == -1)
         continue

      ; check if we are seated at this table
      ; if NOT seated, then ignore this table
;      if (HeroSeated(vTestId) == 0)
;         continue

      ; get the position and distance for this test table
      WinGetPos, vTableX,vTableY,,, ahk_id%vTestId%
      vTestDist := Distance(vTableX,vTableY,vScreenX,vScreenY)

      ; if vNextDist == vActiveDist, then we haven't found a further table yet
      if (vNextDist == vActiveDist)
      {
         ; see if the test table is further than the Next table
         if (vTestDist < vNextDist)
         {
            vNextId := vTestId
            vNextDist := vTestDist
         }
      }
      ; else vNextDist must be < vActiveDist
      else
      {
         if ((vTestDist < vActiveDist) AND (vTestDist > vNextDist))
         {
            vNextId := vTestId
            vNextDist := vTestDist
         }
      }

      if (vTestDist > vLongDist)
      {
         vLongId := vTestId
         vLongDist := vTestDist
      }
   }

   ; check if we are already at the furthest table, if so make the next table the Longest dist table
   if (vNextDist == vActiveDist)
   {
      vNextId := vLongId
   }

   WinActivate, ahk_id%vNextId%

   if NOT (CasinoName := CasinoName(vNextId,A_ThisFunc))
      return

   ; move the mouse to next to the betting box
   vTX := %CasinoName%MouseHomePosX
   vTY := %CasinoName%MouseHomePosY

   WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", vNextId)
   CoordMode, Mouse, Screen
   MouseMove,vTX,vTy,0
}


; activate the second table in the stack, by sending the top table to the bottom of the stack
TableNextInStack()
{
   global
   local CasinoName,vTX,vTy,TopId, SecondId
; need to make TableIdList a global variable, can't make it work as a local, since we are accessing elements of the array

   ; get the list of tables
   WinGet, TableIdList, List, ahk_group Tables
   
   TopId := TableIdList1
   SecondId := TableIdList2

;outputdebug, next in stack:    num tables=%TableIdList%   top table id= %TopId%   2nd table id= %SecondId%
   
   ; send the top one to the bottom
   WinSet, Bottom,,ahk_id%TopId%
   ; activate the 2nd table
   WinActivate, ahk_id%SecondId%
 
;outputdebug, next in stack:    num tables=%TableIdList%   top table id= %TableIdList1%   2nd table id= %TableIdList2%

   if NOT (CasinoName := CasinoName(SecondId,A_ThisFunc))
      return

   ; move the mouse to next to the betting box
   vTX := %CasinoName%MouseHomePosX
   vTY := %CasinoName%MouseHomePosY

   WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", SecondId)
   CoordMode, Mouse, Screen
   MouseMove,vTX,vTy,0

}

TableBottomOfStack()
{
   global
   local CasinoName,vTX,vTy, BottomId,TableIdList
; need to make TableIdList a global variable, can't make it work as a local, since we are accessing elements of the array
   
   ; get the list of tables
   WinGet, TableIdList, List, ahk_group Tables

;outputdebug, bottom of stack:   num tables=%TableIdList%   top table id= %TableIdList1%   2nd table id= %TableIdList2%  3rd table id= %TableIdList3%

   ; get the id of the bottom table
   BottomId := TableIdList%TableIdList%
   ; activate the Bottom table table
   WinActivate, ahk_id%BottomId%

   if NOT (CasinoName := CasinoName(BottomId,A_ThisFunc))
      return

   ; move the mouse to next to the betting box
   vTX := %CasinoName%MouseHomePosX
   vTY := %CasinoName%MouseHomePosY

   WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", BottomId)
   CoordMode, Mouse, Screen
   MouseMove,vTX,vTy,0

}







