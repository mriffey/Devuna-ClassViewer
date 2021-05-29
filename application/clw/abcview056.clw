

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
!!! Update Class Method
!!! </summary>
winUpdateMethod PROCEDURE 

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
MTH:MethodName       LIKE(MethodQ.szMethodName)            ! 
MTH:ParameterList    LIKE(MethodQ.szPrototype)             ! 
MTH:ReturnType       CSTRING(17)                           ! 
MTH:CallingConvention CSTRING(7)                           ! 
MTH:Raw              BYTE                                  ! 
MTH:Name             CSTRING(64)                           ! 
MTH:Type             BYTE                                  ! 
MTH:DLL              BYTE                                  ! 
MTH:Proc             BYTE                                  ! 
MTH:Scope            CSTRING(17)                           ! 
MTH:Virtual          LIKE(MethodQ.bVirtual)                ! 
MTH:Replace          BYTE                                  ! 
MTH:Derived          BYTE                                  ! 
Window               WINDOW('Update Method'),AT(,,214,100),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,TILED,GRAY, |
  PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       PANEL,AT(4,4,206,74),USE(?Panel1),FILL(COLOR:BTNFACE)
                       PROMPT('&Method Name:'),AT(8,8),USE(?szMethodName:Prompt)
                       ENTRY(@s20),AT(60,8,146,10),USE(MTH:MethodName)
                       PROMPT('&Prototype:'),AT(8,22),USE(?szPrototype:Prompt)
                       ENTRY(@s20),AT(60,22,146,10),USE(MTH:ParameterList)
                       PROMPT('&Scope:'),AT(8,36),USE(?PRO:Scope:Prompt),TRN
                       LIST,AT(60,36,,10),USE(MTH:Scope),LEFT(2),DROP(5),FROM('Public|#Public|Private|#Private' & |
  '|Protected|#Protected')
                       CHECK(' &Virtual'),AT(60,50),USE(MTH:Virtual)
                       BUTTON('&OK'),AT(116,82,45,14),USE(?OK:Button)
                       BUTTON('Cancel'),AT(165,82,45,14),USE(?Cancel:Button)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
MyAsciiFileClass        kcrAsciiFileClass
MyAsciiFileClassActive  BYTE,AUTO
UC_TextLine             STRING(255)

AsciiFilename           STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile               FILE,DRIVER('ASCII'),NAME(AsciiFilename),PRE(A1),THREAD
RECORD                    RECORD,PRE()
TextLine                    STRING(255)
                          END
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

I                    LONG,AUTO
J                    LONG,AUTO
  CODE
  GlobalErrors.SetProcedureName('winUpdateMethod')
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
     MTH:MethodName = ''
     MTH:ParameterList = ''
     MTH:ReturnType = ''
     MTH:CallingConvention = ''
     MTH:Raw = FALSE
     MTH:Name = ''
     MTH:Type = FALSE
     MTH:DLL = FALSE
     MTH:Proc = FALSE
     MTH:Scope = ''
     MTH:Virtual = FALSE
     MTH:Replace = FALSE
     MTH:Derived = FALSE
  OF ChangeRecord
     IF TreeQ.lIncludeId
        ModuleQ.lModuleId = TreeQ.lIncludeId
        GET(ModuleQ,+ModuleQ.lModuleId)
      ASSERT(~ERRORCODE())
        AsciiFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
        MyAsciiFileClassActive = MyAsciiFileClass.Init(AsciiFile,AsciiFile.Textline,AsciiFilename,GlobalErrors)
        IF MyAsciiFileClassActive
           MESSAGE(MyAsciiFileClass.GetLine(TreeQ.lLineNum))
           UC_TextLine = UPPER(AsciiFile.Textline)
           MyAsciiFileClass.Kill()
  
           MTH:MethodName = srcGetLabel(AsciiFile.Textline)
           MTH:ParameterList = srcGetPrototype(AsciiFile.Textline)
           !!MTH:ReturnType = srcGetReturnType(AsciiFile.Textline)
           IF INSTRING('PASCAL',UC_TextLine,1)
              MTH:CallingConvention = 'PASCAL'
           ELSIF (INSTRING(',C,',UC_TextLine,1) OR SUB(UC_TextLine,-2,2) = ',C')
              MTH:CallingConvention = 'C'
           ELSE
              MTH:CallingConvention = ''
           END
           MTH:Raw = CHOOSE(INSTRING(',RAW',UC_TextLine,1)=0,FALSE,TRUE)
  
           MTH:Name = ''
           MTH:Type = CHOOSE(INSTRING(',TYPE',UC_TextLine,1)=0,FALSE,TRUE)
           MTH:DLL  = CHOOSE(INSTRING(',DLL',UC_TextLine,1)=0,FALSE,TRUE)
           MTH:Proc = CHOOSE(INSTRING(',PROC',UC_TextLine,1)=0,FALSE,TRUE)
  
  
           IF INSTRING('PRIVATE',UC_TextLine,1)
              MTH:Scope = 'Private'
           ELSIF INSTRING('PROTECTED',UC_TextLine,1)
              MTH:Scope = 'Protected'
           ELSE
              MTH:Scope = 'Public'
           END
  
           MTH:Virtual = CHOOSE(INSTRING(',VIRTUAL',UC_TextLine,1)=0,FALSE,TRUE)
           MTH:Replace = CHOOSE(INSTRING(',REPLACE',UC_TextLine,1)=0,FALSE,TRUE)
           MTH:Derived = CHOOSE(INSTRING(',DERIVED',UC_TextLine,1)=0,FALSE,TRUE)
  
        END
     END
  OF DeleteRecord
     !Ask Delete Reecord
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
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINUPDATEMETHOD'
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
    OF ?OK:Button
      ThisWindow.Update()
      !SORT(ModuleQ,+ModuleQ.lModuleId)
      IF TreeQ.lIncludeId
         ModuleQ.lModuleId = TreeQ.lIncludeId
         GET(ModuleQ,+ModuleQ.lModuleId)
       ASSERT(~ERRORCODE())
         AsciiFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
         MyAsciiFileClassActive = MyAsciiFileClass.Init(AsciiFile,AsciiFile.Textline,AsciiFilename,GlobalErrors)
         IF MyAsciiFileClassActive
            MESSAGE(MyAsciiFileClass.GetLine(TreeQ.lLineNum))
            MyAsciiFileClass.Kill()
         END
      END
      IF TreeQ.lModuleId
         ModuleQ.lModuleId = TreeQ.lModuleId
         GET(ModuleQ,+ModuleQ.lModuleId)
       ASSERT(~ERRORCODE())
         AsciiFileName = ModuleQ.szModulePath & ModuleQ.szModuleName
         MyAsciiFileClassActive = MyAsciiFileClass.Init(AsciiFile,AsciiFile.Textline,AsciiFilename,GlobalErrors)
         IF MyAsciiFileClassActive
            MESSAGE(MyAsciiFileClass.GetLine(TreeQ.lSourceLine))
            MyAsciiFileClass.Kill()
         END
      END
       POST(EVENT:CloseWindow)
    OF ?Cancel:Button
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

