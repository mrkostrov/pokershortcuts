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


; display the chat warning message IF
;     a table is active
;     and mouse is not in chat area
;     and chat display enabled
; 


DisplayChatWarning()
{
   global                                       ;ControlsEnabled
   local vPosX, vPosY, CasinoName, ClientScaleFactor


   WinId := WinActive("A")
   IfWinNotActive, ahk_id%WinId%  ahk_group Tables
      return
      
      
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return  


   ; check if the mouse is in chat box
   if  (TableIsMouseInChat())
   {
   
    
      ; erase the tooltip
      Tooltip,,,,8
      ; if the controls are enabled, then we need to disable them while in chat box
      if (ControlsEnabled)
         SettingsUpdateHotkeys(0)
      ; set the mouse to have focus in the ChatEdit box
      ControlFocus, %CasinoName%%BoxChatEditControlName%,ahk_id%WinId%
   }
   ; else the mouse is not in chat
   else
   {
      if ChatWarningEnabled
      {
         vPosX := %CasinoName%EditChatBoxX
         vPosY := %CasinoName%EditChatBoxY
         WindowScaledPos(vPosX, vPosY, ClientScaleFactor, "Screen", WinId)

;outputdebug, %vPosX%   %vPosY%
         CoordMode, Tooltip, Screen
         Tooltip, Move Mouse Below to Chat, vPosX, vPosY, 8
      }
      ; if the controls are not enabled, then we need to enable them, since we
      ;     are out of the chat box
      if (NOT ControlsEnabled)
         SettingsUpdateHotkeys(1)
   }
}



; display OSD that require the pot size to be read
DisplayOsd1(WinId)
{
   global
   ; these local vars do not need to be declared, since there is a specific global var declared
   local Flag, Bet, BetDiPot, PotBet, X, Y, Text, OsdFontSize, Bold, Italic, Theme, TableType, PendingTableStartTime
   local Stack, M, EM, NumBB, FoldButtonVisibleFlag, PotOdds, CasinoName
   local PotDivCall, DisplayPot, DisplayCall            ; create local vars for these
   local ClientScaleFactor, TableRingOrTournament
   
   static Osd1LastText := ""
   static Osd1LastPosX := ""
   static Osd1LastPosY := ""
   static Osd1LastTheme := ""

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

    TableType := TableType(WinId)

   ; display the OSD if
   ;     the displays are enabled
   ;     and this is not a limit game OR the display is enabled for limit games
   ;   else return
   if (NOT((OsdBettingInfoEnabled) AND ((TableType <> "Limit")  OR  DisplayOsdBetInfoInLimitGamesEnabled)))
      return


   ; get the current table's pending start time,
   ; if it is in the pending table list (so we can display the elapsed time since the fold button appeared in the display routines below)
   Position := ListGetPos(TableIDPendingList,WinId)
   if Position
      PendingTableStartTime := Round(((A_TickCount - ListGetItem(TableIDPendingTimeList,Position))/1000),0)
   else
      PendingTableStartTime := "--"




   ; if action is pending, then show display
   if (TablePendingAction(WinId))
   {

      Bet := "--"
      BetDivPot := "--"
      PotBet := "--"
      PotOdds  := "--"

      ; this needs to be the SAFE version, because this display could be enabled, and
      ;     the user could hit the fold button right away and cause a crash
      ; get the current pot size and other vars

      BetVariables(WinId)
      
      ; added in ver 4.0014
      ; put in a check for the Pot == 0, if so then re-read the bet variables
      if (Pot == 0)
      {
         UpdateBettingVarsFlag := 1       ; so that we will actually try to read the bet vars again
         BetVariables(WinId)
      }

      if (Pot > 0)
      {
         DisplayPot := Pot
         Call := Call
      }

      else
      {
         DisplayPot := "--"
         Call := "--"
         PotDivCall  := "--"
      }

      ; get the bet amount IF the bet edit window is visible
      ;if ControlVisible("BoxBetEdit",WinId)
      Bet := BetAmountGet(WinId)
      if (Bet == 0)
         Bet := "--"
      

;outputdebug, in osd1  Bet: %Bet%   Call:%Call%  Pot:%DisplayPot%   potodds:%PotDivCall%



      ; PotPlusCall is the amount in the pot + the amount for the hero to call (if any)
      ; BetDivPot is the % of pot bet or pot raise that the current bet amount represents
      ; PotBet is the amount to bet (or raise to) to make a pot size bet (or raise)


      if ((Pot > 0) AND (Bet <> "--"))
      {
         BetDivPot := Round(((Bet-Call)/(Pot+Call))*100,0)
         PotBet := Pot
         if (Mod(PotBet*100,100) == 0)
            PotBet := Round(PotBet,0)

         if (Call > 0)
            PotOdds := Round(Pot / Call,1)
      }
      
      

      ; we don't want the possibility of calling the osdEx() function, and getting interrupted in the middle of it, so we'll turn critical on here
      ; this function could get called from by several independent places in the code (timer1 and betmodify() for example).
      ; osdEx() sometime causes AHK to spit out an error message "The same variable cannot be used for more than one control"
      Critical, On


      ; get the text to be displayed from the main program GUI
      Text := OsdBettingInfoText

      ; see if there are any option strings
      Italic := iif( InStr(Text, "!2"), "italic", "" )
      Bold := iif( InStr(Text, "!3"), "bold", "" )
      ; remove any option strings from the text
      StringReplace, Text, Text,!2,,All
      StringReplace, Text, Text,!3,,All


      ; substitute in any variables

      
      
      
      StringReplace, Text, Text,!r,`n,All
      StringReplace, Text, Text,!!,!,All

      StringReplace, Text, Text,!b,% BigBlind%WinId%,All
      StringReplace, Text, Text,!s,% SmallBlind%WinId%,All
      StringReplace, Text, Text,!a,% Ante%WinId%,All

      StringReplace, Text, Text,!x,%Bet%,All
      StringReplace, Text, Text,!y,%BetDivPot%,All
      StringReplace, Text, Text,!z,%PotBet%,All
      StringReplace, Text, Text,!t,%PendingTableStartTime%,All

      StringReplace, Text, Text,!c,%Call%,All
      StringReplace, Text, Text,!p,%DisplayPot%,All
      StringReplace, Text, Text,!d,%PotOdds%,All
      
      TableRingOrTournament := TableRingOrTournament(WinId)
      if TableRingOrTournament
         StringReplace, Text, Text,!q,% "DM:" . DealMeModeState%WinId%,All
      else
         StringReplace, Text, Text,!q,,All

      ; if there are any double next lines, remove one of them
      StringReplace, Text, Text,`n`n,`n,All


      ; get the scaled screen position of the position coordinates
      X := %CasinoName%OsdBettingInfoPosX
      Y := %CasinoName%OsdBettingInfoPosY

      ; we are placing the X,Y relative to the window
      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
      
      OsdFontSize := Round(OsdBettingInfoFontSize * ClientScaleFactor)

      Theme = c%OsdBettingInfoColor% s%OsdFontSize% %Bold% %Italic%   ; size, color, bold/italic

      ; set flag if the GUI does not exist
      Gui 97:+LastFoundExist
      IfWinNotExist
         Flag := 1

      ; display the gui if it did not exist, or if it is differnt from last time
      if (Flag OR (Text <> Osd1LastText) OR (Osd1LastPosX <> X) OR (Osd1LastPosY <> Y)  OR (Osd1LastTheme <> Theme))
      {
;outputdebug, refresh osd1    GuiNum:97
         ; erase the OSD in case the width has changed from last time
         osdEx("","","",0,0,97)

         ; this appears to be a slow command... so we only display it if it has changed of it doesn't exist
         osdEx( Text, Theme, OsdBettingInfoFont, X, Y,97)          ;osdEx(msg="", options="", font="", x=0, y=0, gui=98)
         ; save the text so that we know if it has changed or not
         Osd1LastText := Text
         Osd1LastPosX := X
         Osd1LastPosY := Y
         Osd1LastTheme := Theme
      }


   }

   ; else the fold button is gone, so erase the bet info
   else
   {
      ; erase the tooltip and OSDs
      osdEx("","","",0,0,97)

   }



}





; ----------------------------------------------------------------------------------------------------------------------




; return the next available gui num for the Osd3, that is not already in the GuiNumList
; returns 0 if we are already greater than MaxDisplayOsd3GuiNum constant... just so that we don't issue too many Guis
; this uses the guinums from 1-42 (max of 32)
; we put the numbers 1-32 in the list, but they are really offset to 1-32 (when used in the functions that use them as a guinum)
; the offset value is StartingDisplayOsd3GuiNumMinus1
; THIS FUNCTION MUST BE CALLED WITH Critical, on already in effect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
DisplayOsd3GuiNumNext()
{
   global                                 ; GuiNumList
   local ListLength, NextN, OffsetIndex
;outputdebug, guinumnext
   ; I added the critical on in all of the GuiHighlighter functions, so it isn't necessary in here
   ;Critical, On                        ; since this function could be called by multiple time... need to make it uninterruptable


   ; get the length of the used Osd3 gui numbers
   ListLength := ListLength(Osd3GuiNumList)

   ; if the list length is 0, then the first available number is 1
   if NOT ListLength
   {
      NextN := StartingDisplayOsd3GuiNumMinus1 + 1
   }
   ; else we will find the next available number
   else
   {
      ; loop thru the all the existing numbersnumbers and get the next available number

      loop, %ListLength%
      {
      
         OffsetIndex := A_index + StartingDisplayOsd3GuiNumMinus1

         ; see if the index number is available
         if ListGetPos(Osd3GuiNumList,OffsetIndex)
            continue
         else
         {
            ; this index number is available
            NextN := OffsetIndex
            break
         }
      }
      ; if there were no holes available, take the next one
      if NOT NextN
      {
         NextN := OffsetIndex + 1
      }
      if NextN > StartingDisplayOsd3GuiNumMinus1 + MaxDisplayOsd3GuiNum
         NextN := 0
   }
   ; add the next used gui number to the used list, as long as it is not 0 (no number available case)
   ; Plus add in the starting offset for our particular GUINUM
   if NextN
   {
      ListAddItem(Osd3GuiNumList,NextN)
   }
;outputdebug, NEW Osd3 number issued = %NextN%
   ;Critical Off

   return NextN
}



; destroy the Osd3 display on Table WinId
; THIS FUNCTION MUST BE CALLED WITH Critical, on   already activated
;
DisplayOsd3Off(WinId)
{
   global
   local GuiNum, Position        ;, GuiId

   ; so that we don't end up with partial highlighters showing (since TimerFast might interrupt), use critical
   ;Critical, On

   ; if display is already off, then return
   if NOT Osd3GuiNum%WinId%
   {
      ;Critical, Off
      return
   }

   ; get the GuiNum for this highlighter
   GuiNum := Osd3GuiNum%WinId%

   ; erase the GuiNum for this table
   Osd3GuiNum%WinId% =

   ; erase the last x position, just so that we are sure something will be changed when we re-display this OSD
   Osd3LastPosX%WinId% =


   ; kill this highlighter
   Gui %GuiNum%: destroy

   ; remove this GuiNum from the active list
   ListDelItem(Osd3GuiNumList,GuiNum)


;outputdebug, OSD3 off   %GuiNum%

   ;Critical, Off
}





DisplayOsd3(WinId)
{
   global
   local Flag, X, Y, ClientScaleFactor, Text, OsdFontSize, Theme, TableRingOrTournament, WindowIsOverlayedFlag
   local Stack, NumPlayers, NumBB, M, EM, NumTBB, PendingTableStartTime
   local Bold, Italic
   local TableActiveFlag, Position, Position1, Position2, GuiNum
   local CasinoName
   local Index, Levels, Parameter, Array, DisplayColor, HeroSeatedFlag
   ; we have some arrays...   Level   Color    Array     ; if we remove the Critical On, then we should define every possible array element here...  now they are global


;outputdebug, in Osd3 WinId:%WinId%

;DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
;DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)


   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return






   TableRingOrTournament := TableRingOrTournament(WinId)

   ; check if WinId is the active table
   IfWinActive, ahk_group Tables ahk_id%WinId%
      TableActiveFlag := 1
   else
      TableActiveFlag := 0

   ; check if hero is seated or not
   HeroSeatedFlag := HeroSeated(WinId)
   
   ; get the scaled screen position of the position coordinates
   X := %CasinoName%DisplayOsd3PosX
   Y := %CasinoName%DisplayOsd3PosY
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   
;   WindowIsOverlayedFlag := WindowIsOverlayedAtXY(X,Y,WinId)
   WindowIsOverlayedFlag := WindowIsOverlayed(WinId)
   


   ; so that we don't end up with partial gui number confusion, use critical on....   need this because we could call this from 2 different timers with different
   ;    priorities, and if we get interrupted in the middle of one, the LISTs could be messed up.
   ; I think that we need critical on here too, because below we have some arrays are used that should be defined locally, but can't do that in AHK...   arrays are Array, Level Color
   Critical, On

;outputdebug,   %WinId%     activetable:%TableActiveFlag%     HeroSeated=%HeroSeatedFlag%
;outputdebug, DisplayOsd3Enabled=%DisplayOsd3Enabled%
;outputdebug, TableActiveFlag=%TableActiveFlag%
;outputdebug, DisplayOsd3AllTablesEnabled=%DisplayOsd3AllTablesEnabled%
;outputdebug, TableRingOrTournament=%TableRingOrTournament%
;outputdebug, DisplayOsdStackInfoInRingGamesEnabled=%DisplayOsdStackInfoInRingGamesEnabled%
;outputdebug, HeroSeated=%HeroSeatedFlag%


   ; display the Osd3 info on this table
   ; if
   ;     DisplayOsd3Enabled
   ;     and  mouse button not held down
   ;     and (TableActiveFlag OR (!TableActiveFlag AND DisplayOsd3AllTablesEnabled))
   ;     and hero is seated
   ;     and ((NOT TableRingOrTournament) OR DisplayOsdStackInfoInRingGamesEnabled)
   ;     and window is not overlayed
   if (       DisplayOsd3Enabled

          AND (TableActiveFlag OR (!TableActiveFlag AND DisplayOsd3AllTablesEnabled))
          AND (HeroSeatedFlag == 1)
          AND ((NOT TableRingOrTournament) OR DisplayOsdStackInfoInRingGamesEnabled)
          AND (NOT WindowIsOverlayedFlag) )
   {

;          AND (!(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P")) )

      ; get all of the current information for this table

      ; get the scaled screen position of the position coordinates
;      X := %CasinoName%DisplayOsd3PosX
;      Y := %CasinoName%DisplayOsd3PosY
;      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

      ; get the number of players at this table, but only if we actually need this parameter
      if (instr(DisplayOsd3Text,"!m") OR instr(DisplayOsd3Text,"!p") OR instr(DisplayOsd3Text,"!e") OR instr(DisplayOsd3Text,"!o"))
         NumPlayers := TablePlayers(WinId)
      else
         NumPlayers := 1
         
      ; get the blinds and Antes (into global vars)
      TableBlinds(WinId)
      
      ; get the hero's stack size, but only if it is needed
      if (instr(DisplayOsd3Text,"!$") OR instr(DisplayOsd3Text,"!n") OR instr(DisplayOsd3Text,"!m") OR instr(DisplayOsd3Text,"!e") OR instr(DisplayOsd3Text,"!o"))
         Stack := HeroStack(WinId)
      else
         Stack := 0
         
      ;Stack # size if found
      ;S if sitting out
      ;A if All In
      ;"" if not found

      ; if the stack digits blank out, then just use the last stack value
      if ((Stack == "") OR (Stack == "S"))
         Stack := Osd3LastStack%WinId%

      if (Stack == "A")
         Stack := 0

      ; save the last stack size for next time thru this function
      Osd3LastStack%WinId% := Stack

      ; get this table's pending start time,
      ; if it is in the pending table list (so we can display the time in the display routines below)
      Position1 := ListGetPos(TableIDPendingList,WinId)
      if Position1
         PendingTableStartTime := Round(((A_TickCount - ListGetItem(TableIDPendingTimeList,Position1))/1000),0)
      else
         PendingTableStartTime := "0"





      ; calculate #BB and ~M, and round them off
      NumBB := Stack / BigBlind%WinId%
      if NumBB >= 10
         NumBB := Round(NumBB,0)
      else
         NumBB := Round(NumBB,1)

      ; calculate Harrington's M value
      M := Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)
      if M >= 10
         M := Round(M,0)
      else
         M := Round(M,1)

      ; calculate Harrington's effective M
      EM := (Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)) * (NumPlayers / 10)
      if EM >= 10
         EM := Round(EM,0)
      else
         EM := Round(EM,1)

      ; calculate tBB  i.e. True BB as discussed in    http://forumserver.twoplustwo.com/showthreaded.php?Cat=0&Number=12391697&page=0&vc=1
      ; you add BB plus 2/3 of the antes
      NumTBB :=  Stack / (BigBlind%WinId% + Ante%WinId% * NumPlayers * 2 / 3)
      if NumTBB >= 10
         NumTBB := Round(NumTBB,0)
      else
         NumTBB := Round(NumTBB,1)



      ; break the Osd3 color string into an array
      StringSplit,Array,DisplayOsd3Color,`,

;outputdebug, %Array0%  %Array1%  %Array2%  %Array3%  %Array4%

      ; if the array only has one element, then it must be a solid color, independent of any parameters
      if (Array0 <= 1)
         DisplayColor := DisplayOsd3Color
      ; else the user must have entered a selection of colors and levels to change the color at.
      else
      {
         ; find out how many "less than or equal to levels we have"
         Levels := ((Array0) / 2) - 1
         ; assign the levels and colors from the color array
         Index := 1       ; index pointer into the array (1 points to the criteria, e.g.  !b   )
         Loop, % Levels
         {
            Index++
            Level%a_index% := Array%Index%
            Index++
            Color%a_index% := Array%Index%
         }
         ; get the upper color (default) if the value is above all other levels, the last color in the string (or array)
         Index++
         ColorDefault := Array%Index%
;outputdebug, ColorDefault=%ColorDefault%
         ; get the value of the parameter we are checking for
         if (Array1 == "!n")
            Parameter := NumBB
         else if (Array1 == "!m")
            Parameter := M
         else if (Array1 == "!p")
            Parameter := NumPlayers
         else if (Array1 == "!$")
            Parameter := Stack
         else if (Array1 == "!e")
            Parameter := EM
         else if (Array1 == "!o")
            Parameter := NumTBB
         else if (Array1 == "!b")
            Parameter := BigBlind%WinId%
         else if (Array1 == "!t")
            Parameter := PendingTableStartTime
;outputdebug, Parameter=%Parameter%

         ; loop thru the levels to determine the color
         DisplayColor := ColorDefault      ; set the default color, in case we don't get a match in any of the levels
         loop, % Levels
         {
            if (Parameter <= Level%a_index%)
            {
               DisplayColor := Color%a_index%
               break
            }
         }
      }

;outputdebug, DisplayColor=%DisplayColor%

      OsdFontSize := Round(DisplayOsd3FontSize * ClientScaleFactor)

      Text := DisplayOsd3Text
      ; make sure there are no "|" characters in here, as this is our delimeter, remove them all
      StringReplace, Text, Text,|,,All

      ; see if there are any option strings
      Italic := iif( InStr(Text, "!2"), "italic", "" )
      Bold := iif( InStr(Text, "!3"), "bold", "" )
      ; remove any option strings from the text
      StringReplace, Text, Text,!2,,All
      StringReplace, Text, Text,!3,,All

      StringReplace, Text, Text,!r,`n,All
      StringReplace, Text, Text,!!,!,All

      StringReplace, Text, Text,!b,% BigBlind%WinId%,All
      StringReplace, Text, Text,!s,% SmallBlind%WinId%,All
      StringReplace, Text, Text,!a,% Ante%WinId%,All

      StringReplace, Text, Text,!$,%Stack%,All
      StringReplace, Text, Text,!m,%M%,All
      StringReplace, Text, Text,!n,%NumBB%,All
      StringReplace, Text, Text,!e,%EM%,All
      StringReplace, Text, Text,!p,%NumPlayers%,All

      StringReplace, Text, Text,!t,%PendingTableStartTime%,All

      StringReplace, Text, Text,!o,%NumTBB%,All

      if TableRingOrTournament
         StringReplace, Text, Text,!q,% "DM:" . DealMeModeState%WinId%,All
      else
         StringReplace, Text, Text,!q,,All

      ; if there are any double next lines, remove one of them
      StringReplace, Text, Text,`n`n,`n,All

      Theme = c%DisplayColor% s%OsdFontSize% %Bold% %Italic%   ; size, color, bold/italic

      ; get the class name of the process at XY
      ; if it is not  AutoHotkeyGUI  then some HUD has probably poped on top of our osd and we need to repaint our OSD
      Class := ClassOnTopAtXY(X+5,Y+5)

      ; check if anything has changed since last time... if so then re-display the new info, and update the lists
      if (     (X != Osd3LastPosX%WinId%)
            OR (Y != Osd3LastPosY%WinId%)
            OR (Text != Osd3LastText%WinId%)
            OR (Theme != Osd3LastTheme%WinId%)
            OR (Class != "AutoHotkeyGUI")  )
      {

         ; since something has changed, we need to turn of the display which will reset the width when we display it at the bottom
         DisplayOsd3Off(WinId)

         ; get a new gui num, since we just turned the display off
         Osd3GuiNum%WinId% := DisplayOsd3GuiNumNext()

         ; save a local copy of the current guinum
         GuiNum := Osd3GuiNum%WinId%


;outputdebug, Osd3 Re-displayed with GuiNum:%GuiNum%    WinId:%WinId%


         ; save these values for next time, so we can check if something has changed
         Osd3LastPosX%WinId% := X
         Osd3LastPosY%WinId% := Y
         Osd3LastText%WinId% := Text
         Osd3LastTheme%WinId% := Theme




         osdEx( Text, Theme, DisplayOsd3Font, X, Y,GuiNum)          ;osdEx(msg="", options="", font="", x=0, y=0, gui=98)

      }

   }
   ; else turn off the display for this table
   else
   {
      DisplayOsd3Off(WinId)
   }


Critical, Off


;DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;TimerTest := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, Osd3 time:     %WinId%     %TimerTest%

}








; ----------------------------------------------------------------------------------------------------------------------






; return the next available gui num for the OSD4, that is not already in the GuiNumList
; returns 0 if we are already greater than MaxDisplayOsd4GuiNum constant... just so that we don't issue too many Guis
; this uses the guinums from 1-42 (max of 32)
; we put the numbers 1-32 in the list, but they are really offset to 1-32 (when used in the functions that use them as a guinum)
; the offset value is StartingDisplayOsd4GuiNumMinus1
; THIS FUNCTION MUST BE CALLED WITH Critical, on already in effect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
DisplayOsd4GuiNumNext()
{
   global                                 ; GuiNumList
   local ListLength, NextN, OffsetIndex
;outputdebug, guinumnext
   ; I added the critical on in all of the GuiHighlighter functions, so it isn't necessary in here
   ;Critical, On                        ; since this function could be called by multiple time... need to make it uninterruptable


   ; get the length of the used Osd4 gui numbers
   ListLength := ListLength(Osd4GuiNumList)

   ; if the list length is 0, then the first available number is 1
   if NOT ListLength
   {
      NextN := StartingDisplayOsd4GuiNumMinus1 + 1
   }
   ; else we will find the next available number
   else
   {
      ; loop thru the all the existing numbersnumbers and get the next available number

      loop, %ListLength%
      {

         OffsetIndex := A_index + StartingDisplayOsd4GuiNumMinus1

         ; see if the index number is available
         if ListGetPos(Osd4GuiNumList,OffsetIndex)
            continue
         else
         {
            ; this index number is available
            NextN := OffsetIndex
            break
         }
      }
      ; if there were no holes available, take the next one
      if NOT NextN
      {
         NextN := OffsetIndex + 1
      }
      if NextN > StartingDisplayOsd4GuiNumMinus1 + MaxDisplayOsd4GuiNum
         NextN := 0
   }
   ; add the next used gui number to the used list, as long as it is not 0 (no number available case)
   ; Plus add in the starting offset for our particular GUINUM
   if NextN
   {
      ListAddItem(Osd4GuiNumList,NextN)
   }
;outputdebug, NEW Osd3 number issued = %NextN%
   ;Critical Off

   return NextN
}




; destroy the OSD4 display on Table WinId
; THIS FUNCTION MUST BE CALLED WITH Critical, on   already activated
;
DisplayOsd4Off(WinId)
{
   global
   local GuiNum, Position        ;, GuiId

   ; so that we don't end up with partial highlighters showing (since TimerFast might interrupt), use critical
   ;Critical, On

   ; if display is already off, then return
   if NOT Osd4GuiNum%WinId%
   {
      ;Critical, Off
      return
   }

   ; get the GuiNum for this highlighter
   GuiNum := Osd4GuiNum%WinId%
   
   ; erase the GuiNum for this table
   Osd4GuiNum%WinId% =
   
   ; erase the last x position, just so that we are sure something will be changed when we re-display this OSD
   Osd4LastPosX%WinId% =
   
   
   ; kill this highlighter
   Gui %GuiNum%: destroy
   
   ; remove this GuiNum from the active list
   ListDelItem(Osd4GuiNumList,GuiNum)
   
;outputdebug, OSD3 off   %GuiNum%


   ;Critical, Off
}






DisplayOsd4(WinId)
{
   global
   local Flag, X, Y, ClientScaleFactor, Text, OsdFontSize, Theme, TableRingOrTournament, WindowIsOverlayedFlag
   local Stack, NumPlayers, NumBB, M, EM, NumTBB, PendingTableStartTime
   local Bold, Italic
   local TableActiveFlag, Position, Position1, Position2, GuiNum
   local CasinoName
   local Index, Levels, Parameter, Array, DisplayColor, HeroSeatedFlag
   ; we have some arrays...   Level   Color    Array     ; if we remove the Critical On, then we should define every possible array element here...  now they are global


;outputdebug, in Osd4 WinId:%WinId%

;DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
;DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)


   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return




   TableRingOrTournament := TableRingOrTournament(WinId)

   ; check if WinId is the active table
   IfWinActive, ahk_group Tables ahk_id%WinId%
      TableActiveFlag := 1
   else
      TableActiveFlag := 0

   ; check if hero is seated or not
   HeroSeatedFlag := HeroSeated(WinId)

   ; get the scaled screen position of the position coordinates
   X := %CasinoName%DisplayOsd4PosX
   Y := %CasinoName%DisplayOsd4PosY
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

;   WindowIsOverlayedFlag := WindowIsOverlayedAtXY(X,Y,WinId)
   WindowIsOverlayedFlag := WindowIsOverlayed(WinId)

   ; so that we don't end up with partial gui number confusion, use critical on....   need this because we could call this from 2 different timers with different
   ;    priorities, and if we get interrupted in the middle of one, the LISTs could be messed up.
   ; I think that we need critical on here too, because below we have some arrays are used that should be defined locally, but can't do that in AHK...   arrays are Array, Level Color
   Critical, On

;outputdebug,   %WinId%     activetable:%TableActiveFlag%     HeroSeated=%HeroSeatedFlag%
;outputdebug, DisplayOsd4Enabled=%DisplayOsd4Enabled%
;outputdebug, TableActiveFlag=%TableActiveFlag%
;outputdebug, DisplayOsd4AllTablesEnabled=%DisplayOsd4AllTablesEnabled%
;outputdebug, TableRingOrTournament=%TableRingOrTournament%
;outputdebug, DisplayOsdStackInfoInRingGamesEnabled=%DisplayOsdStackInfoInRingGamesEnabled%
;outputdebug, HeroSeated=%HeroSeatedFlag%


   ; display the Osd4 info on this table
   ; if
   ;     DisplayOsd4Enabled
   ;     and  mouse button not held down
   ;     and (TableActiveFlag OR (!TableActiveFlag AND DisplayOsd4AllTablesEnabled))
   ;     and hero is seated
   ;     and ((NOT TableRingOrTournament) OR DisplayOsdStackInfoInRingGamesEnabled)
   ;     and window is not overlayed
   if (       DisplayOsd4Enabled

          AND (TableActiveFlag OR (!TableActiveFlag AND DisplayOsd4AllTablesEnabled))
          AND (HeroSeatedFlag == 1)
          AND ((NOT TableRingOrTournament) OR DisplayOsdStackInfoInRingGamesEnabled)
          AND (NOT WindowIsOverlayedFlag) )
   {

;          AND (!(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P")) )

      ; get all of the current information for this table

      ; get the scaled screen position of the position coordinates
;      X := %CasinoName%DisplayOsd4PosX
;      Y := %CasinoName%DisplayOsd4PosY
;      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

      ; get the number of players at this table, but only if we actually need this parameter
      if (instr(DisplayOsd4Text,"!m") OR instr(DisplayOsd4Text,"!p") OR instr(DisplayOsd4Text,"!e") OR instr(DisplayOsd4Text,"!o"))
         NumPlayers := TablePlayers(WinId)
      else
         NumPlayers := 1

      ; get the blinds and Antes (into global vars)
      TableBlinds(WinId)

      ; get the hero's stack size, but only if it is needed
      if (instr(DisplayOsd4Text,"!$") OR instr(DisplayOsd4Text,"!n") OR instr(DisplayOsd4Text,"!m") OR instr(DisplayOsd4Text,"!e") OR instr(DisplayOsd4Text,"!o"))
         Stack := HeroStack(WinId)
      else
         Stack := 0

      ;Stack # size if found
      ;S if sitting out
      ;A if All In
      ;"" if not found

      ; if the stack digits blank out, then just use the last stack value
      if ((Stack == "") OR (Stack == "S"))
         Stack := Osd4LastStack%WinId%

      if (Stack == "A")
         Stack := 0
         
      ; save the last stack size for next time thru this function
      Osd4LastStack%WinId% := Stack

      ; get this table's pending start time,
      ; if it is in the pending table list (so we can display the time in the display routines below)
      Position1 := ListGetPos(TableIDPendingList,WinId)
      if Position1
         PendingTableStartTime := Round(((A_TickCount - ListGetItem(TableIDPendingTimeList,Position1))/1000),0)
      else
         PendingTableStartTime := "0"

      ; calculate #BB and ~M, and round them off
      NumBB := Stack / BigBlind%WinId%
      if NumBB >= 10
         NumBB := Round(NumBB,0)
      else
         NumBB := Round(NumBB,1)

      ; calculate Harrington's M value
      M := Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)
      if M >= 10
         M := Round(M,0)
      else
         M := Round(M,1)

      ; calculate Harrington's effective M
      EM := (Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)) * (NumPlayers / 10)
      if EM >= 10
         EM := Round(EM,0)
      else
         EM := Round(EM,1)

      ; calculate tBB  i.e. True BB as discussed in    http://forumserver.twoplustwo.com/showthreaded.php?Cat=0&Number=12391697&page=0&vc=1
      ; you add BB plus 2/3 of the antes
      NumTBB :=  Stack / (BigBlind%WinId% + Ante%WinId% * NumPlayers * 2 / 3)
      if NumTBB >= 10
         NumTBB := Round(NumTBB,0)
      else
         NumTBB := Round(NumTBB,1)



      ; break the Osd4 color string into an array
      StringSplit,Array,DisplayOsd4Color,`,

;outputdebug, %Array0%  %Array1%  %Array2%  %Array3%  %Array4%

      ; if the array only has one element, then it must be a solid color, independent of any parameters
      if (Array0 <= 1)
         DisplayColor := DisplayOsd4Color
      ; else the user must have entered a selection of colors and levels to change the color at.
      else
      {
         ; find out how many "less than or equal to levels we have"
         Levels := ((Array0) / 2) - 1
         ; assign the levels and colors from the color array
         Index := 1       ; index pointer into the array (1 points to the criteria, e.g.  !b   )
         Loop, % Levels
         {
            Index++
            Level%a_index% := Array%Index%
            Index++
            Color%a_index% := Array%Index%
         }
         ; get the upper color (default) if the value is above all other levels, the last color in the string (or array)
         Index++
         ColorDefault := Array%Index%
;outputdebug, ColorDefault=%ColorDefault%
         ; get the value of the parameter we are checking for
         if (Array1 == "!n")
            Parameter := NumBB
         else if (Array1 == "!m")
            Parameter := M
         else if (Array1 == "!p")
            Parameter := NumPlayers
         else if (Array1 == "!$")
            Parameter := Stack
         else if (Array1 == "!e")
            Parameter := EM
         else if (Array1 == "!o")
            Parameter := NumTBB
         else if (Array1 == "!b")
            Parameter := BigBlind%WinId%
         else if (Array1 == "!t")
            Parameter := PendingTableStartTime
;outputdebug, Parameter=%Parameter%

         ; loop thru the levels to determine the color
         DisplayColor := ColorDefault      ; set the default color, in case we don't get a match in any of the levels
         loop, % Levels
         {
            if (Parameter <= Level%a_index%)
            {
               DisplayColor := Color%a_index%
               break
            }
         }
      }

;outputdebug, DisplayColor=%DisplayColor%

      OsdFontSize := Round(DisplayOsd4FontSize * ClientScaleFactor)

      Text := DisplayOsd4Text
      ; make sure there are no "|" characters in here, as this is our delimeter, remove them all
      StringReplace, Text, Text,|,,All
      
      ; see if there are any option strings
      Italic := iif( InStr(Text, "!2"), "italic", "" )
      Bold := iif( InStr(Text, "!3"), "bold", "" )
      ; remove any option strings from the text
      StringReplace, Text, Text,!2,,All
      StringReplace, Text, Text,!3,,All

      StringReplace, Text, Text,!r,`n,All
      StringReplace, Text, Text,!!,!,All

      StringReplace, Text, Text,!b,% BigBlind%WinId%,All
      StringReplace, Text, Text,!s,% SmallBlind%WinId%,All
      StringReplace, Text, Text,!a,% Ante%WinId%,All

      StringReplace, Text, Text,!$,%Stack%,All
      StringReplace, Text, Text,!m,%M%,All
      StringReplace, Text, Text,!n,%NumBB%,All
      StringReplace, Text, Text,!e,%EM%,All
      StringReplace, Text, Text,!p,%NumPlayers%,All

      StringReplace, Text, Text,!t,%PendingTableStartTime%,All

      StringReplace, Text, Text,!o,%NumTBB%,All
      
      
      
      if TableRingOrTournament
         StringReplace, Text, Text,!q,% "DM:" . DealMeModeState%WinId%,All
      else
         StringReplace, Text, Text,!q,,All

      ; if there are any double next lines, remove one of them
      StringReplace, Text, Text,`n`n,`n,All

      Theme = c%DisplayColor% s%OsdFontSize% %Bold% %Italic%   ; size, color, bold/italic

      ; get the class name of the process at XY
      ; if it is not  AutoHotkeyGUI  then some HUD has probably poped on top of our osd and we need to repaint our OSD
      Class := ClassOnTopAtXY(X+5,Y+5)

      ; check if anything has changed since last time... if so then re-display the new info, and update the lists
      if (     (X != Osd4LastPosX%WinId%)
            OR (Y != Osd4LastPosY%WinId%)
            OR (Text != Osd4LastText%WinId%)
            OR (Theme != Osd4LastTheme%WinId%)
            OR (Class != "AutoHotkeyGUI")  )
      {

         ; since something has changed, we need to turn of the display which will reset the width when we display it at the bottom
         DisplayOsd4Off(WinId)

         ; get a new gui num, since we just turned the display off
         Osd4GuiNum%WinId% := DisplayOsd4GuiNumNext()

         ; save a local copy of the current guinum
         GuiNum := Osd4GuiNum%WinId%


;outputdebug, Osd4 Re-displayed with GuiNum:%GuiNum%    WinId:%WinId%


         ; save these values for next time, so we can check if something has changed
         Osd4LastPosX%WinId% := X
         Osd4LastPosY%WinId% := Y
         Osd4LastText%WinId% := Text
         Osd4LastTheme%WinId% := Theme




         osdEx( Text, Theme, DisplayOsd4Font, X, Y,GuiNum)          ;osdEx(msg="", options="", font="", x=0, y=0, gui=98)

      }

   }
   ; else turn off the display for this table
   else
   {
      DisplayOsd4Off(WinId)
   }


Critical, Off


;DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;TimerTest := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, Osd4 time:     %WinId%     %TimerTest%

}



DisplayOsd5(WinId)
{
   global
   local Flag, X, Y, ClientScaleFactor, Text, OsdFontSize, Theme, TableRingOrTournament, WindowIsOverlayedFlag
   local Stack, NumPlayers, NumBB, M, EM, NumTBB, PendingTableStartTime
   local Bold, Italic
   local TableActiveFlag, Position, Position1, Position2, GuiNum
   local CasinoName
   local Index, Levels, Parameter, Array, DisplayColor
   ; we have some arrays...   Level   Color    Array     ; if we remove the Critical On, then we should define every possible array element here...  now they are global
   
   local TableSeats, MouseX, MouseY, MouseCloseToPlayerNum
   local WindowX,  WindowY,  WindowW,  WindowH,  ClientW,  ClientH,  WindowTopBorder,  WindowBottomBorder,  WindowSideBorder


   local Osd5GuiNum := 98
   static Osd5LastPosX := 0
   static Osd5LastPosY := 0
   static Osd5LastTheme := ""
   static Osd5LastText := ""
   static Osd5LastStack := 0
   
   

   

;outputdebug, in Osd5 WinId:%WinId%   %DisplayOsd5Enabled%  %DisplayOsd5Color%  %DisplayOsd5FontSize%  %DisplayOsd5Font%  %DisplayOsd5Text%

;DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
;DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)


   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return


   ; determine if the mouse is close to any player's box
   
   ; this is the seat we are close to... init to 0 in case we don't find that we are close to any player's box later
   MouseCloseToPlayerNum := 0

   
   ; get the mouse's position on this table
   CoordMode, Mouse, Relative
   MouseGetPos, MouseX, MouseY, MouseOverTableId

;outputdebug, Mouse1:  %MouseX%   %MouseY%
   
   ; if the mouse is NOT over a table, set the id to 0, so we can exit later
   ifWinNotExist, ahk_id%MouseOverTableId% ahk_group Tables
      MouseOverTableId := 0

   
   WindowInfo(WindowX, WindowY, WindowW, WindowH, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)
   
   ; convert the mouse position to just the client area
   MouseX -= WindowSideBorder
   MouseY -= WindowTopBorder

;outputdebug, Mouse2:  %MouseX%   %MouseY%   ClientWH:  %ClientW%   %ClientH%
   
   ; convert the mouse's position to a normal size table position (in the client area)
   MouseX := MouseX *  %CasinoName%StandardClientWidth / ClientW
   MouseY := MouseY *  %CasinoName%StandardClientHeight / ClientH

;outputdebug, Mouse3:  %MouseX%   %MouseY%

   ; find the number of seats at this table
   TableSeats := TableSeats(WinId)
   ; loop through all the seats, and see if the mouse is within Osd5DistanceTolerance from the center of a players box
   loop, %TableSeats%
   {
      ; find the distance from the mouse to the center of the player's box
      if ( ( Distance(MouseX,MouseY, %CasinoName%PlayerBoxSeats%TableSeats%Seat%A_Index%X + %CasinoName%StackCenterOffsetX, %CasinoName%PlayerBoxSeats%TableSeats%Seat%A_Index%Y + %CasinoName%StackCenterOffsetY)  ) < Osd5DistanceTolerance)
      {
         MouseCloseToPlayerNum := A_Index
         break

      }
   }








   ; get the scaled screen position of the position coordinates
   X := %CasinoName%DisplayOsd5PosX
   Y := %CasinoName%DisplayOsd5PosY
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

;outputdebug, XY:  %X%  %Y%


;   WindowIsOverlayedFlag := WindowIsOverlayedAtXY(X,Y,WinId)
   WindowIsOverlayedFlag := WindowIsOverlayed(WinId)



   ; so that we don't end up with partial gui number confusion, use critical on....   need this because we could call this from 2 different timers with different
   ;    priorities, and if we get interrupted in the middle of one, the LISTs could be messed up.
   ; I think that we need critical on here too, because below we have some arrays are used that should be defined locally, but can't do that in AHK...   arrays are Array, Level Color
;   Critical, On

;outputdebug,   %WinId%     activetable:%TableActiveFlag%     HeroSeated=%HeroSeatedFlag%
;outputdebug, DisplayOsd5Enabled=%DisplayOsd5Enabled%
;outputdebug, TableActiveFlag=%TableActiveFlag%
;outputdebug, DisplayOsd5AllTablesEnabled=%DisplayOsd5AllTablesEnabled%
;outputdebug, TableRingOrTournament=%TableRingOrTournament%
;outputdebug, DisplayOsdStackInfoInRingGamesEnabled=%DisplayOsdStackInfoInRingGamesEnabled%
;outputdebug, HeroSeated=%HeroSeatedFlag%


   ; display the Osd5 info on this table
   ; if
   ;     DisplayOsd5Enabled
   ;     and MouseCloseToPlayerNum is > 0  (i.e. mouse is near a player's box)
   ;     and the mouse is over a table (MouseOverTableId <> 0)
   ;     and window is not overlayed
   if (       DisplayOsd5Enabled
          AND MouseCloseToPlayerNum
          AND MouseOverTableId
          AND (NOT WindowIsOverlayedFlag) )
   {


      TableRingOrTournament := TableRingOrTournament(WinId)


;          AND (!(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P")) )

      ; get all of the current information for this table

      ; get the scaled screen position of the position coordinates
;      X := %CasinoName%DisplayOsd5PosX
;      Y := %CasinoName%DisplayOsd5PosY
;      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

      ; get the number of players at this table, but only if we actually need this parameter
      if (instr(DisplayOsd5Text,"!m") OR instr(DisplayOsd5Text,"!p") OR instr(DisplayOsd5Text,"!e") OR instr(DisplayOsd5Text,"!o"))
         NumPlayers := TablePlayers(WinId)
      else
         NumPlayers := 1

      ; get the blinds and Antes (into global vars)
      TableBlinds(WinId)

      ; get the Player's stack size, but only if it is needed
      if (instr(DisplayOsd5Text,"!$") OR instr(DisplayOsd5Text,"!n") OR instr(DisplayOsd5Text,"!m") OR instr(DisplayOsd5Text,"!e") OR instr(DisplayOsd5Text,"!o"))
         Stack := PlayersStack(MouseCloseToPlayerNum,WinId)
      else
         Stack := 0

      ;Stack # size if found
      ;S if sitting out
      ;A if All In
      ;"" if not found

      ; if the stack digits blank out, then just use the last stack value
      if ((Stack == "") OR (Stack == "S"))
         Stack := 0

      if (Stack == "A")
         Stack := 0

      ; save the last stack size for next time thru this function
      Osd5LastStack := Stack

      ; get this table's pending start time,
      ; if it is in the pending table list (so we can display the time in the display routines below)
      Position1 := ListGetPos(TableIDPendingList,WinId)
      if Position1
         PendingTableStartTime := Round(((A_TickCount - ListGetItem(TableIDPendingTimeList,Position1))/1000),0)
      else
         PendingTableStartTime := "0"





      ; calculate #BB and ~M, and round them off
      NumBB := Stack / BigBlind%WinId%
      if NumBB >= 10
         NumBB := Round(NumBB,0)
      else
         NumBB := Round(NumBB,1)

      ; calculate Harrington's M value
      M := Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)
      if M >= 10
         M := Round(M,0)
      else
         M := Round(M,1)

      ; calculate Harrington's effective M
      EM := (Stack / (BigBlind%WinId% + SmallBlind%WinId% + Ante%WinId% * NumPlayers)) * (NumPlayers / 10)
      if EM >= 10
         EM := Round(EM,0)
      else
         EM := Round(EM,1)

      ; calculate tBB  i.e. True BB as discussed in    http://forumserver.twoplustwo.com/showthreaded.php?Cat=0&Number=12391697&page=0&vc=1
      ; you add BB plus 2/3 of the antes
      NumTBB :=  Stack / (BigBlind%WinId% + Ante%WinId% * NumPlayers * 2 / 3)
      if NumTBB >= 10
         NumTBB := Round(NumTBB,0)
      else
         NumTBB := Round(NumTBB,1)



      ; break the Osd5 color string into an array
      StringSplit,Array,DisplayOsd5Color,`,

;outputdebug, %Array0%  %Array1%  %Array2%  %Array3%  %Array4%

      ; if the array only has one element, then it must be a solid color, independent of any parameters
      if (Array0 <= 1)
         DisplayColor := DisplayOsd5Color
      ; else the user must have entered a selection of colors and levels to change the color at.
      else
      {
         ; find out how many "less than or equal to levels we have"
         Levels := ((Array0) / 2) - 1
         ; assign the levels and colors from the color array
         Index := 1       ; index pointer into the array (1 points to the criteria, e.g.  !b   )
         Loop, % Levels
         {
            Index++
            Level%a_index% := Array%Index%
            Index++
            Color%a_index% := Array%Index%
         }
         ; get the upper color (default) if the value is above all other levels, the last color in the string (or array)
         Index++
         ColorDefault := Array%Index%
;outputdebug, ColorDefault=%ColorDefault%
         ; get the value of the parameter we are checking for
         if (Array1 == "!n")
            Parameter := NumBB
         else if (Array1 == "!m")
            Parameter := M
         else if (Array1 == "!p")
            Parameter := NumPlayers
         else if (Array1 == "!$")
            Parameter := Stack
         else if (Array1 == "!e")
            Parameter := EM
         else if (Array1 == "!o")
            Parameter := NumTBB
         else if (Array1 == "!b")
            Parameter := BigBlind%WinId%
         else if (Array1 == "!t")
            Parameter := PendingTableStartTime
;outputdebug, Parameter=%Parameter%

         ; loop thru the levels to determine the color
         DisplayColor := ColorDefault      ; set the default color, in case we don't get a match in any of the levels
         loop, % Levels
         {
            if (Parameter <= Level%a_index%)
            {
               DisplayColor := Color%a_index%
               break
            }
         }
      }

;outputdebug, DisplayColor=%DisplayColor%

      OsdFontSize := Round(DisplayOsd5FontSize * ClientScaleFactor)

      Text := DisplayOsd5Text
      ; make sure there are no "|" characters in here, as this is our delimeter, remove them all
      StringReplace, Text, Text,|,,All

      ; see if there are any option strings
      Italic := iif( InStr(Text, "!2"), "italic", "" )
      Bold := iif( InStr(Text, "!3"), "bold", "" )
      ; remove any option strings from the text
      StringReplace, Text, Text,!2,,All
      StringReplace, Text, Text,!3,,All

      StringReplace, Text, Text,!r,`n,All
      StringReplace, Text, Text,!!,!,All

      StringReplace, Text, Text,!b,% BigBlind%WinId%,All
      StringReplace, Text, Text,!s,% SmallBlind%WinId%,All
      StringReplace, Text, Text,!a,% Ante%WinId%,All

      StringReplace, Text, Text,!$,%Stack%,All
      StringReplace, Text, Text,!m,%M%,All
      StringReplace, Text, Text,!n,%NumBB%,All
      StringReplace, Text, Text,!e,%EM%,All
      StringReplace, Text, Text,!p,%NumPlayers%,All

      StringReplace, Text, Text,!t,%PendingTableStartTime%,All

      StringReplace, Text, Text,!o,%NumTBB%,All

      if TableRingOrTournament
         StringReplace, Text, Text,!q,% "DM:" . DealMeModeState%WinId%,All
      else
         StringReplace, Text, Text,!q,,All

      ; if there are any double next lines, remove one of them
      StringReplace, Text, Text,`n`n,`n,All

      Theme = c%DisplayColor% s%OsdFontSize% %Bold% %Italic%   ; size, color, bold/italic

      ; get the class name of the process at XY
      ; if it is not  AutoHotkeyGUI  then some HUD has probably poped on top of our osd and we need to repaint our OSD
      Class := ClassOnTopAtXY(X+5,Y+5)

      ; check if anything has changed since last time... if so then re-display the new info, and update the lists
      if (     (X != Osd5LastPosX)
            OR (Y != Osd5LastPosY)
            OR (Text != Osd5LastText)
            OR (Theme != Osd5LastTheme)
            OR (Class != "AutoHotkeyGUI")  )
      {

         ; since something has changed, we need to turn of the display which will reset the width when we display it at the bottom
         osdEx("","","",0,0,98)


;outputdebug, Osd5 Re-displayed with GuiNum:%GuiNum%    WinId:%WinId%


         ; save these values for next time, so we can check if something has changed
         Osd5LastPosX := X
         Osd5LastPosY := Y
         Osd5LastText := Text
         Osd5LastTheme := Theme




         osdEx( Text, Theme, DisplayOsd5Font, X, Y,Osd5GuiNum)          ;osdEx(msg="", options="", font="", x=0, y=0, gui=98)

      }

   }
   ; else turn off the display for this table
   else
   {
      ; erase the tooltip and OSDs
      osdEx("","","",0,0,98)
   }


;Critical, Off


;DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;TimerTest := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, Osd5 time:     %WinId%     %TimerTest%

}







; from Roland's functions
; similar to osd(), but the position is meant to be spedified here
; to destroy the gui/message, call the function without
; any parameters
; Options are
;        sxx   font size, where xx is the size
;        bold
;        italic
;        cxx   color, where xx is a hex number or a word color
;        center
;        wxxx  width of osd in pixels...   I removed the width from the main osd below... see note below. the width no just defaults to whatever the text takes up.
;
;  if ParentWinId is specified, then the OSD will be attached to that window, and X,Y will be relative to that window...  else X,Y is relative to the screen

/*
I am having getting the set parent to work. It seems to end up invisible. I have a test routine in PokerShortcuts.ahk  label: F7
to test, but I wasn't able to get it working.
*/
; osdEx() sometime causes AHK to spit out an error message "The same variable cannot be used for more than one control"
;     so I now make sure that it can't be called by two functions at the same time (by using a Critical, On   in all functions that call this function.)
osdEx(msg="", options="", font="", x=0, y=0, gui=98) {
   global osdEx_msg                             ; this is used as a variable name for each GUI created...
                                                ; the gui num further defines each one, but they all have this Control Name
   options := a_space . options . a_space
   size := StrEnd(options, "s")
   size := iif( size, size, 30 )
   bold := iif( InStr(options, " bold "), "bold", "" )
   italic := iif( InStr(options, " italic "), "italic", "" )
   color := StrEnd(options, "c")
   color := iif( color, color, "white" )
   theme = s%size% c%color% %bold% %italic%
   font := iif( font, font, "Comic Sans MS" )
   width := StrEnd(options, "w")
   width := iif( width, width, a_screenwidth )
   center := iif( InStr(options, " center "), "center", "" )
   Gui, %gui%: Default
   ;  need to leave this destroy code in for some of the code kills the gui using this method
   If ( msg="" ) {
     Gui, Destroy
     return
   }
   Gui +LastfoundExist
   If WinExist() {                              ; if this Gui num already exists... change the color and text   (if the width is now different compared to the last time it was displayed, the display may not show up correctly)

     Gui, Show, x%x% y%y% NoActivate
     Gui, Font, s%size% c%color% %bold% %italic%, font    ; set the font attributes for the font again, in case it changed
     GuiControl, Font, osdEx_msg                ; this attaches the font parameters above to the GUI control (whose control name is osdEx_msg)
     GuiControl,, osdEx_msg, %msg%              ; writes the new text to the control...
                                                ;    if the width changes a lot, it might not fit in the old width
                                                ;    there is a width command
     return
   }
   Gui, +Lastfound +Toolwindow +AlwaysOnTop
   Gui, Color, Black
   WinSet, TransColor, Black
   Gui -Caption
   Gui, Margin, 0, 0
   Gui, Font, %theme%, %font%
;   Gui, Add, Text, vosdEx_msg w%width% %center%, %msg%      ; adds a text control to the GUI, with the name of   osdEx_msg
   ; I removed the WIDTH command because it was defaulting to a_screenwidth if I didn't specify it... the display was then on top of a lot of stuff across the screen.
   ; if you don't specify width, it just takes up as much width as the text needs
   Gui, Add, Text, vosdEx_msg %center%, %msg%      ; adds a text control to the GUI, with the name of   osdEx_msg
   Gui, +E0x20 ; WS_EX_TRANSPARENT - allows a mouse to be able to click thru this overlay window (and move something below it)
   
;   if ParentWinId
;      SetParent(ParentWinId,gui)
   
   Gui, Show, x%x% y%y% NoActivate

}


; turns Gui #'gui' into a child window of 'win'
setParent(win, gui) {
Gui, %gui%: +LastFound
return DllCall("SetParent", "uint", WinExist(), "uint", win)
}





