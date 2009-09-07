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
; Lobby Functions
; -------------------------------------------------------------------------------
; *******************************************************************************





; get the lobby ID of the casino CasinoName
LobbyId(CasinoName)
{
   local WinId
   WinGet, WinId, ID, ahk_group %CasinoName%Lobby
   
;outputdebug, in lobbyid    CasinoName:%CasinoName%     WinId:%WinId%
   
   return WinId
}



LobbyOpenCashier(WinId="")
{

   ; local CasinoName, LobbyId




   ; check if the Cashier if already open, then close it
   IfWinExist, ahk_group Cashier
   {
      WinClose, ahk_group Cashier
   }
   ; else open it
   else
   {
   
      ; if a WinId waas not specified, use the Table under the mouse
      if ! WinId
      {
         WinId := TableActivateUnderMouse()
         if ! WinId
            return
      }
   
      if NOT (CasinoName := CasinoName(WinId,A_ThisFunc))
         return


      ; get the lobby id of this casino
      LobbyId := LobbyId(CasinoName)

      ; click the cashier button
      ButtonClick("ButtonMainLobbyCashier",LobbyId)

   }

}


; in all poker lobbies, toggle the auto-muck hands menu item
LobbyToggleAutoMuckHands()
{

WinMenuSelectItem, ahk_group FTLobby, , Options, Auto Muck Hands
sleep, 30
WinMenuSelectItem, ahk_group PSLobby, , Options, Muck Losing Hand
sleep, 30
WinMenuSelectItem, ahk_group PSLobby, , Options, Don't Show Winning Hand


}


; close all tournament lobbies IF the register or unregister button is NOT visible
;  YOU NEED TO KEEP CALLING THIS FUNCTION TO MAKE SURE ALL LOBBIES GET CLOSED (typically done in one of the main timer functions)
;  CalledByHotKey is true if we are being called by a user hotkey command (so we will try to close all lobbies regardless of other gui settings)
;  CalledByHotKey is false if (so we will close lobbies only if the gui setting AutoCloseTournamentLobbyEnabled is TRUE)

LobbyTournamentClose(CalledByHotKey=0)
{
   global                                    
   
   static LobbyTournamentCloseTime = 0          ;    this is the time that it was first ok to close this LobbyId, but we are going to delay CloseLobbyTimeDelay
                                                   ; cuz if we close it down too soon after a sng table opens, it may close the table too
                                                   ; so we will close the lobby after this delay after we are first able to close it
                                                   
   static LobbyId = 0                           ; close this lobby after the proper delay, we keep track of it in this static var so we know which one to close next time in this fcn
   
   static HotKeyPressedToCloseAllLobbies = 0    ; this flag variable keeps track of whether a hotkey was pressed by the user to close all tournament lobbies, it is reset when we are
                                                ;     done closing all lobbies

   local WinIdList, Flag1, Flag2, Flag3, Flag4
   local CloseLobbyTimeDelay := 500           ; wait 2 secs after it appears like it is ok to close this lobby

;outputdebug,  LobbyTournamentCloseTime=%CloseLobbyTime%


   ; if we are suspended, then just return
   if (NOT AllHotKeysEnabled)
      return
      
   ; if we were called here by a user press of a hotkey to close all lobbies, then set this flag   
   if CalledByHotKey   
      HotKeyPressedToCloseAllLobbies := 1
      


   ; check if we are waiting to close a lobby from a previous pass thru this function
   if LobbyTournamentCloseTime
   {
   
;outputdebug,  LobbyTournamentCloseTime=%LobbyTournamentCloseTime%
      ; check if it has been longer than the delay time since it was ok to close this lobby
      if (A_TickCount - LobbyTournamentCloseTime > CloseLobbyTimeDelay)
      {

         ; if it is a FT lobby, we need to activate it so that we can see it
         WinActivate, ahk_id%WinId% ahk_group FTTournamentLobby
         
          ; check if the register now button is NOT visible... then close the lobby
         if ( (ButtonVisible("ButtonTournamentLobbyRegister",LobbyId) == 0) AND (ButtonVisible("ButtonTournamentLobbyUnRegister",LobbyId) == 0))
         {
            ; else just close the lobby as the register/unregister button is not visible now
            PostMessage, 0x112, 0xF060,,,ahk_id%LobbyId%  ahk_group TournamentLobby
            LobbyTournamentCloseTime := 0
            return         

         }
         
/*         
          ; check if the ObserveTable button is visible... then close the lobby
         if ( (ButtonVisible("ButtonTournamentLobbyObserveTable",LobbyId) == 1) )
         {
            ; else just close the lobby as the register/unregister button is not visible now
            PostMessage, 0x112, 0xF060,,,ahk_id%LobbyId%  ahk_group TournamentLobby
            LobbyTournamentCloseTime := 0
            return         

         }         
*/         

         ; it appears the Register or UnRegister button is there, or we don't know if it is there (overlayed), so we will not attempt to close this lobby
         LobbyTournamentCloseTime := 0
         return


      }
      ; if we are still waiting to close this lobby, then return so we don't try to close any other lobbies
      else
         return
   }
   
   ; else check if we are enabled to close another lobby in this calling of this function
   else if ( AutoCloseTournamentLobbyEnabled   OR  HotKeyPressedToCloseAllLobbies )
   {

      ;  we don't have any pending lobbies to close, so get the list of current open lobbies
      WinGet, WinIdList, List, ahk_group TournamentLobby
   
      ; if there are any lobbies open
   
      if WinIdList
      {
   
   
   
          ; loop through all of the open lobbies
          Loop, %WinIdList%
          {
             ; find the next ID of the next open lobby
             WinId := WinIdList%A_Index%
             
            ; if it is a FT lobby, we need to activate it so that we can see it             
            ; WinActivate, ahk_id%WinId% ahk_group FTTournamentLobby


             ; check if the register now button is NOT visible... then close the lobby
            if ( (ButtonVisible("ButtonTournamentLobbyRegister",WinId) == 0) AND (ButtonVisible("ButtonTournamentLobbyUnRegister",WinId) == 0))
            {
               ; set the time that it was ok to close the lobby
               LobbyTournamentCloseTime := A_TickCount
               LobbyId := WinId
   
               ; return, because we found a lobby to close, and we only want to be closing one lobby at a time
               return       
   
            }    	       

/*            
            ; check if the ObserveTable button is visible... then close the lobby
            if ( (ButtonVisible("ButtonTournamentLobbyObserveTable",WinId) == 1) )            
            {
               ; set the time that it was ok to close the lobby
               LobbyTournamentCloseTime := A_TickCount
               LobbyId := WinId
   
               ; return, because we found a lobby to close, and we only want to be closing one lobby at a time
               return       
   
            }              
*/            
            
    	       
          }
          ; if we are here, then we did not find any lobbies to close, so we can clean up some flags
          HotKeyPressedToCloseAllLobbies := 0
      }
   }
   
}


; Minimize tournament lobby for WinId...
;  if WinId == 0, then minimize all tournament lobbies
LobbyTournamentMinimize(WinId)
{
   local WinIdList, Flag1, Flag2


   if WinId
      PostMessage, 0x112, 0xF020,,,ahk_group TournamentLobby ahk_id%WinId%
   else
   ; if WinId == 0, then we'll close all the open tournament lobbies
   ;     EXCEPT if the Register or Unregister button is visible
   {
      WinGet, WinIdList, List, ahk_group TournamentLobby
      ; loop through all of the open lobbies
      Loop, %WinIdList%
      {
         ; find the next ID of the next open lobby


         WinId := WinIdList%A_Index%
         ; check if the register now button is visible... if so then don't close this lobby
         ;Flag1 := ButtonVisible("ButtonTournamentLobbyRegister",WinId)
         ;Flag2 := ButtonVisible("ButtonTournamentLobbyUnRegister",WinId)
         ;if ! (Flag1 OR Flag2)
           ; min this lobby
	        PostMessage, 0x112, 0xF020,,,ahk_id%WinId%
      }
   }
}
