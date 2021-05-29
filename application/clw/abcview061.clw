

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
                     MAP
EnumWindowProc         PROCEDURE(HWND HWnd, LPARAM lParam),BOOL,PASCAL
                     END

hwndClarion          LONG
!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
srcFindWindow        PROCEDURE  (STRING sWindowText)       ! Declare Procedure
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
szSearchText    CSTRING(256)

  CODE
  szSearchText = UPPER(CLIP(sWindowText))
  hWndClarion = 0
  EnumWindows(EnumWindowProc,ADDRESS(szSearchText))
  RETURN(hwndClarion)
EnumWindowProc        PROCEDURE(HWND hWnd,LPARAM lParam)
szText  CSTRING(61)
szSearchText &CSTRING
  CODE
  szSearchText &= (lParam)
  GetWindowText(hWnd,szText,SIZE(szText))
  !IF UPPER(SUB(szText,1,7)) = 'CLARION'
  IF UPPER(SUB(szText,1,LEN(szSearchText))) = szSearchText  !'CLARION'
     hWndClarion = hWnd
  END
  RETURN TRUE
