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
 
 
 WatchJoystick:
   WatchJoystick()
return


; determine what joystick is activated... only responds to the first one found in this order... POV, JoyZY, JoyZR, JoyUV
WatchJoystick()
{
   global
   local vJoy        ; which joystick value is active... = "" if none
   local vPovValue,vJoyXValue,vJoyYValue,vJoyZValue,vJoyRValue,vJoyUValue,vJoyVValue
   local vJoyChanged
   local vPos, vGosub, vButtonState, vTime
   local vTemp,vJoystickFoundFlag

   static vJoyPrevious = ""

;outputdebug, joynum=%JoyNum%

;vTime := A_TickCount

   ; check if all features are disabled
   if (NOT AllHotkeysEnabled)
      return


   ; do a quick check to see that some button is visible to the system...
   vJoystickFoundFlag := 0
   loop, 10
   {
      GetKeyState, vButtonState, %JoyNum%Joy%a_index%
      if vButtonState
      {
         vJoystickFoundFlag := 1
         break
      }
   }

   if ! vJoystickFoundFlag
   {
      vTemp := JoyNum
      ; turn off the joystick
      JoyNum := 0
      
      SetTimer, WatchJoystick, Off
      
      Gui, 99:Default
      GuiControl, ChooseString, JoyNum, % JoyNum
      SettingsUpdateHotkeys(-1)

      MsgBox,4096,, Joystick %vTemp% was not found... The joystick has been disabled on the Misc tab.,30
      return

   }




   GetKeyState, vPovValue, %JoyNum%JoyPOV
   GetKeyState, vJoyXValue, %JoyNum%JoyX
   GetKeyState, vJoyYValue, %JoyNum%JoyY
   GetKeyState, vJoyZValue, %JoyNum%JoyZ
   GetKeyState, vJoyRValue, %JoyNum%JoyR
   GetKeyState, vJoyUValue, %JoyNum%JoyU
   GetKeyState, vJoyVValue, %JoyNum%JoyV


;outputdebug, %vJoyXValue%    %vJoyYValue%    %vJoyZValue%    %vJoyRValue%

   ; if we aren't performing a GOSUB if a joystick is pushed, then also check the JOY1-32 and return these if pushed
   ; this is used for debugging
   vJoy := ""


   ; check if any of the joystick buttons are pushed
   loop, 32
   {
      GetKeyState, vButtonState, %JoyNum%Joy%a_index%
      if (vButtonState == "D")
      {
         vJoy := "JOY" . a_index
      }
   }


   ; if we have a vJoy value already, then do nothing in all of the following if statements, cuz we already have a vJoy from above
   if vJoy
   {
   }
   ; convert a continuous POV into a discrete value
   else if (vPovValue <> -1 )
   {
      If (vPovValue > 33750) OR (vPovValue < 2250)
         vJoy := "JOYPOV0"
      Else If (vPovValue < 6750)
         vJoy := "JOYPOV45"
      Else If (vPovValue < 11250)
         vJoy := "JOYPOV90"
      Else If (vPovValue < 15750)
         vJoy := "JOYPOV135"
      Else If (vPovValue < 20250)
         vJoy := "JOYPOV180"
      Else If (vPovValue < 24750)
         vJoy := "JOYPOV225"
      Else If (vPovValue < 29250)
         vJoy := "JOYPOV270"
      Else If (vPovValue < 33750)
         vJoy := "JOYPOV315"
   }
   ; else check of JoyXY is activated
   Else If ((vJoyXValue > 30) AND (vJoyXValue < 70 ) AND (vJoyYValue > 90))
      vJoy := "JOYXY180"
   Else If ((vJoyXValue > 30) AND (vJoyXValue < 70 ) AND (vJoyYValue < 10))
      vJoy := "JOYXY0"
   Else If ((vJoyYValue > 30) AND (vJoyYValue < 70 ) AND (vJoyXValue > 90))
      vJoy := "JOYXY90"
   Else If ((vJoyYValue > 30) AND (vJoyYValue < 70 ) AND (vJoyXValue < 10))
      vJoy := "JOYXY270"
   ; else check of JoyZR is activated
   Else If      ((vJoyZValue > 30) AND (vJoyZValue < 70 ) AND (vJoyRValue > 90))
      vJoy := "JOYZR180"
   Else If ((vJoyZValue > 30) AND (vJoyZValue < 70 ) AND (vJoyRValue < 10))
      vJoy := "JOYZR0"
   Else If ((vJoyRValue > 30) AND (vJoyRValue < 70 ) AND (vJoyZValue > 90))
      vJoy := "JOYZR90"
   Else If ((vJoyRValue > 30) AND (vJoyRValue < 70 ) AND (vJoyZValue < 10))
      vJoy := "JOYZR270"
   ; else check of JoyUV is activated
   Else If      ((vJoyZValue > 30) AND (vJoyZValue < 70 ) AND (vJoyRValue > 90))
      vJoy := "JOYUV180"
   Else If ((vJoyZValue > 30) AND (vJoyZValue < 70 ) AND (vJoyRValue < 10))
      vJoy := "JOYUV0"
   Else If ((vJoyRValue > 30) AND (vJoyRValue < 70 ) AND (vJoyZValue > 90))
      vJoy := "JOYUV90"
   Else If ((vJoyRValue > 30) AND (vJoyRValue < 70 ) AND (vJoyZValue < 10))
      vJoy := "JOYUV270"

   vJoyChanged   := iif((vJoyPrevious <> vJoy),1,0)

   vJoyPrevious := vJoy

   ; if the vJoy has changed, then perform task
   if ((vJoyChanged) AND (vJoy <> ""))
   {
;outputdebug, vJoy=%vJoy%
      ; save the current time, as a joystick command has happened... this is needed for user activity timeouts
      LastJoystickActivityTime := A_TickCount

      ; we don't use this code for the JOY1-JOY32 buttons, because AutoHotkey takes care of those buttons.
      ; but we need to filter them out here, so we don't do them with this code (else the function will be done twice...
      ; once by autohotkey and once here)
      ; get the 4th character of vJoy, and if it is a number then we are dealing with one of the buttons)
      ;     if it is not a number, then it must be the POV or the analog stick that we do need to deal with this joystick operations
      vTemp := SubStr(vJoy, 4 ,1)
      if vTemp is not number
      {

         ; only perform these operations if a FT table is active
         IfWinActive, ahk_group Tables
         {
            ; if the current Joystick is in our hotkey list, then perform the gosub from the gosub list
            vPos := ListGetPos(JoystickHotkeyList,vJoy)
            if vPos
            {
               ; get the gosub we should call
               vGosub := ListGetItem(JoystickGosubList,vPos)

               ; call the gosub
               Gosub, %vGosub%
            }
         }

      }

   }


   ; show joyvalue if this feature is active
   if (ShowJoystickValueEnabled)
   {
         Gui, 99:Default
         GuiControl,, JoystickValue, %vJoy%
   }

;vTime := A_TickCount - vTime
;outputdebug, time=%vTime%
}