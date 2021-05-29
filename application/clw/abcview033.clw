

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

                     MAP
 List::WndProc         (HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam),LONG,PASCAL
                     END


List::OrigWndProc    LONG,THREAD
!!! <summary>
!!! Generated from procedure template - Window
!!! View Methods that Call passed Method
!!! </summary>
winViewCallers PROCEDURE (psCalledMethod)

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
q                    QUEUE,PRE(q)                          ! 
szCallingMethod      LIKE(CallQ.szCallingMethod)           ! 
szCalledMethod       LIKE(CallQ.szCalledMethod)            ! 
                     END                                   ! 
Window               WINDOW('View Calling Methods'),AT(,,150,68),DOUBLE,TILED,CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       LIST,AT(4,4,142,43),USE(?List),VSCROLL,COLOR(COLOR:White),FLAT,FORMAT('140L(2)@s63@'),FROM(q)
                       BUTTON('Cl&ose'),AT(99,50,48,14),USE(?CancelButton),STD(STD:Close)
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

I   LONG
J   LONG
  CODE
  GlobalErrors.SetProcedureName('winViewCallers')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
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
  Window{PROP:Text} = 'Methods that call ' & CLIP(psCalledMethod)
  J = RECORDS(CallQ)
  LOOP I = 1 TO J
     GET(CallQ,I)
     IF CallQ.szCalledMethod = CLIP(psCalledMethod)
        q.szCallingMethod = CallQ.szCallingMethod
        GET(q,+q.szCallingMethod)
        IF ERRORCODE()
           q.szCallingMethod = CallQ.szCallingMethod
           q.szCalledMethod = CallQ.szCalledMethod
           ADD(q,+q.szCallingMethod)
        END
     END
  END
  Do DefineListboxStyle
  List::OrigWndProc = ?List{Prop:WndProc}           ! Save address OF code that handles window messages
  ?List{Prop:WndProc} = ADDRESS(List::WndProc)      ! Re-assign address OF code that handles window messages
  
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINVIEWCALLERS'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('View_Callers.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('View_Callers.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  IF List::OrigWndProc
     ?List{Prop:WndProc} = List::OrigWndProc        ! Restore the handler for this window
  END
  
  FREE(q)
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  GlobalErrors.SetProcedureName
  IF glo:bUseHTMLHelp
  IF ~oHH &= NULL
    oHH.Kill()
    DISPOSE( oHH )
  END
  END
  RETURN ReturnValue

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

