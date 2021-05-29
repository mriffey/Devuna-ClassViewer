

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
!!! </summary>
srcExportTreeToXML   PROCEDURE                             ! Declare Procedure
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
szIndent        CSTRING(256),AUTO
XMLFilename     CSTRING(256),STATIC,AUTO
XMLFile         FILE,DRIVER('ASCII'),NAME(XMLFilename),PRE(XML),THREAD,CREATE
Record            RECORD
Buffer              STRING(4000)
                  END
                END
XMLFileQueue    QUEUE,PRE(afq)
Record            LIKE(XMLFile.Record)
Level             LONG
                END

  CODE
  XMLFilename = 'ABCVIEW.XML'
  IF FILEDIALOG('Select XML File',XMLFileName,'XML Files (*.XML)|*.XML|All Files (*.*)|*.*',FILE:Save+FILE:KeepDir+FILE:LongName+FILE:NoError)
     DO ExportToXML
  END
  RETURN
ExportToXML ROUTINE
!---------------------------------------------------------------------------
  DATA
I               LONG,AUTO
J               LONG,AUTO
pAmp            LONG,AUTO

  CODE
  SORT(ModuleQ,+ModuleQ.lModuleId)
  SORT(ClassQ,+ClassQ.szClassSort)
  SORT(PropertyQ,+PropertyQ.szPropertySort)
  SORT(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodName,+MethodQ.szPrototype)
  SORT(StructureQ,+StructureQ.lModuleId,+StructureQ.szStructureSort,+StructureQ.szDataLabel)

  CREATE(XMLFile)
  OPEN(XMLFile)

  ! write the header
  XMLFile.Record = '<<?xml version="1.0" encoding="ISO-8859-1"?>'
  ADD(XMLFile)

  IF glo:szXmlStyleSheet <> ''
     XMLFile.Record = '<<?xml-stylesheet type="text/xsl" href="' & glo:szXmlStyleSheet & '"?>'
     ADD(XMLFile)
  END

  XMLFile.Record = '<<!DOCTYPE abcview PUBLIC "-//devuna.com//abcview DTD//EN" "http://www.devuna.com/abcview.dtd">'
  ADD(XMLFile)
  XMLFile.Record = '<<abcview>'
  ADD(XMLFile)

  ! dump the tree
  J = RECORDS(TreeQ)
  LOOP I = 1 TO J
     GET(TreeQ,I)

     !adjust indentation
     IF ABS(TreeQ.lLevel) = 1
        szIndent = ''
     ELSE
        szIndent = SUB(ALL(' '),1,(ABS(TreeQ.lLevel)-1)*3)
     END

     !look for and replace special characters
     TreeQ.szText = srcNormalizeString(TreeQ.szText)

     !write the ascii text
     CASE glo:bCurrentView
     OF VIEW:CLASSES
        DO ProcessClassView
     OF VIEW:INTERFACES
        DO ProcessInterfaceView
     OF VIEW:CALLS
        IF I = 1
           !create root document
           XMLFile.Record = '<<methods>'
           ADD(XMLFile)
           XMLFileQueue.Record = '<</methods>'
           XMLFileQueue.Level = 0
           ADD(XMLFileQueue,0)
        END
        DO ProcessCallTreeView

     OF VIEW:STRUCTURES
        IF I = 1
           !create root document (tree may contain multiple definitions)
           XMLFile.Record = '<<structures>'
           ADD(XMLFile)
           XMLFileQueue.Record = '<</structures>'
           XMLFileQueue.Level = 1
           ADD(XMLFileQueue,1)
        END
        DO ProcessStructureView
     OF VIEW:EQUATES
        DO ProcessEquatesView
     END
  END
  J = RECORDS(XMLFileQueue)
  LOOP I = 1 TO J
     GET(XMLFileQueue,I)
     XMLFile.Record = XMLFileQueue.Record
     ADD(XMLFile)
  END
  XMLFile.Record = '<</abcview>'
  ADD(XMLFile)
  FREE(XMLFileQueue)
  CLOSE(XMLFile)
  EXIT
ProcessClassView    ROUTINE
  DATA
szObject    CSTRING(33)

  CODE
  CASE TreeQ:wIcon
    OF   ICON:CLASS             |
    OROF ICON:NEWCLASS          |
    OROF ICON:INTERFACEFOLDER   |
    OROF ICON:NEWINTERFACEFOLDER
       LOOP WHILE RECORDS(XMLFileQueue) > 1
          GET(XMLFileQueue,1)
          IF XMLFileQueue.Level >= ABS(TreeQ.lLevel)
             XMLFile.Record = XMLFileQueue.Record
             ADD(XMLFile)
             DELETE(XMLFileQueue)
          ELSE
             BREAK
          END
       END

       CASE TreeQ:wIcon
       OF   ICON:CLASS     |
       OROF ICON:NEWCLASS
          ClassQ.szClassSort = UPPER(TreeQ.szClassName)
          GET(ClassQ,+ClassQ.szClassSort)
          IF ERRORCODE()
             ClassQ.szParentClassName = ''
          END
          IF ClassQ.szParentClassName
             XMLFile.Record = szIndent & |
                             '<<class name="' & TreeQ.szClassName & |
                             '" parentname="' & ClassQ.szParentClassName & '">'
          ELSE
             XMLFile.Record = szIndent & '<<class name="' & TreeQ.szClassName & '">'
          END
          ADD(XMLFile)
          XMLFileQueue.Record = szIndent & '<</class>'
          XMLFileQueue.Level = ABS(TreeQ.lLevel)
          ADD(XMLFileQueue,1)


       OF   ICON:INTERFACEFOLDER    |
       OROF ICON:NEWINTERFACEFOLDER
          IF TreeQ.szSearch = ''
             XMLFile.Record = szIndent & '<<' & LOWER(TreeQ.szText) & '>'
             ADD(XMLFile)
             XMLFileQueue.Record = szIndent & '<</' & LOWER(TreeQ.szText) & '>'
             XMLFileQueue.Level = ABS(TreeQ.lLevel)
             ADD(XMLFileQueue,1)
          ELSE
             ClassQ.szClassSort = UPPER(TreeQ.szText)
             GET(ClassQ,+ClassQ.szClassSort)
             IF ERRORCODE()
                ClassQ.szParentClassName = ''
             END
             IF ClassQ.szParentClassName
                XMLFile.Record = szIndent & |
                                '<<interface name="' & TreeQ.szText & |
                                '" parentname="' & ClassQ.szParentClassName & '">'
             ELSE
                XMLFile.Record = szIndent & '<<interface name="' & TreeQ.szText & '">'
             END
             ADD(XMLFile)
             XMLFileQueue.Record = szIndent & '<</interface>'
             XMLFileQueue.Level = ABS(TreeQ.lLevel)
             ADD(XMLFileQueue,1)
          END
       END


    OF ICON:PROPERTYFOLDER      |
    OROF ICON:METHODFOLDER
       LOOP WHILE RECORDS(XMLFileQueue) > 1
          GET(XMLFileQueue,1)
          IF XMLFileQueue.Level >= ABS(TreeQ.lLevel)
             XMLFile.Record = XMLFileQueue.Record
             ADD(XMLFile)
             DELETE(XMLFileQueue)
          ELSE
             BREAK
          END
       END
       XMLFile.Record = szIndent & '<<' & LOWER(TreeQ.szText) & '>'
       ADD(XMLFile)
       XMLFileQueue.Record = szIndent & '<</' & LOWER(TreeQ.szText) & '>'
       XMLFileQueue.Level = ABS(TreeQ.lLevel)
       ADD(XMLFileQueue,1)
  ELSE
      DO ProcessCommonElements
  END
  EXIT
ProcessInterfaceView    ROUTINE
  CASE TreeQ:wIcon
    OF   ICON:INTERFACE          |
    OROF ICON:INTERFACEFOLDER    |
    OROF ICON:NEWINTERFACEFOLDER
       LOOP WHILE RECORDS(XMLFileQueue) > 1
          GET(XMLFileQueue,1)
          IF XMLFileQueue.Level >= ABS(TreeQ.lLevel)
             XMLFile.Record = XMLFileQueue.Record
             ADD(XMLFile)
             DELETE(XMLFileQueue)
          ELSE
             BREAK
          END
       END

       ClassQ.szClassSort = UPPER(TreeQ.szClassName)
       GET(ClassQ,+ClassQ.szClassSort)
       IF ERRORCODE()
          ClassQ.szParentClassName = ''
       END
       IF ClassQ.szParentClassName
          XMLFile.Record = szIndent & |
                          '<<interface name="' & TreeQ.szClassName & |
                          '" parentname="' & ClassQ.szParentClassName & '">'
       ELSE
          XMLFile.Record = szIndent & '<<interface name="' & TreeQ.szClassName & '">'
       END
       ADD(XMLFile)
       XMLFileQueue.Record = szIndent & '<</interface>'
       XMLFileQueue.Level = ABS(TreeQ.lLevel)
       ADD(XMLFileQueue,1)
  ELSE
      DO ProcessCommonElements
  END
  EXIT
ProcessCallTreeView    ROUTINE
  DATA
I                   LONG
J                   LONG
K                   LONG
ThisLevel           LONG
NextLevel           LONG
ptrToken            LONG
szDefinitionModule  CSTRING(256)
szRootModule        CSTRING(256),AUTO

  CODE
  ThisLevel = ABS(TreeQ.lLevel)
  J = RECORDS(TreeQ)
  I = POINTER(TreeQ)
  IF I < J
     GET(TreeQ,I+1)
     NextLevel = ABS(TreeQ.lLevel)
     GET(TreeQ,I)
  ELSE
     NextLevel = 0
  END

  J = POINTER(TreeQ)
  K = ABS(TreeQ.lLevel)
  LOOP I = J TO 1 BY -1
    GET(TreeQ,I)
    IF ABS(TreeQ.lLevel) < K
       BREAK
    END
  END
  ModuleQ.lModuleId = TreeQ.lModuleId
  GET(ModuleQ,+ModuleQ.lModuleId)
  ASSERT(~ERRORCODE())
  IF ERRORCODE()
     szRootModule = ''
  ELSE
     szRootModule = CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName)
  END
  GET(TreeQ,J)

  CASE TreeQ:wIcon
    OF ICON:METHOD
       IF TreeQ.lModuleId = 0
          szDefinitionModule = ''
       ELSE
          ModuleQ.lModuleId = TreeQ.lModuleId
          GET(ModuleQ,+ModuleQ.lModuleId)
          ASSERT(~ERRORCODE())
          IF ERRORCODE()
             szDefinitionModule = ''
          ELSE
             szDefinitionModule = CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName)
          END
       END
       ModuleQ.lModuleId = TreeQ.lIncludeId
       GET(ModuleQ,+ModuleQ.lModuleId)
       ClassQ.szClassSort = UPPER(TreeQ.szClassName)
       GET(ClassQ,+ClassQ.szClassSort)
       MethodQ.lClassID = ClassQ.lClassId
       MethodQ.szMethodName = TreeQ:szText
       MethodQ.szPrototype = TreeQ.szPrototype
       GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodName,+MethodQ.szPrototype)

       XMLFile.Record = szIndent & '<<method'                       & |
                        ' name="' & MethodQ.szMethodName & '"'      & |
                        ' prototype="' & srcNormalizeString(MethodQ.szPrototype) & '"'  & |
                        ' private="' & CHOOSE(MethodQ.bPrivate=TRUE,'TRUE','FALSE') & '"'       & |
                        ' protected="' & CHOOSE(MethodQ.bProtected=TRUE,'TRUE','FALSE') & '"'   & |
                        ' virtual="' & CHOOSE(MethodQ.bVirtual=TRUE,'TRUE','FALSE') & '"'       & |
                        ' declarationmodule="' & CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName) & '"'    & |
                        ' declarationlinenumber="' & MethodQ.lLineNum & '"'

       IF MethodQ.lSourceLine
          XMLFile.Record = CLIP(XMLFile.Record) & |
                        ' definitionmodule="' & szDefinitionModule & '"'    & |
                        ' definitionlinenumber="' & MethodQ.lSourceLine & '"'
       END

       IF TreeQ.lOccurranceLine
          XMLFile.Record = CLIP(XMLFile.Record) & |
                        ' sourcemodule="' & szRootModule & '"'    & |
                        ' sourcelinenumber="' & TreeQ.lOccurranceLine & '"'
       END

       IF NextLevel > ThisLevel
          XMLFile.Record = CLIP(XMLFile.Record) & '>'
          ADD(XMLFile)
          XMLFileQueue.Record = szIndent & '<</method>'
          XMLFileQueue.Level = ABS(TreeQ.lLevel)
          ADD(XMLFileQueue,1)
       ELSE
          XMLFile.Record = CLIP(XMLFile.Record) & '>' & MethodQ.szMethodName & '<</method>'
          ADD(XMLFile)
          GET(XMLFileQueue,1)
          IF ~ERRORCODE()
             LOOP WHILE XMLFileQueue.Level >= NextLevel
                XMLFile.Record = XMLFileQueue.Record
                ADD(XMLFile)
                DELETE(XMLFileQueue)
                GET(XMLFileQueue,1)
                IF ERRORCODE()
                   BREAK
                END
             END
          END
       END


    OF   ICON:INTERFACE          |
    OROF ICON:INTERFACEFOLDER    |
    OROF ICON:NEWINTERFACEFOLDER
  END
  EXIT
ProcessStructureView    ROUTINE
  CASE TreeQ:wIcon
    OF ICON:STRUCTUREFOLDER
       LOOP WHILE RECORDS(XMLFileQueue) > 1
          GET(XMLFileQueue,1)
          IF XMLFileQueue.Level >= ABS(TreeQ.lLevel)
             XMLFile.Record = XMLFileQueue.Record
             ADD(XMLFile)
             DELETE(XMLFileQueue)
          ELSE
             BREAK
          END
       END

       ModuleQ.lModuleId = TreeQ.lModuleId
       GET(ModuleQ,+ModuleQ.lModuleId)
       ClassQ.szClassSort = UPPER(TreeQ.szClassName)
       GET(ClassQ,+ClassQ.szClassSort)
       IF ERRORCODE()
          ClassQ.szParentClassName = ''
       END
       XMLFile.Record = szIndent & |
                        '<<structure name="' & TreeQ.szClassName & '"'      & |
                        ' private="' & CHOOSE(StructureQ.bPrivate=TRUE,'TRUE','FALSE') & '"'                & |
                        ' declarationmodule="' & CLIP(ModuleQ:szModulePath & ModuleQ:szModuleName) & '"'    & |
                        ' declarationlinenumber="' & TreeQ.lLineNum & '"'   & |
                        '>'
       ADD(XMLFile)
       XMLFileQueue.Record = szIndent & '<</structure>'
       XMLFileQueue.Level = ABS(TreeQ.lLevel)
       ADD(XMLFileQueue,1)
  ELSE
      DO ProcessCommonElements
  END
  EXIT
ProcessEquatesView  ROUTINE
  CASE TreeQ:wIcon
    OF ICON:EQUATEFOLDER       |
  OROF ICON:ENUMFOLDER
       LOOP WHILE RECORDS(XMLFileQueue) > 1
          GET(XMLFileQueue,1)
          IF XMLFileQueue.Level >= ABS(TreeQ.lLevel)
             XMLFile.Record = XMLFileQueue.Record
             ADD(XMLFile)
             DELETE(XMLFileQueue)
          ELSE
             BREAK
          END
       END

       IF TreeQ.szClassName = '*EQUATES*'
          XMLFile.Record = szIndent & |
                           '<<enumeration name="' & TreeQ.szText & '"'  & |
                           '>'
       ELSE
          ModuleQ.lModuleId = TreeQ.lModuleId
          GET(ModuleQ,+ModuleQ.lModuleId)
          ClassQ.szClassSort = UPPER(TreeQ.szClassName)
          GET(ClassQ,+ClassQ.szClassSort)
          IF ERRORCODE()
             ClassQ.szParentClassName = ''
          END
          XMLFile.Record = szIndent & |
                           '<<enumeration name="' & TreeQ.szClassName & '"'    & |
                           ' declarationmodule="' & CLIP(ModuleQ:szModulePath & ModuleQ:szModuleName) & '"'    & |
                           ' declarationlinenumber="' & TreeQ.lLineNum & '"'   & |
                           '>'
       END
       ADD(XMLFile)
       XMLFileQueue.Record = szIndent & '<</enumeration>'
       XMLFileQueue.Level = ABS(TreeQ.lLevel)
       ADD(XMLFileQueue,1)
  ELSE
      DO ProcessCommonElements
  END
  EXIT
ProcessCommonElements  ROUTINE
  DATA
ptrToken            LONG
szDefinitionModule  CSTRING(256)

  CODE
  CASE TreeQ:wIcon
    OF ICON:INTERFACE
       XMLFile.Record = szIndent & '<<interface name="' & TreeQ.szText & '">' & TreeQ.szSearch & '<</interface>'
       ADD(XMLFile)

    OF ICON:PROPERTY
       ptrToken = INSTRING(' - ',TreeQ.szText,1)
       IF ptrToken
          TreeQ.szText = TreeQ.szText[ptrToken+3 : LEN(TreeQ.szText)]
       END
       ModuleQ.lModuleId = TreeQ.lIncludeId
       GET(ModuleQ,+ModuleQ.lModuleId)
       PropertyQ.szPropertySort = UPPER(TreeQ:szSearch)
       GET(PropertyQ,+PropertyQ.szPropertySort)

       XMLFile.Record = szIndent & '<<property'             & |
                        ' name="' & PropertyQ.szPropertyName & '"'   & |
                        ' datatype="' & srcNormalizeString(PropertyQ.szDataType) & '"'   & |
                        ' private="' & CHOOSE(PropertyQ.bPrivate=TRUE,'TRUE','FALSE') & '"'   & |
                        ' protected="' & CHOOSE(PropertyQ.bProtected=TRUE,'TRUE','FALSE') & '"'   & |
                        ' declarationmodule="' & CLIP(ModuleQ:szModulePath & ModuleQ:szModuleName) & '"'   & |
                        ' declarationlinenumber="' & TreeQ.lLineNum & '"'   & |
                        '>' & PropertyQ.szPropertyName & '<</property>'
       ADD(XMLFile)

    OF ICON:METHOD
       IF TreeQ.lModuleId = 0
          szDefinitionModule = ''
       ELSE
          ModuleQ.lModuleId = TreeQ.lModuleId
          GET(ModuleQ,+ModuleQ.lModuleId)
          ASSERT(~ERRORCODE())
          IF ERRORCODE()
             szDefinitionModule = ''
          ELSE
             szDefinitionModule = CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName)
          END
       END
       ModuleQ.lModuleId = TreeQ.lIncludeId
       GET(ModuleQ,+ModuleQ.lModuleId)
       ClassQ.szClassSort = UPPER(TreeQ.szClassName)
       GET(ClassQ,+ClassQ.szClassSort)
       MethodQ.lClassID = ClassQ.lClassID
       ptrToken = INSTRING(' ',TreeQ:szText)
       MethodQ.szMethodName = TreeQ:szText[1 : ptrToken-1]
       MethodQ.szPrototype = TreeQ.szText[ptrToken+1 : LEN(TreeQ.szText)]
       GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodName,+MethodQ.szPrototype)
       XMLFile.Record = szIndent & '<<method'                       & |
                        ' name="' & MethodQ.szMethodName & '"'      & |
                        ' prototype="' & srcNormalizeString(MethodQ.szPrototype) & '"'  & |
                        ' private="' & CHOOSE(MethodQ.bPrivate=TRUE,'TRUE','FALSE') & '"'       & |
                        ' protected="' & CHOOSE(MethodQ.bProtected=TRUE,'TRUE','FALSE') & '"'   & |
                        ' virtual="' & CHOOSE(MethodQ.bVirtual=TRUE,'TRUE','FALSE') & '"'       & |
                        ' declarationmodule="' & CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName) & '"'    & |
                        ' declarationlinenumber="' & MethodQ.lLineNum & '"'
       IF MethodQ.lSourceLine
          XMLFile.Record = CLIP(XMLFile.Record) & |
                        ' definitionmodule="' & szDefinitionModule & '"'    & |
                        ' definitionlinenumber="' & MethodQ.lSourceLine & '"'
       END
       XMLFile.Record = CLIP(XMLFile.Record) & '>' & MethodQ.szMethodName & '<</method>'
       ADD(XMLFile)

    OF ICON:STRUCTURE
       ModuleQ.lModuleId = TreeQ.lModuleId
       GET(ModuleQ,+ModuleQ.lModuleId)
       StructureQ.lModuleId = TreeQ.lModuleId
       StructureQ.szStructureSort = UPPER(TreeQ.szClassName)
       StructureQ.szDataLabel = TreeQ.szContextString
       GET(StructureQ,+StructureQ.lModuleId,+StructureQ.szStructureSort,+StructureQ.szDataLabel)
       XMLFile.Record = szIndent & '<<property'                             & |
                        ' name="' & StructureQ.szDataLabel & '"'            & |
                        ' datatype="' & srcNormalizeString(StructureQ.szDataType) & '"'         & |
                        ' private="' & CHOOSE(StructureQ.bPrivate=TRUE,'TRUE','FALSE') & '"'                & |
                        ' declarationmodule="' & CLIP(ModuleQ:szModulePath & ModuleQ:szModuleName) & '"'    & |
                        ' declarationlinenumber="' & TreeQ.lLineNum & '"'   & |
                        '>' & StructureQ.szDataLabel & '<</property>'
       ADD(XMLFile)

    OF ICON:EQUATE
       ptrToken = INSTRING(' = ',TreeQ.szText,1)
       ModuleQ.lModuleId = TreeQ.lModuleId
       GET(ModuleQ,+ModuleQ.lModuleId)

       XMLFile.Record = szIndent & '<<equate'                               & |
                        ' name="' & TreeQ.szText[1 : ptrToken-1] & '"'      & |
                        ' value="' & srcNormalizeString(TreeQ.szText[ptrToken+3 : LEN(TreeQ.szText)]) & '"' & |
                        ' declarationmodule="' & CLIP(ModuleQ:szModulePath & ModuleQ:szModuleName) & '"'    & |
                        ' declarationlinenumber="' & TreeQ.lLineNum & '"'   & |
                        '>' & TreeQ.szContextString & '<</equate>'

       ADD(XMLFile)
  END
  EXIT
