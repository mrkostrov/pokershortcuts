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
; Button Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



/*
ButtonClick()
   Purpose: Click the button.
            The software calls the function for the appropriate casino function (which reads the title bar)
   Requires:
            some casinos require that the table be visible
   Returns:
            nothing
   Parameters:
      ButtonName:  the name of the button (without the casino initials... e.g ButtonFold)
      WinId: window id
*/
ButtonClick(ButtonName,WinId)
{
   global
   local CasinoName, ButtonControlName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   ; get the control name
   ButtonControlName := %CasinoName%%ButtonName%ControlName


   ; if the button control name exists, then click it.
   if ButtonControlName
   {
;outputdebug, in button click by control click   ButtonControlName:%ButtonControlName%
      ControlClick, %ButtonControlName%, ahk_id%WinId%,,,,NA
   }
   ; else we have to click a position on the table
   else
   {
;outputdebug, in button click by mouse click   ButtonControlName:%ButtonControlName%
      MouseClickItemLocation(ButtonName,WinId)
;      MouseClickItemLocation(ButtonName,WinId)              ; (added 2nd instance version in 4.0030)  removed in ver 4.0032 because it was casuing a table under current table to also be clicked.
                
   }
}


/*   removed this by just checking the control name
FTButtonClick(ButtonName,WinId)
{
   local FullButtonName

   FullButtonName := FT%ButtonName%
   ControlClick, %FullButtonName%, ahk_id%WinId%,,,,NA
}


PSButtonClick(ButtonName,WinId)
{
   MouseClickItemLocation(ButtonName,WinId)
}
*/





/*
ButtonVisible()
   Purpose: Returns 1 if button is visible, else returns 0.
            This function used the ControlGet Visible feature of AHK if the Button Control Name exists in the theme files, else looks for one pixel, else it looks for the button text image
   Requires:
            some casinos require that the table be visible
   Returns:
      1 if button is visible
      0 if not visible
      -1 if our table is not on the top of the stack (and we can't see it)
      -1 if table is overlayed 
      -1 missing needed parameter from the .ini file
      -1 problem with the CasinoName

   Parameters:
      ButtonName:  the name of the button (without the casino initials... e.g ButtonFold)
      WinId: window id
*/
ButtonVisible(ButtonName,WinId)
{
   global
   local CasinoName, ButtonControlName, Flag, ButtonColor, ButtonW
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return -1

   ; get the control name
   ButtonControlName := %CasinoName%%ButtonName%ControlName          ; we check if the control name is present in the .ini files
   ButtonColor := %CasinoName%%ButtonName%Color                      ; we check if the color is present in the .ini files
   ButtonW := %CasinoName%%ButtonName%W                          ; we check if the width parameter is present in the .ini files

;outputdebug, in button visible  ButtonControlName=%ButtonControlName%

   ; if the button control name exists, then read it's visibility
   if ButtonControlName
   {
      ControlGet, Flag, Visible, , %ButtonControlName%, ahk_id%WinId%
      return Flag
   }
   else if ButtonColor
   {
      return ButtonColorVisible(ButtonName,WinId)
   }
   ; else we have to use image recognition
   else if ButtonW
   {
      return ButtonVisibleUsingImageRecognition(ButtonName,WinId)
   }
   
   ; we seem to have an invalid listing in the .ini file
   Debug(A_ThisFunc,"Missing parameters in the .ini file for this ButtonName: " . CasinoName . ButtonName)   
   return 0
}




/*
ButtonColorVisible()
   Purpose: Returns 1 if button color is visible (in one location).
   Requires:
            some casinos require that the table be visible
   Returns:
      1 if button color is visible
      0 if not visible 
      -1 if our table is not on the top of the stack (and we can't see it), 
      -1 if a color was not defined for this button in the .ini files

   Parameters:
      ButtonName:  the name of the button (without the casino initials... e.g ButtonFold)
      WinId: window id
      
   Notes:
      Only a few buttons have a color associated with them, so that we can check the presence of this one color to verify that the button is present   
*/
ButtonColorVisible(ButtonName,WinId)
{
   global
   local CasinoName, X, Y, ClientScaleFactor,Color,Delta,ColorTolerance

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return -1



   ; find the color of the button we are looking for
   Color := %CasinoName%%ButtonName%Color

   ; if the color is not defined, then continue
   if NOT Color
      return -1

   ; position of the Button
   X := %CasinoName%%ButtonName%X
   Y := %CasinoName%%ButtonName%Y
   
   ColorTolerance :=%CasinoName%%ButtonName%ColorTolerance

   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
      return -1

   ; look for check mark in +- 3 pixel area, but scale the size based on our current table size
   Delta := Round(3 * ClientScaleFactor)

;Outputdebug, check1   x=%X%  y=%Y%   cc=%CheckColor%   bc=%BackColor%   cn=%CasinoName%   cbn=%CheckboxName%  id=%WinId%  errorlevel=%Errorlevel%    color=%CheckColor%

   ; search for the color, return 1 if check is found
   CoordMode,Pixel,Screen

   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, Color ,ColorTolerance, Fast RGB
   If NOT Errorlevel
   {
;outputdebug, Found stars button color:%a_index%
      return 1
   }

   return 0

}



/*
ButtonVisibleUsingImageRecognition()
   Purpose: Returns 1 if button is visible.
            The function uses image recognition to see if the button is visible on the table
   Requires:
            some casinos require that the table be visible
   Returns:
      1 if button is visible
      0 if not visible
      -1 if our table is not on the top of the stack (and we can't see it)
      -1 if table is overlayed 
      -1 missing needed parameter from the .ini file
      -1 problem with the CasinoName
            
   Parameters:
      ButtonName:  the name of the button (without the casino initials... e.g ButtonFold)
      WinId: window id
      
   Note: we try the most likely table width, then the previous table width in the list, and then the next table width...
          just in case the user has a wxh table size (non standard table size)
*/
ButtonVisibleUsingImageRecognition(ButtonName,WinId)
{
   global
   local WindowX,WindowY,WindowW,WindowH,ClientW,ClientH,WindowTopBorder, WindowBottomBorder, WindowSideBorder
   local NumberOfTableWidths, TableWidth, PreviousTableWidth,NextTableWidth,FileName,PreviousFileName,NextFileName
   local X,Y,W,H,ClientScaleFactor,ColTol
   local CasinoName

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return -1


   ; now check the button using image recognition

   ; position of the Button
   X := %CasinoName%%ButtonName%X
   Y := %CasinoName%%ButtonName%Y

   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

   ; make sure that the table is visible at XY
   if WindowIsOverlayedAtXY(X,Y,WinId)
      return -1


   ; get the client width of this table
   WindowInfo(WindowX,WindowY,WindowW,WindowH,ClientW,ClientH,WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)

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
         return 0
   }

   FileName := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . TableWidth . "-" . ButtonName . ".bmp"
   PreviousFileName := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . PreviousTableWidth . "-" . ButtonName . ".bmp"
   NextFileName := "Themes\" . %CasinoName%TableTheme . "\ButtonImages\" . NextTableWidth . "-" . ButtonName . ".bmp"

   ; scale the width and height for our table size
   W := Round(%CasinoName%%ButtonName%W * ClientScaleFactor)
   H := Round(%CasinoName%%ButtonName%H * ClientScaleFactor)
   ColTol := %CasinoName%%ButtonName%ColorTolerance

;outputdebug, X=%X%  Y=%Y%   W=%W%   H=%H%   FileName=%FileName%   ButtonName=%ButtonName%
; if Buttonname
;if (ButtonName == "ButtonFold")
;{
;outputdebug, X=%X%  Y=%Y%   W=%W%   H=%H%   FileName=%FileName%   ColTol:%ColTol%
;}

   ; search for the image, return 1 if a match
   CoordMode,Pixel,Screen
   ImageSearch, foundx ,foundy,  X, Y, X + W , Y + H, *%ColTol% %FileName%
   If (!Errorlevel)
      return 1

   ImageSearch, foundx ,foundy,  X, Y, X + W , Y + H, *%ColTol% %PreviousFileName%
   If (!Errorlevel)
      return 1
      
   ImageSearch, foundx ,foundy,  X, Y, X + W , Y + H, *%ColTol% %NextFileName%
   If (!Errorlevel)
      return 1
      
   return 0

}










