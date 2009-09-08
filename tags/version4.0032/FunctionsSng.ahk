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
; SnG Functions
; -------------------------------------------------------------------------------
; *******************************************************************************


; get the tournament number for this SnG lobby win id
; returns 0 if we don't get a valid number
SngLobbyTournamentNum(WinId)
{
   ; local SngTournamentNum, Pos1, Pos2, CasinoName, WinTitle
   
   if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
      return 0

   WinGetTitle, WinTitle, ahk_id%WinId%

   if (CasinoName == "FT")
   {
      ; find the first digit of the tournament number
      Pos1 := instr(WinTitle,"Tournament") + 11
      ; find the last digit of the tournament number
      Pos2 := strlen(WinTitle)
      
      StringMid, SngTournamentNum, WinTitle, Pos1, Pos2 - Pos1 + 1


   }
   else if (CasinoName == "PS")
   {
      ; finde the first digit of the tournament number
      Pos1 := instr(WinTitle,"Tournament") + 11
      ; find the last digit of the tournament number
      Pos2 := strlen(WinTitle) - 6

      StringMid, SngTournamentNum, WinTitle, Pos1, Pos2 - Pos1 + 1


   }
   
;outputdebug,  in SngLobbyTournamentNum      WinTitle:%WinTitle%    CasinoName:%CasinoName%      SngTournamentNum:%SngTournamentNum%
;   if vSngTournamentNum is not integer
;      vSngTournamentNum := 0

   return SngTournamentNum
   

}




; check if we should open another SnG  (this function is called by a subroutine of the same name
;     which is called continuously (at an interval that is set on the SNG B tab)
SngContinuouslyOpen()
{
   global                           ; SngOpenIdList, SngNumOpenedThisSession
   local NumSngOpen, TotalSngOpen, NumPendingTablesOpen
   local NewSnGOpenIdList
   local StatusNum, SngTournamentNum, SngLobbyId
   local EndTime, SessionTimeInSeconds

   static LastGroupOpened := 0      ; this is the last sng type that we opened... set it to 0, as it gets incremented when first needed.




   ; is we are suspended, then just return
   if (NOT AllHotKeysEnabled)
      return
      

   

   ; we check this before the pending cleanup, so that in case the table opens slowly after the pending list might get reduced,
   ;    so we can avoid opening an extra table
   NumPendingTablesOpen := ListLength(SngPendingLobbyIdList)
   
   
   ; clean up the pending list of sng tables
   if NumPendingTablesOpen
      SngPendingCleanup()

   ; display the status
   SngContinuouslyOpenStatusDisplay()
   
   
   ; if the session is Stopped and there are no pending tables... then return
   ; we continue on if there are pending tables still to open just so that the num open tables stats can get updated.
   if (( SngContinuousStatus == "Stopped") AND (NOT NumPendingTablesOpen))
      return

;outputdebug, in SngContinuouslyOpen 2


   
   ; get the number of tables open
   WinGet, NumSngOpen, List, ahk_group SngTables
   ; get total of open + pending
   TotalSngOpen := NumSngOpen + NumPendingTablesOpen


;outputdebug, In SngContinouslyOpen, SngNumOpenedThisSession=%SngNumOpenedThisSession%   NumSngOpen:%NumSngOpen%      NumPendingTablesOpen:%NumPendingTablesOpen%


   ; see if any new tables have been opened in this session... and increment SngNumOpenedThisSession
   ;     above with the WinGet command, we made an array of IDs for the open tables...  NumSngOpen
   ;     SngOpenIdList is a comma list of all the open tables (that were previously open the last time we were in the function)
   ;     Check this new array, and if any table is in there that wasn't in the previous list, then we must have opened a new
   ;     SNG table, so increment SngNumOpenedThisSession
   ;     This will be incremented whether the software or the user manually opened a new table.
   ; first clear out the new sng id list, so we can build the new list of all open tables
   NewSngOpenIdList := ""
   loop, %NumSngOpen%
   {
      ; if this indexed current table id is not in the list of previously open tables, then increment the number of open tables
      if (NOT instr(SngOpenIdList,NumSngOpen%A_Index%))
         SngNumOpenedThisSession++
      ; add the current indexed table to the list of tables that we will save for next pass through this code
      ListAddItem(NewSngOpenIdList,NumSngOpen%A_Index%)
   }

   ; save the currently generated list of open tables to the global variable for next time
   SngOpenIdList :=  NewSngOpenIdList


   ; check if there has been activity within the fail safe time and
   ;       IF this feature is enabled (SngContinuouslyOpenFailSafeTime > 0),
   ;  if not, stop opening SnGs
   ;
   if ((SngContinuouslyOpenFailSafeTime) AND ( SngContinuousStatus == "Running")  AND (UserTimeIdlePhysical > (SngContinuouslyOpenFailSafeTime * 60000)))
   {
      ; pause opening Sngs
      SngContinuouslyOpenSet(3)
      ; options include:  always on top, Yes No
      MsgBox, 4096,Poker Shortcuts,SnG Inactivity Timer:`n`nThere has been no user activity in the`nlast %SngContinuouslyOpenFailSafeTime% minutes.`n`nClick Resume on the SnG B tab to continue opening SnGs.,30
;      IfMsgBox Yes
;        SngContinuouslyOpenSet(1)
      Return
   }

   ; find the remaining time in our session
   ; find our session time in seconds
   SessionTimeInSeconds := SngContinuouslyOpenPlayTime * 60
   ; find the time we are supposed to stop (in the next 2 lines of code)
   EndTime := SngContinuouslyOpenStartTime
   EndTime += %SessionTimeInSeconds%, seconds
   ; check if we have been opening tables for more than SngContinuouslyOpenPlayTime... if so stop opening tables
   if (  A_Now > EndTime  )
   {
      SngContinuouslyOpenSet(0)
      return
   }


   ; check if we are enabled to stop opening tables after so many have been opened, and that many have been opened
   if ( SngNumOpenedThisSession >= SngStopOpeningAfterNum )
   {
      SngContinuouslyOpenSet(0)
      return
   }


   ; check if we have enough open already
   if (TotalSngOpen  >= SngContinuouslyOpenNumber)
      return
      
      
;outputdebug, Not enough tables are open or pending...  trying to open another
      
   ; if we are not running to open sngs, then just exit
   if (SngContinuousStatus != "Running")
      return
      
      
      
   ; ok, we can try to open a new table
   ; reset our byref variables needed below
   StatusNum := 0
   SngTournamentNum := 0
   SngLobbyId := 0



   ; Loop until we find a Sng that is enabled to be opened
   loop, % SngNumCasinos * SngNumTypes
   {

   
      ; increment the group number, so we try to open a table in the next group.
      ++LastGroupOpened
      
      ; check if we are past the last possible group  (currently 17)
      if (LastGroupOpened > (((SngNumCasinos - 1) * 10) + SngNumTypes))
         LastGroupOpened := 1
      ; if we are trying an invalid number next, in the range of 8-10, then skip to 11
      else if (  (LastGroupOpened >= 8)   AND  (LastGroupOpened <= 10)        )
         LastGroupOpened := 11



      ; check if that group is enabled to open a table
      if Sng%LastGroupOpened%ContinuouslyEnabled
      {
         ; check if this is our Stars group
         if (LastGroupOpened >= PSSngStartingNum)
            PSSngOpen(LastGroupOpened, StatusNum, SngTournamentNum, SngLobbyId)
         ; else it must be a FT type of sng
         else
            FTSngOpen(LastGroupOpened, StatusNum, SngTournamentNum, SngLobbyId)
      }

      ; check if we actually opened a sng
      if (StatusNum == 1)
      {
         ; we now add tables to the pending list in the SngOpen functions
         ; add this table to the pending list
;         ListAddItem(SngPendingLobbyIdList,SngLobbyId)
;         ListAddItem(SngPendingTourneyNumList,SngTournamentNum)

         ; since we opened one, break out of the loop trying to open another
         break

      }
   }     ;  loop end of the number of sng types

   
   

;outputdebug, in SngContinuouslyOpen 3
   
   ; removed in version 4.0004
   ; clean up the pending list of sng tables
;   SngPendingCleanup()

   ; display the status on the sng b tab
   ;SngContinuouslyOpenStatusDisplay()
;outputdebug, in SngContinuouslyOpen at end
   
}


; ********************************************************************************


; NOTE: This should only be called from within the SngContinuouslyOpen() function, as it reads the SngPendingLobbyIdList list, and we want to contain all usage of this list.
SngContinuouslyOpenStatusDisplay()
{
   global
   Local NumSngOpen, NumPendingTablesOpen, SessionTimeInSeconds, EndTime, RemainingTimeSeconds, DisplayMinutes, DisplaySeconds


;   if (SngContinuousStatus == "Stopped")
;      return



   ; get the number of open and pending tables
   WinGet, NumSngOpen, List, ahk_group SngTables
   NumPendingTablesOpen := ListLength(SngPendingLobbyIdList)

   ; find the remaining time in our session
   ; find our session time in seconds
   SessionTimeInSeconds := SngContinuouslyOpenPlayTime * 60
   
   ; find the time we are supposed to stop (in the next 2 lines of code)
   EndTime := SngContinuouslyOpenStartTime
   EndTime += %SessionTimeInSeconds%, seconds
   
;   if EndTime is not number
;      EndTime := 0

   ; find the remaining time in Seconds (in the next 2 lines of code)
   RemainingTimeSeconds := EndTime
   EnvSub, RemainingTimeSeconds, %A_Now%, seconds

;   if RemainingTimeSeconds is not number
;      RemainingTimeSeconds := 0
   
;outputdebug, endtime:%EndTime%    RemainingTimeSeconds:%RemainingTimeSeconds%     SngContinuouslyOpenStartTime: %SngContinuouslyOpenStartTime%     SngContinuouslyOpenStartTime:%SngContinuouslyOpenStartTime%


   ; if we have time left in the session, display that amount of time
   if (A_Now < EndTime  )
   {
   
      ; use floor divide to find the number of minutes left... returns an integer with no rounding
      DisplayMinutes:= RemainingTimeSeconds // 60
      DisplaySeconds := Mod(RemainingTimeSeconds, 60)
      ; put in a leading 0 if DisplaySeconds is only one digit long
      if (strlen(DisplaySeconds) == 1)
         DisplaySeconds := ":0". DisplaySeconds
      else
         DisplaySeconds := ":" . DisplaySeconds
      
      SngTimeLeftStatus := "Time Remaining:   " . DisplayMinutes . DisplaySeconds

   }
   ; else our time has expired, so just display Session Time limit reached
   else
   {
      SngTimeLeftStatus := "Time Remaining:   0:00"
   }


   ; display the time
   Gui, 99:Default
   GuiControl,,SngTimeLeftStatus, %SngTimeLeftStatus%


   SngOpenStatus := "Open:  " . NumSngOpen . "     Pending:  " . NumPendingTablesOpen
   GuiControl,,SngOpenStatus, %SngOpenStatus%          ;Status: Running`nfor %Minutes% more minutes
   
   SngOpenedThisSessionStatus := "Opened this session:  " . SngNumOpenedThisSession
   GuiControl,,SngOpenedThisSessionStatus, %SngOpenedThisSessionStatus%          ;Status: Running`nfor %Minutes% more minutes
   
   ; write the status to the GUI
   GuiControl,, SngContinuousStatus, %SngContinuousStatus%

}

; ********************************************************************************



; enable or disable the Continuously Open Sng feature
; if pEnabled =
;     0  stop opening tables
;     1  resume opening tables
;     2  restart fresh opening tables
;     3  pause opening tables
SngContinuouslyOpenSet(pEnabled)
{
   global

   ; stop opening tables
   if (pEnabled == 0)
   {
   
      outputdebug,   SngContinuouslyOpenSet Stopped !!!
   
      SngContinuousStatus := "Stopped"
;   SetTimer, SngContinuouslyOpen, Off
      ; reset the buttons
      Gui, 99:Default
      GuiControl, Enable, SngStart
      GuiControl, Disable, SngPause
      GuiControl, Disable, SngResume
      GuiControl, Disable, SngStop
      
      ; set the starting time to 1 hour ago, so that the other routines know that we are done with this session
      SngContinuouslyOpenStartTime := A_Now       
      SngContinuouslyOpenStartTime +=  -1, hours

   }
   ; reset and start opening tables
   else if (pEnabled == 2)
   {
      SngContinuousStatus := "Running"
      
      SngContinuouslyOpenStartTime := A_Now        ; set the starting time

      SngNumOpenedThisSession := 0                ; reset the number of SnGs that have been opened for this session


      Gui, 99:Default
      GuiControl, Enable, SngStart
      GuiControl, Enable, SngPause
      GuiControl, Disable, SngResume
      GuiControl, Enable, SngStop
   }
   ; resume opening tables
   else if (pEnabled == 1)
   {
      SngContinuousStatus := "Running"

      Gui, 99:Default
      GuiControl, Enable, SngStart
      GuiControl, Enable, SngPause
      GuiControl, Disable, SngResume
      GuiControl, Enable, SngStop
   }
   ; pause opening tables
   else if (pEnabled == 3)
   {
      SngContinuousStatus := "Paused"
;outputdebug,   SngContinuouslyOpenSet Paused !!!

      Gui, 99:Default
      GuiControl, Enable, SngStart
      GuiControl, Disable, SngPause
      GuiControl, Enable, SngResume
      GuiControl, Enable, SngStop
   }


   


}





; *******************************************************************************
; if there is a sng table pending to open has opened... clean up the pending list
; NOTE: This should only be called from within the SngContinuouslyOpen() function, as it reads the SngPendingLobbyIdList list, and we want to contain all usage of this list.
SngPendingCleanup()
{
   global
   local vPendingLobbyId, vNumPendingLobbies, vIndex, vPendingTournamentNum

;outputdebug, in SngPendingCleanup

;   SngPendingLobbyIdList := ""            ; lobby id list of lobbies that we are waiting for the table to open
;   SngPendingTourneyNumList               ;       and the corresponding Tournament number from the title bar of the lobby


   ; clean up the pending sng lobbies list

   ; if we have a pending open lobby (only from the sng continuous open function)
   ; then we can clear this pending condition if
   ;     the table finally opens
   ;     the lobby does not exist any longer
   ;     the register button is still visible on the sng lobby


   vNumPendingLobbies := ListLength(SngPendingLobbyIdList)

   ; if there is a pending open table, then see if we can clear it
   loop, %vNumPendingLobbies%
   {
;outputdebug, in loop 3
   
      vIndex := vNumPendingLobbies - A_Index + 1

      ; need to work on the tables in reverse order, in case we remove one of them
      vPendingLobbyId := ListGetItem(SngPendingLobbyIdList, vIndex)

      ; get the tournament number for this tournament from our other list
      vPendingTournamentNum := ListGetItem(SngPendingTourneyNumList, vIndex)

      ; if the sng lobby does not exist, then just remove it from the list
      ifWinNotExist, ahk_id%vPendingLobbyId%
      {
         ListDelPos(SngPendingLobbyIdList,vIndex)
         ListDelPos(SngPendingTourneyNumList,vIndex)
         continue
      }
      
      ; remove this tournament from the pending list IF the tournament table has appeared
      ifWinExist, %vPendingTournamentNum% ahk_group Tables
      {
         ListDelPos(SngPendingLobbyIdList,vIndex)
         ListDelPos(SngPendingTourneyNumList,vIndex)
         continue
      }
      

      ; check if the register button OR unregister button (on PS tables) is visible in lobby...  if so, then the table must still be pending
      if ((ButtonVisible("ButtonTournamentLobbyRegister",vPendingLobbyId) == 1) OR (ButtonVisible("ButtonTournamentLobbyUnRegister",vPendingLobbyId) == 1))
      {
         continue
      }
      
      ; ok, the register and unregister buttons are NOT visible...  but let's wait .7 seconds to make sure they are still gone
      
      ; the register button can disappear for about 1/2 second when changing from Register now to Unregister now
      ; we need to wait to make sure that it is really gone
      
      ; this delay also give the table time to show up, so we don't remove it from the from the pending list before the table shows up
      sleep, 700
      

      ; if the register buttons are NOT visible, then we can reset the pending variables
      if NOT ((ButtonVisible("ButtonTournamentLobbyRegister",vPendingLobbyId) == 1) OR (ButtonVisible("ButtonTournamentLobbyUnRegister",vPendingLobbyId) == 1))
      {
         ; allow 7 seconds for the table to appear
         WinWait, %vPendingTournamentNum% ahk_group Tables,,7
      
         ListDelPos(SngPendingLobbyIdList,vIndex)
         ListDelPos(SngPendingTourneyNumList,vIndex)
         continue
      }

      ; the Register button must  be visible, so don't clean up this pending lobby

   }
   
   
;outputdebug, leaving SngPendingCleanup
}




; *******************************************************************************

; open one sng table based the specified number 0-9
;    pContinuousRequest is 1 if this open came from the continuous sng function
; returns 1 if successful, returns 0 if not successful
; StatusNum
;     0 = table not opened
;     1 = sng opened
; SngTournamentNum is the tournament number of the opened sng (disregard this if the status is not 1)

/*
   Options used by FT
   we need to change the name of some of the options... FT doesn't always use obvious names in their options

   FT Uses in txt       FT lby symbol  Shortcuts uses       meaning
   R A                  +              R A                  rebuy addon
   DS                   2 bar stack    DS                   double stack
                        3 bar stack                         superstack (I don't see any of these !!!!!!!!!!!!!!!!!!!!)
   U                    T              T                    turbo                ; this one is a change
   B                    K              KO                   knockout             ; this one is a change
   SO                   S              SO                   shootout
   M                    M              M                    Matrix


   S                                                        6 seats              ; used in the type
   T                                                        2 seats              ; used in the type

*/

FTSngOpen(SngNum, ByRef StatusNum, ByRef SngTournamentNum, ByRef SngLobbyId)
{
   ; make all global vars available in the functions
   global
   ; define local variables here
   local vLobbyId
   local vTableArray, vTableGame, vTableType, vTableStatus, vNumSeats, vTableNumPlayers, vTableBuyIn, vTableRake
   local vTableNumRegPlayers, vTableNumRegSharks
   local vPos1, vLobbyTableString, vLobbyTableStringTemp
   local vFocusedPos, vTableNameList
   local vTablePos, vFocusedTableName, vLastTableId, vSngLobbyTitle
   local vSngDesiredGame,vSngDesiredOptions,vSngDesiredType,vSngDesiredCost,vSngDesiredNumSeats, vSngDesiredNumPlayers
   local vSngDesiredNumRegPlayersMin, vSngDesiredNumRegSharksMax, vSngLobbyText, vSngPaymentType
   local vPlayerList, vPlayerListWindow, vPlayerListFields, vLobbyText
;   local vTablePositionInLobby
;   local vThisTableString, vThisTableStringTemp
   local vNumPlayersTemp
   local vCurrentTime
;   local SngLobbyId
;   local vOpenLobbyList, vOpenLobbyListNew
   local vString
   local CasinoName
   local vNumSharkTournaments, vSharkTournamentNum, Status
   

;outputdebug, in FTSngOpen: %SngNum%



   ; clear the status for this SnG
   Status := "Searching..."
   Gui, 99:Default
   GuiControl,, Sng%SngNum%Status, %Status%

   SngTournamentNum := 0
   SngLobbyId := 0
   StatusNum := 0
   Status := "No suitable table found"

   if ((SngNum < 1) OR (SngNum > 9))
      Return 0


   CasinoName := "FT"
   ; get the main FT Lobby ID
   vLobbyId := LobbyId(CasinoName)
   if NOT vLobbyId
   {
      StatusNum := 0
      Status := "FT Lobby is not open"
      Gui, 99:Default
      GuiControl,, Sng%SngNum%Status, %Status%
      return 0
   }

   ; find the desired parameters from the GUI variables (note the variable SngNum embedded)
   vSngDesiredGame := Sng%SngNum%Game

   vSngDesiredOptions := Sng%SngNum%Options

   ; Full Tilt appends the table options to them game string... so we'll do that too.
   ; make some substitutions in the SHortcuts options to match what FT uses
   StringReplace, vSngDesiredOptions, vSngDesiredOptions,KO,B,All          ; replace Shortcuts KO with FT's U
   StringReplace, vSngDesiredOptions, vSngDesiredOptions,T,U,All           ; replace Shortcuts T with FT's U

   ; game and options are combined on the FT lobby. If the desired options are not None, then add in the options to the game
   if (vSngDesiredOptions <> "None")
      vSngDesiredGame := vSngDesiredGame . " " . vSngDesiredOptions

   vSngDesiredType := Sng%SngNum%Type
   vSngDesiredCost := Sng%SngNum%Cost
   ; remove any commas in case the user put some in there
   StringReplace, vSngDesiredCost, vSngDesiredCost,`,,,All

   vSngDesiredNumRegPlayersMin := SnG%SngNum%NumRegPlayersMin
   vSngDesiredNumSeats := SnG%SngNum%Seats


   ; the number of seats is combined with the Type in the FT lobby.
   if (vSngDesiredNumSeats == 2)
      vSngDesiredType := vSngDesiredType . " T"       ; FT's designation for TWO seats per table
   else if (vSngDesiredNumSeats == 6)
      vSngDesiredType := vSngDesiredType . " S"       ; FT's designation for SIX seats per table

   vSngDesiredNumPlayers := SnG%SngNum%NumPlayers
   vSngDesiredNumRegSharksMax := SnG%SngNum%NumSharksMax
   vSngLobbyText := SnG%SngNum%LobbyText
   vSngPaymentType := SnG%SngNum%PaymentType

   ; trim the white space from aroudn the special lobby text
   vSngLobbyText = %vSngLobbyText%                      ; the autotrim feature will delete and leading/trailing spaces (must use = and not :=)

;OutputDebug, game=%vSngDesiredGame%..type=%vSngDesiredType%..BuyIn=%vSngDesiredCost%..Status=Registering..RegisteredPlayers=%vSngDesiredNumRegPlayersMin%,NumPlayers=%vSngDesiredNumPlayers%

   ;VarSetCapacity(vLobbyTableString,20000)
   ; read the entire lobby table list
   ControlGet, vLobbyTableString, List,, %FTListMainLobbySngTablesControlName%, ahk_id%vLobbyId%
   




   ; clean out the shark list... for each tournament number in the sharklist, see if it is in the lobby. if not remove it from the list
   vNumSharkTournaments := ListLength(SharkSngTourneyNumList)
   ; if there is a tournament in SharkSngTourneyNumList, then see if we can clear it
   loop, %vNumSharkTournaments%
   {
;outputdebug, in loop 4
      vIndex := vNumPendingLobbies - A_Index + 1
      ; need to work on the tables in reverse order, in case we remove one of them
      vSharkTournamentNum := ListGetItem(SharkSngTourneyNumList, vIndex)
      ; if this tournament number is no longer in the big lobby table string, then remove this shark table from our shark list
      if NOT instr(vLobbyTableString,vSharkTournamentNum)
      {
         ListDelPos(SharkSngTourneyNumList,vIndex)
      }
   }





;outputdebug %vLobbyTableString%
;return

   ; Loop thru all the tables in this list, and a sng that matches desired parameters
   ; if no match, then we fall thru to the bottom
   Loop, Parse, vLobbyTableString, `n
   {
;outputdebug, in loop 5
      ; put this sng's string info into an array, for easy disection in to parts
      StringSplit, vTableArray, A_LoopField, %A_Tab%


;outputdebug  *0*%vTableArray0%*1*%vTableArray1%*2*%vTableArray2%*3*%vTableArray3%*4*%vTableArray4%*5*%vTableArray5%*6*%vTableArray6%*7*%vTableArray7%*8*%vTableArray8%*9*%vTableArray9%*10*%vTableArray10%


      SngTournamentNum :=  vTableArray1
      
      


      
      ; if this tournament is on the sharklist, then continue
      if ListGetPos(SharkSngTourneyNumList,SngTournamentNum)
      {
         StatusNum := 0
         Status := SngTournamentNum . ": Too many sharks!"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%
         continue
      }
      
      ; if this tournament is on the pending list, then continue
      if ListGetPos(SngPendingTourneyNumList,SngTournamentNum)
      {
         StatusNum := 0
         Status := SngTournamentNum . ": On pending list"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%
         continue
      }
      ; create a lobby title string that we will look for a match later (to find if the correct lobby is open)
      vSngLobbyTitle := SngTournamentNum . " ahk_class FTCLTourney"
      
      ; if the lobby is already open for this table, then we must have already opened it... so continue to next table
      IfWinExist, %vSngLobbyTitle%
      {
         StatusNum := 0
         Status := SngTournamentNum . ": Lobby is open"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%
         continue
      }
      

      ; get the values out of the lobby data array  vTableArray

      vTableGame := vTableArray2                                             ; save the Table Game (Hold'em, HORSE, etc)
                                                                              ;    options are tagged on the end of this
      vTableType := vTableArray3                                              ; save table type (NL, PL, etc)
                                                                              ;     plus S for six seats, T for 2 seats, nothing for 8/9

      ; remove any commas from the buyin amount
      StringReplace, vTableArray4, vTableArray4,`,,,All
      ; remove the FTP letters if they are there
      StringReplace, vTableArray4, vTableArray4,FTP,,All
      ; remove any spaces in this field
      StringReplace, vTableArray4, vTableArray4,%A_Space%,,All
      ; remove any $ in this field
      StringReplace, vTableArray4, vTableArray4,$,,All
      
      vPos1 := instr(vTableArray4,"+")                                        ; Buy in amount.... find the first +
      if vPos1
      {
         StringMid, vTableBuyIn, vTableArray4, 1, vPos1 - 1                                     ; get the buy in amount
         StringMid, vTableRake, vTableArray4, vPos1 + 1, strlen(vTableArray4) - vPos1       ; get the rake amount
      }
      ; if there is no plus sign, then there is no house rake
      else
      {
         vTableBuyIn := vTableArray4
         vTableRake := 0
      }

      vTableStatus := vTableArray5                                            ; get table status (Registering, Running, etc.)

      ; if a happy hour H appears in the players field, erase it
      StringReplace, vTableArray6, vTableArray6,%A_Space%H,,All

      ; get the number of players at table(s)
      vPos1 := instr(vTableArray6,"of")
      StringMid, vTableNumRegPlayers, vTableArray6, 1, vPos1 - 2
      StringMid, vTableNumPlayers, vTableArray6, vPos1 + 3, strlen(vTableArray6) - vPos1 - 2

      vTableCost := vTableBuyin + vTableRake

;OutputDebug, game=%vTableGame%..type=%vTableType%..BuyIn=%vTableBuyIn%..rake=%vTableRake%..Status=%vTableStatus%..RegisteredPlayers=%vTableNumRegPlayers%,NumPlayers=%vTableNumPlayers%
;return



;OutputDebug, game=%vTableGame%..type=%vTableType%..BuyIn=%vTableCost%..Status=%vTableStatus%..RegisteredPlayers=%vTableNumRegPlayers%,NumPlayers=%vTableNumPlayers%  SngTournamentNum=%SngTournamentNum%
;OutputDebug, game=%vSngDesiredGame%..type=%vSngDesiredType%..BuyIn=%vSngDesiredCost%..Status=Registering..RegisteredPlayers=%vSngDesiredNumRegPlayersMin%,NumPlayers=%vSngDesiredNumPlayers%


      ; see if the sng that we are indexed on is what we want
      If (      (vTableGame ==    vSngDesiredGame)
            AND (vTableType ==    vSngDesiredType)
            AND (vTableCost ==    vSngDesiredCost)
            AND (vTableNumPlayers == vSngDesiredNumPlayers)
            AND (vTableStatus ==  "Registering")       )
      {
;OutputDebug, game=%vTableGame%..type=%vTableType%..BuyIn=%vTableCost%..Status=%vTableStatus%..RegisteredPlayers=%vTableNumRegPlayers%,NumPlayers=%vTableNumPlayers%
;OutputDebug, game=%vSngDesiredGame%..type=%vSngDesiredType%..BuyIn=%vSngDesiredCost%..Status=Registering..RegisteredPlayers=%vSngDesiredNumRegPlayersMin%,NumPlayers=%vSngDesiredNumPlayers%


         ; OK most of the paramters for this table match what we want...
         ; we haven't check for Special Lobby text, Number of players registered, and Number of Sharks




         ; check if there are too few registered players, if so continue to next table
         ; we  check it here since all the above criteria are met, and we can change the status if we need to
         ; if there are too few players
         if (vTableNumRegPlayers < vSngDesiredNumRegPlayersMin)
         {
;outputdebug, There are not enough registered players
         StatusNum := 0
         Status := SngTournamentNum . ": Too few players"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%
         continue
         }


;outputdebug, after check for num of registered players
;OutputDebug, game=%vTableGame%..type=%vTableType%..BuyIn=%vTableCost%..Status=%vTableStatus%..RegisteredPlayers=%vTableNumRegPlayers%,NumPlayers=%vTableNumPlayers%
;OutputDebug, game=%vSngDesiredGame%..type=%vSngDesiredType%..BuyIn=%vSngDesiredCost%..Status=Registering..RegisteredPlayers=%vSngDesiredNumRegPlayersMin%,NumPlayers=%vSngDesiredNumPlayers%


         ; OK, we have a potential sng that we want to open up the lobby, to check it further
         ; Loop until we have highlighted the table we want in the lobby
         ; try it 5 times before quitting
         Loop, 5
         {
;outputdebug, in loop 5
            ; move to the top of the lobby list
            ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{Home}, ahk_id%vLobbyId%
            ; get the current "focused" position that we are at in the lobby
            ControlGet, vFocusedPos, list, Count Focused, %FTListMainLobbySngTablesControlName%, ahk_id%vLobbyId%
                                                           
            ; VarSetCapacity(vLobbyTableStringTemp,20000)
            ; read the entire lobby table list again so we can position the highlighter on the proper on in the lobby
            ; since this took us awhile to find a table, the number of tables may have changed
            ; since we started, and we don't want to move to the wrong table
            ControlGet, vLobbyTableStringTemp, List,, %FTListMainLobbySngTablesControlName%, ahk_id%vLobbyId%

            vTablePos := 0

            ; Loop thru all the tables in this list,
            ;    looking for a match with the one we found above (we use the vThisTableString to find a match)
            ; if no match, then we fall thru to the bottom
            ; we do this in case the tournament as filled up quickly, and we just want to make sure it is still in the lobby
            Loop, Parse, vLobbyTableStringTemp, `n
            {
;outputdebug, in loop Parse vLobbyTableStringTemp
               ; see if we have the correct position of the string we need, by seeing if this is the same SngTournamentNum
               if (instr(A_LoopField,SngTournamentNum))
               {
                  vTablePos := A_index
                  break
               }
            }


            ; check if our table was NOT found in the list, if not break which means it is no longer is in lobby
            if (NOT vTablePos)
            {
               break                ; jump out of the loop 5, which will just return us from this function
            }


            ; we found the table position...
            ; find out how far we have to move the focused position in the lobby
            vFocusedOffset := vTablePos - vFocusedPos

;outputdebug, vFocusedOffset=%vFocusedOffset%
;outputdebug, vTablePos=%vTablePos%


            ; if vFocusedOffset is positive, then we need to move down the list
            if (vFocusedOffset > 0)
            {
               ; pagedown once for every 17
               Loop, % vFocusedOffset // 17
                  ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{PgDn}, ahk_id%vLobbyId%
               ; down once for every modulo remainder
               Loop, % mod(vFocusedOffset, 17)
                  ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{Down}, ahk_id%vLobbyId%
            }
            ; else if it is negative, then we need to move up the list
            else if (vFocusedOffset < 0)
            {
               vFocusedOffset := -vFocusedOffset
               ; pageup once for every 17
               Loop, % vFocusedOffset // 17
                  ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{PgUp}, ahk_id%vLobbyId%
               ; up once for every modulo remainder
               Loop, % mod(vFocusedOffset, 17)
                  ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{Up}, ahk_id%vLobbyId%
            }

            ; small time delay to allow the full tilt table to catch up
            sleep, 75


;outputdebug, after sleep 75

            ; we should be focused on the proper table in the list...
            ; but need to check it (yet again), in case the table list has changed, which it
            ; often does.

            ; get the string of the table that we are focused on in the lobby
            ControlGet, vString, list, Focused, %FTListMainLobbySngTablesControlName%, ahk_id%vLobbyId%
            ; if our tournament number is in this string, then break out of the loop
            if (instr(vString,SngTournamentNum))
               break
         }                                   ; end of the loop, 5    that highlights the proper table in the lobby





         ; we need to check if we fell through the above loop without highlighting the table we wanted
         ; If so, then continue to try the next table in the list
         if (NOT(instr(vString,SngTournamentNum)))
         {
            StatusNum := 0
            Status := SngTournamentNum . ": Tournament removed from lobby"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }

         ; OK we have the correct table highlighted !!!
;outputdebug   we have correct table highlighted, entering critical section


         ; make this section critical because if the user has a lot of tables open already,
         ;     the other timers will take priority over this one and never give this
         ;     section of code a chance to finish. The SnG table could fill up before
         ;     we get a chance to open the table.
         ; if    UseCriticalMethodDisabled is true, the user wants to use the faster method, that gives Critical priority to this subroutine to get the job done without interruption
         ; sometimes if this is enabled, it can cause lagginess in the other operations of Shortcuts going on at the tables (hotkeys are not responding quickly, etc.)
         if (NOT UseCriticalMethodDisabled)
            Critical
;outputdebug, after critical


         ; we are now focused on the correct table in the lobby.
         ; IF the user has specified some Special Lobby Text, then we have to search the lobby to see if it is present.
         if vSngLobbyText
         {

            ; wait for the lobby to refresh itself, so that we can read the lobby text below
            ; wait for up to FTWinOpenTimeMS for the the Lobby to refresh with the special text area
            ;    it says "Loading..." when it is loading in this text
            ;    wait until it is not "Loading..."
            vCurrentTime := A_TickCount
            loop
            {
;outputdebug, in loop 8
               ; read the entire text from the lobby window, and see if it contains the "Spec. Lobby Text"
               ; so we are sure we are opening a correct table (and not some table that has similar buyins, but
               ; might be a Tier One or Satellite SnG)
               ; Set the var capacity, so we are sure to get all of the text in the lobby window
               VarSetCapacity(vLobbyText , 2000)
               WinGetText, vLobbyText, ahk_id%vLobbyId%

               ; break out of this delay loop if the "Loading..." is not longer there
               if (Not instr(vLobbyText, "Loading..."))
               {
                  break
               }

               ; exit out of this function if the Loading text does not dissappear, the code below will cause a continue if the special text is not found
               if ((A_TickCount - vCurrentTime) > FTWinOpenTimeMS)
               {
;outputdebug, the Lobby showed 'Loading...' for too long
                  break
               }
            }


            ; if the special lobby text is not in the lobby text, then continue on to next table
            if (Not instr(vLobbyText, "[CENTER]" . vSngLobbyText, 1))
            {
;outputdebug, special lobby text is not in the lobby text
;outputdebug, -------------------------------------------
;outputdebug, vLobbyText=%vLobbyText%
;outputdebug, vSngLobbyText=%vSngLobbyText%
               Critical, Off
               StatusNum := 0
               Status := SngTournamentNum . ": Wrong Spec. Lobby Text"
               Gui, 99:Default
               GuiControl,, Sng%SngNum%Status, %Status%
               continue
            }

            ; OK, the special lobby text has been verified...

         }


         ; OK, special lobby text is a MATCH (if it was specified)
         ; AND we have at least the desired number of registered players
;outputdebug, Special Lobby text is a MATCH (if specified) and we have at least the desired number of registered players


         ; we will not open the lobby, and check for sharks

         ; send "enter" to the lobby, to open up the lobby
         ControlSend, %FTListMainLobbySngTablesControlName%, {Blind}{Enter}, ahk_id%vLobbyId%


;outputdebug, Enter has been pushed to open lobby
;outputdebug, opening lobby for tournament:  %SngTournamentNum%

         ; wait for the lobby to open... if it doesn't open, then return saying that we didn't find a table
         WinWait,  %vSngLobbyTitle% ,,FTWinOpenTime
         IfWinNotExist, %vSngLobbyTitle%
         {
;outputdebug, new lobby didn't open (perhaps it is already open)
            Critical, Off
            StatusNum := 0
            Status := SngTournamentNum . ": T-Lobby not found"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }


         ; the lobby for this tournament has opened
;outputdebug, lobby opened successfully



         ; get the lobby id
         SngLobbyId := WinExist(vSngLobbyTitle)

;outputdebug, SngLobbyId=%SngLobbyId%
;outputdebug, SngTournamentNum=%SngTournamentNum%


         ; ok, I think we are sure we got the lobby opened that we wanted


         ; wait for the register now button to appear
         loop, 100
         {
;outputdebug, in loop 100 waiting for register button to show up
            if (ButtonVisible("ButtonTournamentLobbyRegister",SngLobbyId) == 1)
               break
            sleep, 20
         }

         ; if the register now button is still not visible, then return close lobby and return saying the the table was not found
         if Not (ButtonVisible("ButtonTournamentLobbyRegister",SngLobbyId) == 1)
         {
            ;WinClose, Tournament %SngTournamentNum%
            ; changed to control send, because FT sometimes does not pick up the fact that the lobby is closed
            ControlSend,,!{F4}, ahk_id%SngLobbyId%
            Critical, Off
            StatusNum := 0
            Status := SngTournamentNum . ": No Register Button"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }


         ; the register button is visible
;outputdebug, register button is visible

         ; check the number of sharks at this table... if there are too many, then don't register (just return)
         ; get the list of players at this table now
         ;ControlGet, vPlayerListWindow, List,, %FTListMainLobbySngTablesControlName%, Tournament %SngTournamentNum%
         ; wait for the list of players to appear (without the words "Loading.." in it)
         loop, 100
         {
;outputdebug, in loop 10
            ControlGet, vPlayerListWindow, List,, %FTListMainLobbySngTablesControlName%, ahk_id%SngLobbyId%
            if !(InStr(vPlayerListWindow, "Loading..."))
               break
            sleep, 20
         }
         ; if the string still shows "Loading...", then it is slow...
         if (InStr(vPlayerListWindow, "Loading..."))
         {
            ;outputdebug, SnG Lobby was still showing "Loading..." in the player list box
            ;WinClose, Tournament %SngTournamentNum%
            ControlSend,,!{F4}, ahk_id%SngLobbyId%
            Critical, Off
            StatusNum := 0
            Status := SngTournamentNum . ": No Player List"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }
         ; make comma delimited list of players already seated at this table
         vPlayerList := ""
         Loop, Parse, vPlayerListWindow, `n
         {
;outputdebug, in loop 11
            ; break this next line into an array, so we can get the player's name, in array element 3
            StringSplit, vPlayerListFields, A_LoopField, %A_Tab%
            ; for some reason FT now puts 1 weird character in the name field for each player... need to strip off the first character
            StringTrimLeft, vPlayerListFields3, vPlayerListFields3, 1

            ListAddItem(vPlayerList,vPlayerListFields3)
         }
         vTableNumRegPlayers := ListLength(vPlayerList)
         vTableNumRegSharks := 0
         ; see if any of the registered players are sharks... count them
         Loop, % vTableNumRegPlayers
         {
;outputdebug, in loop 12
            ; check if each player in vPlayerList is a shark listed in the SharkList
            if ListGetPos(SharkList,ListGetItem(vPlayerList,A_index))
               vTableNumRegSharks++
         }

         ;outputdebug, PlayerList= %vPlayerList%
         ;outputdebug, SharkList= %SharkList%
         ;outputdebug, NumRegPlayers= %vTableNumRegPlayers%   DesiredNumPlayers= %vSngDesiredNumRegPlayersMin%
         ;outputdebug, NumRegSharks= %vTableNumRegSharks%     MaxNumRegSharks= %vSngDesiredNumRegSharksMax%`n`n


         ; if there are too many sharks at this table, then close lobby and return with status of too many sharks at this table
         if (vTableNumRegSharks > vSngDesiredNumRegSharksMax)
         {
;outputdebug, too many sharks at table
            ; add this tournament number to our sharklist
            ListAddItem(SharkSngTourneyNumList,SngTournamentNum)

            ;WinClose, Tournament %SngTournamentNum%
            ControlSend,,!{F4}, ahk_id%SngLobbyId%
            Critical, Off
            StatusNum := 0
            Status := SngTournamentNum . ": Too many sharks!"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }


         ; OK, we have check all of our criteria... we can register for this table

         ;outputdebug, register now button
         ; click the register now button
         ButtonClick("ButtonTournamentLobbyRegister",SngLobbyId)

         ; wait for Tournament Buy In dialog box
         WinWait, Tournament Buy-in ,,FTWinOpenTime
         ; if the dialob box does not show up, then return
         IfWinNotExist, Tournament Buy-in
         {
            ControlSend,,!{F4}, ahk_id%SngLobbyId%
            Critical, Off
            StatusNum := 0
            Status := SngTournamentNum . ": Buy-In Dialog not found"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            continue
         }




;         BuyInTournamentWithDollarsButtonControlName := "FTCSkinButton1"             ; agree to buyin to tournament (sng) with $$ button
;         BuyInTournamentWithTDollarsButtonControlName := "FTCSkinButton2"             ; agree to buyin to tournament (sng) with T$ button
;         BuyInTournamentWithToken26ButtonControlName := "FTCSkinButton3"             ; agree to buyin to tournament (sng) with $26 token button
;         BuyInTournamentWithToken75ButtonControlName := "FTCSkinButton4"             ; agree to buyin to tournament (sng) with $75 token button
;         BuyInTournamentWithFTPointsButtonControlName := "FTCSkinButton5"          ; agree to buyin to tournament (sng) with FT Points button
;         BuyInTournamentWithPlayChipsButtonControlName := "FTCSkinButton7"             ; agree to buyin to tournament (sng) with Play Chips button



;outputdebug, end sngopen   SngTournamentNum:%SngTournamentNum%
;return 0

         ; if we are allowed to click the OK button to actually buy in to this tourney, then do so
         ; if we are manually opening a SNG, then let the dialog box function decide if it should buy in to this sng
         if (ClickOkForSngEnabled AND ( SngContinuousStatus == "Running"))
         {

            ; click the button depending on $, T$, FTP, Play
            if (vSngPaymentType == "$")
               ControlClick, FTCSkinButton1,,,,NA
            else if (vSngPaymentType == "T$")
               ControlClick, FTCSkinButton2,,,,NA
            else if (vSngPaymentType == "FTP")
               ControlClick, FTCSkinButton3,,,,NA
            else if (vSngPaymentType == "Token")
            {
               ControlClick, FTCSkinButton5,,,,NA                 ; $26 token button
               ControlClick, FTCSkinButton6,,,,NA                 ; $75 token button
            }
            else if (vSngPaymentType == "Play")
               ControlClick, FTCSkinButton7,,,,NA
            sleep, -1

            ; minimize the Sng Lobby if this feature is enabled
            ;WinMinimize, Tournament %SngTournamentNum%
            if MinimizeSngLobbyEnabled
               PostMessage, 0x112, 0xF020,,, ahk_id%SngLobbyId%
               
            ; we have sucessfully opened a sng
            Critical, Off
            StatusNum := 1
            Status := SngTournamentNum . ": Registered!"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            
            ; add this table to the pending list
            ListAddItem(SngPendingLobbyIdList,SngLobbyId)
            ListAddItem(SngPendingTourneyNumList,SngTournamentNum)
            
            return 1
         }
         else
         {
            ; we are left waiting for the user to buy in
            Critical, Off
            StatusNum := 1
            Status := SngTournamentNum . ": Manual Buy-In"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            
            ; add this table to the pending list
            ListAddItem(SngPendingLobbyIdList,SngLobbyId)
            ListAddItem(SngPendingTourneyNumList,SngTournamentNum)
            
            return 1
         }
      }              ; end of the IF statement that tests most of the parameters of the desired table
   }                 ; end of the Loop that parses all the tables in the lobby

   ; we were not able to find a sng in the list
   Critical, Off
   StatusNum := 0
   Status := "No suitable table found"
   Gui, 99:Default
   GuiControl,, Sng%SngNum%Status, %Status%
   return 0
}



; *******************************************************************************

; open one sng table based the specified number 0-9
;    pContinuousRequest is 1 if this open came from the continuous sng function
; returns 1 if successful, returns 0 if not successful
; StatusNum
;     0 = no table found
;     1 = sng opened
; SngTournamentNum is the tournament number of the opened sng (disregard this if the status is not 1)
; SngLobbyId is the id of the tournament lobby (disregard this if the status is not 1)
PSSngOpen(SngNum, ByRef StatusNum, ByRef SngTournamentNum, ByRef SngLobbyId)
{
   ; make all global vars available in the functions
   global
   ; define local variables here
   local LobbyId, LobbyIdList
   local CasinoName, RegId, Status
   local X, Y, W,H,ColTol, ClientScaleFactor, FileName
   local StartTime, InitialIdList, CurrentIdList, index, Title
   
   
   ; clear the status for this SnG
   Status := "Searching..."
   Gui, 99:Default
   GuiControl,, Sng%SngNum%Status, %Status%
   
   CasinoName := "PS"
   
   LobbyId := LobbyId(CasinoName)
   ; if the lobby is not visible, then return
   if NOT LobbyId
   {
      StatusNum := 0
      Status := "Stars Lobby is not open"
      Gui, 99:Default
      GuiControl,, Sng%SngNum%Status, %Status%
      return 0
   }
      
   ; verify that the user is logged in
   WinGetTitle, Title, ahk_id%LobbyId%
   if NOT (Instr(Title,"Logged in as"))
   {
      StatusNum := 0
      Status := "User is not logged in"
      Gui, 99:Default
      GuiControl,, Sng%SngNum%Status, %Status%
      return 0
   }

   SngTournamentNum := 0
   SngLobbyId := 0
   StatusNum := 0
   Status := "No suitable table found"


;outputdebug, in PS SngOpen    LobbyId:%LobbyId%
      
   ; clear the status for this SnG
   Status := "Make sure Lobby is visible..."
   Gui, 99:Default
   GuiControl,, Sng%SngNum%Status, %Status%
      
   ; I can't find a way to put the lobby on top, without activating it. So I'll make the user responsible
   ; unminimize the lobby, and put it on top
   
   ; make sure the ps main lobby is on top
;   WinMinimize, ahk_id%LobbyId%
   ;PostMessage, 0x112, 0xF020,,,ahk_id%LobbyId%
;   WinRestore,  ahk_id%LobbyId%


   ; get the file name of the image of the sng we are looking for
   FileName := "Themes\" . PSLobbyTheme . "\SngImages\" . Sng%SngNum%Game . ".bmp"
   ; position of the Button
   X := PSListMainLobbySngTablesX
   Y := PSListMainLobbySngTablesY
   W := PSListMainLobbySngTablesW
   H := PSListMainLobbySngTablesH
   ColTol := PSListMainLobbySngTablesColorTolerance


;outputdebug,   FileName:%FileName%  PosX:%X%  PosY:%Y%  ColTol:%PSListMainLobbySngTablesColorTolerance%  W:%PSListMainLobbySngTablesW%   H:%PSListMainLobbySngTablesH%

   ; convert the x,y position to a screen position
   WindowScaledPos(X, Y, ClientScaleFactor, "Screen", LobbyId)

   
   
   ; move to the top of the sng table list in the lobby
   ControlSend, %PSListMainLobbySngTablesControlName%, {PgUp 20}, ahk_id%LobbyId%

   ; loop up to 100 times moving downward trying to find a sng to open
   loop, 100
   {
;outputdebug, top of loop 20 ***************************************************************************************

      ; put some sleep here to allow PS to respond to the DOWN command (which moves us to the next SNG in the lobby)
      sleep 100        ; change this back to 100

      ; make sure the ps main lobby is on top  (new in 4.0004)
      
      ; wait here for 1 second until the PS lobby is on top
      StartTime := A_TickCount
      loop
      {

         ; make sure the ps main lobby is on top - NOTE this only seems to bring the lobby to the top if it is covered by other Poker Stars windows (tables or  tournament lobbies)
         WinSet, Top,, ahk_id%LobbyId%

         if (NOT WindowIsOverlayed(LobbyId))
         {
;outputdebug, lobby is NOT overlayed
            break
         }
         if ((A_TickCount - StartTime) > 1000)
         {
;outputdebug, Main Lobby is Overlayed
            StatusNum := 0
            Status := "Main Lobby Not Visible"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            return 0
         }
      }

   
      ; loop here until the register button is visible - 200ms, else continue
      StartTime := A_TickCount
      loop
      {
         ; if the register button is visible in the main lobby, then break out
         if (ButtonVisible("ButtonMainLobbyRegister",LobbyId) == 1)
         {
;outputdebug, Register button is visible
            break
         }
         ; if we timed out, break
         if ((A_TickCount - StartTime) > 400)
         {
            break
         }
      }
      ; if we timed out, move down to the next table and continue
      if ((A_TickCount - StartTime) > 400)
      {
;outputdebug, Register button is NOT visible
         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }

      
      ; do image recognition to see if a table that we are looking for is highlighted
      



      ; REMMOVED IN VER 4.00004
      ; make sure that the table is visible at XY
;      if WindowIsOverlayedAtXY(X,Y,LobbyId)
;      {
;            StatusNum := 0
;            Status := "Stars Main Lobby Not Visible!"
;            Gui, 99:Default
;            GuiControl,, Sng%SngNum%Status, %Status%
;      }

      ; search for the image, return 0 if a match
      CoordMode,Pixel,Screen
      ImageSearch,,,  X, Y, X + W , Y + H, *%ColTol% %FileName%
      ; Errorlevel == 1 if the image was NOT found so continue
;outputdebug, Searching for SNG image   FileName:%FileName%  PosX:%X%  PosY:%Y%   ErrorLevel:%ErrorLevel%   ColTol:%PSListMainLobbySngTablesColorTolerance%  W:%PSListMainLobbySngTablesW%   H:%PSListMainLobbySngTablesH%
      if ErrorLevel
      {
;outputdebug, SnG Image NOT FOUND
         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }

;outputdebug, Found SnG Image


      ; make a count and a list of the existing PS Tournament Lobbies that are open
      WinGet, InitialIdList, List, ahk_group PSTournamentLobby
      
;outputdebug,  InitialIdList:%InitialIdList%      InitialIdList1:%InitialIdList1%    InitialIdList2:%InitialIdList2%
      


      
      ; open the SnG lobby for this Sng
      ControlSend, %PSListMainLobbySngTablesControlName%, {Enter}, ahk_id%LobbyId%
      
      
      ; we now need to wait for one additional lobby to open, and that will be the one that we need
      StartTime := A_TickCount
      Loop,
      {
         WinGet, CurrentIdList, List, ahk_group PSTournamentLobby
         
         ; break when we have opened another PS t lobby (which must be the one we wanted)
         if (CurrentIdList > InitialIdList)
            break
            
         if ((A_TickCount - StartTime) > PSWinOpenTimeMS)
            break
      }

      ; if we timed out then continue
      if ((A_TickCount - StartTime) > PSWinOpenTimeMS)
      {
;outputdebug, SnG Lobby did not open, continuing
         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }
      
;outputdebug,  CurrentIdList:%CurrentIdList%   1:%CurrentIdList1%   2:%CurrentIdList2%
      
      ; our newest table SHOULD be the topmost window fomr the WinGet List command (in array 1 position)
      index := 1
      SngLobbyId := CurrentIdList%index%

      ; get the id of this active window (uses the "last found window" feature of ahk)
      ;WinGet, SngLobbyId, id


;outputdebug, id for sng lobby found:   SngLobbyId:%SngLobbyId%

      ; THIS DOESN'T SEEM NECESSARY... removed in 4.0004
      ; double verify that this id is for a tournament lobby
;      IfWinNotExist,ahk_id%SngLobbyId% ahk_group PSTournamentLobby
;      {
;         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
;         continue
;      }


;;outputdebug, t lobby double verified that it exists

         
      ; we now need to wait for the Register button to appear
      StartTime := A_TickCount
      Loop,
      {
         if (ButtonVisible("ButtonTournamentLobbyRegister",SngLobbyId) == 1)
            break

         if ((A_TickCount - StartTime) > PSWinOpenTimeMS)
            break
      }
      
      
      ; continue if the register button is not visible in the tournament lobby
      if ((ButtonVisible("ButtonTournamentLobbyRegister",SngLobbyId) == 0))
      {
;outputdebug, ButtonTournamentLobbyRegister NOT visible... continuing

         ; should we be closing this SngLobbyId, since the register button is not visible ????    I think so
         ; added this in ver 4.0004
         ; close the tournament lobby
         WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby

         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }

;outputdebug, ButtonTournamentLobbyRegister is visible



      ; get the tournament number for this tournament
      if NOT (SngTournamentNum := SngLobbyTournamentNum(SngLobbyId))
      {

         ; should we be closing this SngLobbyId, since the register button is not visible ????    I think so
         ; added this inver 4.0004
         ; close the tournament lobby
         WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby

         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }
      
;outputdebug, SngTournamentNum:%SngTournamentNum%
      
      ;  we need to verify that we really opened a tournament lobby of the type we wanted. Do image recognition on the lobby to make sure that a valid type is stilll highlighted.
      ; first minimize the lobby
;      WinMinimize, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
      ;PostMessage, 0x112, 0xF020,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby

      

/*   REMOVED IN 4.0005
      ; wait here for 1/2 second until the PS lobby is on top again
      StartTime := A_TickCount
      loop
      {

         ; make sure the ps main lobby is on top - NOTE this only seems to bring the lobby to the top if it is covered only by other Poker Stars windows (tables or  tournament lobbies)
         WinSet, Top,, ahk_id%LobbyId%
         
         if (NOT WindowIsOverlayed(LobbyId))
            break
            
         if ((A_TickCount - StartTime) > 1000)
         {
            StatusNum := 0
            Status := "Main Lobby Not Visible (2)"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%
            return 0

         }
      
      }
*/




/* removed in 4.0005

outputdebug, doing double check that the same lobby is highlighted in the lobby

      
      ; do image recognition again
      ; It could be that the table we were on filled up the instant we sent an ENTER to open this lobby.
      ; Poker Stars could have closed that entry in the lobby, and moved our highlight to a different type of lobby
      ; So we want to do image recognition on the lobby again to make sure that the same type of table is still highlighted.
      CoordMode,Pixel,Screen
      ImageSearch, ,,  X, Y, X + W , Y + H, *%ColTol% %FileName%
      ; Errorlevel == 1 if the image was NOT found so continue
;outputdebug, in PS SngOpen   FileName:%FileName%  PosX:%PosX%  PosY:%PosY%   ErrorLevel:%ErrorLevel%   ColTol:%PSListMainLobbySngTablesColorTolerance%  W:%PSListMainLobbySngTablesW%   H:%PSListMainLobbySngTablesH%
      if ErrorLevel
      {
outputdebug, the same type of table was NOT still highlighted in the lobby
         ; close the tournament lobby
         WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
         ;PostMessage, 0x112, 0xF060,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby
         
         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }
      
      ; unminimize the tournament lobby 
;      PostMessage, 0x112, 0xF120,,, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
;      WinRestore, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
;      sleep, 1000
;      WinSet,Redraw,, ahk_id%SngLobbyId% ahk_group PSTournamentLobby

      ; Removed in 4.0004    didn't see any need for delay
;      sleep, 200
      
      
outputdebug, our table was still visible in the lobby 2nd time
*/

      ; click the register button
      ButtonClick("ButtonTournamentLobbyRegister",SngLobbyId)
      
;outputdebug, clicked the tournament lobby register button
      
      ; wait for the registration dialog box to show up
      WinWait, Tournament Registration ahk_class #32770, , PSWinOpenTime
      ; if we did time out, then continue
      if ErrorLevel
      {
;outputdebug, tournament registration dialog box never showed up
         ; close the tournament lobby
         WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
         ;PostMessage, 0x112, 0xF060,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby

         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }
      

      ; get the id of the registration dialog box
      WinGet, RegId, id, Tournament Registration ahk_class #32770
      
;outputdebug, tournament registration dialog box is opened
      
      ; sometimes when we try to register for a sng, we get another warning dialog box, where they are giving us some info.
      ; This dialog box only has two buttons on it. So if this first box does not have Button4 on it, then we close it and wait for the next dialog box
      ControlGet, ButtonVisibleFlag,Visible,,Button4, ahk_id%RegId%
      if NOT ButtonVisibleFlag
      {
      
;outputdebug, we have some other registration dialog box open that we need to get rid of
         ; we must have some other dialog box... click on Button1 to get rid of it
         ControlSend, Button1, {ENTER}, ahk_id %RegId%
         
         ; wait for the "real" registration dialog box to show up
         WinWait, Tournament Registration ahk_class #32770, , PSWinOpenTime
         ; if we did time out, then skip trying for this registration
         if ErrorLevel
         {
            ; close the lobby
            WinClose, ahk_id%SngLobbyId%
            StatusNum := 0
            Status := SngTournamentNum . ": Buy-In Dialog not found"
            Gui, 99:Default
            GuiControl,, Sng%SngNum%Status, %Status%

            ; close the tournament lobby
            WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
            ;PostMessage, 0x112, 0xF060,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby


            ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
            continue

         }
         ; we should have the real registration box now
         ; get the id of the registration dialog box
         WinGet, RegId, id, Tournament Registration ahk_class #32770
         
         ; verify that this dialog box has a Button4... if not, close the lobby and continue
         ControlGet, ButtonVisibleFlag,Visible,,Button4, ahk_id%RegId%
         if NOT ButtonVisibleFlag
         {
            ; close the tournament lobby
            WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
            ;PostMessage, 0x112, 0xF060,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby

            
            ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
            continue
         }
      }

      ; continue if we did not get a a valid ID
      if NOT RegId
      {
      
;outputdebug, we never found the registration dialog box to buy in
         ; close the tournament lobby
         WinClose, ahk_id%SngLobbyId% ahk_group PSTournamentLobby
         ;PostMessage, 0x112, 0xF060,,,ahk_id%SngLobbyId% ahk_group PSTournamentLobby

      
         ControlSend, %PSListMainLobbySngTablesControlName%, {NumpadDown}, ahk_id%LobbyId%
         continue
      }
      
      ; click on the buy in button
      ;ControlSend, Button1, {Space}, ahk_id %RegId%
      ;ControlSend, Button1, {Space}, ahk_id %RegId%
      ;sleep 50
   
      ; if we are supposed to register for the sng AND we are in the continuous opening mode, then click the proper buttons to register
      ; if we are manually opening a SNG, then let the dialog box function decide if it should buy in to this sng
      if (ClickOkForSngEnabled AND ( SngContinuousStatus == "Running"))
      {

;outputdebug, auto buying into this sng
         ; click on the OK button to buy in
         ;ControlSend, Button3, {ENTER}, ahk_id %RegId%
         ControlClick, Button3, ahk_id %RegId%,,,,NA         
;outputdebug, clicked button3         
         ; wait here for this registration dialog box to close - added in version 4.0004
         WinWaitClose, ahk_id%RegId%,,PSWinOpenTime
         
         
         ; wait for the FINAL tournament registration dialog box to show up, and close it
         ; this one just says that you are registered
         WinWait, Tournament Registration ahk_class #32770, , PSWinOpenTime
         WinClose, Tournament Registration ahk_class #32770
         
         
         ; ????????????????????   should we put a test in here to verify that we didn't get the "Registration Closed" dialog box ?????????????????????????????????????????????
         ; that way we know we didn't miss getting into the tournament
         ; or we could have the dialog checker routine set a flag saying that it say this dialog box ?????????????????????????????????????????????????????????????????????????
         ;        Title:Tournament Registration
         ;        ClientSize:  265 x 125
         ;        WindowText:
         ;        OK
         
         ; close the lobby
         StatusNum := 1
         Status := SngTournamentNum . ": Registered!"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%
         
         
         

         ; add this table to the pending list
         ListAddItem(SngPendingLobbyIdList,SngLobbyId)
         ListAddItem(SngPendingTourneyNumList,SngTournamentNum)
         
         ; if enabled, minimize the Sng Lobby
         if MinimizeSngLobbyEnabled
         {
            sleep, 50
            WinMinimize, ahk_id%SngLobbyId%
         }
         return 1
      }
      ; else we didn't finish registering... leaving that up to the user
      else
      {
;;outputdebug, User must manually buy in (not enabled to auto buy in)
         StatusNum := 1
         Status := SngTournamentNum . ": Manual Buy-In"
         Gui, 99:Default
         GuiControl,, Sng%SngNum%Status, %Status%

         ; add this table to the pending list
         ListAddItem(SngPendingLobbyIdList,SngLobbyId)
         ListAddItem(SngPendingTourneyNumList,SngTournamentNum)
         
         return 1
      }

      
      ; we must have completed registering... we should never get here
      ; we always continue above when we want to try the next table down



   }  ; end of the loop that tries 20 times for find a sng


;outputdebug, We finished looping to open SNG, but we were not able to open a SNG
   ; we were not able to find a sng in the list
   ;Critical, Off
   StatusNum := 0
   Status := "No suitable table found"
   Gui, 99:Default
   GuiControl,, Sng%SngNum%Status, %Status%
   return 0
}



