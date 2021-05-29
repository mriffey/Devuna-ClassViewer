

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
!!! Is name an interface method
!!! </summary>
srcIsInterfaceMethod PROCEDURE  (szName)                   ! Declare Procedure
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
lStructureQRecords  LONG
lStructureQPointer  LONG
bIsInterfaceMethod  BYTE
I                   LONG
J                   LONG

  CODE
  bIsInterfaceMethod = FALSE
  J = LEN(szName)
  I = INSTRING('.',szName)
  IF I
     StructureQ.szStructureSort = UPPER(szName[1 : I-1])
     GET(StructureQ,+StructureQ.szStructureSort)
     IF ~ERRORCODE()
        lStructureQPointer = POINTER(StructureQ)
        lStructureQRecords = RECORDS(StructureQ)
        LOOP lStructureQPointer = lStructureQPointer TO lStructureQRecords
          GET(StructureQ,lStructureQPointer)
          IF StructureQ.szStructureSort = UPPER(szName[1 : I-1])
             IF UPPER(StructureQ.szDataLabel) = UPPER(szName[I+1 : J])
                bIsInterfaceMethod = TRUE
                BREAK
             END
          ELSE
             BREAK
          END
        END
     END
  END
  RETURN(bIsInterfaceMethod)
