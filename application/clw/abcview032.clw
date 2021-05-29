

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
!!! Edit Class Properties
!!! </summary>
winClassProperties PROCEDURE (CategoryQueue)

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
RetVal               BYTE                                  ! 
loc:CategoryQ:szCategory LIKE(CategoryQ:szCategory)        ! 
loc:CategoryQ:bDetailLevel LIKE(CategoryQ:bDetailLevel)    ! 
Window               WINDOW('Edit Class Properties'),AT(,,150,68),DOUBLE,TILED,CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       STRING('Class Name:'),AT(4,4),USE(?String2),TRN
                       STRING(@s63),AT(48,4,98,10),USE(ClassQ:szClassName),TRN
                       PROMPT('&Category:'),AT(4,18),USE(?CategoryQ:szCategory:Prompt),TRN
                       COMBO(@s63),AT(48,18,60,10),USE(loc:CategoryQ:szCategory),VSCROLL,UPR,COLOR(COLOR:White),DROP(10), |
  FORMAT('120L(2)@s64@'),FROM(CategoryQueue),TIP('Select from an existing category<0DH,0AH>' & |
  'or add one of your own.')
                       PROMPT('&Detail Level:'),AT(4,32),USE(?CategoryQ:bDetailLevel:Prompt),TRN
                       SPIN(@n3),AT(48,32,14,10),USE(loc:CategoryQ:bDetailLevel),COLOR(COLOR:White),STEP(1),TIP('Detail Lev' & |
  'el for this Class')
                       BUTTON('&OK'),AT(46,50,48,14),USE(?OkButton),DEFAULT,TIP('Save changes and return to th' & |
  'e previous window')
                       BUTTON('Cancel'),AT(99,50,48,14),USE(?CancelButton),TIP('Discard changes and return to ' & |
  'the previous window')
                     END

tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(RetVal)

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG
J   LONG
  CODE
  GlobalErrors.SetProcedureName('winClassProperties')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?String2
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  loc:CategoryQ:szCategory    = CategoryQ:szCategory
  loc:CategoryQ:bDetailLevel  = CategoryQ:bDetailLevel
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
  ClassQ.szClassName = CategoryQ.szClassName
  GET(ClassQ,+ClassQ.szClassName)
  IF ClassQ:szParentClassName
     DISABLE(?loc:CategoryQ:szCategory)
     ?loc:CategoryQ:szCategory{PROP:Background} = COLOR:BTNFACE
  END
  Do DefineListboxStyle
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINCLASSPROPERTIES'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Class_Properties.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Class_Properties.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  tt.Kill()                                                !ToolTipClass Cleanup
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  IF ~oHH &= NULL
    oHH.Kill()
    DISPOSE( oHH )
  END
  RETURN ReturnValue


ThisWindow.Open PROCEDURE

Fld     LONG,AUTO
  CODE
  PARENT.Open
  hwndTT = tt.init(Window{PROP:HANDLE},1)                  !ToolTipClass Initialization
  IF hwndTT
    !This code is placed to instantly enable tooltips on all controls
    Fld = 0
    LOOP
       Fld = Window{PROP:NextField,Fld}
       IF Fld = 0
          BREAK
       ELSE
          IF Fld{PROP:TIP}
             IF INSTRING('<13,10>',Fld{PROP:TIP},1,1)
                Tt.addtip(Fld{PROP:HANDLE},Fld{PROP:TIP},1)
             ELSE
                Tt.addtip(Fld{PROP:HANDLE},Fld{PROP:TIP},0)
             END!IF
             Fld{PROP:TIP}=''
          END!IF
       END
    END
     tt.SetTipTextColor(8388608)
  END


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
    OF ?OkButton
      ThisWindow.Update()
      UPDATE()
      CategoryQ.szCategory    = loc:CategoryQ:szCategory
      CategoryQ.bDetailLevel  = loc:CategoryQ:bDetailLevel
      PUT(CategoryQ)
      CategoryQueue.szCategory = CategoryQ.szCategory
      GET(CategoryQueue,+CategoryQueue.szCategory)
      IF ERRORCODE()
         CASE MESSAGE('Add to Pick List?','Class Viewer',ICON:QUESTION,BUTTON:YES+BUTTON:NO,BUTTON:YES)
         OF BUTTON:YES
            CategoryQueue.szCategory = CategoryQ.szCategory
            ADD(CategoryQueue,+CategoryQueue.szCategory)
         END
      END
      RetVal = 0
       POST(EVENT:CloseWindow)
    OF ?CancelButton
      ThisWindow.Update()
      RetVal = 1
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

