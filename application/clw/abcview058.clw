

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
!!! Get CEDT colors list
!!! </summary>
srcGetCedtColors     PROCEDURE  (*COLORGROUPTYPE ColorGroup, LONG LoadDefault) ! Declare Procedure
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
loc:ViewerStyles         GROUP(COLORGROUPTYPE),PRE()
                         END
loc:StyleGroup           GROUP(STYLEGROUPTYPE),PRE(sg)
                         END
oHH           &tagHTMLHelp
szIniFile       CSTRING(256),STATIC
IniFile         FILE,DRIVER('ASCII'),NAME(szIniFile)
IniRecord         RECORD
IniBuffer           STRING(256)
                  END
                END

color_groups    QUEUE
color_num         LONG
color_group       CSTRING(41)
                END

color_map       QUEUE
color_num         LONG
color_value       CSTRING(41)
                END

default_colors  QUEUE
color_num         LONG
color_value       CSTRING(41)
                END

M               LONG
N               LONG

szSubKey          CSTRING(255)
szValueName       CSTRING(255)
szValue           CSTRING(261)
hKeyExtension     ULONG
pType             ULONG
pData             ULONG
loc:szRoot        CSTRING(261)
RetVal            LONG

MyQueue           QUEUE,PRE(q)
Name                 STRING(65)
Bold                 STRING(65)
Italic               STRING(65)
Color                STRING(65)
BgColor              STRING(65)
Word                 STRING(65)
                  END
MyData            CSTRING(128)
Count             LONG
loc:szXMLFilename CSTRING(261)
szKey             CSTRING(256)
savePointer       LONG

  CODE
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
           !no ini file for c7
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              loc:szXMLFileName = ''
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
           !no ini file for c8
           RetVal = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
           loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
           IF ~EXISTS(loc:szXMLFileName)
              !use clarion7 settings
              loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\modes\CWBinding.Resources.Clarion-Mode.xshd'
              IF ~EXISTS(loc:szXMLFileName)
                 loc:szXMLFileName = ''
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
           !no ini file for c9
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
           !no ini file for c10
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
         OPEN(IniFile,ReadOnly+DenyNone)
         SET(IniFile)
         NEXT(IniFile)
         LOOP UNTIL ERRORCODE()
            CASE UPPER(CLIP(IniFile.IniRecord.IniBuffer))
            OF '[COLOR_GROUPS]'
               DO ProcessColorGroups
            OF '[COLOR_MAP]'
               DO ProcessColorMap
            OF '[DEFAULT_COLORS]'
               DO ProcessDefaults
            ELSE
               NEXT(IniFile)
            END
         END
         CLOSE(IniFile)

      ELSIF glo:bClarionVersion >= CWVERSION_C70
         DO InitializeColorGroups

         SORT(color_groups,+color_groups.color_group)

         xml:SetProgressWindow(-1)
         IF ~xml:LoadFromFile(loc:szXMLFileName,FALSE)
            IF ~xml:FindNextNode('Environment')
               savePointer = xml:GetPointer()
            END

            IF ~xml:FindNextNode('Custom')
               count = xml:LoadQueue(MyQueue,FALSE,TRUE)
               IF count
                  !xml:DebugMyQueue(MyQueue,'Environment')
                  LOOP M = 1 TO count
                     GET(MyQueue,M)
                     CASE UPPER(CLIP(MyQueue.Name))
                       OF 'LABEL'
                          color_groups.color_group = 'Label'
                          GET(color_groups,+color_groups.color_group)
                          DO AddMappedColor

                       OF 'OMITTEDCODE'
                          color_groups.color_group = 'Comment'
                          GET(color_groups,+color_groups.color_group)
                          DO AddMappedColor
                     END
                  END
                  FREE(MyQueue)
               END
            END

            IF ~xml:SetPointer(savePointer)
               IF ~xml:FindNextNode('Default')
                  count = xml:LoadQueue(MyQueue,FALSE,FALSE)
                  IF count
                     !xml:DebugMyQueue(MyQueue,'Default')
                     color_groups.color_group = 'Normal Text'
                     GET(color_groups,+color_groups.color_group)
                     DO AddMappedColor

                     color_groups.color_group = 'Normal Background'
                     GET(color_groups,+color_groups.color_group)
                     MyQueue.Color = CLIP(MyQueue.bgColor)
                     DO AddMappedColor

                     FREE(MyQueue)
                  END
               END
            END

            IF ~xml:SetPointer(savePointer)
               IF ~xml:FindNextNode('InvalidLines')
                  count = xml:LoadQueue(MyQueue,FALSE,FALSE)
                  IF count
                     !xml:DebugMyQueue(MyQueue,'InvalidLines')
                     color_groups.color_group = 'Error Line Text'
                     GET(color_groups,+color_groups.color_group)
                     DO AddMappedColor
                     FREE(MyQueue)
                  END
               END
            END

            IF ~xml:FindNextNode('RuleSet','MarkPrevious')
               count = xml:LoadQueue(MyQueue,FALSE,FALSE)
               !xml:DebugMyQueue(MyQueue,'MarkPrevious')
               IF count
                  color_groups.color_group = 'Built-in Procedures & Functions'
                  GET(color_groups,+color_groups.color_group)
                  DO AddMappedColor
                  FREE(MyQueue)
               END
            END

            IF ~xml:FindNextNode('RuleSet','Keywords')
               count = xml:LoadQueue(MyQueue,FALSE,TRUE)
               !xml:DebugMyQueue(MyQueue,'Keywords')
               DO ParseBindingResource

            END

            xml:Free()

         END

         SORT(color_groups,+color_groups.color_num)
      END

      loc:ViewerStyles = ColorGroup

      LOOP M = 1 TO 15
         CASE M
         OF 1  !?DefaultTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT + 1]
            color_groups.color_group = 'Normal Text'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT + 1] = loc:StyleGroup

         OF 2  !?LabelTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_LABEL + 1]
            color_groups.color_group = 'Label'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_LABEL + 1] = loc:StyleGroup

         OF 3  !?CommentTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_COMMENT + 1]
            color_groups.color_group = 'Comment'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_COMMENT + 1] = loc:StyleGroup

         OF 4  !?StringTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STRING + 1]
            color_groups.color_group = 'String'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_STRING + 1] = loc:StyleGroup

         OF 5  !?IdentifierTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_USER_IDENTIFIER + 1]
            color_groups.color_group = 'User Identifier'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_USER_IDENTIFIER + 1] = loc:StyleGroup

         OF 6  !?IntegerTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_INTEGER_CONSTANT + 1]
            color_groups.color_group = 'Integer Constant'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_INTEGER_CONSTANT + 1] = loc:StyleGroup

         OF 7  !?RealTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_REAL_CONSTANT + 1]
            color_groups.color_group = 'Real constant'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_REAL_CONSTANT + 1] = loc:StyleGroup

         OF 8  !?PictureTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_PICTURE_STRING + 1]
            color_groups.color_group = 'Picture string'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_PICTURE_STRING + 1] = loc:StyleGroup

         OF 9  !?KeywordTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_KEYWORD + 1]
            color_groups.color_group = 'Clarion Keywords'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_KEYWORD + 1] = loc:StyleGroup

         OF 10 !?CompilerTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_COMPILER_DIRECTIVE + 1]
            color_groups.color_group = 'Compiler Directives'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_COMPILER_DIRECTIVE + 1] = loc:StyleGroup

         OF 11 !?BuiltInTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_BUILTIN_PROCEDURES_FUNCTION + 1]
            color_groups.color_group = 'Built-in Procedures & Functions'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_BUILTIN_PROCEDURES_FUNCTION + 1] = loc:StyleGroup

         OF 12 !?StructureTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STRUCTURE_DATA_TYPE + 1]
            color_groups.color_group = 'Structures and Data types'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_STRUCTURE_DATA_TYPE + 1] = loc:StyleGroup

         OF 13 !?AttributeTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_ATTRIBUTE + 1]
            color_groups.color_group = 'Attributes'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_ATTRIBUTE + 1] = loc:StyleGroup

         OF 14 !?EquateTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STANDARD_EQUATE + 1]
            color_groups.color_group = 'Standard Equates'
            DO SetForeColor
            color_groups.color_group = 'Normal Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_STANDARD_EQUATE + 1] = loc:StyleGroup

         OF 15 !?ErrorTab
            loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_ERROR + 1]
            color_groups.color_group = 'Error Line Text'
            DO SetForeColor
            color_groups.color_group = 'Error Line Background'
            DO SetBackColor
            loc:ViewerStyles.StyleGroup[SCE_CLW_ERROR + 1] = loc:StyleGroup
         END
      END

      ColorGroup = loc:ViewerStyles

      RETURN
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
       ADD(color_groups,+color_groups.color_group)
    END
    NEXT(IniFile)
  END
  EXIT
ProcessColorMap     ROUTINE
  DATA
I   LONG
J   LONG
R   LONG
G   LONG
B   LONG
RGB LONG

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       color_map.color_num      = IniFile.IniRecord.IniBuffer[1 : I-1]
       color_map.color_value    = IniFile.IniRecord.IniBuffer[I+1 : J]
       IF color_map.color_value <> '-1'
          R = 0
          G = 0
          B = 0
          I = INSTRING(',',color_map.color_value)
          IF I
             R = color_map.color_value[1 : I-1]
             J = INSTRING(',',color_map.color_value,1,I+1)
             IF J
                G = color_map.color_value[I+1 : J]
                B = color_map.color_value[J+1 : LEN(CLIP(color_map.color_value))]
             END
          END
          RGB = R + BSHIFT(G,8) + BSHIFT(B,16)
          color_map.color_value = RGB
       END
       ADD(color_map,+color_map.color_num)
    END
    NEXT(IniFile)
  END
  EXIT
ProcessDefaults     ROUTINE
  DATA
I   LONG
J   LONG
R   LONG
G   LONG
B   LONG
RGB LONG

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       default_colors.color_num      = IniFile.IniRecord.IniBuffer[1 : I-1]
       default_colors.color_value    = IniFile.IniRecord.IniBuffer[I+1 : J]
       IF default_colors.color_value <> '-1'
          R = 0
          G = 0
          B = 0
          I = INSTRING(',',default_colors.color_value)
          IF I
             R = default_colors.color_value[1 : I-1]
             J = INSTRING(',',default_colors.color_value,1,I+1)
             IF J
                G = default_colors.color_value[I+1 : J]
                B = default_colors.color_value[J+1 : LEN(CLIP(default_colors.color_value))]
             END
          END
          RGB = R + BSHIFT(G,8) + BSHIFT(B,16)
          default_colors.color_value = RGB
       END
       ADD(default_colors,+default_colors.color_num)
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
         CASE UPPER(MyQueue.Name)
           OF 'HARDRESERVEDKEYWORDS'
              color_groups.color_group = 'Clarion Keywords'
              GET(color_groups,+color_groups.color_group)
              DO AddMappedColor

           OF 'DIRECTIVES'
              color_groups.color_group = 'Compiler Directives'
              GET(color_groups,+color_groups.color_group)
              DO AddMappedColor

           OF 'BASETYPES'
              color_groups.color_group = 'Structures and Data types'
              GET(color_groups,+color_groups.color_group)
              DO AddMappedColor

           OF 'ATTRIBUTES'
              color_groups.color_group = 'Attributes'
              GET(color_groups,+color_groups.color_group)
              DO AddMappedColor

           OF 'BUILTINS'
              color_groups.color_group = 'Standard Equates'
              GET(color_groups,+color_groups.color_group)
              DO AddMappedColor

         END
      END
      EXIT
AddMappedColor    ROUTINE
   DATA
R     LONG
G     LONG
B     LONG
RGB   LONG

   CODE
      color_map.color_num = color_groups.color_num
      color_map.color_value = CLIP(MyQueue.Color)
      IF color_map.color_value[1] <> '#'
         color_map.color_value = srcColorFromName(color_map.color_value)
      END
      R = EVALUATE('0' & color_map.color_value[2 : 3] & 'H')
      G = EVALUATE('0' & color_map.color_value[4 : 5] & 'H')
      B = EVALUATE('0' & color_map.color_value[6 : 7] & 'H')
      RGB = R + BSHIFT(G,8) + BSHIFT(B,16)
      color_map.color_value = RGB
      ADD(color_map,+color_map.color_num)
      EXIT
SetForeColor    ROUTINE
  GET(color_groups,+color_groups.color_group)
  IF LoadDefault = FALSE
     color_map.color_num = color_groups.color_num
     GET(color_map,+color_map.color_num)
     IF ~ERRORCODE()
        IF color_map.color_value = '-1'
           !default_colors.color_num = color_groups.color_num+1
           default_colors.color_num = 1
           GET(default_colors,+default_colors.color_num)
           loc:StyleGroup.Fore = default_colors.color_value
        ELSE
           loc:StyleGroup.Fore = color_map.color_value
        END
     ELSE
        loc:StyleGroup.Fore = COLOR:BLACK
     END
  ELSE
     default_colors.color_num = color_groups.color_num+1
     GET(default_colors,+default_colors.color_num)
     loc:StyleGroup.Fore = default_colors.color_value
  END
  !IF loc:StyleGroup.Fore = -1
  !   loc:StyleGroup.Fore = COLOR:BLACK
  !END
  EXIT
SetBackColor    ROUTINE
  GET(color_groups,+color_groups.color_group)
  IF LoadDefault = FALSE
     color_map.color_num = color_groups.color_num
     GET(color_map,+color_map.color_num)
     IF ~ERRORCODE()
        IF color_map.color_value = '-1'
           !default_colors.color_num = color_groups.color_num+1
           !default_colors.color_num = 2
           !GET(default_colors,+default_colors.color_num)
           !loc:StyleGroup.Back = default_colors.color_value
           loc:StyleGroup.Back = COLOR:WHITE
        ELSE
           loc:StyleGroup.Back = color_map.color_value
        END
     ELSE
        loc:StyleGroup.Back = COLOR:WHITE
     END
  ELSE
     default_colors.color_num = color_groups.color_num+1
     GET(default_colors,+default_colors.color_num)
     loc:StyleGroup.Back = default_colors.color_value
  END
  !IF loc:StyleGroup.Back = -1
  !   loc:StyleGroup.Back = COLOR:WHITE
  !END
  EXIT
