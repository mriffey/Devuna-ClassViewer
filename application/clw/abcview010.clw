

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
!!! Get Method Definition Start Line
!!! </summary>
srcGetSourceLine     PROCEDURE  (lModuleId, sMethod, sPrototype, Buffer) ! Declare Procedure
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
I                    LONG
J                    LONG
K                    LONG
lLineNum             LONG
AsciiFilename1       STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile1           FILE,DRIVER('ASCII'),NAME(AsciiFilename1),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(1024)
                      END
                     END
szText               CSTRING(1025)

sav:szText           CSTRING(1025)
sav:lLineNum         LONG
pointerReplaced      BOOL

  CODE
  SORT(ModuleQ,+ModuleQ.lModuleId)
  ModuleQ.lModuleId = lModuleId
  GET(ModuleQ,+ModuleQ.lModuleId)
  IF ~ERRORCODE()
     FileNameQ.sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
     GET(FileNameQ,+FileNameQ.sFileName)
     IF ERRORCODE()                           !file has not been scanned
        DO ScanFile
     END
     SourceLineQ.sFileName = FileNameQ.sFileName
     SourceLineQ.sMethodName = UPPER(CLIP(sMethod))
     SourceLineQ.sMethodPrototype = UPPER(srcRemoveLabels(sPrototype))
     GET(SourceLineQ,+SourceLineQ.sFileName,+SourceLineQ.sMethodName,+SourceLineQ.sMethodPrototype)
     IF ERRORCODE()                            !not found
        pointerReplaced = FALSE
        !Try to catch implied pointers
        I = 1
        J = INSTRING('*',SourceLineQ.sMethodPrototype,1,I)
        LOOP WHILE J
          K = INSTRING(',',SourceLineQ.sMethodPrototype,1,J+1)
          IF K = 0
             K = INSTRING(')',SourceLineQ.sMethodPrototype,1,J+1)
          END
          IF K > 0
             glo:StructureQCopy.szStructureSort = SourceLineQ.sMethodPrototype[J+1 : K-1]
             GET(glo:StructureQCopy,+glo:StructureQCopy.szStructureSort)
             IF ~ERRORCODE()
                !remove the '*' if it is a pointer to a structure
                SourceLineQ.sMethodPrototype = SourceLineQ.sMethodPrototype[1 : J-1] & SourceLineQ.sMethodPrototype[J+1 : LEN(SourceLineQ.sMethodPrototype)]
                I = K
                pointerReplaced = TRUE
             ELSE
                I = K+1
             END
             IF I < LEN(SourceLineQ.sMethodPrototype)
                J = INSTRING('*',SourceLineQ.sMethodPrototype,1,I)
             ELSE
                BREAK
             END
          END
        END
        IF pointerReplaced = TRUE
           GET(SourceLineQ,+SourceLineQ.sFileName,+SourceLineQ.sMethodName,+SourceLineQ.sMethodPrototype)
           IF ~ERRORCODE()                            !found
              IF ~OMITTED(4)
                 Buffer = SourceLineQ.szLineText
              END
              RETURN(SourceLineQ.lSourceLine)
           END
        END
        RETURN(0)
     ELSE
        IF ~OMITTED(4)
           Buffer = SourceLineQ.szLineText
        END
        RETURN(SourceLineQ.lSourceLine)
     END
  ELSE
     RETURN(0)
  END

ScanFile    ROUTINE
  DATA
X               LONG
bProcessingMap  BYTE

  CODE
  FileNameQ.sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
  ADD(FileNameQ,+FileNameQ.sFileName)
  lLineNum = 0
  AsciiFilename1 = FileNameQ.sFileName
  OPEN(AsciiFile1,040h)   !Read-Only
  IF ~ERRORCODE()
     sav:szText = ''
     sav:lLineNum = 0
     SET(AsciiFile1)
     LOOP
        NEXT(AsciiFile1)
        IF ERRORCODE()
           BREAK
        ELSE
           lLineNum += 1
           X = srcFindComment(AsciiFile1.record.TextLine)
           IF X
              AsciiFile1.record.TextLine = SUB(AsciiFile1.record.TextLine,1,X-1)
           END
           szText = CLIP(AsciiFile1.record.TextLine)
           IF UPPER(CLIP(LEFT(szText))) = 'MAP'
              bProcessingMap = TRUE
           END
           IF bProcessingMap
              IF UPPER(CLIP(LEFT(szText))) = 'END'  |
              OR UPPER(CLIP(LEFT(szText))) = '.'
                 bProcessingMap = FALSE
              END
           ELSE
              IF szText
                 IF szText[LEN(szText)] = '|'
                    IF sav:szText = ''
                       sav:lLineNum = lLineNum
                    END
                    sav:szText = sav:szText & CLIP(LEFT(szText[1 : LEN(szText)-1]))
                 ELSE
                    IF sav:szText
                       AsciiFile1.record.TextLine = sav:szText & CLIP(LEFT(szText))
                       sav:szText = ''
                    END
                    IF INSTRING(' PROCEDURE',UPPER(AsciiFile1.record.TextLine),1) OR |
                       INSTRING(' FUNCTION',UPPER(AsciiFile1.record.TextLine),1)
                       SourceLineQ.sFileName = FileNameQ.sFileName
                       SourceLineQ.sMethodName = UPPER(SUB(AsciiFile1.record.TextLine,1,INSTRING(' ',AsciiFile1.record.TextLine)-1))
                       SourceLineQ.sMethodPrototype = UPPER(srcRemoveLabels(srcGetPrototype(AsciiFile1.record.TextLine)))
                       SourceLineQ.lSourceLine = CHOOSE(sav:lLineNum=0,lLineNum,sav:lLineNum)
                       SourceLineQ.szLineText = CLIP(AsciiFile1.record.TextLine)
                       DO RemoveSpaces
                       ADD(SourceLineQ,+SourceLineQ.sFileName,+SourceLineQ.sMethodName,+SourceLineQ.sMethodPrototype)
                    END
                    sav:lLineNum = 0
                 END
              END
           END
        END
     END
     CLOSE(AsciiFile1)
  END
  EXIT
RemoveSpaces    ROUTINE
  DATA
I       LONG,AUTO
J       LONG,AUTO
K       LONG,AUTO
szWork  LIKE(SourceLineQ.szLineText)
bSkip   BYTE(0)

  CODE
  J = LEN(SourceLineQ.szLineText)
  K = 0
  LOOP I = 1 TO J
     IF SourceLineQ.szLineText[I] <> ' '
        bSkip = FALSE
        K += 1
        szWork[K] = SourceLineQ.szLineText[I]
     ELSE
        IF ~bSkip
           K += 1
           szWork[K] = SourceLineQ.szLineText[I]
           bSkip = TRUE
        END
     END
  END
  K += 1
  szWork[K] = '<0>'
  SourceLineQ.szLineText = szWork
  EXIT
