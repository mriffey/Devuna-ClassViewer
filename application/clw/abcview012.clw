

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
!!! Compare with blanks suppressed
!!! </summary>
srcEqual             PROCEDURE  (S1, S2)                   ! Declare Procedure
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
A   CSTRING(1024),AUTO
B   CSTRING(1024),AUTO
I   LONG,AUTO
J   LONG,AUTO
K   LONG,AUTO

  CODE
  !remove blanks from s1
  A = ''
  K = 0
  J = LEN(S1)
  LOOP I = 1 TO J
    IF S1[I] <> ' '
       K += 1
       A[K] = S1[I]
    END
  END
  A[K+1] = '<0>'
  !remove blanks from s2
  B = ''
  K = 0
  J = LEN(S2)
  LOOP I = 1 TO J
    IF S2[I] <> ' '
       K += 1
       B[K] = S2[I]
    END
  END
  B[K+1] = '<0>'
  !compare
  IF A = B
     RETURN(TRUE)
  ELSE
     RETURN(FALSE)
  END
