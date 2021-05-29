

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
!!! Add Method Calls to Tree
!!! </summary>
srcAddCalls          PROCEDURE  (szTreeName,szCallingMethod, lTreeLevel) ! Declare Procedure
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
bExpanded       BYTE
bUpdate         BYTE
lStructureQRecords  LONG
lStructureQPointer  LONG
bExtends        BYTE
bFinal          BYTE

  CODE
  IF szTreeName = szCallingMethod
     RETURN
  END

  I = INSTRING('.',szCallingMethod)
 ASSERT(I > 0)
  ClassQ.szClassSort = UPPER(SUB(szCallingMethod,1,I-1))
  GET(ClassQ,+ClassQ.szClassSort)
  IF ~ERRORCODE()
     MethodQ.lClassID = ClassQ.lClassID
     MethodQ.szMethodSort = UPPER(szCallingMethod[I+1 : LEN(szCallingMethod)])
     GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
    ASSERT(~ERRORCODE())
  ELSE
     ClassQ.lClassID = 0
     MethodQ.szPrototype = ''
     StructureQ.szStructureSort = UPPER(SUB(szCallingMethod,1,I-1))
     GET(StructureQ,+StructureQ.szStructureSort)
    ASSERT(~ERRORCODE())
     ClassQ.szClassName = SUB(szCallingMethod,1,I-1)
     lStructureQRecords = RECORDS(StructureQ)
     lStructureQPointer = POINTER(StructureQ)
     LOOP lStructureQPointer = lStructureQPointer TO lStructureQRecords
       GET(StructureQ,lStructureQPointer)
       IF StructureQ.szStructureSort = UPPER(SUB(szCallingMethod,1,I-1))
          IF UPPER(StructureQ.szDataLabel) = UPPER(szCallingMethod[I+1 : LEN(szCallingMethod)])
             MethodQ.bPrivate = CHOOSE(INSTRING('PRIVATE',UPPER(StructureQ.szDataType))>0,1,0)
             MethodQ.bProtected = CHOOSE(INSTRING('PROTECTED',UPPER(StructureQ.szDataType))>0,1,0)
             MethodQ.bVirtual = CHOOSE(INSTRING('VIRTUAL',UPPER(StructureQ.szDataType))>0,1,0)
             MethodQ.szMethodName = StructureQ.szDataLabel
             MethodQ.lLineNum = StructureQ.lLineNum
             MethodQ.lSourceLine = StructureQ.lLineNum
             !Begin 2004.12.14 -----------------------------------------------
             MethodQ.bExtends = 0       !bExtends
             MethodQ.bFinal = 0         !bFinal
             MethodQ.bProc = 0          !CHOOSE(INSTRING(',PROC',szUpper,1))
             MethodQ.szDLL = ''         !srcGetPrototypeAttr('DLL',SourceFile.Record.sText)
             MethodQ.szExtName = ''     !srcGetPrototypeAttr('NAME',SourceFile.Record.sText)
             MethodQ.szCallConv = ''    !srcGetPrototypeAttr('CALLCONV',SourceFile.Record.sText)
             MethodQ.szReturnType = ''  !srcGetPrototypeAttr('RETURN',SourceFile.Record.sText)
             !End   2004.12.14 -----------------------------------------------
             !
             BREAK
          END
       ELSE
         ASSERT(TRUE = FALSE)
          BREAK
       END
     END
  END
  CallNameQ.szCallName = szCallingMethod
  CallNameQ.szSortName = UPPER(szCallingMethod)
  GET(CallNameQ,+CallNameQ.szSortName)
  IF ERRORCODE()
     bExpanded = FALSE
     bUpdate = FALSE
  ELSE
     bExpanded = CallNameQ.bExpandedAbove
     bUpdate = TRUE
  END

  IF szCallingMethod[1 : I-1] = szTreeName
     TreeQ.szText = szCallingMethod[I+1 : LEN(szCallingMethod)]
  ELSE
     TreeQ.szText = szCallingMethod
  END

  IF bExpanded = TRUE
     TreeQ.szText = TreeQ.szText & ' (Expanded Above)'
  END

  TreeQ.wNoteIcon = ICON:NOTE
  TreeQ.wIcon  = CHOOSE(ClassQ.lModuleId = 0,ICON:INTERFACEFOLDER,ICON:METHOD)
  TreeQ.lLevel = lTreeLevel
  TreeQ.lStyle = CHOOSE(MethodQ.bPrivate,STYLE:PRIVATE,STYLE:NORMAL)
  TreeQ.lStyle = CHOOSE(MethodQ.bProtected,STYLE:PROTECTED,TreeQ.lStyle)
  TreeQ.lStyle = CHOOSE(MethodQ.bModule,STYLE:MODULE,TreeQ.lStyle)
  IF TreeQ.wIcon  = ICON:INTERFACEFOLDER
     TreeQ.lStyle = STYLE:VIRTUAL
  ELSE
     TreeQ.lStyle = CHOOSE(MethodQ.bVirtual,STYLE:VIRTUAL,TreeQ.lStyle)
  END
  TreeQ.szSearch = szCallingMethod
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
  TreeQ.lLineNum = MethodQ.lLineNum
  TreeQ.lSourceLine = MethodQ:lSourceLine
  TreeQ.lIncludeId = ClassQ.lIncludeId
  TreeQ.lModuleId = ClassQ.lModuleId
  TreeQ.lOccurranceLine = CallQ.lLineNum
  TreeQ.szPrototype = MethodQ.szPrototype
  IF MethodQ.bPrivate
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

  IF bExpanded = FALSE AND bUpdate = TRUE
     CallNameQ.bExpandedAbove = TRUE
     PUT(CallNameQ)
     J = RECORDS(CallQ)
     CallQ.szCallingMethod = szCallingMethod
     GET(CallQ,+CallQ.szCallingMethod)
     X" = TreeQ.szClassName
     IF ~ERRORCODE()
        I = POINTER(CallQ)
        LOOP I = I TO J
          GET(CallQ,I)
          IF ERRORCODE() OR CallQ.szCallingMethod <> szCallingMethod
             BREAK
          ELSE
             srcAddCalls(X",CallQ.szCalledMethod,lTreeLevel+1)
          END
        END
     END
  END
  RETURN
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
