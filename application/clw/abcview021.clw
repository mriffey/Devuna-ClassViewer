

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
!!! get called methods from string
!!! </summary>
srcGetCalledMethods  PROCEDURE  (s,szSelf,szParent)        ! Declare Procedure
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
K                   LONG
M                   LONG    !
N                   LONG    !number of parenthesis
sDelimeters         STRING(' ,()[]''{{}+-*/%^<<>=~&')
sWork               CSTRING(256)
Q                   QUEUE,PRE()
szName                CSTRING(64)
lLineNum              LONG
                    END

ClassRefQ           QUEUE()
szClassRef            CSTRING(64)
                    END
lClassRefPointer    LONG
lClassRefRecords    LONG

szClassName         CSTRING(64)
lClassId            LONG

  CODE
  FREE(ClassRefQ)
  ClassRefQ.szClassRef = 'SELF.'
  ADD(ClassRefQ)
  IF szParent
     ClassRefQ.szClassRef = 'PARENT.'
     ADD(ClassRefQ)
  END
  ClassQ.szClassSort = UPPER(szSelf)
  GET(ClassQ,+ClassQ.szClassSort)
 ASSERT(~ERRORCODE())
  PropertyQ.lClassID = ClassQ.lClassId
  GET(PropertyQ,+PropertyQ.lClassID)
  IF ~ERRORCODE()
     I = POINTER(PropertyQ)
     J = RECORDS(PropertyQ)
     LOOP I = I TO J
       GET(PropertyQ,I)
       IF PropertyQ.lClassID <> ClassQ.lClassId
          BREAK
       ELSE
          IF PropertyQ.bModule
             IF srcIsClassReference(PropertyQ.szDataType,szClassName,lClassID)
                ClassRefQ.szClassRef = CLIP(PropertyQ.szPropertySort) & '.'
                ADD(ClassRefQ)
             END
          END
       END
     END
  END

  lClassRefRecords = RECORDS(ClassRefQ)
  LOOP lClassRefPointer = 1 TO lClassRefRecords
    GET(ClassRefQ,lClassRefPointer)
    sWork = CLIP(s)
    J = LEN(sWork)
    K = 1
    LOOP
      I = INSTRING(ClassRefQ.szClassRef,UPPER(sWork),1,K)
      IF I
         LOOP K = I TO J
           IF INSTRING(sWork[K],sDelimeters)
              BREAK
           END
         END
         Q.szName = sWork[I : K-1]
         IF Q.szName[LEN(Q.szName)] = '.'
            Q.szName[LEN(Q.szName)] = '<0>'
         END
         Q.lLineNum = glo:lLineNum
         ADD(Q)
         IF K > J
            BREAK
         END
      ELSE
         BREAK
      END
    END
  END

  J = RECORDS(Q)
  LOOP I = 1 TO J
    GET(Q,I)
    CallQ.szCalledMethod = srcResolveName(Q.szName,szSelf,szParent)
    IF srcIsClassMethod(CallQ.szCalledMethod)
       CallQ.lLineNum = Q.lLineNum
       ADD(CallQ)
    END
  END

  RETURN
