

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
!!! Build Method Calling Queue
!!! </summary>
srcBuildCallQueue    PROCEDURE  (ScanString, ProgressBox, FileProgressBox) ! Declare Procedure
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
I                       LONG
J                       LONG
K                       LONG
M                       LONG
szX                     CSTRING(255)
bABC                    BYTE(FALSE)
bInCode                 BYTE
bProcessingMap          BYTE
bDeclaringClass         BYTE
bProcessingClass        BYTE
lLastClassId            LONG
bProcessingStructure    BYTE
bProcessingEquate       BYTE
szCategory              CSTRING(64)
szThisClass             CSTRING(64)
szThisParent            CSTRING(64)
szOmitTerminator        CSTRING(64)
ClassQRecords           LONG
ClassQPointer           LONG
lFileQPointer           LONG
lFileQRecords           LONG

FileQ                   QUEUE,PRE(Q)
szFileName                CSTRING(256)
szModulePath              CSTRING(256)
szModuleName              CSTRING(64)
lModuleId                 LONG
szClassName               CSTRING(64)
szParentClassName         CSTRING(64)
                        END

szUpper                 CSTRING(1024)
save:sText              CSTRING(1024)
lEnumValue              LONG
lUnlabelledCount        LONG(0)

!Variables for progress indicator
lLastPct                LONG
lPctComplete            LONG

!Variables for file progress indicator
lFileBytesToProcess     LONG
lFileBytesProcessed     LONG
lFilePctComplete        LONG
lFileLastPct            LONG

!Variables used in LookForReferences Routine
szDataType              CSTRING(64)
szClassName             CSTRING(64)
bMultiStatement         BYTE(0)         !true = processing multi statement line
save:sMultiStatement    CSTRING(4096)   !save area for multiple statement source line

szSearchModule          CSTRING(260)
szSearchModulePath      CSTRING(256)
szSearchModuleName      CSTRING(64)

IncludeQ                QUEUE,PRE(IncludeQ)
szFileName                CSTRING(256)
szModulePath              CSTRING(256)
szModuleName              CSTRING(64)
lModuleId                 LONG
szClassName               CSTRING(64)
szParentClassName         CSTRING(64)
                        END

bFinal                  BYTE
bExtends                BYTE
loc:szCompactAsciiFilename cstring(65)

  CODE
  ProgressBox{PROP:WIDTH} = 100
  DISPLAY(ProgressBox)
  lLastPct = 0
  lPctComplete = 0

  FileProgressBox{PROP:WIDTH} = 0
  DISPLAY(FileProgressBox)
  lFileLastPct = 0
  lFilePctComplete = 0

  IF glo:bRefreshAll
     FREE(CallQ)                                         !Free the CallQ
  END

  SORT(ClassQ,+ClassQ.lClassId)
  GET(ClassQ,RECORDS(ClassQ))
  lLastClassId = ClassQ.lClassId
  !SORT(ClassQ,+ClassQ.szClassSort)
  !szClassSort = 'SORT(ClassQ,+ClassQ.szClassSort)'
  SORT(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
  SORT(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
  SORT(StructureQ,+StructureQ.szStructureSort)
  SORT(ModuleQ,+ModuleQ.lModuleId)

  !make a list of files to process
  FREE(FileQ)
  ClassQRecords = RECORDS(ClassQ)                     ! Get record counts
  LOOP ClassQPointer = 1 TO ClassQRecords             ! For each Class
     GET(ClassQ,ClassQPointer)                        !   Get class record
     IF ClassQ.bModified
        ClassQ.bModified = FALSE
        PUT(ClassQ)
        IF ClassQ.lModuleId
           ModuleQ.lModuleId = ClassQ.lModuleId
           GET(ModuleQ,+ModuleQ.lModuleId)
           IF UPPER(SUB(ModuleQ.szModuleName,-3,3)) = 'DLL' |
           OR UPPER(SUB(ModuleQ.szModuleName,-3,3)) = 'LIB'
              !do not scan
           ELSE
              szAsciiFilename = ModuleQ.szModulePath & ModuleQ.szModuleName
              FileQ.szFileName = UPPER(szAsciiFilename)
              GET(FileQ,+FileQ.szFileName)
              IF ERRORCODE()
                 FileQ.szModulePath = ModuleQ.szModulePath
                 FileQ.szModuleName = ModuleQ.szModuleName
                 FileQ.lModuleId = ModuleQ.lModuleId
                 FileQ.szClassName = ClassQ.szClassName
                 FileQ.szParentClassName = ClassQ.szParentClassName
                 ADD(FileQ,+FileQ.szFileName)
              END
           END
        END
     END
  END

  !loop until we process all included files
  !============================================================================
  LOOP WHILE RECORDS(FileQ)
     !scan the class definition modules
     lFileQRecords = RECORDS(FileQ)
     lFileQPointer = 0
     LOOP lFileQPointer = 1 TO lFileQRecords
        GET(FileQ,lFileQPointer)
        szAsciiFilename = FileQ.szFileName
        !ScanString{PROP:TEXT} = szAsciiFilename
        PathCompactPathEx(loc:szCompactAsciiFilename, szAsciiFilename, SIZE(loc:szCompactAsciiFilename),0)
        ScanString{PROP:TEXT} = loc:szCompactAsciiFilename
        DISPLAY(ScanString)

        bInCode = FALSE
        bProcessingClass = FALSE
        bProcessingStructure = FALSE
        bProcessingEquate = FALSE
        bProcessingMap = FALSE
        glo:lLineNum = 0
        szOmitTerminator = ''

        OPEN(SourceFile,ReadOnly+DenyNone)   !Read-Only
        lFileBytesToProcess = BYTES(SourceFile)
        lFileBytesProcessed = 0
        lFileLastPct = 0
        lFilePctComplete = 0
        FileProgressBox{PROP:WIDTH} = 0
        DISPLAY(FileProgressBox)

        SET(SourceFile)
        LOOP
          YIELD()
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
             IF szOmitTerminator = ''
                K = srcFindComment(SourceFile.Record.sText)
                IF K
                   IF UPPER(SourceFile.Record.sText[K : K+14]) = '!ABCINCLUDEFILE' |
                   OR UPPER(SourceFile.Record.sText[K : K+8]) = '!CATEGORY'
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
                   szUpper = SUB(szUpper,1,LEN(szUpper)-1) & ' ' & UPPER(CLIP(LEFT(SourceFile.Record.sText)))
                   SourceFile.Record.sText = save:stext & SourceFile.Record.sText
                ELSE
                   szUpper = UPPER(CLIP(SourceFile.Record.sText))
                END
             ELSE
                szUpper = UPPER(CLIP(SourceFile.Record.sText))
             END

             IF szUpper AND glo:bRefreshAll = TRUE
                K = INSTRING(' INCLUDE',szUpper,1)
                IF K
                   K = INSTRING('''',szUpper,1)
                   IF K
                      szSearchModulePath = ''
                      szSearchModuleName = szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1]
                      srcFindModule(szSearchModulePath,szSearchModuleName)
                      IF szSearchModulePath <> ''
                         szSearchModule = UPPER(szSearchModulePath & szSearchModuleName)
                         !szSearchModule = UPPER(FileQ.szModulePath & szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
                         LOOP M# = 1 TO RECORDS(ModuleQ)
                           GET(ModuleQ,M#)
                           IF szSearchModule = UPPER(ModuleQ.szModulePath & ModuleQ.szModuleName)
                              BREAK
                           END
                         END
                         IF M# > RECORDS(ModuleQ)
                            GET(ModuleQ,RECORDS(ModuleQ))
                            ModuleQ.szModulePath = szSearchModulePath  !FileQ.szModulePath
                            ModuleQ.szModuleName = szSearchModuleName  !CLIP(szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
                            ModuleQ.lModuleId += 1
                            ModuleQ.lDate = TODAY()
                            ModuleQ.lTime = CLOCK()
                            ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                            ADD(ModuleQ,+ModuleQ.lModuleId)

                            IncludeQ.szFileName = UPPER(ModuleQ.szModulePath & ModuleQ.szModuleName)
                            IncludeQ.szModulePath = ModuleQ.szModulePath
                            IncludeQ.szModuleName = ModuleQ.szModuleName
                            IncludeQ.lModuleId = ModuleQ.lModuleId
                            IncludeQ.szClassName = ClassQ.szClassName
                            IncludeQ.szParentClassName = ClassQ.szParentClassName
                            ADD(IncludeQ)
                         END
                      END
                   END
                END
             END

             IF ~szUpper
                CYCLE
             ELSIF szUpper[LEN(szUpper)] = '|'
                save:stext = SourceFile.Record.sText[1 : LEN(szUpper)-1] & ' '
                CYCLE
             ELSIF szOmitTerminator AND ~INSTRING(szOmitTerminator,szUpper,1)
                szUpper = ''
                CYCLE
             ELSE
                IF szOmitTerminator
                   szOmitTerminator = ''
                   CYCLE
                END
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

                K = srcFindComment(SourceFile.Record.sText)
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
                      CYCLE
                   END
                END

                IF CLIP(LEFT(szUpper)) = 'MAP'
                   bProcessingMap = TRUE
                   CYCLE
                END

                IF bProcessingMap
                   DO ProcessMap
                   CYCLE
                END

                IF (INSTRING(' PROCEDURE',szUpper,1) OR INSTRING(' FUNCTION',szUpper,1))    |
                AND ~bProcessingClass
                   CallQ.szCallingMethod = srcGetLabel(SourceFile.Record.sText)
                   IF ~INSTRING('.',CallQ.szCallingMethod)
                      !First parameter is class name
                      K = INSTRING('PROCEDURE(',szUpper,1)
                      IF K
                         K += 10
                      ELSE
                         K = INSTRING('FUNCTION(',szUpper,1)
                         IF K
                            K += 9
                         END
                      END
                      IF K <> 0
                         szX = CLIP(LEFT(SourceFile.Record.sText[K : LEN(SourceFile.Record.sText)]))
                         J = INSTRING(' ',szX,1)
                         IF J
                            K = INSTRING(',',szX,1)
                            IF K AND K < J
                               CallQ.szCallingMethod = szX[1 : K-1] & '.' & CallQ.szCallingMethod
                            ELSE
                               CallQ.szCallingMethod = szX[1 : J-1] & '.' & CallQ.szCallingMethod
                            END
                         ELSE
                            J = INSTRING(',',szX,1)
                            IF J
                               CallQ.szCallingMethod = szX[1 : J-1] & '.' & CallQ.szCallingMethod
                            ELSE
                               J = INSTRING(')',szX,1)
?                             ASSERT(J <> 0)
                               CallQ.szCallingMethod = szX[1 : J-1] & '.' & CallQ.szCallingMethod
                            END
                         END
                      END
                   END
                   K = INSTRING('.',CallQ.szCallingMethod)
                   IF K
                      SORT(ClassQ,+ClassQ.szClassSort)
                      ClassQ.szClassSort = UPPER(CallQ.szCallingMethod[1 : K-1])
                      GET(ClassQ,+ClassQ.szClassSort)
                      IF ~ERRORCODE()
                         !NOTE: May be the wrong one but no way to distinguish
                         !      if the database contains two classes with same name
                         !      but different source files
                         szThisClass = ClassQ.szClassName
                         szThisParent = ClassQ.szParentClassName
                      END
                      bInCode = FALSE
                      bProcessingClass = TRUE
                      bDeclaringClass = FALSE
                   ELSE
                      szThisClass = ClassQ.szClassName
                      szThisParent = ClassQ.szParentClassName
                      bInCode = FALSE
                      bProcessingClass = TRUE
                      bDeclaringClass = FALSE
                   END
                   CYCLE
                ELSIF UPPER(CLIP(LEFT(SourceFile.Record.sText))) = 'CODE'
                   bInCode = TRUE
                   bProcessingClass = FALSE
                   bDeclaringClass = FALSE
                   CYCLE
                END
                IF ~bInCode
                   DO LookForClass
                ELSIF szThisClass
                   srcGetCalledMethods(SourceFile.Record.sText,szThisClass,szThisParent)
                END
             END
          END
        END
        CLOSE(SourceFile)

        lPctComplete = (lFileQPointer/(RECORDS(FileQ) + RECORDS(IncludeQ)))*100
        IF lPctComplete <> lLastPct
           lLastPct = lPctComplete
           ProgressBox{PROP:WIDTH} = lPctComplete + 100
           DISPLAY(ProgressBox)
        END
     END !Loop for each source file

     !reload fileQ with included files
     !=========================================================================
     FREE(FileQ)
     J = RECORDS(IncludeQ)
     LOOP I = 1 TO J
        GET(Includeq,I)
        !FileQ = IncludeQ

        FileQ.szFileName        = IncludeQ.szFileName
        FileQ.szModulePath      = IncludeQ.szModulePath
        FileQ.szModuleName      = IncludeQ.szModuleName
        FileQ.lModuleId         = IncludeQ.lModuleId
        FileQ.szClassName       = IncludeQ.szClassName
        FileQ.szParentClassName = IncludeQ.szParentClassName

        ADD(FileQ)
     END
     FREE(IncludeQ)
  END   !LOOP
  RETURN
LookForClass    ROUTINE
  DATA
bAddClass       BYTE
ptr             LONG

  CODE
  IF ~bProcessingClass    !look for class definition
     SORT(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
     ModuleQ.szModulePath = FileQ.szModulePath
     ModuleQ.szModuleName = FileQ.szModuleName
     GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)

?  ASSERT(~ERRORCODE())

     IF INSTRING(' CLASS,',szUpper,1)       OR |
        INSTRING(' CLASS()',szUpper,1)      OR |
        INSTRING(' INTERFACE,',szUpper,1)   OR |
        INSTRING(' INTERFACE ',szUpper,1)   OR |
        UPPER(SUB(CLIP(SourceFile.Record.sText),-6,6)) = ' CLASS'  OR |    !base class
        UPPER(SUB(CLIP(SourceFile.Record.sText),-10,10)) = ' INTERFACE'    !Interface
        K = INSTRING(' ',SourceFile.Record.sText) - 1
      !ASSERT(K <> 0) - 2006.12.08 RR removed because search string could be in a quoted string in a window declaration eg.
        IF K <> 0
           ClassQ.szClassName = SourceFile.Record.sText[1 : K]
           IF CLIP(ClassQ.szClassName)              !make sure class has a name
              SORT(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)
              ClassQ.szClassSort = UPPER(SourceFile.Record.sText[1 : K])
              ClassQ.lModuleId = ModuleQ.lModuleId
              GET(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)

              IF ERRORCODE()
                 bAddClass = TRUE
              ELSE
                 bAddClass = FALSE
              END

              ClassQ.szParentClassName = ''
              ClassQ.lIncludeId = ModuleQ.lModuleId
              ClassQ.lModuleId =  ModuleQ.lModuleId
              ClassQ.bIsABC = bABC
              ClassQ.lLineNum = glo:lLineNum
              ClassQ.szClassSort = UPPER(ClassQ.szClassName)
              ClassQ.szParentClassSort = ''
              ClassQ.bPrivate = TRUE
              IF INSTRING(' INTERFACE,',szUpper,1)    OR |
                 UPPER(SUB(CLIP(SourceFile.Record.sText),-10,10)) = ' INTERFACE'    !Interface
                 ClassQ.bInterface = TRUE
              ELSE
                 ClassQ.bInterface = FALSE
              END
              ClassQ.bModified = FALSE !because we are processing it now
              IF bAddClass
                 lLastClassId += 1
                 ClassQ.lClassID = lLastClassId
                 ADD(ClassQ,+ClassQ.szClassSort)
              ELSE
                 PUT(ClassQ)
              END

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
              IF SUB(szUpper,-1,1) = '.'   |
              OR SUB(szUpper,-3,3) = 'END'
                 bProcessingClass = FALSE
                 bDeclaringClass = FALSE
              ELSE
                 bProcessingClass = TRUE
                 bDeclaringClass = TRUE
              END
           END
        END

     ELSIF INSTRING(' CLASS(',szUpper,1)  OR |  !derived class
           INSTRING(' INTERFACE(',szUpper,1)    !derived interface
        K = INSTRING(' ',SourceFile.Record.sText) - 1
      !ASSERT(K <> 0) - 2006.12.08 RR removed because search string could be in a quoted string in a window declaration eg.
        IF K <> 0
           ClassQ.szClassName = SourceFile.Record.sText[1 : K]
           IF CLIP(ClassQ.szClassName)              !make sure class has a name
              SORT(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)
              ClassQ.szClassSort = UPPER(SourceFile.Record.sText[1 : K])
              ClassQ.lModuleId = ModuleQ.lModuleId
              GET(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)

              IF ERRORCODE()
                 bAddClass = TRUE
              ELSE
                 bAddClass = FALSE
              END

              K = INSTRING(' CLASS(',szUpper,1)
              IF K
                 K += 7
              ELSE
                 K = INSTRING(' INTERFACE(',szUpper,1) + 11
              END
              M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
              ClassQ.szParentClassName = SourceFile.Record.sText[K : M]

              ClassQ.lIncludeId = ModuleQ.lModuleId
              ClassQ.lModuleId = ModuleQ.lModuleId

              ClassQ.bIsABC = bABC
              ClassQ.lLineNum = glo:lLineNum
              ClassQ.szClassSort = UPPER(ClassQ.szClassName)
              ClassQ.szParentClassSort = UPPER(ClassQ.szParentClassName)
              ClassQ.bPrivate = TRUE
              IF INSTRING(' INTERFACE(',szUpper,1)    !derived interface
                 ClassQ.bInterface = TRUE
              ELSE
                 ClassQ.bInterface = FALSE
              END
              ClassQ.bModified = FALSE !because we are processing it
              IF bAddClass
                 lLastClassId += 1
                 ClassQ.lClassID = lLastClassId
                 ADD(ClassQ,+ClassQ.szClassSort)
              ELSE
                 PUT(ClassQ)
              END

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
              END

              IF SUB(szUpper,-1,1) = '.'   |
              OR SUB(szUpper,-3,3) = 'END'
                 bProcessingClass = FALSE
                 bDeclaringClass = FALSE
              ELSE
                 bProcessingClass = TRUE
                 bDeclaringClass = TRUE
              END
           END
        END
     ELSE
        DO LookForStructure
     END
     SORT(ModuleQ,+ModuleQ.lModuleId)
  ELSE !look for properties and methods
     DO ProcessClass
  END
  EXIT
ProcessMap ROUTINE
  DATA
szTemp  CSTRING(256)
fAdd    BYTE
pToken  LONG

  CODE
  !Look for END or .
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     bProcessingMap = FALSE
  ELSE
     !First parameter is class name
     K = INSTRING('PROCEDURE(',szUpper,1)
     IF K
        K += 10
     ELSE
        K = INSTRING('FUNCTION(',szUpper,1)
        IF K
           K += 9
        END
     END
     IF K <> 0
        szTemp = CLIP(LEFT(SourceFile.Record.sText[K : LEN(SourceFile.Record.sText)]))
        J = INSTRING(' ',szTemp,1)
        IF J
           K = INSTRING(',',szTemp,1)
           IF K AND K < J
              ClassQ.szClassName = szTemp[1 : K-1]
           ELSE
              ClassQ.szClassName = szTemp[1 : J-1]
           END
        ELSE
           J = INSTRING(',',szTemp,1)
           IF J
              ClassQ.szClassName = szTemp[1 : J-1]
           ELSE
              J = INSTRING(')',szTemp,1)
?            ASSERT(J <> 0)
              ClassQ.szClassName = szTemp[1 : J-1]
           END
        END
        !see if valid class

        szTemp = ClassQ.szClassName
        SORT(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)
        ClassQ.szClassSort = UPPER(szTemp)
        ClassQ.lModuleId = FileQ.lModuleId
        GET(ClassQ,+ClassQ.szClassSort,+ClassQ.lModuleId)

        IF ~ERRORCODE()
           !if it is, add this as a method of the class
           K = INSTRING(' ',SourceFile.Record.sText) - 1
           MethodQ.lClassID = ClassQ.lClassID
           MethodQ.szMethodName = SourceFile.Record.sText[1 : K]
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
           MethodQ.bModule = CHOOSE(UPPER(SUB(ModuleQ.szModuleName,-4,4))='.CLW',TRUE,FALSE)

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
  END
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
  MethodQ.bModule = CHOOSE(UPPER(SUB(ModuleQ.szModuleName,-4,4))='.CLW',TRUE,FALSE)
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

!==============================================================================
ProcessClass ROUTINE
  DATA
bEndCount   BYTE
bAdd        BYTE

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
        MethodQ.lClassID = ClassQ.lClassID
        MethodQ.szMethodName = SourceFile.Record.sText[1 : K]
        MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
        GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
        IF ERRORCODE()
           bAdd = TRUE
        ELSE
           bAdd = FALSE
        END

        MethodQ.szPrototype = srcGetPrototype(SourceFile.Record.sText)
        MethodQ.bPrivate = TRUE
        MethodQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
        MethodQ.bVirtual = CHOOSE(INSTRING(',VIRTUAL',szUpper,1))
        MethodQ.lLineNum = glo:lLineNum
        MethodQ.lSourceLine = srcGetSourceLine(ClassQ.lModuleId,ClassQ.szClassName & '.' & MethodQ.szMethodName,MethodQ.szPrototype)
        MethodQ.lClassID = ClassQ.lClassID
        MethodQ.szMethodSort = UPPER(MethodQ.szMethodName)
        MethodQ.bModule = TRUE
        !Begin 2004.12.14 -----------------------------------------------
        MethodQ.bExtends = bExtends
        MethodQ.bFinal = bFinal
        MethodQ.bProc = CHOOSE(INSTRING(',PROC',szUpper,1))
        MethodQ.szDLL = srcGetPrototypeAttr('DLL',SourceFile.Record.sText)
        MethodQ.szExtName = srcGetPrototypeAttr('NAME',SourceFile.Record.sText)
        MethodQ.szCallConv = srcGetPrototypeAttr('CALLCONV',SourceFile.Record.sText)
        MethodQ.szReturnType = srcGetPrototypeAttr('RETURN',SourceFile.Record.sText)
        !End   2004.12.14 -----------------------------------------------

        IF bAdd = TRUE
           ADD(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
        ELSE
           PUT(MethodQ)
        END

     ELSE
        !look for include statement
        K = INSTRING(' INCLUDE',szUpper,1)
        IF K
           K = INSTRING('''',szUpper,1)
           IF K
              szSearchModulePath = ''
              szSearchModuleName = szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1]
              srcFindModule(szSearchModulePath,szSearchModuleName)
              IF szSearchModulePath <> ''
                 szSearchModule = UPPER(szSearchModulePath & szSearchModuleName)
                 !szSearchModule = UPPER(FileQ.szModulePath & szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
                 LOOP M# = 1 TO RECORDS(ModuleQ)
                   GET(ModuleQ,M#)
                   IF szSearchModule = UPPER(ModuleQ.szModulePath & ModuleQ.szModuleName)
                      BREAK
                   END
                 END
                 IF M# > RECORDS(ModuleQ)
                    GET(ModuleQ,RECORDS(ModuleQ))
                    ModuleQ.szModulePath = szSearchModulePath !FileQ.szModulePath
                    ModuleQ.szModuleName = szSearchModuleName !CLIP(szUpper[K+1 : INSTRING('''',szUpper,1,K+1)-1])
                    ModuleQ.lModuleId += 1
                    ModuleQ.lDate = TODAY()
                    ModuleQ.lTime = CLOCK()
                    ModuleQ.szModuleName = CLIP(ModuleQ.szModuleName)
                    ADD(ModuleQ,+ModuleQ.lModuleId)

                    IncludeQ.szFileName = UPPER(ModuleQ.szModulePath & ModuleQ.szModuleName)
                    IncludeQ.szModulePath = ModuleQ.szModulePath
                    IncludeQ.szModuleName = ModuleQ.szModuleName
                    IncludeQ.lModuleId = ModuleQ.lModuleId
                    IncludeQ.szClassName = ClassQ.szClassName
                    IncludeQ.szParentClassName = ClassQ.szParentClassName
                    ADD(IncludeQ)
                 END
              END
           END
        ELSE
           K = INSTRING(' ',SourceFile.Record.sText) - 1
           PropertyQ.szPropertyName = SourceFile.Record.sText[1 : K]
           IF CLIP(PropertyQ.szPropertyName)
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
              PropertyQ.bPrivate = TRUE
              PropertyQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
              PropertyQ.lLineNum = glo:lLineNum
              PropertyQ.lClassID = ClassQ.lClassID
              PropertyQ.szPropertySort = UPPER(PropertyQ.szPropertyName)
              PropertyQ.bModule = TRUE

              IF PropertyQ.szDataType[1] = '&'                    OR |
                 UPPER(PropertyQ.szDataType[1 : 5]) = 'LIKE('     OR |
                 UPPER(PropertyQ.szDataType[1 : 6]) = 'QUEUE('    OR |
                 UPPER(PropertyQ.szDataType[1 : 6]) = 'GROUP('
                 GET(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
                 IF ERRORCODE()
                    ADD(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
                 END
              END
              !! look for Group or Queue
              CASE SUB(UPPER(PropertyQ.szDataType),1,5)
              OF 'GROUP' OROF 'QUEUE'
                 bEndCount = 1
?              ASSERT(LEN(szUpper) <> 0)
                 IF szUpper[LEN(szUpper)] <> '.' AND szUpper[LEN(szUpper)-2 : LEN(szUpper)] <> 'END'
                    LOOP
                       NEXT(SourceFile)
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
              ELSE
                 IF bDeclaringClass
                    GET(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
                    IF ERRORCODE()
                       ADD(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
                    END
                 END
              END
           END
        END
     END
  END
  EXIT
LookForStructure    ROUTINE
  IF ~bProcessingStructure   !look for structure definition
     IF INSTRING(' GROUP',szUpper,1) OR |
        INSTRING(' QUEUE',szUpper,1)

        IF INSTRING(',TYPE',szUpper,1) OR | !found a structure?
           INSTRING(', TYPE',szUpper,1)
           StructureQ.szStructureName = srcGetLabel(SourceFile.Record.sText)
           StructureQ.szStructureSort = UPPER(StructureQ.szStructureName)
           StructureQ.szDataLabel = srcGetLabel(SourceFile.Record.sText)
           GET(StructureQ,+StructureQ.szStructureSort,+StructureQ.szDataLabel)
           IF ERRORCODE()
              DO _SetupStructure
              ADD(StructureQ,+StructureQ.szStructureSort,+StructureQ.szDataLabel)
           ELSE
              DO _SetupStructure
              PUT(StructureQ)
           END
        END
     ELSE
        DO LookForEquate
     END
  ELSE !look for properties and methods
     DO ProcessStructure
  END
  EXIT

_SetupStructure ROUTINE
  StructureQ.szDataType = srcGetStatement(SourceFile.Record.sText)
? ASSERT(LEN(StructureQ.szDataType) <> 0)
  IF StructureQ.szDataType[LEN(StructureQ.szDataType)] = '.'
     StructureQ.szDataType[LEN(StructureQ.szDataType)] = '<0>'
  ELSE
     bProcessingStructure = TRUE
  END
  ModuleQ.szModulePath = FileQ.szModulePath
  ModuleQ.szModuleName = FileQ.szModuleName
  GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
? ASSERT(~ERRORCODE())
  StructureQ.lModuleId = ModuleQ.lModuleId
  StructureQ.lLineNum = glo:lLineNum
  StructureQ.bPrivate = TRUE
  EXIT
ProcessStructure    ROUTINE
  IF CLIP(LEFT(szUpper)) = 'END' OR |
     CLIP(LEFT(szUpper)) = '.'
     bProcessingStructure = FALSE
  ELSE
     StructureQ.szDataLabel = srcGetLabel(SourceFile.Record.sText)
     GET(StructureQ,+StructureQ.szStructureSort,+StructureQ.szDataLabel)
     IF ERRORCODE()
        DO _ProcessStructure
        ADD(StructureQ,+StructureQ.szStructureSort,+StructureQ.szDataLabel)
     ELSE
        DO _ProcessStructure
        PUT(StructureQ)
     END
  END
  EXIT

_ProcessStructure   ROUTINE
  StructureQ.szDataType = srcGetStatement(SourceFile.Record.sText)
? ASSERT(LEN(StructureQ.szDataType) <> 0)
  IF StructureQ.szDataType[LEN(StructureQ.szDataType)] = '.'
     StructureQ.szDataType[LEN(StructureQ.szDataType)] = '<0>'
     bProcessingStructure = FALSE
  END
  ModuleQ.szModulePath = FileQ.szModulePath
  ModuleQ.szModuleName = FileQ.szModuleName
  GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
? ASSERT(~ERRORCODE())
  StructureQ.lModuleId = ModuleQ.lModuleId

  StructureQ.lLineNum = glo:lLineNum
  StructureQ.bPrivate = TRUE
  EXIT
LookForEquate   ROUTINE
  IF ~bProcessingEquate   !look for itemized equates
     IF INSTRING(' ITEMIZE',szUpper,1)

        K = INSTRING(',PRE(',szUpper,1)  !start value specified?
        IF K
           K += 5
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

        ModuleQ.szModulePath = FileQ.szModulePath
        ModuleQ.szModuleName = FileQ.szModuleName
        GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
?      ASSERT(~ERRORCODE())
        EnumQ.lModuleId = ModuleQ.lModuleId

        EnumQ.lLineNum     = glo:lLineNum
        EnumQ.szEnumSort   = UPPER(EnumQ.szEnumName)
        EnumQ.bPrivate     = TRUE
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
           ModuleQ.szModulePath = FileQ.szModulePath
           ModuleQ.szModuleName = FileQ.szModuleName
           GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
?         ASSERT(~ERRORCODE())
           EquateQ.lModuleId = ModuleQ.lModuleId

           EquateQ.lLineNum = glo:lLineNum
           IF EquateQ.szLabel <> EquateQ.szValue     !prevent infinate loop in scan
              ADD(EquateQ) !,+EquateQ.szLabel)
           END
        ELSE
           !DO LookForReference
        END
     END
  ELSE !look for enumeration structures
     DO ProcessEquate
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
        K = INSTRING('(',szUpper,1,K+7)  !equate value specified?
     END
     IF K
        K += 1
        M = INSTRING(')',SourceFile.Record.sText,1,K) - 1
        EnumQ.szEnumValue = SourceFile.Record.sText[K : M]
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
     END

     ModuleQ.szModulePath = FileQ.szModulePath
     ModuleQ.szModuleName = FileQ.szModuleName
     GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
?   ASSERT(~ERRORCODE())
     EnumQ.lModuleId = ModuleQ.lModuleId

     EnumQ.lLineNum = glo:lLineNum
     EnumQ.bPrivate = TRUE
     ADD(EnumQ)
  END
  EXIT
LookForReference    ROUTINE
  K = INSTRING(' ',SourceFile.Record.sText) - 1
  PropertyQ.szPropertyName = SourceFile.Record.sText[1 : K]
  IF CLIP(PropertyQ.szPropertyName)
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
     PropertyQ.bPrivate = TRUE
     PropertyQ.bProtected = CHOOSE(INSTRING(',PROTECTED',szUpper,1))
     PropertyQ.lLineNum = glo:lLineNum
     PropertyQ.lClassID = ClassQ.lClassID
     PropertyQ.szPropertySort = UPPER(PropertyQ.szPropertyName)
     PropertyQ.bModule = TRUE
     GET(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
     IF ERRORCODE()
        ADD(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
     END
  END
  EXIT
