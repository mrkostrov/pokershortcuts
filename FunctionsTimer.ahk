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
 
 ; ***************************************************************************************
; ---------------------------------------------------------------------------------------
; Timer Functions
; ---------------------------------------------------------------------------------------
; ***************************************************************************************

; timer fast (more frequent timer), for items that need to be checked often

; takes about 10ms is table is active and nothing to do
; takes 150ms if the software needs to activate a table the mouse is over (only one time until the table is activated)

TimerFast()
{
   global
   
local WinId, TableRingOrTournament, ImBackButtonFlag, Position, MouseAndShiftKeysAreUpFlag
local ActiveTableIsOverlayedFlag, ActionPendingFlag, ActionPendingOnMouseTableFlag, TopTableUserBusyFlag
local MouseMovedFlag, UserBusyFlag, MouseOverTableId
local MousePosX, MousePosY
local TX, TY, ClientScaleFactor, MoveTableHeight
local TableWDivHFactor, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder
local CasinoName, PreviousBatchLines

static OldMousePosX = 0
static OldMousePosY = 0
static LastStreet := ""
;static UpdatePresetBetFlag := 1                      ; made this global in ver 4.0014

Static MoveTableFlag := 0
Static MoveTableId := 0
static MoveTableOrigPosX := 0
static MoveTableOrigPosY := 0
static MoveTableOrigWidth := 0
static MoveTableOrigHeight := 0
static LastActiveTableWinId := 0             ; previously active table WinId


;critical, On

   ; save the current batch lines to restore it later
;   PreviousBatchLines = %A_BatchLines%
   ; set the speed to maximum
;   SetBatchLines -1



/*
Mouse Moves should usually be relative to the screen.  If relative to window, then a Stars table can pop up (and activated) and this will cause
a mouse move to move relative to the active table, which could be the Stars table that just poped up.
*/



;return

   local TimerFrequency, TimerBefore, TimerAfter, TotalTime
   DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)


;Critical, On


   ; if Hotkeys are suspended, then display tooltip and return
   if (NOT AllHotkeysEnabled)
   {
      IfWinActive, ahk_group Tables
      {
         ToolTip, * * * *   Poker Shortcuts is disabled   * * * *, 5 , 6, 10
         return
      }
      else
      {
         ToolTip,,,,10
         return
      }
   }
   else
      ToolTip,,,,10
      
      
   ; check if mouse is in the chat area to disable action keys and need to display or remove the mouse chat warning
   DisplayChatWarning()
      
   ; if the mouse is in the chat area, then just return...   we don't want to disrupt the user
   ;if TableIsMouseInChat()
   ;   return
      
   MouseNotInChatFlag := NOT TableIsMouseInChat()
      
      
   ; In ver 4.0019 I moved these dialog functions from TimerSlow to here.
   ;        The QWidget dialog boxes would constantly be brought to the front and activated by full tilt... this happened instantly.
   ;        So in this timerfast function, the software would activate the table repeatedly (that the mouse was over, if enabled to auto activate).   
   ;        This takes about 100ms for the table to activate, so TimerFast was always running, and didn't give the other timers time to run,
   ;        if I kept the timerfast interval at 150ms. 
      
   ; *****************************************************************
   ;     CHECK IF THERE ARE ANY OPEN DIALOG BOXES WE NEED TO SERVICE
   ; *****************************************************************
   ;make a list of all the open dialog boxes IDs
   ;WinGet puts the count in the variable DialogIdList,
   WinGet, DialogIdList, List, ahk_group Dialogs
   ; loop thru all of these dialog boxes and see if we need to operate on any of them


   Loop, %DialogIdList%
   {

   
      ; find the next ID of the next open dialog box
      StringTrimRight, WinId, DialogIdList%A_Index%, 0

      ; if it is a FT notes dialog box, then ignore it
      IfWinExist, ahk_id%WinId% ahk_group Notes
         continue
         
      ; if it is in the InvalidDialogWidthIdList, then we already marked it as invalid
      if (ListGetPos(InvalidDialogWidthIdList,WinId))
         continue

;junko1 := DialogIdList%A_Index%
;WinGetTitle, junko, ahk_id%junko1%
;outputdebug, Dialog found   DialogId:%junko1%    Title:%junko%

      ; try to close this dialog box
      DialogClose(WinId)

   }
   
;outputdebug, timerslow4      
   ; QWidget type of dialog boxes
   ; *****************************************************************
   ;     CHECK IF THERE ARE ANY OPEN DIALOG BOXES WE NEED TO SERVICE
   ; *****************************************************************
   ;make a list of all the open dialog boxes IDs
   ;WinGet puts the count in the variable DialogIdList,
   WinGet, DialogIdList, List, ahk_group QWidgetDialogs
   ; loop thru all of these dialog boxes and see if we need to operate on any of them


   Loop, %DialogIdList%
   {

;outputdebug, found qwidget dialog      
      ; find the next ID of the next open dialog box
      StringTrimRight, WinId, DialogIdList%A_Index%, 0

      ; if it is in the InvalidDialogWidthIdList, then we already marked it as invalid
      if (ListGetPos(InvalidDialogWidthIdList,WinId))
         continue

;junko1 := DialogIdList%A_Index%
;WinGetTitle, junko, ahk_id%junko1%
;outputdebug, Dialog found   DialogId:%junko1%    Title:%junko%

      ; try to close this dialog box
      DialogCloseQWidget(WinId)

   }      
      
      


   ; for all existing tables
   ; TASKS are
   ;        NO MORE- MOVED TO TIMER MEDIUM:  time button, if enabled click the time button if visible and time has elapsed
   ;        NO MORE- MOVED TO TIMER MEDIUM:  i'm back button, if enabled and button visible and in tournament... click the buutton
   ;        pending action list update (add and remove)
   IfWinExist, ahk_group Tables
   {
;outputdebug, table exists
      ;make a list of all the open table IDs, excluding Lobby
      ;WinGet puts the table count in the variable TableIdArray,
      WinGet, TableIdArray, List, ahk_group Tables

      ; loop through all of the open tables to see if we need to do anything with them
      Loop, %TableIdArray%
      {

         ; find the next ID of the next FTP table
         WinId := TableIdArray%A_Index%
         

         ; auto-click the time button if needed
         TimeButtonCheck(WinId)         


/*

         ; auto-click the time button if needed
         TimeButtonCheck(WinId)
         
         ; THIS IS A PRETTY SLOW TEST....   SHOULD IT BE IN TIMER MEDIUM ?????????????????????????????????
         ; check if the ImBack button is visible on this table - DOES NOT WORK ON STARS TABLES IF THE TABLES ARE STACKED/CASCADED
         ; Note: there is a test in the TimerSlow() function to check the hand history to see if the player has timed out.. then the I'm back button is clicked (for Poker stars)
         ; click the ImBack button IF
         ;     it is visible
         ;     AND this is a tournament
         ;     AND AutoClickImBackButtonEnabled is true,
         ;     and if the user has been active with mouse or keyboard recently
         if (AutoClickImBackButtonEnabled AND ( NOT TableRingOrTournament(WinId)) AND  (UserTimeIdlePhysical < AutoClickImBackFailSafeTime))
         {
            if (ButtonVisible("ButtonImBack",WinId) == 1)
               ButtonClick("ButtonImBack",WinId)
         }
*/
         ; check if the fold button is visible on this table
         UserBusyFlag := TablePendingAction(WinId)


         ; check if this table needs to be on the Pending table list
         ; get the position of this table in the pending table list
         Position := ListGetPos(TableIDPendingList,WinId)

;outputdebug, in add to pending list   fold:%UserBusyFlag%  Position:%Position%

         if UserBusyFlag
         {
            ; if table is not on the list, then add it to the list
            if NOT Position
            {
               ListAddItem(TableIDPendingList,WinId)
               ListAddItem(TableIDPendingTimeList,A_TickCount)
;               ListAddItem(TableNamePendingList,TableNameOrNumber(WinId))                         ; ??????????????????????????????????????????  remove after done with debug
            }
         }
         ; else remove the table from the list (if it is on the list), since there is no pending action
         ;     NOTE: items also get removed from the list in the TablePending() function.   NOT ANYMORE after version 4.0014
         else
         {
            ; if it is on the list, then remove it
            if Position
            {
               ListDelPos(TableIDPendingList,Position)
               ListDelPos(TableIDPendingTimeList,Position)
;               ListDelPos(TableNamePendingList,Position)                         ; ??????????????????????????????????????????  remove after done with debug
            }
         }
      }
   }


;outputdebug, list:%TableIDPendingList%




   ; check that the user has us enabled
   MouseAndShiftKeysAreUpFlag :=  ! KeyPressedInList(KeyListToDisableShortcuts)


   ; see if we should move the Moved table back to where it came from.
   ; IF MoveTableFlag is true (we have a moved table)
   ;     AND the user is not busy on the moved table
   ;     AND there is pending action on another table
   ;     AND we are not disabled (shift or mouse held down)
   ;     AND mouse is NOT in chat area
   ; THEN
   ;     move the table back to where it was before
   if (MoveTableFlag AND MouseAndShiftKeysAreUpFlag AND MouseNotInChatFlag)
   {

      ; does any table have pending action on it??
      ActionPendingFlag := ListLength(TableIDPendingList)
      ; is the user busy on the moved table ??
      UserBusyFlag := TablePendingAction(MoveTableId)

      if ((NOT UserBusyFlag) AND (ActionPendingFlag))
      {
;outputdebug, move back to    %MoveTableId%      %vMoveTableOrigPosX%     %vMoveTableOrigPosY%     %vMoveTableOrigWidth%    %vMoveTableOrigHeight%
         WinHide, ahk_id%MoveTableId%
      	DetectHiddenWindows, on ; brad
         WinMove, ahk_id%MoveTableId%,,MoveTableOrigPosX,MoveTableOrigPosY,MoveTableOrigWidth,MoveTableOrigHeight
         WinShow, ahk_id%MoveTableId%
         
         Sleep, -1
         ; this magic command re-paints Poker Stars tables so that they are resized correctly
         ControlSend, , {F5}, ahk_id%WinId%
         


         if NOT (CasinoName := CasinoName(MoveTableId,A_ThisFunc))
            return

         if (MouseToHomeEnabled)
         {

            ; move the mouse
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",MoveTableId)
            CoordMode, Mouse, Screen
            ;if !(GetKeyState("LButton", "P") OR GetKeyState("RButton", "P") OR GetKeyState("LShift", "P") OR GetKeyState("RShift", "P"))
   
            MouseMove,TX,Ty,0
         }
         
         
         ; turn off the displays from the moved table, and turn them on in the original position
         DisplayOSD3(MoveTableId)
         DisplayOSD4(MoveTableId)
         MoveTableFlag := 0
         
         ; take this table off the moved table list
         ListDelItem(MovedTableIdList,MoveTableId)
      }
   }



   ; check if the mouse has moved since the last time this timer function ran
   ; get the win id of the window that the mouse is over
   CoordMode, Mouse, Screen
   MouseGetPos, MousePosX, MousePosY , MouseOverTableId
   if (  (abs(MousePosX - OldMousePosX) > MinMouseMovement) OR  (abs(MousePosY - OldMousePosY) > MinMouseMovement) )
   {
      MouseMovedFlag := 1
   }
   else
   {
      MouseMovedFlag := 0
   }
   OldMousePosX := MousePosX
   OldMousePosY := MousePosY


   ; if the mouse is NOT over a table, reset this id to 0 (as we use it as a flag below)
   ifWinNotExist, ahk_id%MouseOverTableId% ahk_group Tables
      MouseOverTableId := 0

   
   ; we turn on critical for a short section of code just so that
;   Critical, On



   ; get the id of the active table
   WinId := WinActive("ahk_group Tables")


   ; check if we have an active table
   if WinId
   {
      ; check if the fold button is visible on the Active table,
      UserBusyFlag := TablePendingAction(WinId)
      ; check if our active table is overlayed
      ActiveTableIsOverlayedFlag := WindowIsOverlayed(WinId)
   }
   else
   {
      UserBusyFlag := 0
      ActiveTableIsOverlayedFlag := 0
   }
   
   
   ; check if action is pending on the table the mouse is over
   if (MouseOverTableId AND TablePendingAction(MouseOverTableId))
      ActionPendingOnMouseTableFlag := 1
   else
      ActionPendingOnMouseTableFlag := 0
      
   ; check if our active table is overlayed
;   ActiveTableIsOverlayedFlag := WindowIsOverlayed(WinId)
      
   
   ; WHY IS THIS HERE?   IT ACTIVATES A TABLE THE MOUSE IS OVER REGARDLESS ?????????????????????????????????????????????????????????????
/*
   ; if the mouse is over a table, BUT no table is active, then activate the table the mouse is over
   if NOT WinId
   {
      WinActivate, ahk_id%MouseOverTableId%  ahk_group Tables
      WinId := WinActive("ahk_group Tables")
   }
*/


      

   ; Continue on in this code IF
   ;        A table is active OR the mouse is over a table
   ;        and the user isn't holding down the shift key or a mouse button
   ;        and the mouse is NOT in chat area
   If ((WinId OR MouseOverTableId) AND MouseAndShiftKeysAreUpFlag AND MouseNotInChatFlag)
   {
;outputdebug, here1
      ; auto-activate tables with pending action IF
      ;        AutoActivateNextPendingTableEnabled
      ;        and mouse is not moving
      ;        and the mouse is over a table
      if (AutoActivateNextPendingTableEnabled AND (NOT MouseMovedFlag) AND MouseOverTableId)
      {
      
      
         ; create a loop, just so that we can break out of it easily
         Loop, 1
         {
         
         
            ; NOTE:  Full Tilt's  "Display Table On Action" will pop a table to the top if covered by another application window (like word);
            ;           Even if this option is Off, FT will still bring a new table with pending action to the top (but it doesn't activate it).
            ;        Sometimes FT has a different queue than we have with our table pending.  So FT will pop a table to the top, and then we pop a different one
            ;           with our table pending routine. This seems to cause some problems as we might pop a table pending table, then FT pops one while we are
            ;           reading the pot size or something, and then we get the wrong answer for the pot.
            ;        NOT SURE HOW TO SOLVE THIS YET ?????????????????????????????
            
            ; NOTE:  Stars pops a table to the top and activates the table too.
         
         
         
            ; In these next 2 blocks, we want to detect tables that are currently waiting for the user to respond to pending action.
            ; We will just return, if that is the case.
            ; Additionally, we will do a few things to make sure that this pending table is brought to the top of the stack, or re-activate it,
            ; in case one of the poker sites pops one of their own tables to the top, and potentially covers the table we were dealing with.
         
         
            ; Do nothing if
            ;     ActionPendingOnMouseTableFlag
            ;     and (WinId == LastActiveTableWinId)
            ;     and (WinId == MouseOverTableId)
            ; then break
            ; This is used most often when we have pending action on the table and we are waiting for the user to act.
            ; IF active table is also overlayed, then bring to top
            ;        this bring to top is needed when FT brings a table to the top (without activating it)  and it partially covers a pending stars table that we were on
            ;              this shouldn't happen if we have seperate stacks of tables... i.e. FT in one stack, and PS in another
            ; See below, where we handle the case where the FT table pops on top of the active table with pending action, and it prevents us from detecting if active table has pending action on it.

            if (ActionPendingOnMouseTableFlag AND (WinId == LastActiveTableWinId) AND (WinId == MouseOverTableId) )
            {
               if ActiveTableIsOverlayedFlag
;outputdebug, Our table got covered by something...  we are re-popping it to the top of the stack.
                  WinSet, Top,,ahk_id%WinId%
               break
            }

            ; Re-Activate the table the mouse is over and exit IF
            ;        the mouse is over a table with pending action
            ;        and the mouse table is NOT active (some other table is active)
            ;        and the last active table is the same as the table our mouse is over(which is where we were last active)
            ; This is useful when Stars activates a table, but we already have action pending on the table the mouse is over, so we re-activate the table the mouse is over
            ; This might be useful if the user is moving the mouse around to a table that he wants to act on  ?????  not sure about this  ?????
            ;
            if (ActionPendingOnMouseTableFlag  AND  (WinId <> MouseOverTableId) AND (LastActiveTableWinId == MouseOverTableId) )
            {

               WinActivate, ahk_id%MouseOverTableId%
;outputdebug, activating table the mouse is over with pending action... some other table became active, and we are re-activating the old table.

               ; we don't want to move the mouse there because the user may have already moved the mouse around some,
               ;     and we are just re-activating a table that the mouse was over

               break
            }
      

/*   Removed this large block of code, which mostly helped with stacked tables, where the stacks of two poker sites could be in the same stack.
      I decided that we now will only try to work with seperate stacks, where the stacks of each poker site must be seperate.
      This makes it so much easier because each poker site wants to pop their on table to the top of the stack with pending action. So often
      the current table of the other poker site would get covered up when a new table was poped to the top.
      
      
            
            ; Move mouse to current active table and then Break: IF
            ;              the ACTIVE table is NOT overlayed (it is on top of it's stack)
            ;              and ACTIVE table has pending action
            ;              and the mouse is NOT over some other table with pending action
            ;              and the mouse is over another Table OR  a different table was active last pass thru this function
            ;                                                           but it is over the active table now (but probably in the wrong spot)
            ;              and MouseToHomeEnabled
            ; If all but MouseToHomeEnabled is true, then just break
            ; This is used when Stars activates a table with pending action, and we should move the mouse to that table (the mouse is probably over the previously active table)
            if (UserBusyFlag AND (NOT ActiveTableIsOverlayedFlag) AND  ((WinId <> MouseOverTableId) OR (WinId <> LastActiveTableWinId)) AND (NOT ActionPendingOnMouseTableFlag))
            {
               if MouseToHomeEnabled
               {
outputdebug, moving mouse to active table with pending action
                  if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
                     return
                  ; move the mouse to home position
                  TX := %CasinoName%MouseHomePosX
                  TY := %CasinoName%MouseHomePosY
                  WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
                  CoordMode, Mouse, Screen
                  MouseMove,TX,Ty,0
               }
               break
            }
         
*/

/*
         
            ; get list of tables and put the Ids in an array, with the topmost table is the first element in the array, etc
            WinGet, TableIdArray, List, ahk_group Tables

         
            ; Special Notes of something I thought about  ************************************************
            ; IF the FT option "Display Table on Action" is checked, then FT will pop a table on top of other applications (like Stars tables).
            ;     Regardless of this setting, FT will pop tables to the top if there are only FT tables in the stack.
            ; This is used if the user has the FT feature on that pops a ft table to the top with pending action.
            ;     the problem is that if this is enabled, the new table could pop on top of a Stars table with pending action.
            ;     So, that is why we recommend that the user not activate the FT feature.
            ;     I looked at adding some code that could detect this case and it gets complicated.
            ;     After the IF, you could add another IF that checks for (WinID == LastActiveTableId) AND ListGetPos(TableIDPendingList,WinId)
            ;     and then bring the active table to the top and check if the active table has pending action on it.
            ;     The problem is that at the top of this function we delete any tables that we don't detect pending action on, and therefore we
            ;     the active table won't be on the pending table list. I could move the code that looks to remove tables from this list to below this section.
            ; *********************************************
            ; Activate the top table IF
            ;     the top table was not the same as the last active table
            ;     the top table has pending action on it
            ;     and the mouse is NOT over some other table with pending action on it
            ; This is needed for Full Tilt, where it will bring a table to the top with pending action,
            ;    but it won't activate that table
            ; check if the top table (TableIdArray1) has the fold button visible
            TopTableUserBusyFlag := TablePendingAction(TableIdArray1)
            if ((LastActiveTableWinId <> TableIdArray1) AND TopTableUserBusyFlag AND ( NOT(ActionPendingOnMouseTableFlag AND (MouseOverTableId <> TableIdArray1))   )  )
            {
               WinActivate, ahk_id%TableIdArray1%
               if MouseToHomeEnabled
               {
                  if NOT (CasinoName := CasinoName(TableIdArray1,A_ThisFunc))
                     return
                  ; move the mouse
                  TX := %CasinoName%MouseHomePosX
                  TY := %CasinoName%MouseHomePosY
                  WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",TableIdArray1)
                  CoordMode, Mouse, Screen
                  MouseMove,TX,Ty,0
               }
outputdebug, Top table has been activated

               break
            }
            

*/

            
/*
            
            ; Bring active to top, IF
            ;        mouse is not over a pending table
            ;        and the top table is not active
            ;        and some table is active (WinId)... we don't need to test this as it is tested above
            ;  then move mouse to home (if enabled) and break out IF
            ;           there is pending action on this now top table
            ; 
            ; This is useful if our active table with pending action is buried in the stack, but it wasn't brought to the top for some unknown reason
            ; On my computer, I have seen it where Stars will activate a pending table, but won't bring it to the top...  I talked to Stars about it, but they couldn't help me.
            ;        we bring this table to the top and see if there is pending action on it.
            if ((WinId <> TableIdArray1) AND  (NOT ActionPendingOnMouseTableFlag))
            {
               WinSet, Top,,ahk_id%WinId%
               TopTableUserBusyFlag := TablePendingAction(WinId)
               ; check if this table that we brought to the top has pending action on it... if so, move mouse to home and break
               if TopTableUserBusyFlag
               {
outputdebug, Active table lower in stack has been moved to top
                  if MouseToHomeEnabled
                  {
                     if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
                        return
                     ; move the mouse
                     TX := %CasinoName%MouseHomePosX
                     TY := %CasinoName%MouseHomePosY
                     WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
                     CoordMode, Mouse, Screen
                     MouseMove,TX,Ty,0
                  }
                  break
               }
            }
*/
            ; if the mouse is not over a pending table, then
            ; see if there is another table with pending action. If so activate it and move mouse to home position
            ; This allows us to activate some other pending table that does not match the above conditions
;            if NOT ActionPendingOnMouseTableFlag
;            {
               ; this will activate a pending table, and move the mouse to home (if enabled)
               if TablePending()
               {
;outputdebug, TablePending just activated a new table
                  break
               }
;            }
            
            
            
            
            
            
            
         }           ; end of LOOP command that looks for all the cases of the handling Auto-Activate tables with pending action ENABLED
      }               ; end of handling Auto-Activate tables with pending action ENABLED
      
      
;      Critical, Off
     
;return

      ; get the id of the active table
      WinId := WinActive("ahk_group Tables")

      ; removed this, so that if a table is not active, and the mouse is over a table, we can activate in below (activate the table the mouse is over)
      ; if we don't have an active table now, just return
;     if NOT WinId
;         return

         
         
      ; if no table is active, this will call  TablePendingAction with WinId == 0...  prints a debug message
      if WinId  
         UserBusyFlag := TablePendingAction(WinId)
      else
         UserBusyFlag := 0


      ; Turn on the active table highlighter IF
      ;     ActiveTableHighlighterEnabled  AND (Not UserBusyFlag)  And (NOT  I'm back button)
      if (ActiveTableHighlighterEnabled AND (Not UserBusyFlag))
         HighlighterOn(ActiveTableHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
      ;  Turn on the pending active highlighter IF
      ;        PendingActionHighlighterEnabled  and (UserBusyFlag)
      else if (ActiveTableAndPendingHighlighterEnabled AND UserBusyFlag)
      {
         HighlighterOn(ActiveTableAndPendingHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
      }
      ; else turn off the highlighter
      else
         HighlighterOn(0,0,0,0)



   

      ; activate the table the mouse is over, IF
      ;     ActivateTableOnMouseOverEnabled    OR   (AutoActivateNextPendingTableEnabled AND MouseToHomeEnabled AND ActivateTableOnMouseOverIfMouseToHomeEnabled)
      ;     the mouse is over a table
      ;     and that table is not already active
      ;     and the mouse is not moving    REMOVED IN 4.0019
;      if ((ActivateTableOnMouseOverEnabled  OR  (AutoActivateNextPendingTableEnabled AND MouseToHomeEnabled AND ActivateTableOnMouseOverIfMouseToHomeEnabled) ) AND (NOT MouseMovedFlag))

;      if ((ActivateTableOnMouseOverEnabled  OR  (AutoActivateNextPendingTableEnabled AND MouseToHomeEnabled AND ActivateTableOnMouseOverIfMouseToHomeEnabled) ) )
      if ((ActivateTableOnMouseOverEnabled  OR  (AutoActivateNextPendingTableEnabled AND ActivateTableOnMouseOverIfMouseToHomeEnabled) ) )
      {
;outputdebug, here2     
      
         ; find the window the mouse is over
         MouseGetPos,,, MouseOverTableId

         ; if the window is NOT an active table but it is a FT table, then activate it
         IfWinNotActive, ahk_id%MouseOverTableId% ahk_group Tables
         {
;DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore1)
            WinActivate, ahk_id%MouseOverTableId%  ahk_group Tables
;DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter1)
;TotalTime1 := 1000 * (TimerAfter1 - TimerBefore1) / TimerFrequency
         }
      }
     
     

;if UserBusyFlag
;   outputdebug, TimerFast Time= %TotalTime%  ms
     
     
     
      ; get the id of the active table
      WinId := WinActive("ahk_group Tables")

      ; if we don't have an active table now, just return
      if NOT WinId
      {
;DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;TotalTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, ***  table not active ***  TimerFast Time= %TotalTime%  ms      
         return
      }

         
      UserBusyFlag := TablePendingAction(WinId)
      TableRingOrTournament := TableRingOrTournament(WinId)
      
      
      ; check if we need to move this table
      ; IF MoveTableFlag is False
      ;    AND the FOLD button is visible
      ;    AND MoveTableEnabled is True
      ;    AND AutoActivateNextPendingTableEnabled is True
      ; THEN
      ;     move the table to the special position
      if (MoveTableEnabled AND AutoActivateNextPendingTableEnabled AND UserBusyFlag AND (NOT MoveTableFlag))
      {

         if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
            return

         WindowInfo(MoveTableOrigPosX, MoveTableOrigPosY, MoveTableOrigWidth, MoveTableOrigHeight, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)
         ; calculate the height of this moved table, given the width that the user specified

         TableWDivHFactor := %CasinoName%StandardClientWidth / %CasinoName%StandardClientHeight
         MoveTableHeight := ((MoveTableWidth - 2 * WindowSideBorder) / TableWDivHFactor) + WindowTopBorder + WindowBottomBorder

         ; save the original table position and size
;         WinGetPos, MoveTableOrigPosX, MoveTableOrigPosY,MoveTableOrigWidth,MoveTableOrigHeight,ahk_id%WinId%
         WinHide, ahk_id%WinId%
	      DetectHiddenWindows, on ; brad
         WinMove,ahk_id%WinId%,,MoveTablePosX,MoveTablePosY,MoveTableWidth,MoveTableHeight
         WinShow, ahk_id%WinId%
         
         Sleep, -1
         ; this magic command re-paints Poker Stars tables so that they are resized correctly
         ControlSend, , {F5}, ahk_id%WinId%
         

         MoveTableFlag := 1
         ; add this table to the moved table list
         ListAddItem(MovedTableIdList,WinId)
         
         MoveTableId := WinId

         WinActivate, ahk_id%WinId%
         if NOT (CasinoName := CasinoName(MoveTableId,A_ThisFunc))
            return
            
         ; need to move the highlighter to the new position
         HighlighterOn(0,0,0,0)
         ; Turn on the active table highlighter IF
         ;     ActiveTableHighlighterEnabled  AND (Not UserBusyFlag)  And (NOT  I'm back button)
         if (ActiveTableHighlighterEnabled AND (Not UserBusyFlag))
            HighlighterOn(ActiveTableHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
         ;  Turn on the pending active highlighter IF
         ;        PendingActionHighlighterEnabled  and (UserBusyFlag)
         else if (ActiveTableAndPendingHighlighterEnabled AND UserBusyFlag)
         {
            HighlighterOn(ActiveTableAndPendingHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
         }
         ; else turn off the highlighter
         else
            HighlighterOn(0,0,0,0)            
            
            

         if (MouseToHomeEnabled)
         {
            ; move the mouse
            TX := %CasinoName%MouseHomePosX
            TY := %CasinoName%MouseHomePosY
   
            WindowScaledPos(TX,TY,ClientScaleFactor,"Screen",WinId)
            CoordMode, Mouse, Screen
            MouseMove,TX,Ty,0
         }
         
;outputdebug, moved from    %MoveTableId%      %vMoveTableOrigPosX%     %vMoveTableOrigPosY%     %vMoveTableOrigWidth%    %vMoveTableOrigHeight%

      }

 
      ; if current active table window ID is different from the last win table id, then make some updates
      ; this will be true if the software changed to a new table, or if the user changed to a new table.
      if (WinId <> LastActiveTableWinId)
      {
         ; in case our new table is stacked on top of the previous table, re-display the osd3/4 for the previous table
         ; and if we are stacked, it will turn off the display for the underlying table
         ; this is a relatively slow function, but it only has to be done once in here.

         DisplayOsd3(LastActiveTableWinId)
         DisplayOsd4(LastActiveTableWinId)

         ; quickly show the display for the current table
         DisplayOsd3(WinId)
         DisplayOsd4(WinId)

;outputdebug, new table    time for activate= %TotalTime1%
         LastActiveTableWinId := WinId
         
         UpdateBettingVarsFlag := 1    ; since we are on a new table, the pot size will
         UpdatePresetBetFlag := 1

         ToolTip,,,,7                  ; erase the Deal Me Info tooltip
         ToolTip,,,,8                  ; erase the ChatBoxWarning tooltip
         ToolTip,,,,9                  ; erase the debug tooltip
         ToolTip,,,,10                 ; erase the AllHotkeysEnabled tooltip
      }


      ; RESET UpdateBettingVarsFlag if the fold button is not visible
      ; If the %FoldButton% is not visible, then we need to read the pot value next time that it is visible, so set flag
      if NOT UserBusyFlag
      {
            UpdateBettingVarsFlag := 1
            UpdatePresetBetFlag := 1
            
            ; display the betting display OSD1... turn off if not needed
            DisplayOsd1(WinId)            
            
      }


      ; RESET UpdateBettingVarsFlag if the Street is different than last time through
      ; we need this check, because if the hero is in the BB and he checks, action can be on him
      ; so quickly on the next street that the software may not see that for FOLD button has
      ; disappeared and then re-appeared (in which case the check for the fold button above
      ; will not catch this case, and we won't reset the UpdateBettingVarsFlag to 1, and then
      ; we won't update the betting box with the preset value)
      TableStreet(WinId)
      if (Street <> LastStreet)
      {
            LastStreet := Street
            UpdateBettingVarsFlag := 1
            UpdatePresetBetFlag := 1
            ;DisplayOsd1(WinId)            ; not needed here, since the fold button may not be visible
      }

   
      ; display osd1 and/or autoset the bet
      if (UpdatePresetBetFlag AND UserBusyFlag AND ((AutoSetBetRingEnabled AND TableRingOrTournament) OR (AutoSetBetTrnyEnabled AND !TableRingOrTournament)) )
      {
         BetPresetStreetBet(WinId)
         UpdatePresetBetFlag := 0
         DisplayOsd1(WinId)         
      }
      else if (UpdatePresetBetFlag AND UserBusyFlag)
      {
         UpdatePresetBetFlag := 0
         DisplayOsd1(WinId)
      }
      
      
      ; we can refresh the OSD1 continuously if this is a PS table. But on Full Tilt, it causes problems when the user tries to type in a bet size.
      ;     in this case the refresh will highlight the bet size and if the user types in another bet digit, it overwrites what was there since the software just highlighted the digits that were there.
      CasinoName := CasinoName(WinId,A_ThisFunc)
      if (CasinoName == "PS")
         DisplayOsd1(WinId)

      ; moved this to top
      ; check if mouse is in the chat area to disable action keys and need to display or remove the mouse chat warning
      ;DisplayChatWarning()



/* moved above
      ; Turn on the active table highlighter IF
      ;     ActiveTableHighlighterEnabled  AND (Not UserBusyFlag)  And (NOT  I'm back button)
      if (ActiveTableHighlighterEnabled AND (Not UserBusyFlag))
         HighlighterOn(ActiveTableHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
      ;  Turn on the pending active highlighter IF
      ;        PendingActionHighlighterEnabled  and (UserBusyFlag)
      else if (ActiveTableAndPendingHighlighterEnabled AND UserBusyFlag)
      {
         HighlighterOn(ActiveTableAndPendingHighlighterColor,TableHighlighterTransperancy,TableHighlighterSize,WinId)
      }
      ; else turn off the highlighter
      else
         HighlighterOn(0,0,0,0)
*/


   }
   ;  else a Table is not active
   else
   {
      ; turn off highlighter if it was on
      HighlighterOn(0,0,0,0)
      osdEx("","","",0,0,98)        ; turn off OSD5

      ToolTip,,,,7                  ; erase the Deal me mode status tooltip
      ToolTip,,,,8                  ; erase the ChatBoxWarning tooltip
      ToolTip,,,,9                  ; erase the debug tooltip
      ToolTip,,,,10                 ; erase the All HOtkeys Suspended tooltip
      
      

 
   }




;   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;   TotalTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;if UserBusyFlag
;   outputdebug, TimerFast Time= %TotalTime%  ms


;SetBatchLines %PreviousBatchLines%


}







 ---------------------------------------------------------------------------------------



;                                                     CHECK WHAT VARS ARE USED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; timer medium actions (less often than timer 1)
TimerMedium()
{
   global
   local WinId, DialogIdList
   local ActiveTableId

   local Flag, TableActiveFlag, ImBackButtonFlag
   local TableType, H, UserBusyFlag, Pos, Title, TableRingOrTournament
   local DesiredHeight, DesiredWidth

;outputdebug, in timer medium
;return


;   local TimerFrequency, TimerBefore, TimerAfter, TotalTime
;   DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
;   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)


;if KeyPressedInList(KeyListToDisableShortcuts)
;   outputdebug Key is down


   ; check if all features are disabled
   if (NOT AllHotkeysEnabled)
      return


   ; *****************************************************************
   ;     IF A TABLE is Active
   ; *****************************************************************
   
   ; we also display these in TimerFast (one time when a new table becomes active)....  we do it here in case the user makes a change and the active table does not change.
   
   IfWinActive, ahk_group Tables
   {
      WinId := WinActive("A")
   
      ; display the OSD3 stack info
      DisplayOsd3(WinId)

      ; display the OSD4 Stack info
      DisplayOsd4(WinId)
      
      DisplayOsd5(WinId)
   }

   ; *****************************************************************
   ;     IF A FT TABLE EXISTS
   ; *****************************************************************


   ; if a table exists, then see if there are some tasks related to all open tables
   IfWinExist, ahk_group Tables
   {


      ; *********************************
      ;     GET LIST OF ALL TABLES
      ; *********************************


      ;make a list of all the open table IDs, excluding Lobby
      ;WinGet puts the table count in the variable TableIdArray,
      WinGet, TableIdArray, List, ahk_group Tables


      ; *********************************
      ;     LOOP THRU ALL TABLES
      ; *********************************

      ; loop through all of the open tables to see if we need to do anything with them
      Loop, %TableIdArray%
      {

         ; find the next ID of the next FTP table
         WinId := TableIdArray%A_Index%
         
         TableRingOrTournament := TableRingOrTournament(WinId)
         
         ; click the info refresh button
         ; IF  enabled and in Tournament
         ;     and it has been more than  AutoClickInfoRefreshInterval seconds
         if (AutoClickInfoRefreshEnabled  AND (NOT TableRingOrTournament) )
         {
            if ((NOT InfoRefreshTime%WinId%) OR ( (A_TickCount - InfoRefreshTime%WinId%) > (AutoClickInfoRefreshInterval * 1000) ) )
            {
               TableInfoRefresh(WinId)
               InfoRefreshTime%WinId% := A_TickCount
            }
         }
         
; click the time button repeatedly on each table         
;MouseClickTimeButton(WinId)         
         
         
         ; THIS IS A PRETTY SLOW TEST....   SHOULD IT BE IN TIMER MEDIUM ?????????????????????????????????
         ; auto-click the time button if needed
         ;TimeButtonCheck(WinId)

         ; THIS IS A PRETTY SLOW TEST....   SHOULD IT BE IN TIMER MEDIUM ?????????????????????????????????
         ; check if the ImBack button is visible on this table - DOES NOT WORK ON STARS TABLES IF THE TABLES ARE STACKED/CASCADED
         ; Note: there is a test in the TimerSlow() function to check the hand history to see if the player has timed out.. then the I'm back button is clicked (for Poker stars)
         ; click the ImBack button IF
         ;     it is visible
         ;     AND this is a tournament
         ;     AND AutoClickImBackButtonEnabled is true,
         ;     and if the user has been active with mouse or keyboard recently
         if (AutoClickImBackButtonEnabled AND ( NOT TableRingOrTournament) AND  (UserTimeIdlePhysical < AutoClickImBackFailSafeTime))
         {
            if (ButtonVisible("ButtonImBack",WinId) == 1)
               ButtonClick("ButtonImBack",WinId)
         }
         
         
         ; display the OSD3/4 stack info if this is a non active table
         if (ActiveTableId <> WinId)
         {
            DisplayOsd3(WinId)
            DisplayOsd4(WinId)
         }

         
         

/*       DOESN"T SEEM LIKE WE NEED THIS EVER ????????????????????????

         ; get the table type (NL, PL, Limit, etc)
         TableType := TableType( WinId)



         ; check if this table is the active table
         IfWinActive, ahk_id%WinId%
            TableActiveFlag := 1
         else
            TableActiveFlag := 0
*/




         ; check if there are any Deal me mode tasks to do
         DealMeMode(WinId)



         ; check if the "I'm Ready" button is visible, if enabled to click it, then click it
         if ClickImReadyEnabled
         {
            ; check if the I'm Ready button is visible on this table, if so click it
            if (ButtonVisible("ButtonImReady",WinId) == 1)
               ButtonClick("ButtonImReady",WinId)
         }




/*
         TableRingOrTournament := TableRingOrTournament(WinId)


         ; check if the ImBack button is visible on this table - DOES NOT WORK ON STARS TABLES IF THE TABLES ARE STACKED/CASCADED
         ImBackButtonFlag := ( ButtonVisible("ButtonImBack",WinId) AND (!TableRingOrTournament) )                 ;  check use of the ButtonVisible function, could be -1
         ; click the ImBack button IF
         ;     it is visible
         ;     AND this is a tournament (this is checked as part of the ImBackButtonFlag)
         ;     AND AutoClickImBackButtonEnabled is true,
         ;     and if the user has been active with mouse or keyboard recently
         if ((ImBackButtonFlag AND AutoClickImBackButtonEnabled) AND  (UserTimeIdlePhysical < AutoClickImBackFailSafeTime))
         {
            ButtonClick("ButtonImBack",WinId)
            ImBackButtonFlag := 0
         }

*/



      }
   }



/*


   ; *****************************************************************
   ;     IF A "GET CHIPS" DIALOG BOX EXISTS
   ; *****************************************************************

   ; if there is a "Get Chips" dialog box open, then deal with it quickly to get it out of the way
   ;     even if there is action pending on another table
   WinId := WinExist("Get Chips")
   if WinId
      DialogGetChips(WinId)

*/



   ; *****************************************************************
   ;     CHECK IF WE NEED TO CHECK THE AUTO POST BLINDS CHECKBOX ON SOME TABLE
   ; *****************************************************************


/* MOVED TO THE DealMeMode()  function
   ; if this CheckAutoPostBlindsFlag is set, we need to check the APB checkbox at the table associated with this
   ;     dialog box.
   if CheckAutoPostBlindsFlag
   {
      ; make sure the get chips dialog box is gone
      IfWinNotExist, ahk_id%CheckAutoPostBlindsAtGetChipsDialogId%
      {
         ; after a table opens, it takes awhile for the Auto-Post blinds checkbox to appear.
         ; wait here for about 2 seconds until it shows up
         StartTime := A_TickCount
         loop,
         {
            ; break with the apb checkbox finally shows up
            if (CheckboxGetState("CheckboxAutoPostBlinds",CheckAutoPostBlindsAtTableId) >= 0)
               break

            ; if we have waited too long, then break out of the loop and quit trying to wait
            if ((A_TickCount - StartTime) > FTWaitForAutoPostBlindsMS)
            {
               break
            }
         }
         ; check the checkbox
         CheckboxSetState(1, "CheckboxAutoPostBlinds",  CheckAutoPostBlindsAtTableId)
         ; reset the flag
         CheckAutoPostBlindsFLag := 0
      }
   }
*/


;   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;   TotalTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, TimerMedium Time= %TotalTime%  ms


}


; ---------------------------------------------------------------------------------------

; timer slow actions (less often than timer 1)


; if we only deal with TableCloseIdList list in the function, then we can remove the Critical, On statements below



TimerSlow()
{
   global
   local CasinoName, WinId, DialogIdList
   local ActiveTableId, TableRingOrTournament

   local Flag, TableActiveFlag
   local H, UserBusyFlag, Pos, Title
   local DesiredHeight, DesiredWidth
   local DialogFlag
   
   local WindowX, WindowY, WindowW, WindowH, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder
   local TableWDivHFactor
   local RealMoneyTableNum
   
   static CurrentFullTiltProcessPriority, CurrentPokerStarsProcessPriority

;outputdebug, in timer slow
;return


;   local TimerFrequency, TimerBefore, TimerAfter, TotalTime
;   DllCall("QueryPerformanceFrequency", "Int64 *", TimerFrequency)
;   DllCall("QueryPerformanceCounter", "Int64 *", TimerBefore)






   ; check if all features are disabled
   if (NOT AllHotkeysEnabled)
      return

;outputdebug, timerslow1

   ; there are several type of user activity... keyboard, mouse, and joystick
   ; but A_TimeIdlePhysical only keeps track of mouse and keyboard activity
   ; we need to keep a new time variable ---  UserTimeIdlePhysical
   ; that is the number of ms since any type of user activity
   ; LastJoystickActivityTime is the tick count that the joystick was last clicked
   ;  A_TimeIdlePhysical is the time in ms since the last keyboard or mouse activity
   ; we will calculate UserTimeIdlePhysical to be the time in ms since the last keyboard, mouse or joystick activity

   ; check if we have had joystick activity more recently than mouse/keyboard activity
   if ((A_TickCount - LastJoystickActivityTime) < A_TimeIdlePhysical)
      UserTimeIdlePhysical := A_TickCount - LastJoystickActivityTime
   else
   {
      ; we have had mouse/keyboard activity more recently than joystick activity
      UserTimeIdlePhysical := A_TimeIdlePhysical
   }


   ; do we need to set the process priority for FT or PS

   ; see if we need to change the process priority for FT
   ; if we are not supposed to change it, then skip this section
   if (FullTiltProcessPriority <> "NoChange")
   {
      ; check if the program is now running
      Process, Exist, FullTiltPoker.exe
      if (ErrorLevel)
      {
         ; it is running
         ; check if we have NOT already set the priority (if not set, then the priority will NOT be the same as the current priority setting )
         if (CurrentFullTiltProcessPriority <> FullTiltProcessPriority)
         {
;outputdebug, changing the FT priority to %FullTiltProcessPriority%
            ; change the priority
            Process, Priority, %ErrorLevel%, %FullTiltProcessPriority%
            ; save our current setting, so we know if we have already set the priority
            CurrentFullTiltProcessPriority := FullTiltProcessPriority
         }
      }
      else
      {
         ;reset the current value of this priority
         CurrentFullTiltProcessPriority := 0
      }
   }
   else
      CurrentFullTiltProcessPriority := 0


   ; see if we need to change the process priority for PS
   ; if we are not supposed to change it, then skip this section
   if (PokerStarsProcessPriority <> "NoChange")
   {
      ; check if the program is now running
      Process, Exist, PokerStars.exe
      if (ErrorLevel)
      {
         ; it is running
         ; check if we have NOT already set the priority (if not set, then the priority will NOT be the same as the current priority setting )
         if (CurrentPokerStarsProcessPriority <> PokerStarsProcessPriority)
         {
;outputdebug, changing the PS priority to %PokerStarsProcessPriority%
            ; change the priority
            Process, Priority, %ErrorLevel%, %PokerStarsProcessPriority%
            ; save our current setting, so we know if we have already set the priority
            CurrentPokerStarsProcessPriority := PokerStarsProcessPriority
         }
      }
      else
      {
         ;reset the current value of this priority
         CurrentPokerStarsProcessPriority := 0
      }
   }
   else
      CurrentPokerStarsProcessPriority := 0





   ; ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
   ; NOTE: this code in this function should not change to another active table, so the following flags should be constant while this function runs
   ;     hummm... but the timerfast function could interrrupt us...   maybe we should set the timers to be the same priority, just different intervals

   UserBusyFlag := 0
   TableActiveFlag := 0
   ActiveTableId := 0



   ; if user is involved in a decision (i.e. the betting window is active on the active table)
   ; then set a flag, so we don't do some of the tasks below during this critical times
   IfWinActive, ahk_group Tables
   {
      TableActiveFlag := 1
      ActiveTableId := WinActive("A")

      ; if the %FoldButton% bet window is visible;   changed this from the BetEdit box, cuz sometimes that box is not visible
      UserBusyFlag := TablePendingAction(ActiveTableId)

   }



   ; *****************************************************************
   ;     DO THESE NO MATTER WHAT
   ; *****************************************************************

   ; here is some clean up functions, that need to be done regardless, IF the hero is not busy

   if NOT UserBusyFlag
   {
      ; clean up the InvalidDialogWidthIdList - remove dialog boxes that no longer exist on the computer
      InvalidDialogRemoveObsolete()
      ; remove display osd3 for any tables that no longer exist
;
      ; remove display osd4 for any tables that no longer exist
;      DisplayOsd4RemoveObsolete()
      ; remove any pending tables from list that no longer exist
      TablePendingRemoveObsolete()
      ; remove any tables from the timebuttonlist that no longer exist
      TimeButtonListCleanup()
      ; display the Sng Status - REMOVED IN VER 4.0004  because this should only be called from within the SngContinuouslyOpen function since it uses lists
;      SngContinuouslyOpenStatusDisplay()
      ; if we should close tournament lobbies, do it now
      LobbyTournamentClose(0)
      ; if we should close any Stars Sngs that have finished
      if CloseFinishedSngTablesEnabled
         TableCloseFinishedStarsSngTables()
      ; see if we have any tables to be closed that are on the list
      TableCloseFromListDelayed()
      ; cleanup the TableOpenIdList    located in FunctionsTable.ahk
      ; this does not need to be Critical, On, because the thing that adds to this list is also in TimerSlow below, and the list can be modified by both at the same time
      TableOpenIdListCleanup()
         
   }




   ; *****************************************************************
   ;     IF A FT TABLE IS ACTIVE
   ; *****************************************************************



;outputdebug, here1
   If TableActiveFlag
   {
;outputdebug, here2   
      ; if debug enabled, then display debug info
      if DisplayDebugInfoEnabled
      {
;outputdebug, here3
         DisplayDebugTooltip()
      }
      ; else erase the tooltip
      else
         ToolTip,,,,9
   }
   ; else erase the tooltip
   else
      ToolTip,,,,9


; return

   ; *****************************************************************
   ;     IF A FT TABLE EXISTS
   ; *****************************************************************


   ; if a FT table exists, then see if there are some tasks related to all open tables
   IfWinExist, ahk_group Tables
   {
;outputdebug, timerslow2
      ;make a list of all the open table IDs, excluding Lobby
      ;WinGet puts the table count in the variable TableIdArray,
      WinGet, TableIdArray, List, ahk_group Tables


;outputdebug, TableIdArray:%TableIdArray%









      ; if the user is NOT busy, then do these tasks for this table
      if  !UserBusyFlag
      {

         ; *********************************
         ;     LOOP THRU ALL TABLES
         ; *********************************

         ; loop through all of the open tables to see if we need to do anything with them
         Loop, %TableIdArray%
         {

            ; find the next ID of the next FTP table
            WinId := TableIdArray%A_Index%
            
            ; if this table is not on our TableOpenIdList then add it
            ; this does not need to be Critical, On, because the thing that cleans up this list is also in TimerSlow, and the list can be modified by both at the same time
            if NOT instr(TableOpenIdList,WinId)
            {
               ListAddItem(TableOpenIdList,WinId)

            }
            
            if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
               continue
               
            TableRingOrTournament := TableRingOrTournament(WinId)
            
            

               

;outputdebug,  table:%A_Index%   %WinId%     activeid:%ActiveTableId%

;visible := TableVisible(WinId)
;seated := HeroSeated(WinId)
;outputdebug,  table:%A_Index%   %WinId%    activeid:%ActiveTableId%    visible:%visible%   seated:%seated%

/*
            ; display the OSD3/4 stack info if this is a non active table
            if (ActiveTableId <> WinId)
            {
;outputdebug, here1
               DisplayOsd3(WinId)
               DisplayOsd4(WinId)
            }
*/

            ; ??????????????????????????????????  we are going to do this even if our tables are tiled  ????????????????????????????????????????
            ; ???????????????????    we could do a check to see if the ButtonImBack is visible
            ; if enabled, check if the last STARS hand history indicates that we timed out.
            ;     if so, then click the i'm back button
            if (AutoClickImBackButtonEnabled AND (CasinoName == "PS"))
            {
;outputdebug, in timer slow...  checking PS  HH for WinId:%WinId%
               ; if the HH says we timed out, then click the I'm back button
               if LastHandHistoryHeroTimedOut%WinId%
                  ButtonClick("ButtonImBack",WinId)
               ; else we may need to get the latest hand history...   which updates the global variable  LastHandHistoryHeroTimedOut%WinId%
               else
               {
                  PSHandHistory(WinId)
                  if LastHandHistoryHeroTimedOut%WinId%
                  {
;outputdebug, clicking Im back button on PS
                     ButtonClick("ButtonImBack",WinId)
                  }
               }
               ; reset the flag
               LastHandHistoryHeroTimedOut%WinId% := 0
            }



            ; if enabled, check if the last FT hand history indicates that we busted out of tournament or SNG, so that we can close the table if enabled.
            ;     if so, then click the i'm back button
            if (CloseFinishedSngTablesEnabled AND (CasinoName == "FT") and (NOT TableRingOrTournament) )
            {
;outputdebug, in timer slow...  checking FT  HH for WinId:%WinId%
               ; if the HH says we stood up, then add this WinId to the list to close this table
               if LastHandHistoryStandsUp%WinId%
               {
                  Critical, On
                  ListAddItem(TableCloseIdList,WinId)
                  ListAddItem(TableCloseTimeList,A_TickCount)
                  Critical, Off
;outputdebug, in timerslow()  SHOULD NEVER SHOW UP !!!!!!   Found FT sng table to close from hh  TableCloseIdList:%TableCloseIdList%      WinId:%WinId%
               }
               ; else we may need to get the latest hand history...   which updates the global variable  LastHandHistoryStandsUp%WinId%
               else
               {
;outputdebug, here2
                  FTHandHistory(WinId)
                  if LastHandHistoryStandsUp%WinId%
                  {
outputdebug, in timerslow()   Found FT sng table to close from hh  TableCloseIdList:%TableCloseIdList%      WinId:%WinId%
                     Critical, On
                     ListAddItem(TableCloseIdList,WinId)
                     ListAddItem(TableCloseTimeList,A_TickCount)
                     Critical, Off
                  }
               }
               ; reset the flag
               LastHandHistoryStandsUp%WinId% := 0
            }
            



            ; check if we need to close this tournament table without hero seated, if it is enabled
            if CloseTourneyTablesIfNotSeatedEnabled
               TableTournamentCloseWithoutHeroDelayed(WinId)




            ; *******************************************************************
            ;        Resize this table
            ; *******************************************************************
            ; check if we should resize the table to a size we need for this program,
            ; do not resize if Mouse button is held down, or if shift key is held down
            ; **********************************************************************************
            ; TEST IDEA
            ; sometimes when a new sng table opens, the title bar is either blank, or it gets stuck and never changes
            ; even when the blinds change. I have this theory that if we resize the table too soon after it first opens
            ; then the title bar might be getting stuck. So, let try this... when we determine that a table should
            ; be resized, put the ID in a list, and don't resize it this time thru, but do it next time the software runs
            ; thru this function.
            ; **********************************************************************************
            if (  (TableSize <> "None") AND  (NOT  KeyPressedInList(KeyListToDisableShortcuts))  )
            {
            
               WindowInfo(WindowX, WindowY, WindowW, WindowH, ClientW, ClientH, WindowTopBorder, WindowBottomBorder, WindowSideBorder, WinId)

               ; see if user has given us a width and a height
               if (Pos := InStr(TableWidth%TableSize%, "x"))
               {
                  ; user have given us width and height
                  DesiredWidth := SubStr(TableWidth%TableSize%, 1, Pos - 1)
                  DesiredHeight := SubStr(TableWidth%TableSize%, Pos + 1, StrLen(TableWidth%TableSize%) - Pos)
                  ; if we don't already have the desired size, then resize the table
                  if ((DesiredWidth <> WindowW) OR (DesiredHeight <> WindowH))
                  {


                     ; if this table id is already in the ResizeTableIdList, then resize this table (as we have waited
                     ; a little since the table was opened)
                     if (instr(ResizeTableIdList,WinId))
                     {
                        ; need to turn critical on in case Timer1 interrupts and moves the table, so that we don't resize a moved table
                        Critical, On

                        ; if this table has been moved (i.e. it is on the moved table list, then do NOT resize it
                        if NOT ListGetPos(MovedTableIdList,WinId)
                        {
;outputdebug, resizing winid:%WinId%   desiredw:%DesiredWidth%   actualw:%WindowW%    desiredh:%DesiredHeight%    actualh:%WindowH%
                           WinMove, ahk_id%WinId%, ,,, DesiredWidth, DesiredHeight

                           Sleep, -1
                           ; this magic command re-paints Poker Stars tables so that they are resized correctly
                           ControlSend, , {F5}, ahk_id%WinId%
                           ; remove this id from the list
                           ListDelItem(ResizeTableIdList,WinId)
                        }
                        Critical, Off
                     }

                     ; else this table is not already in the ResizeTableIdList
                     else
                     {
                        ; add this table to the resize list so that we resize it next time thru this function
                        ListAddItem(ResizeTableIdList,WinId)
                     }
                  }
               }
               else
               {
                  ; else the user only specified a table width....   find the desired width and height
                  ; find the desired width and height that the table should be
                  DesiredWidth := TableWidth%TableSize%
                  TableWDivHFactor := %CasinoName%StandardClientWidth / %CasinoName%StandardClientHeight
                  
                  DesiredHeight := Round(((DesiredWidth - 2 * WindowSideBorder) / TableWDivHFactor) + WindowTopBorder + WindowBottomBorder)

;outputdebug, desired:%DesiredWidth%,%DesiredHeight%   actual:%WindowW%,%WindowH%

                  if ((DesiredWidth <> WindowW))
                  {
                     ; if this table id is already in the ResizeTableIdList, then resize this table (as we have waited
                     ; a little since the table was opened)
                     if (instr(ResizeTableIdList,WinId))
                     {
                        ; need to turn critical on in case Timer1 interrupts and moves the table, so that we don't resize a moved table
                        Critical, On

                        ; if this table has been moved (i.e. it is on the moved table list, then do not resize it
                        if NOT ListGetPos(MovedTableIdList,WinId)
                        {
;outputdebug, resizing winid:%WinId%   desiredw:%DesiredWidth%   actualw:%WindowW%    desiredh:%DesiredHeight%    actualh:%WindowH%
                           WinMove, ahk_id%WinId%, ,,, DesiredWidth, DesiredHeight


                           Sleep, -1
                           ; this magic command re-paints Poker Stars tables so that they are resized correctly
                           ControlSend, , {F5}, ahk_id%WinId%

                           ; remove this id from the list
                           ListDelItem(ResizeTableIdList,WinId)
                        }
                        Critical, Off
                     }
                     ; else this table is not already in the ResizeTableIdList
                     else
                     {
                        ; add this table to the resize list so that we resize it next time thru this function
                        ListAddItem(ResizeTableIdList,WinId)
                     }
                  }
               }
            }
            

            
            
            
         }
      }
   }

;return


   ; *****************************************************************
   ;     IF THERE ARE NO PENDING ACTIONS AT THE ACTIVE TABLE, THEN DO THESE THINGS BELOW
   ; *****************************************************************





; ??????????????????????????????????????????????? I turned off the test for the userbusy flag, because of the FOLD/CHECK dialog box on stars
; ???????????????????????????????????????????????     is it a problem to turn off this test for this flag  ??????????????
; ???????????????????????????????????????????????      note that this dialog only occurs when the FOLD button is present !!!!!
;   if !UserBusyFlag
;   {


/*



      ; *****************************************************************
      ;     CHECK IF THERE ARE ANY OPEN DIALOG BOXES WE NEED TO SERVICE
      ; *****************************************************************
      ;make a list of all the open dialog boxes IDs
      ;WinGet puts the count in the variable DialogIdList,
      WinGet, DialogIdList, List, ahk_group Dialogs
      ; loop thru all of these dialog boxes and see if we need to operate on any of them


      Loop, %DialogIdList%
      {

      
         ; find the next ID of the next open dialog box
         StringTrimRight, WinId, DialogIdList%A_Index%, 0

         ; if it is a FT notes dialog box, then ignore it
         IfWinExist, ahk_id%WinId% ahk_group Notes
            continue
            
         ; if it is in the InvalidDialogWidthIdList, then we already marked it as invalid
         if (ListGetPos(InvalidDialogWidthIdList,WinId))
            continue

;junko1 := DialogIdList%A_Index%
;WinGetTitle, junko, ahk_id%junko1%
;outputdebug, Dialog found   DialogId:%junko1%    Title:%junko%

         ; try to close this dialog box
         DialogClose(WinId)

      }
      
;outputdebug, timerslow4      
      ; QWidget type of dialog boxes
      ; *****************************************************************
      ;     CHECK IF THERE ARE ANY OPEN DIALOG BOXES WE NEED TO SERVICE
      ; *****************************************************************
      ;make a list of all the open dialog boxes IDs
      ;WinGet puts the count in the variable DialogIdList,
      WinGet, DialogIdList, List, ahk_group QWidgetDialogs
      ; loop thru all of these dialog boxes and see if we need to operate on any of them


      Loop, %DialogIdList%
      {

;outputdebug, found qwidget dialog      
         ; find the next ID of the next open dialog box
         StringTrimRight, WinId, DialogIdList%A_Index%, 0

         ; if it is in the InvalidDialogWidthIdList, then we already marked it as invalid
         if (ListGetPos(InvalidDialogWidthIdList,WinId))
            continue

;junko1 := DialogIdList%A_Index%
;WinGetTitle, junko, ahk_id%junko1%
;outputdebug, Dialog found   DialogId:%junko1%    Title:%junko%

         ; try to close this dialog box
         DialogCloseQWidget(WinId)

      }      
      
      
*/

;   DllCall("QueryPerformanceCounter", "Int64 *", TimerAfter)
;   TotalTime := 1000 * (TimerAfter - TimerBefore) / TimerFrequency
;outputdebug, TimerSlow Time= %TotalTime%  ms



}

