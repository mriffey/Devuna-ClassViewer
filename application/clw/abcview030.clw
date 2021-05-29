

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
!!! Edit Additional Files List
!!! </summary>
winAdditionalFiles PROCEDURE (pModuleQ, bClarionVersion)

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
Q                    QUEUE(MODULEQTYPE),PRE(Q)             ! 
bID                  BYTE                                  ! 
                     END                                   ! 
DeleteQ              QUEUE(MODULEQTYPE),PRE(DQ)            ! 
                     END                                   ! 
Window               WINDOW('Additional Files'),AT(,,198,178),DOUBLE,TILED,CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       LIST,AT(4,4,190,130),USE(?List),VSCROLL,ALRT(MouseLeft2),COLOR(COLOR:White,COLOR:HIGHLIGHTTEXT, |
  COLOR:HIGHLIGHT),FLAT,FORMAT('60L(1)|FM~File Name~@s63@?1020L(1)F~Path~S(255)@s255@'),FROM(Q), |
  MSG('Browsing Queue'),TIP('List of Additional Files to include in the database.')
                       BUTTON('&Insert'),AT(4,138,45,12),USE(?Insert),KEY(InsertKey),TIP('Add a New File to th' & |
  'e Additional Files List')
                       BUTTON('&Delete'),AT(53,138,45,12),USE(?Delete),KEY(DeleteKey),TIP('Delete the currentl' & |
  'y highlighted entry<0DH,0AH>from the Additional Files List')
                       BUTTON('Edit'),AT(102,138,45,12),USE(?Edit),HIDE,TIP('Edit the path for the currently h' & |
  'ighlighted<0DH,0AH>file in the Additional Files List')
                       PANEL,AT(4,154,190,1),USE(?Panel1),BEVEL(-1,1)
                       BUTTON('&OK'),AT(99,160,45,14),USE(?OKButton),TIP('Save changes and return to the previ' & |
  'ous window')
                       BUTTON('Cancel'),AT(149,160,45,14),USE(?CancelButton),TIP('Discard changes and return t' & |
  'o the previous window')
                     END

QEIP5:Fields        FieldPairsClass
QEIP5:PopupString   STRING(20)
QEIP5:PopupMgr      PopupClass
QEIP5:EditList      QUEUE(EditQueue),PRE(QEIP5)
                              END
QEIP5:EM            CLASS(EIPManager)
TabAction             BYTE
EnterAction           BYTE
ArrowAction           BYTE
FocusLossAction       BYTE
CurrentChoice         LONG,PRIVATE
AddControl            PROCEDURE(<EditClass EC>,UNSIGNED Column,BYTE AutoFree = 0)
ClearColumn           PROCEDURE,VIRTUAL
Init                  PROCEDURE,BYTE,DERIVED,PROC
InitControls          PROCEDURE,VIRTUAL
Kill                  PROCEDURE,PROC,BYTE,DERIVED
Next                  PROCEDURE,PROTECTED
GetEdit               PROCEDURE,BYTE,VIRTUAL,PROTECTED
ResetColumn           PROCEDURE,VIRTUAL,PROTECTED
Run                   PROCEDURE(BYTE Req),BYTE
TakeAction            PROCEDURE(UNSIGNED Action),VIRTUAL
TakeCompleted         PROCEDURE(BYTE Force),VIRTUAL   ! Note this does -not- override the WindowManager variant
TakeEvent             PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent        PROCEDURE,DERIVED,BYTE,PROC
TakeFocusLoss         PROCEDURE,VIRTUAL
TakeNewSelection      PROCEDURE,DERIVED,BYTE,PROC
                    END
tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


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
  GlobalErrors.SetProcedureName('winAdditionalFiles')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  FREE(Q)
  J = RECORDS(pModuleQ)
  LOOP I = 1 TO J
    GET(pModuleQ,I)
    IF pModuleQ.bClarionVersion = bClarionVersion
       CASE pModuleQ.szModuleName
         OF 'EQUATES.CLW'   |
       OROF 'KEYCODES.CLW'  |
       OROF 'ERRORS.CLW'    |
       OROF 'TPLEQU.CLW'    |
       OROF 'PROPERTY.CLW'  |
       OROF 'WINEQU.CLW'    |
       OROF 'PRNPROP.CLW'   |
       OROF 'WINDOWS.INC'   |
            !skip standard equate files
       ELSE
            Q = pModuleQ
            ADD(Q,+Q.szModuleName,+Q.szModulePath)
       END
    END
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
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Spread)                         ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  List::OrigWndProc = ?List{Prop:WndProc}           ! Save address OF code that handles window messages
  ?List{Prop:WndProc} = ADDRESS(List::WndProc)      ! Re-assign address OF code that handles window messages
  
  SELF.SetAlerts()
  QEIP5:Fields.Init()
  QEIP5:Fields.AddPair(Q.szModuleName,Q.szModuleName)
  QEIP5:Fields.AddPair(Q.szModulePath,Q.szModulePath)
  QEIP5:PopupMgr.Init()
  QEIP5:PopupMgr.AddItemMimic('Edit',?Edit)
  GlobalErrors.AddErrors(QEIP:Errors)
  ?List{Prop:Alrt,QEIP:MouseLeft2Index} = MouseLeft2
  ?List{Prop:Alrt,QEIP:MouseRightIndex} = MouseRight
  Window{PROP:HLP} = '~WINADDITIONALFILES'
  SetWindowLong(Window{prop:handle},GWL_STYLE,BAND(GetWindowLong(Window{prop:handle},GWL_STYLE),0DFFFFFFFh))
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Additional_Files.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Additional_Files.htm')
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


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  PARENT.Reset(Force)
  IF ~RECORDS(Q) OR ~CHOICE(?List)
     DISABLE(?Delete)
  ELSE
     ENABLE(?Delete)
  END


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
szFilenames CSTRING(4096)
szFilename  CSTRING(256)
I           LONG
J           LONG
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Insert
      ThisWindow.Update()
      IF FILEDIALOG('Select files to include...',szFilenames,'Clarion Source Files (*.CLW;*.INC;*.INT;*.TXT)|*.CLW;*.INC;*.INT;*.TXT|All Files (*.*)|*.*',FILE:KeepDir+FILE:NoError+FILE:Multi+FILE:LongName)
         IF INSTRING('|',szFilenames)
            !Multiple files selected
            J = LEN(szFilenames)
            I = INSTRING('|',szFilenames)
            Q.szModulePath = UPPER(szFilenames[1 : I-1]) & '\'
            szFilenames = SUB(szFilenames,I+1,J-I)
            LOOP WHILE szFilenames
              J = LEN(szFilenames)
              I = INSTRING('|',szFilenames)
              IF I
                 Q.szModuleName = UPPER(szFilenames[1 : I-1])
                 szFilenames = SUB(szFilenames,I+1,J-I)
              ELSE
                 Q.szModuleName = UPPER(szFilenames)
                 szFilenames = ''
              END
              Q.bClarionVersion = bClarionVersion
              GET(Q,+Q.szModuleName,+Q.szModulePath)
              IF ERRORCODE()
                 ADD(Q,+Q.szModuleName,+Q.szModulePath)
              END
            END
         ELSE
            !Only a single file selected
            J = LEN(szFilenames)
            LOOP I = J TO 1 BY -1
              IF szFilenames[I] = '\'
                 Q.szModuleName = UPPER(szFilenames[I+1 : J])
                 Q.szModulePath = UPPER(szFilenames[1 : I])
                 Q.bClarionVersion = bClarionVersion
                 GET(Q,+Q.szModuleName,+Q.szModulePath)
                 IF ERRORCODE()
                    ADD(Q,+Q.szModuleName,+Q.szModulePath)
                 END
                 BREAK
              END
            END
         END
      END
    OF ?Delete
      ThisWindow.Update()
      GET(Q,CHOICE(?List))
      IF CHOOSE(GlobalErrors.Throw(Msg:ConfirmDelete) = Level:Benign,RequestCompleted,RequestCancelled) = RequestCompleted
         DeleteQ = Q
         ADD(DeleteQ)
         DELETE(Q)
      END
    OF ?Edit
      ThisWindow.Update()
      LOOP
        ThisWindow.VCRRequest = VCR:None
        IF KEYCODE() = MouseRightUp
          SETKEYCODE(0)
        END
        ReturnValue = QEIP5:EM.Run(ChangeRecord)
        CASE ThisWindow.VCRRequest
          OF VCR:Forward
             IF POINTER(Q) < RECORDS(Q)
                GET(Q,POINTER(Q)+1)
                ?List{PROP:Selected} = POINTER(Q)
                QEIP5:EM.ResetColumn()
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
          OF VCR:Backward
             IF POINTER(Q) > 1
                GET(Q,POINTER(Q)-1)
                ?List{PROP:Selected} = POINTER(Q)
                QEIP5:EM.ResetColumn()
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
        END
      UNTIL ThisWindow.VCRRequest = VCR:None
    OF ?OKButton
      ThisWindow.Update()
      J = RECORDS(DeleteQ)
      LOOP I = 1 TO J
        GET(DeleteQ,I)
        pModuleQ = DeleteQ
        GET(pModuleQ,+pModuleQ.szModuleName,+pModuleQ.szModulePath)
        IF ~ERRORCODE()
           DELETE(pModuleQ)
        END
      END
      FREE(DeleteQ)
      
      J = RECORDS(Q)
      LOOP I = 1 TO J
        GET(Q,I)
        pModuleQ = Q
        GET(pModuleQ,+pModuleQ.szModuleName,+pModuleQ.szModulePath)
        IF ERRORCODE()
           pModuleQ = Q
           ADD(pModuleQ,+pModuleQ.szModuleName,+pModuleQ.szModulePath)
        END
      END
      FREE(Q)
       POST(EVENT:CloseWindow)
    OF ?CancelButton
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
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
  OF ?List
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
        OF MouseLeft2
           IF ~?Edit{PROP:Disable}
              POST(EVENT:Accepted,?Edit)
           END
        OF MouseRight
           QEIP5:PopupString = QEIP5:PopupMgr.Ask()
      END
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeNewSelection PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?List
      GET(Q,CHOICE(?List))
      ThisWindow.Reset()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?List, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?List
  SELF.SetStrategy(?Insert, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?Insert
  SELF.SetStrategy(?Delete, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?Delete
  SELF.SetStrategy(?Panel1, Resize:FixLeft+Resize:FixBottom, Resize:ConstantRight+Resize:LockHeight) ! Override strategy for ?Panel1
  SELF.SetStrategy(?OKButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?OKButton
  SELF.SetStrategy(?CancelButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?CancelButton

QEIP5:EM.AddControl            PROCEDURE(<EditClass E>,UNSIGNED Column,BYTE AutoFree)
  CODE
  PARENT.AddControl(E,Column,AutoFree)
  RETURN

QEIP5:EM.ClearColumn           PROCEDURE
  CODE
  IF KEYCODE() <> EscKey
     IF SELF.LastColumn
        UPDATE
        GET(SELF.EQ,SELF.Column)
        PUT(Q)
        ASSERT(~ERRORCODE())
     END
  END
  PARENT.ClearColumn()
  RETURN

QEIP5:EM.Init                  PROCEDURE
RetVal BYTE(RequestCancelled)
AtEnd  BYTE,AUTO
  CODE
  SELF.TabAction = EIPAction:Always+EIPAction:Remain
  SELF.EnterAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Always+EIPAction:Remain+EIPAction:RetainColumn
  SELF.FocusLossAction = EIPAction:Default
  SELF.Arrow &= SELF.ArrowAction
  SELF.Enter &= SELF.EnterAction
  SELF.EQ &= QEIP5:EditList
  FREE(SELF.EQ)
  SELF.Errors &= NULL
  SELF.Fields &= QEIP5:Fields
  SELF.FocusLoss &= SELF.FocusLossAction
  SELF.ListControl = ?List
  SELF.Tab &= SELF.TabAction
  SELF.VCRRequest &= ThisWindow.VCRRequest
  SELF.CurrentChoice = CHOICE(?List)
  IF ~SELF.CurrentChoice
     SELF.CurrentChoice = 1
     ?List{PROP:Selected} = 1
  END
  GET(Q,SELF.CurrentChoice)
  CASE SELF.Req
  OF InsertRecord
    IF RECORDS(Q)
      AtEnd = CHOOSE(SELF.CurrentChoice = RECORDS(Q))
      SELF.CurrentChoice += 1
    ELSE
      SELF.CurrentChoice = 1
    END
    ADD(Q,SELF.CurrentChoice)
    ASSERT(~ERRORCODE())
    DISPLAY(?List)
    SELECT(?List,SELF.CurrentChoice)
    SELF.Column = 1
  OF DeleteRecord
    RetVal = CHOOSE(GlobalErrors.Throw(Msg:ConfirmDelete) = Level:Benign,RequestCompleted,RequestCancelled)
    IF RetVal = RequestCompleted
       DELETE(Q)
    END
    SELF.Response = RetVal
    RETURN Level:Fatal
  OF ChangeRecord
    IF KEYCODE() = MouseLeft2
      SELF.Column = ?List{PROPLIST:MouseUpField}
    END
  ELSE
    ASSERT(0)
  END
  GET(Q,SELF.CurrentChoice)
  ?List{PROP:Alrt,QEIP:MouseLeft2Index} = 0 ! Prevent alert short-stopping double click
  RetVal = PARENT.Init()
  RETURN(RetVal)

QEIP5:EM.InitControls          PROCEDURE
  CODE
  GET(SELF.EQ,1)
  IF ERRORCODE()
     SELF.EQ.Field = 1
     SELF.EQ.Control &= NULL
     SELF.AddControl(SELF.EQ.Control,SELF.EQ.Field,0)
  END
  GET(SELF.EQ,2)
  IF ERRORCODE()
     SELF.EQ.Field = 2
     SELF.EQ.Control &= NEW EditEntryClass
     SELF.AddControl(SELF.EQ.Control,SELF.EQ.Field,1)
  END
  GET(SELF.EQ,1)
  PARENT.InitControls()
  GET(SELF.EQ,2)
  SETFONT(SELF.EQ.Control.Feq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  RETURN

QEIP5:EM.Kill                  PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.Kill()
  RETURN(ReturnValue)

QEIP5:EM.Next                  PROCEDURE
  CODE
  PARENT.Next()
  RETURN

QEIP5:EM.GetEdit               PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.GetEdit()
  RETURN(ReturnValue)

QEIP5:EM.ResetColumn           PROCEDURE
  CODE
  PARENT.ResetColumn()
  RETURN

QEIP5:EM.Run                   PROCEDURE(BYTE Req)
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.Run(Req)
  RETURN(ReturnValue)

QEIP5:EM.TakeAction            PROCEDURE(UNSIGNED Action)
  CODE
  PARENT.TakeAction(Action)
  RETURN

QEIP5:EM.TakeCompleted         PROCEDURE(BYTE Force)
  CODE
  SELF.Again = 0
  SELF.ClearColumn
  Force = 0
  SELF.Response = RequestCompleted
  PARENT.TakeCompleted(Force)
  RETURN

QEIP5:EM.TakeEvent             PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.TakeEvent()
  RETURN(ReturnValue)

QEIP5:EM.TakeFieldEvent        PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.TakeFieldEvent()
  RETURN(ReturnValue)

QEIP5:EM.TakeFocusLoss         PROCEDURE
  CODE
  PARENT.TakeFocusLoss()
  RETURN

QEIP5:EM.TakeNewSelection      PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  IF FIELD() = ?List
    IF CHOICE(?List) = SELF.CurrentChoice
      ReturnValue = PARENT.TakeNewSelection()
    ELSE                                  ! Focus change to different record
      SELF.TakeFocusLoss
      IF SELF.Again
        SELECT(?List,SELF.CurrentChoice)
        ReturnValue = Level:Benign
      ELSE
        SELF.CurrentChoice = CHOICE(?List)
        SELF.Response = RequestCancelled           ! Avoid cursor following 'new' record
        ReturnValue = Level:Fatal
      END
    END
  END
  RETURN(ReturnValue)
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

