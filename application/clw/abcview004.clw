

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
!!! Refresh the Class Hierarchy Tree
!!! </summary>
srcRefreshTree       PROCEDURE                             ! Declare Procedure
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
I                   LONG
J                   LONG
K                   LONG
lLastLevel          LONG
bContract           BYTE
szLastCallName      LIKE(CallNameQ.szCallName)
loc:sCurrentCursor  STRING(4)
bFirstTime          BYTE(1),STATIC

  CODE
  IF bFirstTime
     bFirstTime = FALSE
     RETURN
  END
  loc:sCurrentCursor = glo:sCurrentCursor
  glo:sCurrentCursor = CURSOR:WAIT
  SETCURSOR(glo:sCurrentCursor)

  SORT(ClassQ,+ClassQ.szParentClassSort,+ClassQ.szClassSort)
  szClassSort = 'SORT(ClassQ,+ClassQ.szParentClassSort,+ClassQ.szClassSort)'
  SORT(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
  SORT(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
  SORT(StructureQ,+StructureQ.szStructureSort,+StructureQ.lModuleId,+StructureQ.lLineNum)
  !SORT(EnumQ,+EnumQ.szEnumSort,+EnumQ.lModuleId,+EnumQ.szEnumLabel)   !+EnumQ.lLineNum)
  SORT(EnumQ,+EnumQ.lModuleId,+EnumQ.szEnumSort,+EnumQ.szEnumLabel)   !+EnumQ.lLineNum)
  SORT(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
  FREE(TreeQ)
  DISPLAY()

  CASE glo:bCurrentView
    OF VIEW:CLASSES OROF VIEW:INTERFACES
       J = RECORDS(ClassQ)
       ClassQ.szParentClassSort = ''
       ClassQ.szClassSort = UPPER(glo:szParentClassName)
       GET(ClassQ,+ClassQ.szParentClassSort,+ClassQ.szClassSort)
       IF ERRORCODE()
          I = 1
       ELSE
          I = POINTER(ClassQ)
       END
       LOOP I = I TO J
         GET(ClassQ,I)
         !*** temporary bug fix
         IF ~ClassQ.szClassName
            CYCLE
         END
         !***
         !should have found the parent record ---------------------------------
         IF ClassQ.szClassSort <> UPPER(glo:szParentClassName)
            BREAK
         END
         !---------------------------------------------------------------------
         IF ClassQ.szParentClassName     !If Derived Class
            BREAK
         ELSE                            !Else Add Base Classes
            CategoryQ.szClassName = ClassQ.szClassName
            GET(CategoryQ,+CategoryQ.szClassName)
            IF ClassQ.bPrivate = TRUE AND glo:bShowPrivate = FALSE
               CYCLE
            ELSIF glo:bCurrentView = VIEW:CLASSES AND ClassQ.bInterface = TRUE
               CYCLE
            ELSIF glo:bCurrentView = VIEW:INTERFACES AND ClassQ.bInterface = FALSE
               CYCLE
            ELSIF glo:bCurrentView = VIEW:CLASSES AND CategoryQ:bDetailLevel > glo:bDetailLevel
               CYCLE
            ELSIF glo:bCurrentView = VIEW:CLASSES AND glo:szParentClassName AND |
                  ClassQ.szClassSort <> UPPER(glo:szParentClassName)
               CYCLE
            ELSIF glo:bCurrentView = VIEW:INTERFACES AND glo:szParentClassName AND |
                  ClassQ.szClassSort <> UPPER(glo:szParentClassName)
               CYCLE
            ELSE
               CASE glo:bABCOnly
               OF 1  !abc
                  IF ~ClassQ.bIsABC
                     CYCLE
                  END
               OF 2  !non-abc
                  IF ClassQ.bIsABC
                     CYCLE
                  END
               END
               TreeQ.szText = ClassQ.szClassName
               TreeQ.lLevel = 1
               TreeQ.lStyle = CHOOSE(ClassQ.bPrivate = FALSE,STYLE:NORMAL,STYLE:PRIVATE)
               OldClassQ.szClassName = ClassQ.szClassName
               GET(OldClassQ,+OldClassQ.szClassName)
               IF ERRORCODE()
                  TreeQ.lStyle = CHOOSE(ClassQ.bPrivate = FALSE,STYLE:NORMAL_NEW,STYLE:PRIVATE_NEW)
                  TreeQ.wIcon  = CHOOSE(ClassQ.bInterface = FALSE,ICON:NEWCLASS,ICON:NEWINTERFACEFOLDER)
               ELSE
                  TreeQ.lStyle = CHOOSE(ClassQ.bPrivate = FALSE,STYLE:NORMAL,STYLE:PRIVATE)
                  TreeQ.wIcon  = CHOOSE(ClassQ.bInterface = FALSE,ICON:CLASS,ICON:INTERFACEFOLDER)
               END
               TreeQ.szSearch = ClassQ.szClassName
               TreeQ.szClassName = ClassQ.szClassName
               IF ClassQ.bIsABC
                  IF SUB(ClassQ.szClassName,-5,5) = 'Class'
                     TreeQ.szContextString = ClassQ.szClassName
                  ELSE
                     TreeQ.szContextString = ClassQ.szClassName & 'Class'
                  END
                  CASE glo:bClarionVersion
                    OF CWVERSION_C2
                       TreeQ.szHelpFile = szRoot & '\bin\CW20help.hlp'
                    OF CWVERSION_C4
                       TreeQ.szHelpFile = szRoot & '\bin\C4help.hlp'
                    OF CWVERSION_C5 OROF CWVERSION_C5EE
                       TreeQ.szHelpFile = szRoot & '\bin\C5help.hlp'
                    OF CWVERSION_C55 OROF CWVERSION_C55EE
                       TreeQ.szHelpFile = szRoot & '\bin\C55help.hlp'
                    OF CWVERSION_C60 OROF CWVERSION_C60EE
                       TreeQ.szHelpFile = szRoot & '\bin\C60help.hlp'
                    OF CWVERSION_C70 OROF CWVERSION_C80 OROF CWVERSION_C90 OROF CWVERSION_C100
                       TreeQ.szHelpFile = szRoot & '\bin\ClarionHelp.chm'
                  ELSE
                       TreeQ.szHelpFile = ''
                  END
               ELSE
                  TreeQ.szContextString = ClassQ.szClassName
                  TreeQ.szHelpFile = ''
               END
               TreeQ.lLineNum = ClassQ:lLineNum
               TreeQ.lSourceLine = 0
               TreeQ.lIncludeId = ClassQ.lIncludeId
               TreeQ.lModuleId  = ClassQ.lModuleId

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
                  TreeQ.szNoteTip = NoteQ:szNote
                  srcWordWrap(TreeQ.szNoteTip,64)
               END
               DO SetTipText

               ADD(TreeQ)
               K = TreeQ.lLevel
               srcAddProperties(K)
               srcAddMethods(K)
               srcAddInterfaces(K)
               srcAddDerivedClass(ClassQ.szClassName,K)
            END
         END
       END
    OF VIEW:STRUCTURES
       srcAddStructures()
    OF VIEW:EQUATES
       srcAddEquates()
    OF VIEW:CALLS
       IF RECORDS(MethodQ)
          J = RECORDS(CallNameQ)
          IF J
             K = POINTER(CallNameQ)
             LOOP I = 1 TO J
               GET(CallNameQ,I)
               CallNameQ.bExpandedAbove = FALSE
               PUT(CallNameQ)
             END
             LOOP I = K TO J
                GET(CallNameQ,I)
                IF INSTRING('.',CallNameQ.szCallName)
                   BREAK
                END
             END
          ELSE
             CallNameQ.szCallName = 'WindowManager.Run'
          END
          SORT(ClassQ,+ClassQ.szClassSort)

          szLastCallName = CallNameQ.szCallName
          srcAddCalls('',CallNameQ.szCallName,1)
          CallNameQ.szCallName = szLastCallName
          GET(CallNameQ,+CallNameQ.szCallName)
       END
  END

  SORT(ClassQ,+ClassQ.szClassSort)
  SORT(StructureQ,+StructureQ.szStructureName,+StructureQ.szDataLabel)
  SORT(EnumQ,+EnumQ.szEnumName,+EnumQ.szEnumLabel)

  DO ContractTree
  GET(TreeQ,1)

  glo:sCurrentCursor = loc:sCurrentCursor
  SETCURSOR(glo:sCurrentCursor)

  omit('end_omit')
  IF ERRORCODE()
     CASE glo:bCurrentView
     OF VIEW:CLASSES
        MESSAGE('Nothing to display for this category/detail level.|Try using a different category or a higher detail level.','Class Viewer Hint')
     OF VIEW:INTERFACES
        MESSAGE('No Interfaces to display','Class Viewer')
     OF VIEW:STRUCTURES
        MESSAGE('No Structures to display','Class Viewer')
     OF VIEW:EQUATES
        MESSAGE('No Equates to display','Class Viewer')
     OF VIEW:CALLS
        MESSAGE('Nothing to display for ' & CallNameQ.szCallName & '|Try setting the Protected or Private attribute checkboxes.','Class Viewer Hint')
     ELSE
     END
  END
  !end_omit

  RETURN
ContractTree    ROUTINE
  DATA
ABS:TreeQ:lLevel    LIKE(TreeQ.lLevel)
  CODE
  J = RECORDS(TreeQ)
  GET(TreeQ,J)
  lLastLevel = ABS(TreeQ.lLevel)
  LOOP I = J TO 1 BY -1
    GET(TreeQ,I)
    ABS:TreeQ:lLevel = ABS(TreeQ.lLevel)
    IF ABS:TreeQ:lLevel > lLastLevel
       lLastLevel = ABS:TreeQ:lLevel
       TreeQ.lLevel = ABS:TreeQ:lLevel
    ELSIF ABS:TreeQ:lLevel < lLastLevel
       lLastLevel = ABS:TreeQ:lLevel
       TreeQ.lLevel = -1 * ABS:TreeQ:lLevel
    ELSE
       TreeQ.lLevel = ABS:TreeQ:lLevel
    END
    PUT(TreeQ)
  END
  EXIT
SetTipText  ROUTINE
  DATA
S           STRING(256)
X           LONG

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
