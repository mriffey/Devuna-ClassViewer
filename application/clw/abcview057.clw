

   MEMBER('abcview.clw')                                   ! This is a MEMBER module

!region Notices
! ================================================================================
! Notice : Copyright (C) 2017, Devuna
!          Distributed under the MIT License (https://opensource.org/licenses/MIT)
!
!    This file is part of Devuna-ClassViewer (https://github.com/Devuna/Devuna-ClassViewer)
!
!    Devuna-ClassViewer is free software: you can redistribute it and/or modify
!    it under the terms of the MIT License as published by
!    the Open Source Initiative.
!
!    Devuna-ClassViewer is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    MIT License for more details.
!
!    You should have received a copy of the MIT License
!    along with Devuna-ClassViewer.  If not, see <https://opensource.org/licenses/MIT>.
! ================================================================================
!endregion Notices
!!! <summary>
!!! Generated from procedure template - Source
!!! Get CEDT word list
!!! </summary>
srcGetWordList       PROCEDURE  (*CSTRING ClarionKeywords, *CSTRING CompilerDirectives, *CSTRING BuiltinProcsFuncs, *CSTRING StructDataTypes, *CSTRING Attributes, *CSTRING StandardEquates) ! Declare Procedure
!region Notices
! ================================================================================
! Notice : Copyright (C) 2017, Devuna
!          Distributed under the MIT License (https://opensource.org/licenses/MIT)
!
!    This file is part of Devuna-ClassViewer (https://github.com/Devuna/Devuna-ClassViewer)
!
!    Devuna-ClassViewer is free software: you can redistribute it and/or modify
!    it under the terms of the MIT License as published by
!    the Open Source Initiative.
!
!    Devuna-ClassViewer is distributed in the hope that it will be useful,
!    but WITHOUT ANY WARRANTY; without even the implied warranty of
!    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!    MIT License for more details.
!
!    You should have received a copy of the MIT License
!    along with Devuna-ClassViewer.  If not, see <https://opensource.org/licenses/MIT>.
! ================================================================================
!endregion Notices
oHH           &tagHTMLHelp
szIniFile         CSTRING(256),STATIC
IniFile           FILE,DRIVER('ASCII'),NAME(szIniFile)
IniRecord            RECORD
IniBuffer               STRING(256)
                     END
                  END

color_groups      QUEUE
color_num            LONG
color_group          CSTRING(41)
                  END

color_values      QUEUE
color_num            LONG
keyword              CSTRING(41)
                  END

M                 LONG
N                 LONG
strBuffer         CSTRING(4096)

szSubKey          CSTRING(255)
szValueName       CSTRING(255)
szValue           CSTRING(261)
hKeyExtension     ULONG
pType             ULONG
pData             ULONG
loc:szRoot        CSTRING(261)
RetVal            LONG
KeywordsFound     LONG

MyQueue           QUEUE,PRE(q)
Name                 STRING(65)
Bold                 STRING(65)
Italic               STRING(65)
Color                STRING(65)
Word                 STRING(65)
                  END
Count             LONG
loc:szXMLFilename CSTRING(261)

  CODE
      KeywordsFound = False

      CASE glo:bClarionVersion
        OF CWVERSION_C2
           szIniFile = szRoot & '\bin\c2edt.ini'
        OF CWVERSION_C4
           szIniFile = szRoot & '\bin\c4edt.ini'
        OF CWVERSION_C5
           szIniFile = szRoot & '\bin\c5edt.ini'
        OF CWVERSION_C5EE
           szIniFile = szRoot & '\bin\c5edt.ini'
        OF CWVERSION_C55
           szIniFile = szRoot & '\bin\c55edt.ini'
        OF CWVERSION_C55EE
           szIniFile = szRoot & '\bin\c55edt.ini'
        OF CWVERSION_C60
           szIniFile = szRoot & '\bin\c60edt.ini'
        OF CWVERSION_C60EE
           szIniFile = szRoot & '\bin\c60edt.ini'
        OF CWVERSION_C70 !OROF CWVERSION_C71
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              loc:szXMLFileName = ''
              szIniFile = ''
              !use clarion6 settings
              szSubKey = 'SOFTWARE\SoftVelocity\Clarion6'
              RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
              IF RetVal = ERROR_SUCCESS
                 szValueName = 'root'
                 pType = REG_SZ
                 pData = SIZE(loc:szRoot)
                 RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
                 RetVal = RegCloseKey(hKeyExtension)
                 IF loc:szRoot
                    szIniFile = loc:szRoot & '\bin\c60edt.ini'
                 END
              END
           END
        OF CWVERSION_C80
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              !use clarion7 settings
              loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
              IF ~EXISTS(loc:szXMLFileName)
                 loc:szXMLFileName = ''
                 szIniFile = ''
                 !use clarion6 settings
                 szSubKey = 'SOFTWARE\SoftVelocity\Clarion6'
                 RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
                 IF RetVal = ERROR_SUCCESS
                    szValueName = 'root'
                    pType = REG_SZ
                    pData = SIZE(loc:szRoot)
                    RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
                    RetVal = RegCloseKey(hKeyExtension)
                    IF loc:szRoot
                       szIniFile = loc:szRoot & '\bin\c60edt.ini'
                    END
                 END
              END
           END
        OF CWVERSION_C90
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              !use clarion8 settings
              loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
              IF ~EXISTS(loc:szXMLFileName)
                 !use clarion7 settings
                 loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
                 IF ~EXISTS(loc:szXMLFileName)
                    loc:szXMLFileName = ''
                    szIniFile = ''
                    !use clarion6 settings
                    szSubKey = 'SOFTWARE\SoftVelocity\Clarion6'
                    RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
                    IF RetVal = ERROR_SUCCESS
                       szValueName = 'root'
                       pType = REG_SZ
                       pData = SIZE(loc:szRoot)
                       RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
                       RetVal = RegCloseKey(hKeyExtension)
                       IF loc:szRoot
                          szIniFile = loc:szRoot & '\bin\c60edt.ini'
                       END
                    END
                 END
              END
           END
        OF CWVERSION_C100
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              !use clarion9 settings
              loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
              IF ~EXISTS(loc:szXMLFileName)
                 !use clarion8 settings
                 loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
                 IF ~EXISTS(loc:szXMLFileName)
                    !use clarion7 settings
                    loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
                    IF ~EXISTS(loc:szXMLFileName)
                       loc:szXMLFileName = ''
                       szIniFile = ''
                       !use clarion6 settings
                       szSubKey = 'SOFTWARE\SoftVelocity\Clarion6'
                       RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
                       IF RetVal = ERROR_SUCCESS
                          szValueName = 'root'
                          pType = REG_SZ
                          pData = SIZE(loc:szRoot)
                          RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
                          RetVal = RegCloseKey(hKeyExtension)
                          IF loc:szRoot
                             szIniFile = loc:szRoot & '\bin\c60edt.ini'
                          END
                       END
                    END
                 END
              END
           END
      END

      IF ((glo:bClarionVersion < CWVERSION_C70) OR ((glo:bClarionVersion >= CWVERSION_C70) AND (loc:szXMLFileName = '')))
         IF EXISTS(szIniFile)
            OPEN(IniFile,ReadOnly+DenyNone)
            SET(IniFile)
            NEXT(IniFile)
            LOOP UNTIL ERRORCODE()
               CASE UPPER(CLIP(IniFile.IniRecord.IniBuffer))
               OF '[COLOR_GROUPS]'
                  DO ProcessColorGroups
               OF '[COLOR_VALUES]'
                  DO ProcessColorValues
               ELSE
                  NEXT(IniFile)
               END
            END
            CLOSE(IniFile)
            KeywordsFound = True
         END

      ELSIF glo:bClarionVersion >= CWVERSION_C70
         xml:SetProgressWindow(-1)
         IF ~xml:LoadFromFile(loc:szXMLFileName,FALSE)
            IF ~xml:FindNextNode('RuleSet','Keywords')
               count = xml:LoadQueue(MyQueue,TRUE,TRUE)
               !XML:DebugMyQueue(MyQueue,'MyQueue Contents')
               xml:Free()
               DO InitializeColorGroups
               SORT(color_groups,+color_groups.color_group)
               DO ParseBindingResource
               DO ParseBuiltIns
               DO AddDefaultBuiltins
               SORT(color_groups,+color_groups.color_num)
               KeywordsFound = True
            END
         END
      END
      IF KeywordsFound = True
         N = RECORDS(Color_Groups)
         LOOP M = 1 TO N
            GET(Color_Groups,M)
            CASE Color_Groups.Color_Group
              OF 'Clarion Keywords'
                  DO GetWordList
                  ClarionKeywords = CLIP(LEFT(strBuffer))
              OF 'Compiler Directives'
                  DO GetWordList
                  CompilerDirectives = CLIP(LEFT(strBuffer))
              OF 'Built-in Procedures & Functions'
                  DO GetWordList
                  BuiltinProcsFuncs = CLIP(LEFT(strBuffer))
              OF 'Structures and Data types'
                  DO GetWordList
                  StructDataTypes = CLIP(LEFT(strBuffer))
              OF 'Attributes'
                  DO GetWordList
                  Attributes = CLIP(LEFT(strBuffer))
              OF 'Standard Equates'
                  DO GetWordList
                  StandardEquates = CLIP(LEFT(strBuffer))
            END
         END
      END
      RETURN KeywordsFound
GetWordList         ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  strBuffer = ''
  J = RECORDS(color_values)
  LOOP I = 1 TO J
     GET(color_values,I)
     IF color_values.color_num = Color_Groups.Color_num
        strBuffer = strBuffer & ' ' & color_values.keyword
     END
  END
  EXIT
ProcessColorGroups  ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       color_groups.color_num   = IniFile.IniRecord.IniBuffer[1 : I-1]
       color_groups.color_group = IniFile.IniRecord.IniBuffer[I+1 : J]
       ADD(color_groups)
    END
    NEXT(IniFile)
  END
  EXIT
ProcessColorValues  ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       color_values.keyword     = IniFile.IniRecord.IniBuffer[1 : I-1]
       ! 2003.11.27 KCR - look for and omit deprecated words
       CASE UPPER(color_values.keyword)
       OF 'BOF' OROF 'EOF' OROF 'FUNCTION' OROF 'POINTER' OROF 'SHARE'
          ! omit deprecated statement
       ELSE
          color_values.color_num   = IniFile.IniRecord.IniBuffer[I+1 : J]
          ADD(color_values)
       END
    END
    NEXT(IniFile)
  END
  EXIT
InitializeColorGroups   ROUTINE
  DATA
I   LONG

  CODE
      LOOP I = 1 TO 26
         color_groups.color_num = I-1
         EXECUTE I
            color_groups.color_group = 'Normal Text'
            color_groups.color_group = 'Normal Background'
            color_groups.color_group = 'Block Text'
            color_groups.color_group = 'Block Background'
            color_groups.color_group = 'Line Highlight Text'
            color_groups.color_group = 'Line Highlight Background'
            color_groups.color_group = 'Error Line Text'
            color_groups.color_group = 'Error Line Background'
            color_groups.color_group = 'Label'
            color_groups.color_group = 'Comment'
            color_groups.color_group = 'String'
            color_groups.color_group = 'User Identifier'
            color_groups.color_group = 'Integer Constant'
            color_groups.color_group = 'Real constant'
            color_groups.color_group = 'Picture string'
            color_groups.color_group = 'Disabled Text'
            color_groups.color_group = 'Disabled Background'
            color_groups.color_group = ''
            color_groups.color_group = ''
            color_groups.color_group = ''
            color_groups.color_group = 'Clarion Keywords'
            color_groups.color_group = 'Compiler Directives'
            color_groups.color_group = 'Built-in Procedures & Functions'
            color_groups.color_group = 'Structures and Data types'
            color_groups.color_group = 'Attributes'
            color_groups.color_group = 'Standard Equates'
         END
         ADD(color_groups,+color_groups.color_num)
      END
      EXIT
ParseBindingResource    ROUTINE
      LOOP M = 1 TO count
         GET(MyQueue,M)
         CASE UPPER(CLIP(MyQueue.Name))

           OF 'LOGICOPERATORS'         !-->Clarion Keywords
              color_groups.color_group = 'Clarion Keywords'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'HARDRESERVEDKEYWORDS'   !-->Clarion Keywords
              color_groups.color_group = 'Clarion Keywords'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'SOFTRESERVEDKEYWORDS'   !-->ReservedWordsProcLabels
              color_groups.color_group = 'Clarion Keywords'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'DIRECTIVES'             !-->Directives
              color_groups.color_group = 'Compiler Directives'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'BASETYPES'              !-->StructDataTypes
              color_groups.color_group = 'Structures and Data types'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'SPECIALTYPES'           !-->StructDataTypes
              color_groups.color_group = 'Structures and Data types'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords
              color_values.color_num = color_groups.color_num
              color_values.keyword   = 'BEGIN'
              ADD(color_values,+color_values.keyword)
              color_values.keyword   = 'ITEMIZE'
              ADD(color_values,+color_values.keyword)

           OF 'ATTRIBUTES'             !-->Attributes
              color_groups.color_group = 'Attributes'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

           OF 'BUILTINS'               !-->StandardEquates
              color_groups.color_group = 'Standard Equates'
              GET(color_groups,+color_groups.color_group)
              DO AddKeywords

         ELSE !skip this node
              M += 1
              GET(MyQueue,M)
              LOOP WHILE CLIP(MyQueue.Name) = ''
                 M += 1
                 GET(MyQueue,M)
                 IF ERRORCODE()
                    BREAK
                 END
              END
              M -= 1
         END
      END
      EXIT
AddKeywords ROUTINE
      color_values.keyword = UPPER(CLIP(MyQueue.Word))
      GET(color_values,+color_values.keyword)
      IF ERRORCODE()
         color_values.color_num = color_groups.color_num
         IF glo:bClarionVersion > CWVERSION_C60EE
            CASE color_groups.color_group
              OF 'Clarion Keywords'
                 CASE color_values.keyword
                   !skip the ReservedWordProcLabels
                   OF 'APPLICATION'
                   OF 'CLASS'
                   OF 'DETAIL'
                   OF 'FILE'
                   OF 'FOOTER'
                   OF 'FORM'
                   OF 'GROUP'
                   OF 'HEADER'
                   OF 'ITEM'
                   OF 'MENU'
                   OF 'MENUBAR'
                   OF 'OPTION'
                   OF 'QUEUE'
                   OF 'REPORT'
                   OF 'SHEET'
                   OF 'TAB'
                   OF 'TABLE'
                   OF 'TOOLBAR'
                   OF 'VIEW'
                ELSE
                   ADD(color_values,+color_values.keyword)
                END
              OF 'Structures and Data types'
                 CASE color_values.keyword
                   OF 'CHECK'
                   OF 'DOUBLE'
                   OF 'SEPARATOR'
                ELSE
                   ADD(color_values,+color_values.keyword)
                END
              OF 'Compiler Directives'
                 CASE color_values.keyword
                   OF 'BEGIN'
                   OF 'ITEMIZE'
                ELSE
                   ADD(color_values,+color_values.keyword)
                END
            ELSE
               ADD(color_values,+color_values.keyword)
            END
         ELSE
            ADD(color_values,+color_values.keyword)
         END
      END

      M += 1
      GET(MyQueue,M)
      LOOP WHILE CLIP(MyQueue.Name) = ''
         color_values.keyword = UPPER(CLIP(MyQueue.Word))
         GET(color_values,+color_values.keyword)
         IF ERRORCODE()
            color_values.color_num = color_groups.color_num
            IF glo:bClarionVersion > CWVERSION_C60EE
               CASE color_groups.color_group
                 OF 'Clarion Keywords'
                    CASE color_values.keyword
                      !skip the ReservedWordProcLabels
                      OF 'APPLICATION'
                      OF 'CLASS'
                      OF 'DETAIL'
                      OF 'FILE'
                      OF 'FOOTER'
                      OF 'FORM'
                      OF 'GROUP'
                      OF 'HEADER'
                      OF 'ITEM'
                      OF 'MENU'
                      OF 'MENUBAR'
                      OF 'OPTION'
                      OF 'QUEUE'
                      OF 'REPORT'
                      OF 'SHEET'
                      OF 'TAB'
                      OF 'TABLE'
                      OF 'TOOLBAR'
                      OF 'VIEW'
                    ELSE
                         ADD(color_values,+color_values.keyword)
                    END
                 OF 'Structures and Data types'
                    CASE color_values.keyword
                      OF 'CHECK'
                      OF 'DOUBLE'
                      OF 'SEPARATOR'
                    ELSE
                         ADD(color_values,+color_values.keyword)
                    END
                 OF 'Compiler Directives'
                    CASE color_values.keyword
                      OF 'BEGIN'
                      OF 'ITEMIZE'
                   ELSE
                      ADD(color_values,+color_values.keyword)
                   END
               ELSE
                  ADD(color_values,+color_values.keyword)
               END
            ELSE
               ADD(color_values,+color_values.keyword)
            END
         END
         M += 1
         GET(MyQueue,M)
         IF ERRORCODE()
            BREAK
         END
      END
      M -= 1
      EXIT
ParseBuiltIns  ROUTINE
  DATA
I           LONG
subFolder   CSTRING(5)

  CODE
      IF glo:bClarionVersion > CWVERSION_C60EE
         subFolder = 'win\'
      ELSE
         subFolder = ''
      END

      color_groups.color_group = 'Built-in Procedures & Functions'
      GET(color_groups,+color_groups.color_group)

      !scan builtins.clw for builtin procedures and functions
      szIniFile = szRoot & '\libsrc\' & subFolder & 'builtins.clw'
      OPEN(IniFile,ReadOnly+DenyNone)
      SET(IniFile)
      LOOP UNTIL ERRORCODE()
         NEXT(IniFile)
         IF ERRORCODE()
            BREAK
         ELSE
            strBuffer = CLIP(LEFT(IniFile.IniRecord.IniBuffer))
            I = INSTRING('(',strBuffer)
            IF I > 0
               color_values.keyword = UPPER(SUB(strBuffer,1,I-1))
               IF color_values.keyword[1] = '!'
                  CYCLE
               ELSIF color_values.keyword = 'MODULE'
                  CYCLE
               ELSIF color_values.keyword = 'COMPILE'
                  CYCLE
               ELSIF color_values.keyword = 'OMIT'
                  CYCLE
               ELSIF color_values.keyword = 'INCLUDE'
                  CYCLE
               ELSE
                  GET(color_values,+color_values.keyword)
                  IF ERRORCODE()
                     color_values.color_num = color_groups.color_num
                     ADD(color_values,+color_values.keyword)
                  END
               END
            END
         END
      END
      CLOSE(IniFile)
      EXIT
AddDefaultBuiltins   ROUTINE
   DATA
szDefaultBuiltins    CSTRING('ABS ADD ADDRESS AGE APPEND BAND BIND BINDEXPRESSION ' & |
                             'BOR BSHIFT BXOR CALLBACK CHR CLEAR COL CREATE DEFORMAT DISPOSE EVALUATE FORMAT GET ' & |
                             'INDEX INLIST INRANGE INT LIKE LOGOUT LONGNAME MAXIMUM MEMO OMITTED PEEK POKE PRINT PRINTER ' & |
                             'PUT ROUND SETNONULL SETNULL SORT VAL _PROC _PROC1 _PROC2 _PROC3')
szDefaultDirectives  CSTRING('EJECT     EMBED   ENDEMBED PRAGMA SUBTITLE TITLE')
i                    LONG,AUTO
j                    LONG,AUTO
p                    LONG,AUTO
   CODE
      color_groups.color_group = 'Built-in Procedures & Functions'
      GET(color_groups,+color_groups.color_group)
      i = 1
      j = LEN(szDefaultBuiltins)
      p = INSTRING(' ',szDefaultBuiltins,1,i)
      LOOP WHILE p > 0
         color_values.keyword = szDefaultBuiltins[i : p-1]
         GET(color_values,+color_values.keyword)
         IF ERRORCODE()
            color_values.color_num = color_groups.color_num
            ADD(color_values,+color_values.keyword)
         END
         i = p+1
         p = INSTRING(' ',szDefaultBuiltins,1,i)
      END
      color_values.keyword = szDefaultBuiltins[i : j]
      GET(color_values,+color_values.keyword)
      IF ERRORCODE()
         color_values.color_num = color_groups.color_num
         ADD(color_values,+color_values.keyword)
      END

      color_groups.color_group = 'Compiler Directives'
      GET(color_groups,+color_groups.color_group)
      i = 1
      j = LEN(szDefaultDirectives)
      p = INSTRING(' ',szDefaultDirectives,1,i)
      LOOP WHILE p > 0
         color_values.keyword = szDefaultDirectives[i : p-1]
         GET(color_values,+color_values.keyword)
         IF ERRORCODE()
            color_values.color_num = color_groups.color_num
            ADD(color_values,+color_values.keyword)
         END
         i = p+1
         p = INSTRING(' ',szDefaultDirectives,1,i)
      END
      color_values.keyword = szDefaultDirectives[i : j]
      GET(color_values,+color_values.keyword)
      IF ERRORCODE()
         color_values.color_num = color_groups.color_num
         ADD(color_values,+color_values.keyword)
      END
