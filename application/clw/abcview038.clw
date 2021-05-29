

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

!!! <summary>
!!! Generated from procedure template - Window
!!! Get Scan Options
!!! </summary>
winGetScanOptions PROCEDURE (ForceSmartScan)

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
subFolder            CSTRING(5)
RetVal               LONG(Level:Notify)                    ! 
I                    LONG                                  ! 
J                    LONG                                  ! 
loc:bEquates         BYTE                                  ! 
loc:bKeycodes        BYTE                                  ! 
loc:bErrors          BYTE                                  ! 
loc:bTplEqu          BYTE                                  ! 
loc:bProperty        BYTE                                  ! 
loc:bWinEqu          BYTE                                  ! 
loc:bPrnProp         BYTE                                  ! 
loc:bWindows         BYTE                                  ! 
Q                    QUEUE,PRE(Q)                          ! Queue of Module Names
szModuleName         CSTRING(64)                           ! 
szModulePath         CSTRING(256)                          ! 
bClarionVersion      BYTE                                  ! 
                     END                                   ! 
szSection            CSTRING(64)                           ! 
szRedFileName        CSTRING(64)                           ! 
loc:szRedFilePath    CSTRING(256)                          ! 
loc:szCurrentDir     CSTRING(256)                          ! 
loc:szCompactRedFilePath CSTRING(43)                       ! 
loc:szCompactCurrentDir CSTRING(43)                        ! 
Window               WINDOW('Scan Options'),AT(,,236,142),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,TILED,ALRT(EscKey), |
  CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       BUTTON('Scan N&ow'),AT(138,124,45,14),USE(?OK:Button),DEFAULT
                       BUTTON('Cancel'),AT(187,124,45,14),USE(?Cancel:Button)
                       PANEL,AT(4,4,228,116),USE(?ScanPanel),FILL(COLOR:BTNFACE)
                       PROMPT('&Redirection File:'),AT(8,8),USE(?szRedFilePath:Prompt),TRN
                       ENTRY(@s42),AT(72,8,140,10),USE(loc:szCompactRedFilePath),COLOR(COLOR:BTNFACE),READONLY,SKIP
                       BUTTON('...'),AT(216,8,11,10),USE(?LookupRedPath:Button),TIP('Select the Redirection fi' & |
  'le to use.')
                       PROMPT('&Current Directory:'),AT(8,22),USE(?szCurrentDir:Prompt),TRN
                       ENTRY(@s42),AT(72,22,140,10),USE(loc:szCompactCurrentDir),COLOR(COLOR:BTNFACE),READONLY,SKIP
                       BUTTON('...'),AT(216,22,11,10),USE(?LookupCurrentDir:Button),TIP('Select the directory ' & |
  'to be used as the current<0DH,0AH>working directory for the scanning process.')
                       GROUP,AT(8,32,219,84),USE(?ClarionGroup),BOXED
                         GROUP(' Include Standard Equate Files'),AT(14,39,206,57),USE(?StandardEquateGroup),BOXED
                           CHECK(' EQUATES.CLW'),AT(19,49),USE(loc:bEquates),COLOR(COLOR:BTNFACE)
                           CHECK(' KEYCODES.CLW'),AT(19,71),USE(loc:bKeycodes),COLOR(COLOR:BTNFACE)
                           CHECK(' ERRORS.CLW'),AT(19,60),USE(loc:bErrors),COLOR(COLOR:BTNFACE)
                           CHECK(' TPLEQU.CLW'),AT(100,60),USE(loc:bTplEqu),COLOR(COLOR:BTNFACE)
                           CHECK(' PROPERTY.CLW'),AT(100,49),USE(loc:bProperty),COLOR(COLOR:BTNFACE)
                           CHECK(' WINEQU.CLW'),AT(100,82),USE(loc:bWinEqu),COLOR(COLOR:BTNFACE)
                           CHECK(' PRNPROP.CLW'),AT(19,82),USE(loc:bPrnProp),COLOR(COLOR:BTNFACE)
                           CHECK(' WINDOWS.INC'),AT(100,71),USE(loc:bWindows),COLOR(COLOR:BTNFACE)
                         END
                         BUTTON('Additional &Files...'),AT(14,100,68,11),USE(?AdditionalFilesButton),TIP('Select Add' & |
  'itional Files for Processing')
                         CHECK(' Scan &All Source Files'),AT(100,100),USE(glo:bRefreshAll),COLOR(COLOR:BTNFACE),TIP('Check to s' & |
  'can all source files.<0DH,0AH>Leave unchecked to scan only files that have<0DH,0AH>b' & |
  'een modified since the last scan.')
                       END
                     END

tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


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

loc:build         CSTRING(5)
loc:szFileName    CSTRING(256)
loc:szXMLFileName CSTRING(261)
cc                LONG
  CODE
  GlobalErrors.SetProcedureName('winGetScanOptions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OK:Button
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szSection = 'Clarion 2'
       szRedFileName = '\bin\cw20.red'
    OF CWVERSION_C4
       szSection = 'Clarion 4'
       szRedFileName = '\bin\clarion4.red'
    OF CWVERSION_C5
       szSection = 'Clarion 5'
       szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C5EE
       szSection = 'Clarion 5  Enterprise Edition'
       szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C55
       szSection = 'Clarion 5.5'
       szRedFileName = '\bin\c55pe.red'
    OF CWVERSION_C55EE
       szSection = 'Clarion 5.5  Enterprise Edition'
       szRedFileName = '\bin\c55ee.red'
    OF CWVERSION_C60
       szSection = 'Clarion 6.0'
       szRedFileName = '\bin\c60pe.red'
    OF CWVERSION_C60EE
       szSection = 'Clarion 6.0  Enterprise Edition'
       szRedFileName = '\bin\c60ee.red'
    OF CWVERSION_C70
       szSection = 'Clarion 7.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(szSection))) = UPPER(szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) = loc:build
             szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
  
    OF CWVERSION_C80
       szSection = 'Clarion 8.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(szSection))) = UPPER(szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) = loc:build
             szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
  
    OF CWVERSION_C90
       szSection = 'Clarion 9.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(szSection))) = UPPER(szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) = loc:build
             szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
  
    OF CWVERSION_C100
       szSection = 'Clarion 10.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(szSection))) = UPPER(szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(szSection)+3,4) = loc:build
             szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
  
  END
  
  !get root folder
  IF glo:bClarionVersion < CWVERSION_C70
     szRoot = GETINI(szSection,'root')                              !get root directory
     IF szRoot[LEN(szRoot)] = '\'
        szRoot[LEN(szRoot)] = '<0>'                                 !remove trailing backslash
     END
     IF glo:szRedFilePath
        loc:szRedFilePath = glo:szRedFilePath
     ELSE
        loc:szRedFilePath = szRoot & szRedFileName
     END
  ELSE
     szRoot = glo:VersionQ.Root
     IF glo:szRedFilePath
        loc:szRedFilePath = glo:szRedFilePath
     ELSE
        loc:szRedFilePath = glo:VersionQ.RedDir & szRedFileName
     END
  END
  PathCompactPathEx(loc:szCompactRedFilePath, loc:szRedFilePath, SIZE(loc:szCompactRedFilePath),0)
  
  IF glo:szCurrentDir
     loc:szCurrentDir = glo:szCurrentDir
  ELSE
     loc:szCurrentDir = LONGPATH(PATH())
  END
  PathCompactPathEx(loc:szCompactCurrentDir, loc:szCurrentDir, SIZE(loc:szCompactCurrentDir),0)
  
  FREE(Q)
  J = RECORDS(ExtraModuleQ)
  LOOP I = 1 TO J
    GET(ExtraModuleQ,I)
    IF ExtraQ:bClarionVersion = glo:bClarionVersion
       Q = ExtraModuleQ
       ADD(Q,+Q.szModuleName,+Q.szModulePath)
       CASE UPPER(Q.szModuleName)
       OF 'EQUATES.CLW'
          loc:bEquates = TRUE
       OF 'ERRORS.CLW'
          loc:bErrors = TRUE
       OF 'PROPERTY.CLW'
          loc:bProperty = TRUE
       OF 'PRNPROP.CLW'
          loc:bPrnProp = TRUE
       OF 'KEYCODES.CLW'
          loc:bKeycodes = TRUE
       OF 'TPLEQU.CLW'
          loc:bTplEqu = TRUE
       OF 'WINEQU.CLW'
          loc:bWinEqu = TRUE
       OF 'WINDOWS.INC'
          loc:bWindows = TRUE
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
     CASE I
     OF ?StandardEquateGroup
        !XPStandardEquateGroup.FontName = glo:Typeface
        !XPStandardEquateGroup.FontSize = glo:FontSize
     END
  END
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINGETSCANOPTIONS'
  IF glo:bClarionVersion > CWVERSION_C60EE
     subFolder = 'win\'
  ELSE
     subFolder = ''
  END
  
  DISABLE(?loc:bEquates,?loc:bWindows)
  LOOP I = 1 TO 8
    CASE I
    OF 1
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\equates.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bEquates{PROP:Disable} = FALSE
       END
    OF 2
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\errors.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bErrors{PROP:Disable} = FALSE
       END
    OF 3
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\property.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bProperty{PROP:Disable} = FALSE
       END
    OF 4
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\prnprop.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bPrnProp{PROP:Disable} = FALSE
       END
    OF 5
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\keycodes.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bKeycodes{PROP:Disable} = FALSE
       END
    OF 6
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\tplequ.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bTplEqu{PROP:Disable} = FALSE
       END
    OF 7
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\winequ.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bWinEqu{PROP:Disable} = FALSE
       END
    OF 8
       loc:szFileName = szRoot & '\libsrc\' & subFolder & '\windows.inc'
       IF _access(loc:szFileName,0) = 0
          ?loc:bWindows{PROP:Disable} = FALSE
       END
    END
  END
  
  IF ForceSmartScan = TRUE
     glo:bRefreshAll = FALSE
     POST(EVENT:Accepted,?OK:Button)
  END
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Scan_Options.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Scan_Options.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  IF glo:bShowTips
  tt.Kill()                                                !ToolTipClass Cleanup
  END
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
     tt.addtip(?LookupRedPath:Button{PROP:HANDLE},?LookupRedPath:Button{PROP:TIP},0)
     ?LookupRedPath:Button{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?LookupCurrentDir:Button{PROP:HANDLE},?LookupCurrentDir:Button{PROP:TIP},1)
     ?LookupCurrentDir:Button{PROP:TIP} = ''               ! Clear tip property to avoid two tips
     tt.addtip(?OK:Button{PROP:HANDLE},?OK:Button{PROP:TIP},0)
     tt.addtip(?Cancel:Button{PROP:HANDLE},?Cancel:Button{PROP:TIP},0)
     tt.addtip(?AdditionalFilesButton{PROP:HANDLE},?AdditionalFilesButton{PROP:TIP},0)
     ?AdditionalFilesButton{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?glo:bRefreshAll{PROP:HANDLE},?glo:bRefreshAll{PROP:TIP},1)
     ?glo:bRefreshAll{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
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
    OF ?OK:Button
      ThisWindow.Update()
       glo:szRedFilePath = loc:szRedFilePath
       glo:szCurrentDir = loc:szCurrentDir
      
       INIMgr.Update('Options','Current Directory',glo:szCurrentDir)
       INIMgr.Update('Options','RED File Path ' & glo:bClarionVersion,glo:szRedFilePath)
      
       FREE(ExtraModuleQ)
       J = RECORDS(Q)
       LOOP I = 1 TO J
         GET(Q,I)
         ExtraModuleQ = Q
         ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
       RetVal = Level:Benign
       POST(EVENT:CloseWindow)
    OF ?Cancel:Button
      ThisWindow.Update()
       RetVal = Level:Notify
       POST(EVENT:CloseWindow)
    OF ?LookupRedPath:Button
      ThisWindow.Update()
       IF ~FILEDIALOG('Select Redirection File',loc:szRedFilePath,'Redrection File (*.RED)|*.RED|All Files (*.*)|*.*',File:KeepDir+File:LongName)
          IF glo:szRedFilePath
             loc:szRedFilePath = glo:szRedFilePath
          ELSE
             IF glo:bClarionVersion < CWVERSION_C70
                loc:szRedFilePath = szRoot & szRedFileName
             ELSE
                loc:szRedFilePath = glo:VersionQ.RedDir & szRedFileName
             END
          END
       ELSE
          PathCompactPathEx(loc:szCompactRedFilePath, loc:szRedFilePath, SIZE(loc:szCompactRedFilePath),0)
          DISPLAY(?loc:szCompactRedFilePath)
       END
    OF ?LookupCurrentDir:Button
      ThisWindow.Update()
       IF ~FILEDIALOG('Select Current Working Directory',loc:szCurrentDir,'All Files (*.*)|*.*',File:KeepDir+File:LongName+File:Directory)
          IF glo:szCurrentDir
             loc:szCurrentDir = glo:szCurrentDir
          ELSE
             loc:szCurrentDir = LONGPATH(PATH())
          END
       ELSE
          PathCompactPathEx(loc:szCompactCurrentDir, loc:szCurrentDir, SIZE(loc:szCompactCurrentDir),0)
          DISPLAY(?loc:szCompactCurrentDir)
       END
    OF ?loc:bEquates
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bEquates
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bKeycodes
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bKeycodes
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bErrors
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bErrors
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bTplEqu
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bTplEqu
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bProperty
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bProperty
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bWinEqu
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bWinEqu
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bPrnProp
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bPrnProp
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?loc:bWindows
       Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
       Q.szModulePath = szRoot & '\LIBSRC\' & subFolder
       Q.bClarionVersion = glo:bClarionVersion
       IF loc:bWindows
          ADD(Q,+Q.szModuleName,+Q.szModulePath)
       ELSE
          GET(Q,+Q.szModuleName,+Q.szModulePath)
          IF ~ERRORCODE()
             DELETE(Q)
          END
       END
    OF ?AdditionalFilesButton
      ThisWindow.Update()
       winAdditionalFiles(Q,glo:bClarionVersion)
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
    OF EVENT:PreAlertKey
      IF KEYCODE() <> EscKey
         CYCLE
      END
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
  SELF.SetStrategy(?ScanPanel, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?ScanPanel
  SELF.SetStrategy(?szRedFilePath:Prompt, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?szRedFilePath:Prompt
  SELF.SetStrategy(?LookupRedPath:Button, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?LookupRedPath:Button
  SELF.SetStrategy(?szCurrentDir:Prompt, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?szCurrentDir:Prompt
  SELF.SetStrategy(?LookupCurrentDir:Button, Resize:FixRight+Resize:FixTop, Resize:LockSize) ! Override strategy for ?LookupCurrentDir:Button
  SELF.SetStrategy(?OK:Button, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?OK:Button
  SELF.SetStrategy(?Cancel:Button, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?Cancel:Button
  SELF.SetStrategy(?ClarionGroup, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?ClarionGroup
  SELF.SetStrategy(?StandardEquateGroup, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?StandardEquateGroup
  SELF.SetStrategy(?loc:bEquates, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bEquates
  SELF.SetStrategy(?loc:bErrors, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bErrors
  SELF.SetStrategy(?loc:bTplEqu, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bTplEqu
  SELF.SetStrategy(?loc:bProperty, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bProperty
  SELF.SetStrategy(?loc:bWinEqu, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bWinEqu
  SELF.SetStrategy(?loc:bPrnProp, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bPrnProp
  SELF.SetStrategy(?loc:bWindows, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bWindows
  SELF.SetStrategy(?AdditionalFilesButton, Resize:FixLeft+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?AdditionalFilesButton
  SELF.SetStrategy(?loc:bKeycodes, Resize:FixLeft+Resize:FixTop, Resize:LockSize) ! Override strategy for ?loc:bKeycodes

