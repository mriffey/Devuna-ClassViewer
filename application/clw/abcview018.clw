

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
!!! Add Itemized Equates to Tree
!!! </summary>
srcAddEquates        PROCEDURE                             ! Declare Procedure
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
I               LONG
J               LONG
K               LONG
ulValue         ULONG
szLastEnum      CSTRING(64)
lLastModuleId   LONG
tmpTreeQ        QUEUE,PRE(Q)
sNote                STRING(1)
wNoteIcon            SHORT
szNoteTip            CSTRING(256)
szText               CSTRING(384)
wIcon                SHORT
lLevel               LONG
lStyle               LONG
szTipText            CSTRING(256)
szSearch             CSTRING(64)
szClassName          CSTRING(64)
szContextString      CSTRING(256)
szHelpFile           CSTRING(256)
lLineNum             LONG
lSourceLine          LONG
lIncludeId           LONG
lModuleId            LONG
lOccurranceLine      LONG
szPrototype          CSTRING(256)
szSort               CSTRING(256)
                END
sav:TreeQ:lLineNum      LIKE(TreeQ:lLineNum)
sav:TreeQ:lIncludeId    LIKE(TreeQ:lIncludeId)

  CODE
  szLastEnum = ''
  lLastModuleId = 0
  J = RECORDS(EnumQ)
  LOOP I = 1 TO J
    GET(EnumQ,I)
    IF ERRORCODE()
       BREAK
    ELSE
       IF ~glo:szParentClassName
          glo:szParentClassName = EnumQ.szEnumName
       END
       IF UPPER(EnumQ.szEnumName) <> UPPER(glo:szParentClassName)
          CYCLE
       END
       IF EnumQ.szEnumName <> szLastEnum
          szLastEnum = EnumQ.szEnumName
          lLastModuleId = EnumQ.lModuleId
          TreeQ.lLevel = 1
          IF EnumQ.bIsEquate = TRUE
             TreeQ.wIcon  = ICON:EQUATEFOLDER
          ELSE
             TreeQ.wIcon  = ICON:ENUMFOLDER
          END
          TreeQ.szText = EnumQ.szEnumName
          IF szLastEnum = '*EQUATES*'
             DO AddTreeQ
             TreeQ.lLevel = 3
             TreeQ.wIcon  = ICON:EQUATE
             IF EnumQ.bIsHexValue
                DO HexFormat
             END
             TreeQ.szText = EnumQ.szEnumLabel & ' = ' & EnumQ.szEnumValue
          ELSE
             IF INSTRING(':',EnumQ.szEnumLabel)
                DO AddTreeQ
                TreeQ.lLevel = 2
                TreeQ.wIcon  = ICON:EQUATE
                IF EnumQ.bIsHexValue
                   DO HexFormat
                END
                TreeQ.szText = EnumQ.szEnumLabel & ' = ' & EnumQ.szEnumValue
             END
          END
       ELSIF EnumQ.lModuleId <> lLastModuleId
          lLastModuleId = EnumQ.lModuleId
          IF szLastEnum = '*EQUATES*'
             TreeQ.lLevel = 3
             TreeQ.wIcon  = ICON:EQUATE
             IF EnumQ.bIsHexValue
                DO HexFormat
             END
             TreeQ.szText = EnumQ.szEnumLabel & ' = ' & EnumQ.szEnumValue
          ELSE
             TreeQ.lLevel = 1
             IF EnumQ.bIsEquate = TRUE
                TreeQ.wIcon  = ICON:EQUATEFOLDER
             ELSE
                TreeQ.wIcon  = ICON:ENUMFOLDER
             END
             TreeQ.szText = EnumQ.szEnumName

             IF INSTRING(':',EnumQ.szEnumLabel)
                DO AddTreeQ
                TreeQ.lLevel = 2
                TreeQ.wIcon  = ICON:EQUATE
                IF EnumQ.bIsHexValue
                   DO HexFormat
                END
                TreeQ.szText = EnumQ.szEnumLabel & ' = ' & EnumQ.szEnumValue
             END

          END
       ELSE
          TreeQ.lLevel = CHOOSE(szLastEnum = '*EQUATES*',3,2)
          TreeQ.wIcon  = ICON:EQUATE
          IF EnumQ.bIsHexValue
             DO HexFormat
          END
          TreeQ.szText = EnumQ.szEnumLabel & ' = ' & EnumQ.szEnumValue
       END
       DO AddTreeQ
    END
  END

  GET(TreeQ,1)
  K = 1
  szLastEnum = ''
  lLastModuleId = 0
  SORT(tmpTreeQ,+tmpTreeQ.szSort)
  J = RECORDS(tmpTreeQ)
  LOOP I = 1 TO J
    GET(tmpTreeQ,I)
    IF tmpTreeQ.szSort[1 : 1] <> szLastEnum
       szLastEnum = tmpTreeQ.szSort[1 : 1]
       TreeQ.lLevel = 2
       TreeQ.wIcon  = ICON:EQUATEFOLDER
       TreeQ.szText = szLastEnum
       K += 1
       DO SetNoteIcon
       DO SetTipText
       ADD(TreeQ,K)
       TreeQ = tmpTreeQ
       K += 1
       DO SetNoteIcon
       DO SetTipText
       ADD(TreeQ,K)
    ELSE
       TreeQ = tmpTreeQ
       K += 1
       ADD(TreeQ,K)
    END
  END

  IF glo:bEnumSort = 1  !canonical
     GET(TreeQ,1)
     IF TreeQ:szText <> '*EQUATES*'
        SORT(TreeQ,+TreeQ:lModuleId,+TreeQ:lLevel,+TreeQ:lLineNum)
        GET(TreeQ,2)
        sav:TreeQ:lLineNum = TreeQ:lLineNum
        sav:TreeQ:lIncludeId = TreeQ:lIncludeId
        GET(TreeQ,1)
        TreeQ:lLineNum = sav:TreeQ:lLineNum
        TreeQ:lIncludeId = sav:TreeQ:lIncludeId
        PUT(TreeQ)
     END
  END

HexFormat   ROUTINE
  CASE EnumQ.bIsHexValue
  OF 1  !Hex Value
     ulValue = EnumQ.szEnumValue
     ultoa(ulValue,EnumQ.szEnumValue,16)
     IF LEN(EnumQ.szEnumValue) % 2
        EnumQ.szEnumValue = '0' & EnumQ.szEnumValue
     END
     EnumQ.szEnumValue = '0' & UPPER(EnumQ.szEnumValue) & 'H'
  OF 2  !Binary Value
     ulValue = EnumQ.szEnumValue
     ultoa(ulValue,EnumQ.szEnumValue,2)
     IF LEN(EnumQ.szEnumValue) % 2
        EnumQ.szEnumValue = '0' & EnumQ.szEnumValue
     END
     EnumQ.szEnumValue = '0' & UPPER(EnumQ.szEnumValue) & 'B'
  END

AddTreeQ    ROUTINE
  IF ~(glo:bShowPrivate = FALSE AND EnumQ.bPrivate = TRUE)
     TreeQ.lStyle = CHOOSE(EnumQ.bPrivate = FALSE,STYLE:NORMAL,STYLE:PRIVATE)
     TreeQ.szSearch = ''
     TreeQ.szClassName = EnumQ.szEnumName
     TreeQ.szContextString = EnumQ.szEnumLabel
     TreeQ.szHelpFile = ''
     TreeQ.lLineNum = EnumQ.lLineNum
     TreeQ.lSourceLine = 0
     TreeQ.lIncludeId = 0
     TreeQ.lModuleId  = EnumQ.lModuleId
     DO SetNoteIcon
     DO SetTipText
     IF szLastEnum = '*EQUATES*' AND TreeQ.lLevel > 1
        tmpTreeQ = TreeQ
        tmpTreeQ.szSort = UPPER(TreeQ.szText)
        ADD(TmpTreeQ)
     ELSE
        ADD(TreeQ)
     END
  END
  EXIT
SetNoteIcon ROUTINE
  NoteQ.bClarionVersion = glo:bClarionVersion
  IF TreeQ.szContextString
     NoteQ.szLookup = UPPER(TreeQ.szContextString)
  ELSE
     NoteQ.szLookup = UPPER(TreeQ.szText)
  END
  GET(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
  IF ERRORCODE()
     TreeQ.wNoteIcon = 0
     TreeQ.szNoteTip = ''
  ELSE
     TreeQ.wNoteIcon = ICON:NOTE
     TreeQ.szNoteTip = NoteQ.szNote
     srcWordWrap(TreeQ.szNoteTip,64)
  END
  EXIT
SetTipText  ROUTINE
  DATA
S   STRING(256)
X   LONG

  CODE
  CASE TreeQ:wIcon
    OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
       ModuleQ.lModuleId = TreeQ.lModuleId
       GET(ModuleQ,ModuleQ.lModuleId)
       IF ERRORCODE()
          ModuleQ:szModulePath = '**UNDEFINED**'
          ModuleQ:szModuleName = ''
       END
       TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
       DO AddCommentsToTip
    OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
       ModuleQ.lModuleId = TreeQ.lModuleId
       GET(ModuleQ,ModuleQ.lModuleId)
       IF ERRORCODE()
          ModuleQ:szModulePath = '**UNDEFINED**'
          ModuleQ:szModuleName = ''
       END
       TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
       DO AddCommentsToTip
    OF ICON:METHOD
       CASE glo:bCurrentView
         OF VIEW:CLASSES OROF VIEW:CALLS
            S = TreeQ.szSearch[LEN(ClassQ.szClassName)+2 : LEN(TreeQ.szSearch)]
            X = INSTRING('.',S)
            IF X
               ClassQ.szClassSort = UPPER(S[X : X-1])
               GET(ClassQ,+ClassQ.szClassSort)
               ModuleQ.lModuleId = ClassQ.lIncludeId
               GET(ModuleQ,ModuleQ.lModuleId)
               IF ERRORCODE()
                  ModuleQ:szModulePath = '**UNDEFINED**'
                  ModuleQ:szModuleName = ''
               END
               TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
               DO AddCommentsToTip
            ELSE
               ModuleQ.lModuleId = TreeQ.lIncludeId
               GET(ModuleQ,ModuleQ.lModuleId)
               IF ERRORCODE()
                  ModuleQ:szModulePath = '**UNDEFINED**'
                  ModuleQ:szModuleName = ''
               END
               TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
               DO AddCommentsToTip
            END
            IF TreeQ.lModuleId <> 0                   |
            AND TreeQ.lSourceLine
               ModuleQ.lModuleId = TreeQ.lModuleId
               GET(ModuleQ,ModuleQ.lModuleId)
               IF ERRORCODE()
                  ModuleQ:szModulePath = '**UNDEFINED**'
                  ModuleQ:szModuleName = ''
               END
               TreeQ.szTipText = TreeQ.szTipText & '<13,10>' & CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lSourceLine & ']'
               DO AddSourceCommentsToTip
            END
       ELSE
          ModuleQ.lModuleId = TreeQ.lIncludeId
          GET(ModuleQ,ModuleQ.lModuleId)
          IF ERRORCODE()
             ModuleQ:szModulePath = '**UNDEFINED**'
             ModuleQ:szModuleName = ''
          END
          TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
          DO AddCommentsToTip
       END
    OF ICON:INTERFACEFOLDER OROF ICON:NEWINTERFACEFOLDER
       CASE glo:bCurrentView
         OF VIEW:CLASSES
            ClassQ.szClassSort = UPPER(TreeQ.szText)
            GET(ClassQ,+ClassQ.szClassSort)
            ModuleQ.lModuleId = ClassQ.lIncludeId
            GET(ModuleQ,ModuleQ.lModuleId)
            IF ERRORCODE()
               ModuleQ:szModulePath = '**UNDEFINED**'
               ModuleQ:szModuleName = ''
            END
            TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
            DO AddCommentsToTip
       ELSE
            ModuleQ.lModuleId = TreeQ.lIncludeId
            GET(ModuleQ,ModuleQ.lModuleId)
            IF ERRORCODE()
               ModuleQ:szModulePath = '**UNDEFINED**'
               ModuleQ:szModuleName = ''
            END
            TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
            DO AddCommentsToTip
       END
  ELSE
       ModuleQ.lModuleId = TreeQ.lIncludeId
       GET(ModuleQ,ModuleQ.lModuleId)
       IF ERRORCODE()
          ModuleQ:szModulePath = '**UNDEFINED**'
          ModuleQ:szModuleName = ''
       END
       TreeQ.szTipText = CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName) & ' [' & TreeQ.lLineNum & ']'
       DO AddCommentsToTip
  END
  EXIT

AddCommentsToTip    ROUTINE
  TreeQ.szTipText = TreeQ.szTipText & '<13,10>' & srcGetLineComments(CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName),TreeQ.lLineNum)
  IF SUB(TreeQ.szTipText,-2,2) = '<13,10>'
     TreeQ.szTipText = SUB(TreeQ.szTipText,1,LEN(TreeQ.szTipText)-2)
  END
  EXIT

AddSourceCommentsToTip    ROUTINE
  TreeQ.szTipText = TreeQ.szTipText & '<13,10>' & srcGetLineComments(CLIP(ModuleQ:szModulePath) & CLIP(ModuleQ:szModuleName),TreeQ.lSourceLine)
  IF SUB(TreeQ.szTipText,-2,2) = '<13,10>'
     TreeQ.szTipText = SUB(TreeQ.szTipText,1,LEN(TreeQ.szTipText)-2)
  END
  EXIT
