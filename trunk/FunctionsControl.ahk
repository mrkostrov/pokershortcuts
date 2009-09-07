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
; Control Functions
; -------------------------------------------------------------------------------
; *******************************************************************************
ControlVisible(ControlName,WinId)
{
   global
   local FullControlName, Flag
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0


   FullControlName := %CasinoName%%ControlName%ControlName
   
   ; if we have a valid control name
   if FullControlName
   {
      ; check if the control is visible
      ControlGet, Flag, Visible, , %FullControlName%, ahk_id%WinId%
;outputdebug, control visible:%Flag%    FullControlName:%FullControlName%     ControlName:%ControlName%    CasinoName:%CasinoName%
      return Flag
   }
   else
      return 0
}


ControlSetText2(ControlName, ControlText,  WinId)
{
   global
   local FullControlName
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   FullControlName := %CasinoName%%ControlName%ControlName

;outputdebug, CasinoName=%CasinoName%   ControlName=%ControlName%   FullControlName=%FullControlName%   WinId:%WinId%
   if FullControlName
      ControlSetText, %FullControlName%, %ControlText%, ahk_id%WinId%
}


ControlSetFocus(ControlName, WinId)
{
   global
   local FullControlName
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   FullControlName := %CasinoName%%ControlName%ControlName

   ; if we have a valid control name
   if FullControlName
      ControlFocus, %FullControlName%, ahk_id%WinId%
}


ControlGetText2(ControlName,  WinId)
{
   global
   local FullControlName, Text
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return ""

   FullControlName := %CasinoName%%ControlName%ControlName

   ; if we have a valid control name
   if FullControlName
   {   
      ControlGetText, Text, %FullControlName%, ahk_id%WinId%
      return Text
   }
}

