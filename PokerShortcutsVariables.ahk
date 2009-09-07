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



; ******************************************************************************************************
; **************           CONSTANTS           *********************************************************
; ******************************************************************************************************








   Ver := "4.0032"                 ; this software's version number

   Title := "Poker Shortcuts"   ; goes in title bar for this program

   GuiSoftwareUpdateFlag := 0            ; set to 1 when the software is writing all the variables to the gui


   AllHotkeysEnabled := 1        ; hotkeys are NOT Suspended

   ; Timer constants
   TimerWatchJoystickInterval := 50        ; check for a joystick operation every 10ms
   TimerFastInterval := 250                ; these are quick response items (like displaying bet info)
   TimerMediumInterval := 1000             ; these are medium response items (like deal me mode, I'm ready button, I'm back)
   TimerSlowInterval := 2000               ; these are slow response items (like dialog boxes)



   SaveSettingsInterval := 60000          ; save the settings to disk after 60 seconds of no more changes
   DealMeToolTipTimerInterval := 10000     ; show the deal me tooltip status tooltip for this line

;   LobbyTournamentCloseTimerInterval := 1000   ; return to the LobbyTournamentClose() every second while it is trying to close the lobbies
;   TableTournamentCloseTimerInterval := 1000   ; return to the TableTournamentCloseWithoutHeroDelayed() every second while it is trying to close the lobbies
   ;TableCloseAllTournamentTablesWithoutHeroDelayedTimerInterval := 1000   ; return to the TableCloseAllTournamentTablesWithoutHeroDelayed() every second while it is trying to close tables

   TimerWatchJoystickPriority := -5             ; timer that looks for joystick operations
   TimerFastPriority := -10                     ; fast timer priority
   TimerMediumPriority := -15                     ; medium Timer Priority
   TimerSlowPriority := -20                     ; slow Timer Priority


   SaveSettingsPriority := -30                  ; save settings timer priority
   SngContinuouslyOpenTimerPriority := -40      ; sng opener timer priority
   DealMeToolTipTimerPriority := -50            ; deal me status tooltip timer priority
   
   DealMeModeStatusTooltipX := 250              ; position of the deal me status
   DealMeModeStatusTooltipY := 5
   
;   LobbyTournamentCloseTimerPriority := -50     ; lobby close timer priority
;   TableTournamentCloseTimerPriority := -50     ; table close timer priority
;   TableCloseAllTournamentTablesWithoutHeroDelayedTimerPriority := -60    ; table close timer priority


   KeyWaitMaxClickTime := .3              ; max time wait for the user to click a multiple click


   SeatAvailBeepInterval := 10000      ; Time in milliseconds between beeps when seat available



   WaitTimeForFullTiltResponse := 5000    ; in milliseconds. On slow internet connections, it can
                                          ; take a long time for Full Tilt to respond to automated actions
                                          ; like clicking on the "Wait for Big Blind" button. But if
                                          ; we don't wait, then this software will keep pressing these buttons
                                          ; in the TableTasks() function.

   AutoClickImBackFailSafeTime := 20000  ; time in ms (30 seconds). If the user is inactive for this amount or time (or longer) then the software will
                                          ; not click the I'm back button automatically (even if enabled). This prevents the software
                                          ; from continuously clicking this button (and making all of the other players wait at the table)
                                          ; in the even that this user has left his computer.

   PSWinOpenTime := 5                          ; time (in seconds) for PS window to open
   PSWinOpenTimeMS := 5000                     ; time (in ms) for PS window to open
   FTWinOpenTime := 5                          ; time (in seconds) for FT SnG lobby to open
   FTWinOpenTimeMS := 5000                     ; same time in MS
   
   FTWaitForAutoPostBlindsMS := 2000              ; time in MS to wait for the auto post blinds checkbox to appear after a new table opens

   ReReadPotDelay := 200                        ; if we have a error in reading the pot value, delay this long before re-reading it again


   UserTimeIdlePhysical := 0                 ; time in ms since there was joystick, mouse or keyboard activity (calculated in TimerSlow() )
   LastJoystickActivityTime := 0             ; time in tick_count time (ms) when there was joystick activity (set in watchjoystick() )


   AutoReloadTimeOutTime := 60000       ; if the stack has not been replenished in 60 seconds, then reload again (we must have missed it)


   PixTol :=  6          ;3                               ; tolerance in imagesearch operations (in pixels)
                                          ;     when we do imagesearches you need to search a few pixels on either side
                                          ;     of where the image should be to account for differences in the screen
                                          ;     resolutions users are using.
                                          ;  Tol is subtracted from the beginning X and Y

   ColTol := 80                           ; color tolerance in image searches
                                          ; changed from 20 in version 1.25... some users were not detecting the Wait for big blind buttons
   ColTolNumbers := 40                    ; color tolerance for stack numbers, increased this greatly since there are some
                                          ;     different colors around the comma and decimal point on the smaller table sizes.


;   LastActiveTableWinId := ""            ; WinId of the last active window

;   LastSngOpenStatus := ""                ; Status message generated by the SngOpen() function


   Osd5DistanceTolerance := 60            ; if the mouse is within 60 pixels of the center of the player's box, then we can display OSD5 for that player


   SngNumTypes := 7                       ; number of different sngs in each group e.g.  7 in each  of  FT and PS
   SngNumCasinos := 2                      ; we have FT sngs to open numbered 1-7, and stars starts at 11-17
   PSSngStartingNum := 11                 ; starting number for the PS sngs
   
   SngNumOpenedThisSession := 0           ; number of SnGs that the continuous opener has opened
   SngOpenIdList := ""                    ; list of sng tables ids that are open (both play and real money)
   SngContinuouslyOpenStartTime := 0      ; this is the computer tick time that we start opening sngs (to be used to know when
                                          ;  to stop opening SnGs)
   SngPendingLobbyIdList := ""            ; lobby id list of lobbies that we are waiting for the table to open
   SngPendingTourneyNumList := ""         ;       and the corresponding Tournament number (from the title bar) of the tournament lobby

   PSSngFileList := ""                      ; list of sng image file names (for current PS theme)

   SngKickMessage = MSG_TABLE_SIT_KICK		;This is the line we're looking for in the PokerStars log file to know when a sng table has closed

   LeftClickWinId := ""                   ; current win id when the left mouse button is clicked
   LeftClickControl := ""                 ; current control that the mouse is over when the left mouse button is clicked

   NumStackFontSizes := 9                 ; number of different Stack Font image types
   NumButtonImageSizes := 9               ; number of different Button image types


   TableCloseIdList := ""                 ; list of table ids that are pending to be closed after a delay time
   TableCloseTimeList := ""               ; time that the table was put on the list to be closed
   
   
   
   TableOpenIdList := ""                    ; list of open tables that have global variables being saved (like LastHandHistory%WinId%)


/*
   ; these are global variables that are like arrays, that are asssociated with each table that is open (and listed in the above list)
   ; this variables get erased in TableOpenIdListCleanup()
   ; these vars get declared when they are first used (mostly in the hand history and herostack functions)
   ;      LastHandHistory%WinId% := ""
   ;      LastHandHistoryFilePath%WinId% := ""
   ;      LastHandHistoryFileSize%WinId% := ""
   ;      LastHandHistoryHeroTimedOut%WinId% := ""              ; true when hero times out (stars hh)
   ;      LastHandHistoryStandsUp%WinId% := ""              ; true when the hero stands up in a tournament or sng (FT hh)
   ;      LastHandHistoryFilePathUpdateTime%WinId% := ""    ; time that we last check for the new hand history file path name



         Osd3GuiNum%WinId% =
         Osd3LastPosX%WinId% =
         Osd3LastPosY%WinId% =
         Osd3LastTheme%WinId% =
         Osd3LastText%WinId% =
         Osd3LastStack%WinId% =

         Osd4GuiNum%WinId% =
         Osd4LastPosX%WinId% =
         Osd4LastPosY%WinId% =
         Osd4LastTheme%WinId% =
         Osd4LastText%WinId% =
         Osd4LastStack%WinId% =
         
         Osd5GuiNum%WinId% =
         Osd5LastPosX%WinId% =
         Osd5LastPosY%WinId% =
         Osd5LastTheme%WinId% =
         Osd5LastText%WinId% =
         Osd5LastStack%WinId% =


         NOTE: a lot of these items use the title to determine their value.
               Be careful if a table is slow to come up and doesn't have a title. The functions
               that determine these values should just set these values to "" and wait until the title does appear.
         CasinoName%WinId% =
         TableRingOrTournament%WinId% =
         HeroName%WinId% =
         TableSeats%WinId% =
         TableNameOrNumber%WinId% =
         TableType%WinId% =
         TableFast%WinId% =
         TableHeadsUp%WinId% =
         BigBlind%WinId% =
         SmallBlind%WinId% =
         Ante%WinId% =

         DealMeModeState%WinId% =                        ; deal me mode state:  In, Out, Off
         InfoRefreshTime%WinId%                          ; we refresh this button at a regular interval... save the time of the last update
*/



   FilePathUpdateIntervalMS := 60000                        ; 60 secs -  this is how often we update the  LastHandHistoryFilePath%WinId%    in case the file name changes
   
;PreviousHighlightId := ""                 ; save the id of the previous table that had a highlighter on (added version 3.21)

;   MaxGuiNum := 16                     ; max number of table highlighters (error protection)--  this uses up gui's 1-64


   MaxDisplayOsd3GuiNum := 32                 ; max number of table GUI
   StartingDisplayOsd3GuiNumMinus1 := 0      ; the guinums for the osd3 display go from 1-32

   MaxDisplayOsd4GuiNum := 32                 ; max number of table GUI
   StartingDisplayOsd4GuiNumMinus1 := 32      ; the guinums for the osd2 display go from 33-64

   TempString := ""                          ; string used to read the table contents with WinGet
   VarSetCapacity(TempString, 300)              ; set the size to something large enough to hold all of the table contents


;   MoveTableId := 0                          ; id of the table that is moved to home position
;   MoveTableFlag := 0                        ; flag indicating that a table has been moved

   MovedTableIdList := ""                    ; list of tables that have been moved by one of the moved table features

   ; Joystick lists
   JoystickHotkeyList := ""                  ; list of the hotkeys that are special Joystick hotkeys
   JoystickGosubList := ""                   ; list of the gosub labels that correlate with the hotkeys above

   ; lists for the OSDs
   Osd3GuiNumList =

   Osd4GuiNumList =

;   DisplayOsd3TableIdList := ""                    ; list of tables displaying OSD3
;   DisplayOsd3GuiNumList := ""                     ; guinum for this displays
;   DisplayOsd3PosXList := ""                       ; last pos X of the display on the table
;   DisplayOsd3PosYList := ""                       ; last pos Y of the display on the table
 ;  DisplayOsd3ListList := ""                       ; last displayed text of the display on the table
;   DisplayOsd3ThemeList := ""                      ; last theme of the display on the table
;   DisplayOsd3StackList := ""                      ; last hero stack size
;   DisplayOsd3BigBlindList := ""                   ; last big blind size for this table
;   DisplayOsd3NumPlayersList := ""                 ; last number of players at this table
;   DisplayOsd3PendingTableStartTimeList := ""      ; last pending start time for this table

   ; lists for the OSD2 stack display

;   DisplayOsd4TableIdList := ""                    ; list of tables displaying OSD3
;   DisplayOsd4GuiNumList := ""                     ; guinum for this displays
;   DisplayOsd4PosXList := ""                       ; last pos X of the display on the table
;   DisplayOsd4PosYList := ""                       ; last pos Y of the display on the table
;   DisplayOsd4ListList := ""                       ; last displayed text of the display on the table
;   DisplayOsd4ThemeList := ""                      ; last theme of the display on the table
;   DisplayOsd4StackList := ""                      ; last hero stack size
;   DisplayOsd4BigBlindList := ""                   ; last big blind size for this table
;   DisplayOsd4NumPlayersList := ""                 ; last number of players at this table
;   DisplayOsd4PendingTableStartTimeList := ""      ; last pending start time for this table


   InitialGuiX := 20                  ; default GUI x position
   InitialGuiY := 20                  ; default GUI y position
   InitialGuiW := 770                  ; default GUI width     **** actually a Constant
   InitialGuiH := 430                  ; default GUI height     **** actually a Constant



   TableWDivHFactor := 1.451                          ; ratio of table width / table height  (for table size inside the borders)
                                                      ; this is the factor that approximates what size FT makes their tables when you resize



   ; this is the size of the active area in a standard large table size that is used to scale the position of various points on the table
   ; This size is without window borders
   StandardActiveWidth :=  794
   StandardActiveHeight := 547




   DisplayHoleCardInfoPosX := 360 - 4
   DisplayHoleCardInfoPosY := 320 - 30


   LobbyTournamentCloseTime := 0                ;   This var is used by the function LobbyTournamentClose  and  the timer functions
                                                ;   this is the time that it was first ok to close a tournament lobby, but we are going to delay CloseLobbyTimeDelay
                                                   ; cuz if we close it down too soon after a sng table opens, it may close the table too
                                                   ; so we will close the lobby after this delay after we are first able to close it




   UpdateBettingVarsFlag := 1                     ; this flag is used by the BetVariables() function to indicate when
                                          ;     the code should read the PotSize from the Full Tilt betting window.
                                          ;     Any time the user clicks the mouse on a Betting button (fold, call, etc.)
                                          ;     then we need to tell the code that the POT size may have changed,
                                          ;     and the POT SIZE will be reread again using the BetVariables() function.

   UpdatePresetBetFlag := 1                  ; this flag is used in TimerFast to indicate when we need to update the preset bet into the betting window

;   Pot := 0
;   Call := 0
;   SmallBlind := 0
;   BigBlind := 0
;   Ante := 0

   FirstToOpenFlag := 0                      ; global var calculated in BetVariables
   Street := ""                              ; globar var calculated in TableStreet


   ControlsEnabled := 0                   ; this flag is set when the Controls are enabled (mouse not in chat box)
                                          ; this is needed because we disable all action keys when the mouse in chat box, so
                                          ;     that they keystrokes can be sent to the chat box instead of doing there
                                          ;     table action




   ; these vars are for detecting the position of a left mouse click
   LeftMouseClickOccurredFlag := 0          ; used to detect when left button is captured



   MinMouseMovement := 5                  ; if the mouse has moved more than this many pixels since the last check, then the mouse is considered to have move
   TableIdArray := 0                      ; array of table ids

;   AutoReloadIdList := ""               ; list of table ids for tables that were just reloaded with chips
;   AutoReloadAtTimeList := ""           ; list of the clock time when we did a reload on this table
;   CheckTableForAutoReloadList := ""    ; list of tables that have had the fold button visible, so it is possible that we
                                        ;     need to do a reload on these tables... list of tables to check for autoreload.

   ManualReloadIdList := ""            ; list of table ids that are being manually reloaded with chips

;   GuiNumList := ""                    ; gui num list for highlighters
;   GuiTableIdList := ""                ; table id list for highlighters
   HighlighterGuiNum := 93             ; 93-96 are gui numbers used for table highlighter bars



   TableIDPendingList := ""            ; table id list for tables that have pending action on them
   TableIDPendingTimeList := ""        ; time that the table id was added to pending list
   TableNamePendingList := ""          ; name of the table that is pending
   
;   PendingTableStartTime := "--"       ; time since the fold button appeared on the current table

   TimeButtonIdList := ""                ; list of table ids where the time button is currently visible
   TimeButtonTimelist := ""            ; list of starting times for when the time button became visible on the table in the ID list above

   PendingActionForTimeButtonIdList := ""                ; list of table ids where the betting box is currently visible
   PendingActionForTimeButtonTimeList := ""            ; list of starting times for when the betting box became visible on the table in the ID list above



;   SharkList := ""                     ; list of known sharks






;   SharkSngTourneyNumList := ""              ; list of tournament numbers that have sharks in them



   InvalidDialogWidthIdList := ""         ; we keep a list of dialog boxes that are open that don't match any that we can close (so that we don't keep trying them)


      Msg0 =
      (  LTrim
         Warning!
         Test this program fully to be sure it does what
         you want and expect. Use this program at your
         own risk. We do not know if it will work correctly
         with your computer hardware or your other
         software. We assume no responsibility for the
         useability of this software for any purpose.
      )

      Msg1 =
      (  LTrim
         The registered version of this software works with
         multiple tables. Registration Instructions are
         on the software's web site documentation.
      )

      Msg2 =
      (  LTrim
         ***********    Important Notice  *************
         You need to upgrade your Software Order Code to work with
         this newer version of the software.
         You may obtain a new Software Order Code for this version
         on our web site (on the ORDER FORM page).
      )



      Msg3 =
      (  LTrim
         Thank you for trying Poker Shortcuts.`n`
         This version of Shortcuts will work with ONE
         real money table open and will automatically
         close if more than one real money table is open.`n
         You may use and test the software with one
         real money table and/or any number of tables
         that say "Play Money" or "Play Chip"
         in their title.`n
         %Msg0%`n
         %Msg1%`n
         Windy Hill Technology LLC`n
      )


         Msg4 =
      (  LTrim
         Custom Text for Displays - Insert any normal text plus these special options:
         !r = next line       !! = !       !2=Italic       !3=bold                                                                                           !$ = Stack Size (OSD 3-5 ONLY)
         !b = Big Blind         !s = Small Blind      !a = Ante       !t = Bet Timer                                                            !n = Number of BB in Stack  (OSD 3-5 ONLY)
         !p = Pot Size   !c = Call Size   !d = Pot Odds   (OSD 1 ONLY - WARNING! see documentation !!)            !m = Harrington's M value  (OSD 3-5 ONLY)
         !x = Bet Amount $  (OSD 1 ONLY)                                                                                                             !e = Harrington's Eff. M value  (OSD 3-5 ONLY)
         !y = `% of Pot Size Bet or Raise  (OSD 1 ONLY)                                                                                         !p = Number of Players at Table  (OSD 3-5 ONLY)
         !z = Pot Size Bet or Raise Amount $  (OSD 1 ONLY)                                                                                 !o = Number of True BB in Stack  (OSD 3-5 ONLY)
         !q = Deal Me mode (e.g. DM:In) (Ring games only)
      )

/*
       Msg5 =
      (  LTrim
         Installation Problem.
         This software is not able to find the location of the file:
         Images/Fonts/480-492-stk0.bmp
         This Images folder needs to be in the
         same location as this Program. When you get this message
         it usually means that you have more than one copy of this
         software on your computer. Try erasing all copies of this
         software, and then re-install this program using the
         installation instructions on the documentation web page.
      )
*/
      Msg6 =
      (  LTrim
         This software is now color calibrated to use a
         standard Full Tilt Green Felt to detect what
         "street" the hand is on (preflop, flop, turn, or river).

         If you use a different colored felt,
         you will need to recalibrate this software.
         See the "Calibrate Felt Colors" instructions
         on the "Calib" tab and on the documentation webpage.
      )

      Msg6a =
      (  LTrim
         This software is now color calibrated to use
         standard (unmodified) Full Tilt Tables  to detect
         the number of seats at the table (for certain types
         of tournament and sng games, namely heads up tables
         and 6 man tables).
         If you you have modified any of the following:
         ....... Green Felt
         ....... Classic Tables empty blue seats
         ....... Racetrack Tables with "Green Carpet"
         and if you plan to play at these types of games,
         then you will need to recalibrate this software
         to the colors that you use on your tables.
         This calibration is needed to detect the number
         of seats at the table, and is only needed if
         you play certain types of tournament or sng games.
         See the "Calibrate Seat Colors" instructions
         on the "Calib" tab and on the documentation webpage.
      )

      Msg7 =
      (  LTrim
         Calibate the software to your table's felt color any time you change
         to a different colored felt. The colors shown should match the color
         of the felt under the board cards. To calibrate, open an empty table
         (or a table with no boards cards present). Click on the table, and
         then click on the Calibrate button at left. The colors will then be
         shown in the boxes.
      )

      Msg8 =
      (  LTrim
         Full Tilt Only: Calibate the software to your table's seat colors
         any time you change the color of the "empty" seats used on the table.
         The colors shown should match the color of the empty seat.
         To Calibrate the software:
         a. Open an empty table with the number of seats shown on button
         b. Click on the table to activate it.
         c. Then click on the button at left to capture the colors.
         d. Repeat a-c for all 4 table types
      )

      Msg9 =
      (  LTrim
         If you want Shortcuts to automatically resize all your tables,
         then set the Table Size . Otherwise set the table size
         to "None". In the A-F boxes, enter a table width (e.g. 800)
         which is the table width in pixels. Or you can enter a width
         and a height (e.g. 640x400) to get a non-standard table size.
         Non-standard table sizes may cause some problems... see the
         program documention on the web for more information.
         
         NOTE: Do NOT use the W x H option when Poker Stars tables are
         open. They can not be resized if a Height is given here.
      )




      Msg11 =
      (  LTrim
         Registering the software will allow the software to work on multiple
         "real money" tables and allows you to use it on two of your own computers.
         Unregistered software will work on only one real money table and multiple
         play money tables.
      )

      Msg12 =
      (  LTrim
         <-- Note: If you click on "Get Unlock Code"
         and you are not taken to our webpage to get your
         unlock code, then go to
         http://www.windyhilltech.com/php/reg.php
         and manually enter your codes.
      )


      Msg13 =
      (  LTrim
         The tables below normally do not need to be changed. See the documentation.
      )

      Msg14 =
      (  LTrim
         All features are Enabled (normal).
         Press Control-ESC to Disable.
      )
      Msg15 =
      (  LTrim
         All features are DISABLED !!!!
         Press Control-ESC to Enable.
      )

      Msg16 =
      (  LTrim
         FOLLOW STEPS 2 and 3 WHEN:
         Installing on your 2nd computer,
         OR installing on a new computer,
         OR if you reformat your hard drive.
         You do not need to contact us for a
         code unless you have misplaced
         your Software Order Code.
      )

      Msg17 := "These are the currently active table themes (which you can change on the Setup tab). Your table color calibration settings (below) will be added to the Calibration.ini files, which are located in the Themes folder. See the documentation for more information."


      Msg18 = 
      (  LTrim
         This software is currently in BETA TEST and it may have some bugs. Use with Caution!
         
         NEW ITEMS:
         On the Setup tab, select the lobby theme that you are using. The new FT lobbies are now listed.
         This version has some problems with correct bet sizes: Verify the amount in betting box before betting!
         
         Not all features are working after the recent major upgrade by Full Tilt.
         
         See our Home Page for status updates.
         
         If you are having any problems see our web documentation for:
         Configuring Poker Shortcuts (these steps are critical for proper operation)
         TroubleShooting Guide
         Current Bug List
         Current Limitations
      )