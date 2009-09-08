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
; Mouse Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



/*
MouseClickItemLocation (30ms)
   Purpose:
      Click the mouse at X,Y in WinId
      Don't Know if the table must be visible for this to work ???????????????????????
   Returns:
      nothing
   Parameters:
      X - client area X
      Y - client area Y
      ByRef CasinoName (optional, finds it if it isn't given)
      ByRef WinId - window id (optional, uses active window if not specified)
*/
MouseClickItemLocation(ItemName,WinId)
{
   global
   local X,Y
   local ClientScaleFactor           ; not used but needed for fcn below
   local CasinoName, TempMouseX, TempMouseY, TempWinId

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return
      
      
   ; on FT tables for a few checkboxes, we need to change the name of the checkbox (since checkboxes can be on one of several positions on the table, depending on table type)
   ItemName := CheckboxChangeName(ItemName,WinId)

      

   ; get the particulars for the checkbox
;   X := %CasinoName%%ItemName%X + (%CasinoName%%ItemName%W / 2)
;   Y := %CasinoName%%ItemName%Y + (%CasinoName%%ItemName%H / 2)
   
   X := %CasinoName%%ItemName%X
   Y := %CasinoName%%ItemName%Y 
   
   
;outputdebug, here1  X=%X%   Y=%Y%   WinId=%WinId%
   
   ; if there is no data for X, then just return
   if ! X
   {
      Debug(A_ThisFunc, "There is no value in .ini file for " . CasinoName . ItemName . "X")
      return
   }
   
   

   if (CasinoName := "FT")
   {


   ; testing two methods of clicking a button on the table (depending on checkbox on the Misc tab...   Use mouse move method to click buttons)
   ; The mouse move method seems to work better for most users, but some users say that the mouse movement is slow, and causes interference with their play.
   ; Until a better method of clicking buttons on the full tilt table is found, I'll leave both methods in there.
   
   if UseMouseMovementToClickButtonsEnabled
   {
   
      ; now using the screen position with the CLICK command...  seems to be much more reliable on FT

      ; convert the x,y position to a Screen position
      WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)


      CoordMode, Mouse, Screen   


      Critical, On

      ; save the window that is active
      TempWinId := WinActive("A")
      ; get the current mouse position, so we can return to there later
      MouseGetPos, TempMouseX, TempMouseY
      
      ; for some reason if the Y screen position is negative, then you need to subtract 1 from it in order for the mouse to be moved back to the 
      ;     same spot on the screen
      if TempMouseY < 0
         TempMouseY := TempMouseY - 1
         

      Click %X% %Y%
      
      
      MouseMove, TempMouseX,TempMouseY,0
      WinActivate, ahk_id%TempWinId%

      Critical, Off    
   
   }
   else
   {
      ; else, don't move mouse to click buttons...   this method does not seem as reliable to me in clicking buttons (gary)

      ; convert the x,y position to a window position
      WindowScaledPos(X, Y, ClientScaleFactor, "Window", WinId)

      CoordMode, Mouse, Relative

;outputdebug, clicking mouse at window pos  X:%X%   Y:%Y%

      ;SetControlDelay -1                                         ; doesn't seem to help
      ;Critical, On                                               ; doesn't seem to help
      
      ControlClick, X%X% Y%Y%, ahk_id %WinId%, , , , NA Pos      ; this method was about 95% reliable... needed to call this fcn multiple times to make it reliable
      

   }

     
      
;outputdebug, here2  %CasinoName%   Screen positions X=%X%   Y=%Y%   

   }
   ; else it must be a PS tables
   else
   {
      ; This is the only reliable method that I have found for clicking on Poker Stars...   The ControlClick method only seems to work about 70% of the time.
      ;Here is a very fast method to click the mouse in the client area (.3ms).
      ;It works on PS, but it doesn't work on FT for some reason. So


      ; ### by JUK: Send the down left click, then the mouse-up messages. (only works for client area)
      ; mouse down command
      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId% 

      ; mouse up command
      PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%




   }

}


/* OLD VERSION
MouseClickItemLocation(ItemName,WinId)
{
   global
   local X,Y
   local ClientScaleFactor           ; not used but needed for fcn below
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return



   ; get the particulars for the checkbox
   X := %CasinoName%%ItemName%X
   Y := %CasinoName%%ItemName%Y



   ; if there is no data for X, then just return
   if ! X
   {
      Debug(A_ThisFunc, "There is no value in .ini file for " . CasinoName . ItemName . "X")
      return
   }
   ; convert the x,y position to a window position
   WindowScaledPos(X, Y, ClientScaleFactor, "Window", WinId)

   CoordMode, Mouse, Relative

;outputdebug, clicking mouse at window pos  X:%X%   Y:%Y%

   Critical, On
   ControlClick, X%X% Y%Y%, ahk_id %WinId%, , , , NA Pos

   ; if this is a button, click it again to see if we can solve the problem where Stars doesn't work with 1 click sometimes
   if instr(ItemName,"Button")
   {
      sleep, 30
      ControlClick, X%X% Y%Y%, ahk_id %WinId%, , , , NA Pos
   }
   ;   Click, %X% %Y%                                          ; this moves the mouse there, so don't use it


      ;Here is a very fast method to click the mouse in the client area (.3ms).
      ;It works on PS, but it doesn't work on FT for some reason. So
      ;I have decided not to use it

      ; ### JUK: Send the down left click, then the mouse-up messages. (only works for client area)
      ;PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
      ;PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%


}
*/



/*
MouseClickXYLocation
   Purpose:
      Click the mouse at X,Y (Client area position) in WinId
      Don't Know if the table must be visible for this to work ???????????????????????
   Returns:
      nothing
   Parameters:
      X - client area X
      Y - client area Y
      WinId - window id
*/
MouseClickXYLocation(X,Y,WinId)
{

   WinActivate, ahk_id%WinId%

   ; ### JUK: Send the down left click, then the mouse-up messages. (only works for client area)
   PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
   PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId% 



}


/*
MouseClickTimeButton
   Purpose:
      Click the time button in WinId
   Returns:
      nothing
   Parameters:

*/
MouseClickTimeButton(WinId)
{
   local ClientScaleFactor, CasinoName, X,Y


;   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
;      return
   
;   X := %CasinoName%ButtonTimeX
;   Y := %CasinoName%ButtonTimeY 

   ; convert the x,y position to a Window position
;   WindowScaledPos(X, Y, ClientScaleFactor, "Window", WinId)


;   CoordMode, Mouse, Relative   

   ControlClick, QWidget51, ahk_id%WinId%, , , 10 , NA 

}


