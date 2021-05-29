

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
!!! Scan Source Files and fill Queues
!!! </summary>
srcRefreshQueues     PROCEDURE  (ProcessString, ScanString, ProgressBox, FileProgressBox, RefreshGroup) ! Declare Procedure
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
Window WINDOW,AT(,,260,60),CENTER,WALLPAPER('WALLPAPER.GIF'),GRAY,DOUBLE,PALETTE(256)
       PANEL,AT(0,0,260,60),USE(?Panel2),BEVEL(-1,-1)
       STRING('Building Class Hierarchy'),AT(4,8,252,10),USE(?ProcessString),TRN,CENTER
       STRING('Scanning:'),AT(4,45,252,10),USE(?ScanString),TRN,CENTER
       STRING(@n_4),AT(211,45),USE(glo:lLineNum),TRN,HIDE
       PANEL,AT(29,23,202,16),USE(?Panel1),BEVEL(-1,-1)
       BOX,AT(30,24,0,14),USE(?ProgressBox),COLOR(COLOR:Red),FILL(COLOR:Red)
     END

AddDerivedClasses:I             LONG
AddDerivedClasses:J             LONG
A                               LONG
I                               LONG
J                               LONG
K                               LONG
M                               LONG
N                               LONG
P                               LONG
lClassPointer                   LONG
sav:ClassQ:szParentClassName    LIKE(ClassQ.szParentClassName)
lStructureQRecords              LONG
lStructureQPointer              LONG
ThisClass                       LIKE(ClassQ)
lMethodQPointer                 LONG
lMethodQRecords                 LONG
bProcessFile                    BYTE
bProcessingMap                  BYTE
bProcessingModule               BYTE
bProcessingClass                BYTE
bProcessingStructure            BYTE
bProcessingEquate               BYTE
bProcessingInclude              BYTE
bABC                            BYTE
lLastClassId                    LONG
lLastModuleId                   LONG
lEnumValue                      LONG
szCategory                      CSTRING(64)
szSection                       CSTRING(64)
szSearchPath                    CSTRING(4096),AUTO
FileQ                           QUEUE(File:queue),PRE(Q)
                                END
TempQ                           QUEUE(File:queue),PRE(TQ)
                                END
SearchQ                         QUEUE(SEARCHQTYPE),PRE(SQ)
                                END
ProcessQ                        QUEUE,PRE(PQ)
szName                            CSTRING(256)
szPath                            CSTRING(512)
bProcessed                        BYTE
lDate                             LONG
lTime                             LONG
                                END
IncludeQ                        QUEUE,PRE(IQ)
szName                            CSTRING(256)
szPath                            CSTRING(512)
lDate                             LONG
lTime                             LONG
bDelete                           BYTE
                                END

lFileBytesToProcess             LONG
lFileBytesProcessed             LONG
lFilePctComplete                LONG
lFileLastPct                    LONG

lPctComplete                    LONG
lLastPct                        LONG
szUpper                         CSTRING(1024)       !UPPER(CLIP(Source.Record.sText))
ClassInterfaceQ                 QUEUE,PRE()
lClassId                          LIKE(ClassQ.lClassID)
szInterface                       CSTRING(64)
                                END
lUnlabelledCount                LONG(0)
save:sText                      CSTRING(1024)
szLastEnumName                  LIKE(EnumQ.szEnumName)
lSaveModuleId                   LIKE(EnumQ.lModuleId)
bProcessInclude                 BYTE
bStructureCount                 BYTE
szOmitTerminator                CSTRING(64)
ReturnValue                     LONG
loc:sCurrentCursor              STRING(4)
bMultiStatement                 BYTE(0)         !true = processing multi statement line
save:sMultiStatement            CSTRING(1024)   !save area for multiple statement source line
hProcess                        LONG
bResult                         BYTE
lCount                          LONG
bModule                         BYTE
MapSourceQueue                  QUEUE,PRE(MapSourceQueue)
sText                             LIKE(SourceFile.Record.sText)
szUpper                           LIKE(szUpper)
LineNo                            LIKE(glo:lLineNum)
                                END

bFinal                          BYTE
bExtends                        BYTE
loc:szCompactAsciiFilename      cstring(65)

  CODE
  hProcess = GetCurrentProcess()
  IF hProcess
     bResult = SetPriorityClass(hProcess,IDLE_PRIORITY_CLASS)
  END

  DO CopyStructureQ
  DO RefreshQueues
  FREE(glo:StructureQCopy)

  IF hProcess
     bResult = SetPriorityClass(hProcess,NORMAL_PRIORITY_CLASS)
  END
  RETURN(ReturnValue)
RefreshQueues   ROUTINE
  IF glo:szRedFilePath
     UNHIDE(RefreshGroup)
     ReturnValue = FALSE

     loc:sCurrentCursor = glo:sCurrentCursor
     glo:sCurrentCursor = CURSOR:WAIT
     SETCURSOR(glo:sCurrentCursor)

     ProcessString{PROP:TEXT} = 'Building Class Hierarchy Tree'
     DISPLAY(ProcessString)

     FREE(ProcessQ)
     FREE(IncludeQ)
     FREE(EquateQ)

     IF glo:bRefreshAll
        FREE(ModuleQ)
        lLastModuleId = 0
        FREE(ClassQ)
        lLastClassId = 0
        FREE(PropertyQ)
        FREE(MethodQ)
        FREE(FileNameQ)
        FREE(SourceLineQ)
        FREE(LineCommentQ)
        FREE(StructureQ)
        FREE(EnumQ)
        DO FindAllModules
     ELSE
        SORT(ModuleQ,+ModuleQ.lModuleId)
        GET(ModuleQ,RECORDS(ModuleQ))
        lLastModuleId = ModuleQ.lModuleId
        SORT(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)

        SORT(ClassQ,+ClassQ.lClassId)
        GET(ClassQ,RECORDS(ClassQ))
        lLastClassId = ClassQ.lClassId
        DO FindChangedModules
        DO RemoveChangedModules
        DO FindNewModules
     END

     bProcessingInclude = FALSE
     J = RECORDS(ProcessQ)
     LOOP I = 1 TO J
       bProcessFile = FALSE
       bProcessingClass = FALSE
       bProcessingStructure = FALSE
       bProcessingEquate = FALSE
       bProcessingMap = FALSE
       bABC = FALSE
       szCategory = ''
       szOmitTerminator = ''
       glo:lLineNum = 0
       GET(ProcessQ,I)

       IF UPPER(ProcessQ.szName) = 'NETEMAIL.INC'
          IncludeQ.szPath = UPPER(ProcessQ.szPath)
          IncludeQ.szName = UPPER(ProcessQ.szName)
          GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
          IF ERRORCODE()
             ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
          END
          CYCLE
       END

       szAsciiFilename = ProcessQ.szPath & ProcessQ.szName
       PathCompactPathEx(loc:szCompactAsciiFilename, szAsciiFilename, SIZE(loc:szCompactAsciiFilename),0)
       ScanString{PROP:TEXT} = loc:szCompactAsciiFilename
       DISPLAY(ScanString)
       OPEN(SourceFile,ReadOnly+DenyNone)   !Read-Only

       !File Progress Bar
       lFileBytesToProcess = BYTES(SourceFile)
       lFileBytesProcessed = 0
       lFileLastPct = 0
       lFilePctComplete = 0
       FileProgressBox{PROP:WIDTH} = 0
       DISPLAY(FileProgressBox)

       SET(SourceFile)

       LOOP
         YIELD()
         Sleep(0)
         IF bMultiStatement = TRUE
            SourceFile.Record.sText = save:sMultiStatement
            bMultiStatement = FALSE
         ELSE
            NEXT(SourceFile)
            IF ~ERRORCODE()

               !!! remove extra whitespace from SourceFile.Record.sText here !!!
               SourceFile.Record.sText = srcRemoveWhitespace(SourceFile.Record.sText)

               glo:lLineNum += 1

               lFileBytesProcessed = POINTER(SourceFile)
               lFilePctComplete = (lFileBytesProcessed/lFileBytesToProcess)*100
               IF lFileLastPct <> INT(lFilePctComplete/10)
                  lFileLastPct = INT(lFilePctComplete/10)
                  FileProgressBox{PROP:Width} = lFilePctComplete*2
                  DISPLAY(FileProgressBox)
               END

            END

            K = srcFindComment(SourceFile.Record.sText)
            IF K
               IF UPPER(SourceFile.Record.sText[K : K+14]) = '!ABCINCLUDEFILE' |
               OR UPPER(SourceFile.Record.sText[K : K+8]) = '!CATEGORY'        |
               OR szOmitTerminator <> ''
                  !let it pass
               ELSE
                  !Begin 2004.12.14 -------------------------------------------
                  IF INSTRING(',FINAL', UPPER(SourceFile.Record.sText[K : LEN(CLIP(SourceFile.Record.sText))]), 1 ,1)
                     bFinal = TRUE
                  ELSE
                     bFinal = FALSE
                  END
                  IF INSTRING(',EXTENDS', UPPER(SourceFile.Record.sText[K : LEN(CLIP(SourceFile.Record.sText))]), 1 ,1)
                     bExtends = TRUE
                  ELSE
                     bExtends = FALSE
                  END
                  !End   2004.12.14 -------------------------------------------
                  IF K > 1
                     SourceFile.Record.sText = SourceFile.Record.sText[1 : K-1]
                  ELSE
                     SourceFile.Record.sText = ''
                  END
               END
            END
         END

         IF ERRORCODE()
            lFilePctComplete = 100
            FileProgressBox{PROP:Width} = lFilePctComplete*2
            DISPLAY(FileProgressBox)
            BREAK
         ELSE
            !==========================================================
            !Handle multiple statements on a line
            !==========================================================
            K = INSTRING(';',SourceFile.Record.sText)
            IF K
               save:sMultiStatement = SourceFile.Record.sText[K+1 : LEN(SourceFile.Record.sText)]
               SourceFile.Record.sText = SourceFile.Record.sText[1 : K-1]
               bMultiStatement = TRUE
            ELSE
               save:sMultiStatement = ''
            END
            !==========================================================
            IF szUpper
               IF szUpper[LEN(szUpper)] = '|'
                  SourceFile.Record.sText = CLIP(save:stext) & ' ' & CLIP(LEFT(SourceFile.Record.sText))
                  szUpper = UPPER(CLIP(SourceFile.Record.sText))
               ELSE
                  szUpper = UPPER(CLIP(SourceFile.Record.sText))
               END
            ELSE
               szUpper = UPPER(CLIP(SourceFile.Record.sText))
            END

            IF ~szUpper
               CYCLE
            ELSIF szUpper[LEN(szUpper)] = '|'
               save:stext = SourceFile.Record.sText[1 : LEN(szUpper)-1]
               CYCLE
            ELSIF szOmitTerminator AND ~INSTRING(szOmitTerminator,szUpper,1)
               szUpper = ''
               CYCLE
            ELSE
               IF szOmitTerminator
                  szOmitTerminator = ''
                  CYCLE
               END
               IF ~bProcessFile
                  bProcessFile = TRUE
                  IF INSTRING('!ABCINCLUDEFILE',szUpper,1)
                     bABC = TRUE
                     K = INSTRING('(',szUpper,1)
                     IF K
                        szCategory = szUpper[K+1 : INSTRING(')',szUpper,1)-1]
                     ELSE
                        szCategory = 'ABC'
                     END
                  ELSIF INSTRING('!CATEGORY',szUpper,1)
                     K = INSTRING('(',szUpper,1)
                     IF K
                        szCategory = szUpper[K+1 : INSTRING(')',szUpper,1)-1]
                     END
                  END
                  ProcessQ.bProcessed = TRUE
                  PUT(ProcessQ)
                  DO ProcessFile
               ELSE
                  DO ProcessFile
               END
            END
         END
       END
       CLOSE(SourceFile)

       lPctComplete = (I/(J + RECORDS(ExtraModuleQ)))*100
       IF lPctComplete > 98
          lPctComplete = 98
       END
       IF lPctComplete <> lLastPct
          lLastPct = lPctComplete
          ProgressBox{PROP:WIDTH} = lPctComplete
          DISPLAY(ProgressBox)
       END
     END

     IF glo:bRefreshAll = TRUE
        !include user specified files
        J = RECORDS(ExtraModuleQ)
        LOOP I = 1 TO J
           GET(ExtraModuleQ,I)
           IF ExtraModuleQ.bClarionVersion = glo:bClarionVersion
              IncludeQ.szPath = UPPER(ExtraModuleQ.szModulePath)
              IncludeQ.szName = UPPER(ExtraModuleQ.szModuleName)
              GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
              IF ERRORCODE()
                 ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
              END
           END
        END
     END

     !Process Files that were included
     bProcessingInclude = TRUE
     SORT(ProcessQ,+ProcessQ.szName,+ProcessQ.szPath)

     P = 0
     LOOP
       bProcessFile = FALSE
       bProcessingClass = FALSE
       bProcessingStructure = FALSE
       bProcessingEquate = FALSE
       bABC = FALSE
       szCategory = ''
       glo:lLineNum = 0
       P += 1
       GET(IncludeQ,P)
       IF ERRORCODE()
          BREAK
       ELSE
          !---------------------------------------------------------------------
          !spin through the queue looking
          bProcessInclude = TRUE
          LOOP A = 1 TO RECORDS(ProcessQ)
            GET(ProcessQ,A)
            IF ProcessQ.szPath = UPPER(IncludeQ.szPath) AND   |
               ProcessQ.szName = UPPER(IncludeQ.szName)
               IF ProcessQ.bProcessed = TRUE
                  bProcessInclude = FALSE
               ELSE
                  ProcessQ.bProcessed = TRUE
                  PUT(ProcessQ)
               END
               BREAK
            END
          END

          !get include file date and time
          IF bProcessInclude
             ProcessQ.szPath = UPPER(IncludeQ.szPath)
             ProcessQ.szName = UPPER(IncludeQ.szName)
             FREE(TempQ)
             DIRECTORY(TempQ,ProcessQ.szPath & ProcessQ.szName,0)
             IF RECORDS(TempQ)
                GET(TempQ,1)
                ProcessQ.lDate  = TempQ.Date
                ProcessQ.lTime  = TempQ.Time
             ELSE
                bProcessInclude = FALSE    !because it doesn't exist
             END
          END

          IF bProcessInclude
             szAsciiFilename = ProcessQ.szPath & ProcessQ.szName
             !ScanString{PROP:TEXT} = szAsciiFilename
             PathCompactPathEx(loc:szCompactAsciiFilename, szAsciiFilename, SIZE(loc:szCompactAsciiFilename),0)
             ScanString{PROP:TEXT} = loc:szCompactAsciiFilename
             DISPLAY(ScanString)
             OPEN(SourceFile,ReadOnly+DenyNone)   !Read-Only

             !File Progress Bar
             lFileBytesToProcess = BYTES(SourceFile)
             lFileBytesProcessed = 0
             lFileLastPct = 0
             lFilePctComplete = 0
             FileProgressBox{PROP:WIDTH} = 0
             DISPLAY(FileProgressBox)

             SET(SourceFile)

             bMultiStatement = FALSE
             LOOP
               YIELD()
               Sleep(0)
               IF bMultiStatement = TRUE
                  SourceFile.Record.sText = save:sMultiStatement
                  bMultiStatement = FALSE
               ELSE
                  NEXT(SourceFile)
                  IF ~ERRORCODE()

                     !!! remove extra whitespace from SourceFile.Record.sText here !!!
                     SourceFile.Record.sText = srcRemoveWhitespace(SourceFile.Record.sText)

                     glo:lLineNum += 1

                     lFileBytesProcessed = POINTER(SourceFile)
                     lFilePctComplete = (lFileBytesProcessed/lFileBytesToProcess)*100
                     IF lFileLastPct <> INT(lFilePctComplete/10)
                        lFileLastPct = INT(lFilePctComplete/10)
                        FileProgressBox{PROP:Width} = lFilePctComplete*2
                        DISPLAY(FileProgressBox)
                     END

                  END
                  IF szOmitTerminator = ''     !If not omitted source section
                     K = srcFindComment(SourceFile.Record.sText)
                     IF K
                        IF UPPER(SourceFile.Record.sText[K : K+14]) = '!ABCINCLUDEFILE' |
                        OR UPPER(SourceFile.Record.sText[K : K+8]) = '!CATEGORY'        |
                           !let it pass
                        ELSE
                           !Begin 2004.12.14 -------------------------------------------
                           IF INSTRING(',FINAL', UPPER(SourceFile.Record.sText[K : LEN(CLIP(SourceFile.Record.sText))]), 1 ,1)
                              bFinal = TRUE
                           ELSE
                              bFinal = FALSE
                           END
                           IF INSTRING(',EXTENDS', UPPER(SourceFile.Record.sText[K : LEN(CLIP(SourceFile.Record.sText))]), 1 ,1)
                              bExtends = TRUE
                           ELSE
                              bExtends = FALSE
                           END
                           !End   2004.12.14 -------------------------------------------
                           IF K > 1
                              SourceFile.Record.sText = SourceFile.Record.sText[1 : K-1]
                           ELSE
                              SourceFile.Record.sText = ''
                           END
                        END
                     END
                  END
               END
               IF ERRORCODE()
                  lFilePctComplete = 100
                  FileProgressBox{PROP:Width} = lFilePctComplete*2
                  DISPLAY(FileProgressBox)
                  BREAK
               ELSE
                  !==========================================================
                  !Handle multiple statements on a line
                  !==========================================================
                  K = INSTRING(';',SourceFile.Record.sText)
                  IF K
                     save:sMultiStatement = SourceFile.Record.sText[K+1 : LEN(SourceFile.Record.sText)]
                     SourceFile.Record.sText = SourceFile.Record.sText[1 : K-1]
                     bMultiStatement = TRUE
                  ELSE
                     save:sMultiStatement = ''
                  END
                  !==========================================================
                  IF szUpper
                     IF szUpper[LEN(szUpper)] = '|'
                        SourceFile.Record.sText = CLIP(save:stext) & ' ' & CLIP(LEFT(SourceFile.Record.sText))
                        szUpper = UPPER(CLIP(SourceFile.Record.sText))
                     ELSE
                        szUpper = UPPER(CLIP(SourceFile.Record.sText))
                     END
                  ELSE
                     szUpper = UPPER(CLIP(SourceFile.Record.sText))
                  END

                  IF ~szUpper
                     CYCLE
                  ELSIF szUpper[LEN(szUpper)] = '|'
                     save:stext = SourceFile.Record.sText[1 : LEN(szUpper)-1]
                     CYCLE
                  ELSIF szOmitTerminator AND ~INSTRING(szOmitTerminator,szUpper,1)
                     szUpper = ''
                     CYCLE
                  ELSE
                     IF szOmitTerminator
                        szOmitTerminator = ''
                        CYCLE
                     END
                     IF ~bProcessFile
                        bProcessFile = TRUE
                        !!! process file here ??? !!!
                     ELSE
                        DO ProcessFile
                     END
                  END
               END
             END
             DO _ProcessMap
             CLOSE(SourceFile)
          END
       END
     END

     !Add InterfaceMethods
     SORT(ClassQ,+ClassQ.lClassId)
     SORT(MethodQ,+MethodQ.lClassId)
     J = RECORDS(ClassInterfaceQ)
     LOOP I = 1 TO J
       GET(ClassInterfaceQ,I)
       ClassQ.lClassId = ClassInterfaceQ.lClassId
       GET(ClassQ,+ClassQ.lClassId)
       ThisClass = ClassQ

       SORT(ClassQ,+ClassQ.szClassSort)
       ClassQ.szClassSort = UPPER(ClassInterfaceQ.szInterface)
       GET(ClassQ,+ClassQ.szClassSort)

       MethodQ.lClassId = ClassQ.lClassId
       GET(MethodQ,+MethodQ.lClassId)
       lMethodQPointer = POINTER(MethodQ)
       lMethodQRecords = RECORDS(MethodQ)
       LOOP lMethodQPointer = lMethodQPointer TO lMethodQRecords
         GET(MethodQ,lMethodQPointer)
         IF MethodQ.lClassId = ClassQ.lClassId
            MethodQ.szMethodName = ClassQ.szClassName & '.' & MethodQ.szMethodName
            MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
            MethodQ:lSourceLine = srcGetSourceLine(ThisClass.lModuleId,ThisClass.szClassName & '.' & MethodQ.szMethodName,MethodQ.szPrototype)
            MethodQ.lClassID = ThisClass.lClassId
            MethodQ.bModule = FALSE
            ADD(MethodQ)
         ELSE
            BREAK
         END
       END
     END

     !Add Equates to EnumQ
     J = RECORDS(EquateQ)
     LOOP I = 1 TO J
       GET(EquateQ,I)
       !Group Equates with a common prefix
       K = INSTRING(':',EquateQ.szLabel)
       IF K
          EnumQ.szEnumName = EquateQ.szLabel[1 : K-1]
          EnumQ:lModuleId = EquateQ.lModuleId
          IF szLastEnumName <> EnumQ.szEnumName OR |
             (szLastEnumName = EnumQ.szEnumName AND lSaveModuleId <> EnumQ:lModuleId)
             IF I < J
                GET(EquateQ,I+1)
                IF EnumQ.szEnumName = EquateQ.szLabel[1 : K-1] AND EnumQ:lModuleId = EquateQ.lModuleId
                   GET(EquateQ,I)
                   szLastEnumName      = EnumQ.szEnumName
                   lSaveModuleId       = EquateQ.lModuleId  !EnumQ:lModuleId
                   !Write a Enumeration Detail
                   EnumQ.szEnumPrefix  = EnumQ.szEnumName
                   EnumQ.szEnumLabel   = EquateQ.szLabel
                   EnumQ.szEnumValue   = EquateQ.szValue
                   EnumQ.lModuleId     = EquateQ.lModuleId
                   EnumQ.lLineNum      = EquateQ.lLineNum
                   EnumQ.szEnumSort    = UPPER(EnumQ.szEnumName)
                   EnumQ.bIsHexValue   = EquateQ.bIsHexValue
                   EnumQ.bIsEquate     = TRUE
                   ADD(EnumQ)
                ELSE
                   GET(EquateQ,I)
                   szLastEnumName      = ''
                   EnumQ.szEnumName    = '*EQUATES*'
                   EnumQ.szEnumPrefix  = ''
                   EnumQ.szEnumLabel   = EquateQ.szLabel
                   EnumQ.szEnumValue   = EquateQ.szValue
                   EnumQ.lModuleId     = EquateQ.lModuleId
                   EnumQ.lLineNum      = EquateQ.lLineNum
                   EnumQ.szEnumSort    = '*EQUATES*'
                   EnumQ.bIsHexValue   = EquateQ.bIsHexValue
                   EnumQ.bIsEquate     = TRUE
                   ADD(EnumQ)
                END
             ELSE
                EnumQ.szEnumPrefix  = EnumQ.szEnumName
                EnumQ.szEnumLabel   = EquateQ.szLabel
                EnumQ.szEnumValue   = EquateQ.szValue
                EnumQ.lModuleId     = EquateQ.lModuleId
                EnumQ.lLineNum      = EquateQ.lLineNum
                EnumQ.szEnumSort    = UPPER(EnumQ.szEnumName)
                EnumQ.bIsHexValue   = EquateQ.bIsHexValue
                EnumQ.bIsEquate     = TRUE
                ADD(EnumQ)
             END
          ELSE
             EnumQ.szEnumPrefix  = EnumQ.szEnumName
             EnumQ.szEnumLabel   = EquateQ.szLabel
             EnumQ.szEnumValue   = EquateQ.szValue
             EnumQ.lModuleId     = EquateQ.lModuleId
             EnumQ.lLineNum      = EquateQ.lLineNum
             EnumQ.szEnumSort    = UPPER(EnumQ.szEnumName)
             EnumQ.bIsHexValue   = EquateQ.bIsHexValue
             EnumQ.bIsEquate     = TRUE
             ADD(EnumQ)
          END
       ELSE
          EnumQ.szEnumName    = '*EQUATES*'
          EnumQ.szEnumPrefix  = ''
          EnumQ.szEnumLabel   = EquateQ.szLabel
          EnumQ.szEnumValue   = EquateQ.szValue
          EnumQ.lModuleId     = EquateQ.lModuleId
          EnumQ.lLineNum      = EquateQ.lLineNum
          EnumQ.szEnumSort    = '*EQUATES*'
          EnumQ.bIsHexValue   = EquateQ.bIsHexValue
          EnumQ.bIsEquate     = TRUE
          ADD(EnumQ)
       END
     END

     !Fixup EnumQ
     DO FixupEnumQ

     lPctComplete = 100
     ProgressBox{PROP:WIDTH} = lPctComplete
     DISPLAY(ProgressBox)

     !Look For Method Calls
     ProcessString{PROP:TEXT} = 'Building Method Call Tree'
     DISPLAY(ProcessString)
     srcBuildCallQueue(ScanString,ProgressBox,FileProgressBox)

     !Now fill the Class Hierarchy Tree
     ProcessString{PROP:TEXT} = 'Finishing Up...'
     DISPLAY(ProcessString)
     !!!srcRefreshTree()
     HIDE(RefreshGroup)
  ELSE
     ReturnValue = TRUE
  END

  glo:sCurrentCursor = loc:sCurrentCursor
  SETCURSOR(glo:sCurrentCursor)
  EXIT
ProcessFile    ROUTINE
  DATA
X   LONG

  CODE
  IF INSTRING('!ABCINCLUDEFILE',szUpper,1)
     bABC = TRUE
     K = INSTRING('(',szUpper,1)
     IF K
        szCategory = szUpper[K+1 : INSTRING(')',szUpper,1)-1]
     ELSE
        szCategory = 'ABC'
     END
  ELSIF INSTRING('!CATEGORY',szUpper,1)
     K = INSTRING('(',szUpper,1)
     IF K
        szCategory = szUpper[K+1 : INSTRING(')',szUpper,1)-1]
     END
  END

  !Look for and remove comments
  K = srcFindComment(szUpper)
  IF K
     IF K > 1
        SourceFile.Record.sText = SUB(SourceFile.Record.sText,1,K-1)
     ELSE
        SourceFile.Record.sText = ''
     END
     szUpper = UPPER(CLIP(SourceFile.Record.sText))
  END

  K = INSTRING(' OMIT(''',szUpper,1)                !look for an omit statement
  IF K                                              !if an omit statement
     IF ~INSTRING(',',szUpper)                      !and not conditional
        M = INSTRING('''',szUpper,1,K+7)
        szOmitTerminator = szUpper[K+7 : M-1]
        szUpper = ''
     ELSE                                           !conditional, remove omit from source line
        M = INSTRING(')',szUpper,1,K+7)
        IF M > 0
           szUpper = CLIP(LEFT(szUpper[M+1 : LEN(szUpper)]))
        END
     END
  END

  IF CLIP(LEFT(szUpper)) = 'MAP'
     bProcessingMap = TRUE
  END

  IF bProcessingMap
     DO ProcessMap
  ELSE
     IF szUpper
        IF ~bProcessingClass    !look for class definition
           IF INSTRING(' CLASS,',szUpper,1)        |   !base class
           OR INSTRING(' CLASS()',szUpper,1)       |   !base class
           OR INSTRING(' INTERFACE,',szUpper,1)    |   !interface definition
           OR INSTRING(' INTERFACE ',szUpper,1)    |   !interface definition
           OR SUB(szUpper,-6,6) = ' CLASS'         |   !base class
           OR SUB(szUpper,-9,9) = 'INTERFACE'          !interface definition
              K = INSTRING(' ',SourceFile.Record.sText) - 1
              ClassQ.szClassName = SourceFile.Record.sText[1 : K]
              IF CLIP(ClassQ.szClassName)              !make sure class has a name
                 ClassQ.szParentClassName = ''
                 ModuleQ.szModulePath = ProcessQ.szPath
                 ModuleQ.szModuleName = ProcessQ.szName
                 ModuleQ.lDate        = ProcessQ.lDate
                 ModuleQ.lTime        = ProcessQ.lTime
                 GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 IF ERRORCODE()
                    lLastModuleId += 1
                    ModuleQ.lModuleId = lLastModuleId
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 ELSE
                    ModuleQ.lDate        = ProcessQ.lDate
                    ModuleQ.lTime        = ProcessQ.lTime
                    PUT(ModuleQ)
                 END
                 ClassQ.lIncludeId = ModuleQ.lModuleId
                 K = INSTRING(',MODULE(',szUpper,1)
                 IF K
                    K += 9
                 ELSE
                    K = INSTRING(', MODULE(',szUpper,1)
                    IF K
                       K += 10
                    END
                 END
                 IF K
                    X = INSTRING('''',SourceFile.Record.sText,1,K)-1
                    ModuleQ.szModulePath = ProcessQ.szPath
                    ModuleQ.szModuleName = UPPER(SourceFile.Record.sText[K : X])
                    IF ~INSTRING('.',ModuleQ.szModuleName)
                       ModuleQ.szModuleName = ModuleQ.szModuleName & '.CLW'
                    END
                    GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                    IF ERRORCODE()
                       lLastModuleId += 1
                       ModuleQ.lModuleId = lLastModuleId
                       !Get Module Date and Time
                       FREE(TempQ)
                       DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
                       IF RECORDS(TempQ)
                          GET(TempQ,1)
                          ModuleQ.lDate        = TempQ.Date
                          ModuleQ.lTime        = TempQ.Time
                          ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                          ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                       ELSE
                          ModuleQ.lModuleId = 0    !because it doesn't exist
                       END
                    ELSE
                       FREE(TempQ)
                       DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
                       IF RECORDS(TempQ)
                          GET(TempQ,1)
                          ModuleQ.lDate        = TempQ.Date
                          ModuleQ.lTime        = TempQ.Time
                          PUT(ModuleQ)
                       END
                    END
                    ClassQ.lModuleId = ModuleQ.lModuleId
                 ELSE
                    ClassQ.lModuleId = 0
                 END
                 lLastClassId += 1
                 ClassQ.bIsABC = bABC
                 ClassQ.lLineNum = glo:lLineNum
                 ClassQ.lClassID = lLastClassId
                 ClassQ.szClassSort = UPPER(ClassQ.szClassName)
                 ClassQ.szParentClassSort = ''
                 ClassQ.bPrivate = FALSE
                 IF INSTRING(' INTERFACE,',szUpper,1)    |   !interface definition
                 OR INSTRING(' INTERFACE ',szUpper,1)    |   !interface definition
                 OR SUB(szUpper,-9,9) = 'INTERFACE'          !interface definition
                    ClassQ.bInterface = TRUE
                 ELSE
                    ClassQ.bInterface = FALSE
                 END
                 ClassQ.bModified = TRUE
                 ADD(ClassQ)

                 !Add Class Categories
                 CategoryQ.szClassName = ClassQ.szClassName
                 GET(CategoryQ,+CategoryQ.szClassName)
                 IF ERRORCODE()
                    CategoryQ.szClassName = ClassQ.szClassName
                    CategoryQ.szCategory = szCategory
                    CASE CategoryQ.szClassName
                    OF   'INIClass'        |
                    OROF 'PopupClass'
                       CategoryQ.bDetailLevel = 0

                    OF   'ErrorClass'      |
                    OROF 'FileManager'     |
                    OROF 'RelationManager'
                       CategoryQ.bDetailLevel = 0

                    OF   'ViewManager'     |
                    OROF 'WindowManager'
                       CategoryQ.bDetailLevel = 0
                    ELSE
                       CategoryQ.bDetailLevel = 1
                    END

                    ADD(CategoryQ,+CategoryQ.szClassName)
                 ELSIF szCategory
                    CategoryQ.szCategory = szCategory
                    PUT(CategoryQ,+CategoryQ.szClassName)
                 END
                 !=================================================
                 !look for terminator
                 IF SUB(szUpper,-1,1) = '.'    |
                 OR SUB(szUpper,-3,3) = 'END'
                    bProcessingClass = FALSE
                 ELSE
                    bProcessingClass = TRUE
                 END
                 !=================================================
                 !bProcessingClass = TRUE
                 DO AddInterfaceMethods
              END

           ELSIF INSTRING(' CLASS(',szUpper,1)     |  !derived class
              OR INSTRING(' INTERFACE(',szUpper,1)    !Interface
              K = INSTRING(' ',SourceFile.Record.sText) - 1
              ClassQ.szClassName = SourceFile.Record.sText[1 : K]
              IF CLIP(ClassQ.szClassName)              !make sure class has a name
                 K = INSTRING(' CLASS(',szUpper,1)
                 IF K
                    K += 7
                 ELSE
                    K = INSTRING(' INTERFACE(',szUpper,1) + 11
                 END
                 M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
                 ClassQ.szParentClassName = SourceFile.Record.sText[K : M]
                 ModuleQ.szModulePath = ProcessQ.szPath
                 ModuleQ.szModuleName = ProcessQ.szName
                 ModuleQ.lDate        = ProcessQ.lDate
                 ModuleQ.lTime        = ProcessQ.lTime
                 GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 IF ERRORCODE()
                    lLastModuleId += 1
                    ModuleQ.lModuleId = lLastModuleId
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 ELSE
                    ModuleQ.lDate        = ProcessQ.lDate
                    ModuleQ.lTime        = ProcessQ.lTime
                    PUT(ModuleQ)
                 END
                 ClassQ.lIncludeId = ModuleQ.lModuleId
                 K = INSTRING(',MODULE(',szUpper,1)
                 IF K
                    K += 9
                 ELSE
                    K = INSTRING(', MODULE(',szUpper,1)
                    IF K
                       K += 10
                    END
                 END
                 IF K
                    X = INSTRING('''',SourceFile.Record.sText,1,K)-1
                    ModuleQ.szModuleName = UPPER(SourceFile.Record.sText[K : X])
                    IF ~INSTRING('.',ModuleQ.szModuleName)
                       ModuleQ.szModuleName = ModuleQ.szModuleName & '.CLW'
                    END
                    GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                    IF ERRORCODE()
                       lLastModuleId += 1
                       ModuleQ.lModuleId = lLastModuleId
                       !Get Module Date and Time
                       FREE(TempQ)
                       DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
                       IF RECORDS(TempQ)
                          GET(TempQ,1)
                          ModuleQ.lDate        = TempQ.Date
                          ModuleQ.lTime        = TempQ.Time
                          ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                          ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                       ELSE
                          ModuleQ.lModuleId = 0    !because it doesn't exist
                       END
                    ELSE
                       FREE(TempQ)
                       DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
                       IF RECORDS(TempQ)
                          GET(TempQ,1)
                          ModuleQ.lDate        = TempQ.Date
                          ModuleQ.lTime        = TempQ.Time
                          PUT(ModuleQ)
                       END
                    END
                    ClassQ.lModuleId = ModuleQ.lModuleId
                 ELSE
                    ClassQ.lModuleId = 0
                 END
                 lLastClassId += 1
                 ClassQ.bIsABC = bABC
                 ClassQ.lLineNum = glo:lLineNum
                 ClassQ.lClassID = lLastClassId
                 ClassQ.szClassSort = UPPER(ClassQ.szClassName)
                 ClassQ.szParentClassSort = UPPER(ClassQ.szParentClassName)
                 ClassQ.bPrivate = FALSE
                 IF INSTRING(' INTERFACE(',szUpper,1)    !Interface
                    ClassQ.bInterface = TRUE
                 ELSE
                    ClassQ.bInterface = FALSE
                 END
                 ClassQ.bModified = TRUE
                 ADD(ClassQ)

                 CategoryQ.szClassName = ClassQ.szClassName
                 GET(CategoryQ,+CategoryQ.szClassName)
                 IF ERRORCODE()
                    CategoryQ.szClassName = ClassQ.szClassName
                    CategoryQ.szCategory = szCategory
                    CASE CategoryQ.szClassName
                    OF   'INIClass'        |
                    OROF 'PopupClass'
                       CategoryQ.bDetailLevel = 0

                    OF   'ErrorClass'      |
                    OROF 'FileManager'     |
                    OROF 'RelationManager'
                       CategoryQ.bDetailLevel = 0

                    OF   'ViewManager'     |
                    OROF 'WindowManager'
                       CategoryQ.bDetailLevel = 0
                    ELSE
                       CategoryQ.szCategory = szCategory
                       CategoryQ.bDetailLevel = 1
                    END

                    ADD(CategoryQ,+CategoryQ.szClassName)

                 ELSIF szCategory
                    CategoryQ.szCategory = szCategory
                    PUT(CategoryQ,+CategoryQ.szClassName)
                 END

                 !=================================================
                 !look for terminator
                 IF SUB(szUpper,-1,1) = '.'    |
                 OR SUB(szUpper,-3,3) = 'END'
                    bProcessingClass = FALSE
                 ELSE
                    bProcessingClass = TRUE
                 END
                 !=================================================
                 !bProcessingClass = TRUE
                 DO AddInterfaceMethods
              END
           END
        ELSE !look for properties and methods
           DO ProcessClass
        END

        IF ~bProcessingStructure   !look for structure definition
           IF INSTRING(' GROUP',szUpper,1) OR |
              INSTRING(' QUEUE',szUpper,1)

              IF INSTRING(',TYPE',szUpper,1)   |       !found a structure?
              OR INSTRING(', TYPE',szUpper,1)
                 StructureQ.szStructureName = srcGetLabel(SourceFile.Record.sText)
                 StructureQ.szDataLabel = srcGetLabel(SourceFile.Record.sText)
                 StructureQ.szDataType = srcGetStatement(SourceFile.Record.sText)

?               ASSERT(LEN(StructureQ.szDataType) <> 0)
                 IF StructureQ.szDataType[LEN(StructureQ.szDataType)] = '.'
                    StructureQ.szDataType[LEN(StructureQ.szDataType)] = '<0>'
                 ELSE
                    bProcessingStructure = TRUE
                    bStructureCount = 1
                 END
                 ModuleQ.szModulePath = ProcessQ.szPath
                 ModuleQ.szModuleName = ProcessQ.szName
                 ModuleQ.lDate        = ProcessQ.lDate
                 ModuleQ.lTime        = ProcessQ.lTime
                 GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 IF ERRORCODE()
                    lLastModuleId += 1
                    ModuleQ.lModuleId = lLastModuleId
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 ELSE
                    ModuleQ.lDate        = ProcessQ.lDate
                    ModuleQ.lTime        = ProcessQ.lTime
                    PUT(ModuleQ)
                 END
                 StructureQ.lModuleId = ModuleQ.lModuleId
                 StructureQ.lLineNum = glo:lLineNum
                 StructureQ.szStructureSort = UPPER(StructureQ.szStructureName)
                 StructureQ.bPrivate = FALSE
                 ADD(StructureQ)
              END
           END
        ELSE !look for properties and methods
           DO ProcessStructure
        END

        IF ~bProcessingEquate   !look for itemized equates
           IF INSTRING(' ITEMIZE',szUpper,1)

              K = INSTRING('PRE(',szUpper,1)  !start value specified?
              IF K
                 K += 4
                 M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
                 EnumQ.szEnumPrefix = SourceFile.Record.sText[K : M]
              ELSE
                 EnumQ.szEnumPrefix = ''
              END

              EnumQ.szEnumLabel  = srcGetLabel(SourceFile.Record.sText)

              IF EnumQ.szEnumLabel
                 EnumQ.szEnumName = EnumQ.szEnumLabel
                 IF ~EnumQ.szEnumPrefix
                    EnumQ.szEnumPrefix = EnumQ.szEnumLabel
                 END
              ELSIF EnumQ.szEnumPrefix
                 EnumQ.szEnumName = EnumQ.szEnumPrefix
              ELSE
                 lUnlabelledCount += 1
                 EnumQ.szEnumName = '_Unlabelled Enumeration Data Structure [' & lUnlabelledCount  & ']'
              END

              K = INSTRING(' ITEMIZE(',szUpper,1)  !start value specified?
              IF K
                 K += 9
                 M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
                 EnumQ.szEnumValue = SourceFile.Record.sText[K : M]
              ELSE
                 EnumQ.szEnumValue = 1
              END
              EnumQ.bIsHexValue = FALSE
              IF ~NUMERIC(EnumQ.szEnumValue)
                 EnumQ.szEnumValue = srcGetEquateValue(EnumQ.szEnumValue,EnumQ.bIsHexValue)
              END
              lEnumValue = EnumQ.szEnumValue - 1

              ModuleQ.szModulePath = ProcessQ.szPath
              ModuleQ.szModuleName = ProcessQ.szName
              ModuleQ.lDate        = ProcessQ.lDate
              ModuleQ.lTime        = ProcessQ.lTime
              GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
              IF ERRORCODE()
                 lLastModuleId += 1
                 ModuleQ.lModuleId = lLastModuleId
                 ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                 ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
              ELSE
                 ModuleQ.lDate        = ProcessQ.lDate
                 ModuleQ.lTime        = ProcessQ.lTime
                 PUT(ModuleQ)
              END
              EnumQ.lModuleId = ModuleQ.lModuleId

              EnumQ.lLineNum     = glo:lLineNum
              EnumQ.szEnumSort   = UPPER(EnumQ.szEnumName)
              ADD(EnumQ)

              bProcessingEquate = TRUE

           ELSE
              K = INSTRING(' EQUATE',szUpper,1)  !equate value specified?
              IF K
                 K = INSTRING('(',szUpper,1,K+7)  !equate value specified?
              END
              IF K
                 EquateQ.szLabel = UPPER(srcGetLabel(SourceFile.Record.sText))
                 K += 1
                 M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
                 IF SourceFile.Record.sText[K] <> ''''
                    EquateQ.bIsHexValue = FALSE
                    IF ~NUMERIC(SourceFile.Record.sText[K : M])
                       EquateQ.szValue = srcGetEquateValue(SourceFile.Record.sText[K : M],EquateQ.bIsHexValue)
                       IF EquateQ.szValue = ''
                          EquateQ.szValue = SourceFile.Record.sText[K : M]
                       END
                    ELSE
                       EquateQ.szValue = SourceFile.Record.sText[K : M]
                    END
                 ELSE
                    EquateQ.szValue = SourceFile.Record.sText[K : M]
                 END
                 IF INSTRING('(',EquateQ.szValue)
                    EquateQ.szValue = EquateQ.szValue & ')'
                 END
                 ModuleQ.szModulePath = ProcessQ.szPath
                 ModuleQ.szModuleName = ProcessQ.szName
                 ModuleQ.lDate        = ProcessQ.lDate
                 ModuleQ.lTime        = ProcessQ.lTime
                 GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 IF ERRORCODE()
                    lLastModuleId += 1
                    ModuleQ.lModuleId = lLastModuleId
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                 ELSE
                    ModuleQ.lDate        = ProcessQ.lDate
                    ModuleQ.lTime        = ProcessQ.lTime
                    PUT(ModuleQ)
                 END
                 EquateQ.lModuleId = ModuleQ.lModuleId
                 EquateQ.lLineNum = glo:lLineNum
                 IF EquateQ.szLabel <> EquateQ.szValue     !prevent infinate loop in scan
                    ADD(EquateQ) !,+EquateQ.szLabel)
                 END
              END
           END
        ELSE !look for enumeration structures
           DO ProcessEquate
        END

        IF glo:bRefreshAll = TRUE
           K = INSTRING(' INCLUDE',szUpper,1)
           IF K !AND ~bProcessingInclude
              K = INSTRING('''',szUpper)
              IF K
                 IncludeQ.szName = CLIP(szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
                 IncludeQ.szPath = ProcessQ.szPath
                 GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                 IF ERRORCODE()
                    !ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                    ADD(IncludeQ)
                 END
              END
           END
        END

     END
  END
  EXIT
ProcessMap ROUTINE
  DATA
pToken  LONG

  CODE
  !Look for END or .
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     IF lCount > 0
        lCount -= 1
        MapSourceQueue.sText   = SourceFile.Record.sText
        MapSourceQueue.szUpper = szUpper
        MapSourceQueue.LineNo  = glo:lLineNum
        ADD(MapSourceQueue)
     ELSE
        bProcessingMap = FALSE
     END
  ELSE
     pToken = INSTRING('MODULE(',szUpper,1)
     IF pToken
        lCount += 1
     END
     MapSourceQueue.sText   = SourceFile.Record.sText
     MapSourceQueue.szUpper = szUpper
     MapSourceQueue.LineNo  = glo:lLineNum
     ADD(MapSourceQueue)
  END

_ProcessMap ROUTINE
  DATA
szTemp  CSTRING(256)
pToken  LONG
pSpace  LONG
pComma  LONG
pParen  LONG
qPtr    LONG
qRecs   LONG
fAdd    BYTE

  CODE
  bProcessingModule = FALSE
  bModule = CHOOSE(UPPER(SUB(ModuleQ.szModuleName,-4,4))='.CLW',TRUE,FALSE)
  qRecs = RECORDS(MapSourceQueue)
  LOOP qPtr = 1 TO qREcs
     GET(MapSourceQueue,qPtr)
     SourceFile.Record.sText = MapSourceQueue.sText
     szUpper = MapSourceQueue.szUpper
     glo:lLineNum = MapSourceQueue.LineNo

     IF bProcessingModule
        IF CLIP(LEFT(szUpper)) = 'END' OR |
           CLIP(LEFT(szUpper)) = '.'
              bProcessingModule = FALSE
        END
     END

     IF bProcessingModule
        !First parameter is class name
        pToken = INSTRING('PROCEDURE(',szUpper,1)
        IF pToken
           pToken += 10
        ELSE
           pToken = INSTRING('FUNCTION(',szUpper,1)
           IF pToken
              pToken += 9
           END
        END
        IF pToken <> 0
           szTemp = CLIP(LEFT(SourceFile.Record.sText[pToken : LEN(SourceFile.Record.sText)]))
           pSpace = INSTRING(' ',szTemp,1)
           IF pSpace
              pComma = INSTRING(',',szTemp,1)
              IF pComma AND pComma < pSpace
                 ClassQ.szClassName = szTemp[1 : pComma-1]
              ELSE
                 ClassQ.szClassName = szTemp[1 : pSpace-1]
              END
           ELSE
              pComma = INSTRING(',',szTemp,1)
              IF pComma
                 ClassQ.szClassName = szTemp[1 : pComma-1]
              ELSE
                 pParen = INSTRING(')',szTemp,1)
?               ASSERT(pParen <> 0)
                 ClassQ.szClassName = szTemp[1 : pParen-1]
              END
           END
           !see if valid class
           szTemp = ClassQ.szClassName
           SORT(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)
           ClassQ.szClassSort = UPPER(szTemp)
           ClassQ.lModuleId = ModuleQ.lModuleId
           GET(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)
           IF ~ERRORCODE()
              !if it is, add this as a method of the class
              pSpace = INSTRING(' ',SourceFile.Record.sText) - 1
              MethodQ.lClassID = ClassQ.lClassID
              MethodQ.szMethodName = SourceFile.Record.sText[1 : pSpace]
              MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
              GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
              IF ERRORCODE()
                 fAdd = TRUE
              ELSE
                 fAdd = FALSE
              END

              MethodQ.szPrototype = srcGetPrototype(SourceFile.Record.sText)
              pToken = INSTRING(ClassQ.szClassSort,UPPER(MethodQ.szPrototype),1)
              IF pToken
                 MethodQ.szPrototype = MethodQ.szPrototype[1 : pToken-1] & MethodQ.szPrototype[pToken+LEN(ClassQ.szClassSort) : LEN(MethodQ.szPrototype)]
                 pToken = INSTRING(',',MethodQ.szPrototype)
                 IF pToken
                    MethodQ.szPrototype = '(' & MethodQ.szPrototype[pToken+1 : LEN(MethodQ.szPrototype)]
                 END
              END

              MethodQ.bPrivate = TRUE
              MethodQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
              MethodQ.bVirtual = CHOOSE(INSTRING(',VIRTUAL',szUpper,1))
              MethodQ.lLineNum = glo:lLineNum
              MethodQ.lSourceLine = srcGetSourceLine(ClassQ.lModuleId,ClassQ.szClassName & '.' & MethodQ.szMethodName,MethodQ.szPrototype)
              MethodQ.lClassID = ClassQ.lClassID
              MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
              MethodQ.bModule = bModule
              !Begin 2004.12.14 -----------------------------------------------
              MethodQ.bExtends = bExtends
              MethodQ.bFinal = bFinal
              MethodQ.bProc = CHOOSE(INSTRING(',PROC',szUpper,1))
              MethodQ.szDLL = srcGetPrototypeAttr('DLL',SourceFile.Record.sText)
              MethodQ.szExtName = srcGetPrototypeAttr('NAME',SourceFile.Record.sText)
              MethodQ.szCallConv = srcGetPrototypeAttr('CALLCONV',SourceFile.Record.sText)
              MethodQ.szReturnType = srcGetPrototypeAttr('RETURN',SourceFile.Record.sText)
              !End   2004.12.14 -----------------------------------------------
              IF fAdd
                 IF MethodQ.lSourceLine
                    ADD(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
                 ELSE
                    DO AddModuleLevelMethod
                 END
              ELSE
                 PUT(MethodQ)
              END
           ELSE
           !otherwise it is module level procedure for
           !all the classes in the file
              DO AddModuleLevelMethod
           END
        END
     ELSE
        pToken = INSTRING('MODULE(',szUpper,1)
        IF pToken
           pToken += 8
           szTemp = CLIP(LEFT(SourceFile.Record.sText[pToken : LEN(SourceFile.Record.sText)]))
           pToken = INSTRING('''',szTemp,1)
           IF pToken
              ModuleQ.szModuleName = szTemp[1 : pToken-1]
              IF UPPER(SUB(ModuleQ.szModuleName,-4,4)) <> '.CLW'
                 ModuleQ.szModuleName = ModuleQ.szModuleName & '.CLW'
              END
              GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
              IF ERRORCODE()
                 !Get Module Date and Time
                 FREE(TempQ)
                 DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
                 IF RECORDS(TempQ)
                    GET(TempQ,1)
                    ModuleQ.lDate        = TempQ.Date
                    ModuleQ.lTime        = TempQ.Time
                    lLastModuleId += 1
                    ModuleQ.lModuleId = lLastModuleId
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
                    bProcessingModule = TRUE
                 ELSE
                    ModuleQ.lModuleId = 0    !because it doesn't exist
                 END
              END
           END
        END
     END
  END   !LOOP
  FREE(MapSourceQueue)
  EXIT

AddModuleLevelMethod    ROUTINE
  DATA
pSpace  LONG
pQueue  LONG

  CODE
  pSpace = INSTRING(' ',SourceFile.Record.sText) - 1
  MethodQ.szMethodName = SourceFile.Record.sText[1 : pSpace]
  MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
  MethodQ.szPrototype = srcGetPrototype(SourceFile.Record.sText)
  MethodQ.bPrivate = TRUE
  MethodQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
  MethodQ.bVirtual = CHOOSE(INSTRING(',VIRTUAL',szUpper,1))
  MethodQ.lLineNum = glo:lLineNum
  MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
  MethodQ.bModule = bModule
  MethodQ.lSourceLine = srcGetSourceLine(ModuleQ.lModuleId,MethodQ.szMethodName,MethodQ.szPrototype)
  !Begin 2004.12.14 -----------------------------------------------
  MethodQ.bExtends = bExtends
  MethodQ.bFinal = bFinal
  MethodQ.bProc = CHOOSE(INSTRING(',PROC',szUpper,1))
  MethodQ.szDLL = srcGetPrototypeAttr('DLL',SourceFile.Record.sText)
  MethodQ.szExtName = srcGetPrototypeAttr('NAME',SourceFile.Record.sText)
  MethodQ.szCallConv = srcGetPrototypeAttr('CALLCONV',SourceFile.Record.sText)
  MethodQ.szReturnType = srcGetPrototypeAttr('RETURN',SourceFile.Record.sText)
  !End   2004.12.14 -----------------------------------------------
  LOOP pQueue = 1 TO RECORDS(ClassQ)
     GET(ClassQ,pQueue)
     IF ClassQ.lModuleId = ModuleQ.lModuleId
        MethodQ.lClassID = ClassQ.lClassID
        ADD(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
     END
  END
  EXIT
ProcessClass ROUTINE
  DATA
bEndCount   BYTE

  CODE
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     bProcessingClass = FALSE
  ELSE
     !property or method
     K = INSTRING(' PROCEDURE',szUpper,1)
     IF ~K
        K = INSTRING(' FUNCTION',szUpper,1)
     END
     IF K AND INSTRING('''',szUpper[1 : K])
        K = 0
     END
     IF K
        K = INSTRING(' ',SourceFile.Record.sText) - 1
        MethodQ.szMethodName = SourceFile.Record.sText[1 : K]

        COMPILE('ENDCOMPILE',_debug_)
        IF UPPER(MethodQ.szMethodName) = 'GROUP'
           x#=0
        END
        !ENDCOMPILE

        MethodQ.szPrototype = srcGetPrototype(SourceFile.Record.sText)
        MethodQ.bPrivate = CHOOSE(INSTRING(',PRIVATE',szUpper,1))
        MethodQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
        MethodQ.bVirtual = CHOOSE(INSTRING(',VIRTUAL',szUpper,1))
        MethodQ.lLineNum = glo:lLineNum
        MethodQ.lSourceLine = srcGetSourceLine(ClassQ.lModuleId,ClassQ.szClassName & '.' & MethodQ.szMethodName,MethodQ.szPrototype)
        MethodQ.lClassID = ClassQ.lClassID
        MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
        MethodQ.bModule = FALSE
        !Begin 2004.12.14 -----------------------------------------------
        MethodQ.bExtends = bExtends
        MethodQ.bFinal = bFinal
        MethodQ.bProc = CHOOSE(INSTRING(',PROC',szUpper,1))
        MethodQ.szDLL = srcGetPrototypeAttr('DLL',SourceFile.Record.sText)
        MethodQ.szExtName = srcGetPrototypeAttr('NAME',SourceFile.Record.sText)
        MethodQ.szCallConv = srcGetPrototypeAttr('CALLCONV',SourceFile.Record.sText)
        MethodQ.szReturnType = srcGetPrototypeAttr('RETURN',SourceFile.Record.sText)
        !End   2004.12.14 -----------------------------------------------
        ADD(MethodQ)
     ELSE
        !look for include statement
        K = INSTRING(' INCLUDE',szUpper,1)
        IF K !AND ~bProcessingInclude
           K = INSTRING('''',szUpper)
           IF K
              IncludeQ.szName = CLIP(szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
              IncludeQ.szPath = ProcessQ.szPath
              GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
              IF ERRORCODE()
                 !ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                 ADD(IncludeQ)
              END
           END
        ELSE
           !price                   decimal(10,2),PRIVATE
           K = INSTRING(' ',SourceFile.Record.sText) - 1
           PropertyQ.szPropertyName = SourceFile.Record.sText[1 : K]

           PropertyQ.szDataType =  LEFT(SUB(SourceFile.Record.sText,K+1,LEN(SourceFile.Record.sText)-K))

           IF (UPPER(SUB(PropertyQ.szDataType,1,7)) = 'DECIMAL') OR (UPPER(SUB(PropertyQ.szDataType,1,8)) = 'PDECIMAL')
              K = INSTRING(')',PropertyQ.szDataType) + 1
           ELSE
              K = INSTRING(',',PropertyQ.szDataType)
           END

           IF K
              PropertyQ.szDataType = PropertyQ.szDataType[1 : K-1]
           END
           PropertyQ.szDataType = CLIP(PropertyQ.szDataType)

           IF (CLIP(PropertyQ.szPropertyName) OR   |
              (PropertyQ.szPropertyName = '' AND (SUB(UPPER(PropertyQ.szDataType),1,5) = 'GROUP' OR SUB(UPPER(PropertyQ.szDataType),1,5) = 'QUEUE')))

              PropertyQ.bPrivate = CHOOSE(INSTRING(',PRIVATE',szUpper,1))
              PropertyQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
              PropertyQ.lLineNum = glo:lLineNum
              PropertyQ.lClassID = ClassQ.lClassID
              PropertyQ.szPropertySort = UPPER(PropertyQ.szPropertyName)
              PropertyQ.bModule = FALSE
              ADD(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)

              !!check for queue or group
              !!and bypass records until end found
              CASE SUB(UPPER(PropertyQ.szDataType),1,5)
              OF 'GROUP' OROF 'QUEUE'
                 bEndCount = 1
?              ASSERT(LEN(szUpper) <> 0)
                 IF szUpper[LEN(szUpper)] <> '.' AND szUpper[LEN(szUpper)-2 : LEN(szUpper)] <> 'END'
                    LOOP
                       IF bMultiStatement = TRUE
                          SourceFile.Record.sText = save:sMultiStatement
                          bMultiStatement = FALSE
                       ELSE
                          NEXT(SourceFile)
                       END
                       IF ERRORCODE()
                          lFilePctComplete = 100
                          FileProgressBox{PROP:Width} = lFilePctComplete*2
                          DISPLAY(FileProgressBox)
                          BREAK
                       ELSE

                          !!! remove extra whitespace from SourceFile.Record.sText here !!!
                          SourceFile.Record.sText = srcRemoveWhitespace(SourceFile.Record.sText)

                          glo:lLineNum += 1

                          lFileBytesProcessed = POINTER(SourceFile)
                          lFilePctComplete = (lFileBytesProcessed/lFileBytesToProcess)*100
                          IF lFileLastPct <> INT(lFilePctComplete/10)
                             lFileLastPct = INT(lFilePctComplete/10)
                             FileProgressBox{PROP:Width} = lFilePctComplete*2
                             DISPLAY(FileProgressBox)
                          END

                          szUpper = UPPER(CLIP(LEFT(SourceFile.Record.sText)))
                          !K = INSTRING('!',szUpper)
                          K = srcFindComment(szUpper)
                          IF K
                             szUpper[K] = '<0>'
                             szUpper = CLIP(szUpper)
                          END
                          IF INSTRING(' GROUP',szUpper,1) |
                          OR INSTRING(' QUEUE',szUpper,1)
                             bEndCount += 1
                          END
                          IF CLIP(LEFT(szUpper)) = 'END' OR |
                             CLIP(LEFT(szUpper)) = '.'
                             bEndCount -= 1
                             IF bEndCount = 0
                                BREAK
                             END
                          END
                       END
                    END
                 END
              END
           END
        END
     END
  END
  EXIT
ProcessStructure    ROUTINE
  IF INSTRING(' GROUP',szUpper,1) OR |
     INSTRING(' QUEUE',szUpper,1)
     bStructureCount += 1
  END
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     bStructureCount -= 1
     IF bStructureCount = 0
        bProcessingStructure = FALSE
     END
  ELSE
     StructureQ.szDataLabel = srcGetLabel(SourceFile.Record.sText)
     StructureQ.szDataType = srcGetStatement(SourceFile.Record.sText)
?    ASSERT(LEN(StructureQ.szDataType) <> 0)
     IF StructureQ.szDataType[LEN(StructureQ.szDataType)] = '.'
        StructureQ.szDataType[LEN(StructureQ.szDataType)] = '<0>'
        bStructureCount -= 1
        IF bStructureCount = 0
           bProcessingStructure = FALSE
        END
     END
     ModuleQ.szModulePath = ProcessQ.szPath
     ModuleQ.szModuleName = ProcessQ.szName
     ModuleQ.lDate        = ProcessQ.lDate
     ModuleQ.lTime        = ProcessQ.lTime
     GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
     IF ERRORCODE()
        lLastModuleId += 1
        ModuleQ.lModuleId = lLastModuleId
        ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
        ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
     ELSE
        ModuleQ.lDate        = ProcessQ.lDate
        ModuleQ.lTime        = ProcessQ.lTime
        PUT(ModuleQ)
     END
     StructureQ.lModuleId = ModuleQ.lModuleId

     StructureQ.lLineNum = glo:lLineNum
     StructureQ.bPrivate = FALSE
     ADD(StructureQ)
  END
  EXIT
ProcessEquate    ROUTINE
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     bProcessingEquate = FALSE
  ELSE
     IF EnumQ.szEnumPrefix
        EnumQ.szEnumLabel  = EnumQ.szEnumPrefix & ':' & srcGetLabel(SourceFile.Record.sText)
     ELSE
        EnumQ.szEnumLabel  = srcGetLabel(SourceFile.Record.sText)
     END

     K = INSTRING(' EQUATE',szUpper,1)  !start value specified?
     IF K
        K = INSTRING('(',szUpper,1,K+7)  !start value specified?
     END
     IF K AND szUpper[K+1] <> ')'
        K += 1
        M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
        EnumQ.szEnumValue = SourceFile.Record.sText[K : M]
        IF INSTRING('(',EnumQ.szEnumValue)
           EnumQ.szEnumValue = EnumQ.szEnumValue & ')'
        END
        EnumQ.bIsHexValue = FALSE
        IF EnumQ.szEnumValue[1] <> ''''
           IF ~NUMERIC(EnumQ.szEnumValue)
              EnumQ.szEnumValue = srcGetEquateValue(EnumQ.szEnumValue,EnumQ.bIsHexValue)
           END
        END
        lEnumValue = EnumQ.szEnumValue
     ELSE
        lEnumValue += 1
        EnumQ.szEnumValue = lEnumValue
     END

     IF K AND ~EnumQ.szEnumValue
        EnumQ.szEnumValue = SourceFile.Record.sText[K : M]
        IF INSTRING('(',EnumQ.szEnumValue)
           EnumQ.szEnumValue = EnumQ.szEnumValue & ')'
        END
     END

     ModuleQ.szModulePath = ProcessQ.szPath
     ModuleQ.szModuleName = ProcessQ.szName
     ModuleQ.lDate        = ProcessQ.lDate
     ModuleQ.lTime        = ProcessQ.lTime
     GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
     IF ERRORCODE()
        lLastModuleId += 1
        ModuleQ.lModuleId = lLastModuleId
        ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
        ADD(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
     ELSE
        ModuleQ.lDate        = ProcessQ.lDate
        ModuleQ.lTime        = ProcessQ.lTime
        PUT(ModuleQ)
     END
     EnumQ.lModuleId = ModuleQ.lModuleId

     EnumQ.lLineNum     = glo:lLineNum
     EnumQ.bIsEquate    = FALSE
     ADD(EnumQ)
  END
  EXIT
AddInterfaceMethods ROUTINE
  DATA
Ptr LONG

  CODE
  Ptr = 1
  LOOP
     K = INSTRING(',IMPLEMENTS(',szUpper,1,Ptr)
     IF ~K
        K = INSTRING(', IMPLEMENTS(',szUpper,1,Ptr)
        IF K
           K += 13
        END
     ELSE
        K += 12
     END
     IF K
        Ptr = K
        ClassInterfaceQ.lClassId = ClassQ.lClassID
        ClassInterfaceQ.szInterface = SourceFile.Record.sText[K : INSTRING(')',SourceFile.Record.sText,1,K+1)-1]
        GET(ClassInterfaceQ,+ClassInterfaceQ.lClassId,+ClassInterfaceQ.szInterface)
        IF ERRORCODE()
           ADD(ClassInterfaceQ,+ClassInterfaceQ.lClassId,+ClassInterfaceQ.szInterface)
        END
     ELSE
        BREAK
     END
  END
  EXIT
FillSearchQ     ROUTINE
  IF EXISTS(glo:szRedFilePath)
     FREE(SearchQ)
     srcGetSearchFoldersFromRedFile(SearchQ, glo:szRedFilePath)
  ELSE
     MESSAGE('Redirection File [' & glo:szRedFilePath & '] not found','Redirection File Error',ICON:HAND)
  END
FindAllModules  ROUTINE
  DO FillSearchQ
  J = RECORDS(SearchQ)
  LOOP I = 1 TO J
    GET(SearchQ,I)
    DIRECTORY(FileQ,SearchQ.szPath & '*.inc',0)
    N = RECORDS(FileQ)
    LOOP M = 1 TO N
      GET(FileQ,M)
      ProcessQ.szName = CLIP(UPPER(FileQ.name))
      ProcessQ.szPath = UPPER(SearchQ.szPath)
      ProcessQ.bProcessed = FALSE
      ProcessQ.lDate = FileQ.Date
      ProcessQ.lTime = FileQ.Time
      GET(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
      IF ERRORCODE()
         ADD(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
      END
    END
    FREE(FileQ)
  END
  EXIT
FindChangedModules  ROUTINE
  DATA
P               LONG
X               LONG
loc:szFileName  CSTRING(256)

  CODE
  X = RECORDS(ModuleQ)
  LOOP P = 1 TO X
     GET(ModuleQ,P)
     FREE(TempQ)
     DIRECTORY(TempQ,ModuleQ.szModulePath & ModuleQ.szModuleName,0)
     IF RECORDS(TempQ)
        GET(TempQ,1)
        IF TempQ.Date <> ModuleQ.lDate OR TempQ.Time <> ModuleQ.lTime
           IF SUB(UPPER(ModuleQ.szModuleName),LEN(ModuleQ.szModuleName)-2,3) = 'INC'
              ProcessQ.szName = UPPER(ModuleQ.szModuleName)
              ProcessQ.szPath = UPPER(ModuleQ.szModulePath)
              ProcessQ.bProcessed = FALSE
              ProcessQ.lDate = TempQ.Date
              ProcessQ.lTime = TempQ.Time
              GET(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
              IF ERRORCODE()
                 ADD(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
              END
           ELSIF SUB(UPPER(ModuleQ.szModuleName),LEN(ModuleQ.szModuleName)-2,3) = 'CLW'
              ProcessQ.szName = SUB(UPPER(ModuleQ.szModuleName),1,LEN(ModuleQ.szModuleName)-3) & 'INC'
              ProcessQ.szPath = UPPER(ModuleQ.szModulePath)

              !make sure inc file exists
              loc:szFileName = ProcessQ.szPath & ProcessQ.szName
              IF _access(loc:szFileName,0) = 0     !INC file does exist
                 ProcessQ.bProcessed = FALSE
                 ProcessQ.lDate = TempQ.Date
                 ProcessQ.lTime = TempQ.Time
                 GET(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
                 IF ERRORCODE()
                    ADD(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
                 END

                 IncludeQ.szName = UPPER(ModuleQ.szModuleName)
                 IncludeQ.szPath = UPPER(ModuleQ.szModulePath)
                 GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                 IF ERRORCODE()
                    IncludeQ.bDelete = TRUE
                    !ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                    ADD(IncludeQ)
                 END
              ELSE
                 IncludeQ.szName = UPPER(ModuleQ.szModuleName)
                 IncludeQ.szPath = UPPER(ModuleQ.szModulePath)
                 GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                 IF ERRORCODE()
                    IncludeQ.bDelete = FALSE
                    !ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                    ADD(IncludeQ)
                 END
              END

           ELSE
              IncludeQ.szName = UPPER(ModuleQ.szModuleName)
              IncludeQ.szPath = UPPER(ModuleQ.szModulePath)
              GET(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
              IF ERRORCODE()
                 IncludeQ.bDelete = FALSE
                 !ADD(IncludeQ,+IncludeQ.szName,+IncludeQ.szPath)
                 ADD(IncludeQ)
              END
           END
        END
     END
  END
  EXIT
RemoveChangedModules    ROUTINE
  DATA
X   LONG
Z   LONG

  CODE
  X = RECORDS(ProcessQ)
  LOOP Z = 1 TO X
     GET(ProcessQ,Z)
     ModuleQ.szModuleName = ProcessQ.szName
     ModuleQ.szModulePath = ProcessQ.szPath
     DO RemoveChangedModule
  END

  X = RECORDS(IncludeQ)
  LOOP Z = X TO 1 BY -1
     GET(IncludeQ,Z)
     ModuleQ.szModuleName = IncludeQ.szName
     ModuleQ.szModulePath = IncludeQ.szPath
     DO RemoveChangedModule
     IF IncludeQ.bDelete = TRUE
        DELETE(IncludeQ)                         !<<<<========= THIS IS THE STATEMENT ON WHICH THE GPF IS OCCURING
     END
  END
RemoveChangedModule    ROUTINE
  DATA
P   LONG
C   LONG
S   LONG
E   LONG
X   LONG
Y   LONG

  CODE
  GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
  IF ~ERRORCODE()
     !remove classes
     LOOP C = RECORDS(ClassQ) TO 1 BY -1
        GET(ClassQ,C)
        IF ClassQ.lModuleId = ModuleQ.lModuleId OR   |
           ClassQ.lIncludeId = ModuleQ.lModuleId
           !CategoryQ
           CategoryQ.szClassName = ClassQ.szClassName
           GET(CategoryQ,+CategoryQ.szClassName)
           IF ~ERRORCODE()
              DELETE(CategoryQ)
           END
           !PropertyQ
           LOOP P = RECORDS(PropertyQ) TO 1 BY -1
              GET(PropertyQ,P)
              IF PropertyQ.lClassID = ClassQ.lClassID
                 DELETE(PropertyQ)
              END
           END
           !MethodQ
           LOOP P = RECORDS(MethodQ) TO 1 BY -1
              GET(MethodQ,P)
              IF MethodQ.lClassID = ClassQ.lClassID
                 DELETE(MethodQ)
              END
           END
           !CallQ
           LOOP P = RECORDS(CallQ) TO 1 BY -1
              GET(CallQ,P)
              IF SUB(CallQ.szCallingMethod,1,INSTRING('.',CallQ.szCallingMethod)-1) = ClassQ.szClassName
                 DELETE(CallQ)
              END
           END

           DELETE(ClassQ)
        END
     END

     !Remove Structures
     LOOP S = RECORDS(StructureQ) TO 1 BY -1
        GET(StructureQ,S)
        IF StructureQ.lModuleId = ModuleQ.lModuleId
           DELETE(StructureQ)
        END
     END

     !Remove Enums
     LOOP E = RECORDS(EnumQ) TO 1 BY -1
        GET(EnumQ,E)
        IF EnumQ.lModuleId = ModuleQ.lModuleId
           DELETE(EnumQ)
        END
     END

     FileNameQ.sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
     GET(FileNameQ,+FileNameQ.sFileName)
     IF ~ERRORCODE()                           !file has not been scanned
        Y = RECORDS(SourceLineQ)
        LOOP X = Y TO 1 BY -1
           GET(SourceLineQ,X)
           IF SourceLineQ.sFileName = FileNameQ.sFileName
              DELETE(SourceLineQ)
           END
        END
        Y = RECORDS(LineCommentQ)
        LOOP X = Y TO 1 BY -1
           GET(LineCommentQ,X)
           IF LineCommentQ.sFileName = FileNameQ.sFileName
              DELETE(LineCommentQ)
           END
        END
        DELETE(FileNameQ)
     END

     DELETE(ModuleQ)
  END
FindNewModules  ROUTINE
  DATA
szSavePath  CSTRING(256)
szFullPath  CSTRING(256)
pszFilePart LONG
cc          LONG

  CODE
  DO FillSearchQ
  J = RECORDS(SearchQ)
  LOOP I = 1 TO J
    GET(SearchQ,I)
    DIRECTORY(FileQ,SearchQ.szPath & '*.inc',0)
    N = RECORDS(FileQ)
    LOOP M = 1 TO N
      GET(FileQ,M)

      ModuleQ.szModuleName = CLIP(UPPER(FileQ.name))
      ModuleQ.szModulePath = UPPER(SearchQ.szPath)
      GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
      IF ERRORCODE()
         ProcessQ.szName = CLIP(UPPER(FileQ.name))
         ProcessQ.szPath = UPPER(SearchQ.szPath)
         ProcessQ.bProcessed = FALSE
         ProcessQ.lDate = FileQ.Date
         ProcessQ.lTime = FileQ.Time
         GET(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
         IF ERRORCODE()
            ADD(ProcessQ,+ProcessQ.szPath,+ProcessQ.szName)
         END
      END
    END
    FREE(FileQ)
  END
  EXIT
FixupEnumQ  ROUTINE
!==============================================================================
! This routine attempts for find a common prefix for unlabelled enumeration
! types to try and give them a more meaningful name.
!==============================================================================
  DATA
Q_Records           LONG,AUTO
ptrQ                LONG,AUTO
ptrStrutureStart    LONG,AUTO
ptrStrutureEnd      LONG,AUTO
ptrToken            LONG,AUTO
sav:szEnumSort      LIKE(EnumQ.szEnumSort),AUTO
sav:szEnumName      LIKE(EnumQ.szEnumName),AUTO
sav:lModuleId       LIKE(EnumQ.lModuleId),AUTO

  CODE
  ! sort the enumq
  SORT(EnumQ,+EnumQ.szEnumSort,+EnumQ.lModuleId,+EnumQ.szEnumLabel)

  !look for '_U'nlabelled Types
  Q_Records = RECORDS(EnumQ)
  LOOP ptrQ = 1 TO Q_Records
     GET(EnumQ,ptrQ)
     IF EnumQ.szEnumSort[1 : 2] = '_U'
        !found one
        IF EnumQ.szEnumLabel = ''
           sav:szEnumSort = EnumQ.szEnumSort
           sav:szEnumName = EnumQ.szEnumLabel
           sav:lModuleId  = EnumQ.lModuleId
           ptrStrutureStart = ptrQ

           ! find the end of this structure
           LOOP
              IF ptrQ < Q_Records
                 ptrQ += 1
                 GET(EnumQ,ptrQ)
                 IF EnumQ.szEnumSort = sav:szEnumSort AND EnumQ.lModuleId = sav:lModuleId
                    IF sav:szEnumName = ''
                       ptrToken = INSTRING(':',EnumQ.szEnumLabel)
                       IF ptrToken
                          sav:szEnumName = EnumQ.szEnumLabel[1 : ptrToken-1]
                       ELSE
                          ptrToken = INSTRING('_',EnumQ.szEnumLabel)
                          IF ptrToken
                             sav:szEnumName = EnumQ.szEnumLabel[1 : ptrToken-1]
                          END
                       END
                    END
                 ELSE
                    ptrStrutureEnd = ptrQ - 1
                    BREAK
                 END
              ELSE
                 ptrStrutureEnd = Q_Records
                 BREAK
              END
           END

           IF sav:szEnumName
              ! see if they all match
              LOOP ptrQ = ptrStrutureStart+1 TO ptrStrutureEnd
                 GET(EnumQ,ptrQ)
                 IF EnumQ.szEnumLabel[1 : LEN(sav:szEnumName)] <> sav:szEnumName
                    BREAK  !break early on no match
                 END
              END

              IF ptrQ > ptrStrutureEnd     ! if they all matched
                 LOOP ptrQ = ptrStrutureStart TO ptrStrutureEnd
                    GET(EnumQ,ptrQ)
                    EnumQ.szEnumName = sav:szEnumName
                    EnumQ.szEnumSort = UPPER(sav:szEnumName)
                    PUT(EnumQ)
                 END
              END
           END

           ptrQ = ptrStrutureEnd
           GET(EnumQ,ptrQ)
       END
     END
  END
CopyStructureQ   ROUTINE
!need to create a copy of the structure queue when doing a scan
!this copy is used for fixing up pointers to structures
!doing this allows the program to identify structures that may not have been 'found' yet
!particularly when doing a full scan as the StructureQ is freed.
  DATA
I       LONG,AUTO
J       LONG,AUTO

  CODE
    FREE(glo:StructureQCopy)
    J = RECORDS(StructureQ)
    LOOP I = 1 TO J
       GET(StructureQ,I)
       glo:StructureQCopy = StructureQ
       ADD(glo:StructureQCopy)
    END
HandleRedirectionMacros ROUTINE
  DATA
I       LONG,AUTO
J       LONG,AUTO
N       LONG,AUTO

  CODE
    N = RECORDS(RedirectionQueue)
    LOOP I = 1 TO N
       GET(RedirectionQueue,I)
       LOOP
          J = INSTRING(RedirectionQueue.Token,UPPER(SearchQ.szPath),1)
          IF J
             SearchQ.szPath = SUB(SearchQ.szPath,1,J-1) & RedirectionQueue.Path & SUB(SearchQ.szPath,J+LEN(RedirectionQueue.Token),LEN(SearchQ.szPath)-J+LEN(RedirectionQueue.Token)-1)
          ELSE
             BREAK
          END
       END
    END
