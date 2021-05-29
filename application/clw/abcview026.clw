

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
!!! resolve name references
!!! </summary>
srcResolveName       PROCEDURE  (szName, szSelf, szParent) ! Declare Procedure
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
I                   LONG
J                   LONG
szWork              CSTRING(1024)
Q                   QUEUE
szSnip                CSTRING(64)
                    END
bStructure          BYTE
lStructureQPointer  LONG
lStructureQRecords  LONG
szLastError         LIKE(szWork),STATIC

  CODE
  !Break szName into pieces
  szWork = szName
  LOOP
    I = INSTRING('.',szWork)
    IF I
       Q.szSnip = szWork[1 : I-1]
       ADD(Q)
       szWork = szWork[I+1 : LEN(szWork)]
    ELSE
       Q.szSnip = szWork
       ADD(Q)
       BREAK
    END
  END

  bStructure = FALSE
  GET(Q,1)
  CASE UPPER(Q.szSnip)
    OF 'SELF'
       szWork = szSelf
    OF 'PARENT'
       szWork = szParent
  ELSE
    ClassQ.szClassSort = UPPER(szSelf)
    GET(ClassQ,+ClassQ.szClassSort)
?  ASSERT(~ERRORCODE())
    PropertyQ.lClassId = ClassQ.lClassId
    PropertyQ.szPropertySort = UPPER(Q.szSnip)
    GET(PropertyQ,+PropertyQ.lClassId,+PropertyQ.szPropertySort)
?  ASSERT(~ERRORCODE())
    szWork = CLIP(PropertyQ.szDataType[2 : LEN(PropertyQ.szDataType)])
  END
  J = RECORDS(Q)
  LOOP I = 2 TO J - 1
    IF ~bStructure   !if not part of a structure
       ClassQ.szClassSort = UPPER(szWork)
       GET(ClassQ,+ClassQ.szClassSort)
       IF ERRORCODE()
          !Maybe it is a structure
          StructureQ.szStructureSort = UPPER(szWork)
          GET(StructureQ,+StructureQ.szStructureSort)
         !ASSERT(~ERRORCODE())
          IF ~ERRORCODE()
             bStructure = TRUE
             GET(Q,I)
             DO FindStructureElement
          END
       ELSE
          LOOP
             PropertyQ.lClassID = ClassQ.lClassID
             GET(Q,I)
             PropertyQ.szPropertySort = UPPER(Q.szSnip)
             GET(PropertyQ,+PropertyQ.lClassID,+PropertyQ.szPropertySort)
             IF ERRORCODE()
                !Might be property of parent class
                IF ClassQ.szParentClassName
                   ClassQ:szClassSort = UPPER(ClassQ.szParentClassName)
                   GET(ClassQ,+ClassQ:szClassSort)
                   IF ERRORCODE()
                      szWork = szWork & '.' & Q.szSnip
                      BREAK
                   END
                ELSE
                   szWork = szWork & '.' & Q.szSnip
                   BREAK
                END
             ELSE
                BREAK
             END
          END
          IF ~ERRORCODE()
             IF PropertyQ.szDataType[1] = '&'
                szWork = CLIP(PropertyQ.szDataType[2 : LEN(PropertyQ.szDataType)])
             ELSIF UPPER(PropertyQ.szDataType[1 : 5]) = 'LIKE('
                szWork = CLIP(PropertyQ.szDataType[6 : LEN(PropertyQ.szDataType)-1])
             ELSIF UPPER(PropertyQ.szDataType[1 : 6]) = 'QUEUE('
                szWork = CLIP(PropertyQ.szDataType[7 : LEN(PropertyQ.szDataType)-1])
             ELSIF UPPER(PropertyQ.szDataType[1 : 6]) = 'GROUP('
                szWork = CLIP(PropertyQ.szDataType[7 : LEN(PropertyQ.szDataType)-1])
             ELSE
                szWork = CLIP(PropertyQ.szDataType)
             END
          END
          ClassQ.szClassSort = UPPER(szSelf)
          GET(ClassQ,+ClassQ:szClassSort)
?        ASSERT(~ERRORCODE())
       END
    ELSE !resolving structure
       DO FindStructureElement
    END
  END
  IF J > 1
     GET(Q,J)
     szWork = szWork & '.' & Q.szSnip
  END
  RETURN(szWork)

FindStructureElement        ROUTINE
  lStructureQPointer = POINTER(StructureQ)+1
  lStructureQRecords = RECORDS(StructureQ)
  LOOP lStructureQPointer = lStructureQPointer TO lStructureQRecords
     GET(StructureQ,lStructureQPointer)
     IF StructureQ.szStructureSort = UPPER(szWork)
        IF UPPER(StructureQ.szDataLabel) = UPPER(Q.szSnip)
           IF StructureQ.szDataType[1] = '&'
              szWork = CLIP(StructureQ.szDataType[2 : LEN(StructureQ.szDataType)])
           ELSIF UPPER(StructureQ.szDataType[1 : 5]) = 'LIKE('
              szWork = CLIP(StructureQ.szDataType[6 : LEN(StructureQ.szDataType)-1])
           ELSIF UPPER(StructureQ.szDataType[1 : 6]) = 'QUEUE('
              szWork = CLIP(StructureQ.szDataType[7 : LEN(StructureQ.szDataType)-1])
           ELSIF UPPER(StructureQ.szDataType[1 : 6]) = 'GROUP('
              szWork = CLIP(StructureQ.szDataType[7 : LEN(StructureQ.szDataType)-1])
           ELSE
?             MESSAGE(StructureQ.szDataType,'What Now?')
           END
        END
     ELSE
        BREAK
     END
  END
? IF lStructureQPointer > lStructureQRecords
?    MESSAGE('Error Getting Structure Element: ' & StructureQ.szStructureSort & '.' & StructureQ.szDataLabel)
? END
  EXIT
