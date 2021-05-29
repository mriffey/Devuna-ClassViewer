

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
!!! Add Derived Class to Tree
!!! </summary>
srcAddDerivedClass   PROCEDURE  (sParentClass,  lTreeLevel) ! Declare Procedure
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
lPosition       LONG
I               LONG
J               LONG
K               LONG
M               LONG
N               LONG
P               LONG
Q               LONG

  CODE
  !save our position
  lPosition = POSITION(ClassQ)

  ClassQ.szParentClassSort = UPPER(sParentClass)
  GET(ClassQ,+ClassQ.szParentClassSort)

  IF ~ERRORCODE()
     I = POINTER(ClassQ)
     J = RECORDS(ClassQ)
     LOOP I = I TO J
       GET(ClassQ,I)
       IF ERRORCODE() OR ClassQ.szParentClassSort <> UPPER(sParentClass)
          BREAK
       ELSE
          !see  if it is in the class hierarchy
          Q = RECORDS(ClassHierarchyQueue)
          IF Q
             LOOP P = 1 TO Q
                GET(ClassHierarchyQueue,P)
                IF ClassHierarchyQueue.szClassName = ClassQ.szClassName
                   DO AddClassToTree
                   BREAK
                END
             END
          ELSE
             DO AddClassToTree
          END
       END
     END
  END

  !restore saved position
  GET(ClassQ,lPosition)

  RETURN
AddClassToTree  ROUTINE
  CategoryQ.szClassName = ClassQ.szClassName
  GET(CategoryQ,+CategoryQ.szClassName)
  IF ClassQ.bPrivate = TRUE AND glo:bShowPrivate = FALSE
     !Do not add to tree and return
  ELSIF CategoryQ:bDetailLevel > glo:bDetailLevel
     !Do not add to tree and return
  !ELSIF glo:bABCOnly = 1 AND ~ClassQ.bIsABC
     !Do not add to tree and return
  !ELSIF glo:bABCOnly = 2 AND ClassQ.bIsABC
     !Do not add to tree and return
  ELSE
     TreeQ.szText = ClassQ.szClassName & '(' & ClassQ.szParentClassName & ')'
     TreeQ.lLevel = lTreeLevel+1
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
     TreeQ.lLineNum = ClassQ.lLineNum
     TreeQ.lSourceLine = 0
     TreeQ.lIncludeId = ClassQ.lIncludeId
     TreeQ.lModuleId  = ClassQ.lModuleId
     DO SetNoteIcon
     DO SetTipText
     ADD(TreeQ)
     K = TreeQ.lLevel  !K is parent level
     srcAddProperties(K)
     srcAddMethods(K)
     srcAddInterfaces(K)
     srcAddDerivedClass(ClassQ.szClassName,K)
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
