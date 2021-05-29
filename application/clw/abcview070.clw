

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
srcGetSearchFoldersFromRedFile PROCEDURE  (*SEARCHQTYPE pSearchQueue, *CSTRING pRedFilename) ! Declare Procedure
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
szSearchPath      CSTRING(1025)
szText            CSTRING(1025)
InCommonSection   BYTE(FALSE)
szRedFilename     CSTRING(261)
pDelimiter        LONG
savPosition       STRING(4)

  CODE
      szAsciiFilename = pRedFilename
      OPEN(SourceFile,ReadOnly+DenyNone)
      SET(SourceFile)
      NEXT(SourceFile)
      LOOP UNTIL ERRORCODE()
         szText = UPPER(CLIP(LEFT(SourceFile.sText)))
         IF InCommonSection
            IF szText[1] = '['
               InCommonSection = FALSE
               BREAK
            ELSIF szText[1 : 8] = '{{INCLUDE'
               pDelimiter = INSTRING('}',szText)
               pSearchQueue.szPath =  CLIP(LEFT(szText[10 : pDelimiter-1]))
               DO HandleRedirectionMacros
               szRedFilename = pSearchQueue.szPath

               savPosition = POSITION(SourceFile)
               CLOSE(SourceFile)
               srcGetSearchFoldersFromRedFile(pSearchQueue,szRedFilename)
               szAsciiFilename = pRedFilename
               OPEN(SourceFile,ReadOnly+DenyNone)
               SET(SourceFile)
               RESET(SourceFile,savPosition)
               NEXT(SourceFile)
            ELSIF szText[1 : 5] = '*.INC'
               DO AddFoldersToQueue
            ELSIF szText[1 : 3] = '*.*'
               DO AddFoldersToQueue
            END
         ELSE
            IF szText[1 : 8] = '[COMMON]'
               InCommonSection = TRUE
            END
         END
         NEXT(SourceFile)
      END
      CLOSE(SourceFile)
      RETURN
AddFoldersToQueue ROUTINE
   DATA
cc             LONG,AUTO
I              LONG,AUTO
pszFilePart    LONG,AUTO
szFullPath     CSTRING(260),AUTO
szSavePath     CSTRING(256),AUTO

   CODE
      I = INSTRING('=',szText)
      szSearchPath = CLIP(LEFT(szText[I+1 : LEN(szText)]))
      LOOP WHILE szSearchPath
         I = INSTRING(';',szSearchPath)
         IF I
            pSearchQueue.szPath = CLIP(LEFT(SUB(szSearchPath,1,I-1)))
            IF pSearchQueue.szPath[1] = '"'
               pSearchQueue.szPath = pSearchQueue.szPath[2 : LEN(pSearchQueue.szPath)-1]
            END
            IF pSearchQueue.szPath[LEN(pSearchQueue.szPath)] = '\'
               pSearchQueue.szPath[LEN(pSearchQueue.szPath)] = '<0>'
            END
            DO HandleRedirectionMacros
            IF pSearchQueue.szPath = '.'
               pSearchQueue.szPath = glo:szCurrentDir
            ELSIF pSearchQueue.szPath[1] = '.'
               cc = GetFullPathName(pSearchQueue.szPath,SIZE(szFullPath),szFullPath,pszFilePart)
               pSearchQueue.szPath = szFullPath
            END
            szSearchPath = SUB(szSearchPath,I+1,LEN(szSearchPath)-I)
         ELSE
            pSearchQueue.szPath = CLIP(LEFT(szSearchPath))
            IF pSearchQueue.szPath[1] = '"'
               pSearchQueue.szPath = pSearchQueue.szPath[2 : LEN(pSearchQueue.szPath)-1]
            END
            IF pSearchQueue.szPath[LEN(pSearchQueue.szPath)] = '\'
               pSearchQueue.szPath[LEN(pSearchQueue.szPath)] = '<0>'
            END
            DO HandleRedirectionMacros
            IF pSearchQueue.szPath = '.'
               pSearchQueue.szPath = glo:szCurrentDir
            ELSIF pSearchQueue.szPath[1] = '.'
               cc = GetFullPathName(pSearchQueue.szPath,SIZE(szFullPath),szFullPath,pszFilePart)
               pSearchQueue.szPath = szFullPath
            END
            szSearchPath = ''
         END
         IF pSearchQueue.szPath[LEN(pSearchQueue.szPath)] <> '\'
            szSavePath = CLIP(pSearchQueue.szPath) & '\'
         END
         pSearchQueue.szPath = UPPER(szSavePath)

         GET(pSearchQueue,+pSearchQueue.szPath)
         IF ERRORCODE()
            pSearchQueue.szPath = UPPER(szSavePath)
            ADD(pSearchQueue,+pSearchQueue.szPath)
         END
      END
   EXIT
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
          J = INSTRING(RedirectionQueue.Token,UPPER(pSearchQueue.szPath),1)
          IF J
             pSearchQueue.szPath = SUB(pSearchQueue.szPath,1,J-1) & RedirectionQueue.Path & SUB(pSearchQueue.szPath,J+LEN(RedirectionQueue.Token),LEN(pSearchQueue.szPath)-J+LEN(RedirectionQueue.Token)-1)
          ELSE
             BREAK
          END
       END
    END
