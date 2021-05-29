

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

   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

!!! <summary>
!!! Generated from procedure template - Window
!!! About Devuna
!!! </summary>
AboutDevuna PROCEDURE 

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
FilesOpened          BYTE                                  ! 
szNull               CSTRING(2)                            ! 
szURL                CSTRING(256)                          ! 
window               WINDOW('About Class Viewer'),AT(,,180,126),FONT('Tahoma',8,,FONT:regular,CHARSET:ANSI),DOUBLE, |
  CENTER,GRAY,HLP('About Devuna'),PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       PANEL,AT(0,0,180,126),USE(?Panel1),BEVEL(-1,-1)
                       STRING('Version 2015.03.05'),AT(49,4),USE(?String8),FONT(,10,,FONT:bold,CHARSET:ANSI),TRN
                       STRING('This computer program was developed by'),AT(23,17),USE(?String1),TRN
                       BOX,AT(14,32,160,56),USE(?Box1),FILL(COLOR:Black),LINEWIDTH(1),ROUND
                       BOX,AT(11,29,159,56),USE(?Box2),COLOR(COLOR:Black),FILL(COLOR:White),LINEWIDTH(1),ROUND
                       STRING('Devuna'),AT(75,32),USE(?String2),FONT(,10,,,CHARSET:ANSI),TRN
                       STRING('Box 103, Hepworth, Ontario'),AT(37,41),USE(?String3),FONT(,10,,,CHARSET:ANSI),TRN
                       STRING('Canada  N0H 1P0'),AT(57,51),USE(?String4),FONT(,10,,,CHARSET:ANSI),TRN
                       STRING('Tel: (519) 935-3201'),AT(57,61),USE(?String5),TRN
                       STRING('www.devuna.com'),AT(57,73),USE(?String4:2),FONT('MS Sans Serif',8,,FONT:bold+FONT:underline, |
  CHARSET:ANSI),TRN
                       REGION,AT(49,72,80,10),USE(?Region1),CURSOR('harrow.cur'),IMM
                       STRING('© Copyright 2001-2017'),AT(52,88),USE(?Copyright),FONT('Arial',8,,FONT:regular,CHARSET:ANSI), |
  TRN
                       STRING('Devuna'),AT(77,94),USE(?Devuna),FONT('Arial',8,,FONT:regular,CHARSET:ANSI),TRN
                       BUTTON('&OK'),AT(67,106,45,14),USE(?OK),DEFAULT
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AboutDevuna')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(window)                                        ! Open window
  ?String8{PROP:Text} = 'Version ' & glo:Version
  Do DefineListboxStyle
  SELF.SetAlerts()
  window{PROP:HLP} = '~ABOUTDEVUNA'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('About_Class_Viewer.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('About_Class_Viewer.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  IF ~oHH &= NULL
    oHH.Kill()
    DISPOSE( oHH )
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?OK
       POST(EVENT:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Region1
      szURL = 'http://www.devuna.com/'
      szNull = ''
      ShellExecute(window{prop:handle},0,szURL,0,szNull,1)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?Region1
    CASE EVENT()
    OF EVENT:MouseIn
      ?string4:2{PROP:FontColor} = color:blue
      SETCURSOR('~HARROW.CUR')
    OF EVENT:MouseOut
      ?string4:2{PROP:FontColor} = color:black
      SETCURSOR()
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

