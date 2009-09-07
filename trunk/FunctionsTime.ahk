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
; Time Button Functions
; ------------------------------------------------------------------------------
; ******************************************************************************


; Check if we should click the time button for this table
; time button gets clicked if   AutoClickTimerEnabled,  TimeButtonWaitTime has gone by after Time Button appears
; AND/OR
; time button gets clicked if   AutoClickTimerIfBetBoxEnabled,   TimeButtonIfPendingActionWaitTime has gone by after Betting Box appears  (Stars tables only)

TimeButtonCheck(WinId)
{
   global
   local Flag, Pos, CasinoName, StartTime

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return


   if AutoClickTimerEnabled
   {
      ; check if the Time button is visible on this table
      if  (ButtonVisible("ButtonTime",WinId) == 1)
      {
;outputdebug, Time button visible      
         ; check if this table is already on the time list
         Pos := ListGetPos(TimeButtonIdList,WinId)
         if Pos
         {
            ; check if it is time to click the time button (we try to wait until we really need it)
            ; NOTE: we actually keep clicking it every time TimerMedium is run, but that shouldn't hurt anything.
            StartTime := ListGetItem(TimeButtonTimeList,Pos)
            if ((A_TickCount -  StartTime)  > (TimeButtonWaitTime * 1000))
            {
               ; click the time button on this table, if this auto click feature is enabled
               ;if AutoClickTimerEnabled                          ; we now check that this is true before calling this function
               ButtonClick("ButtonTime", WinId)
               ButtonClick("ButtonTime", WinId)
;outputdebug, Clicking Time Button on WinId:%WinId%
               ; add 1000 ms to the start time, so that we will click it again in one second...  just in case it didn't register on the table
               ListReplaceItemAtPos(TimeButtonTimeList,Pos,StartTime + 1000)
            }
         }
         ; else the table is not already listed in the list, add it to the list
         else
         {
;outputdebug, adding time buton to list         
            ListAddItem(TimeButtonIdList,WinId)
            ListAddItem(TimeButtonTimeList,A_TickCount)
         }


      }
      ; else the time button is not visible
      else
      {
         ; check if this table is on the list... if so, remove it
         Pos := ListGetPos(TimeButtonIdList,WinId)
         if Pos
         {
;outputdebug, removing time button from list         
            ListDelPos(TimeButtonIdList,Pos)
            ListDelPos(TimeButtonTimeList,Pos)
         }
      }
   }







   ; if enabled it clicks the time button after x seconds after the betting box appears
   if (AutoClickTimerIfBetBoxEnabled)
   {
   
      ; check if the Pending action is visible on this table
;      if  ControlVisible("BoxBetEdit",WinId)
      if TablePendingAction(WinId)
      {
         ; check if this table is already on the time list
         Pos := ListGetPos(PendingActionForTimeButtonIdList,WinId)
         if Pos
         {
            ; check if it is time to click the time button (we try to wait until we really need it)
            ; NOTE: we actually keep clicking it every time TimerMedium is run, but that shouldn't hurt anything.
            StartTime := ListGetItem(PendingActionForTimeButtonTimeList,Pos)
            if ((A_TickCount -  StartTime)  > (TimeButtonIfPendingActionWaitTime * 1000))
            {
               ; click the time button on this table, if this auto click feature is enabled
               ;if AutoClickTimerEnabled                          ; we now check that this is true before calling this function
               ButtonClick("ButtonTime", WinId)
;outputdebug, Clicking Time Button on Stars WinId:%WinId%
               ; add 2000 ms to the start time, so that we will click it again later...  just in case it didn't register on the table
               ListReplaceItemAtPos(PendingActionForTimeButtonTimeList,Pos,StartTime + 2000)
            }
         }
         ; else the table is not already listed in the list, add it to the list
         else
         {
            ListAddItem(PendingActionForTimeButtonIdList,WinId)
            ListAddItem(PendingActionForTimeButtonTimeList,A_TickCount)
         }


      }
      ; else the betting box is not visible
      else
      {
         ; check if this table is on the list... if so, remove it
         Pos := ListGetPos(PendingActionForTimeButtonIdList,WinId)
         if Pos
         {
            ListDelPos(PendingActionForTimeButtonIdList,Pos)
            ListDelPos(PendingActionForTimeButtonTimeList,Pos)
         }
      }
   }



}




; *******************************************************************************
; clean up the Time Button Lists, in case one of the tables no longer exists
TimeButtonListCleanup()
{
   global
   local ListLength, WinId

   ListLength := ListLength(TimeButtonIdList)

   loop, % ListLength
   {
      ; get the next table ID of tables in the list, STARTING FROM THE END
      WinId := ListGetItem(TimeButtonIdList,ListLength - A_Index +1)
      IfWinNotExist, ahk_id%WinId%
      {
         ; remove this table from the list, since this table no longer exists
         ListDelPos(TimeButtonIdList,ListLength - A_Index +1)
         ListDelPos(TimeButtonTimeList,ListLength - A_Index +1)

      }
   }
}
