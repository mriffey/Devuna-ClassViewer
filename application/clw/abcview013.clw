

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
!!! extract prototype from passed string
!!! </summary>
srcGetPrototype      PROCEDURE  (sString)                  ! Declare Procedure
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
I           LONG,AUTO
J           LONG,AUTO
X           LONG,AUTO
szPrototype CSTRING(1024)
szWork      CSTRING(1024)

  CODE
  I = INSTRING(' PROCEDURE',UPPER(sString),1)
  IF I
     I += 10
  ELSE
     I = INSTRING(' FUNCTION',UPPER(sString),1) + 9
  END
  IF I < LEN(CLIP(sString))
     J = INSTRING(')',sString,1,I)
     IF J
        szWork = '(' & CLIP(LEFT(sString[I+1 : J-1])) & ')'
        !start bug fix
        IF szWork[1:2] = '(('
           szWork = szWork[2 : LEN(szWork)]
        END
        !end bug fix

        szPrototype = ''
        J = LEN(szWork)
        X = 0
        LOOP I = 1 TO J
          IF szWork[I] <> ' ' !AND szWork[I] <> '='
             X += 1
             szPrototype[X] = szWork[I]
          ELSE
             !we hit a space
             IF szWork[I+1] <> ' ' AND szWork[I+1] <> ',' AND szPrototype[X] <> ','
                X += 1
                szPrototype[X] = szWork[I]
             END
          END
        END
        X += 1
        szPrototype[X] = '<0>'
     ELSE
        szPrototype = '()'
     END
  ELSE
     szPrototype = '()'
  END

  !equates have not been processed at this point
  !special treatment for ai_com classes
  X = INSTRING('REFIID',szPrototype,1)
  LOOP WHILE X
    szPrototype = SUB(szPrototype,1,X-1) & 'long' & SUB(szPrototype,X+6,LEN(szPrototype)-(X+5))
    X = INSTRING('REFIID',szPrototype,1)
  END
  X = INSTRING('REFCLSID',szPrototype,1)
  LOOP WHILE X
    szPrototype = SUB(szPrototype,1,X-1) & 'long' & SUB(szPrototype,X+8,LEN(szPrototype)-(X+7))
    X = INSTRING('REFCLSID',szPrototype,1)
  END

  RETURN(szPrototype)
