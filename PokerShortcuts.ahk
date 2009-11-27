
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


/*

PokerShortcuts.ahk


Change the operation of the ClickFold and ClickCall for Stars (to be more like the Full TIlt version)
I changed the FastTimer interval to be 250 so that timerslow would be able to run.
need to Change the size of the search window for buttons, now that the button images are so much smaller

Added Critical to the MouseClick routine...  4.0028 needed ???
Added Critical to BetAmountSet and Get in version 4.0030    needed ????



Update Images:  Misc ab, 
doc:  Misc tab, removed reg tab

4.0032   9/8/09
1. Poker Shortcuts is now an open source program, licensed under GNU GPL version 3. See the license.txt for more info.
2. Source code is not included in the file source.zip
3. If you would like to work on this project, the open source project is located here: http://code.google.com/p/pokershortcuts/
4. Changed the table left, right, up, and down functions to Xander's open source code (more robust than the code used previously in Shortcuts).
5. Fixed problem where sometimes the fold button would be clicked on the top table and the fold button on the table below it. This problem was introduced in 4.0031.
6. Fixed problem where the "Seat Available" dialog box was not being closed (only a problem for a few users). Some users have a different dialog box size.
7. Added checkbox on Misc tab "Use Mouse Movement method to click buttons on Full Tilt". If you are having problem where you see mouse movement when buttons are clicked on Full Tilt, then uncheck this box. Unchecking this will use the method of clicking FT buttons that was used in version 4.0029. Some users have reported that this methods works better for them.


4.0031 8/16/09
1. Fixed problem where the Full Tilt Time button was not being detected at tables with a size of around 600-650 pixels wide
2. Fixed problem with the detection of the Full Tilt Fold button.
3. Fixed problem where focus are being taken away from other programs (when certain actions happened on the table, like clicking the Time button).
4. Fixed problem where if the user's mouse was in the chat box, Shortcuts would still jump to a new table with pending action. Now if the mouse is in the chat area, Shortcuts will not perform many of it's normal actions.
5. On the Inc/Dec Bet tab, changed the top row to allow the user to changes these hotkeys. Top row is only for use with Poker Stars, and is intended for WheelUp and WheelDown hotkeys.
6. Fixed problem where the Full Tilt Post Small Blind button was not being detected at some table sizes. This affected the operation of Deal Me mode also.
7. Fixed problem with the Full Tilt Get Chips hotkey on the Actions 2 tab.

4.0030
Internal test version, never released

4.0029 
1. Fixed problem where two FT Lobby Theme files were missing.

4.0028
1. Fixed problem with Deal Me "Out" Mode on FT tables. Deal Me Out mode was not working correctly if the Auto-Post blinds dialog box came up, and the software would click on Yes (and now it clicks on No) to auto post the blinds.
2. Fixed problem with "Auto-Close SnG and Tournament Lobbies" on the SnG T tab. On FT tables, the software needs to be able to "see" the Register button in order for Shortcuts to be able to close the lobby.
3. Fixed problem with the "Close All Tourney/SnG Lobbies" on the Actions3 tab. If this hotkey is pressed, the software will activate the FT lobbies so that the software can "see" if the Register button is visible or not. On Stars lobbies the lobbies will not be activated.
4. Fixed problem with registering for Stars SnGs, where the final buyin dialog box was not being closed (due to a recent update made by Poker Stars).
5. Fixed problem where FT sngs would be registered when the sng buy-in dialog box is visible when the "Auto-Click the final Buy In button ANYTIME..." checkbox is checked (SnG B tab).
6. Changed the operation of dealing with FT dialog boxes so that they are not continually being activated.
7. Added support for the two new FT lobbies (Basic and Standard). Select the lobby you are using on the Setup tab.
8. Fixed problem where the "Key to Open PS Sng 1" was not working on the SnG T tab.
9. Added new feature: Added two hotkeys to open and register a SnG that is highlighted in the main lobby (added to the SnG T tab) (seperate hotkey for Stars and FT).


4.0027
1. Improved the reliability of clicking on the table. This also improves the features dealing with the betting box. Fixes problem where bets were being placed in the chat box.
2. Fixed problem where some checkboxes were not being detected correctly (due to the recent change by FT where they added the "Make Deal" checkbox). This solves the problem where SnG tables were being closed.


4.0026
1. Improved the auto-closing of the "You finished the tournament" dialog box (Dialog tab)
2. If Shortcuts can not read the Hero's stack for any reason, then the software will still put in bets in the betting box. However, this may cause the Full Tilt software to beep if the bet size is larger than the hero's stack. In previous version, Shortcuts would not put in a bet if the Stack could not be read.
3. Fixed some problems with the betting box on FT tables, where you can now type in a bet size when OSD1 is enabled. You can use the RefreshOSD1 key to manually update the OSD1 display (Display tab) IF you change the bet value manually or if you use your mouse wheel to change the bet value. In other situations, OSD1 will refresh automatically.
4. Added the "Key or mouse code to refresh OSD1" on the Display tab. This is needed to refresh the display if you manually type in a bet or use the mouse wheel to change the bet size (on FT tables).
5. Fixed problem with I'm Ready being auto-clicked (SnG T tab) at some table sizes (on Full Tilt).

4.0025
1. Improved the auto-clicking of the time button with Full Tilt tiled tables.


1. moved the click time button to timerfast (from timer medium)

4.0024
1. Fixed problem with All In bets (Fixed bet tab). The software now pushes the Max button on FT tables and puts in 99999999 bet on Stars tables.
2. Added support for auto-closing the Login dialog box with the new Full Tilt software(Dialogs tab).
3. Added support for auto-closing the Get Chips dialog box with the new Full Tilt software(Dialogs tab).
4. Added support for auto-closing the Seat Available dialog box with the new Full Tilt software (Dialogs tab).
5. Added support for auto-closing the "You finished the tournament" dialog box for SnGs (Dialogs tab)
6. Fixed problem to auto-click the "I'm ready" button. (SnG T tab) Still does not work at all tables sizes.
7. Added support for auto-closing (deny) "Re-Login Attempted" Dialog box ()
8. Fixed problem where the pre-action checkboxes (e.g. fold or call) were being toggled when the Fold hotkey was pressed (even when not enabled on the Actions1 tab).
9. Fixed problems reading buttons at some table sizes. 

4.0023
1. Fixed problem in Calib tab, calibrating street colors, when sometimes an error message "The last active table is not a FT/PS table" would appear.
2. Fixed problem reading checkboxes with tables that were around 600 pixels wide.
3. Improved the reliability of clicking buttons on the table.
4. Improved the reliability of clicking the time button on the table (tiled tables only).
5. Fixed problem where the Auto Post Blinds checkbox was not being checked (when enabled on Deal Me Tab).
6. Fixed problem with Deal Me Mode where the "Wait For Big Blind" button was not being pushed.


4.0022 Beta Release 7/12/09
1. Added preliminary support for the new Full Tilt software including: HotKeys (Actions tab), OSD Displays (Displays tab), betting features (very new and untested). Many features have not been upgraded to work with the new FT software yet!
2. Changed "Auto-Activate the Table the Mouse is Over" setting on Table1 tab such that the "Move Mouse to Home position" does not also have to be checked.
3. Changed the operation of "auto-activate the table the mouse is over" so that a table does not have to be active before this feature works.
4. Changed the operation of the "temporarily move this table to this position" so that the mouse does not also move, unless it is enabled to move too.



4.0018 Beta Release  6/17/09
1. Fixed a problem that a few users were seeing with the registration process at program starup (Error Code 2, Server not found).
2. Fixed problem with the Custom Layout hotkeys on Actions3 tab for Poker Stars tables, Hyper-Simple theme.
3. Changed compiler settings to see if Windows 7 opens PSC without dialog box warnings.


1. Changed to use the WININET.ahk routine to read info from our server.
3. Changed the AHK Compiler "Execution Level" setting to none (was RequireAdministrator)

4.0017 Beta Release   6/15/09
1. Fixed problem reading the "2" digit on Full Tilt tables (Pot and Stack size) on tables around 850 pixels wide.
2. Improved the speed of "mouseover table activation" when you manually move your mouse to a different table (if enabled on the Table 1 tab).

Gary only: changed KeyGen routine because the ComputerName was not being used in the FingerPrint.


4.0016  Beta Release   6/10/09
1. Fixed problem reading the "2" digit on Full Tilt tables (Pot and Stack size) on tables around 900 pixels wide.
2. Fixed problem where the Pot was not being read correctly on Full Tilt Racetrack tables. (Adjusted the Pot Digits Height in racetrack.ini files)
3. Fixed problem where the stack was not being read for the hero on Full Tilt Racetrack 6 person tables. (Hero position was incorrect in racetrack.ini theme files)
4. New Feature: Added list of (user definable) keys and buttons that will temporarily disable many features on Shortcuts (on the Misc tab). See documentation for purpose and usage.
5. Fixed problem with Process Priority on Misc tab (now if PS or FT is started after Shortcuts, then the priority will be set correctly).


4.0015   Beta Release  6/08/09
1. Added feature: "Auto-Click Info Refresh Button"  to the SnG/T tab
2. Fixed problem with "Last Hand" feature on Actions3 tab (on Full Tilt tables).
3. Fixed problem with the Call amount not being read correctly at some table sizes on Poker Stars. This would cause the bet amounts to be incorrect in some cases.

4.0014   Beta Release  6/01/09
1. Fixed a betting problem where sometimes the software would put in a street bet (or fixed bet) of 0 (or a min raise) in the betting box.
2. Fixed a problem where sometimes you would see 2 stacked/cascaded tables "flicker" before the next pending table would be chosen as the next pending table.
3. Corrected pre-flop street bet amount if hero is in the small blind
4. Added a correction to preflop bets when the blinds level is $.02/.05 (where the SB is not half of BB)
5. Fixed problem where some buttons on the table were not being recognized correctly (due to differences in some video cards) by changing color tolerance parameters in the theme.ini files.
6. Fixed problem where sometimes the Call amount was not being read correctly off of the table button (on some video cards) by changing color tolerance parameters in the theme.ini files.
7. Removed some items from the debug display that are not useful to most users.
8. Fixed problem with clicking "No" on Take Seat dialog box on Poker Stars.
9. Fixed problem (again) with the "Automatically put the street bet" checkbox on the Street Bet Trny tab.
10. Added "Class" and "Control" name to debug display.
11. Fixed problem where Poker Stars SnGs were not being opened due to differences in video cards. Changed the color tolerance in the lobby theme.ini files
12. Improved the reliability of the buttons being pushed on Stars tables (e.g. sometimes the user had to hit the fold hotkey twice to get a fold).


4.0013  Beta Release   5/26/09
1. Fixed problem when Shortcuts would close a table or lobby it would cause the FT client software to crash.
2. Updated images for "turbo" SnGs which Stars changed recently, so PSC can now open these SnGs again.
3. Fixed problem where the Debug display was not being displayed at the XY defined on the Displays tab.

4.0012 Beta Release   5/25/09
1. Fixed problem where the setting for "Automatically put the street bet amount in the betting box" on the Street Bet Trny tab was not being saved in the settings correctly.
2. Fixed problem with the "Activate Next Table in Stack" hotkey on the Actions3 tab.
3. Added Checkboxes and additional Buttons to the Debug Display
4. Cleaned up Debug Display
5. Fixed problem with DealMeMode:Out on Stars tables, where Sit Out was not being clicked when the BB came around.
6. Fixed a few problems with detecting buttons on the Poker Stars Hyper-Simple theme (the button images did not match the Stars tables - possible change by PS??).
7. Replaced some of the Button images in the PSTableHyperSimple folder.
8. Changed the table theme files to version 1.01. Added a few new items to these files (see the theme documentation for details).
9. Fixed problem (on FT tables) where the "Auto post blinds" dialog box was not being clicked on NO, if we were in DealMeMode:Out. This would Check the Auto Post Blinds checkbox on the tables, even though we were in "DM:Out" mode.

4.0011 Beta Release   5/15/2009
1. Fixed problem were sometimes the software would bet min instead of the desired Street or Fixed bet (increased delay time for slow Full Tilt tables).
2. Added the "Activate Next Pending Action Table" feature on the Actions 3 tab.
3. Fixed problem where the blinds were not determined correctly in SnGs and tournaments.
4. Fixed problem where the Debug mode enabled was not being saved correctly in the settings when the software exited.
5. Fixed problem with Joystick controls
6. Fixed problem where a table would be activated if the mouse was over it, even though that feature was not enabled on the Table 1 tab.

4.0010  Beta release
1. Added OSD5 on the Displays tab. This allows you to position the mouse in a player's box and get user defined stack information about this player (#BB, M, etc.)
2. Added class name to HudClassList.ini so that PokerHound Hud works.
3. Changed code so that the Inc/Dec Bet functions are faster. It will now keep up with an auto-repeating key that is held down.
4. Changed documentation to note that you need to have "Clear Type" for your font settings in Windows, if you want to open Poker Stars SnGs using the SnG B features.

4.0008    Beta release
1. Added class name to HudClassList.ini so that Poker Ace Hud works.
2. Fixed problem with Bet Clear on the Actions1 tab.
3. Fixed problem with the Custom Layout 1 and 2 features on the Actions3 tab (where this feature would not work correctly with some Windows themes).
         Note: see the documentation on this feature when using it with Stars tables... the item is toggled, so you may have to use it twice to get the desired effect.
4. Changed the code for stacked tables... There was a problem if you had 2 large stacks of tables (one FT and one Stars), then the Stars stack would have priority, and FT tables might time out.
         Note: if you play with stacked/cascaded tables, then your Full Tilt tables should be on one stack, and Stars in another stack. The two different tables should not be in the same stack.
         Note: Changed Full Tilt Lobby requirement:  menu Options... verify that "Display Table on Action" is CHECKED.
5. Changed the code for determining the number of seats at the table. On some stars tables it was incorrect, and this caused the hero's stack to read incorrectly (so OSD3/4 would show wrong stack values).
6. Changed the code for determining the number of seats at a Full Tilt ring game. Now using a faster method without image recognition for this particular case.
7. Changed the OSD3/4 code so that if a table is partially overlayed by another table, it will turn off the OSD3/4 display.
8. Changed the OSD3/4 code so that it would update more quickly, especially if a table becomes active.
9. Changed all 6 of the TableTheme.ini files. These 4 values were added, and 8 values that had similar names were removed
         ButtonLayoutTileTablesOffset
         ButtonLayoutCascadeTablesOffset
         ButtonLayoutCustomLayout1Offset
         ButtonLayoutCustomLayout2Offset
10. Removed the hotkey "Activate Table with Pending Action" from the Actions3 tab.

4.0007    Beta release
1. Improved the speed of the Displays OSD3 and OSD4 in some situations.
2. Changed the registration functions so that if the primary server sends back a database error, then the backup server will be tried.
3. (Hopefully) fixed problem where the ahk error: "The same variable cannot be used for more than one control" would show up in the osdEx function. Added a Critical, On in the Osd1 function.
4. removed some initial support for the Full Tilt new Beta software, as it caused an interference with VLC media player software.

4.0006    Beta release
1. Moved the check for the time button and the I'm back button to the TimerMedium() function
2. Improved the speed of the DealMe Mode for Full Tilt tables


4.0005    Beta release
1. Added check to see if user is running as administrator, and shows message box if not.
2. Added display of the software id code on the Reg tab.
3. Removed the recheck in the PS SNG lobby to see if the same sng was still highlighted (to see if this solves problem that CM is seeing).


4.0004    Beta release
1. (Hopefully) fixed problem where SnGs are now opened on Poker Stars.
2. (Hopefully) fixed problem where sometimes 1 or 2 extra SNGs would be opened.


4.0003    Beta release
1. clarified some error messages dealing with HUDs (in the calibration section).
2. fixed problem where an outlook email message that contained the words "Poker Shortcuts" in the subject could be affected by minimizing or closing the Poker Shortcuts software
3. fixed problem in timerfast() where the function tablependingaction() was being called even if a table was not active (or the mouse was not over an active table)
4. fixed problem with HUD class names where Hold'em Manager creates unique class names for different users. Now we just use the 1st 16 characters of the HEM class name in the HudClassList.ini file.
5. Added the "Auto click the final buy in button anytime the Tournament Registration button is visible" on the Sng B tab. Removed similar feature from SnG T tab.


Version 4.0002
1. First Beta release of Poker Shortcuts

Version 4.0001

Added support for Poker Stars
Changed the way Deal Me mode works
2 click and 3 click now allow keys with modifiers (Fixed tab and Deal Me tab)
big speed improvement
Toggle Auto Muck Hands
mouse can now be over hud items
fixed rebuy tournaments, checkboxes, hero seated
new registration process
move to table left, right, up, and down
move to table lower in stack
move to table at bottom of stack
You can now use keys with modifiers in the 2click ad 3click fixed bet tab.
move to next table left, right, up down
move to next table in stack
move to bottom table in stack



Beta limitations
PS black lobby only
PS Hyper simple table only




***************************************************************************************************************


Digit Recognition Thoughts
   need to capture stack numbers, pot size, call size, some buttons (like fold on stars)

   I have 2 methods...
      1.count the pixels in each column of a number (stop counting when you read a column with no pixels.
         this is good because you don't need to know the background color
         this will usually be used for stack size and for pot size... doesn't work on buttons as the fonts are fuzzy.
         this requires fairly precise placement, so that you don't run into any pixels of the match color in some other area.
      2. digit image recognition... this works well if the fonts are fuzzy and you don't have a constant font color.
            this requires a known background that the user can't change...
            this will usually be used for buttons

Do we need to put "Critical" in functions that use image recognition?  like CheckboxGetState
For the CheckboxSetState function... I'm not using the button name to set the checkboxes on FT... using a mouse click instead
      is this a speed issue? might it be faster to do that




***************************************************************************************************************
To auto detect the street colors, we need to know when we are preflop...   we could look at the pot size, and if it is equal to the blinds plus antes we know we are preflop.


***************************************************************************************************************

Mouse Moves should usually be relative to the screen.  If relative to window, then a Stars table can pop up (and activated) and this will cause
a mouse move to move relative to the active table, which could be the Stars table that just poped up.


***************************************************************************************************************

Gui Numbers


   1-32 for OSD3 stack info displays
   33-64 for OSD4 stack info displays
   
   65-92 SPARE
   
   93-96 table highlight bars
   97 OSD1 for % of pot bet amount
   98 OSD5
   99 main user interface GUI
   
   
   
Tooltip numbers

   7  tooltip showing the Deal Me mode state setting (at top of table)
   8  chat warning message
   9  debug tooltip
   10 Shortcuts is disabled (ctrl esc) appears at top of table

**********************************************************************************************************

to allow PS tables to redraw with the F5 key, add this line to the user.ini file:
f5redrawtable=1
For XP, this file is in c:\Program Files\PokerStars
For Vista:  desktop\AppData\gary\local\PokerStars
you can get there easily by clicking in the PS lobby...help...Open my settings folder

Do we need to put this setting in the theme.ini file to determine if we need
to send the F5 to redraw for this table or not





**********************************************************************************************************


The Poker Stars has Fast tables, and in this case there is no "auto post blinds" checkbox. I put in a test for
fast tables, and if that is the case then the APB checkbox will not be checked if the user in on a fast table (when
clicking the toggle APB on the Actions3 tab).
Added TableFast() to check for this case




**********************************************************************************************************


On screen displays:
Our OSDs sometimes get overwritten by the HM hud. So in the OSD display functions, I check to see that our Display is on top (by checking the class on top),
and if we are not on top, I refresh the osd display.

We keep a class list of all the possible Huds in HudClassList.ini in the settings folder



***********************************************************************************************************

Stack tables issues;
I now recommend that stars and FT tables be in different piles...  there are problems cuz each site can pop their table up to the top
and not know that we have action pending on the other table...  I tried to make Shortcuts handle this, but too many problems.

In each of the poker sites, we now set the options so that their software pops the table to the top.


***********************************************************************************************************


Button images for FT

Most button images are just the first letter of the main word for the button. 






Fold                    F
Check                   H
Post SB                 SB or SM
Post BB                 BB or BI
Deal Me In              D plus 1 pixel on right           D gets confused with Fold
I'm Back                B plus 2 pixels on right


Call                    C
Wait for BB             W


Raise                    R
I'm Ready                Y 
Call (stars only)        C
Sit Out                  Sit



Other positions:
I'm Back                B plus 2 pixels
Time                    T



***********************************************************************************************************

*/  







; This code is run when the script first starts
StartUp:





   #include PokerShortcutsVariables.ahk
   #include PokerShortcutsPixelCounts.ahk







   ; define group definitions for poker tables and lobbies
   ; GroupAdd, name, "text in title",,, "text not in title"

   GroupAdd, PokerShortcuts, Poker Shortcuts ahk_class AutoHotkeyGUI

   GroupAdd, Lobby, Full Tilt Poker - Logged In As ahk_class QWidget
   GroupAdd, Lobby, PokerStars Lobby ahk_class #32770,,,Tournament

   GroupAdd, TournamentLobby, Full Tilt Poker - Tournament ahk_class QWidget
   GroupAdd, TournamentLobby, Lobby ahk_class #32770,,,PokerStars

;   GroupAdd, Tables, ahk_class FTC_TableViewFull
   GroupAdd, Tables, ahk_class PokerStarsTableFrameClass
   GroupAdd, Tables, - Logged In As ahk_class QWidget,,,Full Tilt Poker -


   GroupAdd, FTTables, - Logged In As ahk_class QWidget,,,Full Tilt Poker -
   GroupAdd, PSTables, ahk_class PokerStarsTableFrameClass
   
   GroupAdd, LastHand, Last Hand History ahk_class QWidget
   GroupAdd, LastHand, Instant Hand History ahk_class #32770
   
   GroupAdd, Cashier, Cashier - ahk_class QWidget
   GroupAdd, Cashier, Cashier ahk_class #32770
   
   GroupAdd, Notes, Player Note: ahk_class QWidget
   ; no equivalent window for Poker Stars
   
   GroupAdd TournamentInfo, Tournament Status ahk_class QWidget
   ; no equivalent window for Poker Stars
   
   
   
   ; create a group for FT major windows
   GroupAdd, FTWindow, Full Tilt Poker - Logged In As ahk_class QWidget
   GroupAdd, FTWindow, Full Tilt Poker - Tournament ahk_class QWidget
   GroupAdd, FTWindow, - Logged In As ahk_class QWidget,,,Full Tilt Poker -

   
   ; create a group for PS major windows
   GroupAdd, PSWindow, PokerStars Lobby ahk_class #32770,,,Tournament
   GroupAdd, PSWindow, Lobby ahk_class #32770,,,PokerStars
   GroupAdd, PSWindow, ahk_class PokerStarsTableFrameClass
   
   ; create a group for just the FT lobby
   GroupAdd, FTLobby, Full Tilt Poker - Logged In As ahk_class QWidget

   ; create a group for just the PS lobby
   GroupAdd, PSLobby, PokerStars Lobby ahk_class #32770,,,Tournament
   
   ; create a group for the PS Options dialog box
   GroupAdd, PSOptions, Options ahk_class #32770
   
   ; create a group for the PS tournament lobby
   GroupAdd, PSTournamentLobby, Lobby ahk_class #32770,,,PokerStars

   ; create a group for the FT tournament lobby
   GroupAdd, FTTournamentLobby, Full Tilt Poker - Tournament ahk_class QWidget

   GroupAdd, SngTables, Sit & Go ahk_class QWidget,,,Play Money
   GroupAdd, SngTables, Madness ahk_class QWidget,,,Play Money
   GroupAdd, SngTables, Sit&Go ahk_class QWidget,,,Play Money
   GroupAdd, SngTables, Play Money Sit & Go ahk_class QWidget
   GroupAdd, SngTables, Play Money KO Sit & Go ahk_class QWidget
   
   GroupAdd, SngTables, Tournament ahk_class PokerStarsTableFrameClass                 ; we can't exclude regular tournaments here
   
   
   ; Stars dialog boxes
   GroupAdd, Dialogs, ahk_Class #32770,,,PokerStars Lobby,
   
   ; FT dialog boxes - ignore tables/lobbies that are class: QWidget by check for "- Logged In As"
   GroupAdd, QWidgetDialogs, ahk_class QWidget,,,- Logged In As ,
   
   
   ; ??????????????????????????????????????????????????????????????????????????????????   haven't updated these yet  ????????????????????????????????????????????
   GroupAdd, FTPSeatAvailable, Waiting List Options
   GroupAdd, FTPAnnouncements, Announcements








   
   
   
   



   
   

;CoordMode,Mouse,Relative
;CoordMode,Tooltip,screen
;CoordMode, Pixel, Relative


/*

Loop
{

   DisplayDebugTooltip()
;outputdebug, inloop

   sleep, 300

}
*/

; ******************************************************************************************************
; ******************************************************************************************************
; ******************************************************************************************************
; ******************      Start of code                      *******************************************
; ******************************************************************************************************
; ******************************************************************************************************
; ******************************************************************************************************



   ; AHK Initialization

   ;  #MaxMem 1

   ; keeps the timers running
   #Persistent
   ; allow window title matches to be partial matches
   SetTitleMatchMode, 2

;#InstallKeybdHook
;#InstallMouseHook

   ; slow mouse clicks down a little for full tilt tables
   SetMouseDelay, 30

   ; improve keystrokes to dialog boxes
   ;      1st parameter is delay between Send and ControlSend commands; press duration is 2nd parameter
   ;SetKeyDelay,20,20
   SetKeyDelay,10,10      

   ; there does not seem to be a need for this, removed in ver 3.16
   ; If this OnExit line is present, then the exit subroutine gets called twice. Once
   ; when the user clicks on the Red x, and then again at the end of the subroutine with the ExitApp code.
   ; Lets add a OnExit event trap. Allows us to save preferences on exit
   ;OnExit, ExitSub

   ; set to display math calculations to 2 decimal places
   SetFormat, floatfast, 0.2
   ; only allow one instance of this script to run
   #SingleInstance force
   ; Avoids checking empty variables to see if they are environment variables
   #NoEnv
   ; set the max # of hotkeys per interval to a higher value (default is 70), in case
   ;     the user is just twittling the mouse wheel inadvertantly...
   ;     this will prevent a dialog box asking the user if he knows he
   ;     is generating a lot of hot keys per second.
   #MaxHotkeysPerInterval 200

   ; Switch to the SendInput method for Send, Click, and MouseMove/Click/Drag
   ;     this has good speed and reliability.   It blocks user keystrokes and mouse
   ;     movements during Send operations
   SendMode Input

   ; if set for 20ms, then script will sleep for 10ms every time it runs for 20 ms
   ; if set to -1 then script will run as fast possible, and not give up any cpu time while it is busy
   ;SetBatchLines, -1
   SetBatchLines, 20ms

   ; have the scripts working directory be the directory that the script is in
   SetWorkingDir %a_scriptDir%

   ; String comparisons and StringReplace are case sensitive
   StringCaseSense, On



   ; put all tooltips on relative to the current window
   CoordMode, ToolTip, Relative



   



;outputdebug, PSBoxBetEditControlName=%PSBoxBetEditControlName%    StandardActiveWidth=%StandardActiveWidth%



   ; ******************************************************************************************************
   ; ****************     Create the GUI        ***********************************************************
   ; ******************************************************************************************************

;   SettingsGui()


   ; ******************************************************************************************************
   ; ****************     READ PREFERENCES       ***********************************************************
   ; ******************************************************************************************************
   ; Note: these are all global variables too


   ; create the directory for the settings, in case it does not exist
   FileCreateDir, Settings


   ; read in the primary settings from the [Prefs] section of the PokerShortcuts.ini file
;   IniRead OrderUnlockCode, Settings\PokerShortcuts.ini, Prefs, OrderUnlockCode, Place_Unlock_Code_Here

   IniRead, VerInPreferences, Settings\PokerShortcuts.ini, Prefs, Ver, 0                  ; ?????????????????????????????   not used for anything  ???????????????????????????????
   IniRead, GuiX, Settings\PokerShortcuts.ini, Prefs, GuiX, %InitialGuiX%
   IniRead, GuiY, Settings\PokerShortcuts.ini, Prefs, GuiY, %InitialGuiY%
   IniRead, CurrentSetNum, Settings\PokerShortcuts.ini, Prefs, CurrentSetNum, 1


   IniRead, PSSettingsFolder, Settings\PokerShortcuts.ini, Prefs, PSSettingsFolder, %A_Space%
   IniRead, PSHHFolder, Settings\PokerShortcuts.ini, Prefs, PSHHFolder, %A_Space%
   IniRead, FTHHFolder, Settings\PokerShortcuts.ini, Prefs, FTHHFolder, %A_Space%



;outputdebug, Just read [Prefs]   CurrentSetNum= %CurrentSetNum%     Ver= %VerInPreferences%   guix=%GuiX%   guiy=%GuiY%




      ;MsgBox,4096,, %Msg18%

   if NOT A_IsAdmin
   {
      MsgBox,4096,, `nThis software must be run as 'Administrator'. `n`nExit the program and then right click on the program name or icon and check: 'Run as administrator'.`n`nFor more info, please see the 'Vista' section in this program's troubleshooting guide at our website:   www.windyhilltech.com

   }

;   if not A_IsAdmin
;   {
;      DllCall("shell32\ShellExecuteA", uint, 0, str, "RunAs", str, A_AhkPath
;         , str, """" . A_ScriptFullPath . """", str, A_WorkingDir, int, 1)
;      ExitApp
;   }


   ; determine the PS settings folder - this should never change
   If NOT PSSettingsFolder
	{
		If A_OSVersion in WIN_VISTA		;if it's vista the default path is in AppData
				PSSettingsFolder := A_AppData . "\Pokerstars"
		Else							;if it's xp/2k/ME/98 it's in program files so use that as the default path
				PSSettingsFolder := A_ProgramFiles . "\Pokerstars"
	}
	; if the path contains the word "roaming", change it to local
	StringReplace,PSSettingsFolder,PSSettingsFolder,Roaming,Local,All


   ; if we couldn't find the PS settings folder, then erase it
	IfNotExist, %PSSettingsFolder%
	{
		PSSettingsFolder := ""
	}

   ; if we couldn't find the PSHHFolder, then try to get it from the user.ini file
	IfNotExist, %PSHHFolder%
	{
      ; get the path to the user.ini file
      UserIniFilePath := PSSettingsFolder . "\user.ini"
      ifExist %UserIniFilePath%
      {
         ; read the hh folder path from the user.ini file
         IniRead, PSHHFolder, %UserIniFilePath%, Options,SaveMyHandsPath
         ; check if the hh folder exists
         ifExist %PSHHFolder%
         {
            ; get the first user name in the folder
            Files := PSHHFolder . "\*.*"
            Loop, %Files%,2,0
            {
               ; get the first HH user name folder that was present in the HH folder that poker stars specified
               PSHHFolder := A_LoopFileLongPath
            }
         }
      }
      else
         PSHHFolder := ""
	}

   ; if we couldn't find the FTHHFolder, then make a guess at what it is
	IfNotExist, %FTHHFolder%
	{
	
		If A_OSVersion in WIN_VISTA		;if it's vista the default path is in AppData
				FTHHFolder := A_AppData . "\HandHistory"
		Else							;if it's xp/2k/ME/98 it's in program files so use that as the default path
				FTHHFolder := A_ProgramFiles . "\Full Tilt Poker\HandHistory"
;outputdebug, here1  %FTHHFolder%
	  ; if the path contains the word "roaming", change it to local
	  StringReplace,FTHHFolder,FTHHFolder,Roaming,Local,All
	
      ; see of we can find the user name of the player
		ifExist %FTHHFolder%
      {
         ; get the first user name in the folder
         Files := FTHHFolder . "\*.*"
         Loop, %Files%,2,0
         {
            ; get the first HH user name folder that was present in the HH folder that poker stars specified
            FTHHFolder := A_LoopFileLongPath
         }
      }
;outputdebug, here2  %FTHHFolder%
      ifNotExist %FTHHFolder%
         FTHHFolder := ""
	}
;outputdebug, here3  %FTHHFolder%

   ; read in our main settings for the CurrentSetNum
   SettingsRead(CurrentSetNum)


   ; set this GUI variable (which is not saved in the settings PokerShortcuts.ini file)
   ChangeToNewCurrentSetNum := CurrentSetNum
   
   

   ; determine the list of themes, these are used for the dropdown list of possible themes on the setup tab
   ; the hard drive is read for this, so this should only be done once inside the program

   FTLobbyThemeList := ""
   Files := A_WorkingDir . "\Themes\FTLobby*.ini"
   Loop, %Files%,0,0
   {
      FTLobbyThemeList .= "|" . A_LoopFileName
      ; remove the ".ini" from file name
      StringTrimRight, FTLobbyThemeList, FTLobbyThemeList, 4
   }
   ; remove the initial "|" because the first time the gui is set up you don't want the leading "|"
   StringTrimLeft,FTLobbyThemeList,FTLobbyThemeList,1
;outputdebug, FTLobbyThemeList:  %FTLobbyThemeList%
   
   
   FTTableThemeList := ""
   Files := A_WorkingDir . "\Themes\FTTable*.ini"
   Loop, %Files%,0,0
   {
      FTTableThemeList .= "|" . A_LoopFileName
      ; remove the ".ini" from file name
      StringTrimRight, FTTableThemeList, FTTableThemeList, 4
   }
   ; remove the initial "|" because the first time the gui is set up you don't want the leading "|"
   StringTrimLeft,FTTableThemeList,FTTableThemeList,1
;outputdebug, FTTableThemeList:  %FTTableThemeList%
   
   
   PSLobbyThemeList := ""
   Files := A_WorkingDir . "\Themes\PSLobby*.ini"
   Loop, %Files%,0,0
   {
      PSLobbyThemeList .= "|" . A_LoopFileName
      ; remove the ".ini" from file name
      StringTrimRight, PSLobbyThemeList, PSLobbyThemeList, 4
   }
   ; remove the initial "|" because the first time the gui is set up you don't want the leading "|"
   StringTrimLeft,PSLobbyThemeList,PSLobbyThemeList,1
;outputdebug, PSLobbyThemeList:  %PSLobbyThemeList%


   PSTableThemeList := ""
   Files := A_WorkingDir . "\Themes\PSTable*.ini"
   Loop, %Files%,0,0
   {
      PSTableThemeList .= "|" . A_LoopFileName
      ; remove the ".ini" from file name
      StringTrimRight, PSTableThemeList, PSTableThemeList, 4
   }
   ; remove the initial "|" because the first time the gui is set up you don't want the leading "|"
   StringTrimLeft,PSTableThemeList,PSTableThemeList,1
   
;outputdebug, PSTableThemeList:  %PSTableThemeList%
   
   


   
;outputdebug, initial starting themes:  %PSLobbyTheme%  %FTLobbyTheme%  %PSTableTheme%  %FTTableTheme%
   
   

   

   ; now that we know what Theme to use (from our settings file)...
   ; read in our control variables for both FT and PS lobbies and tables
   ; Read in all of the theme .ini  file variables
   ; NOTE: we read these here, even tho they are read below in the call to SettingsUpdateDependentVariables("All")
   ;     because we need the PSSngFileList which is generated here for the SettingsGui() coming up next below
   IniReadAllThemes()
   
   

   
   ; create the gui and populate it with all of the variables that we read in above
   SettingsGui()
   

   ; Need this after where we read the preferences to get the GuiX, GuiY, so we can show the application at the previous location on screen
   ; Show the GUI...   if GuiX is less then 0, it might be off the page or minimized, so restore GUI to 0,0
   if GuiX < 0
      Gui, Show, x%InitialGuiX% y%InitialGuiY% h%InitialGuiH% w%InitialGuiW%, %Title%
   else
      Gui, Show, x%GuiX% y%GuiY% h%InitialGuiH% w%InitialGuiW%, %Title%
   


   ; write settings to the GUI
   ; this one GUI element is not saved to the PokerShortcuts.ini file settings
   GuiControl, ChooseString, ChangeToNewCurrentSetNum, % ChangeToNewCurrentSetNum


;   we don't need to write to the GUI here because the GUI was populated right in the SettingsGui() function above
;   SettingsWriteToGui()
   
   


   ; set up our hotkeys
   SettingsUpdateHotkeys(-1)


   ; check if the Sharklist files exists... if not, then create it
;   IfNotExist, Settings\SharkList.txt
;   {
;      FileAppend,
;      (
; Close the Poker Shortcuts software before adding shark names here.
; Only put one shark's name per line. Comment lines start with a ;
; No commas are allowed in the Sharks names

;      ), Settings\SharkList.txt

;   }


/*
   Loop, read, Settings\SharkList.txt
   {
      ;ignore comment lines
      if (InStr(A_LoopReadLine, ";") == 1)
         continue
         
      ; add all the other lines to the List
      ListAddItem(SharkList,A_LoopReadLine)

   }
*/   

;   the code should not leave us with any carriage returns or line feeds, so I commented these lines out
;   StringReplace, SharkList,SharkList,`n`r,`,,All          ; replace all `n`r with `,
;   StringReplace, SharkList,SharkList,`r`n,`,,All          ; replace all `r`n with `,
;   StringReplace, SharkList,SharkList,`n,`,,All          ; replace all `n with `,
;   StringReplace, SharkList,SharkList,`r,`,,All          ; replace all `r with `,
;   ListClean(SharkList)                     ; clean up the list... remove all leading and trailing junk
   
   
;outputdebug, SharkList:%SharkList%



   ; read in the HUD class list

   Loop, read, Settings\HudClassList.ini
   {
      ;ignore comment lines
      if (InStr(A_LoopReadLine, ";") == 1)
         continue

      ; add all the other lines to the List
      ListAddItem(HudClassList,A_LoopReadLine)

   }

;   the above code should not leave us with any carriage returns or line feeds, so I commented these lines out
;   StringReplace, SharkList,SharkList,`n`r,`,,All          ; replace all `n`r with `,
;   StringReplace, SharkList,SharkList,`r`n,`,,All          ; replace all `r`n with `,
;   StringReplace, SharkList,SharkList,`n,`,,All          ; replace all `n with `,
;   StringReplace, SharkList,SharkList,`r,`,,All          ; replace all `r with `,
   ListClean(HudClassList)                     ; clean up the list... remove all leading and trailing junk


;outputdebug, HudClassList:%HudClassList%



   if MinimizeShortcutsEnabled
      WinHide ahk_group PokerShortcuts





   Gui, 99:Default
   SngContinuousStatus := "Stopped"
   GuiControl,,SngContinuousStatus, %SngContinuousStatus%
   
   ; configure the starting condition of the buttons
   GuiControl, Enable, SngStart
   GuiControl, Disable, SngPause
   GuiControl, Disable, SngResume
   GuiControl, Disable, SngStop




      
   ; update the dependent items, which also reads in the THEME.ini files in case there has been a theme change
   ; we read the theme here again, even tho it is read above, cuz we need to update other dependent variables, like the joystick and system priorities
   ; this also updates things like the Joystick timer and the System priorities
   SettingsUpdateDependentVariables("All")
      
      
   ;   set the priority lower on the timer, so that hotkeys will have a higher priority.
   ;  If you don't set the priority lower, then some how keys will be missed, since the timer
   ;  function is long.
   SetTimer, TimerFast, %TimerFastInterval%, %TimerFastPriority%
   SetTimer, TimerMedium, %TimerMediumInterval%, %TimerMediumPriority%
   SetTimer, TimerSlow, %TimerSlowInterval%, %TimerSlowPriority%
   SetTimer, SngContinuouslyOpen, % SngContinuouslyOpenTimerInterval * 1000, %SngContinuouslyOpenTimerPriority%
      

Return
; ---------------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------------
; End of Start Up Code
; ---------------------------------------------------------------------------------------
; ---------------------------------------------------------------------------------------





; These are the files that are included to make up the entire Poker Shortcuts project



   #include FunctionsAhk.ahk
   #include FunctionsBet.ahk
   #include FunctionsButton.ahk
   #include FunctionsCalib.ahk
   #include FunctionsCasino.ahk
   #include FunctionsCheckbox.ahk
   #include FunctionsColor.ahk
   #include FunctionsControl.ahk
   #include FunctionsDealMeMode.ahk
   #include FunctionsDebug.ahk
   #include FunctionsDialogs.ahk
   #include FunctionsDigit.ahk
   #include FunctionsDisplayOSD.ahk
   #include FunctionsFile.ahk
   #include FunctionsHandHistory.ahk
   #include FunctionsHero.ahk
   #include FunctionsHighlighter.ahk
   #include FunctionsHotkey.ahk
   #include FunctionsIni.ahk
   #include FunctionsJoystick.ahk
   #include FunctionsList.ahk
   #include FunctionsLobby.ahk
   #include FunctionsList.ahk
   #include FunctionsMisc.ahk
   #include FunctionsMouse.ahk
   #include FunctionsNextWindow.ahk   
   #include FunctionsNotes.ahk
   #include FunctionsPlayer.ahk
   #include FunctionsReload.ahk
   #include FunctionsSettings.ahk
   #include FunctionsSng.ahk
   #include FunctionsTable.ahk
   #include FunctionsTableNext.ahk
   #include FunctionsTableOverlay.ahk
   #include FunctionsTime.ahk
   #include FunctionsTimer.ahk
   #include FunctionsWindow.ahk






   
   
   




   

   
   




















#IfWinActive


/*


F11::
WinId := WinActive("A")
ControlGet, junko1, Visible, , QWidget86, ahk_id%WinId%
outputdebug, junko1=%junko1%
ControlGet, junko2, Visible, , QWidget29, ahk_id%WinId%
outputdebug, junko2=%junko2%
return

F11::
   WinId := WinActive("A")


   junko := CheckboxChangeName("CheckboxSitOutNextHand",WinId)
   outputdebug, name=%junko%
return



F1::
   WinId := WinActive("A")
   junko := BetAmountGet(WinId)
   outputdebug, junko=%junko%

return


WinId := WinActive("A")

outputdebug, F1 pushed

   X:= 133
   Y:= 485

;sleep 50   
      ; mouse down command
      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
                                                      
      sleep,0 
      ; mouse up command
      PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%   
      sleep, 0
      
     
      
clipboard := ""

;   MouseClickItemLocation("BoxBetEdit",WinId)      
      
   SetKeyDelay,10,10   
      
;sleep, 500
   ControlSend,,^a,ahk_id%WinId%
;   sleep,0
   ControlSend,,^c,ahk_id%WinId%   
;   sleep, 0
  
 
 
    ; click the mouse in the betting box
   
sleep 150   
      ; mouse down command
      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
                                                      
      sleep,0 
      ; mouse up command
      PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%   
      sleep, 0



   junko := clipboard
   outputdebug, junko=%junko%
   
return








F7::
   WinId := WinActive("ahk_group Tables")
   junko := TablePot(WinId)
   outputdebug, pot: %junko%
return



F8::
   WinId := WinActive("ahk_group Tables")
   MouseGetPos,X,Y
      BetAmount := DigitSearchByPixelCount(X,Y,60,12, "Pot", DummyByRef, WinId)
   outputdebug, BetAmount = %BetAmount%    %DummyByRef%
return




F7::
   WinId := WinActive("ahk_group Tables")
   Value := BetAmountGet(WinId)
   outputdebug, BetValue = %Value%
return

F8::
   WinId := WinActive("ahk_group Tables")
   Value := BetAmountSet(123,WinId)
   outputdebug, Bet set to 123
return


F8::
   WinId := WinActive("ahk_group Tables")
      BetAmount := DigitSearchByPixelCount(688,442,60,12, "Stack", DummyByRef, WinId)
   outputdebug, BetAmount = %BetAmount%    %DummyByRef%
return

F8::
   WinId := WinActive("ahk_group Tables")
   Value := BetAmount(WinId)
   outputdebug, BetValue = %Value%
return


F8::
   SoundPlay, *64
return


F8::
   WinId := WinActive("ahk_group Tables")
   outputdebug,WinId=%WinId%
return



F9::
coordmode, mouse, screen
MouseGetPos,X,Y
WinId := WindowOnTopAtXY(X,Y)
WinGet, Process, ProcessName, ahk_id%WinId%
Class := ClassOnTopAtXY(X,Y)
outputdebug, WinId:%WinId%   Process:%Process%   Class:%Class%
return



F8::
WinMenuSelectItem, Full Tilt Poker - Logged In, , Options, Auto Muck Hands
WinMenuSelectItem, PokerStars Lobby - Logged in, , Options, Muck Losing Hand
WinMenuSelectItem, PokerStars Lobby - Logged in, , Options, Don't Show Winning Hand
return



F8::
WinId := WinActive("A")
      Flag := HandHistoryFilePath(WinId)
      handhistory := handhistory(WinId)
outputdebug, HandHistoryFilePath:%Flag%
outputdebug, HandHistory:%handhistory%
return




F8::
outputdebug,   TableIDPendingList:%TableIDPendingList%
return


F8::
WinId := WinActive("A")
PosX := 774
PosY := 531

WindowScaledPos(PosX, PosY, ClientScaleFactor, "Screen", WinId)
junko := ColorGetAtXY(PosX,PosY)
outputdebug, color:%junko%
return


F9::
WinId := WinActive("A")
junko := TableRingOrTournament(WinId)
outputdebug, junko:%junko%
return

F10::
FTColorSampleSeats(9)
return

F8::
WinId := WinActive("A")
   Flag := ButtonClick("ButtonFold", WinId)
Heroseated := HeroSeated(WinId)
outputdebug, seated:%Heroseated%     checkbox:%Flag%
return

F9::
coordmode, mouse, screen
MouseGetPos,X,Y
WinId := WindowOnTopAtXY(X,Y)
WinGet, Process, ProcessName, ahk_id%WinId%
Class := ClassOnTopAtXY(X,Y)
outputdebug, WinId:%WinId%   Process:%Process%   Class:%Class%
return
x

F8::
WinId := 0x222426
   Flag := CheckboxGetState("CheckboxSitOutNextHand", WinId)
Heroseated := HeroSeated(WinId)
outputdebug, seated:%Heroseated%     checkbox:%Flag%
return




F6::
   WinId := WinActive("A")
   osdEx(HelloWorld, "", "", 300, 300, 8)
return


F7::
; e.g. run an internet explorer window and go to the page: "about:blank" so that is the start of the title text
;   then run this script and it adds a gui window onto the internet explorer window.
; Some programs, such as notepad and calculator, don't seem to work properly with this technique.

WinId := WinActive("A")

size := 15
Color := "White"

   theme = s%size% c%color%
   font := iif( font, font, "Comic Sans MS" )



;   Gui, +Lastfound +Toolwindow +AlwaysOnTop
;   Gui, Color, Black
;   WinSet, TransColor, Black
;   Gui -Caption
;   Gui, Margin, 0, 0
;   Gui, Font, %theme%, %font%



;   WinSet, Transparent, 128                        ; makes the entire parent transparent behind the gui
;   Gui, 7: +Toolwindow  +AlwaysOnTop
   Gui, 7: +Lastfound +Toolwindow +AlwaysOnTop
   Gui, 7: Color, Black
   WinSet, TransColor, Black
   Gui 7: -Caption  +Toolwindow

   Gui, 7: Margin, 0, 0
   Gui, 7: Font, %theme%, %font%
;   Gui, Add, Text, vosdEx_msg w%width% %center%, %msg%      ; adds a text control to the GUI, with the name of   osdEx_msg
   ; I removed the WIDTH command because it was defaulting to a_screenwidth if I didn't specify it... the display was then on top of a lot of stuff across the screen.
   ; if you don't specify width, it just takes up as much width as the text needs
   Gui, 7: Add, Text,, This gui is stuck to the parent... `nbut I haven't programmed it to do anything `;-)
   Gui, 7: +E0x20 ; WS_EX_TRANSPARENT - allows a mouse to be able to click thru this overlay window (and move something below it)



;Gui, 7: Margin, 0, 0
;Gui, 7: +ToolWindow ; -Caption ; no title, no taskbar icon
;Gui, 7: Add, Text,, This gui is stuck to the parent... `nbut I haven't programmed it to do anything `;-)
SetParent(WinId, 7) ; can be done before or after showing the gui
;SetParent(WinId, 7) ; can be done before or after showing the gui
Gui, 7: Show, x200 y320

Return



Set_Parent_by_title(Window_Title_Text, Gui_Number) ; title text is the start of the title of the window, gui number is e.g. 99
{
  WinGetTitle, Window_Title_Text_Complete, %Window_Title_Text%
  Parent_Handle := DllCall( "FindWindowEx", "uint",0, "uint",0, "uint",0, "str", Window_Title_Text_Complete)
  Gui, %Gui_Number%: +LastFound
  Return DllCall( "SetParent", "uint", WinExist(), "uint", Parent_Handle ) ; success = handle to previous parent, failure =null
}





F8::
WinId := WinActive("A")
hero := HeroName(WinId)                  ;(ahk_id%WinId%)
;Flag := CheckboxGetState("CheckboxSitOutNextHand", WinId)
   ;;FilePath := HandHistoryFilePath(WinId)
   outputdebug, hero:%hero%    hero:%HeroName1%
return



F8::
WinId := WinActive("A")
hh := FTHandHistory(WinId)                  ;(ahk_id%WinId%)
;Flag := CheckboxGetState("CheckboxSitOutNextHand", WinId)
   ;;FilePath := HandHistoryFilePath(WinId)
   outputdebug, hh:%hh%
return




F8::
WinId := WinActive("A")
      ; local  WindowIdList, WinId, WinX, WinY, WinW, WinH, TestWinId
X := 1635
Y := 40
      ; get a list of all windows on the user's computer
      WinGet, WindowIdList, List
      ; loop thru all of these dialog boxes and see if we need to operate on any of them

      Loop, %WindowIdList%
      {
         ; get the next windows id
         TestWinId := WindowIdList%A_index%
         WinGetPos,WinX,WinY,WinW,WinH,ahk_id%TestWinId%
         
         WinGetClass, Class, ahk_id%TestWinId%
         

         ; see if our XY is in the range of this window TestWinId
         if ( (X >= WinX) AND (X <= (WinX + WinW)) AND (Y >= WinY) AND (Y <= (WinY + WinH)) )
         {
Msgbox, WinId: %WinId%  TestWinId:%TestWinId%   %WinX%   %WinY%   %WinW%   %WinH%   Class:%Class%
            ; if this testwinid is the same as the user's, then the user's window is on top at this point... return 0
            if (WinId == TestWinId)
               return
            ; else some other window is on top, so return 1 indicating that we are not on top
            else
               return
         }

      }

return




F8::
WinId := WinActive("A")
HeroIsSeated := HeroSeated(WinId)                  ;(ahk_id%WinId%)
Flag := CheckboxGetState("CheckboxSitOutNextHand", WinId)
   ;;FilePath := HandHistoryFilePath(WinId)
   outputdebug, Flag:%Flag%
return




F8::
WinId := WinActive("A")
seats := TableSeats(WinId)                  ;(ahk_id%WinId%)
players := TablePlayers(WinId)
   ;;FilePath := HandHistoryFilePath(WinId)
   outputdebug, seats:%seats%    players:%players%
return

F9::
coordmode, mouse,screen
mousegetpos, mouseX,mouseY,mouseWinId
OnTopWinId := WindowOnTopAtXY(mouseX,mouseY)
wingettitle, title, ahk_id%OnTopWinId%
outputdebug, mouseWinId:%mouseWinId%    Win on top %OnTopWinId%   %title%
return

/*


F8::
WinId := 0x1075a   ;WinActive("A")
junko := WinGetTitle("ahk_id " . WinId)                  ;(ahk_id%WinId%)
   ;;FilePath := HandHistoryFilePath(WinId)
   outputdebug, junko:%junko%
return


F9::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
DllCall("QueryPerformanceCounter", "Int64 *", CounterBefore)

WinId := WinActive("A")
junko1 := HandHistoryFilePath(WinId)

DllCall("QueryPerformanceCounter", "Int64 *", CounterAfter)
Counter := 1000 * (CounterAfter - CounterBefore) / CounterFrequency

outputdebug, time(ms): %Counter%   filepath:%junko1%


;WinId := 0x1c717ea
;junko1 := ButtonVisible("ButtonImBack",WinId)
;outputdebug, ButtonVisible:%junko1%
Return





F8::
WinId := WinActive("A")
outputdebug, WinId:%WinId%
junko0 := WinGetTitle("ahk_id" . WinId)
junko1 := HandHistoryFilePath(WinId)
junko2 := HandHistoryIsNew(WinId)
junko3 := HandHistory(WinId)
junko4:= HeroName(WinId)
outputdebug, WinId:%WinId%
outputdebug, heroname:%junko4%
outputdebug, title:%junko0%
outputdebug, hhFilePath:%junko1%
outputdebug, hhFile is New: %junko2%
outputdebug, Date1:%Date1%
outputdebug, Criteria2:%Criteria2%
if junko2
   outputdebug, %junko3%
Return





F9::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
DllCall("QueryPerformanceCounter", "Int64 *", CounterBefore)

;WinId := WindowOnTopAtXY(2000,0)
junko1 := WindowIsOverlayed(0x134236e)

DllCall("QueryPerformanceCounter", "Int64 *", CounterAfter)
Counter := 1000 * (CounterAfter - CounterBefore) / CounterFrequency

outputdebug, overlayed:%junko1%    time(ms):%Counter%


;WinId := 0x1c717ea
;junko1 := ButtonVisible("ButtonImBack",WinId)
;outputdebug, ButtonVisible:%junko1%
Return





F8::

      WinId := WinActive("A")
   outputdebug, in F8 command   WinId:%WinId%
   WinMinimize, ahk_id%WinId%   ahk_group PSTournamentLobby
   WinClose, ahk_id%WinId%   ahk_group PSTournamentLobby
;      ControlSend,,!{F4}, ahk_id%WinId%
;      PostMessage, 0x112, 0xF120,,, ahk_id%WinId%           ; ahk_group PSTournamentLobby
return



F8::
keyhistory
return

F9::
StatusNum := 0
SngTournamentNum := 0
SngLobbyId := 0
PSSngOpen(1, StatusNum, SngTournamentNum, SngLobbyId)
outputdebug, returned from opening sng    StatusNum:%StatusNum%     SngTournamentNum:%SngTournamentNum%    SngLobbyId:%SngLobbyId%
return


*/

#IfWinActive,  ahk_group Tables

/*


; this is a test to try resetting the betting info, so that it can refresh itself if needed
!F1::


   UpdateBettingVarsFlag := 1       
   UpdatePresetBetFlag := 1

return





F12::

MouseGetPos,,,MouseId

UserBusyFlag := TablePendingAction(MouseId)

outputdebug, WinId=%MouseId%    UserBusyFlag=%UserBusyFlag%

return   



; !!!!!!!!!!!!!!!!   USEFUL FUNCTIONS     !!!!!!!!!!!!!!!!!!!!!
; KEYS to increase and decrease the size of the tables...  put your mouse on the right edge of the table
F11::
   if (A_OSVersion == "WIN_VISTA")
   {
      coordmode, mouse, relative
      mouseclick,Left,0,-1,1,0,D,R
      ;sleep,20
      ;mousemove,0,0,0,R
      sleep,20
      mouseclick,Left,-1,-1,1,0,U,R
      sleep, 500
   }
   else
   {
      coordmode, mouse, relative
      mouseclick,Left,-1,-1,1,0,D,R
      sleep,20
      mousemove,-2,-1,0,R
      sleep,20
      mouseclick,Left,-1,-1,1,0,U,R
      sleep, 500

   }
return
F12::

   if (A_OSVersion == "WIN_VISTA")
   {
      coordmode, mouse, relative
      mouseclick,Left,0,-1,1,0,D,R
      ;sleep,20
      ;mousemove,0,0,0,R
      sleep,20
      mouseclick,Left,1,-1,1,0,U,R
      sleep, 500
   }
   else
   {
      coordmode, mouse, relative
      mouseclick,Left,-1,-1,1,0,D,R
      sleep,20
      mousemove,0,-1,0,R
      sleep,20
      mouseclick,Left,-1,-1,1,0,U,R
      sleep, 500

   }
return

^UP::
   MouseMove, 0,-1,0,R
Return

^Down::
   MouseMove, 0,1,0,R
Return

^Left::
   MouseMove, -1,0,0,R
Return

^Right::
   MouseMove, 1,0,0,R
Return


*/


/*
!Down::
   MouseMove, 46,8,0,R
   Click
Return
*/


/*
^F6::
outputdebug, helloworld
junko := md5HashedKeyGenerate("PKSCV1", "1234")
outputdebug, md5=%junko%

return
*/

/*
^F6::
WinId := ""
CasinoName := ""
junko :=  ControlVisible("BoxBetEdit", WinId)
if 1
{
      ;ControlSetText2("BoxBetEdit", "100", WinId)
      BetAmountSet("100",WinId)
;      outputdebug, in ^F6   visible:%junko%    %WinId%
}
return


^F6::
WinId := ""
CasinoName := ""
ButtonClick("ButtonFold", CasinoName, WinId)
outputdebug, in ^F6   %CasinoName%   %WinId%
return
*/
/*
^F6::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
outputdebug, CounterFrequency=%CounterFrequency%
return
*/


/*
^F7::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
WinId := ""
CasinoName := ""
CheckboxName := "CheckboxSitOutNextHand"
time := A_TickCount
DllCall("QueryPerformanceCounter", "Int64 *", CounterBefore)
value := CheckboxGetState(CheckboxName, CasinoName, WinId)
time := A_TickCount - time
DllCall("QueryPerformanceCounter", "Int64 *", CounterAfter)
Counter := 1000 * (CounterAfter - CounterBefore) / CounterFrequency
outputdebug, state of %CheckboxName% = %value%    time=%time%   QPC=%Counter%
return

^F8::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
WinId := ""
CasinoName := ""
CheckboxName := "CheckboxSitOutNextHand"
State := 1
time := A_TickCount
DllCall("QueryPerformanceCounter", "Int64 *", CounterBefore)
value := CheckboxSetState(State, CheckboxName, CasinoName, WinId)
time := A_TickCount - time
DllCall("QueryPerformanceCounter", "Int64 *", CounterAfter)
Counter := 1000 * (CounterAfter - CounterBefore) / CounterFrequency
value := CheckboxGetState(CheckboxName, CasinoName, WinId)
outputdebug, state of %CheckboxName% = %value%    time=%time%   QPC=%Counter%
return

^F9::
DllCall("QueryPerformanceFrequency", "Int64 *", CounterFrequency)
WinId := ""
CasinoName := ""
CheckboxName := "CheckboxSitOutNextHand"
State := 0
time := A_TickCount
DllCall("QueryPerformanceCounter", "Int64 *", CounterBefore)
value := CheckboxSetState(State, CheckboxName, CasinoName, WinId)
time := A_TickCount - time
DllCall("QueryPerformanceCounter", "Int64 *", CounterAfter)
Counter := 1000 * (CounterAfter - CounterBefore) / CounterFrequency
value := CheckboxGetState(CheckboxName, CasinoName, WinId)
outputdebug, state of %CheckboxName% = %value%    time=%time%   QPC=%Counter%
return
*/