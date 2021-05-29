

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
!!! Edit Favorites Menu List
!!! </summary>
winFavoritesMenu PROCEDURE (pFavoritesMenuQ)

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
Q                    QUEUE,PRE(Q)                          ! 
szName               CSTRING(61)                           ! 
szPath               CSTRING(256)                          ! 
SequenceNo           BYTE                                  ! 
MenuFeq              LONG                                  ! 
                     END                                   ! 
Window               WINDOW('Favorites Menu'),AT(,,198,178),DOUBLE,TILED,CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       LIST,AT(4,4,190,130),USE(?List),VSCROLL,ALRT(MouseLeft2),COLOR(COLOR:White,COLOR:HIGHLIGHTTEXT, |
  COLOR:HIGHLIGHT),FLAT,FORMAT('60L(1)|FM~Menu Text~@s60@1020L(1)F~Path~S(255)@s255@'),FROM(Q), |
  MSG('Browsing Queue')
                       BUTTON('&Insert'),AT(4,138,45,12),USE(?Insert),KEY(InsertKey),TIP('Add a new item to th' & |
  'e favorites menu')
                       BUTTON('&Delete'),AT(53,138,45,12),USE(?Delete),KEY(DeleteKey),TIP('Delete the currentl' & |
  'y highlighted item from the favorites menu')
                       BUTTON('Edit'),AT(102,138,45,12),USE(?Change),HIDE,TIP('Edit the currently highlighted ' & |
  'item in the favorites menu')
                       BUTTON,AT(152,138,20,12),USE(?UpRow:Button),ICON('ABUPROW.ICO'),TIP('Move the highlight' & |
  'ed item up in the list')
                       BUTTON,AT(174,138,20,12),USE(?DnRow:Button),ICON('ABDNROW.ICO'),TIP('Move the highlight' & |
  'ed item down in the list')
                       PANEL,AT(4,154,190,1),USE(?Panel1),BEVEL(-1,1)
                       BUTTON('&OK'),AT(99,160,45,14),USE(?OKButton),TIP('Save changes and return to the previ' & |
  'ous window')
                       BUTTON('Cancel'),AT(149,160,45,14),USE(?CancelButton),TIP('Cancel changes and return to' & |
  ' the previous window')
                     END

QEIP8:SaveEntry      GROUP,PRE(QEIP8)
szName                 LIKE(Q:szName)
szPath                 LIKE(Q:szPath)
                     END
QEIP8:Fields         FieldPairsClass
QEIP8:EditList       QUEUE(EditQueue),PRE(QEIP8)
                     END
QEIP8:EM             CLASS(EIPManager)
TabAction              BYTE
EnterAction            BYTE
ArrowAction            BYTE
FocusLossAction        BYTE
CurrentChoice          LONG,PRIVATE
AddControl             PROCEDURE(<EditClass EC>,UNSIGNED Column,BYTE AutoFree = 0)
ClearColumn            PROCEDURE,DERIVED
Init                   PROCEDURE,BYTE,DERIVED,PROC
InitControls           PROCEDURE,DERIVED
Kill                   PROCEDURE,PROC,BYTE,DERIVED
Next                   PROCEDURE,PROTECTED
GetEdit                PROCEDURE,BYTE,DERIVED,PROTECTED
PrimeRecord            PROCEDURE(BYTE SuppressClear = 0)
ResetColumn            PROCEDURE,DERIVED,PROTECTED
Run                    PROCEDURE(BYTE Req),BYTE
TakeAction             PROCEDURE(UNSIGNED Action),DERIVED
TakeCompleted          PROCEDURE(BYTE Force),DERIVED   ! Note this does -not- override the WindowManager variant
TakeEvent              PROCEDURE,DERIVED,BYTE,PROC
TakeFieldEvent         PROCEDURE,DERIVED,BYTE,PROC
TakeFocusLoss          PROCEDURE,DERIVED
TakeNewSelection       PROCEDURE,DERIVED,BYTE,PROC
                     END

QEIP8::Q:szName      CLASS(EditEntryClass)
CreateControl          PROCEDURE(),DERIVED                      ! Method added to host embed code
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                      ! Method added to host embed code
SetAlerts              PROCEDURE(),DERIVED                      ! Method added to host embed code
SetReadOnly            PROCEDURE(BYTE State),DERIVED            ! Method added to host embed code
TakeAccepted           PROCEDURE(BYTE Action),BYTE,DERIVED      ! Method added to host embed code
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED   ! Method added to host embed code
                     END
QEIP8::Q:szPath      CLASS(EditDropComboClass)
CreateControl          PROCEDURE(),DERIVED                      ! Method added to host embed code
Init                   PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar),DERIVED ! Method added to host embed code
Kill                   PROCEDURE(),DERIVED                      ! Method added to host embed code
SetAlerts              PROCEDURE(),DERIVED                      ! Method added to host embed code
SetReadOnly            PROCEDURE(BYTE State),DERIVED            ! Method added to host embed code
TakeAccepted           PROCEDURE(BYTE Action),BYTE,DERIVED      ! Method added to host embed code
TakeEvent              PROCEDURE(UNSIGNED Event),BYTE,DERIVED   ! Method added to host embed code
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
TakeUpRow   ROUTINE
  DATA
sav:SequenceNo  BYTE
sav:Pointer     LONG

  CODE
  sav:SequenceNo = Q.SequenceNo
  Q.SequenceNo -= 1
  PUT(Q)
  sav:Pointer = POINTER(Q)-1
  GET(Q,sav:Pointer)
  Q.SequenceNo = Sav:SequenceNo
  PUT(Q)
  SORT(Q,+Q.SequenceNo)
  GET(Q,sav:Pointer)
  ?List{PROP:Selected} = sav:Pointer
  ThisWindow.Reset()

  EXIT
TakeDnRow   ROUTINE
  DATA
sav:SequenceNo  BYTE
sav:Pointer     LONG

  CODE
  sav:SequenceNo = Q.SequenceNo
  Q.SequenceNo += 1
  PUT(Q)
  sav:Pointer = POINTER(Q)+1
  GET(Q,sav:Pointer)
  Q.SequenceNo = Sav:SequenceNo
  PUT(Q)
  SORT(Q,+Q.SequenceNo)
  GET(Q,sav:Pointer)
  ?List{PROP:Selected} = sav:Pointer
  ThisWindow.Reset()

  EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG
J   LONG
  CODE
  GlobalErrors.SetProcedureName('winFavoritesMenu')
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
  J = RECORDS(pFavoritesMenuQ)
  LOOP I = 1 TO J
    GET(pFavoritesMenuQ,I)
    Q = pFavoritesMenuQ
    Q.SequenceNo = I
    ADD(Q,+Q.SequenceNo)
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
  QEIP8:Fields.Init()
  QEIP8:Fields.AddPair(QEIP8:SaveEntry.szName,Q.szName)
  QEIP8:Fields.AddPair(QEIP8:SaveEntry.szPath,Q.szPath)
  GlobalErrors.AddErrors(QEIP:Errors)
  ?List{Prop:Alrt,QEIP:MouseLeft2Index} = MouseLeft2
  Window{PROP:HLP} = '~WINFAVORITESMENU'
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
  IF RECORDS(Q)
     ?Change{PROP:Disable} = FALSE
     ?Delete{PROP:Disable} = FALSE
  ELSE
     ?Change{PROP:Disable} = TRUE
     ?Delete{PROP:Disable} = TRUE
  END
  IF ~CHOICE(?List)
     DISABLE(?Delete)
     DISABLE(?UpRow:Button)
     DISABLE(?DnRow:Button)
  ELSE
     ENABLE(?UpRow:Button)
     ENABLE(?DnRow:Button)
     IF CHOICE(?List) = 1
        DISABLE(?UpRow:Button)
     END
     IF CHOICE(?List) = RECORDS(Q)
        DISABLE(?DnRow:Button)
     END
  END


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
I           LONG
J           LONG
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?Insert
      CLEAR(q)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Insert
      ThisWindow.Update()
      LOOP
        ThisWindow.VCRRequest = VCR:None
        IF KEYCODE() = MouseRightUp
          SETKEYCODE(0)
        END
        ReturnValue = QEIP8:EM.Run(InsertRecord)
        CASE ThisWindow.VCRRequest
          OF VCR:Forward
             IF POINTER(Q) < RECORDS(Q)
                ?List{PROP:Selected} = POINTER(Q)
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
          OF VCR:Backward
             IF POINTER(Q) > 1
                ?List{PROP:Selected} = POINTER(Q)
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
        END
      UNTIL ThisWindow.VCRRequest = VCR:None
      SELECT(?List)
      ThisWindow.Reset()
    OF ?Delete
      ThisWindow.Update()
      ReturnValue = QEIP8:EM.Run(DeleteRecord)
      ThisWindow.Reset()
    OF ?Change
      ThisWindow.Update()
      LOOP
        ThisWindow.VCRRequest = VCR:None
        IF KEYCODE() = MouseRightUp
          SETKEYCODE(0)
        END
        ReturnValue = QEIP8:EM.Run(ChangeRecord)
        CASE ThisWindow.VCRRequest
          OF VCR:Forward
             IF POINTER(Q) < RECORDS(Q)
                GET(Q,POINTER(Q)+1)
                ?List{PROP:Selected} = POINTER(Q)
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
          OF VCR:Backward
             IF POINTER(Q) > 1
                GET(Q,POINTER(Q)-1)
                ?List{PROP:Selected} = POINTER(Q)
             ELSE
                ThisWindow.VCRRequest = VCR:None
             END
        END
      UNTIL ThisWindow.VCRRequest = VCR:None
      SELECT(?List)
      ThisWindow.Reset()
    OF ?UpRow:Button
      ThisWindow.Update()
      DO TakeUpRow
    OF ?DnRow:Button
      ThisWindow.Update()
      DO TakeDnRow
    OF ?OKButton
      ThisWindow.Update()
      FREE(pFavoritesMenuQ)
      J = RECORDS(Q)
      LOOP I = 1 TO J
        GET(Q,I)
        Q.SequenceNo = I
        pFavoritesMenuQ = Q
        ADD(pFavoritesMenuQ)
      END
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
           IF ~?Change{PROP:Disable} AND RECORDS(Q)
              POST(EVENT:Accepted,?Change)
           END
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
  SELF.SetStrategy(?Change, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?Change
  SELF.SetStrategy(?UpRow:Button, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?UpRow:Button
  SELF.SetStrategy(?DnRow:Button, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?DnRow:Button

QEIP8:EM.AddControl            PROCEDURE(<EditClass E>,UNSIGNED Column,BYTE AutoFree)
  CODE
  PARENT.AddControl(E,Column,AutoFree)
  RETURN

QEIP8:EM.ClearColumn           PROCEDURE
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

QEIP8:EM.Init                  PROCEDURE
RetVal BYTE(RequestCancelled)
AtEnd  BYTE,AUTO
  CODE
  SELF.TabAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  SELF.Arrow &= SELF.ArrowAction
  SELF.Enter &= SELF.EnterAction
  SELF.EQ &= QEIP8:EditList
  SELF.Errors &= NULL
  SELF.Fields &= QEIP8:Fields
  SELF.FocusLoss &= SELF.FocusLossAction
  SELF.ListControl = ?List
  SELF.Tab &= SELF.TabAction
  SELF.VCRRequest &= ThisWindow.VCRRequest
  SELF.AddControl(QEIP8::Q:szName,1,0)
  SELF.AddControl(QEIP8::Q:szPath,2,0)
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
      CASE(SELF.Insert)
        OF EIPAction:Before
           !Default
        OF EIPAction:Append
           SELF.CurrentChoice = RECORDS(Q)+1
      ELSE
           SELF.CurrentChoice += 1
      END
    ELSE
      SELF.CurrentChoice = 1
    END
    SELF.PrimeRecord()
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
    QEIP8:SaveEntry = Q
    IF KEYCODE() = MouseLeft2
      SELF.Column = ?List{PROPLIST:MouseUpField}
    END
  ELSE
    ASSERT(0)
  END
  GET(Q,SELF.CurrentChoice)
  SELF.Fields.AssignRightToLeft()
  ?List{PROP:Alrt,QEIP:MouseLeft2Index} = 0 ! Prevent alert short-stopping double click
  RetVal = PARENT.Init()
  RETURN(RetVal)

QEIP8:EM.InitControls          PROCEDURE
  CODE
  SELF.EQ.Field = 1
  PARENT.InitControls()
  RETURN

QEIP8:EM.Kill                  PROCEDURE
ReturnValue BYTE,AUTO
I           LONG,AUTO
J           LONG,AUTO
  CODE
  ReturnValue = PARENT.Kill()
  !Now dispose of any edit classes we created
  J = RECORDS(QEIP8:EditList)
  LOOP I = 1 TO J
    GET(QEIP8:EditList,I)
    IF ~QEIP8:EditList.Control &= NULL AND QEIP8:EditList.FreeUp = TRUE
       DISPOSE(QEIP8:EditList.Control)
    END
  END
  !and free up the edit queue
  FREE(QEIP8:EditList)
  RETURN(ReturnValue)

QEIP8:EM.Next                  PROCEDURE
  CODE
  PARENT.Next()
  RETURN

QEIP8:EM.GetEdit               PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.GetEdit()
  RETURN(ReturnValue)

QEIP8:EM.PrimeRecord           PROCEDURE(BYTE SC)
  CODE
  IF ~SC
     CLEAR(Q)
  END
  GET(Q,RECORDS(Q))
  Q.Q:szName = ''
  Q.Q:szPath = ''
  Q.MenuFeq = 0
  Q.SequenceNo += 1
  RETURN

QEIP8:EM.ResetColumn           PROCEDURE
  CODE
  PARENT.ResetColumn()
  RETURN

QEIP8:EM.Run                   PROCEDURE(BYTE Req)
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.Run(Req)
  RETURN(ReturnValue)

QEIP8:EM.TakeAction            PROCEDURE(UNSIGNED Action)
  CODE
  PARENT.TakeAction(Action)

QEIP8:EM.TakeCompleted         PROCEDURE(BYTE Force)
SaveAns UNSIGNED,AUTO
  CODE
  SELF.Again = 0
  SELF.ClearColumn
  SaveAns = CHOOSE(Force = 0,Button:Yes,Force)
  IF SELF.Fields.Equal()
      SaveAns = Button:No
  ELSE
     IF ~Force
        SaveAns = GlobalErrors.Message(Msg:SaveRecord,Button:Yes+Button:No+Button:Cancel,Button:Yes)
     END
  END
  Force = 0
  SELF.Response = RequestCancelled
  CASE SaveAns
    OF Button:Cancel
       SELF.Again = 1
    OF Button:No
       IF SELF.Req = InsertRecord
          DELETE(Q)
          IF SELF.CurrentChoice AND SELF.Insert <> EIPAction:Before
             SELF.CurrentChoice -= 1
          END
       ELSE
          SELF.Fields.AssignLeftToRight
          PUT(Q)
       END
    OF Button:Yes
       SELF.Response = RequestCompleted
  END
  PARENT.TakeCompleted(Force)
  RETURN

QEIP8:EM.TakeEvent             PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.TakeEvent()
  RETURN(ReturnValue)

QEIP8:EM.TakeFieldEvent        PROCEDURE
ReturnValue BYTE,AUTO
  CODE
  ReturnValue = PARENT.TakeFieldEvent()
  RETURN(ReturnValue)

QEIP8:EM.TakeFocusLoss         PROCEDURE
  CODE
  PARENT.TakeFocusLoss()
  RETURN

QEIP8:EM.TakeNewSelection      PROCEDURE
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



QEIP8::Q:szName.CreateControl    PROCEDURE
  CODE
  PARENT.CreateControl()
  SETFONT(SELF.Feq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  SELF.Feq{PROP:BackGround} = COLOR:WHITE
  !GET(SELF.EQ,1)
  !SETFONT(SELF.EQ.Control.Feq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  !SELF.EQ.Control.Feq{PROP:BackGround} = COLOR:WHITE
  RETURN

QEIP8::Q:szName.Init    PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar)
  CODE
  PARENT.Init(FieldNumber,ListBox,UseVar)
  RETURN

QEIP8::Q:szName.Kill    PROCEDURE
  CODE
  PARENT.Kill()
  RETURN

QEIP8::Q:szName.SetAlerts    PROCEDURE
  CODE
  PARENT.SetAlerts()
  RETURN

QEIP8::Q:szName.SetReadOnly    PROCEDURE(BYTE State)
  CODE
  PARENT.SetReadOnly(State)
  RETURN

QEIP8::Q:szName.TakeAccepted    PROCEDURE(BYTE Action)
ReturnValue BYTE
  CODE
  ReturnValue = PARENT.TakeAccepted(Action)
  RETURN(ReturnValue)

QEIP8::Q:szName.TakeEvent    PROCEDURE(UNSIGNED Event)
ReturnValue BYTE
  CODE
  ReturnValue = PARENT.TakeEvent(Event)
  RETURN(ReturnValue)



QEIP8::Q:szPath.CreateControl    PROCEDURE
  CODE
  PARENT.CreateControl()
  SETFONT(SELF.Feq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  SELF.Feq{PROP:BackGround} = COLOR:WHITE
  SELF.Feq{PROP:DROP} = 0
  SELF.Feq{PROP:Icon} = ICON:Ellipsis
  !GET(SELF.EQ,2)
  !SETFONT(SELF.EQ.Control.Feq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  !SELF.EQ.Control.Feq{PROP:BackGround} = COLOR:WHITE
  !SELF.EQ.Control.Feq{PROP:DROP} = 0
  !SELF.EQ.Control.Feq{PROP:Icon} = ICON:Ellipsis
  RETURN

QEIP8::Q:szPath.Init    PROCEDURE(UNSIGNED FieldNumber,UNSIGNED ListBox,*? UseVar)
  CODE
  PARENT.Init(FieldNumber,ListBox,UseVar)
  RETURN

QEIP8::Q:szPath.Kill    PROCEDURE
  CODE
  PARENT.Kill()
  RETURN

QEIP8::Q:szPath.SetAlerts    PROCEDURE
  CODE
  PARENT.SetAlerts()
  RETURN

QEIP8::Q:szPath.SetReadOnly    PROCEDURE(BYTE State)
  CODE
  PARENT.SetReadOnly(State)
  RETURN

QEIP8::Q:szPath.TakeAccepted    PROCEDURE(BYTE Action)
ReturnValue BYTE
  CODE
  ReturnValue = PARENT.TakeAccepted(Action)
  RETURN(ReturnValue)

QEIP8::Q:szPath.TakeEvent    PROCEDURE(UNSIGNED Event)
ReturnValue BYTE
szFilename  CSTRING(256)
I           LONG
J           LONG
  CODE
  CASE EVENT()
  OF EVENT:DroppingDown
     IF FILEDIALOG('Select file to include...',szFilename,'All Files (*.*)|*.*',FILE:KeepDir+FILE:NoError+FILE:LongName)
        IF Q.szName = ''
           J = LEN(szFilename)
           LOOP I = J TO 1 BY -1
              IF szFilename[I] = '\'
                 Q.szName = szFilename[I+1 : J]
              END
              BREAK
           END
        END
        Q.szPath = szFilename
        ReturnValue = EditAction:Forward
     ELSE
        ReturnValue = EditAction:None
     END
     RETURN(ReturnValue)
  END
  ReturnValue = PARENT.TakeEvent(Event)
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

