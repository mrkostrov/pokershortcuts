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
; Reload Functions
; -------------------------------------------------------------------------------
; *******************************************************************************




; -----------------------------------------------------------------------------------------------

; Reload chips (for manual reloads only)
ReloadChips(WinId="")
{

   ; local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
   %CasinoName%ReloadChips(WinId)
}


FTReloadChips(WinId)
{
 outputdebug here1
      ; Open the get chips window on this table pWinId
      ButtonClick("ButtonGetChips",WinId)

}

PSReloadChips(WinId)
{


      ; Open the get chips window on this table pWinId
      ButtonClick("ButtonOptions",WinId)
      
      ; wait til the Options window is active
      WinWait, ahk_group PSOptions ,, 2
      ifWinActive, ahk_group PSOptions
      {
         ControlClick, Button4, ahk_group PSOptions,,,,NA
      }

}


