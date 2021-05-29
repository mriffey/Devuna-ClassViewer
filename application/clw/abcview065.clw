

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
!!! Get Class Interface Implementations
!!! </summary>
srcGetImplements     PROCEDURE  (LONG lClassId, *CSTRING Buffer) !,LONG ! Declare Procedure
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
lLineNum             LONG
AsciiFilename1       STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile1           FILE,DRIVER('ASCII'),NAME(AsciiFilename1),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(1024)
                      END
                     END

  CODE
  !SORT(ClassQ,+ClassQ.lClassId)
  ClassQ.lClassId = lClassId
  GET(ClassQ,+ClassQ.lClassId)
  ModuleQ.lModuleId = ClassQ:lIncludeId
  GET(ModuleQ,+ModuleQ.lModuleId)
  IF ~ERRORCODE()
     FileNameQ.sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
     GET(FileNameQ,+FileNameQ.sFileName)
     IF ERRORCODE()                           !file has not been scanned
        DO ScanFile
     END
     I = INSTRING('IMPLEMENTS(',UPPER(A1:TextLine),1,1)
     IF I
        I += 11
        J = INSTRING(')',UPPER(A1:TextLine),1,I)-1
        Buffer = A1:TextLine[I : J]
     ELSE
        Buffer = ''
     END
     RETURN(ClassQ:lLineNum)
  ELSE
     RETURN(0)
  END

ScanFile    ROUTINE
  FileNameQ.sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
  ADD(FileNameQ,+FileNameQ.sFileName)
  lLineNum = 0
  AsciiFilename1 = FileNameQ.sFileName
  OPEN(AsciiFile1,040h)   !Read-Only
  IF ~ERRORCODE()
     SET(AsciiFile1)
     LOOP
        NEXT(AsciiFile1)
        IF ERRORCODE()
           BREAK
        ELSE
           lLineNum += 1
           IF lLineNum = ClassQ:lLineNum
              BREAK
           END
        END
     END
     CLOSE(AsciiFile1)
  END
  EXIT
