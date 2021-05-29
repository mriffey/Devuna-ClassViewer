

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
!!! Find Equate Value
!!! </summary>
srcGetEquateValue    PROCEDURE  (szEnumLabel,bIsHexValue)  ! Declare Procedure
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
work:szEnumLabel    CSTRING(1024)
this:szEnumLabel    LIKE(EnumQ.szEnumLabel)
save:szEnumLabel    LIKE(EnumQ.szEnumLabel)
save:EnumQ          LIKE(EnumQ)
save:EquateQ        LIKE(EquateQ)
save:EnumQPointer   LONG
save:EquateQPointer LONG
I                   LONG
J                   LONG
K                   LONG
N                   LONG
X                   LONG
ulValue             ULONG
lValue              LONG,OVER(ulValue)
szRetVal            CSTRING(64)
bRetIsHexValue      BYTE
szLookupValue       CSTRING(64)
endptr              ULONG
bStartFound         BYTE(FALSE)

  CODE
  !First Strip out all blanks
  K = 0
  X = 0
  J = LEN(szEnumLabel)
  LOOP I = 1 TO J
    IF szEnumLabel[I] <> ' '
       K += 1
       work:szEnumLabel[K] = szEnumLabel[I]
       IF X = 0 AND ~INSTRING(work:szEnumLabel[K],' +-*/0123456789')
          X = K
       END
    END
  END
  K += 1
  work:szEnumLabel[K] = '<0>'
  IF X = 0
     X = 1
  END

  bRetIsHexValue = bIsHexValue
  save:szEnumLabel = work:szEnumLabel
  K = 0
  N = 0
  J = LEN(work:szEnumLabel)
  LOOP I = X TO J
    IF INSTRING(work:szEnumLabel[I],' +-*/') AND I > 1
       K = I    !save value for use later
       BREAK
    ELSE
       N += 1
       szLookupValue[N] = work:szEnumLabel[I]
    END
  END
  N += 1
  szLookupValue[N] = '<0>'

  save:EnumQ = EnumQ
  save:EnumQPointer = POINTER(EnumQ)
  save:EquateQ = EquateQ
  save:EquateQPointer = POINTER(EquateQ)
  J = RECORDS(EnumQ)
  LOOP I = J TO 1 BY -1
    GET(EnumQ,I)
    IF EnumQ.szEnumPrefix
       this:szEnumLabel = EnumQ.szEnumLabel
    ELSIF EnumQ.szEnumName
       this:szEnumLabel = EnumQ.szEnumName & ':' & EnumQ.szEnumLabel
    ELSE
       this:szEnumLabel = EnumQ.szEnumLabel
    END
    IF UPPER(this:szEnumLabel) = UPPER(szLookupValue) !save:szEnumLabel
       IF ~NUMERIC(EnumQ.szEnumValue)
          szRetVal = srcGetEquateValue(EnumQ.szEnumValue,bRetIsHexValue)
       ELSE
          szRetVal = EnumQ.szEnumValue
          bRetIsHexValue = EnumQ.bIsHexValue
       END
       BREAK
    END
  END
  IF ~I         !did not find in enumerated equates
     J = RECORDS(EquateQ)
     LOOP I = 1 TO J
        GET(EquateQ,I)
        IF EquateQ.szLabel = UPPER(szLookupValue)
           szRetVal = EquateQ.szValue
           bRetIsHexValue = EquateQ.bIsHexValue
           BREAK
        END
     END
     IF I > J
        IF UPPER(SUB(save:szEnumLabel,-1,1)) = 'H'
           bRetIsHexValue = TRUE
           save:szEnumLabel = '0x' & SUB(save:szEnumLabel,1,LEN(save:szEnumLabel)-1)
           ulValue = strtoul(save:szEnumLabel,endptr,16)
           szRetVal = ulValue
        ELSIF UPPER(SUB(save:szEnumLabel,-1,1)) = 'B'
           bRetIsHexValue = TRUE + 1
           save:szEnumLabel = SUB(save:szEnumLabel,1,LEN(save:szEnumLabel)-1)
           ulValue = strtoul(save:szEnumLabel,endptr,2)
           szRetVal = ulValue
        ELSE
           BIND('save:szEnumLabel',save:szEnumLabel)
           szRetVal = EVALUATE(save:szEnumLabel & ' + 0')
           UNBIND('save:szEnumLabel')
           !IF szRetVal[1] = '-'
           !   lValue = szRetVal
           !   szRetVal = ulValue
           !END
        END
     ELSIF K
        szRetVal = srcGetEquateValue(work:szEnumLabel[1 : X-1] & szRetVal & work:szEnumLabel[K : LEN(work:szEnumLabel)],bRetIsHexValue)
     ELSE
        szRetVal = srcGetEquateValue(work:szEnumLabel[1 : X-1] & szRetVal,bRetIsHexValue)
     END
  END
  GET(EquateQ,save:EquateQPointer)
  EquateQ = save:EquateQ
  GET(EnumQ,save:EnumQPointer)
  EnumQ = save:EnumQ
  bIsHexValue = bRetIsHexValue
  RETURN(szRetVal)
