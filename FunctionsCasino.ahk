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
; Casino Functions
; -------------------------------------------------------------------------------
; *******************************************************************************


/*
CasinoName()
   Purpose:
      Finds the casino name of this table
   Returns:
      "PS" or "FT" etc if casino is known
      "" if a casino type is know known
   Parameters:
      WinId - window id
   Globals:
      Sets  CasinoName%WinId% to the casino name
*/
CasinoName(WinId,ThisFunc)
{
   global
   
   if CasinoName%WinId%
      return CasinoName%WinId%

   ifWinExist, ahk_id%WinId% ahk_group FTWindow
   {
      CasinoName%WinId% := "FT"
      return "FT"
   }
   ifWinExist, ahk_id%WinId% ahk_group PSWindow
   {
      CasinoName%WinId% := "PS"
      return "PS"
   }
   Debug(ThisFunc,"Could not determine CasinoName for WinId: " . WinId)
   return ""
}