

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
!!! View Annotation
!!! </summary>
winViewNote PROCEDURE (bClarionVersion,szLookup)

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
bNoteInserted        BYTE                                  ! 
loc:szNote           LIKE(NoteQ.szNote)                    ! 
Window               WINDOW('Notes'),AT(,,198,178),DOUBLE,CENTER,GRAY,PALETTE(256)
                       TEXT,AT(0,0),USE(loc:szNote),FULL,VSCROLL,COLOR(00C0FFFFh)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('winViewNote')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?loc:szNote
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SORT(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
  NoteQ.bClarionVersion = bClarionVersion
  NoteQ.szLookup = UPPER(szLookup)
  GET(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
  IF ERRORCODE()
     ADD(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
     bNoteInserted = TRUE
     loc:szNote = ''
  ELSE
     bNoteInserted = FALSE
     loc:szNote = NoteQ.szNote
  END
  SELF.Open(Window)                                        ! Open window
  J = LASTFIELD()
  LOOP I = 1 TO J
     SETFONT(I,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
  END
  ?loc:szNote{PROP:Background} = glo:lNoteColor
  Do DefineListboxStyle
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINVIEWNOTE'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('View_Notes.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('View_Notes.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
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
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:CloseWindow
      IF loc:szNote
         IF loc:szNote <> NoteQ.szNote
            IF GlobalErrors.Throw(Msg:SaveNote) = Level:Benign
               NoteQ.szNote = loc:szNote
               PUT(NoteQ)
               TreeQ.wNoteIcon = ICON:NOTE
               TreeQ.szNoteTip = NoteQ.szNote
               srcWordWrap(TreeQ.szNoteTip,64)
               PUT(TreeQ)
            END
         END
      ELSE
         IF bNoteInserted
            DELETE(NoteQ)
            NoteQ.szNote = ''
            TreeQ.wNoteIcon = 0
            TreeQ.szNoteTip = NoteQ.szNote
            PUT(TreeQ)
         ELSE
            IF GlobalErrors.Throw(Msg:DeleteNote) = Level:Benign
               DELETE(NoteQ)
               NoteQ.szNote = ''
               TreeQ.wNoteIcon = 0
               TreeQ.szNoteTip = NoteQ.szNote
               PUT(TreeQ)
            END
         END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

