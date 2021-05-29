

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
!!! Insert CRLF to word wrap
!!! </summary>
srcWordWrap          PROCEDURE  (s,w)                      ! Declare Procedure
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
I   LONG,AUTO
J   LONG,AUTO
K   LONG,AUTO
s1  CSTRING(255)
sz  CSTRING(4096)

  CODE
  I = 0
  LOOP WHILE I < (LEN(s)-w)
    s1 = s[I+1 : I+w]
    !look for cr
    J = INSTRING('<13>',s1)
    IF J
       s1[J] = '<0>'
       I += (LEN(s1) + 2)
    ELSE    !break at last space
       K = LEN(s1)
       LOOP J = K TO 1 BY -1
         IF s1[J] = ' '
            s1[J] = '<0>'
            BREAK
         END
       END
       I += (LEN(s1) + 1)
    END
    sz = sz & s1 & '<13,10>'
  END
  IF I < (LEN(s)-1)
    s1 = s[I+1 : LEN(s)]
    sz = sz & s1 & '<13,10>'
  END
  sz[LEN(sz)-2] = '<0>'
  s = sz
  IF s <> sz    !truncated?
     s = s[1 : LEN(s)-5] & '.....'
  END
