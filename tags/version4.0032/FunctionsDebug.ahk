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
; Debug Functions
; -------------------------------------------------------------------------------
; *******************************************************************************



Debug(Function,Message)
{
   outputdebug, ***** Message from function:%Function%  *****%Message%

}



DisplayDebugTooltip()
{
   global         ; need some global constants
   local TitleBarHeight,  CXEDGE, CYEDGE, CXSIZEFRAME, CYSIZEFRAME
   local WindowBottomBorder, WindowSideBorder, WindowTopBorder ,WindowX,WindowY,WindowW,WindowH
   local ClientWidth, ClientHeight , ClientWidthScaleFactor, ClientHeightScaleFactor
   local MousePosStandardClientX, MousePosStandardClientY, MousePosClientX, MousePosClientY
   local MouseX, MouseY,ControlName, MouseColor, BigBlind, SmallBlind, Ante
   local WinId, CasinoName, MouseWinId, Class
   local DigitType, TableTheme


   local TimerBefore, TimerAfter, TimerFrequency
   
   local HeroStack,HeroStackTime
   local TablePot,TablePotTime
   local TableCall,TableCallTime
   local TableSeats,TableSeatsTime
   local TablePlayers,TablePlayersTime
   local TableBigBlind,TableBigBlindTime
   local TableSmallBlind
   local TableAnte
   local TableRingOrTournament,TableRingOrTournamentTime
   local TableStreet,TableStreetTime
   local HeroSeated,HeroSeatedTime
   
   local ButtonFold,ButtonFoldTime
   local ButtonImBack,ButtonImBackTime
   local ButtonCall,ButtonCallTime
   local ButtonCall2,ButtonCall2Time
   local ButtonCheck,ButtonCheckTime
   local ButtonWaitForBigBlind,ButtonWaitForBigBlindTime
   local ButtonPostBigBlind,ButtonPostBigBlindTime
   local ButtonPostSmallBlind,ButtonPostSmallBlindTime
   local ButtonSitout,ButtonSitoutTime
   local ButtonDealMeIn,ButtonDealMeInTime
   local ButtonTime,ButtonTimeTime
   local ButtonImReady, ButtonImReadyTime
   
   local CheckboxSitOutNextHand, CheckboxSitOutNextHandTime
   local CheckboxAutoPostBlinds, CheckboxAutoPostBlindsTime
   local CheckboxFoldToAnyBet, CheckboxFoldToAnyBetTime
   local CheckboxFold, CheckboxFoldTime
   
   local ActionPending, ActionPendingTime
   
   

   IfWinNotActive, ahk_group Tables
      return






   WinId := WinActive("A")

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return

   TableTheme := %CasinoName%TableTheme

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

   CoordMode, Mouse, Relative
   MouseGetPos, MouseX, MouseY,MouseWinId,ControlName,1
   ; ControlGetPos, ControlX,ControlY,ControlW,ControlH,%ControlName%,ahk_id%WinId%
   CoordMode, Pixel, relative
   PixelGetColor, MouseColor,MouseX,MouseY,RGB
   
   



   WinGetClass, Class, ahk_id%MouseWinId%
   
   

   ; calc the Client area in this window (window - borders)
   ClientWidth := WindowW - 2 * WindowSideBorder
   ClientHeight := WindowH - TitleBarHeight - 2 * WindowBottomBorder

   ; calculate the current Client area scale factors   FTStandardClientWidth
   ClientWidthScaleFactor := ClientWidth / %CasinoName%StandardClientWidth
   ClientHeightScaleFactor := ClientHeight / %CasinoName%StandardClientHeight

   MousePosScreenX := WindowX + MouseX
   MousePosScreenY := WindowY + MouseY

   MousePosClientX := MouseX - WindowBottomBorder
   MousePosClientY := MouseY - TitleBarHeight - WindowBottomBorder

   ; what would the mouse position be on a Standard Client Position
   MousePosStandardClientX := Round(MousePosClientX / ClientWidthScaleFactor)
   MousePosStandardClientY := Round(MousePosClientY / ClientHeightScaleFactor)

   ControlPosClientX := ControlX - WindowBottomBorder
   ControlPosClientY := ControlY - TitleBarHeight - WindowBottomBorder

   DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)


   ; MISC  TABLE ITEMS   **************************************************************


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         HeroStack := HeroStack(WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   HeroStackTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         TablePot := TablePot(WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TablePotTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off



   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TableCall := TableCall( WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TableCallTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TableSeats := TableSeats(WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TableSeatsTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TablePlayers := TablePlayers( WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TablePlayersTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TableBlinds(WinId)
         TableBigBlind := BigBlind%WinId%
         TableSmallBlind := SmallBlind%WinId%
         TableAnte := Ante%WinId%
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TableBigBlindTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TableRingOrTournament := TableRingOrTournament( WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TableRingOrTournamentTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         TableStreet := TableStreet( WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   TableStreetTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         HeroSeated := HeroSeated( WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   HeroSeatedTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off


   ;  BUTTONS   *****************************


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonFold := ButtonVisible("ButtonFold",  WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonFoldTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonCall := ButtonVisible("ButtonCall",  WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonCallTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         if (CasinoName == "PS")
            ButtonCall2 := ButtonVisible("ButtonCall2",  WinId)
         else
            ButtonCall2 := 0   
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonCall2Time := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonCheck := ButtonVisible("ButtonCheck",  WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonCheckTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonWaitForBigBlind := ButtonVisibleUsingImageRecognition("ButtonWaitForBigBlind", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonWaitForBigBlindTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonPostBigBlind := ButtonVisibleUsingImageRecognition("ButtonPostBigBlind", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonPostBigBlindTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonPostSmallBlind := ButtonVisibleUsingImageRecognition("ButtonPostSmallBlind", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonPostSmallBlindTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonSitout := ButtonVisibleUsingImageRecognition("ButtonSitOut", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonSitoutTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonDealMeIn := ButtonVisibleUsingImageRecognition("ButtonDealMeIn", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonDealMeInTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off


   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonTime := ButtonVisible("ButtonTime", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonTimeTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonImBack := ButtonVisible("ButtonImback", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonImBackTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off   
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         ButtonImReady := ButtonVisible("ButtonImReady", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   ButtonImReadyTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off     
   
   
   ;   CHECKBOXES   *************************************
   
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         CheckboxSitOutNextHand := CheckboxGetState("CheckboxSitOutNextHand", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   CheckboxSitOutNextHandTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off   
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         CheckboxAutoPostBlinds := CheckboxGetState("CheckboxAutoPostBlinds", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   CheckboxAutoPostBlindsTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off    
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         CheckboxFoldToAnyBet := CheckboxGetState("CheckboxFoldToAnyBet", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   CheckboxFoldToAnyBetTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off    

   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         CheckboxFold := CheckboxGetState("CheckboxFold", WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   CheckboxFoldTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off       
   
   critical, on
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)
         ;DigitsByImageRecognition(X, Y, W, H, Prefix, Ext, Shades, AltImagesFlag, ByRef CasinoName = "", ByRef WinId="")
         PendingAction := TablePendingAction(WinId)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
   PendingActionTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
   critical, off       
  
   

   coordmode, tooltip,screen
   ToolTip,
   (LTrim Join
   Poker Shortcuts Debug Display`n
   (Disable this display on the Displays tab)`n
   PSC Version: %Ver%`n
   ----- TABLE INFORMATION`n
   TableID  id=%WinId%`n
   TableTheme: %TableTheme%`n
   Control Name: %ControlName%`n
   Class Name: %Class%`n`n
   Borders(top,side): %TitleBarHeight%,%WindowBottomBorder%`n`n

   ClientAreaSize: %ClientWidth%, %ClientHeight%`n
   WindowSize: %WindowW%, %WindowH%`n`n

   **** COLOR under mouse: %MouseColor%`n
   **** MousePosStandard(Client): %MousePosStandardClientX%, %MousePosStandardClientY%`n`n
   *   
   MousePos(Client):    %MousePosClientX%, %MousePosClientY%`n
   MousePos(Window): %MouseX%, %MouseY%`n
   MousePos(Screen):  %MousePosScreenX%, %MousePosScreenY%`n
   ----- MAIN STATUS`n
   Stack: %HeroStack%           timer=%HeroStackTime%`n
   Pot: %TablePot%           timer=%TablePotTime%`n
   Call: %TableCall%            timer=%TableCallTime%`n`n
   Table Seats: %TableSeats%    timer=%TableSeatsTime%`n
   Table Players: %TablePlayers%    timer=%TablePlayersTime%`n
   BB:%TableBigBlind%  SB:%TableSmallBlind%  Ante:%TableAnte%   timer=%TableBigBlindTime%`n
   RingOrTournament(=1 if Ring): %TableRingOrTournament%     timer=%TableRingOrTournamentTime%`n
   Street: %TableStreet%         timer=%TableStreetTime%`n
   Hero Seated (=1 if seated): %HeroSeated%     timer=%HeroSeatedTime%`n
   PendingAction: %PendingAction%   timer=%PendingActionTime%`n
   ***** BUTTONS (1=present  0=not pres  -1=overlayed)`n
   Fold Button: %ButtonFold%     timer=%ButtonFoldTime%`n
   Check Button: %ButtonCheck%     timer=%ButtonCheckTime%`n   
   Call Button (middle): %ButtonCall%     timer=%ButtonCallTime%`n
   Call Button (right): %ButtonCall2%     timer=%ButtonCall2Time%`n
   Post BB Button: %ButtonPostBigBlind%     timer=%ButtonPostBigBlindTime%`n
   Post SB Button: %ButtonPostSmallBlind%     timer=%ButtonPostSmallBlindTime%`n
   Wait For BB Button: %ButtonWaitForBigBlind%     timer=%ButtonWaitForBigBlindTime%`n
   Sit Out Button: %ButtonSitout%     timer=%ButtonSitoutTime%`n
   Deal Me In Button: %ButtonDealMeIn%     timer=%ButtonDealMeInTime%`n
   I'm Back Button: %ButtonImBack%     timer=%ButtonImBackTime%`n
   I'm Ready Button: %ButtonImReady%     timer=%ButtonImReadyTime%`n   
   Time Button: %ButtonTime%     timer=%ButtonTimeTime%`n
   ***** CHECKBOXES  (0=not checked  `n
   .      1=checked  -1=not visible)`n
   Sit Out Next Hand: %CheckboxSitOutNextHand%     timer=%CheckboxSitOutNextHandTime% `n
   Auto Post Blinds: %CheckboxAutoPostBlinds%     timer=%CheckboxAutoPostBlindsTime%  `n
   Fold To Any Bet: %CheckboxFoldToAnyBet%     timer=%CheckboxFoldToAnyBetTime%`n
   Fold: %CheckboxFold%     timer=%CheckboxFoldTime%`n  
   ), %DebugTooltipPosX% ,%DebugTooltipPosY%, 9


/*

   Check Button: %ButtonCheck%     timer=%ButtonCheckTime%`n


   `n TableIDPendingList: %TableIDPendingList%`n
   TableNamePendingList: %TableNamePendingList%`n        ; if you use this, need to add the code in the timerfast routine where the pending list is updated.

   ***** LISTS:`n
   TableIDPendingList: %TableIDPendingList%`n
   SngPendingLobbyIdList: %SngPendingLobbyIdList%`n
   SngPendingTourneyNumList: %SngPendingTourneyNumList%`n
   Osd3GuiNumList: %Osd3GuiNumList%`n
   Osd4GuiNumList: %Osd4GuiNumList%`n
   TableCloseIdList: %TableCloseIdList%`n
   TableOpenIdList: %TableOpenIdList%`n
   PendingActionForTimeButtonIdList: %PendingActionForTimeButtonIdList%`n
   TimeButtonIdList: %TimeButtonIdList%`n


   MouseDigits: %Test3%     timer=%TimerTest3%`n
   MouseString: %Test4%`n`n


   DisplayOsd3TableIdList := ""                    ; list of tables displaying OSD3
   DisplayOsd3GuiNumList := ""                     ; guinum for this displays
   DisplayOsd3PosXList := ""                       ; last pos X of the display on the table
   DisplayOsd3PosYList := ""                       ; last pos Y of the display on the table
   DisplayOsd3ListList := ""                       ; last displayed text of the display on the table
   DisplayOsd3ThemeList := ""                      ; last theme of the display on the table
   DisplayOsd3StackList := ""                      ; last hero stack size



   DisplayOsd4TableIdList := ""                    ; list of tables displaying OSD3
   DisplayOsd4GuiNumList := ""                     ; guinum for this displays
   DisplayOsd4PosXList := ""                       ; last pos X of the display on the table
   DisplayOsd4PosYList := ""                       ; last pos Y of the display on the table
   DisplayOsd4ListList := ""                       ; last displayed text of the display on the table
   DisplayOsd4ThemeList := ""                      ; last theme of the display on the table
   DisplayOsd4StackList := ""                      ; last hero stack size

*/




}
