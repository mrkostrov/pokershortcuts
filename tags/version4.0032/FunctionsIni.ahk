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
; Ini Functions
; -------------------------------------------------------------------------------
; *******************************************************************************





; read all the variables from all the active themes
IniReadAllThemes()
{
   global
   local Files

   ; read in all of the theme variables from the theme.ini files (both lobby and )
   IniReadLobbyTheme(PSLobbyTheme,"PS")
   IniReadLobbyTheme(FTLobbyTheme,"FT")

   IniReadTableTheme(PSTableTheme,"PS")
   IniReadTableThemeCalibration(PSTableTheme,"PS")
   
   IniReadTableTheme(FTTableTheme,"FT")
   IniReadTableThemeCalibration(FTTableTheme,"FT")
   
   
   ; we will read all the .bmp files in the PS theme folder
   ; we need to create the string of PS Sng types for the SngXGame dropdown box
   ; we will read all the .bmp files in the PS theme folder
   PSSngFileList := ""
   Files := A_WorkingDir . "\Themes\" . PSLobbyTheme . "\SngImages\*.bmp"
   Loop, %Files%,0,0
   {
      PSSngFileList .= "|" . A_LoopFileName
      ; remove the ".bmp" from file name
      StringTrimRight, PSSngFileList, PSSngFileList, 4
   }
   ; remove the initial "|" because the first time the gui is set up you don't want the leading "|"
   StringTrimLeft,PSSngFileList,PSSngFileList,1


}



/*
IniReadLobbyTheme()
   Purpose: Read the variables in the specified  Lobby theme
   Returns:
      the variables in their respective global variable names
   Parameters:
      Theme: the lobbytheme.ini file to read
      CasinoName: casino initials...returns it if not sent
*/
IniReadLobbyTheme(Theme, CasinoName)
{
   global
   local FileName

   FileName := "Themes\" . Theme . ".ini"

   IniRead, %CasinoName%ButtonMainLobbyCashierControlName, %FileName%, Main, ButtonMainLobbyCashierControlName
   IniRead, %CasinoName%ButtonMainLobbyCashierX, %FileName%, Main, ButtonMainLobbyCashierX
   IniRead, %CasinoName%ButtonMainLobbyCashierY, %FileName%, Main, ButtonMainLobbyCashierY

   IniRead, %CasinoName%ButtonMainLobbyRegisterControlName, %FileName%, Main,ButtonMainLobbyRegisterControlName
   IniRead, %CasinoName%ButtonMainLobbyRegisterX, %FileName%, Main,ButtonMainLobbyRegisterX   
   IniRead, %CasinoName%ButtonMainLobbyRegisterY, %FileName%, Main,ButtonMainLobbyRegisterY
      
   IniRead, %CasinoName%ButtonMainLobbyTournamentLobbyControlName, %FileName%, Main,ButtonMainLobbyTournamentLobbyControlName
   IniRead, %CasinoName%ButtonMainLobbyTournamentLobbyX, %FileName%, Main,ButtonMainLobbyTournamentLobbyX
   IniRead, %CasinoName%ButtonMainLobbyTournamentLobbyY, %FileName%, Main,ButtonMainLobbyTournamentLobbyY
   
   IniRead, %CasinoName%ListMainLobbySngTablesControlName, %FileName%, Main,ListMainLobbySngTablesControlName
   IniRead, %CasinoName%ListMainLobbySngTablesX, %FileName%, Main,ListMainLobbySngTablesX
   IniRead, %CasinoName%ListMainLobbySngTablesY, %FileName%, Main,ListMainLobbySngTablesY
   IniRead, %CasinoName%ListMainLobbySngTablesW, %FileName%, Main,ListMainLobbySngTablesW
   IniRead, %CasinoName%ListMainLobbySngTablesH, %FileName%, Main,ListMainLobbySngTablesH
   IniRead, %CasinoName%ListMainLobbySngTablesColorTolerance, %FileName%, Main,ListMainLobbySngTablesColorTolerance

   IniRead, %CasinoName%ButtonTournamentLobbyRegisterControlName, %FileName%, Main,ButtonTournamentLobbyRegisterControlName
   IniRead, %CasinoName%ButtonTournamentLobbyRegisterX, %FileName%, Main,ButtonTournamentLobbyRegisterX
   IniRead, %CasinoName%ButtonTournamentLobbyRegisterY, %FileName%, Main,ButtonTournamentLobbyRegisterY
   IniRead, %CasinoName%ButtonTournamentLobbyRegisterColor, %FileName%, Main,ButtonTournamentLobbyRegisterColor
   IniRead, %CasinoName%ButtonTournamentLobbyRegisterColorTolerance, %FileName%, Main,ButtonTournamentLobbyRegisterColorTolerance

   IniRead, %CasinoName%ButtonTournamentLobbyUnRegisterControlName, %FileName%, Main,ButtonTournamentLobbyUnRegisterControlName
   IniRead, %CasinoName%ButtonTournamentLobbyUnRegisterX, %FileName%, Main,ButtonTournamentLobbyUnRegisterX
   IniRead, %CasinoName%ButtonTournamentLobbyUnRegisterY, %FileName%, Main,ButtonTournamentLobbyUnRegisterY
   IniRead, %CasinoName%ButtonTournamentLobbyUnRegisterColor, %FileName%, Main,ButtonTournamentLobbyUnRegisterColor
   IniRead, %CasinoName%ButtonTournamentLobbyUnRegisterColorTolerance, %FileName%, Main,ButtonTournamentLobbyUnRegisterColorTolerance
      

}

/*
IniReadTableThemeCalibration()
   Purpose: Read new variables to the specified  Table theme
   Returns:
      nothing
   Parameters:
      Theme: the theme.ini file to read
      CasinoName: casino initials...returns it if not sent

*/
IniReadTableThemeCalibration(Theme, CasinoName)
{
   global
   local FileName

   FileName := "Themes\" . Theme . "\Calibration.ini"
   
   IniRead, %CasinoName%FlopColor, %FileName%, Main,FlopColor
   IniRead, %CasinoName%TurnColor, %FileName%, Main,TurnColor
   IniRead, %CasinoName%RiverColor, %FileName%, Main,RiverColor
   IniRead, %CasinoName%TestColor, %FileName%, Main,TestColor
   
   ; Table Empty seat colors
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat10, %FileName%, Main,PlayerEmptySeatColorSeats10Seat10
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat9, %FileName%, Main,PlayerEmptySeatColorSeats10Seat9
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat8, %FileName%, Main,PlayerEmptySeatColorSeats10Seat8
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat7, %FileName%, Main,PlayerEmptySeatColorSeats10Seat7
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat6, %FileName%, Main,PlayerEmptySeatColorSeats10Seat6
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat5, %FileName%, Main,PlayerEmptySeatColorSeats10Seat5
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat4, %FileName%, Main,PlayerEmptySeatColorSeats10Seat4
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat3, %FileName%, Main,PlayerEmptySeatColorSeats10Seat3
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat2, %FileName%, Main,PlayerEmptySeatColorSeats10Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats10Seat1, %FileName%, Main,PlayerEmptySeatColorSeats10Seat1

   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat9, %FileName%, Main,PlayerEmptySeatColorSeats9Seat9
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat8, %FileName%, Main,PlayerEmptySeatColorSeats9Seat8
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat7, %FileName%, Main,PlayerEmptySeatColorSeats9Seat7
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat6, %FileName%, Main,PlayerEmptySeatColorSeats9Seat6
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat5, %FileName%, Main,PlayerEmptySeatColorSeats9Seat5
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat4, %FileName%, Main,PlayerEmptySeatColorSeats9Seat4
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat3, %FileName%, Main,PlayerEmptySeatColorSeats9Seat3
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat2, %FileName%, Main,PlayerEmptySeatColorSeats9Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats9Seat1, %FileName%, Main,PlayerEmptySeatColorSeats9Seat1

   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat8, %FileName%, Main,PlayerEmptySeatColorSeats8Seat8
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat7, %FileName%, Main,PlayerEmptySeatColorSeats8Seat7
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat6, %FileName%, Main,PlayerEmptySeatColorSeats8Seat6
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat5, %FileName%, Main,PlayerEmptySeatColorSeats8Seat5
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat4, %FileName%, Main,PlayerEmptySeatColorSeats8Seat4
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat3, %FileName%, Main,PlayerEmptySeatColorSeats8Seat3
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat2, %FileName%, Main,PlayerEmptySeatColorSeats8Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats8Seat1, %FileName%, Main,PlayerEmptySeatColorSeats8Seat1

   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat6, %FileName%, Main,PlayerEmptySeatColorSeats6Seat6
   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat5, %FileName%, Main,PlayerEmptySeatColorSeats6Seat5
   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat4, %FileName%, Main,PlayerEmptySeatColorSeats6Seat4
   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat3, %FileName%, Main,PlayerEmptySeatColorSeats6Seat3
   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat2, %FileName%, Main,PlayerEmptySeatColorSeats6Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats6Seat1, %FileName%, Main,PlayerEmptySeatColorSeats6Seat1

   IniRead, %CasinoName%PlayerEmptySeatColorSeats4Seat4, %FileName%, Main,PlayerEmptySeatColorSeats4Seat4
   IniRead, %CasinoName%PlayerEmptySeatColorSeats4Seat3, %FileName%, Main,PlayerEmptySeatColorSeats4Seat3
   IniRead, %CasinoName%PlayerEmptySeatColorSeats4Seat2, %FileName%, Main,PlayerEmptySeatColorSeats4Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats4Seat1, %FileName%, Main,PlayerEmptySeatColorSeats4Seat1

   IniRead, %CasinoName%PlayerEmptySeatColorSeats2Seat2, %FileName%, Main,PlayerEmptySeatColorSeats2Seat2
   IniRead, %CasinoName%PlayerEmptySeatColorSeats2Seat1, %FileName%, Main,PlayerEmptySeatColorSeats2Seat1

   
}



/*
IniWriteTableThemeCalibration()
   Purpose: Write new variables to the specified  Table theme
   Returns:
      nothing
   Parameters:
      Theme: the theme.ini file to read
      CasinoName: casino initials...returns it if not sent
      
   NOTE: only the items on the calib tab are ever changed by the program, so only these items are written
*/
IniWriteTableThemeCalibration(Theme, CasinoName)
{
   global
   local FileName

   FileName := "Themes\" . Theme . "\Calibration.ini"


   IniWrite,% %CasinoName%FlopColor, %FileName%, Main,FlopColor
   IniWrite,% %CasinoName%TurnColor, %FileName%, Main,TurnColor
   IniWrite,% %CasinoName%RiverColor, %FileName%, Main,RiverColor
   IniWrite,% %CasinoName%TestColor, %FileName%, Main,TestColor

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat10, %FileName%, Main,PlayerEmptySeatColorSeats10Seat10
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat9, %FileName%, Main,PlayerEmptySeatColorSeats10Seat9
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat8, %FileName%, Main,PlayerEmptySeatColorSeats10Seat8
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat7, %FileName%, Main,PlayerEmptySeatColorSeats10Seat7
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat6, %FileName%, Main,PlayerEmptySeatColorSeats10Seat6
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat5, %FileName%, Main,PlayerEmptySeatColorSeats10Seat5
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat4, %FileName%, Main,PlayerEmptySeatColorSeats10Seat4
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat3, %FileName%, Main,PlayerEmptySeatColorSeats10Seat3
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat2, %FileName%, Main,PlayerEmptySeatColorSeats10Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats10Seat1, %FileName%, Main,PlayerEmptySeatColorSeats10Seat1

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat9, %FileName%, Main,PlayerEmptySeatColorSeats9Seat9
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat8, %FileName%, Main,PlayerEmptySeatColorSeats9Seat8
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat7, %FileName%, Main,PlayerEmptySeatColorSeats9Seat7
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat6, %FileName%, Main,PlayerEmptySeatColorSeats9Seat6
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat5, %FileName%, Main,PlayerEmptySeatColorSeats9Seat5
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat4, %FileName%, Main,PlayerEmptySeatColorSeats9Seat4
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat3, %FileName%, Main,PlayerEmptySeatColorSeats9Seat3
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat2, %FileName%, Main,PlayerEmptySeatColorSeats9Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats9Seat1, %FileName%, Main,PlayerEmptySeatColorSeats9Seat1

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat8, %FileName%, Main,PlayerEmptySeatColorSeats8Seat8
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat7, %FileName%, Main,PlayerEmptySeatColorSeats8Seat7
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat6, %FileName%, Main,PlayerEmptySeatColorSeats8Seat6
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat5, %FileName%, Main,PlayerEmptySeatColorSeats8Seat5
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat4, %FileName%, Main,PlayerEmptySeatColorSeats8Seat4
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat3, %FileName%, Main,PlayerEmptySeatColorSeats8Seat3
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat2, %FileName%, Main,PlayerEmptySeatColorSeats8Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats8Seat1, %FileName%, Main,PlayerEmptySeatColorSeats8Seat1

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat6, %FileName%, Main,PlayerEmptySeatColorSeats6Seat6
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat5, %FileName%, Main,PlayerEmptySeatColorSeats6Seat5
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat4, %FileName%, Main,PlayerEmptySeatColorSeats6Seat4
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat3, %FileName%, Main,PlayerEmptySeatColorSeats6Seat3
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat2, %FileName%, Main,PlayerEmptySeatColorSeats6Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats6Seat1, %FileName%, Main,PlayerEmptySeatColorSeats6Seat1

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats4Seat4, %FileName%, Main,PlayerEmptySeatColorSeats4Seat4
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats4Seat3, %FileName%, Main,PlayerEmptySeatColorSeats4Seat3
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats4Seat2, %FileName%, Main,PlayerEmptySeatColorSeats4Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats4Seat1, %FileName%, Main,PlayerEmptySeatColorSeats4Seat1

   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats2Seat2, %FileName%, Main,PlayerEmptySeatColorSeats2Seat2
   IniWrite,% %CasinoName%PlayerEmptySeatColorSeats2Seat1, %FileName%, Main,PlayerEmptySeatColorSeats2Seat1



}

/*
IniReadTableTheme()
   Purpose: Read the variables in the specified  Table theme
   Returns:
      the variables in their respective global variable names
   Parameters:
      Theme: the theme.ini file to read
      CasinoName: casino initials...returns it if not sent
*/
IniReadTableTheme(Theme, CasinoName)
{
   global
   local FileName
   
   FileName := "Themes\" . Theme . ".ini"

   IniRead, %CasinoName%StandardClientWidth, %FileName%, Main, StandardClientWidth
   IniRead, %CasinoName%StandardClientHeight, %FileName%, Main, StandardClientHeight
   IniRead, %CasinoName%MaximumAllowedNumPixelsInRowToBeBlank, %FileName%, Main, MaximumAllowedNumPixelsInRowToBeBlank
   IniRead, %CasinoName%ButtonFontSizeTableWidths, %FileName%, Main, ButtonFontSizeTableWidths
   IniRead, %CasinoName%TableSeatsList, %FileName%, Main,TableSeatsList
   IniRead, %CasinoName%HeroSeatNumList, %FileName%, Main,HeroSeatNumList
   IniRead, %CasinoName%FlopX, %FileName%, Main,FlopX
   IniRead, %CasinoName%FlopY, %FileName%, Main,FlopY

   IniRead, %CasinoName%TurnX, %FileName%, Main,TurnX
   IniRead, %CasinoName%TurnY, %FileName%, Main,TurnY

   IniRead, %CasinoName%RiverX, %FileName%, Main,RiverX
   IniRead, %CasinoName%RiverY, %FileName%, Main,RiverY

   IniRead, %CasinoName%TestX, %FileName%, Main,TestX
   IniRead, %CasinoName%TestY, %FileName%, Main,TestY

   IniRead, %CasinoName%StreetColorTolerance, %FileName%, Main,StreetColorTolerance
   IniRead, %CasinoName%StreetDelta, %FileName%, Main,StreetDelta
   
   ; Player's box positions
   IniRead, %CasinoName%PlayerBoxSeats10Seat1X, %FileName%, Main,PlayerBoxSeats10Seat1X
   IniRead, %CasinoName%PlayerBoxSeats10Seat1Y, %FileName%, Main,PlayerBoxSeats10Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat2X, %FileName%, Main,PlayerBoxSeats10Seat2X
   IniRead, %CasinoName%PlayerBoxSeats10Seat2Y, %FileName%, Main,PlayerBoxSeats10Seat2Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat3X, %FileName%, Main,PlayerBoxSeats10Seat3X
   IniRead, %CasinoName%PlayerBoxSeats10Seat3Y, %FileName%, Main,PlayerBoxSeats10Seat3Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat4X, %FileName%, Main,PlayerBoxSeats10Seat4X
   IniRead, %CasinoName%PlayerBoxSeats10Seat4Y, %FileName%, Main,PlayerBoxSeats10Seat4Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat5X, %FileName%, Main,PlayerBoxSeats10Seat5X
   IniRead, %CasinoName%PlayerBoxSeats10Seat5Y, %FileName%, Main,PlayerBoxSeats10Seat5Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat6X, %FileName%, Main,PlayerBoxSeats10Seat6X
   IniRead, %CasinoName%PlayerBoxSeats10Seat6Y, %FileName%, Main,PlayerBoxSeats10Seat6Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat7X, %FileName%, Main,PlayerBoxSeats10Seat7X
   IniRead, %CasinoName%PlayerBoxSeats10Seat7Y, %FileName%, Main,PlayerBoxSeats10Seat7Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat8X, %FileName%, Main,PlayerBoxSeats10Seat8X
   IniRead, %CasinoName%PlayerBoxSeats10Seat8Y, %FileName%, Main,PlayerBoxSeats10Seat8Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat9X, %FileName%, Main,PlayerBoxSeats10Seat9X
   IniRead, %CasinoName%PlayerBoxSeats10Seat9Y, %FileName%, Main,PlayerBoxSeats10Seat9Y
   IniRead, %CasinoName%PlayerBoxSeats10Seat10X, %FileName%, Main,PlayerBoxSeats10Seat10X
   IniRead, %CasinoName%PlayerBoxSeats10Seat10Y, %FileName%, Main,PlayerBoxSeats10Seat10Y

   IniRead, %CasinoName%PlayerBoxSeats9Seat1X, %FileName%, Main,PlayerBoxSeats9Seat1X
   IniRead, %CasinoName%PlayerBoxSeats9Seat1Y, %FileName%, Main,PlayerBoxSeats9Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat2X, %FileName%, Main,PlayerBoxSeats9Seat2X
   IniRead, %CasinoName%PlayerBoxSeats9Seat2Y, %FileName%, Main,PlayerBoxSeats9Seat2Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat3X, %FileName%, Main,PlayerBoxSeats9Seat3X
   IniRead, %CasinoName%PlayerBoxSeats9Seat3Y, %FileName%, Main,PlayerBoxSeats9Seat3Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat4X, %FileName%, Main,PlayerBoxSeats9Seat4X
   IniRead, %CasinoName%PlayerBoxSeats9Seat4Y, %FileName%, Main,PlayerBoxSeats9Seat4Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat5X, %FileName%, Main,PlayerBoxSeats9Seat5X
   IniRead, %CasinoName%PlayerBoxSeats9Seat5Y, %FileName%, Main,PlayerBoxSeats9Seat5Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat6X, %FileName%, Main,PlayerBoxSeats9Seat6X
   IniRead, %CasinoName%PlayerBoxSeats9Seat6Y, %FileName%, Main,PlayerBoxSeats9Seat6Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat7X, %FileName%, Main,PlayerBoxSeats9Seat7X
   IniRead, %CasinoName%PlayerBoxSeats9Seat7Y, %FileName%, Main,PlayerBoxSeats9Seat7Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat8X, %FileName%, Main,PlayerBoxSeats9Seat8X
   IniRead, %CasinoName%PlayerBoxSeats9Seat8Y, %FileName%, Main,PlayerBoxSeats9Seat8Y
   IniRead, %CasinoName%PlayerBoxSeats9Seat9X, %FileName%, Main,PlayerBoxSeats9Seat9X
   IniRead, %CasinoName%PlayerBoxSeats9Seat9Y, %FileName%, Main,PlayerBoxSeats9Seat9Y

   IniRead, %CasinoName%PlayerBoxSeats8Seat1X, %FileName%, Main,PlayerBoxSeats8Seat1X
   IniRead, %CasinoName%PlayerBoxSeats8Seat1Y, %FileName%, Main,PlayerBoxSeats8Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat2X, %FileName%, Main,PlayerBoxSeats8Seat2X
   IniRead, %CasinoName%PlayerBoxSeats8Seat2Y, %FileName%, Main,PlayerBoxSeats8Seat2Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat3X, %FileName%, Main,PlayerBoxSeats8Seat3X
   IniRead, %CasinoName%PlayerBoxSeats8Seat3Y, %FileName%, Main,PlayerBoxSeats8Seat3Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat4X, %FileName%, Main,PlayerBoxSeats8Seat4X
   IniRead, %CasinoName%PlayerBoxSeats8Seat4Y, %FileName%, Main,PlayerBoxSeats8Seat4Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat5X, %FileName%, Main,PlayerBoxSeats8Seat5X
   IniRead, %CasinoName%PlayerBoxSeats8Seat5Y, %FileName%, Main,PlayerBoxSeats8Seat5Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat6X, %FileName%, Main,PlayerBoxSeats8Seat6X
   IniRead, %CasinoName%PlayerBoxSeats8Seat6Y, %FileName%, Main,PlayerBoxSeats8Seat6Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat7X, %FileName%, Main,PlayerBoxSeats8Seat7X
   IniRead, %CasinoName%PlayerBoxSeats8Seat7Y, %FileName%, Main,PlayerBoxSeats8Seat7Y
   IniRead, %CasinoName%PlayerBoxSeats8Seat8X, %FileName%, Main,PlayerBoxSeats8Seat8X
   IniRead, %CasinoName%PlayerBoxSeats8Seat8Y, %FileName%, Main,PlayerBoxSeats8Seat8Y

   IniRead, %CasinoName%PlayerBoxSeats6Seat1X, %FileName%, Main,PlayerBoxSeats6Seat1X
   IniRead, %CasinoName%PlayerBoxSeats6Seat1Y, %FileName%, Main,PlayerBoxSeats6Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats6Seat2X, %FileName%, Main,PlayerBoxSeats6Seat2X
   IniRead, %CasinoName%PlayerBoxSeats6Seat2Y, %FileName%, Main,PlayerBoxSeats6Seat2Y
   IniRead, %CasinoName%PlayerBoxSeats6Seat3X, %FileName%, Main,PlayerBoxSeats6Seat3X
   IniRead, %CasinoName%PlayerBoxSeats6Seat3Y, %FileName%, Main,PlayerBoxSeats6Seat3Y
   IniRead, %CasinoName%PlayerBoxSeats6Seat4X, %FileName%, Main,PlayerBoxSeats6Seat4X
   IniRead, %CasinoName%PlayerBoxSeats6Seat4Y, %FileName%, Main,PlayerBoxSeats6Seat4Y
   IniRead, %CasinoName%PlayerBoxSeats6Seat5X, %FileName%, Main,PlayerBoxSeats6Seat5X
   IniRead, %CasinoName%PlayerBoxSeats6Seat5Y, %FileName%, Main,PlayerBoxSeats6Seat5Y
   IniRead, %CasinoName%PlayerBoxSeats6Seat6X, %FileName%, Main,PlayerBoxSeats6Seat6X
   IniRead, %CasinoName%PlayerBoxSeats6Seat6Y, %FileName%, Main,PlayerBoxSeats6Seat6Y

   IniRead, %CasinoName%PlayerBoxSeats4Seat1X, %FileName%, Main,PlayerBoxSeats4Seat1X
   IniRead, %CasinoName%PlayerBoxSeats4Seat1Y, %FileName%, Main,PlayerBoxSeats4Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats4Seat2X, %FileName%, Main,PlayerBoxSeats4Seat2X
   IniRead, %CasinoName%PlayerBoxSeats4Seat2Y, %FileName%, Main,PlayerBoxSeats4Seat2Y
   IniRead, %CasinoName%PlayerBoxSeats4Seat3X, %FileName%, Main,PlayerBoxSeats4Seat3X
   IniRead, %CasinoName%PlayerBoxSeats4Seat3Y, %FileName%, Main,PlayerBoxSeats4Seat3Y
   IniRead, %CasinoName%PlayerBoxSeats4Seat4X, %FileName%, Main,PlayerBoxSeats4Seat4X
   IniRead, %CasinoName%PlayerBoxSeats4Seat4Y, %FileName%, Main,PlayerBoxSeats4Seat4Y

   IniRead, %CasinoName%PlayerBoxSeats2Seat1X, %FileName%, Main,PlayerBoxSeats2Seat1X
   IniRead, %CasinoName%PlayerBoxSeats2Seat1Y, %FileName%, Main,PlayerBoxSeats2Seat1Y
   IniRead, %CasinoName%PlayerBoxSeats2Seat2X, %FileName%, Main,PlayerBoxSeats2Seat2X
   IniRead, %CasinoName%PlayerBoxSeats2Seat2Y, %FileName%, Main,PlayerBoxSeats2Seat2Y

   IniRead, %CasinoName%EmptySeatOffsetX, %FileName%, Main,EmptySeatOffsetX
   IniRead, %CasinoName%EmptySeatOffsetY, %FileName%, Main,EmptySeatOffsetY



   ; Table Empty seat colors
   IniRead, %CasinoName%PlayerEmptySeatColorTolerance, %FileName%, Main,PlayerEmptySeatColorTolerance

   
   ; Player Seated Positions
   IniRead, %CasinoName%StackCenterOffsetX, %FileName%, Main,StackCenterOffsetX
   IniRead, %CasinoName%StackCenterOffsetY, %FileName%, Main,StackCenterOffsetY
   
   ; Stack digits position
   IniRead, %CasinoName%StackReadOffsetX, %FileName%, Main,StackReadOffsetX
   IniRead, %CasinoName%StackReadOffsetY, %FileName%, Main,StackReadOffsetY
   IniRead, %CasinoName%StackReadW, %FileName%, Main,StackReadW
   IniRead, %CasinoName%StackReadH, %FileName%, Main,StackReadH


   ; Stack digits colors
   IniRead, %CasinoName%StackDigitsAlternateColorAvailable, %FileName%, Main,StackDigitsAlternateColorAvailable
   IniRead, %CasinoName%StackDigitsColor, %FileName%, Main,StackDigitsColor
   IniRead, %CasinoName%StackDigitsColorTolerance, %FileName%, Main,StackDigitsColorTolerance
   IniRead, %CasinoName%StackDigitsAlternateColor, %FileName%, Main,StackDigitsAlternateColor
   IniRead, %CasinoName%StackDigitsAlternateColorTolerance, %FileName%, Main,StackDigitsAlternateColorTolerance
   IniRead, %CasinoName%StackDigitsBackgroundColor, %FileName%, Main,StackDigitsBackgroundColor
   IniRead, %CasinoName%StackDigitsBackgroundColorTolerance, %FileName%, Main,StackDigitsBackgroundColorTolerance
   IniRead, %CasinoName%StackDigitsAlternateBackgroundColor, %FileName%, Main,StackDigitsAlternateBackgroundColor
   IniRead, %CasinoName%StackDigitsAlternateBackgroundColorTolerance, %FileName%, Main,StackDigitsAlternateBackgroundColorTolerance
   
   IniRead, %CasinoName%PlayerBoxMessageColor, %FileName%, Main,PlayerBoxMessageColor
   IniRead, %CasinoName%PlayerBoxMessageColorTolerance, %FileName%, Main,PlayerBoxMessageColorTolerance

   ; Pot digits positions
   IniRead, %CasinoName%PotDigitsPosX, %FileName%, Main,PotDigitsPosX
   IniRead, %CasinoName%PotDigitsPosY, %FileName%, Main,PotDigitsPosY
   IniRead, %CasinoName%PotDigitsPos10X, %FileName%, Main,PotDigitsPos10X
   IniRead, %CasinoName%PotDigitsPos10Y, %FileName%, Main,PotDigitsPos10Y
   IniRead, %CasinoName%PotDigitsPos9X, %FileName%, Main,PotDigitsPos9X
   IniRead, %CasinoName%PotDigitsPos9Y, %FileName%, Main,PotDigitsPos9Y
   IniRead, %CasinoName%PotDigitsPos8X, %FileName%, Main,PotDigitsPos8X
   IniRead, %CasinoName%PotDigitsPos8Y, %FileName%, Main,PotDigitsPos8Y
   IniRead, %CasinoName%PotDigitsPos6X, %FileName%, Main,PotDigitsPos6X
   IniRead, %CasinoName%PotDigitsPos6Y, %FileName%, Main,PotDigitsPos6Y
   IniRead, %CasinoName%PotDigitsPos4X, %FileName%, Main,PotDigitsPos4X
   IniRead, %CasinoName%PotDigitsPos4Y, %FileName%, Main,PotDigitsPos4Y
   IniRead, %CasinoName%PotDigitsPos2X, %FileName%, Main,PotDigitsPos2X
   IniRead, %CasinoName%PotDigitsPos2Y, %FileName%, Main,PotDigitsPos2Y
   IniRead, %CasinoName%PotDigitsPosW, %FileName%, Main,PotDigitsPosW
   IniRead, %CasinoName%PotDigitsPosH, %FileName%, Main,PotDigitsPosH
   
   ; Pot Digits Colors
   IniRead, %CasinoName%PotDigitsAlternateColorAvailable, %FileName%, Main,PotDigitsAlternateColorAvailable
   IniRead, %CasinoName%PotDigitsColor, %FileName%, Main,PotDigitsColor
   IniRead, %CasinoName%PotDigitsColorTolerance, %FileName%, Main,PotDigitsColorTolerance
   IniRead, %CasinoName%PotDigitsAlternateColor, %FileName%, Main,PotDigitsAlternateColor
   IniRead, %CasinoName%PotDigitsAlternateColorTolerance, %FileName%, Main,PotDigitsAlternateColorTolerance
   IniRead, %CasinoName%PotDigitsBackgroundColor, %FileName%, Main,PotDigitsBackgroundColor
   IniRead, %CasinoName%PotDigitsBackgroundColorTolerance, %FileName%, Main,PotDigitsBackgroundColorTolerance
   IniRead, %CasinoName%PotDigitsAlternateBackgroundColor, %FileName%, Main,PotDigitsAlternateBackgroundColor
   IniRead, %CasinoName%PotDigitsAlternateBackgroundColorTolerance, %FileName%, Main,PotDigitsAlternateBackgroundColorTolerance
   
   
   ; Call digits position and colors
   IniRead, %CasinoName%CallDigitsPos1X, %FileName%, Main,CallDigitsPos1X
   IniRead, %CasinoName%CallDigitsPos1Y, %FileName%, Main,CallDigitsPos1Y
   IniRead, %CasinoName%CallDigitsPos2X, %FileName%, Main,CallDigitsPos2X
   IniRead, %CasinoName%CallDigitsPos2Y, %FileName%, Main,CallDigitsPos2Y
   IniRead, %CasinoName%CallDigitsPosW, %FileName%, Main,CallDigitsPosW
   IniRead, %CasinoName%CallDigitsPosH, %FileName%, Main,CallDigitsPosH
   IniRead, %CasinoName%CallColTol, %FileName%, Main,CallColTol
   
   

   
   ; Table Main checkboxes
   IniRead, %CasinoName%CheckboxFoldToAnyBetControlName, %FileName%, Main,CheckboxFoldToAnyBetControlName
   IniRead, %CasinoName%CheckboxFoldToAnyBetX, %FileName%, Main,CheckboxFoldToAnyBetX
   IniRead, %CasinoName%CheckboxFoldToAnyBetY, %FileName%, Main,CheckboxFoldToAnyBetY
   IniRead, %CasinoName%CheckboxFoldToAnyBetCheckColor, %FileName%, Main,CheckboxFoldToAnyBetCheckColor
   IniRead, %CasinoName%CheckboxFoldToAnyBetBackColor, %FileName%, Main,CheckboxFoldToAnyBetBackColor

   IniRead, %CasinoName%CheckboxRebuyFoldToAnyBetControlName, %FileName%, Main,CheckboxRebuyFoldToAnyBetControlName
   IniRead, %CasinoName%CheckboxRebuyFoldToAnyBetX, %FileName%, Main,CheckboxRebuyFoldToAnyBetX
   IniRead, %CasinoName%CheckboxRebuyFoldToAnyBetY, %FileName%, Main,CheckboxRebuyFoldToAnyBetY
   IniRead, %CasinoName%CheckboxRebuyFoldToAnyBetCheckColor, %FileName%, Main,CheckboxRebuyFoldToAnyBetCheckColor
   IniRead, %CasinoName%CheckboxRebuyFoldToAnyBetBackColor, %FileName%, Main,CheckboxRebuyFoldToAnyBetBackColor

   IniRead, %CasinoName%CheckboxFinalFoldToAnyBetControlName, %FileName%, Main,CheckboxFinalFoldToAnyBetControlName
   IniRead, %CasinoName%CheckboxFinalFoldToAnyBetX, %FileName%, Main,CheckboxFinalFoldToAnyBetX
   IniRead, %CasinoName%CheckboxFinalFoldToAnyBetY, %FileName%, Main,CheckboxFinalFoldToAnyBetY
   IniRead, %CasinoName%CheckboxFinalFoldToAnyBetCheckColor, %FileName%, Main,CheckboxFinalFoldToAnyBetCheckColor
   IniRead, %CasinoName%CheckboxFinalFoldToAnyBetBackColor, %FileName%, Main,CheckboxFinalFoldToAnyBetBackColor





  
   IniRead, %CasinoName%CheckboxSitOutNextHandControlName, %FileName%, Main,CheckboxSitOutNextHandControlName
   IniRead, %CasinoName%CheckboxSitOutNextHandX, %FileName%, Main,CheckboxSitOutNextHandX
   IniRead, %CasinoName%CheckboxSitOutNextHandY, %FileName%, Main,CheckboxSitOutNextHandY
   IniRead, %CasinoName%CheckboxSitOutNextHandCheckColor, %FileName%, Main,CheckboxSitOutNextHandCheckColor
   IniRead, %CasinoName%CheckboxSitOutNextHandBackColor, %FileName%, Main,CheckboxSitOutNextHandBackColor

   IniRead, %CasinoName%CheckboxRebuySitOutNextHandControlName, %FileName%, Main,CheckboxRebuySitOutNextHandControlName
   IniRead, %CasinoName%CheckboxRebuySitOutNextHandX, %FileName%, Main,CheckboxRebuySitOutNextHandX
   IniRead, %CasinoName%CheckboxRebuySitOutNextHandY, %FileName%, Main,CheckboxRebuySitOutNextHandY
   IniRead, %CasinoName%CheckboxRebuySitOutNextHandCheckColor, %FileName%, Main,CheckboxRebuySitOutNextHandCheckColor
   IniRead, %CasinoName%CheckboxRebuySitOutNextHandBackColor, %FileName%, Main,CheckboxRebuySitOutNextHandBackColor

   IniRead, %CasinoName%CheckboxFinalSitOutNextHandControlName, %FileName%, Main,CheckboxFinalSitOutNextHandControlName
   IniRead, %CasinoName%CheckboxFinalSitOutNextHandX, %FileName%, Main,CheckboxFinalSitOutNextHandX
   IniRead, %CasinoName%CheckboxFinalSitOutNextHandY, %FileName%, Main,CheckboxFinalSitOutNextHandY
   IniRead, %CasinoName%CheckboxFinalSitOutNextHandCheckColor, %FileName%, Main,CheckboxFinalSitOutNextHandCheckColor
   IniRead, %CasinoName%CheckboxFinalSitOutNextHandBackColor, %FileName%, Main,CheckboxFinalSitOutNextHandBackColor





   IniRead, %CasinoName%CheckboxAutoPostBlindsControlName, %FileName%, Main,CheckboxAutoPostBlindsControlName
   IniRead, %CasinoName%CheckboxAutoPostBlindsX, %FileName%, Main,CheckboxAutoPostBlindsX
   IniRead, %CasinoName%CheckboxAutoPostBlindsY, %FileName%, Main,CheckboxAutoPostBlindsY
   IniRead, %CasinoName%CheckboxAutoPostBlindsCheckColor, %FileName%, Main,CheckboxAutoPostBlindsCheckColor
   IniRead, %CasinoName%CheckboxAutoPostBlindsBackColor, %FileName%, Main,CheckboxAutoPostBlindsBackColor





   IniRead, %CasinoName%CheckboxAutoRebuyControlName, %FileName%, Main,CheckboxAutoRebuyControlName
   IniRead, %CasinoName%CheckboxAutoRebuyX, %FileName%, Main,CheckboxAutoRebuyX
   IniRead, %CasinoName%CheckboxAutoRebuyY, %FileName%, Main,CheckboxAutoRebuyY
   IniRead, %CasinoName%CheckboxAutoRebuyCheckColor, %FileName%, Main,CheckboxAutoRebuyCheckColor
   IniRead, %CasinoName%CheckboxAutoRebuyBackColor, %FileName%, Main,CheckboxAutoRebuyBackColor

   IniRead, %CasinoName%CheckboxAutoRebuyMinControlName, %FileName%, Main,CheckboxAutoRebuyMinControlName
   IniRead, %CasinoName%CheckboxAutoRebuyMinX, %FileName%, Main,CheckboxAutoRebuyMinX
   IniRead, %CasinoName%CheckboxAutoRebuyMinY, %FileName%, Main,CheckboxAutoRebuyMinY
   IniRead, %CasinoName%CheckboxAutoRebuyMinCheckColor, %FileName%, Main,CheckboxAutoRebuyMinCheckColor
   IniRead, %CasinoName%CheckboxAutoRebuyMinBackColor, %FileName%, Main,CheckboxAutoRebuyMinBackColor

   IniRead, %CasinoName%CheckboxAutoRebuyMaxControlName, %FileName%, Main,CheckboxAutoRebuyMaxControlName
   IniRead, %CasinoName%CheckboxAutoRebuyMaxX, %FileName%, Main,CheckboxAutoRebuyMaxX
   IniRead, %CasinoName%CheckboxAutoRebuyMaxY, %FileName%, Main,CheckboxAutoRebuyMaxY
   IniRead, %CasinoName%CheckboxAutoRebuyMaxCheckColor, %FileName%, Main,CheckboxAutoRebuyMaxCheckColor
   IniRead, %CasinoName%CheckboxAutoRebuyMaxBackColor, %FileName%, Main,CheckboxAutoRebuyMaxBackColor





   IniRead, %CasinoName%CheckboxSitOutNextBlindControlName, %FileName%, Main,CheckboxSitOutNextBlindControlName
   IniRead, %CasinoName%CheckboxSitOutNextBlindX, %FileName%, Main,CheckboxSitOutNextBlindX
   IniRead, %CasinoName%CheckboxSitOutNextBlindY, %FileName%, Main,CheckboxSitOutNextBlindY
   IniRead, %CasinoName%CheckboxSitOutNextBlindCheckColor, %FileName%, Main,CheckboxSitOutNextBlindCheckColor
   IniRead, %CasinoName%CheckboxSitOutNextBlindBackColor, %FileName%, Main,CheckboxSitOutNextBlindBackColor



   IniRead, %CasinoName%CheckboxWaitForBigBlindControlName, %FileName%, Main,CheckboxWaitForBigBlindControlName
   IniRead, %CasinoName%CheckboxWaitForBigBlindX, %FileName%, Main,CheckboxWaitForBigBlindX
   IniRead, %CasinoName%CheckboxWaitForBigBlindY, %FileName%, Main,CheckboxWaitForBigBlindY
   IniRead, %CasinoName%CheckboxWaitForBigBlindCheckColor, %FileName%, Main,CheckboxWaitForBigBlindCheckColor
   IniRead, %CasinoName%CheckboxWaitForBigBlindBackColor, %FileName%, Main,CheckboxWaitForBigBlindBackColor



   ; Table Pre-Action Checkboxes
   IniRead, %CasinoName%CheckboxCheckFoldControlName, %FileName%, Main,CheckboxCheckFoldControlName
   IniRead, %CasinoName%CheckboxCheckFoldX, %FileName%, Main,CheckboxCheckFoldX
   IniRead, %CasinoName%CheckboxCheckFoldY, %FileName%, Main,CheckboxCheckFoldY
   IniRead, %CasinoName%CheckboxCheckFoldCheckColor, %FileName%, Main,CheckboxCheckFoldCheckColor
   IniRead, %CasinoName%CheckboxCheckFoldBackColor, %FileName%, Main,CheckboxCheckFoldBackColor

   IniRead, %CasinoName%CheckboxFoldControlName, %FileName%, Main,CheckboxFoldControlName
   IniRead, %CasinoName%CheckboxFoldX, %FileName%, Main,CheckboxFoldX
   IniRead, %CasinoName%CheckboxFoldY, %FileName%, Main,CheckboxFoldY
   IniRead, %CasinoName%CheckboxFoldCheckColor, %FileName%, Main,CheckboxFoldCheckColor
   IniRead, %CasinoName%CheckboxFoldBackColor, %FileName%, Main,CheckboxFoldBackColor

   IniRead, %CasinoName%CheckboxCallControlName, %FileName%, Main,CheckboxCallControlName
   IniRead, %CasinoName%CheckboxCallX, %FileName%, Main,CheckboxCallX
   IniRead, %CasinoName%CheckboxCallY, %FileName%, Main,CheckboxCallY
   IniRead, %CasinoName%CheckboxCallCheckColor, %FileName%, Main,CheckboxCallCheckColor
   IniRead, %CasinoName%CheckboxCallBackColor, %FileName%, Main,CheckboxCallBackColor

   IniRead, %CasinoName%CheckboxCallAnyControlName, %FileName%, Main,CheckboxCallAnyControlName
   IniRead, %CasinoName%CheckboxCallAnyX, %FileName%, Main,CheckboxCallAnyX
   IniRead, %CasinoName%CheckboxCallAnyY, %FileName%, Main,CheckboxCallAnyY
   IniRead, %CasinoName%CheckboxCallAnyCheckColor, %FileName%, Main,CheckboxCallAnyCheckColor
   IniRead, %CasinoName%CheckboxCallAnyBackColor, %FileName%, Main,CheckboxCallAnyBackColor

   IniRead, %CasinoName%CheckboxRaiseMinControlName, %FileName%, Main,CheckboxRaiseMinControlName
   IniRead, %CasinoName%CheckboxRaiseMinX, %FileName%, Main,CheckboxRaiseMinX
   IniRead, %CasinoName%CheckboxRaiseMinY, %FileName%, Main,CheckboxRaiseMinY
   IniRead, %CasinoName%CheckboxRaiseMinCheckColor, %FileName%, Main,CheckboxRaiseMinCheckColor
   IniRead, %CasinoName%CheckboxRaiseMinBackColor, %FileName%, Main,CheckboxRaiseMinBackColor

   IniRead, %CasinoName%CheckboxRaiseAnyControlName, %FileName%, Main,CheckboxRaiseAnyControlName
   IniRead, %CasinoName%CheckboxRaiseAnyX, %FileName%, Main,CheckboxRaiseAnyX
   IniRead, %CasinoName%CheckboxRaiseAnyY, %FileName%, Main,CheckboxRaiseAnyY
   IniRead, %CasinoName%CheckboxRaiseAnyCheckColor, %FileName%, Main,CheckboxRaiseAnyCheckColor
   IniRead, %CasinoName%CheckboxRaiseAnyBackColor, %FileName%, Main,CheckboxRaiseAnyBackColor

   ; Table Buttons
   IniRead, %CasinoName%ButtonActionPendingControlName, %FileName%, Main,ButtonActionPendingControlName
   IniRead, %CasinoName%ButtonActionPendingX, %FileName%, Main,ButtonActionPendingX
   IniRead, %CasinoName%ButtonActionPendingY, %FileName%, Main,ButtonActionPendingY
   IniRead, %CasinoName%ButtonActionPendingColor1, %FileName%, Main,ButtonActionPendingColor1
   IniRead, %CasinoName%ButtonActionPendingColor2, %FileName%, Main,ButtonActionPendingColor2
   IniRead, %CasinoName%ButtonActionPendingColor3, %FileName%, Main,ButtonActionPendingColor3
   IniRead, %CasinoName%ButtonActionPendingColor4, %FileName%, Main,ButtonActionPendingColor4
   IniRead, %CasinoName%ButtonActionPendingColorTolerance, %FileName%, Main,ButtonActionPendingColorTolerance
   
   IniRead, %CasinoName%ButtonActionPending2ControlName, %FileName%, Main,ButtonActionPending2ControlName
   IniRead, %CasinoName%ButtonActionPending2X, %FileName%, Main,ButtonActionPending2X
   IniRead, %CasinoName%ButtonActionPending2Y, %FileName%, Main,ButtonActionPending2Y
   IniRead, %CasinoName%ButtonActionPending2Color1, %FileName%, Main,ButtonActionPending2Color1
   IniRead, %CasinoName%ButtonActionPending2Color2, %FileName%, Main,ButtonActionPending2Color2
   IniRead, %CasinoName%ButtonActionPending2Color3, %FileName%, Main,ButtonActionPending2Color3
   IniRead, %CasinoName%ButtonActionPending2Color4, %FileName%, Main,ButtonActionPending2Color4
   IniRead, %CasinoName%ButtonActionPending2ColorTolerance, %FileName%, Main,ButtonActionPending2ColorTolerance   

   IniRead, %CasinoName%ButtonFoldControlName, %FileName%, Main,ButtonFoldControlName
   IniRead, %CasinoName%ButtonFoldX, %FileName%, Main,ButtonFoldX
   IniRead, %CasinoName%ButtonFoldY, %FileName%, Main,ButtonFoldY
   IniRead, %CasinoName%ButtonFoldW, %FileName%, Main,ButtonFoldW
   IniRead, %CasinoName%ButtonFoldH, %FileName%, Main,ButtonFoldH
   IniRead, %CasinoName%ButtonFoldColorTolerance, %FileName%, Main,ButtonFoldColorTolerance

   IniRead, %CasinoName%ButtonCheckControlName, %FileName%, Main,ButtonCheckControlName
   IniRead, %CasinoName%ButtonCheckX, %FileName%, Main,ButtonCheckX
   IniRead, %CasinoName%ButtonCheckY, %FileName%, Main,ButtonCheckY
   IniRead, %CasinoName%ButtonCheckW, %FileName%, Main,ButtonCheckW
   IniRead, %CasinoName%ButtonCheckH, %FileName%, Main,ButtonCheckH
   IniRead, %CasinoName%ButtonCheckColorTolerance, %FileName%, Main,ButtonCheckColorTolerance

   IniRead, %CasinoName%ButtonCallControlName, %FileName%, Main,ButtonCallControlName
   IniRead, %CasinoName%ButtonCallX, %FileName%, Main,ButtonCallX
   IniRead, %CasinoName%ButtonCallY, %FileName%, Main,ButtonCallY
   IniRead, %CasinoName%ButtonCallW, %FileName%, Main,ButtonCallW
   IniRead, %CasinoName%ButtonCallH, %FileName%, Main,ButtonCallH
   IniRead, %CasinoName%ButtonCallColorTolerance, %FileName%, Main,ButtonCallColorTolerance

   IniRead, %CasinoName%ButtonCall2ControlName, %FileName%, Main,ButtonCall2ControlName
   IniRead, %CasinoName%ButtonCall2X, %FileName%, Main,ButtonCall2X
   IniRead, %CasinoName%ButtonCall2Y, %FileName%, Main,ButtonCall2Y
   IniRead, %CasinoName%ButtonCall2W, %FileName%, Main,ButtonCall2W
   IniRead, %CasinoName%ButtonCall2H, %FileName%, Main,ButtonCall2H
   IniRead, %CasinoName%ButtonCall2ColorTolerance, %FileName%, Main,ButtonCall2ColorTolerance

   IniRead, %CasinoName%ButtonRaiseControlName, %FileName%, Main,ButtonRaiseControlName
   IniRead, %CasinoName%ButtonRaiseX, %FileName%, Main,ButtonRaiseX
   IniRead, %CasinoName%ButtonRaiseY, %FileName%, Main,ButtonRaiseY
   IniRead, %CasinoName%ButtonRaiseW, %FileName%, Main,ButtonRaiseW
   IniRead, %CasinoName%ButtonRaiseH, %FileName%, Main,ButtonRaiseH
   IniRead, %CasinoName%ButtonRaiseColorTolerance, %FileName%, Main,ButtonRaiseColorTolerance

   IniRead, %CasinoName%ButtonImBackControlName, %FileName%, Main,ButtonImBackControlName
   IniRead, %CasinoName%ButtonImBackX, %FileName%, Main,ButtonImBackX
   IniRead, %CasinoName%ButtonImBackY, %FileName%, Main,ButtonImBackY
   IniRead, %CasinoName%ButtonImBackW, %FileName%, Main,ButtonImBackW
   IniRead, %CasinoName%ButtonImBackH, %FileName%, Main,ButtonImBackH
   IniRead, %CasinoName%ButtonImBackColorTolerance, %FileName%, Main,ButtonImBackColorTolerance

   IniRead, %CasinoName%ButtonPostSmallBlindControlName, %FileName%, Main,ButtonPostSmallBlindControlName
   IniRead, %CasinoName%ButtonPostSmallBlindX, %FileName%, Main,ButtonPostSmallBlindX
   IniRead, %CasinoName%ButtonPostSmallBlindY, %FileName%, Main,ButtonPostSmallBlindY
   IniRead, %CasinoName%ButtonPostSmallBlindW, %FileName%, Main,ButtonPostSmallBlindW
   IniRead, %CasinoName%ButtonPostSmallBlindH, %FileName%, Main,ButtonPostSmallBlindH
   IniRead, %CasinoName%ButtonPostSmallBlindColorTolerance, %FileName%, Main,ButtonPostSmallBlindColorTolerance

   IniRead, %CasinoName%ButtonPostBigBlindControlName, %FileName%, Main,ButtonPostBigBlindControlName
   IniRead, %CasinoName%ButtonPostBigBlindX, %FileName%, Main,ButtonPostBigBlindX
   IniRead, %CasinoName%ButtonPostBigBlindY, %FileName%, Main,ButtonPostBigBlindY
   IniRead, %CasinoName%ButtonPostBigBlindW, %FileName%, Main,ButtonPostBigBlindW
   IniRead, %CasinoName%ButtonPostBigBlindH, %FileName%, Main,ButtonPostBigBlindH
   IniRead, %CasinoName%ButtonPostBigBlindColorTolerance, %FileName%, Main,ButtonPostBigBlindColorTolerance

   IniRead, %CasinoName%ButtonWaitForBigBlindControlName, %FileName%, Main,ButtonWaitForBigBlindControlName
   IniRead, %CasinoName%ButtonWaitForBigBlindX, %FileName%, Main,ButtonWaitForBigBlindX
   IniRead, %CasinoName%ButtonWaitForBigBlindY, %FileName%, Main,ButtonWaitForBigBlindY
   IniRead, %CasinoName%ButtonWaitForBigBlindW, %FileName%, Main,ButtonWaitForBigBlindW
   IniRead, %CasinoName%ButtonWaitForBigBlindH, %FileName%, Main,ButtonWaitForBigBlindH
   IniRead, %CasinoName%ButtonWaitForBigBlindColorTolerance, %FileName%, Main,ButtonWaitForBigBlindColorTolerance

   IniRead, %CasinoName%ButtonSitOutControlName, %FileName%, Main,ButtonSitOutControlName
   IniRead, %CasinoName%ButtonSitOutX, %FileName%, Main,ButtonSitOutX
   IniRead, %CasinoName%ButtonSitOutY, %FileName%, Main,ButtonSitOutY
   IniRead, %CasinoName%ButtonSitOutW, %FileName%, Main,ButtonSitOutW
   IniRead, %CasinoName%ButtonSitOutH, %FileName%, Main,ButtonSitOutH
   IniRead, %CasinoName%ButtonSitOutColorTolerance, %FileName%, Main,ButtonSitOutColorTolerance

   IniRead, %CasinoName%ButtonDealMeInControlName, %FileName%, Main,ButtonDealMeInControlName
   IniRead, %CasinoName%ButtonDealMeInX, %FileName%, Main,ButtonDealMeInX
   IniRead, %CasinoName%ButtonDealMeInY, %FileName%, Main,ButtonDealMeInY
   IniRead, %CasinoName%ButtonDealMeInW, %FileName%, Main,ButtonDealMeInW
   IniRead, %CasinoName%ButtonDealMeInH, %FileName%, Main,ButtonDealMeInH
   IniRead, %CasinoName%ButtonDealMeInColorTolerance, %FileName%, Main,ButtonDealMeInColorTolerance

   IniRead, %CasinoName%ButtonTimeControlName, %FileName%, Main,ButtonTimeControlName
   IniRead, %CasinoName%ButtonTimeX, %FileName%, Main,ButtonTimeX
   IniRead, %CasinoName%ButtonTimeY, %FileName%, Main,ButtonTimeY
   IniRead, %CasinoName%ButtonTimeW, %FileName%, Main,ButtonTimeW
   IniRead, %CasinoName%ButtonTimeH, %FileName%, Main,ButtonTimeH
   IniRead, %CasinoName%ButtonTimeColorTolerance, %FileName%, Main,ButtonTimeColorTolerance

   IniRead, %CasinoName%ButtonImReadyControlName, %FileName%, Main,ButtonImReadyControlName
   IniRead, %CasinoName%ButtonImReadyX, %FileName%, Main,ButtonImReadyX
   IniRead, %CasinoName%ButtonImReadyY, %FileName%, Main,ButtonImReadyY
   IniRead, %CasinoName%ButtonImReadyW, %FileName%, Main,ButtonImReadyW
   IniRead, %CasinoName%ButtonImReadyH, %FileName%, Main,ButtonImReadyH
   IniRead, %CasinoName%ButtonImReadyColorTolerance, %FileName%, Main,ButtonImReadyColorTolerance
   
   IniRead, %CasinoName%ButtonNLMaxBetControlName, %FileName%, Main,ButtonNLMaxBetControlName
   IniRead, %CasinoName%ButtonNLMaxBetX, %FileName%, Main,ButtonNLMaxBetX
   IniRead, %CasinoName%ButtonNLMaxBetY, %FileName%, Main,ButtonNLMaxBetY   

   IniRead, %CasinoName%ButtonOptionsControlName, %FileName%, Main,ButtonOptionsControlName
   IniRead, %CasinoName%ButtonOptionsX, %FileName%, Main,ButtonOptionsX
   IniRead, %CasinoName%ButtonOptionsY, %FileName%, Main,ButtonOptionsY


   ; Misc Table Buttons
   IniRead, %CasinoName%ButtonLayoutControlName, %FileName%, Main,ButtonLayoutControlName
   IniRead, %CasinoName%ButtonLayoutX, %FileName%, Main,ButtonLayoutX
   IniRead, %CasinoName%ButtonLayoutY, %FileName%, Main,ButtonLayoutY
   
   IniRead, %CasinoName%ButtonLayoutTileTablesOffset, %FileName%, Main,ButtonLayoutTileTablesOffset
   IniRead, %CasinoName%ButtonLayoutCascadeTablesOffset, %FileName%, Main,ButtonLayoutCascadeTablesOffset
   IniRead, %CasinoName%ButtonLayoutCustomLayout1Offset, %FileName%, Main,ButtonLayoutCustomLayout1Offset
   IniRead, %CasinoName%ButtonLayoutCustomLayout2Offset, %FileName%, Main,ButtonLayoutCustomLayout2Offset

   IniRead, %CasinoName%ButtonRingLastHandControlName, %FileName%, Main,ButtonRingLastHandControlName
   IniRead, %CasinoName%ButtonRingLastHandX, %FileName%, Main,ButtonRingLastHandX
   IniRead, %CasinoName%ButtonRingLastHandY, %FileName%, Main,ButtonRingLastHandY
   
   IniRead, %CasinoName%ButtonTournamentLastHandControlName, %FileName%, Main,ButtonTournamentLastHandControlName
   IniRead, %CasinoName%ButtonTournamentLastHandX, %FileName%, Main,ButtonTournamentLastHandX
   IniRead, %CasinoName%ButtonTournamentLastHandY, %FileName%, Main,ButtonTournamentLastHandY

   IniRead, %CasinoName%ButtonTournamentInfoControlName, %FileName%, Main,ButtonTournamentInfoControlName
   IniRead, %CasinoName%ButtonTournamentInfoX, %FileName%, Main,ButtonTournamentInfoX
   IniRead, %CasinoName%ButtonTournamentInfoY, %FileName%, Main,ButtonTournamentInfoY

   IniRead, %CasinoName%ButtonChatControlName, %FileName%, Main,ButtonChatControlName
   IniRead, %CasinoName%ButtonChatX, %FileName%, Main,ButtonChatX
   IniRead, %CasinoName%ButtonChatY, %FileName%, Main,ButtonChatY
   
   IniRead, %CasinoName%ButtonInfoControlName, %FileName%, Main,ButtonInfoControlName
   IniRead, %CasinoName%ButtonInfoX, %FileName%, Main,ButtonInfoX
   IniRead, %CasinoName%ButtonInfoY, %FileName%, Main,ButtonInfoY
   IniRead, %CasinoName%ButtonInfoColor, %FileName%, Main,ButtonInfoColor
   IniRead, %CasinoName%ButtonInfoColorTolerance, %FileName%, Main,ButtonInfoColorTolerance
   
   IniRead, %CasinoName%ButtonRefreshControlName, %FileName%, Main,ButtonRefreshControlName
   IniRead, %CasinoName%ButtonRefreshX, %FileName%, Main,ButtonRefreshX
   IniRead, %CasinoName%ButtonRefreshY, %FileName%, Main,ButtonRefreshY      

   IniRead, %CasinoName%BoxChatEditControlName, %FileName%, Main,BoxChatEditControlName
   IniRead, %CasinoName%BoxChatListControlName, %FileName%, Main,BoxChatListControlName
   IniRead, %CasinoName%EditChatBoxX, %FileName%, Main,EditChatBoxX
   IniRead, %CasinoName%EditChatBoxY, %FileName%, Main,EditChatBoxY
   IniRead, %CasinoName%EditChatBoxW, %FileName%, Main,EditChatBoxW
   IniRead, %CasinoName%EditChatBoxH, %FileName%, Main,EditChatBoxH

   ; Table Text Boxes (betting box, chat box, etc)
   IniRead, %CasinoName%BoxBetEditControlName, %FileName%, Main,BoxBetEditControlName
   IniRead, %CasinoName%BoxBetEditX, %FileName%, Main,BoxBetEditX  
   IniRead, %CasinoName%BoxBetEditY, %FileName%, Main,BoxBetEditY
   IniRead, %CasinoName%BoxBetEditColor, %FileName%, Main,BoxBetEditColor   
 
   ; Player Note items
   IniRead, %CasinoName%BoxNoteListControlName, %FileName%, Main,BoxNoteListControlName
   IniRead, %CasinoName%BoxNotePlayersNameControlName, %FileName%, Main,BoxNotePlayersNameControlName

   ; Misc Table Buttons
   IniRead, %CasinoName%ButtonGetChipsControlName, %FileName%, Main,ButtonGetChipsControlName
   IniRead, %CasinoName%ButtonGetChipsX, %FileName%, Main,ButtonGetChipsX
   IniRead, %CasinoName%ButtonGetChipsY, %FileName%, Main,ButtonGetChipsY
      

}