

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
!!! Get Procedure Return Type
!!! </summary>
srcGetReturnType     PROCEDURE  (sz)                       ! Declare Procedure
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
K               LONG,AUTO
Delimiter       STRING(1)
szWork          CSTRING(1024)
szAttributes    CSTRING(1024)
szReturnValue   CSTRING(64)
szKeyword       CSTRING(32)
oHH           &tagHTMLHelp

  CODE
  szWork = sz
  K = INSTRING('PROCEDURE(',szWork,1)
  IF K
     Delimiter = ')'
  ELSE
     K = INSTRING('PROCEDURE,',szWork,1)
     IF K
        Delimiter = ','
     ELSE
        K = INSTRING('FUNCTION(',szWork,1)
        IF K
           Delimiter = ')'
        ELSE
           K = INSTRING('FUNCTION,',szWork,1)
           IF K
              Delimiter = ','
           END
        END
     END
  END

  IF K
     szAttributes = ''
     LOOP K = 1 TO LEN(szWork)
        IF szWork[K] = Delimiter
           CASE Delimiter
           OF ')'
              IF CLIP(szWork[K+1 : LEN(szWork)]) <> ''
                 szAttributes = UPPER(szWork[K+1 : LEN(szWork)])
              END
           OF ','
              IF CLIP(szWork[K : LEN(szWork)]) <> ''
                 szAttributes = UPPER(szWork[K : LEN(szWork)])
              END
           END
           BREAK
        END
     END
     IF szAttributes <> ''
        szKeyWord = 'DERIVED'
        DO RemoveKeyWord
        szKeyWord = 'REPLACE'
        DO RemoveKeyWord
        szKeyWord = 'PROTECTED'
        DO RemoveKeyWord
        szKeyWord = 'PROC'
        DO RemoveKeyWord
        szKeyWord = 'VIRTUAL'
        DO RemoveKeyWord
        szKeyWord = 'PRIVATE'
        DO RemoveKeyWord
        DO RemoveCommas
        szReturnValue = CLIP(LEFT(szAttributes))
     ELSE
        szReturnValue = ''
     END
  ELSE
     szReturnValue = ''
  END
  RETURN szReturnValue
RemoveKeyWord   ROUTINE
  DATA
I   LONG,AUTO
J   LONG,AUTO
N   LONG,AUTO

  CODE
  IF INSTRING(szKeyword,szAttributes,1)
    I = LEN(szKeyword)
    J = LEN(szAttributes)
    N = INSTRING(szKeyword,szAttributes,1)
    IF N+I <= J
       szAttributes = szAttributes[1 : N-1] & szAttributes[N+I : J]
    ELSE
       szAttributes = szAttributes[1 : N-1]
    END
  END
  EXIT

RemoveCommas    ROUTINE
  DATA
I       LONG,AUTO
J       LONG,AUTO
N       LONG,AUTO
szWork  CSTRING(64)

  CODE
  szWork = CLIP(LEFT(szAttributes))
  J = LEN(szWork)
  N = 0
  LOOP I = 1 TO J
     IF szWork[I] = ','
        CYCLE
     ELSE
        N += 1
        szAttributes[N] = szWork[I]
     END
  END
  szAttributes[N+1] = '<0>'
