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
; Table Functions
; -------------------------------------------------------------------------------
; *******************************************************************************






; activate the table under the mouse... if the window under the mouse is not
;     a full tilt table, then just return (0)
;     returns the winID of the table,
TableActivateUnderMouse()
{
   ;local WinId, MouseX, MouseY

   ; get the screen mouse position
   CoordMode, Mouse, Screen
   MouseGetPos, MouseX, MouseY

   ; find the top window at this mouse location... but ignore any huds
   WinId := WindowOnTopAtXY(MouseX,MouseY)

;outputdebug, mouseisover: %WinId%

   ; if mouse is over a Full table
   IfWinExist, ahk_id%WinId% ahk_group Tables
   {
      ; if the table is not active, then activate it
      ifWinNotActive, ahk_id%WinId% ahk_group Tables
      {
         WinActivate, ahk_id%WinId% ahk_group Tables
      }
      ; mouse is now over an active FT table... return the winid of it
      return WinId
   }
   ; else return 0, cuz the mouse is not over a FT table
   else
      return 0
}


/*
TableBlinds()
   Purpose: Returns the BB, SB, and Ante for this table.
            The software call the function for the appropriate casino function (which reads the title bar)
   Requires:
            none
   Returns:
      number seats
      0 if not determined
   Parameters:
      ByRef CasinoName: casino initials...returns it if not sent
      WinId: window id... returns active window id if not passed
   Global Variables updated:
      BigBlind%WinId%
      SmallBlind%WinId%
      Ante%WinId%
*/
TableBlinds(WinId)
{

   global
   local CasinoName
   
   ; if this is a ring game, then no need to get the blind info again, IF we already have it
   ;     since blinds don't increase in a ring game
   ;     we check the ante against a ""  since it is often 0
   if (  TableRingOrTournament(WinId)  AND  BigBlind%WinId%   AND   SmallBlind%WinId%   AND   (Ante%WinId% <> "")    )
      return
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
   return %CasinoName%TableBlinds(WinId)
}




FTTableBlinds(WinId)
{
   global
   local WinTitle, Pos0, Pos1, Pos2, Pos3, BigBlind, SmallBlind, Ante

   ; need to find the amount of the small blind and big blind...   read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%
   ; sometimes the title is slow to come up on tables
   if NOT WinTitle
      return
      
   Ante := 0

   ; read the small blind and big blind from the window title

   ; check if this is a play money cash game WITHOUT antes
   If (InStr(WinTitle, "Play Chip") AND (NOT InStr(WinTitle,"Play Chip Tournament")) AND (NOT InStr(WinTitle," Ante ")))
   {
      ; find the first -
      Pos1 := InStr(WinTitle," - ")
      ; find the position of /
      Pos2 := Instr(WinTitle, "/")
      ; find the position of the " - " after the big blind
      Pos3 := InStr(WinTitle, " - ", 0 , Pos2)
      StringMid, SmallBlind, WinTitle, Pos1 + 3, Pos2 - Pos1 - 3
      StringMid, BigBlind,   WinTitle, Pos2 + 1, Pos3 - Pos2 - 1
   }
   ; check if this is a play money cash game WITH antes
   else If (InStr(WinTitle, "Play Chip") AND (NOT InStr(WinTitle,"Play Chip Tournament")) AND (InStr(WinTitle," Ante ")))
   {
      ; find the position of the first char of SB
      Pos1 := InStr(WinTitle," - ") + 3
      ; find the position of the last char of SB
      Pos2 := Instr(WinTitle, "/") - 1
      StringMid, SmallBlind, WinTitle, Pos1, Pos2 - Pos1 + 1
      ; find the position of the first char of the BB
      Pos1 := Pos2 + 2
      ; find the position of the last char of the BB
      Pos2 := InStr(WinTitle, " Ante ") - 1
      StringMid, BigBlind,   WinTitle, Pos1, Pos2 - Pos1 + 1
      ; find the position of the first char of the Ante
      Pos1 := Pos2 + 7
      ; find the position of the last char of the Ante
      Pos2 := InStr(WinTitle, "-",0,Pos2) - 2
      StringMid, Ante,   WinTitle, Pos1, Pos2 - Pos1 + 1
   }
   ; check if this is a real money cash game WITHOUT ANTES
   ; cash games have "/$ in them"
   else If (InStr(WinTitle, "/$") AND (NOT InStr(WinTitle," Ante ")) )
   {
      ; find the first $
      Pos1 := InStr(WinTitle,"$")
      ; find the position of /$
      Pos2 := Instr(WinTitle, "/$")
      ; find the position of the - after the big blind
      Pos3 := InStr(WinTitle, "-",0,Pos2)
      StringMid, SmallBlind, WinTitle, Pos1 + 1, Pos2 - Pos1 -1
      StringMid, BigBlind, WinTitle, Pos2 + 2, Pos3 - Pos2 - 2
   }
   ; check if this is a real money cash game WITH ANTES
   ; cash games have "/$ in them"
   else If (InStr(WinTitle, "/$") AND (InStr(WinTitle," Ante ")) )
   {
      ; find the position of the first char of SB
      Pos1 := InStr(WinTitle," - ") + 4
      ; find the position of the last char of SB
      Pos2 := Instr(WinTitle, "/$") - 1
      StringMid, SmallBlind, WinTitle, Pos1, Pos2 - Pos1 + 1
      ; find the position of the first char of the BB
      Pos1 := Pos2 + 3
      ; find the position of the last char of the BB
      Pos2 := InStr(WinTitle, " Ante ") - 1
      StringMid, BigBlind,   WinTitle, Pos1, Pos2 - Pos1 + 1
      ; find the position of the first char of the Ante
      Pos1 := Pos2 + 8
      ; find the position of the last char of the Ante
      Pos2 := InStr(WinTitle, "-",0,Pos2) - 2
      StringMid, Ante,   WinTitle, Pos1, Pos2 - Pos1 + 1
   }
   ; else this must be a tournament
   ; check if there are antes in this must be a tournament.
   else if InStr(WinTitle," Ante ")
   {
      ; find the )
      Pos0 := InStr(WinTitle,")")
      ; find the first - after the )
      Pos1 := InStr(WinTitle," - ", 0, Pos0)
      ; find the position of / after the -
      Pos2 := Instr(WinTitle, "/", 0, Pos1)
      ; find the position of the word "Ante" after the big blind
      Pos3 := InStr(WinTitle, "Ante", 0 , Pos2)
      ; find the position of " - " after the word Ante
      Pos4 := InStr(WinTitle, " - ", 0 , Pos3)
      StringMid, SmallBlind, WinTitle, Pos1 + 3, Pos2 - Pos1 - 3
      StringMid, BigBlind, WinTitle, Pos2 + 1, Pos3 - Pos2 - 1
      StringMid, Ante, WinTitle, Pos3 + 5, Pos4 - Pos3 - 5
   }
   ; else there are not antes
   else
   {
      ; find the )
      Pos0 := InStr(WinTitle,")")
      ; find the first - after the )
      Pos1 := InStr(WinTitle," - ", 0, Pos0)
      ; find the position of /
      Pos2 := Instr(WinTitle, "/")
      ; find the position of the " - " after the big blind
      Pos3 := InStr(WinTitle, " - ", 0 , Pos2)
      StringMid, SmallBlind, WinTitle, Pos1 + 3, Pos2 - Pos1 - 3
      StringMid, BigBlind,   WinTitle, Pos2 + 1, Pos3 - Pos2 - 1
   }
   
   BigBlind%WinId% := BigBlind
   SmallBlind%WinId% := SmallBlind
   Ante%WinId% := Ante


}


PSTableBlinds(WinId)
{
   global
   local WinTitle, Pos0, Pos1, Pos2, Pos3, BigBlind, SmallBlind, Ante

   ; need to find the amount of the small blind and big blind...   read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%
   
   ; sometimes the title is slow to come up on tables
   if NOT WinTitle
      return

   BigBlind := 0
   SmallBlind := 0
   Ante := 0

   ; read the small blind and big blind from the window title

   ; check if this is a play money cash game    format:   name - 5/10 Play Money - No Limit Hold'em
   If (InStr(WinTitle, "Play Money")  AND (NOT InStr(WinTitle,"Tournament"))  )
   {
      ; if there are antes
      if (InStr(WinTitle," Ante ", 1))
      {
         ; find the pos of the 1st digit of the small blind
         Pos1 := InStr(WinTitle," - ") + 3
         ; find the position of the first digit of the big blind
         Pos2 := Instr(WinTitle, "/") + 1
         ; find the position first digit of the Ante
         Pos3 := InStr(WinTitle, "Ante") + 5
         ; find the position of the last digit of the Ante
         Pos4 := InStr(WinTitle, "Play",0,Pos3) - 2
         StringMid, SmallBlind, WinTitle, Pos1, (Pos2 - 2) - Pos1 + 1
         StringMid, BigBlind, WinTitle, Pos2, (Pos3 - 7) - Pos2 + 1
         StringMid, Ante, WinTitle, Pos3, Pos4 - Pos3 + 1
      }
      ; else no ante      format:   name - 5/10 Play Money - Pot Limit Hold'em
      else
      {
         ; find the pos of the 1st digit of the small blind
         Pos1 := InStr(WinTitle," - ") + 3
         ; find the position of the first digit of the big blind
         Pos2 := Instr(WinTitle, "/") + 1
         ; find the position of the last digit of the big blind
         Pos3 := InStr(WinTitle, "Play Money") - 2
         StringMid, SmallBlind, WinTitle, Pos1, (Pos2 - 2) - Pos1 + 1
         StringMid, BigBlind, WinTitle, Pos2, Pos3 - Pos2 + 1
      }
   }
   ; check if this is a real money cash game   format:   name - $5/$10 Ante $0.50 - Limit Razz
   ; cash games have "/$ in them"
   else If (NOT InStr(WinTitle,"Tournament"))
   {
      ; if there are antes
      if (InStr(WinTitle," Ante ", 1))
      {
         ; find the pos of the 1st digit of the small blind
         Pos1 := InStr(WinTitle,"$") + 1
         ; find the position of the first digit of the big blind
         Pos2 := Instr(WinTitle, "/$") + 2
         ; find the position first digit of the Ante
         Pos3 := InStr(WinTitle, "Ante $") + 6
         ; find the position of the last digit of the Ante
         Pos4 := InStr(WinTitle, " - ",0,Pos3) - 1
         StringMid, SmallBlind, WinTitle, Pos1, (Pos2 - 3) - Pos1 + 1
         StringMid, BigBlind, WinTitle, Pos2, (Pos3 - 8) - Pos2 + 1
         StringMid, Ante, WinTitle, Pos3, Pos4 - Pos3 + 1
      }
      ; else no ante      format:   name - $5/$10 - Pot Limit Hold'em
      else
      {
         ; find the pos of the 1st digit of the small blind
         Pos1 := InStr(WinTitle,"$") + 1
         ; find the position of the first digit of the big blind
         Pos2 := Instr(WinTitle, "/$") + 2
         ; find the position of the last digit of the big blind
         Pos3 := InStr(WinTitle, " - ",0,Pos2) - 1
         StringMid, SmallBlind, WinTitle, Pos1, (Pos2 - 3) - Pos1 + 1
         StringMid, BigBlind, WinTitle, Pos2, Pos3 - Pos2 + 1
      }
   }
   ; else this must be a FOR MONEY tournament     format:    Tournament 12345678 Table 1 - $5.20 No Limit Hold'em - Blinds $200/$400 Ante $25 - Logged in as nanochip
   ; check if there are antes in this must be a tournament.
   else if ( (InStr(WinTitle," Ante ", 1)) AND (InStr(WinTitle,"/$")) )
   {
      ; find position the first digit of the small blind after the word "- Blinds $"
      Pos0 := InStr(WinTitle,"- Blinds $") + 10
      ; find the position of the first digit of the big blind
      Pos1 := InStr(WinTitle,"/$", 0, Pos0) + 2
      ; find the position of first digit of the Ante
      Pos2 := Instr(WinTitle, "Ante ", 0, Pos1) + 6
      ; find the position of the last digit of the Ante
      Pos3 := InStr(WinTitle,"-", 0, Pos2) - 2
      ; if we are not logged in, there will not be a "-" after the ante, so just use the length of the string as the last digit of the ante
      if (Pos3 <= 0)
         Pos3 := strlen(WinTitle)
      StringMid, SmallBlind, WinTitle, Pos0, (Pos1 - 3) - Pos0 + 1
      StringMid, BigBlind, WinTitle, Pos1, (Pos2 - 8) - Pos1 + 1
      StringMid, Ante, WinTitle, Pos2, Pos3 - Pos2 + 1
   }
   ; else there are not antes in a FOR MONEY TOURNEY      format:    Tournament 12345678 Table 1 - $5.20 No Limit Hold'em - Blinds $200/$400 - Logged in as nanochip
   else if (InStr(WinTitle,"/$"))
   {
      ; find position the first digit of the small blind after the word "- Blinds $"
      Pos0 := InStr(WinTitle,"- Blinds $") + 10
      ; find the position of the first digit of the big blind
      Pos1 := InStr(WinTitle,"/$", 0, Pos0) + 2
      ; find the position of the last digit of the BB
      Pos2 := InStr(WinTitle,"-", 0, Pos1) - 2
      ; if we are not logged in, there will not be a "-" after the big blind, so just use the length of the string as the last digit of the BB
      if (Pos2 <= 0)
         Pos2 := strlen(WinTitle)
      StringMid, SmallBlind, WinTitle, Pos0, (Pos1 - 3) - Pos0 + 1
      StringMid, BigBlind, WinTitle, Pos1, Pos2 - Pos1 + 1
   }
   ; else this must be a Play MONEY tournament     format:    Tournament 12345678 Table 1 - 320 No Limit Hold'em - Blinds 200/400 Ante 25 - Logged In as nano
   ; check if there are antes
   else if (InStr(WinTitle," Ante ", 1))
   {
      ; find position of the first digit of the SB...   find second "-" and add 9
      Pos0 := InStr(WinTitle,"-")
      Pos0 := InStr(WinTitle,"-",0,Pos0+1) + 9
      ; find the position of the first digit of the big blind
      Pos1 := InStr(WinTitle,"/", 0, Pos0) + 1
      ; find the position of first digit of the Ante
      Pos2 := Instr(WinTitle, "Ante ", 0, Pos1) + 5
      ; find the position of the last digit of the Ante
      Pos3 := Instr(WinTitle, "-", 0, Pos2) - 2
      ; if we are not logged in, there will not be a "-" after the big blind, so just use the length of the string as the last digit of the BB
      if (Pos3 <= 0)
         Pos3 := strlen(WinTitle)
      StringMid, SmallBlind, WinTitle, Pos0, (Pos1 - 2) - Pos0 + 1
      StringMid, BigBlind, WinTitle, Pos1, (Pos2 - 7) - Pos1 + 1
      StringMid, Ante, WinTitle, Pos2, Pos3 - Pos2 + 1
   }
   ; else there are not antes in a Play MONEY TOURNEY      format:    Tournament 12345678 Table 1 - 320 No Limit Hold'em - Blinds 200/400 - Logged In as
   else
   {
      ; find position of the first digit of the SB...   find second "-" and add 9
      Pos0 := InStr(WinTitle,"-")
      Pos0 := InStr(WinTitle,"-",0,Pos0+1) + 9
      ; find the position of the first digit of the big blind
      Pos1 := InStr(WinTitle,"/", 0, Pos0) + 1
      ; find the position of the last digit of the BB
      Pos2 := InStr(WinTitle,"-",0,Pos2) - 2
      ; if we are not logged in, there will not be a "-" after the big blind, so just use the length of the string as the last digit of the BB
      if (Pos2 <= 0)
         Pos2 := strlen(WinTitle)
      StringMid, SmallBlind, WinTitle, Pos0, (Pos1 - 2) - Pos0 + 1
      StringMid, BigBlind, WinTitle, Pos1, Pos2 - Pos1 + 1
   }

   BigBlind%WinId% := BigBlind
   SmallBlind%WinId% := SmallBlind
   Ante%WinId% := Ante

}

/*
TableCall()
   Purpose: Returns the size of the amount to call. It reads the call button (or if not found, the value in the Raise button position)
   Returns:
      the call amount
      "" if no value found
   Parameters:
      WinId: window id.
      
   Note: we try the most likely table width, then the previous table width in the list, and then the next table width...
          just in case the user has a w x h table size (non standard table size)
*/
TableCall(WinId)
{
   global
   local Call, NumberOfTableWidths, TableWidth,PreviousTableWidth,NextTableWidth
   local WindowX,WindowY,WindowW,WindowH,ClientW,ClientH,WindowTopBorder, WindowBottomBorder, WindowSideBorder
   local FilePrefix,PreviousFilePrefix,NextFilePrefix
   local CasinoName

   if NOT (CasinoName := CasinoName%WinId%)
      return ""

   ; get the client width of this table
   WindowInfo(WindowX,WindowY,WindowW,WindowH,ClientW,ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)

   ; find the button image number size to use, based on the client width of this table
   NumberOfTableWidths := ListLength(%CasinoName%ButtonFontSizeTableWidths)
   Loop,
   {
      ; get the first table width from the list of break points
      TableWidth := ListGetItem(%CasinoName%ButtonFontSizeTableWidths, A_Index)
      PreviousTableWidth := ListGetItem(%CasinoName%ButtonFontSizeTableWidths, A_Index - 1)
      NextTableWidth := ListGetItem(%CasinoName%ButtonFontSizeTableWidths, A_Index + 1)
      
      ; if our current table width is in this font size range, then exit out of loop
      if (ClientW <= TableWidth)
         break

      ; if we exhausted the list return since we have tried all available table width sizes
      if (NumberOfTableWidths == A_Index)
         return ""
   }

   FilePrefix := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . TableWidth . "-"
   PreviousFilePrefix := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . PreviousTableWidth . "-"
   NextFilePrefix := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . NextTableWidth . "-"




   ; read the call size using digit image recognition
   ; the first call position is always in the center...   so check to see that the center button is visible
   if (ButtonVisible("ButtonCall",WinId) == 1)
   {
   
   
      Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos1X, %CasinoName%CallDigitsPos1Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, FilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
;Outputdebug, FilePrefix=  %FilePrefix%   call=%Call%


      if Call is number
         return Call

      if PreviousTableWidth
      {
         Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos1X, %CasinoName%CallDigitsPos1Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, PreviousFilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
;Outputdebug, FilePrefix=  %FilePrefix%   call=%Call%
         if Call is number
            return Call
      }
      if NextTableWidth
      {
;Outputdebug, FilePrefix=  %FilePrefix%   call=%Call%
         Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos1X, %CasinoName%CallDigitsPos1Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, NextFilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
         if Call is number
            return Call
      }
   }

   ; if we didn't read a number and there is another position available to check (which is the Raise button on Stars), then check the alternate position
   if (%CasinoName%CallDigitsPos2X )
   {
      ; we have to make sure that the alternate position really says "Call" above this amount
      ; on PS, the Call2 position is the far right button. That button can say Call, Bet, or Raise.
      ; So we have to look with image recognition to verify that it says Call.
      if (ButtonVisible("ButtonCall2",WinId) == 1)
      {
         Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos2X, %CasinoName%CallDigitsPos2Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, FilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
         if Call is number
            return Call

         if PreviousTableWidth
         {
            Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos2X, %CasinoName%CallDigitsPos2Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, PreviousFilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
            if Call is number
               return Call
         }
         if NextTableWidth
         {
            Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos2X, %CasinoName%CallDigitsPos2Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, NextFilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)
            if Call is number
               return Call
         }
      }
   }

;   Call := DigitsByImageRecognition(%CasinoName%CallDigitsPos1X, %CasinoName%CallDigitsPos1Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, FilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)

;   Call := Call . "    " .  DigitsByImageRecognition(%CasinoName%CallDigitsPos2X, %CasinoName%CallDigitsPos2Y, %CasinoName%CallDigitsPosW, %CasinoName%CallDigitsPosH, FilePrefix, "bmp", %CasinoName%CallColTol, 0, WinId)


   return 0
}



; close tables for WinId...
;  if pWinId == 0, then close all tables
;  if pWinId == 1, then close active table
;  else close specific table
TableClose(WinId)
{
   ; local WinIdList, Flag

   if (WinId == 1)
   {
      ; activate the table under the mouse
      WinId := TableActivateUnderMouse()
      if WinId
         PostMessage, 0x112, 0xF060,,, ahk_id%WinId%

   }
   ; else close all tables
   else if (WinId == 0)
   ; if WinId == 0, then we'll close all the open tables
   {
      WinGet, WinIdList, List, ahk_group Tables
      ; loop through all of the open tables
      Loop, %WinIdList%
      {
         ; find the next ID of the next open table


         WinId := WinIdList%A_Index%
         ; close this table
         PostMessage, 0x112, 0xF060,,,ahk_id%WinId%

      }
   }
   ; else close the specific table WinId
   else
   {
      if WinId
         PostMessage, 0x112, 0xF060,,, ahk_id%WinId%
   }
}



; close tables if the hero is not seated at the table for pWinId...
;  if pWinId == 0, then close all tables
;  if pWinId == 1, then close active table
;  else close pWinId table
TableCloseWithoutHero(WinId)
{
   ; local WinIdList, Flag

   ; if WinId == 0, then we'll close all the tables
   if (WinId == 0)
   {
      WinGet, WinIdList, List, ahk_group Tables
      ; loop through all of the open tables
      Loop, %WinIdList%
      {
         ; find the next ID of the next open table


         WinId := WinIdList%A_Index%
         ; close this table if the hero is not seated
         if (HeroSeated(WinId) == 0)
            PostMessage, 0x112, 0xF060,,,ahk_id%WinId%
      }
   }
   ; check if we should activate the table under the mouse and close it
   else if (WinId == 1)
   {
      ; activate the table under the mouse
      WinId := TableActivateUnderMouse()
      if (HeroSeated(WinId) == 0)
         PostMessage, 0x112, 0xF060,,, ahk_id%WinId%

   }
   ; else close the specific table WinId
   else
   {
      if (HeroSeated(WinId) == 0)
         PostMessage, 0x112, 0xF060,,, ahk_id%WinId%
   }
}


; close tournament table without hero, in delayed fashion... for WinId...
; we delay the closing by the gui setting:  CloseTableTimeDelay
TableTournamentCloseWithoutHeroDelayed(WinId)
{

   global

;outputdebug, in close without hero
   ; if the table is alread on the list, then return
   if instr(TableCloseIdList,WinId)
      return
;outputdebug, in close without hero1
   ; check if the Hero is NOT seated, and this is a tournament, then add this table to the list to be closed
   if ( (HeroSeated(WinId) == 0) AND (NOT TableRingOrTournament(WinId)) )
   {
      Critical, On
;outputdebug, in close without hero2
      ListAddItem(TableCloseIdList,WinId)
      ListAddItem(TableCloseTimeList,A_TickCount)
   }

   Critical, Off
}



; close table on TableCloseIdList in delayed fashion(when CloseTableTimeDelay amount of time has expired)
; We must keep calling this function to in a loop to be sure that the table ultimately gets closed
; this function also cleans up the list
TableCloseFromListDelayed()
{
   global
   local WinId, ListLength, StartTime, TableName


   ; if we are suspended, then just return
   if (NOT AllHotKeysEnabled)
      return
      
   Critical, On
      
   ; if we don't have any tables to close, then return
   if NOT (ListLength := ListLength(TableCloseIdList))
      return
      
;outputdebug, in close delayed     TableCloseIdList:%TableCloseIdList%
   ; loop thru the list from the last to first and see if we need to close any of these tables yet
   loop, %ListLength%
   {

      WinId := ListGetItem(TableCloseIdList,ListLength - A_Index + 1)

;outputdebug, here0    WinId:%WinId%
      ; if the table no longer exists, then remove it from the list
      ifWinNotExist, ahk_id%WinId%
      {
         ListDelPos(TableCloseIdList,ListLength - A_Index + 1)
         ; remove the time from it's list too
         ListDelPos(TableCloseTimeList,ListLength - A_Index + 1)
         continue
      }

;outputdebug, here1

      StartTime := ListGetItem(TableCloseTimeList,ListLength - A_Index + 1)
      
      ; if the current time has exceeded the delay time, then close this table
      if (   ((A_TickCount - StartTime) / 1000) > CloseTableTimeDelay  )
      {
;outputdebug, here2
         ; close the Table if the hero is not seated (extra safety check)
         if NOT (HeroSeated(WinId) == 1)
         {
         
            ; get the tournament number for this tournament, so we can close the lobby if it pops up afterwards
            TableName := TableNameOrNumber(WinId)
         
            ; close the table
            ;PostMessage, 0x10, 0, 0,, ahk_id %WinId%           ; this causes FT to crash
            PostMessage, 0x112, 0xF060,,,ahk_id%WinId%
            
            ; if enabled, and if the lobby pops up after we close the table, then just close it too
            if AutoCloseTournamentLobbyEnabled
            {
               WinWait, %TableName% ahk_group TournamentLobby,,1
               if NOT ErrorLevel
                  PostMessage, 0x112, 0xF060,,,%TableName% ahk_group TournamentLobby
                  ;PostMessage, 0x10, 0, 0,, %TableName% ahk_group TournamentLobby           ; this causes FT to crash
            }
         }

         ListDelPos(TableCloseIdList,ListLength - A_Index + 1)
         ; remove the time from it's list too
         ListDelPos(TableCloseTimeList,ListLength - A_Index + 1)
         continue
      }
   }


   Critical, Off

}


; this looks in the stars log file to see if we need to finish an stars sng tables
TableCloseFinishedStarsSngTables()
{

	global
	local FileSize,WinId, FileName, FileContents
	
	static LastFileSize := 0
	


   FileName := PSSettingsFolder . "\PokerStars.log.0"

	IfNotExist, %FileName%
      return

	FileGetSize FileSize, %FileName%
	
;outputdebug, in finshed stars1    FileName:%FileName%
	; if the log file is still the same size, then return
	If (LastFileSize == FileSize)
		Return
;outputdebug, in finshed stars2    FileSize:%FileSize%   LastFileSize:%LastFileSize%
	LastFileSize := FileSize

	FileContents := FileTail(500, FileName)
	;The string we're looking for looks something like this
	;MSG_TABLE_SIT_KICK 00010FE0 'You finished the tournament in 7th place,
	;We check each each of the lines we pulled from the file above
	
	; check if the kick message is in our sample of the log file, if not return
	
	if NOT instr(FileContents,SngKickMessage)
      return
	

	Loop, Parse, FileContents, `n, `r
   {

   	If (InStr(A_LoopField, SngKickMessage))			;If we find the kick message a tourney has ended
      {
         WinId := SubStr(A_LoopField, 19, 9)		;Parse out the handle of the window so we can Close it
         WinId := "0x" . WinId						;Put it in autoHotkey format 0x000F1939
         StringReplace, WinId, WinId, %A_Space%,,
;outputdebug, in finshed stars... found WinID:%WinId%
         ; add the table to close ID to the list, IF it isn't on there already, AND the table still exists
         ifWinExist, ahk_id%WinId%
         {
;outputdebug, in finished stars, here1

      	  ; if this is a ring game, then just continue... we don't close ring game tables
	        if TableRingOrTournament(WinId)
               continue


            if NOT instr(TableCloseIdList,WinId)
            {
               Critical, On
               ListAddItem(TableCloseIdList,WinId)
               ListAddItem(TableCloseTimeList,A_TickCount)
               Critical, Off
outputdebug, in finished stars --   adding table to list     TableCloseIdList:%TableCloseIdList%      WinId:%WinId%
            }
         }
      }
   }
}


; check if this is a Fast type Ring Game - only applies to STARS
; return 1 if it is
; else return 0
; return "" if not known
TableFast(WinId)
{
   global
   local TableName, CasinoName

   if (TableFast%WinId% <> "")
      return TableFast%WinId%

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""
      
      
   if (CasinoName == "PS")
   {
      if NOT (TableName := TableNameOrNumber(WinId))
         return ""

      ; see if " fast" is at the end of the TableName
      If (InStr(TableName, " fast") == strlen(TableName) - 4)
         return (TableFast%WinId% := 1)
      else
         return (TableFast%WinId% := 0)
   }
   ; if not PS table
   else
      return (TableFast%WinId% := 0)
}


; Needs to be changed for new Casinos when they are added *****************
; reads the title bar to see if this table is a heads up ring game table
; returns 1 if it is, 0 otherwise
; returns ""  if not known
TableHeadsUp(WinId)
{
   global
   local WinTitle

   if (TableHeadsUp%WinId% <> "")
      return TableHeadsUp%WinId%
      
      
   ; read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%

   if NOT WinTitle
      return ""

   ; check if this is a HU game
   If (InStr(WinTitle, "(heads up)") OR InStr(vWinTitle, "(deep hu)") OR InStr(WinTitle," - 1 on 1") )
      return (TableHeadsUp%WinId% := 1)
   else
      return (TableHeadsUp%WinId% := 0)
}




; return the table id under the mouse... if the window under the mouse is not
;     a full tilt table, then just return (0)
;     returns the winID of the table,
TableIdUnderMouse()
{

   ; local WinId

   ; get the id of the window the mouse is over
   MouseGetPos, , , WinId

   ; if mouse is over a Full table
   IfWinExist, ahk_id%WinId% ahk_group Tables
      return WinId
   ; else return 0, cuz the mouse is not over a FT table
   else
      return 0
}


; click the refresh button if the Info tab button is visible
TableInfoRefresh(WinId)
{
   if (ButtonColorVisible("ButtonInfo",WinId) == 1)
      ButtonClick("ButtonRefresh",WinId)
}



TableIsMouseInChat()
{
   global
   local ControlName, CasinoName, X, Y, MouseId, ClientScaleFactor
   

   
   IfWinActive, ahk_group Tables
   {
      CoordMode, Mouse, Screen
      MouseGetPos,X,Y,MouseId,ControlName

      ; check if the mouse is over a table
      ifWinNotExist, ahk_id%MouseId% ahk_group Tables
         return 0    
         
      if NOT (CasinoName := CasinoName(MouseId,A_ThisFunc))
         return 0          
          
                
      ; check if this table has a control name for the mouse area
      if (%CasinoName%BoxChatEditControlName)
      {
         if ((ControlName == PSBoxChatEditControlName)  OR   (ControlName == PSBoxChatListControlName)  OR   (ControlName == PSBoxNoteListControlName)  OR   (ControlName == PSBoxNotePlayersNameControlName))
            Return 1
      }
      ; else this table must not have control names... check if the mouse is in the chat area
      else
      {
     
         X1 := %CasinoName%EditChatBoxX
         Y1 := %CasinoName%EditChatBoxY
         X2 := X1 + %CasinoName%EditChatBoxW
         Y2 := Y1 + %CasinoName%EditChatBoxH 
         
         WindowScaledPos(X1, Y1, ClientScaleFactor, "Screen", MouseId)         
         WindowScaledPos(X2, Y2, ClientScaleFactor, "Screen", MouseId)
         
;outputdebug, mouseinchat X:%X%   Y:%Y%   X1:%X1%   Y1:%Y1%   X2:%X2%   Y2:%Y2%          
         ; check if mouse is in the chat area  
         if ( (X>=X1) AND (Y>=Y1) AND (X<=X2) AND (Y<=Y2) )     
            return 1
      }   
   }
   Return 0

}

; -----------------------------------------------------------------------------------------

; uses the gui info ManualMoveTablePosX,  ManualMoveTablePosY,  ManualMoveTableWidth to position a table to a new location
TableManualMove(WinId="")
{
   global
   local TX, TY, CasinoName,TableWDivHFactor
   local ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder
   local ManualMoveTableHeight ; we calcuate this below

   static MoveTableId := 0
   static MoveTableOrigPosX := 0
   static MoveTableOrigPosY := 0
   static MoveTableOrigWidth := 0
   static MoveTableOrigHeight := 0

;outputdebug, in tablemanualmove   WinId:%WinId%    MoveTableId:%MoveTableId%




   ; if a table is already in the moved table position, and that table exists, then move it back to where it came from

   if (MoveTableId AND WinExist("ahk_id " . MoveTableId))
   {

         WinHide, ahk_id%MoveTableId%
      	DetectHiddenWindows, on ; brad
         WinMove, ahk_id%MoveTableId%,,MoveTableOrigPosX,MoveTableOrigPosY,MoveTableOrigWidth,MoveTableOrigHeight
         WinShow, ahk_id%MoveTableId%
         
         Sleep, -1
         ; this magic command re-paints Poker Stars tables so that they are resized correctly
         ControlSend, , {F5}, ahk_id%MoveTableId%
         


         if NOT (CasinoName := CasinoName(MoveTableId,A_ThisFunc))
            return

         ; move the mouse
         TX := %CasinoName%MouseHomePosX
         TY := %CasinoName%MouseHomePosY

         WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",MoveTableId)
         CoordMode, Mouse, Screen
         if (! KeyPressedInList(KeyListToDisableShortcuts))
            MouseMove,TX,Ty,0

         ; turn off the displays from the moved table, and turn them on in the original position
         DisplayOSD3(MoveTableId)
         DisplayOSD4(MoveTableId)

         ; turn off the highlighter so that we can move it to the new position
         HighlighterOn(0,0,0,0)

         ; remove this table from the list
         ListDelItem(MovedTableIdList,MoveTableId)

         ;reset this id so that we know that no table is in moved position
         MoveTableId := 0
   }

   ; else move the specified table or active table to the movetableposX Y
   else
   {

      ; if a WinId was not specified, use the Table under the mouse
      if ! WinId
      {
         WinId := TableActivateUnderMouse()
         if ! WinId
            return
      }
      
      ; if this table has already been moved, then return
      if ListGetPos(MovedTableIdList,WinId)
         return

      if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
         return

      ; get and save the table info for when we return the table, and get border information about out tables for calculation below
      WindowInfo(MoveTableOrigPosX, MoveTableOrigPosY, MoveTableOrigWidth, MoveTableOrigHeight, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)

      ; calculate the height of this moved table, given the constants for our table
      TableWDivHFactor := %CasinoName%StandardClientWidth / %CasinoName%StandardClientHeight
      ManualMoveTableHeight := ((ManualMoveTableWidth - 2 * WindowSideBorder) / TableWDivHFactor) + WindowTopBorder + WindowBottomBorder


      WinHide, ahk_id%WinId%
      DetectHiddenWindows, on ; brad
      WinMove,ahk_id%WinId%,,ManualMoveTablePosX,ManualMoveTablePosY,ManualMoveTableWidth,ManualMoveTableHeight
      WinShow, ahk_id%WinId%
      
      Sleep, -1
      ; this command re-paints Poker Stars tables so that they are resized correctly
      ControlSend, , {F5}, ahk_id%WinId%
      


      MoveTableId := WinId

      ; add this table to the list of moved tables
      ListAddItem(MovedTableIdList,MoveTableId)

      WinActivate, ahk_id%WinId%

      ; move the mouse to this table
      TX := %CasinoName%MouseHomePosX
      TY := %CasinoName%MouseHomePosY

      WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
      CoordMode, Mouse, Screen
      if (! KeyPressedInList(KeyListToDisableShortcuts))
         MouseMove,TX,Ty,0

      ; since this table is active, turn off the highlighter so that we can move it to the new position
      HighlighterOn(0,0,0,0)

   }

}
; -----------------------------------------------------------------------------------------

; uses the gui info ManualMoveTablePosX,  ManualMoveTablePosY,  ManualMoveTableWidth to position a table to a new location
Table2ManualMove(WinId="")
{
   global               ; MovedTableIdList
   local TX, TY, CasinoName,TableWDivHFactor
   local ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder
   local ManualMoveTableHeight ; we calcuate this below
   
   static MoveTableId := 0
   static MoveTableOrigPosX := 0
   static MoveTableOrigPosY := 0
   static MoveTableOrigWidth := 0
   static MoveTableOrigHeight := 0
   
;outputdebug, in tablemanualmove 2   WinId:%WinId%    MoveTableId:%MoveTableId%
      

      
      
   ; if a table is already in the moved table position, and that table exists, then move it back to where it came from
   
   if (MoveTableId AND WinExist("ahk_id " . MoveTableId))
   {

         WinHide, ahk_id%MoveTableId%
      	DetectHiddenWindows, on ; brad
         WinMove, ahk_id%MoveTableId%,,MoveTableOrigPosX,MoveTableOrigPosY,MoveTableOrigWidth,MoveTableOrigHeight
         WinShow, ahk_id%MoveTableId%
         
         Sleep, -1
         ; this magic command re-paints Poker Stars tables so that they are resized correctly
         ControlSend, , {F5}, ahk_id%MoveTableId%
         


         if NOT (CasinoName := CasinoName(MoveTableId,A_ThisFunc))
            return

         ; move the mouse
         TX := %CasinoName%MouseHomePosX
         TY := %CasinoName%MouseHomePosY

         WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",MoveTableId)
         CoordMode, Mouse, Screen
         if (! KeyPressedInList(KeyListToDisableShortcuts))
            MouseMove,TX,Ty,0

         ; turn off the displays from the moved table, and turn them on in the original position
         DisplayOSD3(MoveTableId)
         DisplayOSD4(MoveTableId)
         
         ; turn off the highlighter so that we can move it to the new position
         HighlighterOn(0,0,0,0)

         ; remove this table from the list
         ListDelItem(MovedTableIdList,MoveTableId)
         
         ;reset this id so that we know that no table is in moved position
         MoveTableId := 0
         

   }
   
   ; else move the specified table or active table to the movetableposX Y
   else
   {
   
      ; if a WinId was not specified, use the Table under the mouse
      if ! WinId
      {
         WinId := TableActivateUnderMouse()
         if ! WinId
            return
      }
      
      ; if this table has already been moved, then return
      if ListGetPos(MovedTableIdList,WinId)
         return
         
      if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
         return

      ; get and save the table info for when we return the table, and get border information about out tables for calculation below
      WindowInfo(MoveTableOrigPosX, MoveTableOrigPosY, MoveTableOrigWidth, MoveTableOrigHeight, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)
      
      ; calculate the height of this moved table, given the constants for our table
      TableWDivHFactor := %CasinoName%StandardClientWidth / %CasinoName%StandardClientHeight
      ManualMoveTableHeight := ((ManualMoveTable2Width - 2 * WindowSideBorder) / TableWDivHFactor) + WindowTopBorder + WindowBottomBorder


      WinHide, ahk_id%WinId%
      DetectHiddenWindows, on ; brad
      WinMove,ahk_id%WinId%,,ManualMoveTable2PosX,ManualMoveTable2PosY,ManualMoveTable2Width,ManualMoveTableHeight
      WinShow, ahk_id%WinId%
      
      Sleep, -1
      ; this magic command re-paints Poker Stars tables so that they are resized correctly
      ControlSend, , {F5}, ahk_id%WinId%
      


      MoveTableId := WinId
      
      ; add this table to the list of moved tables
      ListAddItem(MovedTableIdList,MoveTableId)

      WinActivate, ahk_id%WinId%

      ; move the mouse to this table
      TX := %CasinoName%MouseHomePosX
      TY := %CasinoName%MouseHomePosY

      WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
      CoordMode, Mouse, Screen
      if (! KeyPressedInList(KeyListToDisableShortcuts))
         MouseMove,TX,Ty,0
         
      ; since this table is active, turn off the highlighter so that we can move it to the new position
      HighlighterOn(0,0,0,0)

   }

}

; -----------------------------------------------------------------------------------------



; minimize tables for WinId...
;  if WinId == 0, then minimize all tables
TableMinimize(WinId)
{
   ; local WinIdList,Flag


   if WinId
      PostMessage, 0x112, 0xF020,,, ahk_id%WinId%
   else
   ; if WinId == 0, then we'll minimize all the open tournament lobbies
   ;     EXCEPT if the Register or Unregister button is visible
   {
      WinGet, WinIdList, List, ahk_group Tables
      ; loop through all of the open tables
      Loop, %WinIdList%
      {
         ; find the next ID of the next open table


         WinId := WinIdList%A_Index%
         ; minimize this table
         PostMessage, 0x112, 0xF020,,,ahk_id%WinId%
      }
   }
}


; -----------------------------------------------------------------------------------------



; minimize tables if the hero is not seated at the table for WinId...
;  if WinId == 0, then close all tables
TableMinimizeWithoutHero(WinId)
{
   ; local WinIdList, Flag


   if WinId
   {
      if (HeroSeated(WinId) == 0)
         PostMessage, 0x112, 0xF020,,, ahk_id%WinId%
   }
   else
   ; if WinId == 0, then we'll close all the open tournament lobbies
   ;     EXCEPT if the Register or Unregister button is visible
   {
      WinGet, WinIdList, List, ahk_group Tables
      ; loop through all of the open tables
      Loop, %WinIdList%
      {
         ; find the next ID of the next open table


         WinId := WinIdList%A_Index%
         ; minimize this table if the hero is not seated
         if (HeroSeated(WinId) == 0)
            PostMessage, 0x112, 0xF020,,,ahk_id%WinId%
      }
   }
}



; move the mouse in and out of the chat area, if the mouse is over a FT table
TableMoveToFromChat(WinId="")
{
   global
   local vTX, vTY, CasinoName, ClientScaleFactor


   ; if a WinId was not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   ; if mouse is in chat area, move to it's home position
   if TableIsMouseInChat()
   {
      vTX := %CasinoName%MouseHomePosX
      vTY := %CasinoName%MouseHomePosY
      WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", WinId)
      CoordMode, Mouse, Screen
      MouseMove, vTX, vTY,0
   }
   ; else if mouse is not in chat area, then move it to the chat area
   else
   {
      ; erase the tooltip
      Tooltip,,,,8
   
      vTX := %CasinoName%EditChatBoxX + 40
      vTY := %CasinoName%EditChatBoxY + 40
      WindowScaledPos(vTX, vTY, ClientScaleFactor, "Screen", WinId)
      CoordMode, Mouse, Screen
      MouseMove, vTX, vTY ,0
      ; set the mouse to have focus in the ChatEdit box
      ControlFocus, %CasinoName%%BoxChatEditControlName%,ahk_id%WinId%
   }
}


; cleanup the TableOpenIdList    located in FunctionsTable.ahk
TableOpenIdListCleanup()
{

   global
   local WinId, ListLength

   Critical, On

   ; if we don't have any tables to close, then return
   if NOT (ListLength := ListLength(TableOpenIdList))
      return


   ; loop thru the list from the last to first and see if we need to close any of these tables yet
   loop, %ListLength%
   {

      WinId := ListGetItem(TableOpenIdList,ListLength - A_Index + 1)


      ; if the table no longer exists, then remove it from the list
      ifWinNotExist, ahk_id%WinId%
      {
         ListDelPos(TableOpenIdList,ListLength - A_Index + 1)
         
         
         ; delete all the global variables associated with this table
         LastHandHistory%WinId% =
         LastHandHistoryFilePath%WinId% =
         LastHandHistoryFileSize%WinId% =
         LastHandHistoryHeroTimedOut%WinId% =
         LastHandHistoryStandsUp%WinId% =
         LastHandHistoryFilePathUpdateTime%WinId% =

         if Osd3GuiNum%WinId%
            DisplayOsd3Off(WinId)                        ; critical must be on for this
         Osd3GuiNum%WinId% =
         Osd3LastPosX%WinId% =
         Osd3LastPosY%WinId% =
         Osd3LastTheme%WinId% =
         Osd3LastText%WinId% =
         Osd3LastStack%WinId% =

         if Osd4GuiNum%WinId%
            DisplayOsd4Off(WinId)                        ; critical must be on for this
         Osd4GuiNum%WinId% =
         Osd4LastPosX%WinId% =
         Osd4LastPosY%WinId% =
         Osd4LastTheme%WinId% =
         Osd4LastText%WinId% =
         Osd4LastStack%WinId% =
         


         CasinoName%WinId% =
         TableRingOrTournament%WinId% =
         HeroName%WinId% =
         TableSeats%WinId% =
         TableNameOrNumber%WinId% =
         TableType%WinId% =
         TableFast%WinId% =
         TableHeadsUp%WinId% =
         BigBlind%WinId% =
         SmallBlind%WinId% =
         Ante%WinId% =

         DealMeModeState%WinId% =
         InfoRefreshTime%WinId% =

      }
   }
   
   ; Critical, Off

}


; NEW VERSION in 4.0014
;      this version tries to use the top table that the poker site pops to the top, rather than using the oldest table from the pending list.
;      this prevents the flickering where they pop a table to the top, and then we re-pop with our oldest table from the pending list


; move to the top pending action table in the list
;    if the currently active table is 1st on the list, then move it to the bottom of the list
; return 1 if we activate a new table, else return 0
; if HotKeyFlag == 1, then we called this function from the "Activate next table with pending action" hotkey,
;     in that case we need to jump to the 2nd table in the pending list IF the 1st table in the pending list is already active
TablePending(HotKeyFlag=0)
{
   global
   local CasinoName, WinId, NextTableId, Position, TX, TY
   local FoldButtonFlag, Temp, ClientScaleFactor
;   local TableIdArray                                         ; this needs to be a global var to get the array elements to work correctly

;outputdebug, in Table pending

   WinId := WinActive("A")

   ; get the number of pending tables
   Position := ListLength(TableIDPendingList)

   ; if there are no pending tables, then return
   if (!Position)
      return 0

;outputdebug, in Table pending  Position=%Position%
   ; get the first pending table ID
   NextTableId := ListGetItem(TableIDPendingList,1)



   ; if there is only one table in the list, then we'll want to go to this table
   if (Position == 1)
   {
      ; then our NextTableId is already set above
      ; now fall thru to the bottom of these if/elses
;outputdebug, only one table pending... activating it
   }
   ; else
   ; CHECK if we want to go to the 2nd table in the list...  i.e. the user pressed a hotkey to go to nexp pending table
   ; if the first table in the list is the current ACTIVE table,
   ;    AND there are more than 1 tables on the list
   ;     AND we were called this function from the "Activate next table with pending action" hotkey (HotKeyFlag == 1)
   ;        Then move the current table to the bottom of the list
   ;           and get the table id of the next table in the list
   else if ((NextTableId == WinId) AND (Position > 1) AND HotKeyFlag)
   {


      ; remove the 1st pending table, and add it to the end of the list
      ListDelPos(TableIDPendingList,1)
      ListAddItem(TableIDPendingList,NextTableId)
      ; get the time for this first table, and move it to the bottom of it's list too
      Temp := ListGetPos(TableIDPendingTimeList,1)
      ListDelPos(TableIDPendingTimeList,1)
      ListAddItem(TableIDPendingTimeList,Temp)

      ; get the first table NOW still in the list
      NextTableId := ListGetItem(TableIDPendingList,1)

;outputdebug, HotKeyFlag=%HotKeyFlag%    PendingListLength=%Position%    NextTableId=%NextTableId%
   }
   ; else check if we should go to the table that the casino popped to the top.
   ;    we get the casino name for the next pending table on our list.
   ;     then we find out what table is at the top of the stack for that casino.
   ;     If that top table has pending action on it, we jump to that table
   ;     instead of the top table in our pending list. This prevents flicker if
   ;     the casino's table is different than our table... so we use their pending table list.
   else
   {
      ; get the casino name for the next pending table on our list.
      if NOT (CasinoName := CasinoName(NextTableId,A_ThisFunc))
         return 0
;outputdebug, next table in list is a Casino: %CasinoName%
      ; so we want to activate a table of this casino:  CasinoName
      ; get the top table for this casino, since the casino should have popped a table to the top.

      ; get a list of the this casino's tables that are open
      WinGet, TableIdArray, List, ahk_group %CasinoName%Tables

      ; check if action is pending on this top table of this casino
      ;     if so, then set the next table that we should go to to be this table that is on top of the stack.
      if (TablePendingAction(TableIdArray1))
      {
         NextTableId := TableIdArray1
;TableName := TableNameOrNumber(TableIdArray1)
;outputdebug, activating top table for this casino is %TableName%
      }


   }

   ; if this table still has pending action on it, then activate it

   ; check if the fold button OR  betting box  OR  pixel of pending action button   is visible on this table
   FoldButtonFlag := TablePendingAction(NextTableId)

   ; if the ImBackButton is visible
   ;ImBackButtonFlag := ButtonVisible("ButtonImBack", NextTableId)               ;  need == 1   ??????????

   ; find out whether this is a ring or tournament table (needed below in the auto preset bet check below)
;   RingOrTournament := TableRingOrTournament(NextTableId)

   ; check if the bet slider is visible - this is checked in FoldButtonFlag above !!!!!!!!!
   ;BoxBetEditFlag := ControlVisible("BoxBetEdit",WinId)

;outputdebug, in tablepending 3   FoldButtonFlag:%FoldButtonFlag%   ImBackButtonFlag:%ImBackButtonFlag%   RingOrTournament:%RingOrTournament%   
      
   ; activate this table IF pending action
   if (FoldButtonFlag)
   {
      ; activate this table
      WinActivate, ahk_id%NextTableId%

      if MouseToHomeEnabled
      {
;outputdebug, in table pending... moving mouse to home
         ; move the mouse to next to the mouse home position(if a mouse button is not being held down)
         if NOT (CasinoName := CasinoName(NextTableId,A_ThisFunc))
            return 0

         ; move the mouse to next to the betting box
         TX := %CasinoName%MouseHomePosX
         TY := %CasinoName%MouseHomePosY
         
         WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",NextTableId)
         CoordMode, Mouse, Screen
; this is checked for in TimerFast()
;         if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P"))
         MouseMove,TX,TY,0
      }
      return 1

   }
   
   
/*     removed this in ver 4.0014 because we may not be dealing with the first table in the list (since we might be activating the topmost table)
   
   ; else remove the table from the list, since there is no pending action
   else
   {
      ListDelPos(TableIDPendingList,1)
      ListDelPos(TableIDPendingTimeList,1)
   }

*/


   return 0



}




; ------------------------------------------------------------------------------------------------

; OLD VERSION BEFORE 4.0014

/*

; move to the top pending action table in the list
;    if the currently active table is 1st on the list, then move it to the bottom of the list
; return 1 if we activate a new table, else return 0
; if HotKeyFlag == 1, then we called this function from the "Activate next table with pending action" hotkey,
;     in that case we need to jump to the 2nd table in the pending list IF the 1st table in the pending list is already active
TablePending(HotKeyFlag=0)
{
   global
   local CasinoName, WinId, NextTableId, Position, TX, TY
   local FoldButtonFlag, Temp, ClientScaleFactor

;outputdebug, in Table pending

   WinId := WinActive("A")

   ; a FT table must already be active to get here.
   ; move to the next table with pending action
   ; If the TOP table in the pending list is the one that we are at, then remove
   ;     the current table, as the user must want to go to the next.
   ;     The TimerMedium() function will add the table to the bottom of the list again, if it is still pending action



   ; get the number of pending tables
   Position := ListLength(TableIDPendingList)



   ; if there are no pending tables, then return
   if (!Position)
      return 0

;outputdebug, in Table pending  Position=%Position%
   ; get the first pending table ID
   NextTableId := ListGetItem(TableIDPendingList,1)




;outputdebug, in Table pending 2




   ; if the first table in the list is the current ACTIVE table,
   ;    AND there are more than 1 tables on the list
   ;     AND we were called this function from the "Activate next table with pending action" hotkey (HotKeyFlag == 1)
   ;        Then move the current table to the bottom of the list
   ;           and get the table id of the next table in the list
   if ((NextTableId == WinId) AND (Position > 1) AND HotKeyFlag)
   {


      ; remove the 1st pending table, and add it to the end of the list
      ListDelPos(TableIDPendingList,1)
      ListAddItem(TableIDPendingList,NextTableId)
      ; get the time for this first table, and move it to the bottom of it's list too
      Temp := ListGetPos(TableIDPendingTimeList,1)
      ListDelPos(TableIDPendingTimeList,1)
      ListAddItem(TableIDPendingTimeList,Temp)

      ; get the first table NOW still in the list
      NextTableId := ListGetItem(TableIDPendingList,1)

;outputdebug, HotKeyFlag=%HotKeyFlag%    PendingListLength=%Position%    NextTableId=%NextTableId%
   }




   ; if this table still has pending action on it, then activate it
   ; if NO pending action, then delete it from the list

   ; check if the fold button OR  betting box  OR  pixel of pending action button   is visible on this table
   FoldButtonFlag := TablePendingAction(NextTableId)

   ; if the ImBackButton is visible
   ;ImBackButtonFlag := ButtonVisible("ButtonImBack", NextTableId)    ; need == 1 ??????????

   ; find out whether this is a ring or tournament table (needed below in the auto preset bet check below)
;   RingOrTournament := TableRingOrTournament(NextTableId)

   ; check if the bet slider is visible - this is checked in FoldButtonFlag above !!!!!!!!!
   ;BoxBetEditFlag := ControlVisible("BoxBetEdit",WinId)

;outputdebug, in tablepending 3   FoldButtonFlag:%FoldButtonFlag%   ImBackButtonFlag:%ImBackButtonFlag%   RingOrTournament:%RingOrTournament%

   ; activate this table IF pending action
   if (FoldButtonFlag)
   {
      ; activate this table
      WinActivate, ahk_id%NextTableId%

      if MouseToHomeEnabled
      {
;outputdebug, in table pending... moving mouse to home
         ; move the mouse to next to the mouse home position(if a mouse button is not being held down)
         if NOT (CasinoName := CasinoName(NextTableId,A_ThisFunc))
            return

         ; move the mouse to next to the betting box
         TX := %CasinoName%MouseHomePosX
         TY := %CasinoName%MouseHomePosY

         WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",NextTableId)
         CoordMode, Mouse, Screen
; this is checked for in TimerFast()
;         if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P"))
         MouseMove,TX,TY,0
      }
      return 1

   }
   ; else remove the table from the list, since there is no pending action
   else
   {
      ListDelPos(TableIDPendingList,1)
      ListDelPos(TableIDPendingTimeList,1)
   }

   return 0



}

*/


; ------------------------------------------------------------------------------------------------

/*
TablePendingAction()
   Purpose: Returns 1 if table has pending action, else returns 0.
            This function checks:
               Betting box visible
               ButtonActionPending button Control visible (which is usually the Fold button control visible)
               ButtonActionPending color visible (usually the Raise button lower right hand corner visible)

   Requires:
            some casinos require that the table be visible
   Returns:
      1 if action is pending visible
      0 if action is not pending or we couldn't detect it (maybe overlayed tables)

   Parameters:
      WinId: window id
*/
TablePendingAction(WinId)
{
   global
   local CasinoName, ButtonControlName, Flag, X,Y,ColorTolerance,ClientScaleFactor,Delta
   local Color, BettingBoxVisibleFlag

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0

   ; check if the betting box is visible
   BettingBoxVisibleFlag := ControlVisible("BoxBetEdit",WinId)

   ; get the control name of the button that we use for detecting pending action
   ButtonControlName := %CasinoName%ButtonActionPendingControlName
   
   ; get the alternate control name of the button that we use for detecting pending action
   ButtonControlName2 := %CasinoName%ButtonActionPending2ControlName   
   
   
;outputdebug, in button visible  ButtonControlName=%ButtonControlName%

   ; if the betting box is visible, then we have pending action
   if BettingBoxVisibleFlag 
      return 1
   ; if the button control name exists, then read it's visibility
   else if ButtonControlName
   {
      ControlGet, Flag, Visible, , %ButtonControlName%, ahk_id%WinId%
      return Flag
   }
   ; if the alternate button control name exists, then read it's visibility
   else if ButtonControlName2
   {
      ControlGet, Flag, Visible, , %ButtonControlName2%, ahk_id%WinId%
      return Flag
   }   
   ; else we have to use pixel recognition to see if a button is visible
   else
   {

      ; get the particulars for the checkbox
      X := %CasinoName%ButtonActionPendingX
      Y := %CasinoName%ButtonActionPendingY

      ; if a value is not specified for this pixel check, then just return
      if NOT X
         return 0

      ColorTolerance := %CasinoName%ButtonActionPendingColorTolerance


;outputdebug, in button visible  ButtonControlName=%ButtonControlName%    X:%X%   Y:%Y%   ColorTol:%ColorTolerance%


      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)


      ; if this window is not the top  window and this XY position, then return 0
      ; this checks to make sure that WinId is on the top of the stack at position X,Y
      if WIndowIsOverlayedAtXY(X,Y,WinId)
         return 0


      ; look for check mark in +- 3 pixel area, but scale the size based on our current table size
      Delta := Round(3 * ClientScaleFactor)

;Outputdebug, check1   x=%X%  y=%Y%   cc=%CheckColor%   bc=%BackColor%   cn=%CasinoName%   cbn=%CheckboxName%  id=%WinId%  errorlevel=%Errorlevel%    color=%CheckColor%

      ; search for the color, return 1 if check is found
      CoordMode,Pixel,Screen

      ; try the 4 possible button colors
      loop, 4
      {

         Color := %CasinoName%ButtonActionPendingColor%A_index%

         ; if the color is not defined, then continue
         if NOT Color
            continue

         ; if there is a color value, check to see if it is present
         if Color
         {
            PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, Color ,ColorTolerance, Fast RGB
            If NOT Errorlevel
            {
;outputdebug, Found stars quick button color:%a_index%
               return 1
            }
         }
      }
      
      
      ; else check the alternate pending color button
      ; get the particulars for the button
      X := %CasinoName%ButtonActionPending2X
      Y := %CasinoName%ButtonActionPending2Y

      ; if a value is not specified for this pixel check, then just return
      if NOT X
         return 0

      ColorTolerance := %CasinoName%ButtonActionPending2ColorTolerance


;outputdebug, in button visible  ButtonControlName=%ButtonControlName%    X:%X%   Y:%Y%   ColorTol:%ColorTolerance%


      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)


      ; if this window is not the top  window and this XY position, then return 0
      ; this checks to make sure that WinId is on the top of the stack at position X,Y
      if WIndowIsOverlayedAtXY(X,Y,WinId)
         return 0


      ; look for check mark in +- 3 pixel area, but scale the size based on our current table size
      Delta := Round(3 * ClientScaleFactor)

;Outputdebug, check1   x=%X%  y=%Y%   cc=%CheckColor%   bc=%BackColor%   cn=%CasinoName%   cbn=%CheckboxName%  id=%WinId%  errorlevel=%Errorlevel%    color=%CheckColor%

      ; search for the color, return 1 if check is found
      CoordMode,Pixel,Screen

      ; try the 4 possible button colors
      loop, 4
      {

         Color := %CasinoName%ButtonActionPending2Color%A_index%

         ; if the color is not defined, then continue
         if NOT Color
            continue

         ; if there is a color value, check to see if it is present
         if Color
         {
         
            PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, Color ,ColorTolerance, Fast RGB
;Outputdebug, pending button2   x=%X%  y=%Y%   Color=%Color%   cn=%CasinoName%   id=%WinId%  errorlevel=%Errorlevel%   colorTolerance=%ColorTolerance%            
            If NOT Errorlevel
            {
;outputdebug, Found stars quick button color:%a_index%
               return 1
            }
         }
      }

      ; else return 0 as we didn't find the color
      return 0
   }
}




; ------------------------------------------------------------------------------
; remove any pending tables from list, if the tables do not exist

TablePendingRemoveObsolete()
{

   global
   local Num, WinId


      ; work thru the list backwards so that we don't miss any when we remove one

      Num := ListLength(TableIDPendingList)
      Loop, %Num%
      {
         WinId := ListGetItem(TableIDPendingList,Num - A_Index + 1)
         ifWinNotExist, ahk_id%WinId%
         {
            ListDelPos(TableIDPendingList,Num - A_Index + 1)
            ; remove the time from it's list too
            ListDelPos(TableIDPendingTimeList,Num - A_Index + 1)
            
            ListDelPos(TableNamePendingList,Num - A_Index + 1)                         ; ??????????????????????????????????????????  remove after done with debug

         }
      }

}








/*
TablePlayers()
   Purpose: Returns the number of players at this table.
            The software calls the appropriate function for the desired casino
   Requires:
            see requirements for each casino
   Returns:
      number players
      0 if not determined
   Parameters:
      WinId: window id... returns active window id if not passed
*/
TablePlayers(WinId)
{
   ; local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0

   return %CasinoName%TablePlayers(WinId)

}


/*
FTTablePlayers()
   Purpose: Returns the number of players at this table.
   Requires:
   Returns:
      number players
      0 if not determined
   Parameters:
      WinId: window id
*/
FTTablePlayers(WinId)
{
   ; local NumberSeatsFound, NumberPlayersFound

   FTTableSeatsAndPlayers(NumberSeatsFound, NumberPlayersFound, WinId)

   return NumberPlayersFound

}


/*
PSTablePlayers()
   Purpose: Returns the number of players seated at the table.
            It first finds the number of seats, and then it uses image recognition to look for the stack digits colors in the player's boxes to count the players
   Requires:
            The table must be VISIBLE on the screen
            The Hero must be seated (or at least some player in the Hero's position)
   Returns:
      number of players
      0 if not found
   Parameters:
      WinId: window id
*/
PSTablePlayers(WinId)
{
   global

   local TableSeats, TablePlayers, CurrentSeatNum,ClientScaleFactor,Delta,X,Y


   ; we are doing pixel search on the screen
   CoordMode, Pixel, Screen


   TableSeats := TableSeats(WinId)


   TablePlayers := 0


   Loop, % TableSeats
   {
      CurrentSeatNum := A_Index
      ; find the center of this player's box (stack digits section), by adding in the offset to the stack center
      X := PSPlayerBoxSeats%TableSeats%Seat%CurrentSeatNum%X + PSStackCenterOffsetX
      Y := PSPlayerBoxSeats%TableSeats%Seat%CurrentSeatNum%Y + PSStackCenterOffsetY
;outputdebug, %X%  %Y%
      ; convert the x,y position to a screen position
      WindowScaledPos(X, Y, ClientScaleFactor, "Screen",WinId)



      ; if this player's box is overlayed, then don't bother counting it
      if WIndowIsOverlayedAtXY(X,Y,WinId)
      {
;outputdebug, PS table overlayed in seat:%CurrentSeatNum%    X:%X%   Y:%Y%                              ;continue
         continue
      }
      
      ; look for check mark in +- 5 pixel area, but scale the size based on our current table size
      Delta := Round(5 * ClientScaleFactor)
;color := PSStackDigitsColor
;outputdebug, %X%  %Y%  %color%   %Delta%

      ; search for the primary font color...  errorlevel == 0 if it was found
      PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, PSStackDigitsColor ,PSStackDigitsColorTolerance, Fast RGB
      ; if the color was found...
      If NOT Errorlevel
      {
         ; we found a color match
         ++TablePlayers

;outputdebug, match found at %X%  %Y%   seatnum=%CurrentSeatNum%  of  %CurrentNumSeats%

         continue

      }
      ; if the color was not found, try the alt color
      else
      {
         ; search for the alt font color
         PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, PSStackDigitsAlternateColor ,PSStackDigitsAlternateColorTolerance, Fast RGB
         If NOT Errorlevel
         {
            ; we found a color match
;outputdebug, alt match found at %X%  %Y%   seatnum=%CurrentSeatNum%  of  %CurrentNumSeats%
            ++TablePlayers
            continue
         }
      }
   }

   return TablePlayers

}




/*
TablePot()
   Purpose: Returns the size of the pot. It reads first from the primary position and if not found it tries the secondary position
            Image recognition by pixel count is use to read the pot size off the table
   Returns:
      the pot amount
      "" if no value found
   Parameters:

      WinId: window id
*/
TablePot(WinId)
{
   global
   local Pot, DummyByRef, TableSeats
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""


   Pot := DigitSearchByPixelCount(%CasinoName%PotDigitsPosX,%CasinoName%PotDigitsPosY,%CasinoName%PotDigitsPosW,%CasinoName%PotDigitsPosH,"Pot", DummyByRef, WinId)
   
;outputdebug, pot:%Pot%     pixels: %DummyByRef%   
   if (!Pot)
   {
      ; check the sceondary position for the pot digits... these are a function of the number of seats at the table
      TableSeats := TableSeats(WinId)
      ; check if we have a valid X position for this stack digits
      if %CasinoName%PotDigitsPos%TableSeats%X
         Pot := DigitSearchByPixelCount(%CasinoName%PotDigitsPos%TableSeats%X,%CasinoName%PotDigitsPos%TableSeats%Y,%CasinoName%PotDigitsPosW,%CasinoName%PotDigitsPosH,"Pot" ,DummyByRef, WinId)
   }

   ; remove any leading zeros (sometimes on PS, the O in POT is read as a zero)
   if (instr(Pot,"0") == 1)
      StringTrimleft, Pot,Pot,1


   if Pot is number
      return Pot
   else
      return 0

}



/*
TableTableRingOrTournament()
   Purpose: Returns Ring (1) or Tournament(0)     unknown=""
            The software calls the appropriate function for the desired casino
   Requires:
            see requirements for each casino
   Returns:
      1 if ring game
      0 if tournament
      ""  unknown
   Parameters:
      WinId: window id... returns active window id if not passed
   Sets global var
      TableRingOrTournament%WinId
      
   NOTE: sometimes the title for the Poker Stars table is slow to come on...  so we now return "" if the title is still blank
*/
TableRingOrTournament(WinId)
{
   global
   local CasinoName
   
   if (TableRingOrTournament%WinId% <> "")
      return TableRingOrTournament%WinId%

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   return (TableRingOrTournament%WinId% := %CasinoName%TableRingOrTournament(WinId))

}


; returns Ring=1 Tourney=0   unknown=""
FTTableRingOrTournament(WinId)
{
   ; local WinTitle


   ; need to find the amount of the small blind and big blind...   read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%

   if ! WinTitle
      return ""

   If InStr(WinTitle, "Play Money Sit & Go")
      return 0

   If InStr(WinTitle, "Play Chip Tournament")
      return 0

   If InStr(WinTitle, "Play Chip")
      return 1

   ; cash games have "/$" in the title
   If InStr(WinTitle, "/$")
      return 1
   else
      return 0
}


; returns Ring=1 Tourney=0  unknown=""
PSTableRingOrTournament(WinId)
{
   ; local WinTitle

   ; need to find the amount of the small blind and big blind...   read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%

   if ! WinTitle
      return ""
      
   If InStr(WinTitle, "Tournament")
      return 0
   else
      return 1

}


/*
TableSeats()
   Purpose: Returns the number of seats at this table.
            The software calls the appropriate function for the desired casino
   Requires:
            see requirements for each casino
   Returns:
      number seats
      0 if not determined
   Parameters:
      WinId: window id.
*/
TableSeats(WinId)
{
   global
   local CasinoName, TableSeats
   
   ; Changed this operation in version 4.0008.  Sometimes the number of seats that was calculated for pokerstars was wrong... If we
   ; permanently saved in the global variable  TableSeats%WinId%, then we would be stuck with the wrong value for as long as the table
   ; was open.  Unfortunately, TableSeats() is a relatively slow function, but we are going to have to calculate it each time.
   ; But, we will now use the global variable to save the most recent value, and if we go to calculate it again and get 0, then
   ; we will return the previously saved value.
   
   
;   if TableSeats%WinId%
;      return TableSeats%WinId%

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0
      
   TableSeats := %CasinoName%TableSeats(WinId)
   
   ; if we didn't get a good valud of tables seats, then return the previous version, or 0 if there was no previous value
   if ! TableSeats
      TableSeats := IIF(TableSeats%WinId%,TableSeats%WinId%,0)
      
   ; save the value we found in global variable
   TableSeats%WinId% := TableSeats
      
   return TableSeats

}


/*
FTTableSeats()
   Purpose: Returns the number of seats at this table.
   Requires:
   Returns:
      number seats
      0 if not determined
   Parameters:
      WinId: window id.
*/
FTTableSeats(WinId)
{




   WinGetTitle, WinTitle, ahk_id%WinId%

   RingOrTournament := TableRingOrTournament(WinId)


   ; if ring game, we can get the number of seats from the title...  else we have to use the image recog function
   if (RingOrTournament)
   {


      If ( (InStr(WinTitle,"(6 max, deep)"))  OR  (InStr(WinTitle,"(6 max)"))  OR  (InStr(WinTitle,"(6 max, ante, deep)"))  OR   (InStr(WinTitle,"(6 max, edu)"))   )
         return 6
      else If (InStr(WinTitle,"(heads up)") OR InStr(WinTitle,"heads up, deep") )
         return 2
      else If (InStr(WinTitle,"Stud Hi -") OR InStr(WinTitle,"Stud H/L -"))
         return 8
      else If InStr(WinTitle,"Razz -")
         return 8
      else If ( InStr(WinTitle," HORSE - ",1)  OR   InStr(WinTitle," HA - ",1)  OR   InStr(WinTitle," HEROS - ",1)  OR   InStr(WinTitle," HOE - ",1)  OR     InStr(WinTitle," HOSE - ",1)  OR     InStr(WinTitle," OE - ",1)  OR      InStr(WinTitle," SE - ",1)  OR     InStr(WinTitle," HSE - ",1))
         return 8
      else
         return 9

   }
   else
   {
      FTTableSeatsAndPlayers(NumberSeatsFound, NumberPlayersFound, WinId)
   }



   return NumberSeatsFound

}


/*
FTTableSeatsAndPlayers()
   Purpose: Returns the number of seats and players at this table (returned ByRef Parameters).
            The software does image recognition to look for the valid seat position for each possible number of seats at a FT table.
            The color of the player's box is scanned for stack digits background color, alternate stack digits background color, and then empty seat colors.
   Requires:
            The table must be VISIBLE on the screen.
            The empty seat colors must have been calibrated for this table
   Returns:
      1 if a valid number of seats were found
      0 if not determined
   Parameters:
      ByRef NumberSeatsFound
      ByRef NumberPlayersFound
      WinId: window id.
      
On FT Ring game tables, the software is not able to correctly count the number of players. This is because FT puts the text "Join Table" in the player's box
with the same color as the player's name and stack digits. The software sees this color and thinks there is a player seated there.
In tournaments and SnGs, FT does not put any text in there, and hence it is not counted as a player.
Since the number of players is mostly useful for SnGs and tournaments, I have not looked for a solution to this as it doesn't matter much.
It is listed as a limatation.      
      
*/
FTTableSeatsAndPlayers( ByRef NumberSeatsFound, ByRef NumberPlayersFound, WinId)
{
   global
   local CurrentSeatNum, TestNumSeats, Delta, X, Y,



   ; we are doing pixel search on the screen
   CoordMode, Pixel, Screen

   ; check if this window is overlayed in any of the 4 corners
;   if WindowIsOverlayed(WinId)
;   {
;      NumberSeatsFound := 0
;      NumberPlayersFound := 0
;      return 0
;   }

   ; loop for each table size from the list of possible seats
   Loop, % ListLength(FTTableSeatsList)
   {
      ; get the number of seats to test for
      TestNumSeats := ListGetItem(FTTableSeatsList, A_Index)

      ; reset the count of the number seats at this test table
      NumberSeatsFound := 0
      NumberPlayersFound := 0

      ; loop thru all seat positions
      Loop, % TestNumSeats
      {
         CurrentSeatNum := A_Index
;outputdebug, %TestNumSeats%   %CurrentSeatNum%
         ; get the position to check looking for text in the player box (which will allow us to count players)
         X := FTPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%X + FTStackCenterOffsetX
         Y := FTPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%Y + FTStackCenterOffsetY

         ; convert the x,y position to a screen position
         WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

         ; if we find some overlay here, then we won't get an accurate seat count, so continue
         if WIndowIsOverlayedAtXY(X,Y,WinId)
         {
;outputdebug, seat %CurrentSeatNum% not on top   %X%   %Y%
            continue
         }
         ; look for color in +- 3 pixel area, but scale the size based on our current table size
         Delta := Round(5 * ClientScaleFactor)


; get the color under this position
;PixelGetColor, junkocolor, X, Y, RGB
;outputdebug,  seats:%TestNumSeats%  seat#: %CurrentSeatNum%  X:%X%  Y:%Y%   color:= %junkocolor%


         ; search for the primary stack font color...  errorlevel == 0 if it was found
         ; this is the main stack digits color that should be present most of the time if player is seated
         PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FTStackDigitsColor ,FTStackDigitsColorTolerance, Fast RGB
         ; if the color was found...
         If NOT Errorlevel
         {
;outputdebug,  player found with primary color in seat: %CurrentSeatNum%
            ; increment the number of seats found for this trial
            ++NumberSeatsFound
            ++NumberPlayersFound
            continue
         }
         
         
         
         ; if this theme has alternate stack digits color, test for it too
         if FTStackDigitsAlternateColorAvailable
         {

            ; search for the alternate stack digits color...  errorlevel == 0 if it was found
            ; this is the alternate stack digits color that is present when it is the players time to act
            PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FTStackDigitsAlternateColor ,FTStackDigitsAlternateColorTolerance, Fast RGB
            ; if the color was found...
            If NOT Errorlevel
            {
;outputdebug,  player found with alternate color in seat: %CurrentSeatNum%
               ; increment the number of seats found for this trial
               ++NumberSeatsFound
               ++NumberPlayersFound
               continue
            }
         }
         
         
         ; if this theme has PlayerBoxMessageColor colors, test for it too
         ; this is the color of the font for messages like "Fold, Bet, etc" that are normally Blue in color on FT
         if FTPlayerBoxMessageColor
         {

            ; search for the alternate background color...  errorlevel == 0 if it was found
            ; this is the alternate stack digits background color that is present when it is the players time to act
            PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FTPlayerBoxMessageColor ,FTPlayerBoxMessageColorTolerance, Fast RGB
            ; if the color was found...
            If NOT Errorlevel
            {
;outputdebug,  player found with alternate color in seat: %CurrentSeatNum%
               ; increment the number of seats found for this trial
               ++NumberSeatsFound
               ++NumberPlayersFound
               continue
            }
         }         
         

;junkocolor := FTPlayerEmptySeatColorSeats%TestNumSeats%Seat%CurrentSeatNum%
;junkotol := FTPlayerEmptySeatColorTolerance
;outputdebug,  seat#: %CurrentSeatNum%  %X%   %Y%    color:= %junkocolor%   tolerance := %junkotol%


         ; get the position to check for the empty seat
         X := FTPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%X + FTEmptySeatOffsetX
         Y := FTPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%Y + FTEmptySeatOffsetY

         ; convert the x,y position to a screen position
         WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

         ; if we find some overlay here, then we won't get an accurate seat count, so continue
         if WIndowIsOverlayedAtXY(X,Y,WinId)
         {
;outputdebug, seat %CurrentSeatNum% not on top   %X%   %Y%
            continue
         }
         ; look for color in +- 3 pixel area, but scale the size based on our current table size
         Delta := Round(5 * ClientScaleFactor)

         ; search for the empty color...  errorlevel == 0 if it was found
         ; this is the alternate stack digits background color that is present when it is the players time to act
         PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FTPlayerEmptySeatColorSeats%TestNumSeats%Seat%CurrentSeatNum% ,FTPlayerEmptySeatColorTolerance, Fast RGB
         ; if the color was found...
         If NOT Errorlevel
         {

;outputdebug,  empty seat found in seat: %CurrentSeatNum%
            ; increment the number of seats found for this trial
            ++NumberSeatsFound
            continue
         }
      }

      ; if we found the correct number of seats for this trial, then return the number of seats
      if (NumberSeatsFound == TestNumSeats)
      {

;outputdebug, valid !!!   seats:%NumberSeatsFound%    players: %NumberPlayersFound%
        ; we return the number of players and seats found ByRef
         ; return true, since we found a valid contidion
         return  1
      }

   }
;outputdebug, INVALID    seats:%NumberSeatsFound%    players: %NumberPlayersFound%
   ; we did not find a correct number of seats
   NumberSeatsFound := 0
   NumberPlayersFound := 0
   return 0


}

/*
PSTableSeats()
   Purpose: Returns the number of seats at this table.
            The software does image recognition to look for the Hero's stack at a required position on the table. If the hero is found then the position it is found at determines the number of seats at the table.
   Requires:
            The table must be VISIBLE on the screen
            ******   The Hero must be seated (or at least some player in the Hero's position)
   Returns:
      number seats
      0 if not determined
   Parameters:
      WinId: window id... returns active window id if not passed
*/
PSTableSeats(WinId)
{
   global
   local TestNumSeats,CurrentSeatNum,ClientScaleFactor,Delta,X,Y


   ; we are doing pixel search on the screen
   CoordMode, Pixel, Screen

   if Not HeroSeated(WinId)
      return 0

   ; loop for each table size from the list of possible seats
   Loop, % ListLength(PSTableSeatsList)
   {
      ; get the number of seats to test for
      TestNumSeats := ListGetItem(PSTableSeatsList, A_Index)

      ; get the hero's seat position at this table with TestNumSeats seats at it.
      CurrentSeatNum := ListGetItem(PSHeroSeatNumList,A_Index)
;outputdebug, %TestNumSeats%   %CurrentSeatNum%

      ; check the hero's position to see if the hero is present at this table

      X := PSPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%X + PSStackCenterOffsetX
      Y := PSPlayerBoxSeats%TestNumSeats%Seat%CurrentSeatNum%Y + PSStackCenterOffsetY
;outputdebug, %X%  %Y%
      ; convert the x,y position to a screen position
      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

      ; if the window is overlayed where we are trying to check, continue as there might be a HUD at this position
      if WIndowIsOverlayedAtXY(X,Y,WinId)
         continue

      ; look for font color in +- 5 pixel area, but scale the size based on our current table size
      Delta := Round(5 * ClientScaleFactor)

;color := PSStackDigitsColor
;altcolor := PSStackDigitsAlternateColor
;outputdebug, TestNumSeats:%TestNumSeats%   %X%  %Y%    %Delta%     %color%      %altcolor%

      ; search for the primary font color...  errorlevel == 0 if it was found
      PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, PSStackDigitsColor ,PSStackDigitsColorTolerance, Fast RGB
      ; if the color was found...
      If NOT Errorlevel
      {
         ; we found a color match
         return TestNumSeats

      }
      ; if the color was not found, try the alt color
      else
      {
         ; search for the alt font color
         PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, PSStackDigitsAlternateColor ,PSStackDigitsAlternateColorTolerance, Fast RGB
         If NOT Errorlevel
         {
            ; we found a color match
            return TestNumSeats
         }
      }
   }
   return 0
}



/*
TableStreet()
   Purpose: Returns the street of the current table (preflop, flop, turn, river)
   Requires:
            the table must be visible
   Returns:
      table street condition (preflop, flop, turn, river)
      returns "" if the table is not visible
   Parameters:
      WinId: window id.urns active window id if not passed
   Global Variables Updated:
      Street:  text string of the street
*/
TableStreet(WinId)
{
   global
   local ClientScaleFactor, X, Y, FeltColor, Delta
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""

   CoordMode,Pixel,Screen

   ; now look at color behind 1st card of the flop
   X := %CasinoName%FlopX
   Y := %CasinoName%FlopY
   FeltColor := %CasinoName%FlopColor
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
   
   ; make sure the table is visible
   if WIndowIsOverlayedAtXY(X,Y,WinId)
      return ""
   

   ; look for check mark in +- StreetDelta pixel area (scaled by the table size factor)
   Delta := Round(%CasinoName%StreetDelta * ClientScaleFactor)
   
;outputdebug, here0    %X%    %Y%     %FeltColor%    Delta:%Delta%
   
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FeltColor , %CasinoName%StreetColorTolerance, Fast|RGB
   If NOT Errorlevel
   {
      Street := "preflop"
      return "preflop"
   }
;outputdebug, here1
   ; now look at color behind the turn card
   X := %CasinoName%TurnX
   Y := %CasinoName%TurnY
   FeltColor := %CasinoName%TurnColor
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
   ; make sure the table is visible
   if WIndowIsOverlayedAtXY(X,Y,WinId)
      return ""
      
   ; look for check mark in +- StreetDelta pixel area (scaled by the table size factor)
   Delta := Round(%CasinoName%StreetDelta * ClientScaleFactor)
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FeltColor , %CasinoName%StreetColorTolerance, Fast|RGB
   If NOT Errorlevel
   {
      Street := "flop"
      return "flop"
   }

   ; now look at color behind the river card
   X := %CasinoName%RiverX
   Y := %CasinoName%RiverY
   FeltColor := %CasinoName%RiverColor
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
   ; make sure the table is visible
   if WIndowIsOverlayedAtXY(X,Y,WinId)
      return ""
      
   ; look for check mark in +- StreetDelta pixel area (scaled by the table size factor)
   Delta := Round(%CasinoName%StreetDelta * ClientScaleFactor)
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, FeltColor , %CasinoName%StreetColorTolerance, Fast|RGB
   If NOT Errorlevel
   {
      Street := "turn"
      return "turn"
   }
   ;  else we must be on the river
   Street := "river"
   return "river"

}





; -----------------------------------------------------------------------------------------

; reads the title bar of table/tournament lobby, and returns the table name or tournament number
; saves global variable    TableNameOrNumber%WinId%
TableNameOrNumber(WinId="")
{
   global
   local CasinoName

   if TableNameOrNumber%WinId%
      return TableNameOrNumber%WinId%

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return ""
   }

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""
      
   return (TableNameOrNumber%WinId% := %CasinoName%TableNameOrNumber(WinId))


}

FTTableNameOrNumber(WinId)
{

   ; local WinTitle, Pos1, Pos2, TableName

   ; read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%

   TableName := ""
   
   ; check if this is a table
   if WinExist("ahk_id" . WinId . " ahk_group Tables")
   {
      ; if this is a tournament or Sng
      if ( inStr(WinTitle, "Tournament") OR  inStr(WinTitle, "Sit & Go") OR inStr(WinTitle, "Sit&Go") OR inStr(WinTitle, "Madness"))
      {
         ; find the first and last digits of the tournament number... skip past the word Turbo, if it exists
         Pos1 := InStr(WinTitle,"Turbo")
         if Pos1
         {
            Pos1 := InStr(WinTitle,"(",0, Pos1) + 1
            Pos2 := Instr(WinTitle, ")",0, Pos1) - 1
         }
         else
         {
            Pos1 := InStr(WinTitle,"(") + 1
            Pos2 := Instr(WinTitle, ")") - 1
         }

         ; read the contents between the ()
         StringMid, TableName, WinTitle, Pos1, Pos2 - Pos1 + 1
      }
      ; else it is a ring game, return the name of the table
      else
      {
         ; set Criteria1 = table's name
         Pos1 := instr(WinTitle," - ") - 1        ; last position of table name
         StringLeft, TableName, WinTitle, Pos1
      }
   }
   ;else check if it is a tournament lobby
   else if WinExist("ahk_id" . WinId . " ahk_group TournamentLobby")
   {

         ; set TableName = tournament number
         Pos1 := instr(WinTitle,"Tournament ") + 11        ; first position of tournament number
         StringTrimLeft, TableName, WinTitle, Pos1 - 1


   }
   ; else this isn't a valid table or tournament lobby
   else
      Debug(A_ThisFunc,"WinId: " . WinId . " is not a table or tournament lobby")


   Return TableName
   
   
}

PSTableNameOrNumber(WinId)
{
   ; local WinTitle, Pos1, Pos2, TableName

   ; read the title and extract the info
   WinGetTitle, WinTitle, ahk_id%WinId%

   TableName := ""

   ; check if this is a table
   if WinExist("ahk_id" . WinId . " ahk_group Tables")
   {
      ; if this is a tournament or Sng
      if inStr(WinTitle, "Tournament")
      {
         ; get the position of the first digit of the tournament number(after the word "tournament")
         Pos1 := 12
         ; get the position of the last digit of the tournament number (before the word "table")
         Pos2 := Instr(WinTitle, "Table",0, Pos1) - 2

         ; read the contents between the ()
         StringMid, TableName, WinTitle, Pos1, Pos2 - Pos1  + 1
      }
      ; else it is a ring game, return the name of the table
      else
      {
         ; set Criteria1 = table's name
         Pos1 := instr(WinTitle," - ") - 1        ; last position of table name
         StringLeft, TableName, WinTitle, Pos1
      }
   }
   ;else check if it is a tournament lobby
   else if WinExist("ahk_id" . WinId . " ahk_group TournamentLobby")
   {

         ; set TableName = tournament number
         Pos1 := instr(WinTitle,"Tournament ") + 11        ; first position of tournament number
         Pos2 := instr(WinTitle,"Lobby") - 2                ; last position of tournament nummber
         StringMid, TableName, WinTitle, Pos1, Pos2 - Pos1 + 1


   }
   ; else this isn't a valid table or tournament lobby
   else
      Debug(A_ThisFunc,"WinId: " . WinId . " is not a table or tournament lobby")


   Return TableName
   
   
   
   
}


/*
TableType()
   Purpose: Returns the type of this table  (NL, PL, Limit, CAP NL, CAP PL)
            The software calls the appropriate function for the desired casino
   Requires:
            see requirements for each casino
   Returns:
      table type
      "" if not determined
   Parameters:
      WinId: window id.
*/
TableType(WinId)
{
   ; local WinTitle
   
   if TableType%WinId%
      return TableType%WinId%

   WinGetTitle, WinTitle, ahk_id%WinId%
   
   If InStr(WinTitle,"- Limit")
      return (TableType%WinId% := "Limit")
   else If InStr(WinTitle,"Cap No Limit")
      return (TableType%WinId% := "CAP NL")
   else If InStr(WinTitle,"Cap Pot Limit")
      return (TableType%WinId% := "CAP PL")
   else If InStr(WinTitle,"Pot Limit")
      return (TableType%WinId% := "PL")
   else If InStr(WinTitle,"No Limit")
      return (TableType%WinId% := "NL")
   else
      return (TableType%WinId% := "")

}


