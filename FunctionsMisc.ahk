
 
 ; *******************************************************************************
; -------------------------------------------------------------------------------
; Misc Functions
; -------------------------------------------------------------------------------
; *******************************************************************************

; find the distance between 2 points
Distance(pX1,pY1,pX2,pY2)
{
   return (sqrt( (pX1-pX2)**2  +  (pY1-pY2)**2  ))
}

IIf(_boolExpr, _exprTrue, _exprFalse) {
If _boolExpr
 Return _exprTrue
else
 return _exprFalse
}




;this function extracts the trailing characters of a string
;(for instance "White" from BackgroundWhite etc.)
StrEnd(O,str) {
IfNotInString, O, %a_space%%str%
 return
StringMid, e, O, InStr(O, " " str) + StrLen(str) + 1
, InStr(O, a_space, "", InStr(O, " " str) + 1) - InStr(O, " " str) - StrLen(str) - 1
return e
}



; string replace (Roland)
strRep(str,char,rep_char="",all=1) {
StringReplace,str,str,%char%,%rep_char%,% all ? "useErrorLevel" : 0
return str
}

; check if one of the keys in list is currently pressed
; returns 1 if one of the keys is pressed, else returns 0
KeyPressedInList(List)
{

   KeyNum := ListLength(List)
   Loop, %KeyNum%
   {
         Key := ListGetItem(List,A_Index)
         if GetKeyState(Key,"P")
            return 1
   }
   return 0
}


; remove all keboard modifiers from Key
RemoveKeyModifiers(Key)
{


   ; get rid of any modifiers of this key, so that we can detect multiple presses of must the main key

   if instr(Key,"&")
   {
      StringReplace, Key, Key,LAlt,,All
      StringReplace, Key, Key,RAlt,,All
      StringReplace, Key, Key,LShift,,All
      StringReplace, Key, Key,RShift,,All
      StringReplace, Key, Key,LWin,,All
      StringReplace, Key, Key,RWin,,All
      StringReplace, Key, Key,LControl,,All
      StringReplace, Key, Key,RControl,,All
      StringReplace, Key, Key,LCtrl,,All
      StringReplace, Key, Key,RCtrl,,All
      StringReplace, Key, Key,Alt,,All
      StringReplace, Key, Key,Shift,,All
      StringReplace, Key, Key,Control,,All
      StringReplace, Key, Key,Ctrl,,All
      StringReplace, Key, Key,&,,All
   }




   StringReplace, Key, Key,#,,All
   StringReplace, Key, Key,!,,All
   StringReplace, Key, Key,^,,All
   StringReplace, Key, Key,<,,All
   StringReplace, Key, Key,>,,All
   StringReplace, Key, Key,%A_space%,,All

   return Key
}


