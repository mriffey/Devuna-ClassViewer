

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
!!! Find location of included file
!!! </summary>
srcFindModule        PROCEDURE  (*CSTRING szModulePath, *CSTRING szModuleName) ! Declare Procedure
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
N           LONG,AUTO
P           LONG,AUTO
SearchQ     QUEUE(SEARCHQTYPE),PRE(SQ)
            END
FileQ       QUEUE(File:queue),PRE(Q)
            END

  CODE
    P = INSTRING('\',szModuleName,-1,LEN(szModuleName))
    IF P > 0
       szModulePath = UPPER(szModuleName[1 : P])
       szModuleName = UPPER(szModuleName[P+1 : LEN(szModuleName)])
    END
    RETURN
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
