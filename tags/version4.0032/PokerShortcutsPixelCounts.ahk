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




/*  template

   PixelCountDigits := 0
   PixelCountDigits := 1
   PixelCountDigits := 2
   PixelCountDigits := 3
   PixelCountDigits := 4
   PixelCountDigits := 5
   PixelCountDigits := 6
   PixelCountDigits := 7
   PixelCountDigits := 8
   PixelCountDigits := 9
   PixelCountDigits := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"

*/

   FTMinimumPixelCountPerColumn := 2               ; when counting pixels in a column, this is the minimum number to be a valid column (else it is a spacer column)
                                                   ; FT has some columns with one pixel in them next to a decimal point that we need to say these are spacer columns.
                                                   ;    Like the 4 digit has one column on the right with one pixel, and this will be right next to the decimal point.
                                                   ;    Fortunately the decimal point has 2 pixels in it, so that it can be detected as a dp.

   ; FT Pixel Count Digits for table (client width) 472-563
   PixelCountDigits52254 := 0
   PixelCountDigits276 := 1
   PixelCountDigits35335 := 2
   PixelCountDigits23344 := 3
   PixelCountDigits22276 := 4
   PixelCountDigits53335 := 5
   PixelCountDigits53321 := 6
   PixelCountDigits23321 := 7
   PixelCountDigits43344 := 8
   PixelCountDigits23354 := 9
   PixelCountDigits21 := "."
   PixelCountDigits3333332 := "A"
   PixelCountDigits333335 := "S"


   ; FT Pixel Count Digits for table (client width) 564-682
   PixelCountDigits622265 := 0
   PixelCountDigits287 := 1
   PixelCountDigits333336 := 2
   PixelCountDigits223355 := 3
   PixelCountDigits22287 := 4
   PixelCountDigits533346 := 5
   PixelCountDigits533332 := 6
   PixelCountDigits33321 := 7
   PixelCountDigits533355 := 8
   PixelCountDigits333354 := 9
   PixelCountDigits21 := "."
   PixelCountDigits3433432 := "A"
   PixelCountDigits333346 := "S"

   ; FT Pixel Count Digits for table (client width) 683-841
   PixelCountDigits6822865 := 0
   PixelCountDigits2887 := 1
   PixelCountDigits3544536 := 2
   PixelCountDigits2433855 := 3
   PixelCountDigits222787 := 4
   PixelCountDigits653646 := 5
   PixelCountDigits6833632 := 6
   PixelCountDigits47521 := 7
   PixelCountDigits5833855 := 8
   PixelCountDigits3633865 := 9
   PixelCountDigits221 := "."
   PixelCountDigits36636632 := "A"
   PixelCountDigits4644646 := "S"



   ; FT Pixel Count Special situation below 842-881 - looks like only the 2 digit is different here
   PixelCountDigits23444647 := 2

   ; FT Pixel Count Digits for table (client width) 842-960
   PixelCountDigits79222976 := 0
   PixelCountDigits22998 := 1
   PixelCountDigits33444647 := 2

   PixelCountDigits22333966 := 3
   PixelCountDigits2222998 := 4
   PixelCountDigits5533757 := 5
   PixelCountDigits68433743 := 6
   PixelCountDigits465421 := 7
   PixelCountDigits69333966 := 8
   PixelCountDigits47334865 := 9
   PixelCountDigits221 := "."
   PixelCountDigits2555355521 := "A"
   PixelCountDigits56333656 := "S"





   ; FT Pixel Count Digits for table (client width) 961-1040
   PixelCountDigits684224865 := 0
   PixelCountDigits22AA9 := 1
   PixelCountDigits354435647 := 2
   PixelCountDigits463337735 := 3
   PixelCountDigits22222AA9 := 4
   PixelCountDigits275335647 := 5
   PixelCountDigits685335632 := 6
   PixelCountDigits3555421 := 7
   PixelCountDigits7A3333A77 := 8
   PixelCountDigits365335865 := 9
   PixelCountDigits332 := "."
   PixelCountDigits3556365532 := "A"
   PixelCountDigits475445746 := "S"

   ; FT Pixel Count Digits for table (client width) 1041-1119
   PixelCountDigits8A42224A87 := 0
   PixelCountDigits22CCB := 1
   PixelCountDigits3544445649 := 2
   PixelCountDigits4623337957 := 3
   PixelCountDigits222222CCB := 4
   PixelCountDigits2863335759 := 5
   PixelCountDigits7954335743 := 6
   PixelCountDigits35555421 := 7
   PixelCountDigits5973337957 := 8
   PixelCountDigits4753345976 := 9
   PixelCountDigits332 := "."
   PixelCountDigits355653565532 := "A"
   PixelCountDigits5864446858 := "S"






/*  template

   PixelCountDigits := 0
   PixelCountDigits := 1
   PixelCountDigits := 2
   PixelCountDigits := 3
   PixelCountDigits := 4
   PixelCountDigits := 5
   PixelCountDigits := 6
   PixelCountDigits := 7
   PixelCountDigits := 8
   PixelCountDigits := 9
   PixelCountDigits := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"
*/


   PSMinimumPixelCountPerColumn := 1               ; when counting pixels in a column, this is the minimum number to be a valid column (else it is a spacer column)

   ; PS Pixel Count Digits for table (client width) 475-518
   PixelCountDigits42243 := 0
   PixelCountDigits165 := 1
   PixelCountDigits33334 := 2
   PixelCountDigits22333 := 3
   PixelCountDigits23610 := 4
   PixelCountDigits4334 := 5
   PixelCountDigits43321 := 6
   PixelCountDigits1521 := 7
   PixelCountDigits33333 := 8
   PixelCountDigits23343 := 9
   PixelCountDigits21 := "."
   PixelCountDigits223221 := "A"
   PixelCountDigits23323 := "S"

   ; PS Pixel Count Digits for table (client width) 519-613
   PixelCountDigits52254 := 0
   PixelCountDigits176 := 1
   PixelCountDigits33335 := 2
   PixelCountDigits22344 := 3
   PixelCountDigits23710 := 4
   PixelCountDigits53345 := 5
   PixelCountDigits53334 := 6
   PixelCountDigits14321 := 7
   PixelCountDigits43344 := 8
   PixelCountDigits33354 := 9
   PixelCountDigits10 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"

   ; PS Pixel Count Digits for table (client width) 614-728
   PixelCountDigits622265 := 0
   PixelCountDigits1187 := 1
   PixelCountDigits233346 := 2
   PixelCountDigits223355 := 3
   PixelCountDigits232810 := 4
   PixelCountDigits343346 := 5
   PixelCountDigits633345 := 6
   PixelCountDigits143310 := 7
   PixelCountDigits533355 := 8
   PixelCountDigits433365 := 9
   PixelCountDigits10 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"


   ; PS Pixel Count Digits for table (client width) 729-867
   PixelCountDigits8A22A87 := 0
   PixelCountDigits22AA9 := 1
   PixelCountDigits3555748 := 2
   PixelCountDigits2433A77 := 3
   PixelCountDigits233AA10 := 4
   PixelCountDigits4743868 := 5
   PixelCountDigits7933857 := 6
   PixelCountDigits1476421 := 7
   PixelCountDigits7A33A77 := 8
   PixelCountDigits5833976 := 9
   PixelCountDigits221 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"

/*
   ; PS Pixel Count Digits for table (client width) 868-1029
   PixelCountDigits39242932 := 0
   PixelCountDigits111ABA := 1
   PixelCountDigits5454737 := 2
   PixelCountDigits4254725 := 3
   PixelCountDigits2333AB21 := 4
   PixelCountDigits9464847 := 5
   PixelCountDigits36364710 := 6
   PixelCountDigits23743221 := 7
   PixelCountDigits16464710 := 8
   PixelCountDigits17463632 := 9
   PixelCountDigits221 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"
*/
   
   ; PS Pixel Count Digits for table (client width) 868-1029
   PixelCountDigits39242932 := 0
   PixelCountDigits111ABA := 1
   PixelCountDigits5454737 := 2
   PixelCountDigits4254725 := 3
   PixelCountDigits2333AB21 := 4
   PixelCountDigits9464847 := 5
   PixelCountDigits36364710 := 6
   PixelCountDigits23743221 := 7
   PixelCountDigits16464710 := 8
   PixelCountDigits17463632 := 9
   PixelCountDigits221 := "."
   PixelCountDigits1456465410 := "A"
   PixelCountDigits64554610 := "S"

/*
   ; PS Pixel Count Digits for table (client width) 1030-1219
   PixelCountDigits482442843 := 0
   PixelCountDigits111BCB := 1
   PixelCountDigits54554738 := 2
   PixelCountDigits32464736 := 3
   PixelCountDigits23333BC21 := 4
   PixelCountDigits84664721 := 5
   PixelCountDigits373463821 := 6
   PixelCountDigits223753321 := 7
   PixelCountDigits284664825 := 8
   PixelCountDigits283643732 := 9
   PixelCountDigits221 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"
*/

   ; PS Pixel Count Digits for table (client width) 1030-1219
   PixelCountDigits482442843 := 0
   PixelCountDigits111BCB := 1
   PixelCountDigits54554738 := 2
   PixelCountDigits32464736 := 3
   PixelCountDigits23333BC21 := 4
   PixelCountDigits84664721 := 5
   PixelCountDigits373463821 := 6
   PixelCountDigits223753321 := 7
   PixelCountDigits284664825 := 8
   PixelCountDigits283643732 := 9
   PixelCountDigits221 := "."
   PixelCountDigits3354445332 := "A"
   PixelCountDigits1644643725 := "S"

/*
   ; PS Pixel Count Digits for table (client width) 1220+
   PixelCountDigits4AC242CA43 := 0
   PixelCountDigits211CEED := 1
   PixelCountDigits47666974A := 2
   PixelCountDigits25255C926 := 3
   PixelCountDigits23344DEE221 := 4
   PixelCountDigits49755A821 := 5
   PixelCountDigits4AB355A821 := 6
   PixelCountDigits237A654321 := 7
   PixelCountDigits28A464A827 := 8
   PixelCountDigits28A553BA43 := 9
   PixelCountDigits3332 := "."
   PixelCountDigits := "A"
   PixelCountDigits := "S"
*/

   ; PS Pixel Count Digits for table (client width) 1220+
   PixelCountDigits4AC242CA43 := 0
   PixelCountDigits211CEED := 1
   PixelCountDigits47666974A := 2
   PixelCountDigits25255C926 := 3
   PixelCountDigits23344DEE221 := 4
   PixelCountDigits49755A821 := 5
   PixelCountDigits4AB355A821 := 6
   PixelCountDigits237A654321 := 7
   PixelCountDigits28A464A827 := 8
   PixelCountDigits28A553BA43 := 9
   PixelCountDigits3332 := "."
   PixelCountDigits366986896632 := "A"
   PixelCountDigits27A58885A736 := "S"
