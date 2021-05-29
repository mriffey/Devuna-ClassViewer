

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
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('csciviewer.inc'),ONCE
   INCLUDE('kcrAsciiFileClass.inc'),ONCE

!!! <summary>
!!! Generated from procedure template - Window
!!! View Ascii File
!!! </summary>
winViewAsciiFile PROCEDURE (sFileName, pWhat)

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
sSearchString        STRING(64)                            ! 
lSearchLine          LONG                                  ! 
LineNoQueue          QUEUE,PRE(LNQ)                        ! 
LineNo               LONG                                  ! 
                     END                                   ! 
FilesOpened          BYTE                                  ! 
TextField            CSTRING(4001)                         ! 
lStyle               LONG                                  ! 
ViewerActive1        BYTE(False)
AsciiFilename1       STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile1           FILE,DRIVER('ASCII'),NAME(AsciiFilename1),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(255)
                      END
                     END
Window               WINDOW('View text file'),AT(,,298,212),FONT('Microsoft Sans Serif',10,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,ALRT(AltF3),ALRT(F3Key),ALRT(ShiftF3),ALRT(CtrlG),ALRT(CtrlP),ALRT(CtrlE),ALRT(CtrlT), |
  ALRT(CtrlL),ALRT(CtrlF),ALRT(CtrlF3),ALRT(CtrlShiftF3),CENTER,ICON('data16.ico'),GRAY,IMM, |
  MAX,PALETTE(256),SYSTEM,WALLPAPER('WALLPAPER.GIF')
                       LIST,AT(4,4,290,185),USE(?AsciiBox),FONT('Courier New',9,,FONT:bold,CHARSET:ANSI),COLOR(COLOR:White)
                       TEXT,AT(6,6,290,185),USE(TextField),FONT('Courier New',9,,FONT:bold,CHARSET:ANSI),LEFT,HSCROLL, |
  BOXED,COLOR(COLOR:White),HIDE
                       BUTTON,AT(4,194,14,14),USE(?MoveTopButton),ICON('vcrfirst.ico'),TIP('Move To First Line')
                       BUTTON,AT(20,194,14,14),USE(?MovePageUpButton),ICON('vcrprior.ico'),TIP('Page Up')
                       BUTTON,AT(36,194,14,14),USE(?MovePageDownButton),ICON('vcrnext.ico'),TIP('Page Down')
                       BUTTON,AT(52,194,14,14),USE(?MoveBottomButton),ICON('vcrlast.ico'),TIP('Move to Last Line')
                       BUTTON,AT(72,194,14,14),USE(?GoToButton),ICON('GoToLine.ico'),TIP('Go to Line')
                       BUTTON,AT(88,194,14,14),USE(?FindButton),ICON('find.ico'),TIP('Find')
                       BUTTON,AT(108,194,14,14),USE(?PrintButton),ICON('print.ico'),TIP('Print')
                       BUTTON,AT(128,194,14,14),USE(?EditButton),ICON('edit.ico'),TIP('Edit')
                       BUTTON,AT(148,194,14,14),USE(?ListTextModeButton),ICON('text.ico'),TIP('Text View')
                       BUTTON('Cl&ose'),AT(249,194,45,14),USE(?CloseButton),TIP('Close File Viewer window.')
                       IMAGE('list.ico'),AT(163,194,14,14),USE(?Image1),CENTERED,HIDE
                     END

tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Viewer1              CLASS(kcrAsciiViewerClass)
FormatLine             PROCEDURE(*STRING TextLine,LONG LineNo),DERIVED
Init                   PROCEDURE(FILE AsciiFile,*STRING FileLine,*STRING Filename,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0),BYTE
SetDisplayQueueStyle   PROCEDURE(LONG LineNo,*LONG Style),DERIVED
TakeEvent              PROCEDURE(LONG EventNo),BYTE,PROC   ! New method added to this class instance
                     END

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
FillTextField   ROUTINE
  DATA
I   LONG,AUTO
J   LONG,AUTO

  CODE
  TextField = ''
  J = Viewer1.TopLine + ?AsciiBox{PROP:Items} !- 1
  LOOP I = Viewer1.TopLine TO J
     TextField = TextField & CLIP(Viewer1.GetLine(I)) & '<13,10>'
  END
  DISPLAY(?TextField)

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG,AUTO
J   LONG,AUTO
K   LONG,AUTO
  CODE
  GlobalErrors.SetProcedureName('winViewAsciiFile')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?AsciiBox
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  K = POINTER(CallQ)
  J = RECORDS(CallQ)
  LOOP I = 1 TO J
    GET(CallQ,I)
    IF CallQ.szCalledMethod = TreeQ.szSearch
       LineNoQueue.LineNo = CallQ.lLineNum
       ADD(LineNoQueue,+LineNoQueue.LineNo)
    END
  END
  GET(CallQ,K)
  SELF.Open(Window)                                        ! Open window
  window{PROP:Text} = 'View File [' & CLIP(sFilename) & ']' !& ' [' & pWhat & ']'
  ?AsciiBox{PROP:SelectedColor} = glo:lSelectedFore !COLOR:BLACK
  ?AsciiBox{PROP:SelectedFillColor} = glo:lSelectedBack
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
  LOOP I = 0 TO J
     CASE I
     OF ?AsciiBox OROF ?TextField
        SETFONT(I,,glo:FontSize,glo:FontColor,glo:FontStyle,0)
     ELSE
        SETFONT(I,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
     END
  END
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Spread,Resize:SetMinSize)       ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  IF NUMERIC(pWhat)
     sSearchString = ''
     lSearchLine = pWhat
     LineNoQueue.LineNo = lSearchLine
     ADD(LineNoQueue,+LineNoQueue.LineNo)
  ELSE
     sSearchString = pWhat
     lSearchLine = 0
  END
  
  AsciiFileName1 = sFileName
  OMIT('CLEAR(AsciiFilename1)')
  CLEAR(AsciiFilename1)
  ViewerActive1=Viewer1.Init(AsciiFile1,A1:Textline,AsciiFilename1,?AsciiBox,GlobalErrors,EnableSearch+EnablePrint)
  IF ~ViewerActive1 THEN RETURN Level:Fatal.
  ?AsciiBox{PROP:Alrt,250} = MouseLeft2
  ?TextField{PROP:Alrt,250} = MouseLeft2
  ?TextField{PROP:LeftOffset} = 2

  POST(EVENT:USER)
  SELF.SetAlerts()
  IF glo:bForceEdit = 1
     POST(EVENT:Accepted,?EditButton)
  END
  Window{PROP:HLP} = '~WINVIEWASCIIFILE'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Ascii_File_Viewer.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Ascii_File_Viewer.htm')
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

  CODE
  PARENT.Open
  hwndTT = tt.init(Window{PROP:HANDLE},1)                  !ToolTipClass Initialization
  IF hwndTT
     tt.addtip(?MoveTopButton{PROP:HANDLE},?MoveTopButton{PROP:TIP},0)
     ?MoveTopButton{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?MovePageUpButton{PROP:HANDLE},?MovePageUpButton{PROP:TIP},0)
     ?MovePageUpButton{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?MovePageDownButton{PROP:HANDLE},?MovePageDownButton{PROP:TIP},0)
     ?MovePageDownButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?MoveBottomButton{PROP:HANDLE},?MoveBottomButton{PROP:TIP},0)
     ?MoveBottomButton{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?GoToButton{PROP:HANDLE},?GoToButton{PROP:TIP},0)
     ?GoToButton{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?FindButton{PROP:HANDLE},?FindButton{PROP:TIP},0)
     ?FindButton{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?PrintButton{PROP:HANDLE},?PrintButton{PROP:TIP},0)
     ?PrintButton{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.addtip(?EditButton{PROP:HANDLE},?EditButton{PROP:TIP},0)
     ?EditButton{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?ListTextModeButton{PROP:HANDLE},'Text View',0)
     ?ListTextModeButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?CloseButton{PROP:HANDLE},?CloseButton{PROP:TIP},0)
     ?CloseButton{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.SetTipTextColor(0)
  END


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  IF ViewerActive1 THEN Viewer1.TakeEvent(EVENT()).
  PARENT.Reset(Force)


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
szNull          CSTRING(2)
szFilename      CSTRING(256)
szCommandLine   CSTRING(256),AUTO
I               LONG,AUTO
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?MoveTopButton
      ThisWindow.Update()
      POST(EVENT:ScrollTop,?AsciiBox)
    OF ?MovePageUpButton
      ThisWindow.Update()
      POST(EVENT:PageUp,?AsciiBox)
    OF ?MovePageDownButton
      ThisWindow.Update()
      POST(EVENT:PageDown,?AsciiBox)
    OF ?MoveBottomButton
      ThisWindow.Update()
      POST(EVENT:ScrollBottom,?AsciiBox)
    OF ?GoToButton
      ThisWindow.Update()
      Viewer1.AskGotoLine
    OF ?FindButton
      ThisWindow.Update()
      Viewer1.Searcher.Ask(CHOOSE(CHOICE(?AsciiBox)>0,Viewer1.TopLine+CHOICE(?AsciiBox)-1,1))
    OF ?PrintButton
      ThisWindow.Update()
      Viewer1.Printer.Ask
    OF ?EditButton
      ThisWindow.Update()
      IF glo:bUseAssociation
         szFilename = CLIP(sFilename)
         szNull = ''
         ShellExecute(window{prop:handle},0,szFilename,0,szNull,1)
      ELSE
         szCommandline = 'Notepad.exe ' & CLIP(sFilename)
         IF glo:szEditorCommand
            szCommandLine = glo:szEditorCommand
            I = INSTRING('.EXE ',UPPER(szCommandLine),1)
            IF I
               szCommandLine = SHORTPATH(szCommandLine[i : I+3]) & szCommandLine[I+4 : LEN(szCommandLine)]
            END
            !look for filename parameter token
            I = INSTRING('%1',szCommandLine,1)
            IF I
               szCommandLine = SUB(szCommandLine,1,I-1) & |
                               CLIP(sFilename) & |
                               SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
            END
            !look for line number parameter token
            I = INSTRING('%2',szCommandLine,1)
            IF I
               szCommandLine = SUB(szCommandLine,1,I-1) & |
                               lSearchLine & |
                               SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
            END
         END
         RUN(szCommandLine)
         IF RUNCODE() = -4   !Failed to execute
           CASE MESSAGE('An error occurred trying to execute the following command:||' & szCommandLine & |
                   '||Do you want to use Notepad?',ERROR(),ICON:EXCLAMATION, |
                   BUTTON:YES+BUTTON:NO,BUTTON:YES)
           OF BUTTON:YES
              RUN('Notepad.exe ' & CLIP(sFilename))
           END
         END
      END
    OF ?ListTextModeButton
      ThisWindow.Update()
      IF ?TextField{PROP:Hide} = TRUE
         !?ListTextModeButton{PROP:Text} = 'Lis&t'
         ?ListTextModeButton{PROP:Icon} = '~LIST.ICO'
         IF glo:bShowTips
            tt.updatetiptext(?ListTextModeButton{PROP:HANDLE},'List View',0)
         ELSE
            ?ListTextModeButton{PROP:Tip} = 'List View'
         END
         ?AsciiBox{PROP:Hide} = TRUE
         ?TextField{PROP:Hide} = FALSE
      ELSE
         !?ListTextModeButton{PROP:Text} = '&Text'
         ?ListTextModeButton{PROP:Icon} = '~TEXT.ICO'
         IF glo:bShowTips
            tt.updatetiptext(?ListTextModeButton{PROP:HANDLE},'Text View',0)
         ELSE
            ?ListTextModeButton{PROP:Tip} = 'Text View'
         END
         ?TextField{PROP:Hide} = TRUE
         ?AsciiBox{PROP:Hide} = FALSE
      END
    OF ?CloseButton
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
Find                GROUP(AsciiFindGroup),PRE(Find)
                    END
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
    IF EVENT() = EVENT:USER
       Viewer1.GetLastLineNo()
       IF sSearchString
          Find.What = sSearchString
          Find.MatchCase = TRUE
          Find.Direction = 'Down'
          Viewer1.Searcher.Setup(Find)
          Viewer1.DisplayPage(Viewer1.Searcher.Next())
       ELSE
          Viewer1.DisplayPage(lSearchLine)
       END
       DO FillTextField
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
  CASE FIELD()
  OF ?AsciiBox
    IF ViewerActive1
      IF Viewer1.TakeEvent(EVENT())=Level:Notify THEN CYCLE.
    END
  END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?TextField
    CASE EVENT()
    OF EVENT:AlertKey
       IF KEYCODE() = MouseLeft2
          POST(EVENT:Accepted,?ListTextModeButton)
       END
    ELSE
       FORWARDKEY(?AsciiBox)
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
I                   LONG
J                   LONG
TextLine            CSTRING(255)
sz                  CSTRING(65)
LastLine            LONG
StartLine           LONG
Find                GROUP(AsciiFindGroup),PRE(Find)
                    END
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseWindow
      IF ViewerActive1
        Viewer1.Kill
        ViewerActive1=False
      END
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF CtrlE
         POST(EVENT:Accepted,?EditButton)
      OF CtrlG
         POST(EVENT:Accepted,?GoToButton)
      OF CtrlL
         IF ?TextField{PROP:Hide} = FALSE
            POST(EVENT:Accepted,?ListTextModeButton)
         END
      OF CtrlP
         POST(EVENT:Accepted,?PrintButton)
      OF CtrlT
         IF ?TextField{PROP:Hide} = TRUE
            POST(EVENT:Accepted,?ListTextModeButton)
         END
      OF AltF3 OROF CtrlF
         POST(EVENT:Accepted,?FindButton)
      OF F3Key
         Viewer1.Searcher.GetLastSearch(Find,LastLine)
         IF Find.What
            Find.Direction = 'Down'
            Viewer1.Searcher.Setup(Find,Viewer1.TopLine)
      
            StartLine = Viewer1.Searcher.Next()
            IF ~StartLine
               CASE GlobalErrors.Throw(Msg:SearchReachedEnd)
               OF Level:Benign
                  Viewer1.Searcher.Setup(Find,1)
                  Viewer1.DisplayPage(Viewer1.Searcher.Next())
                  DO FillTextField
               OF Level:Cancel
                  !do nothing
               ELSE
                  ASSERT(False) !Unexpected return value from ErrorMgr.Throw()
               END
            ELSE
               Viewer1.DisplayPage(StartLine)
               DO FillTextField
            END
      
         ELSE
            POST(EVENT:Accepted,?FindButton)
         END
      
      OF ShiftF3
         Viewer1.Searcher.GetLastSearch(Find,LastLine)
         IF Find.What
            Find.Direction = 'Up'
            Viewer1.Searcher.Setup(Find,Viewer1.TopLine)
      
            StartLine = Viewer1.Searcher.Next()
            IF ~StartLine
               CASE GlobalErrors.Throw(Msg:SearchReachedBeginning)
               OF Level:Benign
                  Viewer1.Searcher.Setup(Find,Viewer1.GetLastLineNo())
                  Viewer1.DisplayPage(Viewer1.Searcher.Next())
                  DO FillTextField
               OF Level:Cancel
                  !Do nothing
               ELSE
                  ASSERT(False) !Unexpected return value from ErrorMgr.Throw()
               END
            ELSE
               Viewer1.DisplayPage(Viewer1.Searcher.Next())
               DO FillTextField
            END
      
         ELSE
            POST(EVENT:Accepted,?FindButton)
         END
      
      OF CtrlF3
         J = RECORDS(LineNoQueue)
         IF J
            Viewer1.Searcher.GetLastSearch(Find,LastLine)
            Find.Direction = 'Down'
            Viewer1.Searcher.Setup(Find,Viewer1.TopLine)
      
            !StartLine = Viewer1.Searcher.Next()
            I = INSTRING('.',TreeQ.szSearch)
            sz = TreeQ.szSearch[I : LEN(TreeQ.szSearch)]
            StartLine = 0
            LOOP I = 1 TO J
               GET(LineNoQueue,I)
               IF LineNoQueue.LineNo > Viewer1.TopLine
                  TextLine = Viewer1.GetLine(LineNoQueue.LineNo)
                  IF INSTRING(sz & ' ',TextLine,1)
                     StartLine = LineNoQueue.LineNo
                     BREAK
                  ELSIF INSTRING(sz & '(',TextLine,1)
                     StartLine = LineNoQueue.LineNo
                     BREAK
                  END
               END
            END
      
            IF ~StartLine
               CASE GlobalErrors.Throw(Msg:SearchReachedEnd)
               OF Level:Benign
                  Viewer1.Searcher.Setup(Find,1)
                  !Viewer1.DisplayPage(Viewer1.Searcher.Next())
                  Viewer1.TopLine = 1
                  LOOP I = 1 TO J
                     GET(LineNoQueue,I)
                     IF LineNoQueue.LineNo > Viewer1.TopLine
                        TextLine = Viewer1.GetLine(LineNoQueue.LineNo)
                        IF INSTRING(sz & ' ',TextLine,1)
                           StartLine = LineNoQueue.LineNo
                           BREAK
                        ELSIF INSTRING(sz & '(',TextLine,1)
                           StartLine = LineNoQueue.LineNo
                           BREAK
                        END
                     END
                  END
                  Viewer1.DisplayPage(StartLine)
                  DO FillTextField
               OF Level:Cancel
                  !do nothing
               ELSE
                  ASSERT(False) !Unexpected return value from ErrorMgr.Throw()
               END
            ELSE
               Viewer1.DisplayPage(StartLine)
               DO FillTextField
            END
         END
      
      OF CtrlShiftF3
         J = RECORDS(LineNoQueue)
         IF J
            Viewer1.Searcher.GetLastSearch(Find,LastLine)
            Find.Direction = 'Up'
            Viewer1.Searcher.Setup(Find,Viewer1.TopLine)
      
            !StartLine = Viewer1.Searcher.Next()
            I = INSTRING('.',TreeQ.szSearch)
            sz = TreeQ.szSearch[I : LEN(TreeQ.szSearch)]
            StartLine = 0
            LOOP I = J TO 1 BY -1
               GET(LineNoQueue,I)
               IF LineNoQueue.LineNo < Viewer1.TopLine
                  TextLine = Viewer1.GetLine(LineNoQueue.LineNo)
                  IF INSTRING(sz & ' ',TextLine,1)
                     StartLine = LineNoQueue.LineNo
                     BREAK
                  ELSIF INSTRING(sz & '(',TextLine,1)
                     StartLine = LineNoQueue.LineNo
                     BREAK
                  END
               END
            END
      
            IF ~StartLine
               CASE GlobalErrors.Throw(Msg:SearchReachedEnd)
               OF Level:Benign
                  Viewer1.Searcher.Setup(Find,1)
                  !Viewer1.DisplayPage(Viewer1.Searcher.Next())
                  Viewer1.TopLine = Viewer1.GetLastLineNo()
                  LOOP I = J TO 1 BY -1
                     GET(LineNoQueue,I)
                     IF LineNoQueue.LineNo < Viewer1.TopLine
                        TextLine = Viewer1.GetLine(LineNoQueue.LineNo)
                        IF INSTRING(sz & ' ',TextLine,1)
                           StartLine = LineNoQueue.LineNo
                           BREAK
                        ELSIF INSTRING(sz & '(',TextLine,1)
                           StartLine = LineNoQueue.LineNo
                           BREAK
                        END
                     END
                  END
                  Viewer1.DisplayPage(StartLine)
                  DO FillTextField
               OF Level:Cancel
                  !do nothing
               ELSE
                  ASSERT(False) !Unexpected return value from ErrorMgr.Throw()
               END
            ELSE
               Viewer1.DisplayPage(StartLine)
               DO FillTextField
            END
         END
      END
    OF EVENT:Iconize
      Window{PROP:Iconize} = TRUE
    OF EVENT:Restore
      Window{PROP:Iconize} = FALSE
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Viewer1.FormatLine PROCEDURE(*STRING TextLine,LONG LineNo)

I   LONG,AUTO
sz  CSTRING(256)

  CODE
  PARENT.FormatLine(TextLine,LineNo)
  IF RECORDS(LineNoQueue)
     LineNoQueue.LineNo = LineNo
     GET(LineNoQueue,+LineNoQueue.LineNo)
     IF ERRORCODE()
        lStyle = 1
        GET(LineNoQueue,1)        !Force ERRORCODE to Clear
     ELSE
        I = INSTRING('.',TreeQ.szSearch)
        IF I
           sz = TreeQ.szSearch[I : LEN(TreeQ.szSearch)]
           IF INSTRING(sz & ' ',TextLine,1)
              lStyle = 2
           ELSIF INSTRING(sz & '(',TextLine,1)
              lStyle = 2
           ELSE
              lStyle = 1
           END
        ELSE
           lStyle = 1
        END
     END
  END


Viewer1.Init PROCEDURE(FILE AsciiFile,*STRING FileLine,*STRING Filename,UNSIGNED ListBox,ErrorClass ErrHandler,BYTE Enables=0)

ReturnValue          BYTE,AUTO


  CODE
  ReturnValue = PARENT.Init(AsciiFile,FileLine,Filename,ListBox,ErrHandler,Enables)
  ListBox{PROP:HScroll} = FALSE !?AsciiBox
  ListBox{PROP:FORMAT} = '24L(2)|@n05@250L(2)YS(1024)@s255@'
  ListBox{PROPLIST:BackColor,1} = COLOR:BTNFACE
  
  ListBox{PROPSTYLE:TextColor,1} = COLOR:BLACK
  ListBox{PROPSTYLE:BackColor,1} = COLOR:WHITE
  ListBox{PROPSTYLE:TextSelected,1} = glo:lSelectedFore !COLOR:BLACK
  ListBox{PROPSTYLE:BackSelected,1} = glo:lSelectedBack
  ListBox{PROPSTYLE:FontName,1} = 'Courier New'
  ListBox{PROPSTYLE:FontSize,1} = glo:FontSize
  ListBox{PROPSTYLE:FontStyle,1} = glo:FontStyle
  
  ListBox{PROPSTYLE:TextColor,2} = glo:lHighlightColor2
  ListBox{PROPSTYLE:BackColor,2} = COLOR:BTNFACE
  ListBox{PROPSTYLE:TextSelected,2} = glo:lHighlightColor2
  ListBox{PROPSTYLE:BackSelected,2} = glo:lSelectedBack
  ListBox{PROPSTYLE:FontName,2} = 'Courier New'
  ListBox{PROPSTYLE:FontSize,2} = glo:FontSize
  ListBox{PROPSTYLE:FontStyle,2} = glo:FontStyle
  
  ListBox{PROPSTYLE:TextColor,3} = glo:lHighlightColor1
  ListBox{PROPSTYLE:BackColor,3} = COLOR:BTNFACE
  ListBox{PROPSTYLE:TextSelected,3} = glo:lHighlightColor1
  ListBox{PROPSTYLE:BackSelected,3} = glo:lSelectedBack
  ListBox{PROPSTYLE:FontName,3} = 'Courier New'
  ListBox{PROPSTYLE:FontSize,3} = glo:FontSize
  ListBox{PROPSTYLE:FontStyle,3} = glo:FontStyle
  
  SELF.Popup.AddMenu('~&Find|~&Print|&Edit|-|&Move{{&Top|Page &Up|Page &Down|Bottom}|-|&Goto')
  SELF.Popup.SetItemEnable('Find',CHOOSE(BAND(Enables,EnableSearch)))
  SELF.Popup.SetItemEnable('Print',CHOOSE(BAND(Enables,EnablePrint)))
  SELF.Popup.AddItemEvent('Top',EVENT:ScrollTop,ListBox)
  SELF.Popup.AddItemEvent('PageUp',EVENT:PageUp,ListBox)
  SELF.Popup.AddItemEvent('PageDown',EVENT:PageDown,ListBox)
  SELF.Popup.AddItemEvent('Bottom',EVENT:ScrollBottom,ListBox)
  RETURN ReturnValue


Viewer1.SetDisplayQueueStyle PROCEDURE(LONG LineNo,*LONG Style)


  CODE
  PARENT.SetDisplayQueueStyle(LineNo,Style)
  Style = CHOOSE(LineNo=lSearchLine,3,lStyle)

Viewer1.TakeEvent PROCEDURE(LONG EventNo)

ReturnValue          BYTE,AUTO
I                    LONG,AUTO
J                    LONG,AUTO
X                    SHORT,AUTO
Y                    SHORT,AUTO
W                    SHORT,AUTO
H                    SHORT,AUTO

  CODE
  IF FIELD() = ?AsciiBox
     CASE EventNo
     OF EVENT:AlertKey
        CASE KEYCODE()
        OF MouseLeft2
           !GETPOSITION(?AsciiBox,X,Y,W,H)
           !SETPOSITION(?TextField,X,Y,W,H)
           POST(EVENT:Accepted,?ListTextModeButton)
        OF MouseRightUp
           CASE SELF.Popup.Ask()
           OF 'Find'
              SELF.Searcher.Ask(CHOOSE(CHOICE(?AsciiBox)>0,Viewer1.TopLine+CHOICE(?AsciiBox)-1,1))
           OF 'Print'
              SELF.Printer.Ask
           OF 'Edit'
              POST(EVENT:Accepted,?EditButton)   !RUN('Notepad.exe ' & sFilename)
           OF 'Goto'
              SELF.AskGotoLine
           END
           ReturnValue = Level:Notify
        ELSE
           ReturnValue = PARENT.TakeEvent(EventNo)
        END
     ELSE
        ReturnValue = PARENT.TakeEvent(EventNo)
     END
  ELSE
     ReturnValue = PARENT.TakeEvent(EventNo)
  END
  
  DO FillTextField
  
  RETURN ReturnValue



Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?AsciiBox, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?AsciiBox
  SELF.SetStrategy(?TextField, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?TextField
  SELF.SetStrategy(?MoveTopButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MoveTopButton
  SELF.SetStrategy(?MovePageUpButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MovePageUpButton
  SELF.SetStrategy(?MovePageDownButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MovePageDownButton
  SELF.SetStrategy(?MoveBottomButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MoveBottomButton
  SELF.SetStrategy(?GoToButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?GoToButton
  SELF.SetStrategy(?FindButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?FindButton
  SELF.SetStrategy(?PrintButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?PrintButton
  SELF.SetStrategy(?EditButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?EditButton
  SELF.SetStrategy(?ListTextModeButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?ListTextModeButton
  SELF.SetStrategy(?CloseButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?CloseButton
  SELF.RemoveControl(?Image1)                              ! Remove ?Image1 from the resizer, it will not be moved or sized
  ?TextField{PROP:XPos} = ?AsciiBox{PROP:XPos}
  ?TextField{PROP:YPos} = ?AsciiBox{PROP:YPos}

!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
srcViewAsciiFile     PROCEDURE  (lModuleId, pWhat,pThreadQ) ! Declare Procedure
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
sFilename       CSTRING(256)
szCommandLine   CSTRING(256)
lSearchLine     LONG
I               LONG
J               LONG
szNull          CSTRING(2)
szWhat          STRING(10)

  CODE
  IF lModuleId
     SORT(ModuleQ,+ModuleQ.lModuleId)
     ModuleQ.lModuleId = lModuleId
     GET(ModuleQ,+ModuleQ.lModuleId)
    ASSERT(~ERRORCODE())
     CASE glo:bForceEdit
     OF 0
        OMIT('***',_Scintilla_)
        winViewAsciiFile(ModuleQ.szModulePath & ModuleQ.szModuleName, pWhat)
        !***
        COMPILE('***',_Scintilla_)
        winSciViewAsciiFile(ModuleQ.szModulePath & ModuleQ.szModuleName, pWhat)
        ! szWhat = pWhat
        ! start(winSciViewAsciiFile,25000,ModuleQ.szModulePath & ModuleQ.szModuleName, szWhat)
        !***
     OF 1
        sFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
        IF glo:bUseAssociation
           szNull = ''
           ShellExecute(0{prop:handle},0,sFileName,0,szNull,1)
        ELSE
           IF NUMERIC(pWhat)
              lSearchLine = pWhat
           END
           szCommandline = 'Notepad.exe ' & CLIP(sFilename)
           IF glo:szEditorCommand
              szCommandLine = glo:szEditorCommand
              I = INSTRING('.EXE ',UPPER(szCommandLine),1)
              IF I
                 szCommandLine = SHORTPATH(szCommandLine[1 : I+3]) & szCommandLine[I+4 : LEN(szCommandLine)]
              END
              !look for filename parameter token
              I = INSTRING('%1',szCommandLine,1)
              IF I
                 szCommandLine = SUB(szCommandLine,1,I-1) & |
                                 CLIP(sFilename) & |
                                 SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
              END
              !look for line number parameter token
              I = INSTRING('%2',szCommandLine,1)
              IF I
                 szCommandLine = SUB(szCommandLine,1,I-1) & |
                                 lSearchLine & |
                                 SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
              END
           END
           RUN(szCommandLine)
           IF RUNCODE() = -4   !Failed to execute
             CASE MESSAGE('An error occurred trying to execute the following command:||' & szCommandLine & |
                     '||Do you want to use Notepad?',ERROR(),ICON:EXCLAMATION, |
                     BUTTON:YES+BUTTON:NO,BUTTON:YES)
             OF BUTTON:YES
                RUN('Notepad.exe ' & CLIP(sFilename))
             END
           END
        END
     ELSE
     END
  END
  RETURN
!!! <summary>
!!! Generated from procedure template - Window
!!! Scintilla Ascii File Viewer
!!! </summary>
winSciViewAsciiFile PROCEDURE (STRING sFileName, LONG LineNo)

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
!==========================================================!
!ToolTip for Scintilla Viewer                              !
!==========================================================!
Viewer_tt            ToolTipClass                          !
hwndViewer_TT        HWND                                  !
!==========================================================!
FilesOpened          BYTE                                  ! 
I                    LONG                                  ! 
J                    LONG                                  ! 
K                    LONG                                  ! 
bControlInitialised  BOOL                                  ! 
loc:szViewerStyle    CSTRING(256)                          ! 
ViewerActive         BOOL                                  ! 
AsciiFilename        STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile            FILE,DRIVER('ASCII'),NAME(AsciiFilename),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(255)
                      END
                     END
Window               WINDOW('View text file'),AT(,,298,212),FONT('Microsoft Sans Serif',10,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,ALRT(CtrlE),CENTER,ICON('data16.ico'),GRAY,IMM,MAX,MODAL,PALETTE(256),SYSTEM, |
  WALLPAPER('WALLPAPER.GIF')
                       TEXT,AT(4,4,290,185),USE(?sciControl:Region),BOXED
                       BUTTON,AT(4,194,14,14),USE(?MoveTopButton),ICON('vcrfirst.ico'),TIP('Move To First Line')
                       BUTTON,AT(20,194,14,14),USE(?MovePageUpButton),ICON('vcrprior.ico'),TIP('Page Up')
                       BUTTON,AT(36,194,14,14),USE(?LineUpButton),ICON('VCRUP.ICO')
                       BUTTON,AT(52,194,14,14),USE(?LineDownButton),ICON('VCRDOWN.ICO')
                       BUTTON,AT(68,194,14,14),USE(?MovePageDownButton),ICON('vcrnext.ico'),TIP('Page Down')
                       BUTTON,AT(84,194,14,14),USE(?MoveBottomButton),ICON('vcrlast.ico'),TIP('Move to Last Line')
                       BUTTON,AT(104,194,14,14),USE(?GoToButton),ICON('GoToLine.ico'),TIP('Go to Line')
                       BUTTON,AT(120,194,14,14),USE(?FindButton),ICON('find.ico'),TIP('Find')
                       BUTTON,AT(140,194,14,14),USE(?PrintButton),ICON('print.ico'),TIP('Print')
                       BUTTON,AT(160,194,14,14),USE(?EditButton),ICON('edit.ico'),TIP('Edit')
                       BUTTON('Cl&ose'),AT(249,194,45,14),USE(?CloseButton),TIP('Close File Viewer window.')
                     END

szClarionKeywords    CSTRING(2048)
szCompilerDirectives CSTRING(2048)
szBuiltinProcsFuncs  CSTRING(2048)
szStructDataTypes    CSTRING(2048)
szAttributes         CSTRING(2048)
szStandardEquates    CSTRING(2048)
tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeEvent              PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
Resize                 PROCEDURE(),BYTE,PROC,DERIVED
                     END

SciControl           CLASS(CSciViewer)                     ! Scintilla using ?sciControl:Region
Colourise              PROCEDURE(LONG lStart,LONG lEnd),DERIVED
FindWindowTakeOpenWindow PROCEDURE(),DERIVED
Init                   PROCEDURE(*WINDOW W,LONG feq,UNSIGNED id,BOOL Themed = 0),BYTE,DERIVED
OpenFile               PROCEDURE(*CSTRING szFileName),BOOL,PROC,DERIVED
SetBuffer              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,DERIVED
TakeOpenWindow         PROCEDURE(),BYTE,DERIVED
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

  CODE
  GlobalErrors.SetProcedureName('winSciViewAsciiFile')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?sciControl:Region
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  ! Initialize Styles
  !----------------------------------------------------------------------------
  LOOP K = 1 TO SCE_CLW_LAST
     EXECUTE K
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,255,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,128,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8421504,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8388608,16777215,0,0,1,1'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,16711680,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,0,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8388608,16777215,0,0,1,1'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8388608,16777215,0,0,1,1'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8388608,16777215,0,0,1,1'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,32768,16777215,0,0,1,1'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,255,16777215,0,0,1,0'
        loc:szViewerStyle = 'Courier New,10,700,1,0,0,8421376,16777215,0,0,1,0'
     END
  
     INIMgr.Fetch('Options','ViewerStyle'& FORMAT(K-1,@n02),loc:szViewerStyle)
     I = 1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Font = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].FontSize = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].FontStyle = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Bold = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Italic = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Underline = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Fore = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Back = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].EolFilled = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].CaseOpt = loc:szViewerStyle[I : J-1]
     I = J+1
     J = INSTRING(',',loc:szViewerStyle,,I)
     glo:ViewerStyles.StyleGroup[K].Visible = loc:szViewerStyle[I : J-1]
     I = J+1
     J = LEN(CLIP(loc:szViewerStyle))
     glo:ViewerStyles.StyleGroup[K].HotSpot = loc:szViewerStyle[I : J]
  END
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(Window)                                        ! Open window
  Window{PROP:Buffer} = 1
  Window{PROP:Text} = 'View File [' & CLIP(sFilename) & ']' !& ' [' & pWhat & ']'
  
  CASE glo:Background
  OF 1  !Color
     Window{PROP:Wallpaper} = ''
     Window{PROP:Color} = glo:Color2
  OF 2  !Wallpaper
     Window{PROP:Wallpaper} = glo:szWallpaper2
     window{PROP:Tiled} = glo:Tiled2
     Window{PROP:Color} = COLOR:NONE
  OF 3  !None
     Window{PROP:Wallpaper} = ''
     Window{PROP:Color} = COLOR:NONE
  END
  
  J = LASTFIELD()
  LOOP I = 0 TO J
     SETFONT(I,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  END
  !XPMoveTopButton.Init(?MoveTopButton, 0, 0)
  !XPMoveTopButton.SetIconSize(32, 32)
  !XPMovePageUpButton.Init(?MovePageUpButton, 0, 0)
  !XPMovePageUpButton.SetIconSize(32, 32)
  !XPMovePageDownButton.Init(?MovePageDownButton, 0, 0)
  !XPMovePageDownButton.SetIconSize(32, 32)
  !XPMoveBottomButton.Init(?MoveBottomButton, 0, 0)
  !XPMoveBottomButton.SetIconSize(32, 32)
  !XPGoToButton.Init(?GoToButton, 0, 0)
  !XPGoToButton.SetIconSize(32, 32)
  !XPFindButton.Init(?FindButton, 0, 0)
  !XPFindButton.SetIconSize(32, 32)
  !XPPrintButton.Init(?PrintButton, 0, 0)
  !XPPrintButton.SetIconSize(32, 32)
  !XPEditButton.Init(?EditButton, 0, 0)
  !XPEditButton.SetIconSize(32, 32)
  !XPCloseButton.Init(?CloseButton, 0, 0)
  !XPCloseButton.SetIconSize(32, 32)
  Do DefineListboxStyle
  HIDE(?sciControl:Region)
  ReturnValue = SciControl.Init(Window, ?sciControl:Region, 1006)
  SciControl.SetContextMenuEvent(EVENT:USER+1)
  IF ReturnValue = Level:Benign
     ThisWindow.AddItem(SciControl.WindowComponent)
  END
  IF ReturnValue = Level:Benign
     bControlInitialised = TRUE
  ELSE
     bControlInitialised = FALSE
  END
  Resizer.Init(AppStrategy:NoResize,Resize:SetMinSize)     ! Don't change the windows controls when window resized
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINSCIVIEWASCIIFILE'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Ascii_File_Viewer.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Ascii_File_Viewer.htm')
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
     tt.SetTipTextColor(16711680)
  END


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

szFilename           CSTRING(261)
szCommandline        CSTRING(261)
szNull               CSTRING(2)
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
    OF ?MoveTopButton
      ThisWindow.Update()
      POST(EVENT:ScrollTop,?sciControl:Region)
    OF ?MovePageUpButton
      ThisWindow.Update()
      POST(EVENT:PageUp,?sciControl:Region)
    OF ?LineUpButton
      ThisWindow.Update()
      POST(EVENT:ScrollUp,?sciControl:Region)
    OF ?LineDownButton
      ThisWindow.Update()
      POST(EVENT:ScrollDown,?sciControl:Region)
    OF ?MovePageDownButton
      ThisWindow.Update()
      POST(EVENT:PageDown,?sciControl:Region)
    OF ?MoveBottomButton
      ThisWindow.Update()
      POST(EVENT:ScrollBottom,?sciControl:Region)
    OF ?GoToButton
      ThisWindow.Update()
      SciControl.AskGotoLine()
    OF ?FindButton
      ThisWindow.Update()
      SciControl.SearchAsk()
    OF ?PrintButton
      ThisWindow.Update()
      SciControl.PrintAsk()
    OF ?EditButton
      ThisWindow.Update()
      IF glo:bUseAssociation
         szFilename = CLIP(sFilename)
         szNull = ''
         ShellExecute(window{prop:handle},0,szFilename,0,szNull,1)
      ELSE
         szCommandline = 'Notepad.exe ' & CLIP(sFilename)
         IF glo:szEditorCommand
            szCommandLine = glo:szEditorCommand
            I = INSTRING('.EXE ',UPPER(szCommandLine),1)
            IF I
               szCommandLine = SHORTPATH(szCommandLine[1 : I+3]) & szCommandLine[I+4 : LEN(szCommandLine)]
            END
            !look for filename parameter token
            I = INSTRING('%1',szCommandLine,1)
            IF I
               szCommandLine = SUB(szCommandLine,1,I-1) & |
                               CLIP(sFilename) & |
                               SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
            END
            !look for line number parameter token
            I = INSTRING('%2',szCommandLine,1)
            IF I
               szCommandLine = SUB(szCommandLine,1,I-1) & |
                               LineNo & |
                               SUB(szCommandLine,I+2,LEN(szCommandLine)-(I+1))
            END
         END
         RUN(szCommandLine)
         IF RUNCODE() = -4   !Failed to execute
           CASE MESSAGE('An error occurred trying to execute the following command:||' & szCommandLine & |
                   '||Do you want to use Notepad?',ERROR(),ICON:EXCLAMATION, |
                   BUTTON:YES+BUTTON:NO,BUTTON:YES)
           OF BUTTON:YES
              RUN('Notepad.exe ' & CLIP(sFilename))
           END
         END
      END
    OF ?CloseButton
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

lb          LIKE(LOGBRUSH)
hOldBrush   UNSIGNED
hBrush      UNSIGNED
hDC         UNSIGNED
hCheckBox   UNSIGNED
rVal        UNSIGNED
hwnd        UNSIGNED
Looped BYTE
  CODE
  hwnd = 0    !SciControl.GetWindowHandle()
  IF hwnd
     lb.lbStyle = BS_SOLID
     lb.lbColor = 0B99D7FH
     lb.lbHatch = 0
     hBrush = CreateBrushIndirect(lb)
     hDC = getWindowDC(hwnd)
     hOldBrush = SelectObject(hDC,hBrush)
     ExtFloodFill(hDC,0,0,COLOR:BLACK,FLOODFILLSURFACE)
     SelectObject(hDC,hOldBrush)
     DeleteObject(hBrush)
     ReleaseDC(hwnd,hDC)
  END
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
      COMPILE('***',_Scintilla_)
lc  LONG,AUTO
lh  LONG,AUTO
h   LONG,AUTO
h2  LONG,AUTO
      !***
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
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
    OF EVENT:PreAlertKey
      IF KEYCODE() <> EscKey AND KEYCODE() <> CtrlE
         CYCLE
      END
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
        OF CtrlE
           POST(EVENT:Accepted,?EditButton)
      END
    OF EVENT:DoResize
      SciControl.Reset(FALSE)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  SELF.SetStrategy(?sciControl:Region, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?sciControl:Region
  SELF.SetStrategy(?MoveTopButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MoveTopButton
  SELF.SetStrategy(?MovePageUpButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MovePageUpButton
  SELF.SetStrategy(?MovePageDownButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MovePageDownButton
  SELF.SetStrategy(?MoveBottomButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?MoveBottomButton
  SELF.SetStrategy(?GoToButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?GoToButton
  SELF.SetStrategy(?FindButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?FindButton
  SELF.SetStrategy(?PrintButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?PrintButton
  SELF.SetStrategy(?EditButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?EditButton
  SELF.SetStrategy(?CloseButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?CloseButton
  SELF.SetStrategy(?LineUpButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?LineUpButton
  SELF.SetStrategy(?LineDownButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?LineDownButton


Resizer.Resize PROCEDURE

ReturnValue          BYTE,AUTO

vcrXPos        LONG
vcrYPos        LONG

  CODE
  ReturnValue = PARENT.Resize()
    vcrXPos = 4
    vcrYPos = ?MoveTopButton{PROP:YPos}
    SETPOSITION(?MoveTopButton,vcrXPos,vcrYPos,,)
    vcrXPos += 16
    SETPOSITION(?MovePageUpButton,vcrXPos,vcrYPos,,)
    vcrXPos += 16
    SETPOSITION(?LineUpButton,vcrXPos,vcrYPos,,)
    vcrXPos += 16
    SETPOSITION(?LineDownButton,vcrXPos,vcrYPos,,)
    vcrXPos += 16
    SETPOSITION(?MovePageDownButton,vcrXPos,vcrYPos,,)
    vcrXPos += 16
    SETPOSITION(?MoveBottomButton,vcrXPos,vcrYPos,,)
  RETURN ReturnValue


SciControl.Colourise PROCEDURE(LONG lStart,LONG lEnd)

M               LONG
N               LONG
FirstLine       LONG
LastLine        LONG
thisLine        LONG
thisFoldLevel   LONG
thisClass       LONG
LastClass       LONG
SaveClass       LONG
  CODE
  PARENT.Colourise(lStart,lEnd)
  OMIT('***',UseDefaultWordlist=1)
  IF UPPER(SUB(ModuleQ.szModuleName,-3,3)) = 'CLW'
  
     FirstLine = lStart
     LastLine = CHOOSE(lEnd = -1, SELF.GetLineCount() - 1, lEnd)
  
     SaveClass = POINTER(ClassQ)
     LastClass = RECORDS(ClassQ)
     LOOP thisClass = 1 TO LastClass
        GET(ClassQ,thisCLass)
        IF ClassQ.lModuleID = ModuleQ.lModuleID
           N = RECORDS(MethodQ)
           LOOP M = 1 TO N
              GET(MethodQ,M)
              IF MethodQ.lClassID = ClassQ.lClassID
                 IF INRANGE(MethodQ:lSourceLine,FirstLine,LastLine)
                    sciControl.SetFoldLevel(MethodQ:lSourceLine-1,BOR(1023,SC_FOLDLEVELHEADERFLAG))
                 END
              END
           END
        END
     END
     GET(ClassQ,SaveClass)
  
     LOOP thisLine = FirstLine TO LastLine
       thisFoldLevel = BAND(SELF.GetFoldLevel(thisLine),SC_FOLDLEVELNUMBERMASK)
       IF thisFoldLevel = 1023
          SELF.SetFoldLevel(thisLine,BOR(1024,SC_FOLDLEVELHEADERFLAG))
          LOOP thisLine = thisLine+1 TO LastLine
             thisFoldLevel = BAND(SELF.GetFoldLevel(thisLine),SC_FOLDLEVELNUMBERMASK)
             IF thisFoldLevel = 1023
                thisLine -= 1
                BREAK
             ELSE
                IF BAND(SELF.GetFoldLevel(thisLine),SC_FOLDLEVELHEADERFLAG)
                   SELF.SetFoldLevel(thisLine,BOR(thisFoldLevel+1,SC_FOLDLEVELHEADERFLAG))
                ELSE
                   SELF.SetFoldLevel(thisLine,thisFoldLevel+1)
                END
             END
          END
       END
     END
  
  END
  !***


SciControl.FindWindowTakeOpenWindow PROCEDURE

Fld     LONG,AUTO
  CODE
  hwndViewer_tt = Viewer_tt.init(0{PROP:HANDLE},1) !ToolTipClass Initialization
  IF hwndViewer_tt
     Fld = 0
     LOOP
        Fld = 0{PROP:NextField,Fld}
        IF Fld = 0
           BREAK
        ELSE
           IF Fld{PROP:TIP}
              IF INSTRING('<13,10>',Fld{PROP:TIP},1,1)
                 Viewer_tt.addtip(Fld{PROP:HANDLE},Fld{PROP:TIP},1)
              ELSE
                 Viewer_tt.addtip(Fld{PROP:HANDLE},Fld{PROP:TIP},0)
              END!IF
              Fld{PROP:TIP}=''
           END!IF
        END!IF
     END!LOOP
     Viewer_tt.SetTipTextColor(COLOR:NAVY)
  END!IF
  PARENT.FindWindowTakeOpenWindow


SciControl.Init PROCEDURE(*WINDOW W,LONG feq,UNSIGNED id,BOOL Themed = 0)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Init(W,feq,id,TRUE)
  OMIT('ReturnValue')
  ReturnValue = PARENT.Init(W,feq,id,Themed)
  OMIT('***',UseDefaultWordlist=1)
  IF srcGetWordList(szClarionKeywords, szCompilerDirectives, szBuiltinProcsFuncs, szStructDataTypes, szAttributes, szStandardEquates)
     IF CLIP(szClarionKeywords)
        SELF.ClarionKeywords     &= szClarionKeywords
     END
     IF CLIP(szCompilerDirectives)
        SELF.CompilerDirectives  &= szCompilerDirectives
     END
     IF CLIP(szBuiltinProcsFuncs)
        SELF.BuiltinProcsFuncs   &= szBuiltinProcsFuncs
     END
     IF CLIP(szStructDataTypes)
        SELF.StructDataTypes     &= szStructDataTypes
     END
     IF CLIP(szAttributes)
        SELF.Attributes          &= szAttributes
     END
     IF CLIP(szStandardEquates)
        IF glo:bClarionVersion >= CWVERSION_C70 !CWVERSION_C80, CWVERSION_C90, CWVERSION_C100
           szStandardEquates = szStandardEquates & |
                               ' BEEP: BUTTON: CHARSET: COLOR: CREATE: CURSOR: DATATYPE: DDE: DOCK: DRIVEROP: '   & |
                               'EVENT: FF_: FILE: FONT: ICON: LISTZONE: MATCH: OCX: PAPER: PAPERBIN: '            & |
                               'PEN: PROP: PROPLIST: PROPPRINT: REJECT: RESOLUTION: STD: TPSREADONLY '            & |
                               'VBXEVENT: WARN:'
        END
        SELF.StandardEquates     &= szStandardEquates
     END
  END
  !***
  SELF.Style = glo:ViewerStyles
  IF glo:Typeface
     SELF.SetTypeface(glo:Typeface)
  END
  RETURN ReturnValue


SciControl.OpenFile PROCEDURE(*CSTRING szFileName)

ReturnValue          BOOL,AUTO

  CODE
  ReturnValue = PARENT.OpenFile(szFileName)
  ?sciControl:Region{PROP:Use} = SELF.szTextBuffer
  RETURN ReturnValue


SciControl.SetBuffer PROCEDURE

  CODE
  PARENT.SetBuffer
  SELF.SetClarionLexer()


SciControl.TakeEvent PROCEDURE

ReturnValue          BYTE,AUTO

WordEndPosition     LONG,AUTO
WordStartPosition   LONG,AUTO
szHotClickWord      CSTRING(256)
  CODE
  ReturnValue = PARENT.TakeEvent()
  CASE EVENT()
     OF    SCN_MARGINCLICK
        SELF.ToggleFold(SELF.LineFromPosition(SELF.MarginClickPosition))
     OF    SCN_HOTSPOTCLICK        |
     OROF  SCN_HOTSPOTDOUBLECLICK
        WordEndPosition = SELF.WordEndPosition(SELF.HotSpotClickPosition, 0)
        WordStartPosition = SELF.WordStartPosition(SELF.HotSpotClickPosition, 0)
        SELF.SetCurrentPos(WordStartPosition)
        SELF.SetAnchor(WordEndPosition)
        SELF.GetSelText(szHotClickWord)
        SELF.SetSel(SELF.HotSpotClickPosition,SELF.HotSpotClickPosition)
        CASE glo:bClarionVersion
          OF CWVERSION_C2
             HELP(szRoot & '\bin\CW20help.hlp',szHotClickWord)
             HELP('abcview.hlp')
          OF CWVERSION_C4
             HELP(szRoot & '\bin\C4help.hlp',szHotClickWord)
             HELP('abcview.hlp')
          OF CWVERSION_C5 OROF CWVERSION_C5EE
             HELP(szRoot & '\bin\C5help.hlp',szHotClickWord)
             HELP('abcview.hlp')
          OF CWVERSION_C55 OROF CWVERSION_C55EE
             HELP(szRoot & '\bin\C55help.hlp',szHotClickWord)
             HELP('abcview.hlp')
          OF CWVERSION_C60 OROF CWVERSION_C60EE
             HELP(szRoot & '\bin\C60help.hlp',szHotClickWord)
             HELP('abcview.hlp')
          OF CWVERSION_C70 OROF CWVERSION_C80 OROF CWVERSION_C90 OROF CWVERSION_C100
             IF oHH &= NULL
                oHH &= NEW tagHTMLHelp
                oHH.Init(szRoot & '\bin\ClarionHelp.chm')
             ELSE
                oHH.SetHelpFile(szRoot & '\bin\ClarionHelp.chm')
             END
             oHH.KeyWordLookup(szHotClickWord)
             !oHH.ShowTopic(szHotClickWord)
             oHH.SetHelpFile( 'ABCVIEW.CHM' )
        END
  END
  RETURN ReturnValue


SciControl.TakeOpenWindow PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.TakeOpenWindow()
  IF bControlInitialised
     SciControl.UsePopup(FALSE)
     SciControl.SetDefaults()
  
     szAsciiFilename = CLIP(sFileName)
     SciControl.SetReadOnly(FALSE)
     ViewerActive = SciControl.OpenFile(szAsciiFilename)
     IF ViewerActive = TRUE
        SciControl.SetReadOnly(TRUE)
        sciControl.GoToLine(LineNo + ?sciControl:Region{PROP:LineCount})
        SciControl.GoToLine(LineNo-1)
     END
  END
  RETURN ReturnValue

