

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
!!! </summary>
winShowStatistics PROCEDURE 

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
Modules              LONG                                  ! 
Classes              LONG                                  ! 
Interfaces           LONG                                  ! 
Methods              LONG                                  ! 
Structures           LONG                                  ! 
Equates              LONG                                  ! 
Window               WINDOW('Class Viewer Statistics'),AT(,,86,94),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,CENTER, |
  GRAY,PALETTE(256)
                       PANEL,AT(4,4,78,68),USE(?Panel1)
                       PROMPT('Modules:'),AT(8,8),USE(?Modules:Prompt),TRN
                       STRING(@n6),AT(48,8),USE(Modules),RIGHT,TRN
                       PROMPT('Classes:'),AT(8,18),USE(?Classes:Prompt),TRN
                       STRING(@n6),AT(48,18),USE(Classes),RIGHT,TRN
                       PROMPT('Interfaces:'),AT(8,28),USE(?Interfaces:Prompt),TRN
                       STRING(@n6),AT(48,28),USE(Interfaces),RIGHT,TRN
                       PROMPT('Methods:'),AT(8,38),USE(?Methods:Prompt),TRN
                       STRING(@n6),AT(48,38),USE(Methods),RIGHT,TRN
                       PROMPT('Structures:'),AT(8,48),USE(?Structures:Prompt),TRN
                       STRING(@n6),AT(48,48),USE(Structures),RIGHT,TRN
                       PROMPT('Equates:'),AT(8,58),USE(?Equates:Prompt),TRN
                       STRING(@n6),AT(48,58),USE(Equates),RIGHT,TRN
                       BUTTON('&OK'),AT(21,76,45,14),USE(?OkButton),DEFAULT,STD(STD:Close)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
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

I   LONG,AUTO
J   LONG,AUTO
  CODE
  GlobalErrors.SetProcedureName('winShowStatistics')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  Modules = RECORDS(ModuleQ)
  Classes = 0
  Interfaces = 0
  J = RECORDS(ClassQ)
  LOOP I = 1 TO J
     GET(ClassQ,I)
     IF ClassQ.bInterface = TRUE
        Interfaces += 1
     ELSE
        Classes += 1
     END
  END
  Methods = RECORDS(MethodQ)
  Structures = RECORDS(StructureQ)
  Equates = RECORDS(EnumQ)
  SELF.Open(Window)                                        ! Open window
  CASE glo:Background
  OF 1  !Color
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = glo:Color2
  OF 2  !Wallpaper
     window{PROP:Wallpaper} = glo:szWallpaper2
     window{PROP:Tiled} = glo:Tiled2
     window{PROP:Color} = COLOR:NONE
  OF 3  !None
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = COLOR:NONE
  END
  J = LASTFIELD()
  LOOP I = 1 TO J
     SETFONT(I,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  END
  Do DefineListboxStyle
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINSHOWSTATISTICS'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
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

