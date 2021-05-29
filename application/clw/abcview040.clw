

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
!!! </summary>
_main                PROCEDURE                             ! Declare Procedure
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
szModuleName    CSTRING('SciLexer.DLL')
oHH           &tagHTMLHelp
Window WINDOW('Class Viewer'),AT(0,0,10,10)
     END

  CODE
  IF ProgramIsRunning('ABCVIEW', 'ClassViewer')
?    MESSAGE('Program is already running, cannot run another instance','Class Viewer',ICON:HAND)
     RETURN
  END

  OPEN(Window)
  Window{PROP:Hide} = TRUE
  ACCEPT
    CASE EVENT()
    OF EVENT:OpenWindow
       glo:hwnd_main = Window{PROP:Handle}
       glo:lMainThread = START(Main,64000)
       glo:lLoadingThread = START(winLoading,10000)
    OF EVENT:CloseWindow OROF EVENT:CloseDown
       IF glo:lLoadingThread
          POST(EVENT(),,glo:lLoadingThread)
       END
       IF glo:lMainThread
          POST(EVENT(),,glo:lMainThread)
       END
    END
  END
  CLOSE(Window)
