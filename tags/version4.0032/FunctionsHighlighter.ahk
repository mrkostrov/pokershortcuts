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
 
 
 ; ***********************************************************************************************
; -----------------------------------------------------------------------------------------------
;  Gui Functions
; -----------------------------------------------------------------------------------------------
; ***********************************************************************************************

; create a highlighter box on top of the Table WinId
; if WinId == 0, then turn off the highlighter
HighlighterOn(Color=0xFF0000, Transperancy=200, BorderSize=5, WinId=0)
{
   global                                       ; GuiNumList, GuiIdList, GuiTableIdList
   local GuiNum, Position, GuiId
   local X, Y
   local WindowX, WindowY, WindowW, WindowH, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder,

   
   static HighlighterOnFlag := 0              ; true if the highlighter is currently on
   static PreviousHighlightedTableId := 0                                  ; winid of the table that has highlighter on
   static PreviousHighlightColor := 0
   
   GuiNum := HighlighterGuiNum                                 ; set the starting guinum




   ; see we we just need to turn off the highlighter
   if (WinId == 0)
   {
      ; turn off the highlighter if it was on
      if HighlighterOnFlag
         Gosub HighlighterDestroy
         
      return
   }


   ; turn off the old highlighter IF
   ;     Highlighter was ON
   ;     and it was a different table from the one we want to turn on now
   if ((HighlighterOnFlag) AND (PreviousHighlightedTableId <> WinId))
   {
      Gosub HighlighterDestroy
   }


   ; so that we don't end up with partial highlighters showing (since TimerFast might interrupt), use critical
   ; or this function getting called in both timermedium and timerfast at the same time, we
   Critical, On



   ; if there already is a highlighter on this table, then just set it's color (IF it has changed)
   if (HighlighterOnFlag AND (PreviousHighlightedTableId == WinId))
   {
      ; if we have a new color, then update the color
      if (PreviousHighlightColor <> Color)
      {
   
         GuiNum := HighlighterGuiNum                                 ; set the starting guinum
         ; set the color of this table's highlighter (4 borders)
         Gui, %GuiNum%: Color, %Color%
         GuiNum++
         Gui, %GuiNum%: Color, %Color%
         GuiNum++
         Gui, %GuiNum%: Color, %Color%
         GuiNum++
         Gui, %GuiNum%: Color, %Color%
         
         PreviousHighlightColor := Color
         
      
      }

      Critical, Off

      return

   }

   ; get the window position information
   WindowInfo(WindowX, WindowY, WindowW, WindowH, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)

   GuiNum := HighlighterGuiNum                                 ; set the starting guinum



   ;top
   Gui, %GuiNum%: +Alwaysontop +Lastfound +ToolWindow              ;+Owner
   Gui, %GuiNum%: Color, %Color%
   WinSet, Transparent, %Transperancy%
   Gui, %GuiNum%: -Caption
   Gui, %GuiNum%: +E0x20 ; WS_EX_TRANSPARENT - allows a mouse to be able to click thru this overlay window (and move something below it)
   Gui, %GuiNum%: Show, w%WindowW% h%BorderSize% x%WindowX% y%WindowY% NoActivate


   ;left
   GuiNum++
   Gui, %GuiNum%: +Alwaysontop +Lastfound +ToolWindow              ;+Owner
   Gui, %GuiNum%: Color, %Color%
   WinSet, Transparent, %Transperancy%
   Gui, %GuiNum%: -Caption
   Gui, %GuiNum%: +E0x20 ; WS_EX_TRANSPARENT
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)
   Gui, %GuiNum%: Show, w%BorderSize% h%WindowH% x%WindowX% y%WindowY% NoActivate
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)

   ;bottom
   GuiNum++
   Gui, %GuiNum%: +Alwaysontop +Lastfound +ToolWindow              ;+Owner
   Gui, %GuiNum%: Color, %Color%
   WinSet, Transparent, %Transperancy%
   Gui, %GuiNum%: -Caption
   Gui, %GuiNum%: +E0x20 ; WS_EX_TRANSPARENT
   Y := WindowY + WindowH - BorderSize
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)
   Gui, %GuiNum%: Show, w%WindowW% h%BorderSize% x%WindowX% y%Y% NoActivate
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)

   ;right
   GuiNum++
   Gui, %GuiNum%: +Alwaysontop +Lastfound +ToolWindow              ;+Owner
   Gui, %GuiNum%: Color, %Color%
   WinSet, Transparent, %Transperancy%
   Gui, %GuiNum%: -Caption
   Gui, %GuiNum%: +E0x20 ; WS_EX_TRANSPARENT
   X := WindowX + WindowW - BorderSize
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)
   Gui, %GuiNum%: Show, w%BorderSize% h%WindowH% x%X% y%WindowY% NoActivate
;   DllCall("SetParent", "uint", WinExist(), "uint", WinId)


   HighlighterOnFlag := 1
   PreviousHighlightedTableId := WinId
   PreviousHighlightColor := Color

   Critical, Off
  
   return
   
   
; local gosubs
HighlighterDestroy:
;outputdebug, in destroy
   GuiNum := HighlighterGuiNum                                 ; set the starting guinum
   ; kill this highlighter
   Gui %GuiNum%: destroy
   GuiNum++
   Gui %GuiNum%: destroy
   GuiNum++
   Gui %GuiNum%: destroy
   GuiNum++
   Gui %GuiNum%: destroy

   HighlighterOnFlag := 0
return

}

