

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
!!! Remove unnecessary white space from passed string
!!! </summary>
srcRemoveWhitespace  PROCEDURE  (*STRING s)                ! Declare Procedure
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
szWork      CSTRING(4097),AUTO
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
bSkipSpaces BYTE,AUTO
oHH           &tagHTMLHelp

  CODE
  bSkipSpaces = FALSE
  szWork = ''
  J = LEN(CLIP(s))
  K = 0
  LOOP I = 1 TO J
    CASE s[I]
    OF ' '
       IF ~bSkipSpaces
          K += 1
          szWork[K] = s[I]
          bSkipSpaces = TRUE
       END
    ELSE
       bSkipSpaces = FALSE
       K += 1
       szWork[K] = s[I]
    END
  END
  K += 1
  szWork[K] = '<0>'

  ! replace ', ' with ','
  !==========================================
  J = LEN(szWork)
  I = INSTRING(', ',szWork,1)
  LOOP WHILE I <> 0
     szWork = szWork[1 : I] & szWork[I+2 : J]
     J = LEN(szWork)
     I = INSTRING(', ',szWork,1)
  END

  ! replace ') ' with ')'
  !==========================================
  J = LEN(szWork)
  I = INSTRING(') ',szWork,1)
  LOOP WHILE I <> 0
     szWork = szWork[1 : I] & szWork[I+2 : J]
     J = LEN(szWork)
     I = INSTRING(') ',szWork,1)
  END


  ! replace '( ' with '('
  !==========================================
  J = LEN(szWork)
  I = INSTRING('( ',szWork,1)
  LOOP WHILE I <> 0
     szWork = szWork[1 : I] & szWork[I+2 : J]
     J = LEN(szWork)
     I = INSTRING('( ',szWork,1)
  END

  ! replace ' ( ' with '('
  !==========================================
  J = LEN(szWork)
  I = INSTRING(' (',szWork,1)
  LOOP WHILE I <> 0
     szWork = szWork[1 : I-1] & szWork[I+1 : J]
     J = LEN(szWork)
     I = INSTRING(' (',szWork,1)
  END

  RETURN(CLIP(szWork))
