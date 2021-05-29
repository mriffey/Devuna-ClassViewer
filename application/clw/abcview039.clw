

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
!!! Splash Screen
!!! </summary>
winLoading           PROCEDURE                             ! Declare Procedure
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
Count  BYTE
Window WINDOW,AT(,,140,50),CENTER,GRAY,FONT('Tahoma',10,,FONT:regular,CHARSET:ANSI), |
            TIMER(100),WALLPAPER('WALLPAPER.GIF'),DOUBLE
        IMAGE('abcview.ico'),AT(6,4,14,12),USE(?Image1),CENTERED
        STRING('Class Viewer'),AT(40,3,60),USE(?String1),TRN,FONT('Tahoma',12, |
                COLOR:Navy,FONT:bold,CHARSET:ANSI)
        STRING('<169> Copyright 2001-2017'),AT(31,17),USE(?Copyright),TRN, |
                FONT('Arial',8,,FONT:regular,CHARSET:ANSI)
        STRING('Devuna'),AT(59,23),USE(?Devuna),TRN,FONT('Arial',8,, |
                FONT:regular,CHARSET:ANSI)
        STRING('Loading Database - Please Wait'),AT(7,34),CURSOR(CURSOR:Wait), |
                USE(?String2),TRN,FONT(,,COLOR:Navy,FONT:bold,CHARSET:ANSI)
        STRING('...'),AT(125,34),CURSOR(CURSOR:Wait),USE(?String3),TRN, |
                FONT(,,COLOR:Navy,FONT:bold,CHARSET:ANSI)
    END

  CODE
  OPEN(Window)
  Window{PROP:Buffer} = 1
  ACCEPT
    CASE EVENT()
    OF EVENT:TIMER
       Count += 1
       Count = Count % 3
       EXECUTE Count + 1
          ?String3{PROP:TEXT} = '...'
          ?String3{PROP:TEXT} = '.'
          ?String3{PROP:TEXT} = '..'
       END
    OF EVENT:CloseWindow
       Count += 1
       IF Count = 2
          BREAK
       END
    OF Event:CloseDown
       BREAK
    END
  END
  CLOSE(Window)
  glo:lLoadingThread = 0
  POST(EVENT:User,,1)
