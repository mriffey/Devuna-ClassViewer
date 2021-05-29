

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
!!! Normalize String for XML Output
!!! </summary>
srcNormalizeString   PROCEDURE  (s)                        ! Declare Procedure
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
pAmp        LONG,AUTO
sz          CSTRING(256),AUTO

  CODE
  !look for and replace special characters
  sz = CLIP(LEFT(s))
  pAmp = INSTRING('&',sz)
  LOOP WHILE pAmp <> 0
     sz = sz[1 : pAmp] & 'amp;' & sz[pamp+1 : LEN(sz)]
     pAmp = INSTRING('&',sz,1,pAmp+1)
  END
  pAmp = INSTRING('<<',sz)
  LOOP WHILE pAmp <> 0
     sz = sz[1 : pAmp-1] & '&lt;' & sz[pamp+1 : LEN(sz)]
     pAmp = INSTRING('<<',sz)
  END
  pAmp = INSTRING('>',sz)
  LOOP WHILE pAmp <> 0
     sz = sz[1 : pAmp-1] & '&gt;' & sz[pamp+1 : LEN(sz)]
     pAmp = INSTRING('>',sz)
  END
  RETURN(sz)
