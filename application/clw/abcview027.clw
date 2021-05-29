

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
!!! Is name a class method
!!! </summary>
srcIsClassMethod     PROCEDURE  (szName)                   ! Declare Procedure
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
lClassQPointer  LONG
bIsClassMethod  BYTE
I               LONG
J               LONG

  CODE
  bIsClassMethod = FALSE
  J = LEN(szName)
  I = INSTRING('.',szName)
  IF I
     ClassQ.szClassSort = UPPER(szName[1 : I-1])
     GET(ClassQ,+ClassQ.szClassSort)
     IF ~ERRORCODE()
        MethodQ.lClassID = ClassQ.lClassId
        MethodQ.szMethodSort = UPPER(szName[I+1 : J])
        GET(MethodQ,+MethodQ.lClassID,+MethodQ.szMethodSort)
        IF ERRORCODE()
           bIsClassMethod = FALSE
        ELSE
           bIsClassMethod = TRUE
        END
     ELSE
        bIsClassMethod = FALSE
     END
  END
  RETURN(bIsClassMethod)
