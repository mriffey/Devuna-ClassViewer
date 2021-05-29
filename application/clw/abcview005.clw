

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
!!! Add Class Properties to Tree
!!! </summary>
srcAddProperties     PROCEDURE  (lTreeLevel)               ! Declare Procedure
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
szObjectName    CSTRING(61)
lObjectId       LONG

  CODE
  PropertyQ.lClassID = ClassQ.lClassID
  PropertyQ.szPropertyName = ''
  GET(PropertyQ,+PropertyQ.lClassID)
  IF ~ERRORCODE()                       !If we found a property for this class
     !Add Properties Folder
     TreeQ.szText = 'Properties'
     TreeQ.wIcon  = ICON:PROPERTYFOLDER
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
     !Add Current Property
     TreeQ.szText = PropertyQ.szPropertyName & ' - ' & PropertyQ.szDataType
     TreeQ.wIcon  = ICON:PROPERTY
     TreeQ.lLevel = lTreeLevel+2
     TreeQ.lStyle = CHOOSE(PropertyQ.bPrivate,STYLE:PRIVATE,STYLE:NORMAL)
     TreeQ.lStyle = CHOOSE(PropertyQ.bProtected,STYLE:PROTECTED,TreeQ.lStyle)
     TreeQ.lStyle = CHOOSE(PropertyQ.bModule,STYLE:MODULE,TreeQ.lStyle)

     DO CheckForHyperlink

     TreeQ.szSearch = PropertyQ.szPropertyName
     TreeQ.szClassName = ClassQ.szClassName
     IF ClassQ.bIsABC
        IF SUB(ClassQ.szClassName,-5,5) = 'Class'
           TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName
        ELSE
           TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName & 'Class'
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
        TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName
        TreeQ.szHelpFile = ''
     END
     TreeQ.lLineNum = PropertyQ.lLineNum
     TreeQ.lSourceLine = 0
     IF PropertyQ.bModule
        TreeQ.lIncludeId = ClassQ.lModuleId
     ELSE
        TreeQ.lIncludeId = ClassQ.lIncludeId
     END
     TreeQ.lModuleId  = ClassQ.lModuleId
     IF PropertyQ.bPrivate OR PropertyQ.bModule
        TreeQ.szContextString = ''
        TreeQ.szHelpFile = ''
        IF glo:bShowPrivate
           IF PropertyQ.bModule
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
     ELSIF PropertyQ.bProtected
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

     I = POINTER(PropertyQ) + 1
     J = RECORDS(PropertyQ)
     LOOP I = I TO J
       GET(PropertyQ,I)
       IF ERRORCODE() OR PropertyQ.lClassID <> ClassQ.lClassID
          BREAK
       !ELSIF PropertyQ.bModule
       !   CYCLE
       ELSE
          TreeQ.szText = PropertyQ.szPropertyName & ' - ' & PropertyQ.szDataType
          TreeQ.wIcon  = ICON:PROPERTY
          TreeQ.lLevel = lTreeLevel+2
          TreeQ.lStyle = CHOOSE(PropertyQ.bPrivate,STYLE:PRIVATE,STYLE:NORMAL)
          TreeQ.lStyle = CHOOSE(PropertyQ.bProtected,STYLE:PROTECTED,TreeQ.lStyle)
          TreeQ.lStyle = CHOOSE(PropertyQ.bModule,STYLE:MODULE,TreeQ.lStyle)

          DO CheckForHyperlink

          TreeQ.szSearch = PropertyQ.szPropertyName
          TreeQ.szClassName = ClassQ.szClassName
          IF ClassQ.bIsABC
             IF SUB(ClassQ.szClassName,-5,5) = 'Class'
                TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName
             ELSE
                TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName & 'Class'
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
             TreeQ.szContextString = PropertyQ.szPropertyName & ':' & ClassQ.szClassName
             TreeQ.szHelpFile = ''
          END
          TreeQ.lLineNum = PropertyQ.lLineNum
          TreeQ.lSourceLine = 0
          IF PropertyQ.bModule
             TreeQ.lIncludeId = ClassQ.lModuleId
          ELSE
             TreeQ.lIncludeId = ClassQ.lIncludeId
          END
          TreeQ.lModuleId  = ClassQ.lModuleId
          IF PropertyQ.bPrivate OR PropertyQ.bModule
             TreeQ.szContextString = ''
             TreeQ.szHelpFile = ''
             IF glo:bShowPrivate
                IF PropertyQ.bModule
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
          ELSIF PropertyQ.bProtected
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
       END
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
  OF STYLE:MODULE
     TreeQ.lStyle = STYLE:MODULE_HYPERLINK
  OF STYLE:NORMAL_NEW
     TreeQ.lStyle = STYLE:NORMAL_NEW_HYPERLINK
  OF STYLE:PRIVATE_NEW
     TreeQ.lStyle = STYLE:PRIVATE_NEW_HYPERLINK
  OF STYLE:PROTECTED_NEW
     TreeQ.lStyle = STYLE:PROTECTED_NEW_HYPERLINK
  OF STYLE:MODULE_NEW
     TreeQ.lStyle = STYLE:MODULE_NEW_HYPERLINK
  END
  EXIT
