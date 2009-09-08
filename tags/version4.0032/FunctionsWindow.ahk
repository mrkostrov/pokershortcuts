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
; Window Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



/*
WindowScaledPos()
   Purpose: This function scales PosX,PosY for the current window size
      to find the new position coordinates for a different size table (compared to the
      standard Client window size)
      If the window is a poker table, then the XY position is scaled proportionally to a standard size table, based on what the current table size is.
      If the window is not a poker table, then no scaling takes place
   Requires:
      nothing special
   Returns:
      nothing
   Parameters:
      ByRef PosX: Client window x position... returns scaled position
      ByRef PosY: Client window y position... returns scaled position
      ByRef ClientScaleFactor: not needed in fcn... returns the table scale factor for current table
               (note: the horiz and vertical scale factors are about the same, so we just return 1 of them - width one)
      ScaleType:
         if = "Window", then return position relative to the WinId window
         if = "Screen", then return position relative to the screen
         if = "Client", then return position relative to the client area of WinId
      WinId: window id.
*/
WindowScaledPos(ByRef PosX, ByRef PosY, ByRef ClientScaleFactor, ScaleType="Screen", WinId="")
{
   global   ; we need some settings   %CasinoName%StandardClientWidth, %CasinoName%StandardClientHeight

   local TitleBarHeight, WindowBottomBorder, WindowSideBorder, WindowTopBorder ,WindowX,WindowY,WindowWidth,WindowHeight
   local ClientWidth, ClientHeight , ClientWidthScaleFactor, ClientHeightScaleFactor
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return


   SysGet, TitleBarHeight, 4

   SysGet, WindowBottomBorder, 32
   SysGet, WindowSideBorder, 33

   WindowTopBorder := TitleBarHeight + WindowBottomBorder

   ; get the current window info (includes borders)
   WinGetPos,WindowX,WindowY,WindowWidth,WindowHeight,ahk_id%WinId%


   ; if this is a poker table, then scale the XY position based on the size of the current table to a standard table size
   ifWinExist, ahk_id%WinId%  ahk_group Tables
   {
      ; calc the Client area in this window (window - borders)
      ClientWidth := WindowWidth - 2 * WindowSideBorder
      ClientHeight := WindowHeight - TitleBarHeight - 2 * WindowBottomBorder
   
   
   
      ; calculate the current Client area scale factors
      ClientWidthScaleFactor := ClientWidth / %CasinoName%StandardClientWidth
      ClientHeightScaleFactor := ClientHeight / %CasinoName%StandardClientHeight
   
   ;outputdebug, scale factors  %ClientWidthScaleFactor%, %ClientHeightScaleFactor%
   
   
      ClientScaleFactor := ClientWidthScaleFactor     ; pass back the scaling factor in case the calling function needs it
   
      ; scale the positions within the client area
      PosX := Round(PosX * ClientWidthScaleFactor)
      PosY := Round(PosY * ClientHeightScaleFactor)
   }
   
   
   if (ScaleType == "Client")
   {
      return
   }
   ; if position is needed relative to the window, then add in the borders of the window
   else if (ScaleType == "Window")
   {
      PosX += WindowSideBorder
      PosY += WindowTopBorder
   }

   ; if position is needed relative to the screen, then add in borders and the screen position of the window
   else if (ScaleType == "Screen")
   {
      PosX += WindowX + WindowSideBorder
      PosY += WindowY + WindowTopBorder
   }



;outputdebug, in windowscaledpos   CasinoName:%CasinoName%   X%PosX%  Y%PosY%   WScaleFactor%ClientWidthScaleFactor%   HScaleFactor%ClientHeightScaleFactor%   TopBorder%WindowTopBorder%   SideBorder%WindowSideBorder%
}
; -----------------------------------------------------------------------------------------

; return these byref parameters
WindowInfo(ByRef WindowX, ByRef WindowY, ByRef WindowW, ByRef WindowH, ByRef ClientW, ByRef ClientH, ByRef WindowTopBorder, ByRef WindowBottomBorder, ByRef WindowSideBorder, WinId)
{
   global    ; many global variables returned from the WindowSize() function
   local TitleBarHeight,  CXEDGE, CYEDGE, CXSIZEFRAME, CYSIZEFRAME
;   local WindowTopBorder, WindowBottomBorder, WindowSideBorder


   SysGet, TitleBarHeight, 4

   SysGet, CXEDGE, 45
   SysGet, CYEDGE, 46

   SysGet, CXSIZEFRAME, 32
   SysGet, CYSIZEFRAME, 33

   ; if this is a dialog box, then use the vCXEDGE as the borders, else use CXSIZEFRAME for the size of the borders
   ifWinExist ahk_id%WinId%  ahk_class #32770
   {
      WindowBottomBorder := CXEDGE
      WindowSideBorder := CYEDGE
   }
   ; else it must be a table
   else
   {
      WindowBottomBorder := CXSIZEFRAME
      WindowSideBorder := CYSIZEFRAME
   }

   WindowTopBorder :=TitleBarHeight + WindowBottomBorder

   ; get the current window info (includes borders)
   WinGetPos,WindowX,WindowY,WindowW,WindowH,ahk_id%WinId%

   ; calc the Client area in this window (window - borders)
   ClientW := WindowW - 2 * WindowSideBorder
   ClientH := WindowH - TitleBarHeight - 2 * WindowBottomBorder
}
