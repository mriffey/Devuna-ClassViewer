

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
!!! Add Class Methods to Tree
!!! </summary>
srcAddMethods        PROCEDURE  (lTreeLevel)               ! Declare Procedure
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
szInterfaceName CSTRING(64)

  CODE
  SORT(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
  J = RECORDS(MethodQ)
  LOOP I = 1 TO J
     GET(MethodQ,I)
     IF MethodQ.lClassID < ClassQ.lClassID
        CYCLE
     ELSIF MethodQ.lClassID > ClassQ.lClassID
        BREAK
     ELSE
        !Add Methods Folder
        IF glo:bCurrentView <> VIEW:INTERFACES
           TreeQ.szText = 'Methods'
           TreeQ.wIcon  = ICON:METHODFOLDER
           TreeQ.lLevel = lTreeLevel+1
           TreeQ.lStyle = STYLE:NORMAL
           TreeQ.szSearch = ''
           TreeQ.szClassName = ClassQ.szClassName
           TreeQ.szContextString = ''
           TreeQ.lLineNum = ClassQ.lLineNum
           TreeQ.lSourceLine = 0
           TreeQ.lIncludeId = ClassQ.lIncludeId
           TreeQ.lModuleId  = ClassQ.lModuleId
           DO SetNoteIcon
           DO SetTipText
           ADD(TreeQ)
        END
        !Look For Interface Name
        DO LookForInterface
        IF ~szInterfaceName
           !Add Current Method
           DO AddMethod
           I = POINTER(MethodQ) + 1
           J = RECORDS(MethodQ)
           LOOP I = I TO J
             GET(MethodQ,I)
             IF ERRORCODE() OR MethodQ.lClassID <> ClassQ.lClassID
                BREAK
             ELSE
                DO LookForInterface
                IF ~szInterfaceName
                   DO AddMethod
                END
             END
           END
        ELSE
           DELETE(TreeQ)
        END
        !BREAK
     END
  END

LookForInterface    ROUTINE
  K = INSTRING('.',MethodQ.szMethodName)
  IF K   !Add Interface Folder
     IF szInterfaceName <> MethodQ.szMethodName[1 : K-1]
        szInterfaceName = MethodQ.szMethodName[1 : K-1]
        !DO AddInterfaceFolder
     END
  ELSE
     szInterfaceName = ''
  END
  EXIT

AddInterfaceFolder  ROUTINE
  TreeQ.szText = szInterfaceName
  TreeQ.wIcon  = ICON:INTERFACEFOLDER
  TreeQ.lLevel = lTreeLevel+2
  TreeQ.lStyle = STYLE:NORMAL
  TreeQ.szSearch = ClassQ.szClassName & '.' & szInterfaceName
  TreeQ.szClassName = ClassQ.szClassName
  IF ClassQ.bIsABC
     IF SUB(ClassQ.szClassName,-5,5) = 'Class'
        TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName
     ELSE
        TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName & 'Class'
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
     TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName
     TreeQ.szHelpFile = ''
  END
  TreeQ.lLineNum = ClassQ.lLineNum
  TreeQ.lSourceLine = 0
  TreeQ.lIncludeId = ClassQ.lIncludeId
  TreeQ.lModuleId  = ClassQ.lModuleId
  IF ClassQ.bPrivate
     TreeQ.szContextString = ''
     TreeQ.szHelpFile = ''
     IF glo:bShowPrivate
        DO SetNoteIcon
        DO SetTipText
        ADD(TreeQ)
     END
  ELSE
     DO SetNoteIcon
     DO SetTipText
     ADD(TreeQ)
  END
  EXIT

AddMethod   ROUTINE
  TreeQ.szText = MethodQ.szMethodName & ' ' & MethodQ.szPrototype
  TreeQ.lLevel = CHOOSE(glo:bCurrentView <> VIEW:INTERFACES,lTreeLevel+2,lTreeLevel+1)
  TreeQ.wIcon  = ICON:METHOD
  TreeQ.lStyle = CHOOSE(MethodQ.bPrivate,STYLE:PRIVATE,STYLE:NORMAL)
  TreeQ.lStyle = CHOOSE(MethodQ.bProtected,STYLE:PROTECTED,TreeQ.lStyle)
  TreeQ.lStyle = CHOOSE(MethodQ.bModule,STYLE:MODULE,TreeQ.lStyle)
  IF glo:bCurrentView = VIEW:INTERFACES OR szInterfaceName <> ''
     TreeQ.lStyle = STYLE:VIRTUAL
  ELSE
     TreeQ.lStyle = CHOOSE(MethodQ.bVirtual,STYLE:VIRTUAL,TreeQ.lStyle)
  END
  TreeQ.szSearch = ClassQ.szClassName & '.' & MethodQ.szMethodName
  IF ClassQ.bIsABC
     IF SUB(ClassQ.szClassName,-5,5) = 'Class'
        TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName
     ELSE
        TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName & 'Class'
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
     TreeQ.szContextString = MethodQ.szMethodName & ':' & ClassQ.szClassName
     TreeQ.szHelpFile = ''
  END
  TreeQ.lLineNum = MethodQ.lLineNum
  TreeQ.lSourceLine = MethodQ:lSourceLine
  IF MethodQ.bModule
     TreeQ.lIncludeId = ClassQ.lModuleId
  ELSE
     TreeQ.lIncludeId = ClassQ.lIncludeId
  END
  TreeQ.lModuleId  = ClassQ.lModuleId
  IF MethodQ.bPrivate OR MethodQ.bModule
     TreeQ.szContextString = ''
     TreeQ.szHelpFile = ''
     IF glo:bShowPrivate
        IF MethodQ.bModule
           IF glo:bShowModule
              DO SetNoteIcon
              DO SetTipText
              ADD(TreeQ)
           END
        ELSE
           DO SetNoteIcon
           DO SetTipText
           ADD(TreeQ)
        END
     END
  ELSIF MethodQ.bProtected
     IF glo:bShowProtected
        DO SetNoteIcon
        DO SetTipText
        ADD(TreeQ)
     END
  ELSE
     DO SetNoteIcon
     DO SetTipText
     ADD(TreeQ)
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
