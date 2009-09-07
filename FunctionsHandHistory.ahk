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
 
 
 
; Check if there is a new hand history for this table... returns 1 if there is, else 0
HandHistoryIsNew(WinId)
{

   ; local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
   ; make sure this WinId is for a table
   ifWinNotExist, ahk_id%WinId% ahk_group Tables
   {
      Debug(A_ThisFunc,"WinId:" WinId " is not a Table")
      return 0
   }
   
   
   return %CasinoName%HandHistoryIsNew(WinId)
}


; determines if a new hh is waiting (and therefore a new hand has started)
; we keep a bunch of file sizes in global variables for each WinId
; returns 1 if there is a new hand history file
; return 0 if hand history file is old, OR if it doesn't exist
FTHandHistoryIsNew(WinId) {
;   local FileSize, FilePath


   ; get the hh file name, and return if it doesn't exist
   if NOT (FilePath := HandHistoryFilePath(WinId))
   {
;      Debug(A_ThisFunc,"HH file path not found for WinId:" . WinId)
      return 0
   }
;outputdebug, in is new   FilePath:%FilePath%
   FileGetSize, FileSize, % FilePath

   ; if the current size is the same as the last size, then return the last hand history
   if (FileSize == LastHandHistoryFileSize%WinId%)
      return 0
   else
      return 1
}




; determines if a new hh is waiting (and therefore a new hand has started)
; we keep a bunch of file sizes in global variables for each WinId
; returns 1 if there is a new hand history file
; return 0 if hand history file is old, OR if it doesn't exist
PSHandHistoryIsNew(WinId) {

;   local FileSize, FilePath


   ; get the hh file Path, and return if it doesn't exist
   if NOT (FilePath := HandHistoryFilePath(WinId))
   {
;      Debug(A_ThisFunc,"HH file path not found for WinId:" . WinId)
      return 0
   }

   FileGetSize, FileSize, % FilePath

   ; if the current size is the same as the last size, then return the last hand history
   if (FileSize == LastHandHistoryFileSize%WinId%)
      return 0
   else
      return 1
}


; **************************************************************************************************************************************


HandHistory(WinId)
{

   ; local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   ; make sure this WinId is for a table
   ifWinNotExist, ahk_id%WinId% ahk_group Tables
   {
      Debug(A_ThisFunc,"WinId:" WinId " is not a Table")
      return 0
   }

   return %CasinoName%HandHistory(WinId)
}


; returns the last hh for table WinId
; return "" if it doesn't exist
FTHandHistory(WinId)
{
   global                  ; all variables not defined in Local are global
   local HandHistory, FileSize, FilePath

   ; get the hh file Path, and return if it doesn't exist
   if NOT (FilePath := HandHistoryFilePath(WinId))
   {
;      Debug(A_ThisFunc,"HH file path not found for WinId:" . WinId)
      return ""
   }
   
;outputdebug, FilePath:%FilePath%

   FileGetSize, FileSize, % FilePath
;outputdebug, in FTHH    FileSize:%FileSize%     WinId:%WinId%
   ; if the current size is the same as the last size, then return the last hand history
   if (FileSize == LastHandHistoryFileSize%WinId%)
      return LastHandHistory%WinId%

;outputdebug, in FTHH    FileSize:%FileSize%    file size different from last time

   FileRead, HandHistory, % FilePath

   StringTrimLeft, HandHistory, HandHistory, InStr(HandHistory, "Full Tilt Poker Game #", "", 0) - 1
   LastHandHistoryFileSize%WinId% := FileSize
   LastHandHistory%WinId% := HandHistory
   
   
   ; calculate other global variables from this new hh
   
   ; BE SURE TO ADD NEW VARS TO THE CLEAN UP ROUTINE, and to the comments in the variables file


   HeroName := HeroName(WinId)
   
;outputdebug, in FTHH  HeroName:%HeroName%     WinId:%WinId%


   ; if we found the Hero's name and if the HH says that we busted out (stands up), then set flag
   if (HeroName AND InStr(HandHistory, HeroName . " stands up"))
   {
;outputdebug, in FFTH  FilePath:%FilePath%
;outputdebug, in FTHH  HeroName:%HeroName%     WinId:%WinId%    found stands up
;outputdebug, in FTHH  HandHistory:%HandHistory%
      LastHandHistoryStandsUp%WinId% := 1
   }
   else
   {
;outputdebug, in FTHH  HeroName:%HeroName%      did not find standup
      LastHandHistoryStandsUp%WinId% := 0
   }
   
   
   
   
   return HandHistory
}


; returns the last hh for table WinId
; return "" if it doesn't exist
PSHandHistory(WinId)
{
   global                  ; all variables not defined in Local are global
   local HandHistory, FileSize, FilePath, HeroName

   ; get the hh file Path, and return if it doesn't exist
   if NOT (FilePath := HandHistoryFilePath(WinId))
   {
;      Debug(A_ThisFunc,"HH file path not found for WinId:" . WinId)
      return ""
   }
      
   FileGetSize, FileSize, % FilePath

   ; if the current size is the same as the last size, then return the last hand history
   if (FileSize == LastHandHistoryFileSize%WinId%)
      return LastHandHistory%WinId%
      
   FileRead, HandHistory, % FilePath

   StringTrimLeft, HandHistory, HandHistory, InStr(HandHistory, "PokerStars Game #", "", 0)-1
   LastHandHistoryFileSize%WinId% := FileSize
   LastHandHistory%WinId% := HandHistory

;outputdebug, new PS HH   %HandHistory%
   
   ; calculate other global variables from this new hh
   
   ; BE SURE TO ADD NEW VARS TO THE CLEAN UP ROUTINE, and to the comments in the variables file
   
   HeroName := HeroName(WinId)
   
   ; if the HH says that we timed out or are sitting out, then set flag
   ;    Seat 1: nanochip (1000 in chips) is sitting out
   if ( InStr(HandHistory, HeroName . " has timed out")     OR    regExMatch(HandHistory, "Seat \d{1,2}: " HeroName " \(.*\) is sitting out") )
   {
;outputdebug,  found sitting out message  HeroName:%HeroName%
      LastHandHistoryHeroTimedOut%WinId% := 1
   }
   else
   {
;outputdebug,  did not find sitting out message  HeroName:%HeroName%
      LastHandHistoryHeroTimedOut%WinId% := 0
   }

   return HandHistory
}


; ******************************************************************************************************************************


; finds the hh file path for table WinId
; returns "" if the FilePath does not exist.
HandHistoryFilePath(WinId) {
   global
   local WinTitle, FilePath, TableName, CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   ; make sure this WinId is for a table
   ifWinNotExist, ahk_id%WinId% ahk_group Tables
   {
;      Debug(A_ThisFunc,"WinId:" WinId " is not a Table")
      return ""
   }

   ; set the update time to 0 if this is the first time for this WinId
   If NOT LastHandHistoryFilePathUpdateTime%WinId%
      LastHandHistoryFilePathUpdateTime%WinId% := 0

   ; if we have already found the file path,
   ;     AND too much time has NOT passed by  (we need to recheck the path, as it can change if the user get moved to another table, or the date changes past midnight.
   ;              in which case PS and FT both create a new name for the hand history with the current date in it.)
   ; then just return the previous file path
   if ((LastHandHistoryFilePath%WinId%)  AND  ((A_TickCount - LastHandHistoryFilePathUpdateTime%WinId%) < FilePathUpdateIntervalMS) )
      return LastHandHistoryFilePath%WinId%

   ; since we are doing an update on the FilePath, set the update time to the current time, so we know the time when we last updated this path name
   LastHandHistoryFilePathUpdateTime%WinId% := A_TickCount

   TableName := TableNameOrNumber(WinId)

   if TableName
   {
   
      FilePath := FileSearchOneCriteriaLatestDate(TableName,"Summary", %CasinoName%HHFolder, "txt")
      if FilePath
      {
         LastHandHistoryFilePath%WinId% := FilePath
         return FilePath
      }
      else
      {
;         Debug(A_ThisFunc,"Could not find hand history file path for WinId: " . WinId)
         return ""
      }
   }
}






; *********************************************************************************************************************************************


