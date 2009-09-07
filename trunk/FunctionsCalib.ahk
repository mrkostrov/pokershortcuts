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

; -----------------------------------------------------------------------------------------

; sample the color of the seats when no players are seated
;     pNumSeats is the number at seats at this table
;     pTableShape is C for Classic, and R for Racetrack (note capital letters)
FTColorSampleSeats(NumSeats)
{
   global
   local WinId, X, Y, ClientScaleFactor, Color

   ; activate any FT table
   WinActivate, ahk_group FTTables                    ; activates the most recently used FT window
   Sleep, 200

   WinId := WinActive("A")

   loop, %NumSeats%
   {
      ; these positions listed are on a default table with standard title bar of 26
      ; WindowScaledPos() will calculate the positions for the current resized table with any size title bar

      X := FTPlayerBoxSeats%NumSeats%Seat%A_Index%X + FTEmptySeatOffsetX
      Y := FTPlayerBoxSeats%NumSeats%Seat%A_Index%Y + FTEmptySeatOffsetY

      ; convert the x,y position to a screen position
      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
;outputdebug, seat calibration   X:%X%   Y:%Y%
      ; make sure that the table is visible at XY
      if WindowIsOverlayedAtXY(X,Y,WinId)
      {
         MsgBox,% "Problem occurred while calibrating table empty seat colors: `nThe Full Tilt Poker table appears to be covered at seat " . A_Index
         return                                                    
      }
      
      Color := ColorGetAtXY(X,Y)

      ; save the color at this location to the variable
      FTPlayerEmptySeatColorSeats%NumSeats%Seat%A_Index% := Color

      ; save it to the gui as well
      Gui, 99:Default
      GuiControl +Background%Color%, FTPlayerEmptySeatColorSeats%NumSeats%Seat%A_Index%Display

   }
}


; -----------------------------------------------------------------------------------------

; sample the colors behind these board cards
; user must be sure that there are no board cards present
ColorSampleStreets(CasinoName)
{
   global                                                ;ColorBehindFlopCard, ColorBehindTurnCard, ColorBehindRiverCard
   local WinId, X, Y, Color,ClientScaleFactor

   ; activate the last active poker table
   WinActivate, ahk_group %CasinoName%Tables

   Sleep, 200

   WinId := WinActive("A")
   
   ifWinNotActive, ahk_group %CasinoName%Tables
   {
      MsgBox, % "Not able to find or activate a " . CasinoName . " table"
      return
   }   
   
;   if (CasinoName <> CasinoName(WinId,A_ThisFunc))
;   {
;      MsgBox, % "The last active table is not a " . CasinoName . " table"
;      return
;   }

   ; get the colors behind the board cards


   X := %CasinoName%FlopX
   Y := %CasinoName%FlopY
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
   {
      MsgBox,% "Problem occurred while calibrating the table felt colors: `nThe poker table appears to be covered at the 1st board card. You may be using an unknown HUD (heads up display) that is covering the table with an invisible layer. See the troubleshooting web page regarding adding support for unknown HUDs."
      return
   }
   Color := ColorGetAtXY(X,Y)
   ; save the color at this location to the variable
   %CasinoName%FlopColor := Color
   ; save it to the gui as well
   Gui, 99:Default
   GuiControl +Background%Color%, %CasinoName%FlopColorDisplay


   X := %CasinoName%TurnX
   Y := %CasinoName%TurnY
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
   {
      MsgBox,% "Problem occurred while calibrating the table felt colors: `nThe poker table appears to be covered at the 4th board card. You may be using an unknown HUD (heads up display) that is covering the table with an invisible layer. See the troubleshooting web page regarding adding support for unknown HUDs."
      return
   }
   Color := ColorGetAtXY(X,Y)
   ; save the color at this location to the variable
   %CasinoName%TurnColor := Color
   ; save it to the gui as well
   Gui, 99:Default
   GuiControl +Background%Color%, %CasinoName%TurnColorDisplay


   X := %CasinoName%RiverX
   Y := %CasinoName%RiverY
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
   {
      MsgBox,% "Problem occurred while calibrating the table felt colors: `nThe poker table appears to be covered at the 5th board card. You may be using an unknown HUD (heads up display) that is covering the table with an invisible layer. See the troubleshooting web page regarding adding support for unknown HUDs."
      return
   }
   Color := ColorGetAtXY(X,Y)
   ; save the color at this location to the variable
   %CasinoName%RiverColor := Color
   ; save it to the gui as well
   Gui, 99:Default
   GuiControl +Background%Color%, %CasinoName%RiverColorDisplay


   X := %CasinoName%TestX
   Y := %CasinoName%TestY
   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)
   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
   {
      MsgBox,% "Problem occurred while calibrating the table felt colors: `nThe poker table appears to be covered between the 1st and 2nd board cards. You may be using an unknown HUD (heads up display) that is covering the table with an invisible layer. See the troubleshooting web page regarding adding support for unknown HUDs."
      return
   }
   Color := ColorGetAtXY(X,Y)
   ; save the color at this location to the variable
   %CasinoName%TestColor := Color
   ; save it to the gui as well
   Gui, 99:Default
   GuiControl +Background%Color%, %CasinoName%TestColorDisplay


}



