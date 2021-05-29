

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
!!! Get parameters from passed prototype
!!! </summary>
srcGetParameters     PROCEDURE  (sz)                       ! Declare Procedure
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
I       LONG,AUTO
J       LONG,AUTO
K       LONG,AUTO
N       LONG,AUTO
pSpace  LONG,AUTO
pComma  LONG,AUTO
pStart  LONG,AUTO
szWork  CSTRING(1025)
paramq  QUEUE,PRE(paramq)
param     CSTRING(256)
        END
oHH           &tagHTMLHelp

  CODE
  !make local copy trimming spaces
  !====================================================================
  szWork = CLIP(LEFT(sz))

  !get rid of parenthesis if present
  !====================================================================
  J = LEN(szWork)
  I = INSTRING('(',szWork)
  IF I
     szWork = szWork[I+1 : J]
  END
  I = INSTRING(')',szWork)
  IF I
     szWork = szWork[1 : I-1]
  END

  !split string at commas and add to parameter queue
  !====================================================================
  pStart = 1
  pComma = INSTRING(',',szWork,1,pStart)
  LOOP WHILE pComma <> 0
     paramq.param = CLIP(LEFT(szWork[pStart : pComma-1]))
     ADD(paramq)
     pStart = pComma + 1
     pComma = INSTRING(',',szWork,1,pStart)
  END
  paramq.param = CLIP(LEFT(szWork[pStart : LEN(szWork)]))
  ADD(paramq)


  !loop through parameter queue
  !====================================================================
  J = RECORDS(paramq)
  LOOP I = 1 TO J
     GET(paramq,I)
     K = LEN(paramq.param)
     !step backwards through the parameter looking for a space or <
     !=================================================================
     LOOP N = K TO 1 BY -1
        IF INSTRING(paramq.param[N],' <<')
           !found space or < so discard prefix
           !===========================================================
           paramq.param = paramq.param[N+1 : K]
           !look fo omittable parameter delimeters and truncate if found
           !===========================================================
           K = INSTRING('=',paramq.param)
           IF K <> 0
              paramq.param[K] = '<0>'
           END
           K = INSTRING('>',paramq.param)
           IF K <> 0
              paramq.param[K] = '<0>'
           END
           !update the parameter
           !===========================================================
           PUT(paramq)
           BREAK
        END
     END
  END

  !finally loop through parameter queue and create result
  !====================================================================
  szWork = '('
  J = RECORDS(paramq)-1
  LOOP I = 1 TO J
     GET(paramq,I)
     szWork = szWork & paramq.param & ','
  END
  GET(paramq,I)     !I will be pointing to the last record in queue
  szWork = szWork & paramq.param & ')'

  RETURN szWork
