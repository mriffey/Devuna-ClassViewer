

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
!!! Remove labels from passed prototype string
!!! </summary>
srcRemoveLabels      PROCEDURE  (s)                        ! Declare Procedure
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
szReturn     CSTRING(1024)
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
Q           QUEUE,PRE(Q)
szSnip        CSTRING(64)
            END

  CODE
  FREE(Q)
  !Copy the passed string to a local variable, removing < and >
  K = 0
  J = LEN(CLIP(s))
  LOOP I = 1 TO J
    IF s[I] = '<<' OR |
       s[I] = '>'
       !do nothing
    ELSE
       K += 1
       szReturn[K] = s[I]
    END
  END
  szReturn[K+1] = '<0>'

  !Remove CONST attribute
  I = INSTRING('CONST ',UPPER(szReturn),1)
  LOOP WHILE I
    szReturn = szReturn[1 : I-1] & szReturn[I+6 : LEN(szReturn)]
    I = INSTRING('CONST ',UPPER(szReturn),1)
  END

  !Split the string at the comma's
  LOOP
    I = INSTRING(',',szReturn)
    IF I
       Q.szSnip = CLIP(LEFT(szReturn[1 : I-1]))
       ADD(Q)
       szReturn = szReturn[I+1 : LEN(szReturn)]
    ELSE
       Q.szSnip = CLIP(LEFT(szReturn))
       ADD(Q)
       szReturn = ''
       BREAK
    END
  END

  !Now loop through the snips and truncate at first space
  J = RECORDS(Q)
  LOOP I = 1 TO J
    GET(Q,I)
    K = INSTRING(' ',Q.szSnip)
    IF K
       Q.szSnip[K] = '<0>'                  !null terminates cstring
       PUT(Q)
    END
  END

  !Finally piece the snips back together
  J = RECORDS(Q)
  LOOP I = 1 TO J
    GET(Q,I)
    szReturn = szReturn & Q.szSnip & ','
  END
  szReturn[LEN(szReturn)] = '<0>'           !replace the trailing comma
  K = LEN(szReturn)                         !and make sure we have a closing ')'
  IF K
     IF szReturn[K] <> ')'
        szReturn[K+1 : K+2] = ')<0>'
     END
  END

  !Return to caller
  RETURN(szReturn)
