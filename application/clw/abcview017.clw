

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
!!! Add Class Structures to Tree
!!! </summary>
srcAddStructures     PROCEDURE                             ! Declare Procedure
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
szLastStructure CSTRING(64)
lLastModuleId   LONG
szObjectName    CSTRING(61)
lObjectId       LONG
szParentStruct  CSTRING(64)

  CODE
  szLastStructure = ''
  szParentStruct = ''
  IF glo:szParentClassName
     StructureQ.szStructureSort = UPPER(glo:szParentClassName)
     GET(StructureQ,+StructureQ.szStructureSort)
     K = INSTRING('(',StructureQ.szDataType)
     IF K
        szParentStruct = StructureQ.szDataType[K+1 : INSTRING(')',StructureQ.szDataType)-1]
     END
  END
  IF szParentStruct
     J = RECORDS(StructureQ)
     LOOP I = 1 TO J
       GET(StructureQ,I)
       IF ERRORCODE()
          BREAK
       ELSE
          IF UPPER(StructureQ.szStructureName) <> UPPER(szParentStruct)
             CYCLE
          END

          IF StructureQ.bPrivate = TRUE AND glo:bShowPrivate = FALSE
             CYCLE
          END
          IF StructureQ.szStructureName <> szLastStructure
             szLastStructure = StructureQ.szStructureName
             lLastModuleId = StructureQ.lModuleId
             TreeQ.lLevel = 1
             TreeQ.wIcon  = ICON:STRUCTUREFOLDER
          ELSE
             IF StructureQ.lModuleId <> lLastModuleId
                lLastModuleId = StructureQ.lModuleId
                TreeQ.lLevel = 1
                TreeQ.wIcon  = ICON:STRUCTUREFOLDER
             ELSE
                TreeQ.lLevel = 2
                TreeQ.wIcon  = ICON:STRUCTURE
             END
          END
          TreeQ.szText = StructureQ.szDataLabel & ' - ' & StructureQ.szDataType
          TreeQ.lStyle = CHOOSE(StructureQ.bPrivate = FALSE,STYLE:NORMAL,STYLE:PRIVATE)

          IF TreeQ.wIcon  = ICON:STRUCTURE
             DO CheckForHyperLink
          END

          TreeQ.szSearch = ''
          TreeQ.szClassName = StructureQ.szStructureName
          TreeQ.szContextString = StructureQ.szDataLabel
          TreeQ.szHelpFile = ''
          TreeQ.lLineNum = StructureQ.lLineNum
          TreeQ.lSourceLine = 0
          TreeQ.lIncludeId = 0
          TreeQ.lModuleId  = StructureQ.lModuleId
          DO SetNoteIcon
          DO SetTipText
          ADD(TreeQ)
       END
     END
  END

  J = RECORDS(StructureQ)
  LOOP I = 1 TO J
    GET(StructureQ,I)
    IF ERRORCODE()
       BREAK
    ELSE
       IF ~glo:szParentClassName
          glo:szParentClassName = StructureQ.szStructureName
       END

       IF UPPER(StructureQ.szStructureName) <> UPPER(glo:szParentClassName)
          CYCLE
       END

       IF StructureQ.bPrivate = TRUE AND glo:bShowPrivate = FALSE
          CYCLE
       END
       IF StructureQ.szStructureName <> szLastStructure
          szLastStructure = StructureQ.szStructureName
          lLastModuleId = StructureQ.lModuleId
          TreeQ.lLevel = CHOOSE(szParentStruct='',1,2)
          TreeQ.wIcon  = ICON:STRUCTUREFOLDER
       ELSE
          IF StructureQ.lModuleId <> lLastModuleId
             lLastModuleId = StructureQ.lModuleId
             TreeQ.lLevel = CHOOSE(szParentStruct='',1,2)
             TreeQ.wIcon  = ICON:STRUCTUREFOLDER
          ELSE
             TreeQ.lLevel = CHOOSE(szParentStruct='',2,3)
             TreeQ.wIcon  = ICON:STRUCTURE
          END
       END
       TreeQ.szText = StructureQ.szDataLabel & ' - ' & StructureQ.szDataType
       TreeQ.lStyle = CHOOSE(StructureQ.bPrivate = FALSE,STYLE:NORMAL,STYLE:PRIVATE)

       IF TreeQ.wIcon  = ICON:STRUCTURE
          DO CheckForHyperLink
       END

       TreeQ.szSearch = ''
       TreeQ.szClassName = StructureQ.szStructureName
       TreeQ.szContextString = StructureQ.szDataLabel
       TreeQ.szHelpFile = ''
       TreeQ.lLineNum = StructureQ.lLineNum
       TreeQ.lSourceLine = 0
       TreeQ.lIncludeId = 0
       TreeQ.lModuleId  = StructureQ.lModuleId
       DO SetNoteIcon
       DO SetTipText
       ADD(TreeQ)
    END
  END
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
CheckForHyperlink   ROUTINE
  IF INSTRING('&',TreeQ.szText)
     IF srcIsClassReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName,lObjectId)
        DO SetHyperlinkStyle
     ELSIF srcIsStructureReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName)
        DO SetHyperlinkStyle
     END
  ELSIF INSTRING('LIKE(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('LIKE(',UPPER(TreeQ.szText),1)+5 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          DO SetHyperlinkStyle
       END
  ELSIF INSTRING('GROUP(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('GROUP(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          DO SetHyperlinkStyle
       END
  ELSIF INSTRING('QUEUE(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('QUEUE(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          DO SetHyperlinkStyle
       END
  END
  EXIT
SetHyperlinkStyle   ROUTINE
  CASE TreeQ.lStyle
  OF STYLE:NORMAL
     TreeQ.lStyle = STYLE:NORMAL_HYPERLINK
  OF STYLE:PRIVATE
     TreeQ.lStyle = STYLE:PRIVATE_HYPERLINK
  OF STYLE:PROTECTED
     TreeQ.lStyle = STYLE:PROTECTED_HYPERLINK
  OF STYLE:NORMAL_NEW
     TreeQ.lStyle = STYLE:NORMAL_NEW_HYPERLINK
  OF STYLE:PRIVATE_NEW
     TreeQ.lStyle = STYLE:PRIVATE_NEW_HYPERLINK
  OF STYLE:PROTECTED_NEW
     TreeQ.lStyle = STYLE:PROTECTED_NEW_HYPERLINK
  END
  EXIT
