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
; Bet Functions
; ---------------------------------------------------------------------------------------
; ***************************************************************************************

; check if the betting box is visible
BetAmountVisible(WinId)
{
   global
   local CasinoName, X, Y, Color, Delta, ClientScaleFactor
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0

   ; get the bet amount IF the bet edit window is visible
   if ControlVisible("BoxBetEdit",WinId)
      return 1
      

   

   X := %CasinoName%BoxBetEditX
   Y := %CasinoName%BoxBetEditY 
   Color := %CasinoName%BoxBetEditColor


   ; if something is wrong with the casino name or checkbox name, then return
   if !X
   {
      return 0
   }



   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", WinId)

   ; if this window is not the top  window and this XY position, then return 0
   ; this checks to make sure that WinId is on the top of the stack at position X,Y
   if WindowIsOverlayedAtXY(X,Y,WinId)
      return 0

   ; look for check mark in +- 3 pixel area, but scale the size based on our current table size
   Delta := 1

;Outputdebug, check1   x=%X%  y=%Y%   cc=%CheckColor%   bc=%BackColor%   cn=%CasinoName%   cbn=%CheckboxName%  id=%WinId%  errorlevel=%Errorlevel%    color=%CheckColor%

   ; search for a check, return 1 if check is found
   CoordMode,Pixel,Screen
   PixelSearch,,,X - Delta, Y - Delta, X + Delta, Y + Delta, Color ,3, Fast RGB
   If NOT Errorlevel
      return 1   
      
   return 0   


}


; Get the amount in the betting box
BetAmountGet(WinId)
{
   global
   local CasinoName, Bet

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0
      
  ;  ?????????????????????????????????????????????????    this is prob redundant, since we also to it before we call this function in each case  ????????????????????????????????????    
  ; return if the bet box is not visible 
   if NOT BetAmountVisible(WinId)
      return  0    
      

   ; get the bet amount IF the bet edit window is visible
   if ControlVisible("BoxBetEdit",WinId)
   {
      return ControlGetText2("BoxBetEdit",  WinId)
   }  
/*     
   ; if this might be a pixel count situation (X is defined for the betting box)   
   if (%CasinoName%BetDigitsPosX)  
   { 
      Bet := DigitSearchByPixelCount(%CasinoName%BetDigitsPosX,%CasinoName%BetDigitsPosY,%CasinoName%BetDigitsPosW,%CasinoName%BetDigitsPosH,"Bet" ,DummyByRef, WinId)      
outputdebug, in BetAmount   Bet=%Bet%      
   }
      
   if Bet is number
      return Bet
   else
      return 0      

*/

   ; click in the betting box
   ButtonClick("BoxBetEdit",WinId)

/*
   ; try clicking in the betting box and getting the bet amount (control A and Control C to put it in the clipboard)
   ; get the particulars for the checkbox
;   X := 112   ; chat box right side
;   Y := 487   ; chat box right side   

   X := %CasinoName%BoxBetEditX
   Y := %CasinoName%BoxBetEditY   


   ; if a value is not speci  fied, then just return
   if NOT X
      return 0
      
   ; convert the x,y position to a window position
   ;WindowScaledPos(X, Y, ClientScaleFactor, "Window", WinId)

   ;CoordMode, Mouse, Relative  
   
   ; click the mouse in the betting box
   
;sleep 50   
      ; mouse down command
      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
                                                      
      sleep,0 
      ; mouse up command
      PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%   
      sleep, 0
*/      
clipboard := ""

;   MouseClickItemLocation("BoxBetEdit",WinId)      
      
Critical, On      
      
   SetKeyDelay,10,10   
      
;sleep, 500
   ControlSend,,^a,ahk_id%WinId%
;   sleep,0
   ControlSend,,^c,ahk_id%WinId%   
;   sleep, 0
  
 
 
    ; click the mouse in the betting box so that the betting box is no longer highlighted
   
;sleep 150   
      ; mouse down command
      ;PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
                                                      
      ;sleep,0 
      ; mouse up command
      ;PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%   
      ;sleep, 0
 
   
;SetKeyDelay,10,10
;ControlSend,,^A^C{Right}1^a^c{Right}2^a^c{Right}3    ;,ahk_id%WinId%

   
;   sleep, 200
   
;      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%   
;      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
      
         
   Value := clipboard
   
;outputdebug, Bet Value = %Value%   
   
   if Value is number
      return Value
   else
      return 0
     
      

}

; Set the amount in the betting box
BetAmountSet(BetAmount,WinId)
{
   global
   local CasinoName, Bet

   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0
 
  ;  ?????????????????????????????????????????????????    this is prob redundant, since we also to it before we call this function in each case  ????????????????????????????????????      
  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return      
      

   ; set the bet amount IF the bet edit window is visible
   if ControlVisible("BoxBetEdit",WinId)
   {
      ControlSetText2("BoxBetEdit", BetAmount,  WinId)
      return
   }



   ; click in the betting box
   ButtonClick("BoxBetEdit",WinId)
   
/*

   X := %CasinoName%BoxBetEditX
   Y := %CasinoName%BoxBetEditY   


   ; if a value is not speci  fied, then just return
   if NOT X
      return
      
   ; convert the x,y position to a window position
   ;WindowScaledPos(X, Y, ClientScaleFactor, "Window", WinId)

   ;CoordMode, Mouse, Relative  
  
      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
                                                      ; need a little delay in here, else Stars button push is not reliable...  20 not enough
;      sleep,100  
      PostMessage, 0x202 , 0, ((Y<<16)^X),, ahk_id%WinId%   
;      sleep, 100
      

;   MouseClickItemLocation("BoxBetEdit",WinId)      
      
      
      
*/      
      
Critical, On      
      
   SetKeyDelay,10,10   
      
      
   ControlSend,,^a,ahk_id%WinId%
   
   
;   sleep,100

   if (BetAmount == "")
      ControlSend,,{BS},ahk_id%WinId%
   else
      ControlSend,,%BetAmount%,ahk_id%WinId%   
;   sleep, 100
   
;SetKeyDelay,10,10
;ControlSend,,^A^C{Right}1^a^c{Right}2^a^c{Right}3    ;,ahk_id%WinId%

   
;   sleep, 200
   
;      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%   
;      PostMessage, 0x201, 0x0001, ((Y<<16)^X),, ahk_id%WinId%
      
         
;   Value := clipboard
   
;outputdebug, Bet Value = %Value%   

     
      

}

/*
BetCalculate()
   Purpose: Returns a bet size that is calculated from the settings on the Street and Fixed bet tabs.
   Returns:
      The $ amount to bet or raise
      Returns 0 if sometime was amiss (like the software couldn't get the Pot value)
   Parameters:
      TypeBet: (a string value)
              fixed - find the bet based on using a Fixed bet
              street - find the bet amount based on using street bet
      FixedNum: is the fixed bet number 1-5 (not used for street bets)
      ClickNum:   for Fixed bets, this is the number of clicks that the user performed (which changes the bet amount)
                  for street bets, this number doesn't matter. ClickNum is determined below by the number of players at the table.

      WinId: window id.
      
   Notes:
      The bet amount is based on the whether you are first to act, or whether someone bet into you.
      Consequently the your bet amount (or raise amount) is calculated differently.
      Also the preflop bet amount is different from the post flop calculations.
      See the web page for how the bet amounts are calculated.
      We only call   BetVariables(CasinoName, WinId)   if needed below

*/
BetCalculate(TypeBet, FixedNum, ClickNum, WinId)
{
   global            
   local BetFactor, Bet, RingOrTournamentString, RoundAmount, TablePlayers, RingOrTournament
   local Units
   
    if (TypeBet == "fixed")
   {
   
      BetFactor := BetFixedAmount%FixedNum%%ClickNum%
      Units :=  BetFixedUnits%FixedNum%
      RoundAmount := RoundFixedBetToSmallBlindMultiple * SmallBlind%WinId%
   
   
      if (Units == "$")
      {
         Bet := BetFactor
      }
      else if (Units == "`%Pot")
      {
         ; we need the pot and call size for this calculation
         BetVariables(WinId)
         
         ; added in ver 4.0014 - may not be necessary now that I have the table pending routine picking the top table in stack, but this shouldn't hurt anything
         ; put in a check for the Pot == 0, if so then re-read the bet variables
         if (Pot == 0)
         {
            sleep, ReReadPotDelay
            UpdateBettingVarsFlag := 1       ; so that we will actually try to read the bet vars again
            BetVariables(WinId)
         }
         
         
         
         Bet := (BetFactor / 100) * (Pot + Call) + Call
         
         /*
         ; check if we are preflop OR  NOT first to act   (we have been bet into)
         if ((Street == "preflop")  OR (FirstToOpenFlag == 0))
         {
            Bet := (BetFactor / 100) * (Pot + Call) + Call
         }
         else
         ; there has no betting and raising before the hero
         {
            Bet := (BetFactor / 100) * Pot
         }
         */
         
         
      }
      else if (Units == "SB")
      {
         Bet := BetFactor * SmallBlind%WinId%
      }
      else if (Units == "BB")
      {
         Bet := BetFactor * BigBlind%WinId%
      }
   }

   ; else TypeBet = "street"
   else
   {
      ; get all the betting variables
      BetVariables(WinId)
      
      ; added in ver 4.0014 - may not be necessary now that I have the table pending routine picking the top table in stack, but this shouldn't hurt anything
      ; put in a check for the Pot == 0, if so then re-read the bet variables
      if (Pot == 0)
      {
         sleep, ReReadPotDelay
         UpdateBettingVarsFlag := 1       ; so that we will actually try to read the bet vars again
         BetVariables(WinId)
      }
      
      
      RingOrTournament := TableRingOrTournament(WinId)
      TablePlayers := TablePlayers(WinId)

       ; if the table is heads up, then use the other set of street bet values
      if (TablePlayers == 2)
         ClickNum := 2
      else
         ; else we use the normal street bet values (ClickNum = 1)
         ClickNum := 1


      ; if this is a Ring game
      if (RingOrTournament)
      {
         RingOrTournamentString := "r"
         RoundAmount := RoundStreetBetRingToSmallBlindMultiple * SmallBlind%WinId%
      }
      ; else it must be a tournament
      else
      {
         RingOrTournamentString := "t"
         RoundAmount := RoundStreetBetTrnyToSmallBlindMultiple * SmallBlind%WinId%
      }
      
      
      ; if heads up then ClickNum == 2, else it ==1
      BetFactor := StreetBet%Street%AmountAct%FirstToOpenFlag%Click%ClickNum%%RingOrTournamentString%
;outputdebug, BetFactor in street  %BetFactor%
      
      ; find out if we are PREFLOP and first to act
      If (   FirstToOpenFlag   AND (Street == "preflop"))
      {
            ; if we are in the small blind
            if ((Call==SmallBlind%WinId%)  OR  ((BigBlind%WinId%==.25) AND (Call==.15)) OR  ((BigBlind%WinId%==.05) AND (Call==.03)) )
            {
               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
;               Bet := Pot + 2 * Call + (BetFactor - 3.5) * BigBlind%WinId% + SmallBlind%WinId%                                ; just added the "+SmallBlind%WinId%"
               Bet := Pot + 2 * BigBlind%WinId% + (BetFactor - 3.5) * BigBlind%WinId%                                   ; changed to this in version 4.0014
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025
               ; in the NL5 game, need to add in .005 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .02)
                  Bet += .005

            }
            ; else we are in BB or we posted blind out of position
            else if (Call == 0)
            {
      
               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
               ; the mod(Pot , BigBlind%WinId%) term adds in an additional amount if the small blind did not complete
               Bet := Pot + (BetFactor - 3.5) * BigBlind%WinId% + BigBlind%WinId% + SmallBlind%WinId% + mod(Pot , BigBlind%WinId%)
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025
               ; in the NL5 game, need to add in .005 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .02)
                  Bet += .005
               
            }
            ; else we are not in SB or BB
            else
            {

               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
               Bet := Pot + 2 * Call + (BetFactor - 3.5) * BigBlind%WinId%
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025
               ; in the NL5 game, need to add in .005 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .02)
                  Bet += .005
            }
      }
      else
      {
         Bet := (BetFactor / 100) * (Pot + Call) + Call
      }
   }



/*
      ; find out if we are PREFLOP and first to act
      If (   (     (Call==0)OR(Call == BigBlind%WinId%)OR(Call==SmallBlind%WinId%)OR  ((BigBlind%WinId%==.25) AND (Call==.15))   )   AND (Street == "preflop"))
      {
            ; if we are in the small blind
            if ((Call==SmallBlind%WinId%)OR  ((BigBlind%WinId%==.25) AND (Call==.15)))
            {
               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
               Bet := Pot + 2 * Call + (BetFactor - 3.5) * BigBlind%WinId% + BigBlind%WinId%                                 ; just added the "+BigBlind%WinId%"
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025

            }
            ; else we are in BB or we posted blind out of position
            else if (Call == 0)
            {

               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
               Bet := Pot + 2 * Call + (BetFactor - 3.5) * BigBlind%WinId% + BigBlind%WinId%
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025

            }
            ; else we are not in SB or BB
            else
            {

               ; this is a tricky little forumla to include the limpers in the preflop bet size
               ;     since we don't actually know the number of limpers in there.
               ; need to subtract out the antes so we don't inflate the number of Big Blinds to bet
               Bet := Pot + 2 * Call + (BetFactor - 3.5) * BigBlind%WinId%
               if (Ante%WinId% > 0)
               {
                  ; since this is a street tab situation, we have already found the number of players above
                  Bet := Bet - (Ante%WinId% * TablePlayers)
               }
               ; in the NL25 game, need to add in .025 since the sb <> .5 bb (this will give a 4xbb = 1.00, instead of rounding down to .95)
               if (SmallBlind%WinId% == .1)
                  Bet += .025

            }
      }
      else
      {
         Bet := (BetFactor / 100) * (Pot + Call) + Call
      }
   }


*/


   ; MIGHT NOT NEED THIS... but no harm  ????????????????????????????????????????
   ; if Bet is negative, then set it to 0
   If (Bet < 0)
   {
      Bet := 0
   }

   ; find the amount to round the bet to, if it is non-zero
   if RoundAmount
      Bet := Round(Bet / RoundAmount) * RoundAmount

   ; if Bet is NOT an even multiple of $1,
   ;      round it off to 2 decimal places
   if mod(Bet * 100, 100)
      Bet := round(Bet,2)

   ; if Bet is an even multiple of $1,
   ;      round it off so we don't see the decimal places
;   if NOT mod(Bet * 100, 100)
;      Bet := round(Bet,0)
;   else
;      Bet := round(Bet,2)


/*
; ???????????????????????????????????????????????????????????????????????????????????
;  also think about if you want the other bet checks in the rest of this file

BBlind := BigBlind%WinId%
outputdebug, betcalc   Bet:%Bet%   BetFactor:%BetFactor%   Pot:%Pot%  Call:%Call%    FirstToOpen:%FirstToOpenFlag%  Street:%Street%  BB:%BBlind%
                     
if (Bet == 0)
{
   outputdebug, Bet == 0
   SoundPlay, *64
}
;if (Bet == LastBet)
;{
;   outputdebug, Bet == LastBet
;   SoundPlay, *32
;}
;LastBet:= Bet                 ; save the last bet, to check if it is ever the same as the last one

*/

BBlind := BigBlind%WinId%
outputdebug, betcalc   Bet:%Bet%   BetFactor:%BetFactor%   Pot:%Pot%  Call:%Call%    FirstToOpen:%FirstToOpenFlag%  Street:%Street%  BB:%BBlind%


   if Bet is number
      return Bet
   else
      return 0
}

; -------------------------------------------------------------------------------
/*
BetFixedAmount()
   Purpose: Places a bet in the bet window based on the Fixed bet tab settings. If enabled the software will also click the Bet/Raise button
   Returns: nothing
   Parameters:
      FixedNum: is the fixed bet number 1-5 (from the Fixed bet tab)
   Notes:
*/
BetFixedAmount(FixedNum)
{
   global
   local Bet, ClickNum, Key, Stack
   local WinId

;outputdebug, in fixed bet
   ; the hotkey that got us here, need to do this right away in a functions so that another hotkey doesn't come along
   Key := A_ThisHotkey

   ; need to wait for multiple clicks/presses (up to 3 max)
   if FixedBetMultiClickDisabled
   {
      ClickNum := 1
   }
   ; else we are allowing multiple clicks
   else
   {

      ; remove any key modifiers (like Shift, LWin, etc) so that we only look for multiple keypresses from the main key itself
      Key := RemoveKeyModifiers(Key)
   

      ; wait for the key to go up
      KeyWait, %Key%, t%KeyWaitMaxClickTime%
      ; see if user held button down for too long, is so, treat it as a single key press
      if (errorlevel == 1)
      {
         ;set the amount to the 1click amount for this fixed bet number
         ClickNum := 1
         GoTo, DoneWithKeyWaiting
      }
      ; wait for the key to go down again, or do a short time out
      KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
      ; check if a second press did NOT occur within short window of time
      If (errorlevel == 1)
      {
         ;set the amount to the 1click amount for this fixed bet number
         ClickNum := 1
         GoTo, DoneWithKeyWaiting
      }
      else
      {
         ; we have either a double or triple press
         ; wait for the key to go up
         KeyWait, %Key%, t%KeyWaitMaxClickTime%
         ; see if user held button down for 1 second or more, is so, treat it as a double key press
         if (errorlevel == 1)
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 2
            GoTo, DoneWithKeyWaiting
         }
         ; wait for the key to go down again, or time out
         KeyWait, %Key%, D, T%KeyWaitMaxClickTime%
         ; check if a third press did NOT occur within short window of time
         If (errorlevel == 1)
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 2
            GoTo, DoneWithKeyWaiting
         }
         else
         {
            ;set the amount to the 2click amount for this fixed bet number
            ClickNum := 3
            GoTo, DoneWithKeyWaiting
         }
      }
   }
   
DoneWithKeyWaiting:


   ; activate the table under the mouse
   WinId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT WinId)
      return
      
  ; return if the bet box is not visible
;   if NOT ControlVisible("BoxBetEdit",WinId)
;      return

  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return

   ; get the bet size
   Bet := BetCalculate("fixed", FixedNum, ClickNum, WinId)
   
   
   ; since full tilt beeps if bet is too big, put in a check to not bet more than stack
   Stack := HeroStack(WinId)
   if Stack
   {
      if (Bet > HeroStack(WinId))
         Bet := Stack   
   }
   
;outputdebug, pot:%Pot%   Call:%Call%     Street:%Street%     First:%FirstToOpenFlag%      CasinoName:%CasinoName%    WinId:%WinId%
;outputdebug, betsize:%BetSize%

   ; set the bet amount IF the bet edit window is visible
;   if ControlVisible("BoxBetEdit",WinId)
;      ControlSetText2("BoxBetEdit", Bet, WinId)
   BetAmountSet(Bet,WinId)

   ; update the display the betting info 
   DisplayOsd1(WinId)


   ; if user wants us to press the bet/raise button, then click it
   if ClickBetAfterSettingBetFixedEnabled
   {
      ; there is something slow writing to the bet edit window, and then clicking the bet button
      ;     if this sleep time is 0, then you have to press the Fixed bet key twice
      ;     to get it to click the bet button. Once to write the value in the bet window
      ;     and then the next time you press it the bet button is pressed, (the 2nd time
      ;     you press the key, the bet window doesn't change since
      ;     the value is already in there)
      ;     100 is not long enough on my system
      sleep, 300
      ButtonClick("ButtonRaise",WinId)
   }
}

; -------------------------------------------------------------------------------

/*
BetMax()
   Purpose: Places a max bet in the bet window based. If enabled the software will also click the Bet/Raise button
   Returns: nothing
   Parameters: none
   Notes:
*/
BetMax()
{
   global
   local WinId
   local Bet, Stack, CasinoName



   ; activate the table under the mouse
   WinId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT WinId)
      return
      
  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return


   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0   
      
   if (CasinoName == "PS")
   {
      Bet := 9999999
      
  
      ; set the bet amount IF the bet edit window is visible
      ;   if ControlVisible("BoxBetEdit",WinId)
      ;      ControlSetText2("BoxBetEdit", Bet, WinId)
      BetAmountSet(Bet,WinId)     
   
   }
   else if (CasinoName == "FT")
   {
   
      ; on FT tables, we can't put in 999999999  as the FT software will beep and truncate the bet... so we'll push the max bet button
   
      ButtonClick("ButtonNLMaxBet", WinId) 
   
   
   }

    

   ; if user wants us to press the bet/raise button, then click it
   if ClickBetAfterSettingBetFixedEnabled
   {
      sleep, 300        ; wait for the Max bet to register in the bet window
      ButtonClick("ButtonRaise",WinId)
      
      ; in FT Shortcuts we would first check to see if the Bet/Raise button was visible. 
      ; If is was visible then we would click the Bet/Raise button.
      ; If it was not visible, then we would check for the presence of the Call button.
      ; If it was visible, then we would click it (i.e. calling the All In bet that was before us.
      ; We'll have to change some things to implement this...   
      ;     change the check for for BetAmountVisible(WinId) above
      ;     on Stars tables the Call button will be on the right (Call2)
      ;     on FT tables, the Call button will be in the middle
   }
}





; -----------------------------------------------------------------------------------------------
/*
BetModify()
   Purpose: Increments or decrements the value in the betting window
   Returns: nothing
   Parameters: 
         Mult is bet multiplier.  The bet will be changed by  Mult * small blind
                              if Mult is negative, the bet will be decreased
         Units can be SB,BB,$,%Pot
   Notes:
*/
BetModify(Mult, Units)
{

   global
   local Bet, WinId, BetChange, RoundAmount, CasinoName

   ; activate the table under the mouse
   WinId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT WinId)
      return
      
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0      
      
   ; if this is a full tilt table
   ;     and  the hotkey pressed was WheelUp or WheelDown
   ;     and  the user has disabled the mouse wheel on FT tables
   ;  then return   
;   if (MouseWheelOnFullTiltDisabled AND ((A_ThisHotkey == "WheelUp") OR (A_ThisHotkey == "WheelDown")) and (CasinoName == "FT"))
;      return
      
   ; some themes do not allow the mouse wheel to be used for this function. 
   ; e.g. the NEW Full Tilt software    
      

  ; return if the bet box is not visible
;   if NOT ControlVisible("BoxBetEdit",WinId)
;      return

  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return

   ; find what is in the current bet box
   Bet := BetAmountGet(WinId)

   TableBlinds(WinId)

   ; modify the current bet size with the amount desired
   ;    note that if pMult is negative, then the bets size is reduced
   if (Units == "$")
   {
      BetChange := Mult
   }
   else if (Units == "`%Pot")
   {
      BetVariables(WinId)
      
      ; added in ver 4.0014 - may not be necessary now that I have the table pending routine picking the top table in stack, but this shouldn't hurt anything
      ; put in a check for the Pot == 0, if so then re-read the bet variables
      if (Pot == 0)
      {
         sleep, ReReadPotDelay
         UpdateBettingVarsFlag := 1       ; so that we will actually try to read the bet vars again
         BetVariables(WinId)
      }
      
      BetChange := Mult * Pot / 100
      ; round the betsize DOWN to an even multiple of Mult*Pot
      ;Bet := Floor(Bet/(Mult * Pot)) * Mult * Pot
   }
   else if (Units == "SB")
   {
      BetChange := Mult * SmallBlind%WinId%
   }
   else if (Units == "BB")
   {
      BetChange := Mult * BigBlind%WinId%
   }

   Bet := Bet + BetChange

   ; if bet is negative, then set it to 0
   If (Bet < 0)
   {
      Bet := 0
   }


   RoundAmount := RoundVarBetToSmallBlindMultiple * SmallBlind%WinId%
   if RoundAmount
      Bet := Round(Bet / RoundAmount) * RoundAmount


   ; if Bet is an even multiple of $1,
   ;      round it off so we don't see the decimal places
   if NOT mod(Bet * 100, 100)
      Bet := round(Bet,0)


   ; set the bet amount IF the bet edit window is visible
;   if ControlVisible("BoxBetEdit",WinId)
;      ControlSetText2("BoxBetEdit", Bet, WinId)
   BetAmountSet(Bet,WinId)
   ; update the betting OSD
   DisplayOsd1(WinId)

   ; slow this function down so that it isn't so fast with the mouse wheel
   sleep, 50

}

; -------------------------------------------------------------------------------

/*
BetBetPot()
   Purpose: Places a pot size bet in the bet window based. If enabled the software will also click the Bet/Raise button
   Returns: nothing
   Parameters: none
   Notes:
*/
BetPot()
{
   global
   local WinId
   local Bet, Stack



   ; activate the table under the mouse
   WinId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT WinId)
      return


  ; return if the bet box is not visible
;   if NOT ControlVisible("BoxBetEdit",WinId)
;      return

  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return
      
   BetVariables(WinId)
   
   ; added in ver 4.0014 - may not be necessary now that I have the table pending routine picking the top table in stack, but this shouldn't hurt anything
   ; put in a check for the Pot == 0, if so then re-read the bet variables
   if (Pot == 0)
   {
      sleep, ReReadPotDelay
      UpdateBettingVarsFlag := 1       ; so that we will actually try to read the bet vars again
      BetVariables(WinId)
   }
   
   
   
   Bet := Pot + 2 * Call
;outputdebug, in BetPot   POT:%Pot%   Call:%Call%

   ; since full tilt beeps if bet is too big, put in a check to not bet more than stack
   Stack := HeroStack(WinId)
   if Stack
   {
      if (Bet > HeroStack(WinId))
         Bet := Stack
   }

   ; set the bet amount IF the bet edit window is visible
;   if ControlVisible("BoxBetEdit",WinId)
;      ControlSetText2("BoxBetEdit", Bet, WinId)
   BetAmountSet(Bet,WinId)      
   ; update the betting OSD
   DisplayOsd1(WinId)

      
   ; if user wants us to press the bet/raise button, then click it
   if ClickBetAfterSettingBetFixedEnabled
   {

      sleep, 300        ; wait for the Max bet to register in the bet window
      
      ButtonClick("ButtonRaise",WinId)
   }
}

; ----------------------------------------------------------------------------------------


BetPresetStreetBet(WinId)
{
   global
   local Bet, Stack
   
  ; return if the bet box is not visible
;   if NOT ControlVisible("BoxBetEdit",WinId)
;      return

  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return

   ; get the preset amount
   Bet := BetCalculate("street", 0, 1, WinId)
   
   ; since full tilt beeps if bet is too big, put in a check to not bet more than stack
   Stack := HeroStack(WinId)
   if Stack
   {
      if (Bet > HeroStack(WinId))
         Bet := Stack   
   }
   
   ; set the bet size back to this amount, as long as the edit box is still visible
   ; set the bet amount IF the bet edit window is visible
;   if ControlVisible("BoxBetEdit",WinId)
;      ControlSetText2("BoxBetEdit", Bet, WinId)
   BetAmountSet(Bet,WinId)
}


; ----------------------------------------------------------------------------------------

; make a bet based on what street the hand is on, and how many times the user clicked the control (1-2 times)
BetStreetAmount()
{
   global
   local Bet, Stack
   local WinId
   local RingOrTournament

   ; activate the table under the mouse
   WinId := TableActivateUnderMouse()
   ; verify that the mouse was over a FT Table
   if (NOT WinId)
      return


; force the software to re-get the pot and call amounts.    something I was testing one time
;UpdateBettingVarsFlag := 1
;UpdatePresetBetFlag := 1
      

  ; return if the bet box is not visible
;   if NOT ControlVisible("BoxBetEdit",WinId)
;      return

  ; return if the bet box is not visible
   if NOT BetAmountVisible(WinId)
      return


   Bet := BetCalculate("street", 0, 1, WinId)
   
   
   ; since full tilt beeps if bet is too big, put in a check to not bet more than stack
   Stack := HeroStack(WinId)
   if Stack
   {
      if (Bet > HeroStack(WinId))
         Bet := Stack   
   }
   
   ; set the bet amount IF the bet edit window is visible
;   if ControlVisible("BoxBetEdit",WinId)
;      ControlSetText2("BoxBetEdit", Bet, WinId)
   BetAmountSet(Bet,WinId)
   
   ; update the betting osd
   DisplayOsd1(WinId)


   RingOrTournament := TableRingOrTournament(WinId)

   ; if user wants us to press the bet/raise button, then click it
   if ((ClickBetAfterSettingStreetBetRingEnabled AND (RingOrTournament)) OR (ClickBetAfterSettingStreetBetTrnyEnabled AND (!RingOrTournament)))
   {
      ; there is something slow writing to the bet edit window, and then clicking the bet button
      ;     if this sleep time is 0, then you have to press the Fixed bet key twice
      ;     to get it to click the bet button. Once to write the value in the bet window
      ;     and then the next time you press it the bet button is pressed, (the 2nd time
      ;     you press the key, the bet window doesn't change since
      ;     the value is already in there)
      ;     100 is not long enough on my system
      sleep, 300
      ButtonClick("ButtonRaise",WinId)
   }
}




; ------------------------------------------------------------------------------------



; this function is SAFE from full tilt crashes...
; It is used to get the bet variables, and preset the betting box with the proper street bet amount (if enabled)

; get the values for the global betting variables on table WinId, and write values into the BetEdit window if needed
;     BigBlind, SmallBlind, Ante, Street, Call, Pot (includes Hero's call)
; This function will also PRESET the betting box with the StreetBet amount, if enabled
BetVariables(WinId)
{
   global
   local MinRaise
   
   static LastPot := 0                   ; the value of the last time we read the pot value
   static LastWinId := 0                  ; the winid the last time we were here
   


   ; check if we either have to update the betting variables, or
   ;     put a street or fixed bet into the BetEdit window
   if (UpdateBettingVarsFlag)
   {

      ; reset the flag since we are updating the pot now
      UpdateBettingVarsFlag := 0
      
/* trying a delay here to solve problem where sometimes we get the previous pot value for the last table.
   It could be that a table is registering as Active, but it still isn't visible yet. When we read the pot value, we are
   graphically reading the value from the previous table (assuming stacked tables).
*/
;sleep, 250


      Pot := TablePot(WinId)
      
      ; add this if the user sees the pot == previous pot situation again...  I think that this should be fixed by the new table pending routine, but use this double check if not ???????????????????
      ; I have this weird problem where one user showed me a problem where:
      ;     the pot size on a table somehow read as the exact size as on the previous table. But this table was not really that same pot size.
      ;     so, I'll try re-reading this pot size if we ever get the case where the pot==lastpot  and the tables were different
;      if ((Pot == LastPot)  AND  (WinId <> LastWinId) )
;      {
;         sleep, ReReadPotDelay
;         Pot := TablePot(WinId)
;      }
      
      LastPot := Pot
      LastWinId := WinId
      
      
      Call := TableCall(WinId)


      ; get the min Raise amount
;      MinRaise := 0
      ; get the bet amount IF the bet edit window is visible
;      if ControlVisible("BoxBetEdit",WinId)
;         MinRaise := BetAmountGet(WinId)


         

      ; get the min Raise amount
      MinRaise := BetAmountGet(WinId)   

      TableStreet(WinId)
      TableBlinds(WinId)

      FirstToOpenFlag := 0

      if (Street == "preflop")
      {
         ; if Min == 2 * BB, then hero is first to open
         if (MinRaise == 2 * BigBlind%WinId%)
            FirstToOpenFlag := 1
      }
      ; else we are on flop, turn or river
      else
      {
         if (MinRaise == BigBlind%WinId%)
            FirstToOpenFlag := 1
      }

      ; if we didn't get good readings on PotRaise, the just set the pot to 0   ???????????????????????????????????????????????????????????????????????????????????????????????????????????
      if (Pot <= 0)
      {
         Call := 0
         Pot := 0
      }
      
;outputdebug, BetVariables   Pot:%Pot%    Call:%Call%    Street:%Street%    MinRaise:%MinRaise%   FirstToOpen:%FirstToOpenFlag%
   }
   
;outputdebug, BetVariables   Pot:%Pot%    Call:%Call%    Street:%Street%    MinRaise:%MinRaise%   FirstToOpen:%FirstToOpenFlag%
   
}




; clear the bet window and set the focus there
BetWindowClear(WinId="")
{
   ;local Flag, Input, ControlName
   ;local CasinoName

   ; if a WinId waas not specified, use the Table under the mouse
   if ! WinId
   {
      WinId := TableActivateUnderMouse()
      if ! WinId
         return
   }
   
   
   Input := ""
   BetAmountSet(Input,WinId)
}




; ***************************************************************************************
