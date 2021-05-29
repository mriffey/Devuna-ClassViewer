

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
srcGetLineComments   PROCEDURE  (STRING sFilename, LONG lLineNum) ! Declare Procedure
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
thisLineNum          LONG
AsciiFilename1       STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile1           FILE,DRIVER('ASCII'),NAME(AsciiFilename1),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(1024)
                      END
                     END
szText               CSTRING(1025)

  CODE
  LineCommentQ.sFileName = sFileName
  GET(LineCommentQ,+LineCommentQ.sFileName)
  IF ERRORCODE()
     DO ScanFile
  END
  LineCommentQ.sFileName = sFileName
  LineCommentQ.lSourceLine = lLineNum
  GET(LineCommentQ,+LineCommentQ.sFileName,+LineCommentQ.lSourceLine)
  IF ~ERRORCODE()
     szText = LineCommentQ.szComment
  ELSE
     szText = ''
  END
  RETURN(szText)
ScanFile    ROUTINE
  DATA
X               LONG
bProcessingMap  BYTE

  CODE
  thisLineNum = 0
  AsciiFilename1 = sFileName
  OPEN(AsciiFile1,040h)   !Read-Only
  IF ~ERRORCODE()
     SET(AsciiFile1)
     LOOP
        NEXT(AsciiFile1)
        IF ERRORCODE()
           BREAK
        ELSE
           thisLineNum += 1
           X = srcFindComment(AsciiFile1.record.TextLine)
           IF X
              LineCommentQ.sFileName = sFileName
              LineCommentQ.lSourceLine = thisLineNum
              LineCommentQ.szComment = SUB(AsciiFile1.record.TextLine,X,LEN(CLIP(AsciiFile1.record.TextLine)))
              ADD(LineCommentQ,+LineCommentQ.sFileName,+LineCommentQ.lSourceLine)
           END
        END
     END
     CLOSE(AsciiFile1)
  END
  EXIT
