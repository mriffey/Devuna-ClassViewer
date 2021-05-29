

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

   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
 List::WndProc         (HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam),LONG,PASCAL
                     END


List::OrigWndProc    LONG,THREAD
!!! <summary>
!!! Generated from procedure template - Window
!!! Display The Note Queue
!!! </summary>
winFindNotes PROCEDURE 

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
bSynchronize         BYTE                                  ! 
Window               WINDOW('Find Notes'),AT(,,318,226),RESIZE,TILED,ICON('abcview.ico'),GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF'),IMM
                       LIST,AT(6,4,306,200),USE(?List),ALRT(MouseLeft2),COLOR(COLOR:White,COLOR:HIGHLIGHTTEXT,COLOR:HIGHLIGHT), |
  FLAT,FORMAT('120L(2)|M~Item~S(500)@s255@#2#190L(2)|M~Note~S(500)@s255@'),FROM(NoteQ),TIP('List of annotations')
                       BUTTON('Cl&ose'),AT(268,208,45,14),USE(?Close),TIP('Return to the previous window')
                       IMAGE('tcorner.gif'),AT(310,218),USE(?SizeGrip)
                     END

tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(bSynchronize)

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
rc                   LIKE(RECT)
hRgnUpdate           HRGN
  CODE
  GlobalErrors.SetProcedureName('winFindNotes')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
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
  
  GET(NoteQ,1)
  ?List{PROP:Selected} = 1
  !----------------------------------------------------------------------
  ! Set Window Style
  !----------------------------------------------------------------------
  kcr_SetWindowLong(Window{prop:handle},GWL_STYLE,BXOR(kcr_GetWindowLong(Window{prop:handle},GWL_STYLE),WS_MINIMIZEBOX))
  kcr_GetWindowRect(Window{prop:handle},rc)
  kcr_InvalidateRect(Window{prop:handle},rc,TRUE)
  hRgnUpdate = kcr_CreateRectRgn(0,0,1,1)
  kcr_SendMessage(Window{prop:handle},WM_NCPAINT,kcr_GetUpdateRgn(Window{prop:handle},hRgnUpdate,FALSE),0)
  !----------------------------------------------------------------------
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:NoResize,Resize:SetMinSize)     ! Don't change the windows controls when window resized
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  List::OrigWndProc = ?List{Prop:WndProc}           ! Save address OF code that handles window messages
  ?List{Prop:WndProc} = ADDRESS(List::WndProc)      ! Re-assign address OF code that handles window messages
  
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINFINDNOTES'
  Resizer.Resize()
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Find_Notes.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Find_Notes.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  IF List::OrigWndProc
     ?List{Prop:WndProc} = List::OrigWndProc        ! Restore the handler for this window
  END
  
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
  OF ?List
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft2
         GET(NoteQ,CHOICE(?List))
         winViewNote(NoteQ:bClarionVersion,NoteQ:szLookup)
      END
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseWindow
      !IF CHOICE(?List)
         GET(NoteQ,CHOICE(?List))
      !ELSE
      !   GET(NoteQ,1)
      !END
    END
  ReturnValue = PARENT.TakeWindowEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?Close, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?Close
  SELF.SetStrategy(?SizeGrip, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?SizeGrip

!========================================================================================
List::WndProc PROCEDURE(HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam)
!========================================================================================
lb          LIKE(LOGBRUSH)
hOldBrush   UNSIGNED
hBrush      UNSIGNED
hDC         UNSIGNED
hCheckBox   UNSIGNED
rVal        UNSIGNED
crColor     COLORREF
crBrush     COLORREF(12164479)
rc          LIKE(RECT)

    CODE
    CASE wMsg
    OF WM_PAINT
       rVal = CallWindowProc(List::OrigWndProc,hWnd,wMsg,wParam,lParam)
       hDC = getWindowDC(hWnd)
       crColor = GetPixel(hDC,0,0)
       IF crColor <> crBrush
          lb.lbStyle = BS_SOLID
          lb.lbColor = crBrush
          lb.lbHatch = 0
          hBrush = CreateBrushIndirect(lb)
          hOldBrush = SelectObject(hDC,hBrush)
    
       !   ExtFloodFill(hDC,0,0,crColor,FLOODFILLSURFACE)
    
          GetWindowRect(hWnd,rc)
          OffsetRect(rc,-rc.left,-rc.top)
          FrameRect(hDC,rc,hBrush)
    
          SelectObject(hDC,hOldBrush)
          DeleteObject(hBrush)
       END
       ReleaseDC(hWnd,hDC)
       RETURN(rVal)
    END
    RETURN(CallWindowProc(List::OrigWndProc,hWnd,wMsg,wParam,lParam))

