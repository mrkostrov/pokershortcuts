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

B means it uses both numbers and image recog (if the user wants image recog)
* means it uses the numbers to close the dialog box
I means it uses image recognition
T means it is uses the title bar
TA means Tournament Announcement



*************************************************************************************************************
*                             Full Tilt Dialog Boxes
*************************************************************************************************************

-----stand up from table    
QWidget  267x82    YES: 90x60    NO: 170x60    Title: tablename



-----leave table    
QWidget  265x82    YES: 90x60    NO: 170x60    Title: tablename



-----autopost blinds
QWidget  441x84    YES: 180x60    NO: 260x60    Title: tablename



-----remove from waiting list ----   Handled with One Button FT Dialogs
Title:Waiting List Options
ClientSize:  344 x 99
WindowText:
Sorry, you did not respond in time.
You have been removed from the waiting list on table:
Play Chip 1635 - 5/10 - No Limit Hold'em
OK    (FTCSkinButton1)

+++++  QWidget   324x95    OK: 163,63    Title:  Waiting List Options


------Seat Available
QWidget    300x187    Yes: 80,130  No: 160,130   Not Yet: 240,130   Title:  Waiting List Options



-----get chips
QWidget   286x??   OK: 100x318    alternate OK:  100x340    3rd alternate:  100x350    Title: Get Chips



-----Login                      (without text: Attempted)
QWidget   287x306               Login Button:  87x127 (QWidget15)      Title: Login



-----ReLogin Attempted
QWidget  Size: 268,161    Deny Button: 186,138    Title:  Re-Login Attempted




-----Educational Table
QWidget  500x182    YES: 210x160    NO: 290x160    Title:  Educational Table



-----we're sorry, reg closed -------   Handled with ONE BUTTON FT DIALOGS
Title:Full Tilt Poker
ClientSize:  316 x 86
WindowText:
We're sorry, but registration for this tournament is presently closed.
OK                                  (FTCSkinButton1)




----- sng registration dialog
QWidget   682x268     buyin:  172x149        Title:  Tournament Buy-In - xxxxxtournamentnumberxxxx - xxxxx








-----You finished the tourn (***** need to use the delayed close routine for this one *****)
This is the dialog box you get for SNGs

QWidget   size: 400,153   Yes:158,130  No:245,130    Close completed tournament checkbox: 67,90   Title: Tournament Announcement




-----you have too many windows open     (winclose???) ----   Handled with One Button FT dialogs
Title:Full Tilt Poker
ClientSize:  314 x 73
WindowText:
You have too many windows open, Please close one first.
OK                                  (FTCSkinButton1)





-----you cannot register for more tournaments  ----   Handled with One Button FT dialogs          FTP          
Title:Full Tilt Poker
ClientSize:  (344 x 99)        ***   !!!  same size as remove from waiting list  (winclose)
WindowText:
You cannot currently register for any more tournaments. Please contact [EMAIL]support@fulltiltpoker.com[/EMAIL] to have your tournament limits increased.
OK                                  (FTCSkinButton1)


-----Announcements                    Announcements  (winclose)
Title:Announcements
QWidget ????????????????????











NC  We're sorry, chat no active      FTP ??      348 x 116   (344 x 92)               348 x 116   (344 x 93)        ???   I'm not able to test for this size... got it from customer

NC   New Software to install
     with FTCSkinButton 1 and 2      FTP          240 x 103    (236  x 73)             240 x 96    (236 x 73)       ???    got numbers from a customer   ???


; These are not checked for in the software
   leave the tournament  ($$)       tourn ID       356 x 135   (352 x 111)                                       check these numbers... is it 346 instead of 356 ??
   leave the tournament (play)      tourn ID       346 x 135   (342 x 111)                         (342 x 112)       ***     !!! can be the same size as "you finished tourn, ITM"
      Note that this dialog box does have a FTCSkinButton2 on it (for "no")
   you have successfully
      unregistered from tourney        ??





*************************************************************************************************************
*                             Poker Stars Dialog Boxes
*************************************************************************************************************
Dialog boxes SIZE are a functionof the View...Text Size  in the lobby menu...   Doesn't work to use dialog box size for these unless you want to capture all 5 sizes
We currently on support the larget text size !!


-----autopost blinds (NOT AVAILABLE ON POKER STARS)
-----remove from waiting list (NOT AVAILABLE ON POKER STARS)
-----stand up from table (NOT AVAILABLE ON POKER STARS)
-----Educational Table (NOT AVAILABLE ON POKER STARS)
-----you have too many windows open     (winclose???)        ??? does stars have this ???
-----you cannot register for more tournaments        ??? does stars have this ???
-----ReLogin Attempted    ??? does stars have this ???
-----unregistered from the tournament ??? does stars have this ???




-----News
Title:News
ClientSize:  684 x 404  this varies
WindowText:

                              PokerStarsFrameClass1      (has the contents of the news)
                              PokerStarsButtonClass1     (close button)



----- Tournament Registration dialog box
Title:Tournament Registration
ClientSize: 375 x 283
WindowText:
                           (Button1)  buyin button, meaning you agree to buyin to the sng
                           (Button2)  checkbox to "Automatically try to register for identical"
OK                         (Button3)
Cancel                     (Button4)




-----FOLD/CHECK (if you press fold accidentally)
Title:PokerStars
ClientSize: 280 x 127
WindowText:
Check                               (Button1)
Fold                                (Button2)


-----leave table

Title:Table Aegle V
ClientSize: 266 x 125
WindowText:
OK                                  (Button1)
Cancel                              (Button2)



------Seat Available

Title:Seat Available
ClientSize: 383 x 202
WindowText:
Yes               (Button1)
No                (Button2)
Not Yet           (Button3)




-----get chips
Title:Buy-in
ClientSize:  441 x 442
WindowText:
500
OK
Cancel





-----Login
Title:Log In
ClientSize:  392 x 253
WindowText:
nanochip                            (Edit1) userid
                                    (Edit2) password
                                    (RadioButton: Button1) remember password
Create New Account...               (Button2)
Forgot Password...                  (Button3)
OK                                  (Button4)
Cancel                              (Button5)





----- this table has been closed (shows up after all players are done at the table)
; these are one button dialog boxes, but they have unique titles (not PokerStars or Tournament Registration)
Title:141473091 1        <---  tournament number and table number
ClientSize: 265 x 125
WindowText:
OK            Button1

Title:Baetsle IV        <----- ring game table name
ClientSize: 265 x 125
WindowText:
OK




*****************  Poker Stars dialog boxes with only 1 button (button1) that we can close with the "group close" feature
*
-----we're sorry, reg closed
Title:Tournament Registration
ClientSize: 265 x 125
WindowText:
OK                (Button1)



----- you did not act in time (to sit down at ring game) CHANGED TO NEW SIZE
Title:PokerStars
ClientSize: 328 x 127
WindowText:
OK                             (Button1)






-----You finished the tourn (***** need to use the delayed close routine for this one *****)

VARIOUS WIDTHS

Title:PokerStars
ClientSize: 349 x 127
WindowText:
OK            Button1

Title:PokerStars
ClientSize: 352 x 127
WindowText:
OK            Button1



---- Play money tournament after buy-in - you win play money chips, note about sitting out
Title:Tournament Registration
ClientSize: 418 x 266
WindowText:
OK                            (Button1)



----- tournament closed (not sure when this shows up...   after a sng end I think)
Title:PokerStars
ClientSize: 265 x 125
WindowText:
OK            Button1


******************** don't show me again dialog boxes (we don't close these because the user can click to disable them  ***********************************************

----- Buy-in warning for fast tables (Please note: you are joining a high speed table. You will have less time to make decisions.....)
Title:Buy-in
ClientSize: 769 x 201
WindowText:
OK             Button1
Cancel         Button2
               Button3 (checkbox for "Don't show this message again")


----- Buy-in warning about disconnection protection at this table
Title:Buy-in
ClientSize: 663 x 289
WindowText:
OK             Button1
Cancel         Button2
               Button3 (checkbox for "Don't show this message again")



----- after buying into tournament, you will be folded if disconnected
Title:PokerStars
ClientSize: 397 x 235
WindowText:
OK                (Button1)
                  (Button2) checkbox for "Don't show this message again)


*/




; ------------------------------------------------------------------------------
; remove any Invalid Dialog Ids from the  InvalidDialogWidthIdList, if these dialogs no longer exist on the computer

InvalidDialogRemoveObsolete()
{

   global
   local Num, WinId


      ; work thru the list backwards so that we don't miss any when we remove one

      Num := ListLength(InvalidDialogWidthIdList)
      Loop, %Num%
      {
         WinId := ListGetItem(InvalidDialogWidthIdList,Num - A_Index + 1)
         ifWinNotExist, ahk_id%WinId%
         {
            ListDelPos(InvalidDialogWidthIdList,Num - A_Index + 1)
;outputdebug, removing from list  %WinId%
         }
      }
}



; Close this dialog box for Stars Dialog boxes  WinId
; Note that if we find a dialog box that we could close, but it's just not enabled to close it, then we don't add it to the invalid list (so that we could close it if we enable it)
DialogClose(WinId)
{
   global                              ; InvalidDialogWidthIdList
   local DialogWidthList,DialogWidth, ErrorFlag, DialogTitle, ButtonVisibleFlag1, ButtonVisibleFlag2, ButtonVisibleFlag3
   local CYEDGE, WindowW
   
   ; list all the possible dialog widths ************   UPDATE THIS AS YOU ADD MORE DIALOG BOX CLOSINGS
   DialogWidthList := "265,266,280,383,392,441"

   WinGetTitle, DialogTitle, ahk_id%WinId%


   ; check dialog boxes that don't have a constant width

 


   ; check for Poker Stars News dialog box
   if instr(DialogTitle,"News")
   {
      ControlGet, ButtonVisibleFlag1,Visible,,PokerStarsButtonClass1, ahk_id%WinId%
      if ButtonVisibleFlag1
      {
         ; if enabled, close this dialog box
         if CloseAnnouncementsDialogEnabled
            ControlClick, PokerStarsButtonClass1, ahk_id%WinId%,,,,NA
         return
      }
      ; else this is some unknown type of dialog box... add it to invalid list
      else
      {
         ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogClose News ListAddItem    1    WinId:%WinId%         
         return
      }
   }
   ; else we have some other type of dialog box
   else
   {


      
      ; check if there PS type buttons
      ControlGet, ButtonVisibleFlag1,Visible,,Button1, ahk_id%WinId%
      ControlGet, ButtonVisibleFlag2,Visible,,Button2, ahk_id%WinId%
      
      ; check if this is a poker stars type of one button dialog box (note that it can't have a Button2 on the box, just Button1)
      if (  (instr(DialogTitle,"PokerStars") OR instr(DialogTitle,"Tournament Registration"))  AND ButtonVisibleFlag1 AND (NOT ButtonVisibleFlag2) )
      {
         if CloseOneButtonStarsDialogsEnabled
            ControlSend, Button1, {ENTER}, ahk_id %WinId%
         return
      }



      
      
      ; STARS main sng tournament registration dialog box
      ; note that this is not width dependent
      ; NOTE that tournament boxes don't have Button4 on them (as they don't offer the checkbox for trying to register to similar sngs)
      ;     so that is how this section will not register for tournaments, only SnGs
      ;Title:Tournament Registration
      ;ClientSize: 375 x 283
      ;WindowText:
      ;                           (Button1)  buyin button, meaning you agree to buyin to the sng
      ;                           (Button2)  checkbox to "Automatically try to register for identical"
      ;OK                         (Button3)
      ;Cancel                     (Button4)
      ControlGet, ButtonVisibleFlag1,Visible,,Button1, ahk_id%WinId%
      ControlGet, ButtonVisibleFlag2,Visible,,Button4, ahk_id%WinId%
      ControlGet, ButtonVisibleFlag3,Visible,,Button5, ahk_id%WinId%

      ; check if this is a Stars main tournament registration box
      if (  instr(DialogTitle,"Tournament Registration")  AND ButtonVisibleFlag1 AND ButtonVisibleFlag2 AND (NOT ButtonVisibleFlag3)    )
      {
      
      
;outputdebug, here333      SngContinuousStatus=%SngContinuousStatus%
      
         ; if a sng opening is in progress, then just return so we don't interfere here
         if ( SngContinuousStatus == "Running")
            return
      
      
         if OneClickSngRegisteringEnabled
         {


             ControlClick, Button3, ahk_id %WinId%,,,,NA
;            ControlSend, Button3, {ENTER}, ahk_id %WinId%
           
         }
         return
      }
      
      
      
      
      ; else check if this is a dialog box that we will close based on width

      ; get the width of the dialog box
      SysGet, CYEDGE, 46
      WinGetPos,,,WindowW,,ahk_id%WinId%
      DialogWidth := WindowW - 2 * CYEDGE


;outputdebug, in dialogclose  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%

      ; check that this width is a valid width... if not save the ID in a list of invalid dialog lists
      if (NOT ListGetPos(DialogWidthList,DialogWidth))
      {
         ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogClose  not valid Width    ListAddItem  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%  WinId%WinId%
         return
      }
;outputdebug, in dialogclose  DialogWidth:%DialogWidth%

      ; call the correct width checker
      ErrorFlag := DialogWidth%DialogWidth%(WinId)




      ; ErrorFlag == 0 if we found a valid dialog box that we either did close or Could close (but it was disabled)
      ; ErrorFlag == 1 if we didn't find a valid dialog box
      if ErrorFlag
      {
         ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogClose  ErrorFlag==1    ListAddItem  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%  WinId%WinId%         
         return
      }
   }
}



; Close QWidget (FT) DIalog boxes
; Note that if we find a dialog box that we could close, but it's just not enabled to close it, then we don't add it to the invalid list (so that we could close it if we enable it)
DialogCloseQWidget(WinId)
{
   global                              ; InvalidDialogWidthIdList
   local DialogWidthList,DialogWidth, ErrorFlag, DialogTitle, ButtonVisibleFlag1, ButtonVisibleFlag2, ButtonVisibleFlag3
   local CYSIZEFRAME, WindowW, X, Y
   
   ; list all the possible dialog widths ************   UPDATE THIS AS YOU ADD MORE DIALOG BOX CLOSINGS
   DialogWidthList := "265,267,268,286,287,330,,332,338,400,441,500,690"   
  
   
   WinGetTitle, DialogTitle, ahk_id%WinId%
   
   ; sometimes these QWidget dialog boxes are slow to put in the real title... and they just put in Dialog for the title, until sometime later they
   ; put in the real title....  so if the title comes back as Dialog, then just return, and we will try again later.
   if (DialogTitle == "Dialog")
      return

   ; we ignore notes dialog boxes
   if (DialogTitle == "Player Notes:")
   {
      ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogCloseQWidgets    PlayerNotes    ListAddItem  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%  WinId%WinId%      
      return
   }


   ; else check if this is a dialog box that we will close based on width

   ; get the width of the dialog box
   SysGet, CYSIZEFRAME, 33
   WinGetPos,,,WindowW,,ahk_id%WinId%
   DialogWidth := WindowW - 2 * CYSIZEFRAME


;outputdebug, in dialogclose  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%

   ; check that this width is a valid width... if not save the ID in a list of invalid dialog lists
   if (NOT ListGetPos(DialogWidthList,DialogWidth))
   {
      ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogCloseQWidgets    Invalid Width    ListAddItem  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%  WinId%WinId%
      return
   }
;outputdebug, in dialogclose  DialogWidth:%DialogWidth%


   ; initialize
   ErrorFlag := 0


Critical, On
;WinActivate, ahk_id%WinId%
;sleep, 100
   ; call the correct width checker subroutine
   Gosub DialogWidth%DialogWidth%

Critical, Off

   ; ErrorFlag == 0 if we found a valid dialog box that we either did close or Could close (but it was disabled)
   ; ErrorFlag == 1 if we didn't find a valid dialog box
   ; In a lot of cases with these QWidget dialog boxes, we only have the width and the height to go on to confirm a valid dialog box.
   ;     In these cases, the subroutines below just return ErrorFlag := 0  and we will keep trying to close these if they didn't close the first time.
   ;     If we can check the title bar, then we can double check the title bar, to also confirm that this was a valid dialog box for us to close
   if ErrorFlag
   {
      ListAddItem(InvalidDialogWidthIdList,WinId)
;outputdebug, in DialogCloseQWidgets    ErrorFlag==1    ListAddItem  InvalidDialogWidthIdList:%InvalidDialogWidthIdList%     ThisDialogWidth:%DialogWidth%  WinId%WinId%      DialogTitle:%DialogTitle%
      return
   }
      
return

;  subroutines for closing the dialog boxes      
;   CloseOneButtonFullTiltDialogsEnabled

;Leave Table dialog
DialogWidth265:
   if CloseLeaveTableDialogEnabled
   {
      WinActivate, ahk_id%WinId%
      sleep, 100   
      X := 90
      Y := 60
      MouseClickXYLocation(X,Y,WinId)
   }
Return

;Leave Seat dialog
DialogWidth267:
   if CloseLeaveSeatDialogEnabled
   {
      WinActivate, ahk_id%WinId%
      sleep, 100   
   
      X := 90
      Y := 60
      MouseClickXYLocation(X,Y,WinId)
   }
Return


;Re-LogIn Attempted....  press Deny if this feature is enabled
DialogWidth268:
;outputdebug, here1
      if (DialogTitle == "Re-Login Attempted")
      {
;outputdebug, here2
         if DenyReLoginAttemptedEnabled
         {
;outputdebug, here3   
            WinActivate, ahk_id%WinId%
            sleep, 100   

            X := 186
            Y := 138
            MouseClickXYLocation(X,Y,WinId)
         }
         ErrorFlag := 0
      }   
      else
         ErrorFlag := 1
   
Return





; Get Chips Dialog box - QWidget
DialogWidth286:
;outputdebug, here1
      if (DialogTitle == "Get Chips")
      {
;outputdebug, here2
         if AutoClickOkOnGetChipsDialogEnabled
         {
            ; when you first sit down at table, this is the location of the OK button   
            WinActivate, ahk_id%WinId%
            sleep, 100   
            
            
            X := 100
            Y := 318
            MouseClickXYLocation(X,Y,WinId)
            
            ; wait a little bit for this dialog box to disappear
            sleep, 50
            ; if the dialog box still exists, then click in the alternate position (which is the position if the user clicks the Get Chips button)     
            ;       this one is if you manually get chips        
            ifwinexist, ahk_id%WinId%
            {
               WinActivate, ahk_id%WinId%
               sleep, 100   
            
               X := 100
               Y := 340
               MouseClickXYLocation(X,Y,WinId)
            }       
            ; wait a little bit for this dialog box to disappear
            sleep, 50
            ; if the dialog box still exists, then click in other alternate position (which is the position if the user clicks the Get Chips button)       
            ;     this one says that you fell below the minimum chip level for the table to play there     
            ifwinexist, ahk_id%WinId%
            {
               WinActivate, ahk_id%WinId%
               sleep, 100   
            
               X := 100
               Y := 350
               MouseClickXYLocation(X,Y,WinId)
            }                   
            
            
         }
         ErrorFlag := 0
      }   
      else
         ErrorFlag := 1


return


; Login Dialog box - QWidget
DialogWidth287:
;outputdebug, here1
      if (DialogTitle == "Login")
      {
;outputdebug, here2
         if AutoLoginEnabled
         {
;outputdebug, here3   
            WinActivate, ahk_id%WinId%
            sleep, 100   

            X := 87
            Y := 127
            MouseClickXYLocation(X,Y,WinId)
         }
         ErrorFlag := 0
      }   
      else
         ErrorFlag := 1


return


; Table available seat dialog box
DialogWidth330:
DialogWidth332:
outputdebug, in DialogWidth330
      if (DialogTitle == "Waiting List Options")
      {
         sleep, 400
         ; if enabled, pop this dialog box to the top
         if PopSeatAvailDialogToTopEnabled
         {
            winset, alwaysontop, on, ahk_id %WinId%
            winset, alwaysontop, off, ahk_id %WinId%
         }
         if RejectSeatIfSeatAvailableEnabled
         {
            WinActivate, ahk_id%WinId%
            sleep, 100   
         
            X := 160
            Y := 130
            MouseClickXYLocation(X,Y,WinId) 
         }
         else if TakeSeatIfSeatAvailableEnabled
         {
            WinActivate, ahk_id%WinId%
            sleep, 100   
         
            X := 80
            Y := 130
            MouseClickXYLocation(X,Y,WinId)
         }
         ErrorFlag := 0
      } 
      else              
         ErrorFlag := 1   

return

; Tournament: Unregister successful, has just an "OK" button
DialogWidth338:
	winclose, ahk_id %WinId%
return


; Sng: You finished the tournament
; QWidget   size: 400,153   Yes:158,130  No:245,130    Close completed tournament checkbox: 67,90   Title: Tournament Announcement
DialogWidth400:

      if (DialogTitle == "Tournament Announcement")
      {
;outputdebug, in dialog 400      
         ; if enabled, close this dialog box
         if CloseYouFinishedTheTournamentDialogEnabled
         {
            ; we need to delay the closing of this dialog box
            DialogCloseDelayed(WinId)
         }
         ErrorFlag := 0
      }      
      else              
         ErrorFlag := 1       
      
return


;AutoPostBlinds dialog
DialogWidth441:


   ; get the FT table id that this dialog box applies to
   WinGet, TableId , Id, %DialogTitle% ahk_group FTTables

      ; we deal me OUT mode is set, then click no to not auto post blinds
      if (DealMeModeState%TableId% == "Out")
      {
         WinActivate, ahk_id%WinId%
         sleep, 100   
      
         ; click the No Button
         X := 260
         Y := 60
         MouseClickXYLocation(X,Y,WinId)
      }



   ; if enabled, close this dialog box
   if CloseAutoPostBlindsDialogEnabled
   {
         WinActivate, ahk_id%WinId%
         sleep, 100   

         ; Send enter to the Yes button 
         X := 180
         Y := 60
         MouseClickXYLocation(X,Y,WinId)

   }

return

 
;Educational table dialog
DialogWidth500:

;outputdebug, here1
   if (DialogTitle == "Educational Table")
   {
;outputdebug, here2   
      if CloseEducationalTableDialogEnabled
      {
;outputdebug, here3   
         WinActivate, ahk_id%WinId%
         sleep, 100   
   
         X := 205
         Y := 160
         MouseClickXYLocation(X,Y,WinId)
      }
      ErrorFlag := 0
   }   
   else
      ErrorFlag := 1
Return 
  
  
  
; Tournament Buy-in
;QWidget   682x268     buyin:  172x147        Title:  Tournament Buy-In - xxxxxtournamentnumberxxxx - xxxxx  
DialogWidth690: 
 
   if (instr(DialogTitle,"Tournament Buy-in -"))
   {
         ErrorFlag := 0
         
         ; if a sng opening is in progress, then just return so we don't interfere here
         if (SngContinuousStatus == "Running")
         {
            return
         }
         if OneClickSngRegisteringEnabled
         {
            ; click on the register buttonuu
            WinActivate, ahk_id%WinId%
            sleep, 100   
            
            ; if this is a play money table
            if (instr(DialogTitle,"Play Money"))
            {
               X := 170
               Y := 145
               MouseClickXYLocation(X,Y,WinId)            
            }
            ; else real money table
			; try buying in w/ Token
            {          
               X := 260
               Y := 160
			   MouseClickXYLocation(X,Y,WinId)
            }
			; try buying in w/ T$
			{          
               X := 260
               Y := 130
			   MouseClickXYLocation(X,Y,WinId)
            }
			; try buying in w/ $
			{          
               X := 260
               Y := 100
			   MouseClickXYLocation(X,Y,WinId)
            }
			if MinimizeSngLobbyEnabled {
				sleep, 200
				WinId := WinExist("A")
				LobbyTournamentMinimize(WinId)
			}
         }
   }
   else
      ErrorFlag := 1    
 
Return 

 
 
 
 
 
 
 
 
   
}







/*
----- this table has been closed (shows up after all players are done at the table)
; these are one button dialog boxes, but they have unique titles (not PokerStars or Tournament Registration)
Title:141473091 1        <---  tournament number and table number
ClientSize: 265 x 125
WindowText:
OK            Button1

Title:Baetsle IV        <----- ring game table name
ClientSize: 265 x 125
WindowText:
OK


; this next one is handled by the One button dialog box on Stars code in the main dialog function
;----- *****  Poker Stars *****   we're sorry, registration closed
;Title:Tournament Registration
;ClientSize:  265 x 125
;WindowText:
;OK                (Button1)

*/

DialogWidth265(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,Button1, ahk_id%WinId%

   if (instr(DialogText,"OK") AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if CloseTableHasBeenClosedEnabled
      {
;         ControlClick, Button1, ahk_id%WinId%,,,,NA
         ControlSend, Button1, {ENTER}, ahk_id %WinId%
      }
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }

}







/*
----- *****  Poker Stars *****   leave table
Title:Table Aegle V
ClientSize: 266 x 125
WindowText:
OK                                  (Button1)
Cancel                              (Button2)
*/
DialogWidth266(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,Button2, ahk_id%WinId%

   if (instr(DialogText,"OK") AND instr(DialogText,"Cancel") AND instr(DialogTitle,"Table ") AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if CloseLeaveTableDialogEnabled
      {
;         ControlClick, Button1, ahk_id%WinId%,,,,NA
         ControlSend, Button1, {ENTER}, ahk_id %WinId%
      }
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }
}





/*
----- *****  Poker Stars *****   Fold/Check dialog box

Title:PokerStars
ClientSize: 280 x 127
WindowText:
Check                               (Button1)
Fold                                (Button2)

*/
DialogWidth280(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   
   

   ControlGet, ButtonVisibleFlag1,Visible,,Button2, ahk_id%WinId%
   if (instr(DialogText,"Fold") AND instr(DialogTitle,"PokerStars") AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if CloseFoldCallDialogEnabled
      {
         ControlSend, Button1, {ENTER}, ahk_id %WinId%
      }
      return 0
   }

   
   
   
   ; we did not find a valid dialog box that we can close
   return 1

}



/*
----- *****  Full Tilt *****   you have too many windows open     (winclose???)
Title:Full Tilt Poker
ClientSize:  314 x 73
WindowText:
You have too many windows open, Please close one first.
OK                                  (FTCSkinButton1)
*/

/*  NOW HANDLED WITH FT ONE BUTTON DIALOGS CASE
DialogWidth314(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,FTCSkinButton1, ahk_id%WinId%

   if (instr(DialogText,"You have too many windows open") AND instr(DialogTitle,"Full Tilt Poker") AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if CloseTooManyWindowsOpenDialogEnabled
         ControlClick, FTCSkinButton1, ahk_id%WinId%,,,,NA
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }

}
*/



/*
----- *****  Full Tilt *****   we're sorry, reg closed
Title:Full Tilt Poker
ClientSize:  316 x 86
WindowText:
We're sorry, but registration for this tournament is presently closed.
OK                   (FTCSkinButton1)
*/


/*    NOW HANDLED WITH ONE BUTTON FT DIALOGS CASE
DialogWidth316(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,FTCSkinButton1, ahk_id%WinId%

   if (instr(DialogText,"We're sorry, but registration for this tournament is presently closed") AND instr(DialogTitle,"Full Tilt Poker")  AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if CloseWereSorryRegClosedDialogEnabled
         ControlClick, FTCSkinButton1, ahk_id%WinId%,,,,NA
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }

}
*/






/*
----- ***** Poker Stars *****   get chips
Title:Buy-in
ClientSize:  441 x 423
WindowText:
400
OK
Cancel
*/
DialogWidth441(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1,ButtonVisibleFlag2

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,Button4, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag2,Visible,,Button5, ahk_id%WinId%
;outputdebug, here1
   ; the initial buyin at the table when you sit down has 5 buttons on it... check for that case first
   if (instr(DialogText,"OK") AND instr(DialogText,"Cancel") AND instr(DialogTitle,"Buy-in") AND ButtonVisibleFlag2)
   {
;outputdebug, here2
      ; click on the ok button if enabled
      if AutoClickOkOnGetChipsDialogEnabled
         ;ControlClick, Button4, ahk_id%WinId%,,,,NA
         ControlSend, Button4, {ENTER}, ahk_id %WinId%
      return 0
   }


   ; the case where you buy chips at the table only has 4 buttons on it. check that case here
   if (instr(DialogText,"OK") AND instr(DialogText,"Cancel") AND instr(DialogTitle,"Buy-in") AND ButtonVisibleFlag1)
   {
;outputdebug, here3
      ; click on the ok button if enabled
      if AutoClickOkOnGetChipsDialogEnabled
         ;ControlClick, Button3, ahk_id%WinId%,,,,NA
         ControlSend, Button3, {ENTER}, ahk_id %WinId%
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }

}





/*
------ *****  Poker Stars *****   Seat Available
Title:Seat Available
ClientSize: 383 x 202
WindowText:
Yes               (Button1)
No                (Button2)
Not Yet           (Button3)
*/
DialogWidth383(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,Button3, ahk_id%WinId%

   if (instr(DialogText,"Not Yet") AND instr(DialogTitle,"Seat Available") AND ButtonVisibleFlag1)
   {
      ; if enabled, pop this dialog box to the top   **********   THIS DOESN't Do ANYTHING ON STARS... can't do a stay on top for some reason
      if PopSeatAvailDialogToTopEnabled
      {
         winset, alwaysontop, on, ahk_id %WinId%
         winset, alwaysontop, off, ahk_id %WinId%
      }
      if RejectSeatIfSeatAvailableEnabled
      {
         ControlClick, Button2, ahk_id %WinId%,,,,NA
;         ControlSend, Button2, {ENTER}, ahk_id %WinId%              ; for some reason this didn't click the correct button ???????????
      }
      else if TakeSeatIfSeatAvailableEnabled
      {
         ControlClick, Button1, ahk_id %WinId%,,,,NA
;         ControlSend, Button1, {ENTER}, ahk_id %WinId%              ; for some reason this didn't click the correct button ???????????
      }
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }

}



/*
----- ***** Poker Stars *****   Login
Title:Log In
ClientSize:  392 x 352
WindowText:
nanochip                            (Edit1) userid
                                    (Edit2) password
                                    (RadioButton: Button1) remember password
Create New Account...               (Button2)
Forgot Password...                  (Button3)
OK                                  (Button4)
Cancel                              (Button5)
*/
DialogWidth392(WinId)
{
   local DialogTitle, DialogText,ButtonVisibleFlag1

   WinGetTitle, DialogTitle, ahk_id%WinId%
   VarSetCapacity(DialogText , 1000)
   WinGetText, DialogText, ahk_id%WinId%
   ControlGet, ButtonVisibleFlag1,Visible,,Button5, ahk_id%WinId%

   if (instr(DialogText,"Forgot Password...") AND instr(DialogTitle,"Log In") AND ButtonVisibleFlag1)
   {
      ; if enabled, close this dialog box
      if AutoLoginEnabled
      {
;         ControlClick, Button4, ahk_id%WinId%,,,,NA
         ControlSend, Button4, {ENTER}, ahk_id %WinId%
      }
      return 0
   }
   ; we did not find a valid dialog box that we can close
   else
   {
      return 1
   }
}







; close "you finished tournament dialog box", but with a delay in there to allow time for FT to write the hand history, and for the user to see the results
; This function is called by the DialogCloseYouFinishedTheTournament(WinId) function when a "you finished the tournament" dialog box is displayed
; WinId is the id of the dialog box
DialogCloseDelayed(WinId)
{

   global
   static vCloseDialogTime = 0                 ; this is the time that it was first ok to close this dialog, but we are going to delay CloseDialogDelay

   static vDialogId = 0                        ; close this dialog box/Table after the proper delay

   local vCloseDialogDelayMS               ; delay to wait to close this dialog box/table
   local vFlag

   ; if we are suspended, then return
   if (NOT AllHotkeysEnabled)
      return


   ; set the delay in closing tables to the value the user set, but not less than 2 seconds
   if (CloseDialogDelay < 2 )
      vCloseDialogDelayMS := 2000
   else
      vCloseDialogDelayMS := CloseDialogDelay * 1000

   ; check if we are waiting to close a table from a previous pass thru this function
   if vCloseDialogTime
   {

      ; check if the pending dialog box to close does not exist any more, then stop tring to close it
      ifWinNotExist, ahk_id%vDialogId%
      {
         vCloseDialogTime := 0
         return
      }

      ; check if it has been longer than the delay time since it was ok to close this table
      if (A_TickCount - vCloseDialogTime > vCloseDialogDelayMS)
      {
         ; if we are enabled to auto close tables, then uncheck the "Close Completed Tournament" checkbox
         ;ControlGet, vFlag, Checked,, QWidget1, ahk_id %vDialogId%
         ;if (vFlag  AND  (CloseFinishedSngTablesEnabled  OR   CloseTourneyTablesIfNotSeatedEnabled))
         ;{
         ;   ; click "close tournament" checkbox to uncheck it
         ;   Control, Check,, QWidget1, ahk_id %vDialogId%
         ;}

         ;sleep, 20


         ; close the dialog box by clicking on "NO" we don't want to play another tournament, and the table if the above is enabled
         ;ControlClick, QWidget3, ahk_id %vDialogId%,,,,NA
         ; play money sngs
         ; X := 245
         ; Y := 170
         ; MouseClickXYLocation(X,Y,WinId)
         
         ;real money sngs
         ; X := 245
         ; Y := 130
         ; MouseClickXYLocation(X,Y,WinId)
         
		WinClose, ahk_id%WinId%
         ;WinWaitClose, ahk_id %vDialogId%,,2

         vCloseDialogTime := 0
         return


      }
      ; if we are still waiting, then return so we don't try to close any other lobbies
      else
      {

         return
      }
   }
   ; else we have not been in the delay mode, but we do have a new dialog to close
   else {
      ; we haven't been waiting to close any dialog box/table until now.

      vDialogId := WinId                    ; this is the next dialog box to close, save it in case we are asked to another one before we close this one

      ; set the time that it was first checked to be ok to close this table
      vCloseDialogTime := A_TickCount

      return

   }
   

   
}


