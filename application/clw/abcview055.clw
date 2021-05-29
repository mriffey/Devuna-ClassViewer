

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
!!! Update Class Property
!!! </summary>
winUpdateProperty PROCEDURE 

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
ActionMessage        CSTRING(40)                           ! 
PRO:PropertyName     CSTRING(65)                           ! 
PRO:DataType         CSTRING(31)                           ! 
PRO:Scope            CSTRING(17)                           ! 
PRO:ReferenceVar     BYTE                                  ! 
window               WINDOW('Update Property'),AT(,,214,100),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,TILED,CENTER, |
  GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       PANEL,AT(4,4,206,74),USE(?Panel1),FILL(COLOR:BTNFACE)
                       PROMPT('&Property Name:'),AT(8,8),USE(?PRO:PropertyName:Prompt),TRN
                       ENTRY(@s64),AT(62,8,,10),USE(PRO:PropertyName)
                       PROMPT('&Data Type:'),AT(8,22),USE(?PRO:DataType:Prompt),TRN
                       COMBO(@s30),AT(62,22,,10),USE(PRO:DataType),LEFT(2),VSCROLL,DROP(10),FROM('ANY|#ANY|AST' & |
  'RING|#ASTRING|BFLOAT4|#BFLOAT4|BFLOAT8|#BFLOAT8|BYTE|#BYTE|CLASS|#CLASS|CSTRING|#CST' & |
  'RING|DATE|#DATE|DECIMAL|#DECIMAL|INTERFACE|#INTERFACE|LIKE|#LIKE|LONG|#LONG|MEMO|#ME' & |
  'MO|PDECIMAL|#PDECIMAL|PSTRING|#PSTRING|REAL|#REAL|SHORT|#SHORT|SIGNED|#SIGNED|SREAL|' & |
  '#SREAL|STRING|#STRING|STRUCTURE|#STRUCTURE|TIME|#TIME|ULONG|#ULONG|UNSIGNED|#UNSIGNE' & |
  'D|USHORT|#USHORT')
                       PROMPT('&Scope:'),AT(8,36),USE(?PRO:Scope:Prompt),TRN
                       LIST,AT(62,36,,10),USE(PRO:Scope),LEFT(2),DROP(5),FROM('Public|#Public|Private|#Private' & |
  '|Protected|#Protected')
                       CHECK(' &Reference Variable'),AT(62,50,,10),USE(PRO:ReferenceVar),COLOR(COLOR:BTNFACE),VALUE('1', |
  '0')
                       BUTTON('&OK'),AT(116,82,45,14),USE(?OK),DEFAULT,REQ
                       BUTTON('Cancel'),AT(165,82,45,14),USE(?Cancel)
                       STRING(@S40),AT(8,64),USE(ActionMessage),TRN
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
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

I               LONG,AUTO
J               LONG,AUTO
loc:szClassName LIKE(ClassQ.szClassName),AUTO
loc:lClassId    LIKE(ClassQ.lClassId),AUTO
  CODE
  GlobalErrors.SetProcedureName('winUpdateProperty')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  !Initialise the fields
  CASE SELF.Request
  OF InsertRecord
     PRO:PropertyName = ''
     PRO:DataType = ''
     PRO:Scope = ''
     PRO:ReferenceVar = FALSE
  OF ChangeRecord
     PRO:PropertyName = PropertyQ.szPropertyName
     IF PropertyQ.szDataType[1] = '&'
        PRO:ReferenceVar = TRUE
        PRO:DataType = PropertyQ.szDataType[2 : LEN(PropertyQ.szDataType)]
        IF srcIsClassReference(PropertyQ.szDataType,loc:szClassName,loc:lClassId)
           PRO:DataType = 'CLASS'
        END
     ELSE
        PRO:ReferenceVar = FALSE
        PRO:DataType = '&' & PropertyQ.szDataType
        IF srcIsClassReference(PRO:DataType,loc:szClassName,loc:lClassId)
           PRO:DataType = 'CLASS'
        ELSE
           PRO:DataType = PropertyQ.szDataType
        END
     END
     IF PropertyQ.bPrivate
        PRO:Scope = 'Private'
     ELSIF PropertyQ.bProtected
        PRO:Scope = 'Protected'
     ELSE
        PRO:Scope = 'Public'
     END
  OF DeleteRecord
     !Ask Delete Reecord
  END
  SELF.Open(window)                                        ! Open window
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
  window{PROP:HLP} = '~WINUPDATEPROPERTY'
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
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    OF ?Cancel
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

