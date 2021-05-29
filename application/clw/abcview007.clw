

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
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
 loc:szEditorCommand::WndProc (HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam),LONG,PASCAL
 TreeList::WndProc     (HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam),LONG,PASCAL
                     END


loc:szEditorCommand::OrigWndProc LONG,THREAD
TreeList::OrigWndProc LONG,THREAD
!!! <summary>
!!! Generated from procedure template - Window
!!! Edit User Preferences
!!! </summary>
winOptions PROCEDURE 

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
FilesOpened          BYTE                                  ! 
bReturnValue         BYTE(FALSE)                           ! 
loc:szRedFileName    CSTRING(64)                           ! 
loc:szRedFilePath    CSTRING(256)                          ! 
loc:szCompactRedFilePath CSTRING(43)                       ! 
loc:Background       BYTE                                  ! 
loc:Color1           LONG                                  ! 
loc:Color2           LONG                                  ! 
loc:sColor1          STRING(30)                            ! 
loc:sColor2          STRING(30)                            ! 
loc:szWallpaper1     LIKE(glo:szWallpaper1)                ! 
loc:szWallpaper2     LIKE(glo:szWallpaper2)                ! 
loc:Tiled1           BYTE                                  ! 
loc:Tiled2           BYTE                                  ! 
loc:Typeface         STRING(31)                            ! 
loc:FontSize         LONG                                  ! 
loc:FontColor        LONG                                  ! 
loc:sFontColor       STRING(30)                            ! 
loc:FontStyle        LONG                                  ! 
loc:szFont           CSTRING(256)                          ! 
loc:lModuleColor     LONG                                  ! 
loc:sModuleColor     STRING(30)                            ! 
loc:lPrivateColor    LONG                                  ! 
loc:sPrivateColor    STRING(30)                            ! 
loc:lProtectedColor  LONG                                  ! 
loc:sProtectedColor  STRING(30)                            ! 
loc:lVirtualColor    LONG                                  ! 
loc:sVirtualColor    STRING(30)                            ! 
loc:lSelectedBack    LONG                                  ! 
loc:sSelectedBack    STRING(30)                            ! 
loc:lSelectedFore    LONG                                  ! 
loc:sSelectedFore    STRING(30)                            ! 
loc:lNoteColor       LONG                                  ! 
loc:sNoteColor       STRING(30)                            ! 
loc:lHighlightColor1 LONG                                  ! 
loc:sHighlightColor1 STRING(30)                            ! 
loc:lHighlightColor2 LONG                                  ! 
loc:sHighlightColor2 STRING(30)                            ! 
loc:sHyperlinkColor  STRING(30)                            ! 
loc:lHyperlinkColor  LONG                                  ! 
loc:bClarionVersion  BYTE                                  ! 
loc:bShowTips        BYTE                                  ! 
loc:bOpaqueCheckBox  BYTE                                  ! 
loc:bForceEdit       BYTE                                  ! 
loc:bUseAssociation  BYTE                                  ! Use WIndows File Association
loc:szEditorCommand  LIKE(glo:szEditorCommand)             ! 
sav:szEditorCommand  LIKE(glo:szEditorCommand)             ! 
Q                    QUEUE,PRE(Q)                          ! Queue of Module Names
szModuleName         CSTRING(64)                           ! 
szModulePath         CSTRING(256)                          ! 
bClarionVersion      BYTE                                  ! 
                     END                                   ! 
szNull               CSTRING(2)                            ! 
szURL                CSTRING(256)                          ! 
loc:szRoot           CSTRING(256)                          ! 
loc:bEquates         BYTE                                  ! 
loc:bErrors          BYTE                                  ! 
loc:bProperty        BYTE                                  ! 
loc:bPrnProp         BYTE                                  ! 
loc:bKeycodes        BYTE                                  ! 
loc:bTplEqu          BYTE                                  ! 
loc:bWinEqu          BYTE                                  ! 
loc:bWindows         BYTE                                  ! 
loc:bAutoExpand      BYTE                                  ! Automatically expand the selected object.
loc:bUseHTMLHelp     BYTE                                  ! 
loc:bShowSparseTrees BYTE                                  ! 
loc:szXmlStyleSheet  CSTRING(256)                          ! 
EditorQ              QUEUE,PRE(eq)                         ! List of good shareware editors.
szWebAddress         CSTRING(256)                          ! 
szCommandLineExample CSTRING(129)                          ! example command line
                     END                                   ! 
loc:ViewerStyles     GROUP(COLORGROUPTYPE),PRE()           ! 
                     END                                   ! 
loc:StyleGroup       GROUP(STYLEGROUPTYPE),PRE(sg)         ! 
                     END                                   ! 
loc:szViewerFont     CSTRING(256)                          ! 
loc:sViewerForeColor STRING(30)                            ! 
loc:sViewerBackColor STRING(30)                            ! 
loc:sViewerSample    CSTRING(65)                           ! 
OptionQ              QUEUE,PRE(Tree)                       ! 
szText               CSTRING(32)                           ! 
Icon                 SHORT                                 ! 
Level                LONG                                  ! 
Style                LONG                                  ! 
Feq                  LONG                                  ! 
                     END                                   ! 
Heading1             CSTRING(33)                           ! 
Heading2             CSTRING(33)                           ! 
Sheet2Choice         LONG                                  ! 
loc:bMaxMRU          BYTE                                  ! 
loc:CategoryDropCount BYTE                                 ! 
loc:Layout           BYTE                                  ! 
szSubKey             CSTRING(255)                          ! 
szValueName          CSTRING(255)                          ! 
szValue              CSTRING(255)                          ! 
hKeyExtension        ULONG                                 ! 
pType                ULONG                                 ! 
pData                ULONG                                 ! 
RetVal               LONG                                  ! 
Window               WINDOW('Edit Options'),AT(,,351,200),DOUBLE,TILED,CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       LIST,AT(4,5,100,190),USE(?TreeList),FONT(,8,COLOR:Black,,CHARSET:ANSI),VSCROLL,COLOR(COLOR:White, |
  COLOR:HIGHLIGHTTEXT,COLOR:HIGHLIGHT),FLAT,FORMAT('68L(2)IYT@s31@'),FROM(OptionQ)
                       STRING(@s32),AT(117,9),USE(Heading1),FONT(,,COLOR:Black,FONT:bold,CHARSET:ANSI),TRN
                       STRING(@s32),AT(127,31),USE(Heading2),FONT(,,COLOR:Black,FONT:bold,CHARSET:ANSI),HIDE,TRN
                       SHEET,AT(109,4,238,174),USE(?Sheet1),COLOR(COLOR:BTNFACE),WIZARD
                         TAB('Clarion'),USE(?Clarion:Tab)
                           GROUP,AT(113,18,230,156),USE(?ClarionGroup),BOXED,TRN
                             GROUP('Include Standard Equate Files'),AT(119,23,218,57),USE(?StandardEquateGroup),BOXED,TRN
                               CHECK(' EQUATES.CLW'),AT(124,34),USE(loc:bEquates),TRN
                               CHECK(' KEYCODES.CLW'),AT(124,55),USE(loc:bKeycodes),TRN
                               CHECK(' ERRORS.CLW'),AT(124,44),USE(loc:bErrors),TRN
                               CHECK(' TPLEQU.CLW'),AT(215,44),USE(loc:bTplEqu),TRN
                               CHECK(' PROPERTY.CLW'),AT(215,34),USE(loc:bProperty),TRN
                               CHECK(' WINEQU.CLW'),AT(215,66),USE(loc:bWinEqu),TRN
                               CHECK(' PRNPROP.CLW'),AT(124,66),USE(loc:bPrnProp),TRN
                               CHECK(' WINDOWS.INC'),AT(215,55),USE(loc:bWindows),TRN
                             END
                             BUTTON('Additional &Files...'),AT(119,84,68,11),USE(?AdditionalFilesButton),TIP('Select Add' & |
  'itional Files for Processing')
                             PANEL,AT(113,100,230,1),USE(?Panel1),BEVEL(0,0,9)
                             PROMPT('&Redirection File:'),AT(119,108),USE(?szRedFilePath:Prompt),TRN
                             ENTRY(@s42),AT(185,108,138,10),USE(loc:szCompactRedFilePath),COLOR(COLOR:White),DISABLE,READONLY, |
  SKIP
                             BUTTON('...'),AT(327,108,10,10),USE(?LookupRedPath:Button),TIP('Select the Redirection ' & |
  'file to use.')
                           END
                         END
                         TAB('Application'),USE(?Application:Tab)
                           GROUP,AT(113,18,230,156),USE(?ApplicationGroup),BOXED,TRN
                             PROMPT('&Font:'),AT(119,26),USE(?loc:szFont:Prompt),TRN
                             ENTRY(@s255),AT(183,26,140,10),USE(loc:szFont),COLOR(COLOR:White),DISABLE,READONLY,SKIP
                             BUTTON('...'),AT(327,26,11,10),USE(?FontLookupButton),TIP('Select Application Font')
                             PROMPT('&Background:'),AT(119,40),USE(?glo:Background:Prompt),TRN
                             LIST,AT(183,40,,10),USE(loc:Background),COLOR(COLOR:White),DROP(5),FROM('Color|#1|Wallp' & |
  'aper|#2|None|#3'),TIP('Choose Application Background Type')
                             GROUP,AT(117,54,222,26),USE(?ColorGroup),HIDE,TRN
                               PROMPT('Color &1:'),AT(119,54),USE(?loc:Color1:Prompt),TRN
                               BOX,AT(183,54,11,10),USE(?loc:sColor1Box),COLOR(00B99D7Fh),FILL(00C08080h),LINEWIDTH(1),ROUND
                               ENTRY(@s30),AT(197,54,126,10),USE(loc:sColor1),COLOR(COLOR:White),DISABLE,READONLY,SKIP
                               BUTTON('...'),AT(327,54,11,10),USE(?Color1:Lookup),TIP('Select Main Window Background Color')
                               PROMPT('Color &2:'),AT(119,68),USE(?loc:Color2:Prompt),TRN
                               BOX,AT(183,68,11,10),USE(?loc:sColor2Box),COLOR(00B99D7Fh),FILL(COLOR:Gray),LINEWIDTH(1),ROUND
                               ENTRY(@s30),AT(197,68,126,10),USE(loc:sColor2),COLOR(COLOR:White),DISABLE,READONLY,SKIP
                               BUTTON('...'),AT(327,68,11,10),USE(?Color2:Lookup),TIP('Select Other Window Background Color')
                             END
                             GROUP,AT(117,54,222,26),USE(?WallpaperGroup),HIDE,TRN
                               PROMPT('Image1:'),AT(119,54),USE(?loc:Background1:Prompt),TRN
                               CHECK(' Tiled'),AT(154,54,27,10),USE(loc:Tiled1),TRN
                               ENTRY(@s255),AT(183,54,140,10),USE(loc:szWallpaper1),COLOR(COLOR:White)
                               BUTTON('...'),AT(327,54,11,10),USE(?Wallpaper1:LookupFile),TIP('Select Main Window Wallpaper')
                               PROMPT('Image2:'),AT(119,68),USE(?loc:szBackground2:Prompt),TRN
                               CHECK(' Tiled'),AT(154,68,27,10),USE(loc:Tiled2),TRN
                               ENTRY(@s255),AT(183,68,140,10),USE(loc:szWallpaper2),COLOR(COLOR:White)
                               BUTTON('...'),AT(327,68,11,10),USE(?Wallpaper2:LookupFile),TIP('Select Other Window Wallpaper')
                             END
                             PANEL,AT(113,81,230,1),USE(?Panel2),BEVEL(0,0,9)
                             PROMPT('Dou&bleClick Action:'),AT(119,83),USE(?loc:bForceEdit:Prompt),TRN
                             OPTION,AT(192,82,146,10),USE(loc:bForceEdit),TRN
                               RADIO(' &View'),AT(197,83,47,10),USE(?loc:bForceEdit:Radio1),TIP('Start the Ascii Filev' & |
  'iewer when double clicking on tree'),VALUE('0'),TRN
                               RADIO(' &Edit'),AT(245,83,47,10),USE(?loc:bForceEdit:Radio2),TIP('Start the Editor when' & |
  ' double clicking on tree'),VALUE('1'),TRN
                               RADIO(' &Disabled'),AT(293,83),USE(?loc:bForceEdit:Radio3),TIP('Ignore double clicking ' & |
  'on the tree'),VALUE('2'),TRN
                             END
                             PANEL,AT(113,94,230,1),USE(?Panel3),BEVEL(0,0,9)
                             CHECK(' Enable Balloon &Tips'),AT(119,96),USE(loc:bShowTips),TIP('Check to enable Ballo' & |
  'on ToolTips (requires application restart)'),TRN
                             CHECK(' &Auto Expand'),AT(119,108),USE(loc:bAutoExpand),MSG('Automatically expand the s' & |
  'elected object.'),TIP('Automatically expand the selected object.'),TRN
                             CHECK(' &Show Sparse Trees'),AT(212,96),USE(loc:bShowSparseTrees),MSG('Show direct line' & |
  'age if set otherwise show the whole family'),TIP('Show direct lineage in tree if set' & |
  ' <0DH,0AH>otherwise show the whole family'),TRN
                             CHECK(' Use &HTML Help'),AT(212,108),USE(loc:bUseHTMLHelp),TIP('Check to use HTML Help<0DH>' & |
  '<0AH>Uncheck to use Windows Help'),TRN
                             PANEL,AT(113,120,230,1),USE(?Panel3:2),BEVEL(0,0,9)
                             PROMPT('&MRU Maximum:'),AT(119,124),USE(?loc:bMaxMRU:Prompt),TRN
                             SPIN(@n02),AT(183,124,20,10),USE(loc:bMaxMRU),RIGHT,COLOR(COLOR:White),RANGE(0,99),STEP(1), |
  TIP('Maximum Number of Records for the<0DH,0AH>Recent File list on the File menu.')
                             PROMPT('&Category Drop Count:'),AT(223,124),USE(?loc:CategoryDropCount:Prompt),TRN
                             SPIN(@n02),AT(303,124,20,10),USE(loc:CategoryDropCount),RIGHT,COLOR(COLOR:White),RANGE(0,99), |
  STEP(1),TIP('Number of elements displayed in the<0DH,0AH>Category drop list on the Ma' & |
  'in window.')
                             OPTION,AT(192,154,146,10),USE(loc:Layout),TRN
                               RADIO(' Classic'),AT(197,154),USE(?loc:Layout:Radio1),VALUE('0'),TRN
                               RADIO(' Vertical'),AT(245,154),USE(?loc:Layout:Radio2),VALUE('1'),TRN
                             END
                             PROMPT('&Layout:'),AT(119,154),USE(?loc:Layout:Prompt),TRN
                             PROMPT('XML StyleSheet:'),AT(119,140),USE(?loc:szXmlStyleSheet:Prompt),TRN
                             ENTRY(@s255),AT(183,140,140,10),USE(loc:szXmlStyleSheet),COLOR(COLOR:White),DISABLE,READONLY, |
  SKIP
                             BUTTON('...'),AT(327,140,11,10),USE(?XMLStyleSheet:Lookup),TIP('Browse for an XML Style sheet.')
                             BUTTON('Fa&vorites Menu...'),AT(109,182,76,14),USE(?FavoritesMenuButton),TIP('Press this' & |
  ' button to maintain the Favorites Menu.')
                           END
                         END
                         TAB('Color Preferences'),USE(?Color:Tab)
                           GROUP,AT(113,18,230,156),USE(?ColorPreferencesGroup),BOXED,TRN
                             PROMPT('&Selected Background:'),AT(119,28,,8),USE(?glo:lSelectedBack:Prompt),TRN
                             BOX,AT(192,28,9,8),USE(?loc:sSelectedBackBox),COLOR(00B99D7Fh),FILL(COLOR:Black),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,28,120,8),USE(loc:sSelectedBack),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,28,9,8),USE(?SelectedBackColorButton),TIP('Select Listbox Selected' & |
  ' Background Color')
                             PROMPT('S&elected Foreground:'),AT(119,40,,8),USE(?glo:lSelectedFore:Prompt),TRN
                             BOX,AT(192,40,9,8),USE(?loc:sSelectedForeBox),COLOR(00B99D7Fh),FILL(COLOR:White),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,40,120,8),USE(loc:sSelectedFore),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,40,9,8),USE(?SelectedForeColorButton),TIP('Select Listbox Selected' & |
  ' Foreground Color')
                             PROMPT('&Module Color:'),AT(119,52,45,8),USE(?glo:lModuleColor:Prompt),TRN
                             BOX,AT(192,52,9,8),USE(?loc:sModuleColorBox),COLOR(00B99D7Fh),FILL(COLOR:Purple),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,52,120,8),USE(loc:sModuleColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,52,9,8),USE(?ModuleColorButton),TIP('Select Color for Module Attribute')
                             PROMPT('&Private Color:'),AT(119,64,44,8),USE(?glo:lPrivateColor:Prompt),TRN
                             BOX,AT(192,64,9,8),USE(?loc:sPrivateColorBox),COLOR(00B99D7Fh),FILL(COLOR:Red),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,64,120,8),USE(loc:sPrivateColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,64,9,8),USE(?PrivateColorButton),TIP('Select Color for Private Attribute')
                             PROMPT('P&rotected Color:'),AT(119,76,52,8),USE(?glo:lProtectedColor:Prompt),TRN
                             BOX,AT(192,76,9,8),USE(?loc:sProtectedColorBox),COLOR(00B99D7Fh),FILL(COLOR:Maroon),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,76,120,8),USE(loc:sProtectedColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,76,9,8),USE(?ProtectedColorButton),TIP('Select Color for Protected' & |
  ' Attribute')
                             PROMPT('&Virtual Color:'),AT(119,88,42,8),USE(?lVirtualColor:Prompt),TRN
                             BOX,AT(192,88,9,8),USE(?loc:sVirtualColorBox),COLOR(00B99D7Fh),FILL(COLOR:Fuchsia),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,88,120,8),USE(loc:sVirtualColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,88,9,8),USE(?VirtualColorButton),TIP('Select Color for Virtual Attribute')
                             PROMPT('&Hyperlink Color:'),AT(119,100,52,8),USE(?lHyperlinkColor:Prompt:),TRN
                             BOX,AT(192,100,9,8),USE(?loc:sHyperlinkColorBox),COLOR(00B99D7Fh),FILL(COLOR:Lime),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,100,120,8),USE(loc:sHyperlinkColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,100,9,8),USE(?HyperlinkColorButton),TIP('Select Color for Hyperlinks')
                             PROMPT('&Note Color:'),AT(119,112,36,8),USE(?lNoteColor:Prompt),TRN
                             BOX,AT(192,112,9,8),USE(?loc:sNoteColorBox),COLOR(00B99D7Fh),FILL(COLOR:White),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,112,120,8),USE(loc:sNoteColor),COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,112,9,8),USE(?NoteColor:Button),TIP('Select Note Color')
                             PROMPT('Highlight Color &1:'),AT(119,124,56,8),USE(?lHighlightColor1:Prompt),TRN
                             BOX,AT(192,124,9,8),USE(?loc:sHighlightColor1Box),COLOR(00B99D7Fh),FILL(COLOR:Blue),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,124,120,8),USE(loc:sHighlightColor1),COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,124,9,8),USE(?HighlightColor1:Button),TIP('Select Ascii Viewer hig' & |
  'hlight color 1<0DH,0AH>used to highlight the object of interest.')
                             PROMPT('Highlight Color &2:'),AT(119,136,56,8),USE(?lHighlightColor2:Prompt),FONT(,,,,CHARSET:ANSI), |
  TRN
                             BOX,AT(192,136,9,8),USE(?loc:sHighlightColor2Box),COLOR(00B99D7Fh),FILL(COLOR:Teal),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(204,136,120,8),USE(loc:sHighlightColor2),COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(329,136,9,8),USE(?HighlightColor2:Button),TIP('Select Ascii Viewer hig' & |
  'hlight color 2<0DH,0AH>used to highlight references to the <0DH,0AH>object of interest.')
                           END
                         END
                         TAB('Editor'),USE(?Editor:Tab)
                           GROUP,AT(113,18,230,156),USE(?EditorGroup),BOXED,TRN
                             CHECK(' Use Windows &Associations'),AT(117,24),USE(loc:bUseAssociation),COLOR(COLOR:BTNFACE), |
  MSG('Use Windows File Association'),TIP('Use Windows File Association'),TRN
                             PROMPT('Co&mmand Line:'),AT(117,36),USE(?loc:szEditorCommand:Prompt),TRN
                             ENTRY(@S255),AT(117,46,206,10),USE(loc:szEditorCommand),COLOR(COLOR:White),FLAT,MSG('File Edito' & |
  'r Command Line'),TIP('File Editor Command Line')
                             PROMPT('Looking for a great shareware source editor that does color coding and more?  T' & |
  'he list below contains some suggestions.  To find out more and download the latest v' & |
  'ersion for free click on the web address in the list.'),AT(191,60,137,34),USE(?Prompt14), |
  FONT('Tahoma',8,,FONT:regular,CHARSET:ANSI),TRN
                             LIST,AT(117,96,220,74),USE(?EditorList),FONT('Tahoma',8,,FONT:regular,CHARSET:ANSI),VSCROLL, |
  ALRT(MouseLeft2),COLOR(COLOR:White),FORMAT('60L(2)|M~Web Address~@s64@120L(2)~Command' & |
  ' Line Example~@s128@'),FROM(EditorQ),TIP('Double Click on Web Address to go to the w' & |
  'eb page.<0DH,0AH>Double Click on Command Line Example to paste into command line.')
                             BUTTON('...'),AT(326,46,11,10),USE(?LookupEditor),TIP('Browse for an Editor.')
                             STRING('Editor Command Macros'),AT(117,60),USE(?String3),FONT('Tahoma',8,,FONT:underline),TRN
                             STRING('%1 = Filename to edit'),AT(117,68),USE(?String4),FONT('Tahoma',8),TRN
                             STRING('%2 = Current Line'),AT(117,76),USE(?String5),FONT('Tahoma',8),TRN
                           END
                         END
                         TAB('Templates'),USE(?Templates:Tab)
                           GROUP,AT(113,18,230,156),USE(?TemplateGroup),BOXED,TRN
                             BUTTON('Class Include File Templates...'),AT(117,26,116,14),USE(?incTemplatesButton),TIP('Press this' & |
  ' button to maintain the list of inc Templates.')
                             BUTTON('Class Source File Templates...'),AT(117,44,116,14),USE(?clwTemplatesButton),TIP('Press this' & |
  ' button to maintain the list of clw Templates.')
                             BUTTON('Wrapper Generator Templates...'),AT(117,62,116,14),USE(?tplTemplatesButton),TIP('Press this' & |
  ' button to maintain the list of tpl Templates.')
                           END
                         END
                         TAB('Viewer'),USE(?Viewer:Tab)
                           GROUP,AT(113,18,230,156),USE(?ViewerGroup),BOXED,TRN
                             PROMPT('Fo&nt:'),AT(123,45),USE(?loc:StyleGroup:Font:Prompt),TRN
                             ENTRY(@s255),AT(169,45,150,10),USE(loc:szViewerFont),COLOR(COLOR:White),DISABLE,READONLY,SKIP
                             BUTTON('...'),AT(322,45,11,10),USE(?ViewerFontLookupButton),TIP('Select Application Font')
                             PROMPT('Fo&re Color:'),AT(123,59),USE(?loc:StyleGroup:Fore:Prompt),TRN
                             BOX,AT(169,59,11,10),USE(?loc:sViewerForeColorBox),COLOR(00B99D7Fh),FILL(COLOR:Red),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(182,59,137,10),USE(loc:sViewerForeColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(322,59,11,10),USE(?ViewerForeColorButton),TIP('Select Fore Color')
                             PROMPT('&Back Color:'),AT(123,73),USE(?loc:StyleGroup:Back:Prompt),TRN
                             BOX,AT(169,73,11,10),USE(?loc:sViewerBackColorBox),COLOR(00B99D7Fh),FILL(COLOR:Maroon),LINEWIDTH(1), |
  ROUND
                             ENTRY(@s30),AT(182,73,137,10),USE(loc:sViewerBackColor),LEFT,COLOR(COLOR:White),DISABLE,SKIP
                             BUTTON('...'),AT(322,73,11,10),USE(?ViewerBackColorButton),TIP('Select Back Color')
                             OPTION('&Case'),AT(123,84,210,20),USE(loc:StyleGroup:CaseOpt),BOXED,TRN
                               RADIO(' &Mixed'),AT(161,91),USE(?loc:StyleGroup:CaseOpt:Radio1),VALUE('0'),TRN
                               RADIO(' &Upper'),AT(219,91),USE(?loc:StyleGroup:CaseOpt:Radio2),VALUE('1'),TRN
                               RADIO(' &Lower'),AT(279,91),USE(?loc:StyleGroup:CaseOpt:Radio3),VALUE('2'),TRN
                             END
                             GROUP('Op&tions'),AT(123,104,210,20),USE(?OptionsGroup),BOXED,TRN
                               CHECK(' EOL &Filled'),AT(161,111),USE(loc:StyleGroup:EolFilled),TRN
                               CHECK(' &Visible'),AT(219,111),USE(loc:StyleGroup:Visible),RIGHT,TRN
                               CHECK(' &Hot Spot'),AT(279,111),USE(loc:StyleGroup:HotSpot),RIGHT,TRN
                             END
                             GROUP('Sample'),AT(123,124,210,20),USE(?SampleGroup),BOXED,TRN
                               STRING('Using Clarion to Forge Applications...'),AT(127,132,203,8),USE(?SampleText),CENTER,TRN
                             END
                             SHEET,AT(119,26,218,144),USE(?Sheet2),WIZARD
                               TAB('Default'),USE(?DefaultTab)
                                 BUTTON('&Apply Defaults'),AT(109,182,60,14),USE(?ResetButton),TIP('Apply Default Settin' & |
  'gs to All Styles.')
                                 BUTTON('Clarion &Editor'),AT(175,182,60,14),USE(?ClarionEditorButton),TIP('Retrieve col' & |
  'ors from the CxxEDT.INI file.')
                               END
                               TAB('Label'),USE(?LabelTab)
                               END
                               TAB('Comment'),USE(?CommentTab)
                               END
                               TAB('String'),USE(?StringTab)
                               END
                               TAB('Identifier'),USE(?IdentifierTab)
                               END
                               TAB('Integer Constant'),USE(?IntegerTab)
                               END
                               TAB('Real Constant'),USE(?RealTab)
                               END
                               TAB('Picture String'),USE(?PictureTab)
                               END
                               TAB('Keyword'),USE(?KeywordTab)
                               END
                               TAB('Compiler Directive'),USE(?CompilerTab)
                               END
                               TAB('Runtime Expression'),USE(?RuntimeTab)
                               END
                               TAB('BuiltIn Procedure'),USE(?BuiltInTab)
                               END
                               TAB('Structure'),USE(?StructureTab)
                               END
                               TAB('Attribute'),USE(?AttributeTab)
                               END
                               TAB('Equate'),USE(?EquateTab)
                               END
                               TAB('Error'),USE(?ErrorTab)
                               END
                               TAB('Deprecated'),USE(?DeprecatedTab)
                               END
                             END
                           END
                         END
                       END
                       BOX,AT(113,8,230,10),USE(?Heading1Box),COLOR(00743C00h),FILL(COLOR:White),LINEWIDTH(1),ROUND
                       BOX,AT(123,30,210,10),USE(?Heading2Box),COLOR(00743C00h),FILL(COLOR:White),HIDE,LINEWIDTH(1), |
  ROUND
                       BUTTON('&OK'),AT(252,182,45,14),USE(?OKButton),TIP('Save Changes and Close the Window')
                       BUTTON('Cancel'),AT(302,182,45,14),USE(?CancelButton),TIP('Ignore Changes and Close the Window')
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
Wallpaper1FileLookup SelectFileClass
Wallpaper2FileLookup SelectFileClass
FileLookup7          SelectFileClass
FileLookup10         SelectFileClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(bReturnValue)

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
  !------------------------------------
  !Style for ?TreeList
  !------------------------------------
  ?TreeList{PROPSTYLE:TextColor,STYLE:NORMAL} = COLOR:BLACK
  ?TreeList{PROPSTYLE:BackColor,STYLE:NORMAL} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:NORMAL} = glo:lSelectedFore    !COLOR:HIGHLIGHTTEXT  !COLOR:BLACK
  ?TreeList{PROPSTYLE:BackSelected,STYLE:NORMAL} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle
!---------------------------------------------------------------------------
GetColors   ROUTINE
  CASE ?Sheet2{PROP:ChoiceFeq}
  OF ?DefaultTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT + 1]
  OF ?LabelTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_LABEL + 1]
  OF ?CommentTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_COMMENT + 1]
  OF ?StringTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STRING + 1]
  OF ?IdentifierTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_USER_IDENTIFIER + 1]
  OF ?IntegerTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_INTEGER_CONSTANT + 1]
  OF ?RealTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_REAL_CONSTANT + 1]
  OF ?PictureTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_PICTURE_STRING + 1]
  OF ?KeywordTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_KEYWORD + 1]
  OF ?CompilerTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_COMPILER_DIRECTIVE + 1]
  OF ?RuntimeTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_RUNTIME_EXPRESSIONS + 1]
  OF ?BuiltInTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_BUILTIN_PROCEDURES_FUNCTION + 1]
  OF ?StructureTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STRUCTURE_DATA_TYPE + 1]
  OF ?AttributeTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_ATTRIBUTE + 1]
  OF ?EquateTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_STANDARD_EQUATE + 1]
  OF ?ErrorTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_ERROR + 1]
  OF ?DeprecatedTab
     loc:StyleGroup = loc:ViewerStyles.StyleGroup[SCE_CLW_DEPRECATED + 1]
  END
  !ThisWindow.Reset()
  EXIT
SaveColors  ROUTINE
  CASE ?Sheet2{PROP:ChoiceFeq}
  OF ?DefaultTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT + 1] = loc:StyleGroup
  OF ?LabelTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_LABEL + 1] = loc:StyleGroup
  OF ?CommentTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_COMMENT + 1] = loc:StyleGroup
  OF ?StringTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_STRING + 1] = loc:StyleGroup
  OF ?IdentifierTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_USER_IDENTIFIER + 1] = loc:StyleGroup
  OF ?IntegerTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_INTEGER_CONSTANT + 1] = loc:StyleGroup
  OF ?RealTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_REAL_CONSTANT + 1] = loc:StyleGroup
  OF ?PictureTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_PICTURE_STRING + 1] = loc:StyleGroup
  OF ?KeywordTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_KEYWORD + 1] = loc:StyleGroup
  OF ?CompilerTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_COMPILER_DIRECTIVE + 1] = loc:StyleGroup
  OF ?RuntimeTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_RUNTIME_EXPRESSIONS + 1] = loc:StyleGroup
  OF ?BuiltInTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_BUILTIN_PROCEDURES_FUNCTION + 1] = loc:StyleGroup
  OF ?StructureTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_STRUCTURE_DATA_TYPE + 1] = loc:StyleGroup
  OF ?AttributeTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_ATTRIBUTE + 1] = loc:StyleGroup
  OF ?EquateTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_STANDARD_EQUATE + 1] = loc:StyleGroup
  OF ?ErrorTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_ERROR + 1] = loc:StyleGroup
  OF ?DeprecatedTab
     loc:ViewerStyles.StyleGroup[SCE_CLW_DEPRECATED + 1] = loc:StyleGroup
  END
  EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

loc:build           CSTRING(5)
loc:Selection       BYTE
loc:Selections      BYTE
loc:CWVersions      CSTRING(256)
loc:szSection       CSTRING(32)
loc:szFileName      CSTRING(261)
loc:szXMLFileName   CSTRING(261)
cc                  LONG
I                   LONG
J                   LONG
  CODE
  GlobalErrors.SetProcedureName('winOptions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?TreeList
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  loc:szRedFilePath     = glo:szRedFilePath
  loc:bAutoExpand       = glo:bAutoExpand
  loc:lModuleColor      = glo:lModuleColor
  loc:lPrivateColor     = glo:lPrivateColor
  loc:lProtectedColor   = glo:lProtectedColor
  loc:lVirtualColor     = glo:lVirtualColor
  loc:lSelectedBack     = glo:lSelectedBack
  loc:lSelectedFore     = glo:lSelectedFore
  loc:lNoteColor        = glo:lNoteColor
  loc:lHighlightColor1  = glo:lHighlightColor1
  loc:lHighlightColor2  = glo:lHighlightColor2
  loc:lHyperlinkColor   = glo:lHyperlinkColor
  loc:bClarionVersion   = glo:bClarionVersion
  loc:bShowTips         = glo:bShowTips
  loc:bOpaqueCheckBox   = glo:bOpaqueCheckBox
  loc:bForceEdit        = glo:bForceEdit
  loc:bUseAssociation   = glo:bUseAssociation
  loc:Background        = glo:Background
  loc:Color1            = glo:Color1
  loc:Color2            = glo:Color2
  loc:szWallpaper1      = glo:szWallpaper1
  loc:szWallpaper2      = glo:szWallpaper2
  loc:Tiled1            = glo:Tiled1
  loc:Tiled2            = glo:Tiled2
  loc:Typeface          = glo:Typeface
  loc:FontSize          = glo:FontSize
  loc:FontColor         = glo:FontColor
  loc:FontStyle         = glo:FontStyle
  loc:szEditorCommand   = glo:szEditorCommand
  loc:bUseHTMLHelp      = glo:bUseHTMLHelp
  loc:szXmlStyleSheet   = glo:szXmlStyleSheet
  loc:bShowSparseTrees  = glo:bShowSparseTrees
  loc:bMaxMRU           = glo:bMaxMRU
  loc:CategoryDropCount = glo:CategoryDropCount
  loc:Layout            = glo:Layout
  FREE(Q)
  J = RECORDS(ExtraModuleQ)
  LOOP I = J TO 1 BY -1
    GET(ExtraModuleQ,I)
    Q = ExtraModuleQ
    loc:szFileName = Q.szModulePath & Q.szModuleName
    IF _access(loc:szFileName,0) = 0
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
    ELSE
       DELETE(ExtraModuleQ)
    END
  END
  
  FREE(EditorQ)
  EditorQ.szWebAddress = 'www.editplus.com'
  EditorQ.szCommandLineExample ='c:\program files\editplus 2\editplus.exe %1 -cursor %2'
  ADD(EditorQ)
  EditorQ.szWebAddress = 'www.schofieldcomputer.com/cgi-bin/download.cgi?path=/misc/&file=Ced.zip'
  EditorQ.szCommandLineExample ='c:\program files\ced\ced.exe %1 %2'
  ADD(EditorQ)
  EditorQ.szWebAddress = 'www.textpad.com'
  EditorQ.szCommandLineExample ='c:\program files\textpad 4\textpad.exe -q -am"%1"(%2)'
  ADD(EditorQ)
  EditorQ.szWebAddress = 'www.ultraedit.com'
  EditorQ.szCommandLineExample ='c:\program files\ultraedit\uedit32.exe %1 -l%2'
  ADD(EditorQ)
  
  OptionQ.Level = 1
  OptionQ.Style = 1
  OptionQ.Icon = 2
  OptionQ.szText = 'Clarion'
  OptionQ.Feq = ?Clarion:Tab
  ADD(OptionQ)
  OptionQ.Level = 1
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Application'
  OptionQ.Feq = ?Application:Tab
  ADD(OptionQ)
  OptionQ.Level = 1
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Color Preferences'
  OptionQ.Feq = ?Color:Tab
  ADD(OptionQ)
  OptionQ.Level = 1
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Editor'
  OptionQ.Feq = ?Editor:Tab
  ADD(OptionQ)
  OptionQ.Level = 1
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Templates'
  OptionQ.Feq = ?Templates:Tab
  ADD(OptionQ)
  OptionQ.Level = -1
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Viewer'
  OptionQ.Feq = ?DefaultTab   !?Viewer:Tab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Default'
  OptionQ.Feq = ?DefaultTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Label'
  OptionQ.Feq = ?LabelTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Comment'
  OptionQ.Feq = ?CommentTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'String'
  OptionQ.Feq = ?StringTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Identifier'
  OptionQ.Feq = ?IdentifierTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Integer Constant'
  OptionQ.Feq = ?IntegerTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Real Constant'
  OptionQ.Feq = ?RealTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Picture String'
  OptionQ.Feq = ?PictureTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Keyword'
  OptionQ.Feq = ?KeywordTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Compiler Directive'
  OptionQ.Feq = ?CompilerTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Runtime Expression'
  OptionQ.Feq = ?RuntimeTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'BuiltIn Procedure'
  OptionQ.Feq = ?BuiltInTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Structure'
  OptionQ.Feq = ?StructureTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Attribute'
  OptionQ.Feq = ?AttributeTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Equate'
  OptionQ.Feq = ?EquateTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Error'
  OptionQ.Feq = ?ErrorTab
  ADD(OptionQ)
  OptionQ.Level = 2
  OptionQ.Style = 1
  OptionQ.Icon = 1
  OptionQ.szText = 'Deprecated'
  OptionQ.Feq = ?DeprecatedTab
  ADD(OptionQ)
  
  Heading1 = 'Clarion'
  Heading2 = 'Default'
  GET(OptionQ,1)
  SELF.Open(Window)                                        ! Open window
  Window{PROP:Buffer} = 1
  CASE loc:Background
  OF 1  !Color
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = loc:Color2
  OF 2  !Wallpaper
     window{PROP:Wallpaper} = loc:szWallpaper2
     window{PROP:Tiled} = loc:Tiled2
     window{PROP:Color} = COLOR:NONE
  OF 3  !None
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = COLOR:NONE
  END
  ?TreeList{PROP:SELECTED} = 1
  ?TreeList{PROP:IconList,1} = '~CLSDFOLD.ICO'
  ?TreeList{PROP:IconList,2} = '~OPENFOLD.ICO'
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       loc:szSection = 'Clarion for Windows V2.0'
       loc:szRedFileName = '\bin\cw20.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 2'
    OF CWVERSION_C4
       loc:szSection = 'Clarion 4'
       loc:szRedFileName = '\bin\clarion4.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 4'
    OF CWVERSION_C5
       loc:szSection = 'Clarion 5'
       loc:szRedFileName = '\bin\clarion5.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 5'
    OF CWVERSION_C5EE
       loc:szSection = 'Clarion 5  Enterprise Edition'
       loc:szRedFileName = '\bin\clarion5.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 5 EE'
    OF CWVERSION_C55
       loc:szSection = 'Clarion 5.5'
       loc:szRedFileName = '\bin\c55pe.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 5.5'
    OF CWVERSION_C55EE
       loc:szSection = 'Clarion 5.5  Enterprise Edition'
       loc:szRedFileName = '\bin\c55ee.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 5.5 EE'
    OF CWVERSION_C60
       loc:szSection = 'Clarion 6.0'
       loc:szRedFileName = '\bin\c60pe.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 6.0'
    OF CWVERSION_C60EE
       loc:szSection = 'Clarion 6.0  Enterprise Edition'
       loc:szRedFileName = '\bin\c60ee.red'
       ?Clarion:Tab{PROP:Text} = 'Clarion 6.0 EE'
    OF CWVERSION_C70
       loc:szSection = 'Clarion 7.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) = loc:build
             loc:szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
       ?Clarion:Tab{PROP:Text} = glo:VersionQ.VersionName   !'Clarion 7.0'
    OF CWVERSION_C80
       loc:szSection = 'Clarion 8.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) = loc:build
             loc:szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
       ?Clarion:Tab{PROP:Text} = glo:VersionQ.VersionName   !'Clarion 8.0'
    OF CWVERSION_C90
       loc:szSection = 'Clarion 9.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) = loc:build
             loc:szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
       ?Clarion:Tab{PROP:Text} = glo:VersionQ.VersionName   !'Clarion 9.0'
  
    OF CWVERSION_C100
       loc:szSection = 'Clarion 10.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
             END
          END
       END
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) = loc:build
             loc:szRedFileName = '\' & glo:VersionQ.RedFile
             BREAK
          END
       END
       ?Clarion:Tab{PROP:Text} = glo:VersionQ.VersionName   !'Clarion 10.0'
  
  END
  
  IF glo:bClarionVersion < CWVERSION_C70
     loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
     IF loc:szRoot[LEN(loc:szRoot)] = '\'
        loc:szRoot[LEN(loc:szRoot)] = '<0>'                                 !remove trailing backslash
     END
     IF glo:szRedFilePath
        loc:szRedFilePath = glo:szRedFilePath
     ELSE
        loc:szRedFilePath = loc:szRoot & loc:szRedFileName
     END
  ELSE
     loc:szRoot = glo:VersionQ.Root
     IF glo:szRedFilePath
        loc:szRedFilePath = glo:szRedFilePath
     ELSE
        loc:szRedFilePath = glo:VersionQ.RedDir & loc:szRedFileName
     END
  END
  PathCompactPathEx(loc:szCompactRedFilePath, loc:szRedFilePath, SIZE(loc:szCompactRedFilePath),0)
  
  
  loc:ViewerStyles = glo:ViewerStyles
  DO GetColors
  Do DefineListboxStyle
  loc:szEditorCommand::OrigWndProc = ?loc:szEditorCommand{Prop:WndProc}           ! Save address OF code that handles window messages
  ?loc:szEditorCommand{Prop:WndProc} = ADDRESS(loc:szEditorCommand::WndProc)      ! Re-assign address OF code that handles window messages
  
  TreeList::OrigWndProc = ?TreeList{Prop:WndProc}           ! Save address OF code that handles window messages
  ?TreeList{Prop:WndProc} = ADDRESS(TreeList::WndProc)      ! Re-assign address OF code that handles window messages
  
  Wallpaper1FileLookup.Init
  Wallpaper1FileLookup.ClearOnCancel = True
  Wallpaper1FileLookup.Flags=BOR(Wallpaper1FileLookup.Flags,FILE:LongName) ! Allow long filenames
  Wallpaper1FileLookup.SetMask('Windows Bitmaps (*.bmp)','*.bmp') ! Set the file mask
  Wallpaper1FileLookup.AddMask('GIF files','*.GIF')        ! Add additional masks
  Wallpaper1FileLookup.AddMask('Icons (*.ico)','*.ICO')    ! Add additional masks
  Wallpaper1FileLookup.AddMask('JPEG files (*.jpg)','*.JPG') ! Add additional masks
  Wallpaper1FileLookup.AddMask('PCX files','*.PCX')        ! Add additional masks
  Wallpaper1FileLookup.AddMask('Windows Metafiles (*.wmf)','*.WMF') ! Add additional masks
  Wallpaper1FileLookup.AddMask('All files','*.*')          ! Add additional masks
  Wallpaper1FileLookup.WindowTitle='Select Wallpaper 1'
  Wallpaper2FileLookup.Init
  Wallpaper2FileLookup.ClearOnCancel = True
  Wallpaper2FileLookup.Flags=BOR(Wallpaper2FileLookup.Flags,FILE:LongName) ! Allow long filenames
  Wallpaper2FileLookup.SetMask('Windows Bitmaps (*.bmp)','*.BMP') ! Set the file mask
  Wallpaper2FileLookup.AddMask('GIF files','*.GIF')        ! Add additional masks
  Wallpaper2FileLookup.AddMask('Icons (*.ico)','*.ico')    ! Add additional masks
  Wallpaper2FileLookup.AddMask('JPEG files (*.jpg)','*.JPG') ! Add additional masks
  Wallpaper2FileLookup.AddMask('PCX files','*.pcx')        ! Add additional masks
  Wallpaper2FileLookup.AddMask('Windows Metafiles (*.wmf)','*.WMF') ! Add additional masks
  Wallpaper2FileLookup.AddMask('All files','*.*')          ! Add additional masks
  Wallpaper2FileLookup.WindowTitle='Select Wallpaper 2'
  FileLookup7.Init
  FileLookup7.ClearOnCancel = True
  FileLookup7.Flags=BOR(FileLookup7.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup7.SetMask('Programs (*.exe)','*.exe')          ! Set the file mask
  FileLookup7.AddMask('All Files (*.*)','*.*')             ! Add additional masks
  FileLookup7.WindowTitle='Select Editor'
  FileLookup10.Init
  FileLookup10.ClearOnCancel = True
  FileLookup10.Flags=BOR(FileLookup10.Flags,FILE:LongName) ! Allow long filenames
  FileLookup10.Flags=BOR(FileLookup10.Flags,FILE:NoError)  ! doesn't report errors if the file does exist on Save... or does not exist on Open
  FileLookup10.SetMask('All Files','*.*')                  ! Set the file mask
  FileLookup10.DefaultFile='abcview.xsl'
  FileLookup10.WindowTitle='Select XML StyleSheet'
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINOPTIONS'
  IF glo:bClarionVersion > CWVERSION_C60EE
     subFolder = 'win\'
  ELSE
     subFolder = ''
  END
  
  DISABLE(?loc:bEquates,?loc:bWindows)
  LOOP I = 1 TO 8
    CASE I
    OF 1
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'equates.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bEquates{PROP:Disable} = FALSE
       END
    OF 2
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'errors.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bErrors{PROP:Disable} = FALSE
       END
    OF 3
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'property.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bProperty{PROP:Disable} = FALSE
       END
    OF 4
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'prnprop.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bPrnProp{PROP:Disable} = FALSE
       END
    OF 5
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'keycodes.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bKeycodes{PROP:Disable} = FALSE
       END
    OF 6
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'tplequ.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bTplEqu{PROP:Disable} = FALSE
       END
    OF 7
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'winequ.clw'
       IF _access(loc:szFileName,0) = 0
          ?loc:bWinEqu{PROP:Disable} = FALSE
       END
    OF 8
       loc:szFileName = loc:szRoot & '\libsrc\' & subFolder & 'windows.inc'
       IF _access(loc:szFileName,0) = 0
          ?loc:bWindows{PROP:Disable} = FALSE
       END
    END
  END
  
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Edit_Options.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM')
        oHH.SetTopic('Edit_Options.htm')
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  IF loc:szEditorCommand::OrigWndProc
     ?loc:szEditorCommand{Prop:WndProc} = loc:szEditorCommand::OrigWndProc        ! Restore the handler for this window
  END
  
  IF TreeList::OrigWndProc
     ?TreeList{Prop:WndProc} = TreeList::OrigWndProc        ! Restore the handler for this window
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

  CODE
  PARENT.Open
  hwndTT = tt.init(Window{PROP:HANDLE},1)                  !ToolTipClass Initialization
  IF hwndTT
     tt.addtip(?AdditionalFilesButton{PROP:HANDLE},?AdditionalFilesButton{PROP:TIP},0)
     ?AdditionalFilesButton{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?loc:szCompactRedFilePath{PROP:HANDLE},?loc:szCompactRedFilePath{PROP:TIP},0)
     tt.addtip(?LookupRedPath:Button{PROP:HANDLE},?LookupRedPath:Button{PROP:TIP},0)
     ?LookupRedPath:Button{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?FontLookupButton{PROP:HANDLE},?FontLookupButton{PROP:TIP},0)
     ?FontLookupButton{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?loc:Background{PROP:HANDLE},?loc:Background{PROP:TIP},0)
     ?loc:Background{PROP:TIP} = ''                        ! Clear tip property to avoid two tips
     tt.addtip(?Color1:Lookup{PROP:HANDLE},?Color1:Lookup{PROP:TIP},0)
     ?Color1:Lookup{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?Color2:Lookup{PROP:HANDLE},?Color2:Lookup{PROP:TIP},0)
     ?Color2:Lookup{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?Wallpaper1:LookupFile{PROP:HANDLE},?Wallpaper1:LookupFile{PROP:TIP},0)
     ?Wallpaper1:LookupFile{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?Wallpaper2:LookupFile{PROP:HANDLE},?Wallpaper2:LookupFile{PROP:TIP},0)
     ?Wallpaper2:LookupFile{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?SelectedBackColorButton{PROP:HANDLE},?SelectedBackColorButton{PROP:TIP},0)
     ?SelectedBackColorButton{PROP:TIP} = ''               ! Clear tip property to avoid two tips
     tt.addtip(?SelectedForeColorButton{PROP:HANDLE},?SelectedForeColorButton{PROP:TIP},1)
     ?SelectedForeColorButton{PROP:TIP} = ''               ! Clear tip property to avoid two tips
     tt.addtip(?ModuleColorButton{PROP:HANDLE},?ModuleColorButton{PROP:TIP},0)
     ?ModuleColorButton{PROP:TIP} = ''                     ! Clear tip property to avoid two tips
     tt.addtip(?PrivateColorButton{PROP:HANDLE},?PrivateColorButton{PROP:TIP},0)
     ?PrivateColorButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?ProtectedColorButton{PROP:HANDLE},?ProtectedColorButton{PROP:TIP},0)
     ?ProtectedColorButton{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?VirtualColorButton{PROP:HANDLE},?VirtualColorButton{PROP:TIP},0)
     ?VirtualColorButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?NoteColor:Button{PROP:HANDLE},?NoteColor:Button{PROP:TIP},0)
     ?NoteColor:Button{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?HighlightColor1:Button{PROP:HANDLE},?HighlightColor1:Button{PROP:TIP},1)
     ?HighlightColor1:Button{PROP:TIP} = ''                ! Clear tip property to avoid two tips
     tt.addtip(?HighlightColor2:Button{PROP:HANDLE},?HighlightColor2:Button{PROP:TIP},1)
     ?HighlightColor2:Button{PROP:TIP} = ''                ! Clear tip property to avoid two tips
     tt.addtip(?loc:szEditorCommand{PROP:HANDLE},?loc:szEditorCommand{PROP:TIP},0)
     ?loc:szEditorCommand{PROP:TIP} = ''                   ! Clear tip property to avoid two tips
     tt.addtip(?loc:bShowTips{PROP:HANDLE},?loc:bShowTips{PROP:TIP},1)
     ?loc:bShowTips{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?loc:bUseAssociation{PROP:HANDLE},?loc:bUseAssociation{PROP:TIP},0)
     ?loc:bUseAssociation{PROP:TIP} = ''                   ! Clear tip property to avoid two tips
     tt.addtip(?OKButton{PROP:HANDLE},?OKButton{PROP:TIP},0)
     ?OKButton{PROP:TIP} = ''                              ! Clear tip property to avoid two tips
     tt.addtip(?CancelButton{PROP:HANDLE},?CancelButton{PROP:TIP},0)
     ?CancelButton{PROP:TIP} = ''                          ! Clear tip property to avoid two tips
     tt.addtip(?loc:bForceEdit:Radio1{PROP:HANDLE},?loc:bForceEdit:Radio1{PROP:TIP},0)
     ?loc:bForceEdit:Radio1{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?loc:bForceEdit:Radio2{PROP:HANDLE},?loc:bForceEdit:Radio2{PROP:TIP},0)
     ?loc:bForceEdit:Radio2{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?loc:bAutoExpand{PROP:HANDLE},?loc:bAutoExpand{PROP:TIP},0)
     ?loc:bAutoExpand{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
     tt.addtip(?HyperlinkColorButton{PROP:HANDLE},?HyperlinkColorButton{PROP:TIP},0)
     ?HyperlinkColorButton{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?EditorList{PROP:HANDLE},?EditorList{PROP:TIP},1)
     ?EditorList{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?loc:bUseHTMLHelp{PROP:HANDLE},?loc:bUseHTMLHelp{PROP:TIP},1)
     ?loc:bUseHTMLHelp{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?loc:szXmlStyleSheet{PROP:HANDLE},?loc:szXmlStyleSheet{PROP:TIP},0)
     tt.addtip(?XMLStyleSheet:Lookup{PROP:HANDLE},?XMLStyleSheet:Lookup{PROP:TIP},0)
     ?XMLStyleSheet:Lookup{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?FavoritesMenuButton{PROP:HANDLE},?FavoritesMenuButton{PROP:TIP},0)
     ?FavoritesMenuButton{PROP:TIP} = ''                   ! Clear tip property to avoid two tips
     tt.addtip(?incTemplatesButton{PROP:HANDLE},?incTemplatesButton{PROP:TIP},0)
     ?incTemplatesButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?clwTemplatesButton{PROP:HANDLE},?clwTemplatesButton{PROP:TIP},0)
     ?clwTemplatesButton{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?ViewerFontLookupButton{PROP:HANDLE},?ViewerFontLookupButton{PROP:TIP},0)
     ?ViewerFontLookupButton{PROP:TIP} = ''                ! Clear tip property to avoid two tips
     tt.addtip(?ViewerForeColorButton{PROP:HANDLE},?ViewerForeColorButton{PROP:TIP},0)
     ?ViewerForeColorButton{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?ViewerBackColorButton{PROP:HANDLE},?ViewerBackColorButton{PROP:TIP},0)
     ?ViewerBackColorButton{PROP:TIP} = ''                 ! Clear tip property to avoid two tips
     tt.addtip(?loc:bShowSparseTrees{PROP:HANDLE},?loc:bShowSparseTrees{PROP:TIP},1)
     ?loc:bShowSparseTrees{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?loc:bMaxMRU{PROP:HANDLE},?loc:bMaxMRU{PROP:TIP},1)
     ?loc:bMaxMRU{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.SetTipTextColor(8388608)
  END


ThisWindow.Reset PROCEDURE(BYTE Force=0)

I   LONG,AUTO
J   LONG,AUTO
  CODE
  CASE loc:Background
  OF 1  !Color
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = loc:Color2
     HIDE(?WallpaperGroup)
     UNHIDE(?ColorGroup)
  OF 2  !Wallpaper
     window{PROP:Wallpaper} = loc:szWallpaper2
     window{PROP:Tiled} = loc:Tiled2
     window{PROP:Color} = COLOR:NONE
     HIDE(?ColorGroup)
     UNHIDE(?WallpaperGroup)
  OF 3  !None
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = COLOR:NONE
     HIDE(?ColorGroup)
     HIDE(?WallpaperGroup)
  END
  
  ! 2003.12.18 RR - Not Needed
  !IF loc:FontSize > 10
  !   ?Sheet1{PROP:Join} = TRUE
  !ELSE
  !   ?Sheet1{PROP:Join} = FALSE
  !END
  
  J = LASTFIELD()
  LOOP I = 0 TO J
     CASE I
     OF ?String3 OROF ?String4 OROF ?String5 OROF ?EditorList |
     OROF ?Heading1 OROF ?Heading2
        !Do Nothing
     OF ?Prompt14 !OROF ?TreeList
        SETFONT(I,loc:Typeface,8,loc:FontColor,loc:FontStyle,0)
  
     OF ?StandardEquateGroup
        SETFONT(I,loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
        !XPStandardEquateGroup.FontName = loc:Typeface
        !XPStandardEquateGroup.FontSize = loc:FontSize
     OF ?OptionsGroup
        SETFONT(I,loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
        !XPOptionsGroup.FontName = loc:Typeface
        !XPOptionsGroup.FontSize = loc:FontSize
     OF ?SampleGroup
        SETFONT(I,loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
        !XPSampleGroup.FontName = loc:Typeface
        !XPSampleGroup.FontSize = loc:FontSize
     OF ?loc:StyleGroup:CaseOpt
        SETFONT(I,loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
        !XPloc:StyleGroup:CaseOpt.FontName = loc:Typeface
        !XPloc:StyleGroup:CaseOpt.FontSize = loc:FontSize
     ELSE
        SETFONT(I,loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
     END
  END
  
  loc:sFontColor = srcGetColorString(loc:FontColor)
  
  loc:szFont = CLIP(loc:Typeface) & ',' & loc:FontSize & ','
  IF BAND(loc:FontStyle,0FFFh) >= FONT:bold
     loc:szFont = loc:szFont & 'Bold,'
  ELSIF BAND(loc:FontStyle,0FFFh) >= FONT:regular
     loc:szFont = loc:szFont & 'Regular,'
  ELSE
     loc:szFont = loc:szFont & 'Thin,'
  END
  IF BAND(loc:FontStyle,FONT:italic) = FONT:italic
     loc:szFont = loc:szFont & 'Italic,'
  END
  IF BAND(loc:FontStyle,FONT:underline) = FONT:underline
     loc:szFont = loc:szFont & 'Underline,'
  END
  IF BAND(loc:FontStyle,FONT:strikeout) = FONT:strikeout
     loc:szFont = loc:szFont & 'Strikeout,'
  END
  loc:szFont = loc:szFont & CLIP(srcGetColorString(loc:FontColor))
  
  loc:sColor1          = srcGetColorString(loc:Color1)
  loc:sColor2          = srcGetColorString(loc:Color2)
  
  ?loc:sColor1Box{PROP:Fill} = loc:Color1
  ?loc:sColor2Box{PROP:Fill} = loc:Color2
  
  loc:sModuleColor     = srcGetColorString(loc:lModuleColor)
  loc:sPrivateColor    = srcGetColorString(loc:lPrivateColor)
  loc:sProtectedColor  = srcGetColorString(loc:lProtectedColor)
  loc:sVirtualColor    = srcGetColorString(loc:lVirtualColor)
  loc:sHyperlinkColor  = srcGetColorString(loc:lHyperlinkColor)
  loc:sSelectedBack    = srcGetColorString(loc:lSelectedBack)
  loc:sSelectedFore    = srcGetColorString(loc:lSelectedFore)
  loc:sNoteColor       = srcGetColorString(loc:lNoteColor)
  loc:sHighlightColor1 = srcGetColorString(loc:lHighlightColor1)
  loc:sHighlightColor2 = srcGetColorString(loc:lHighlightColor2)
  
  ?loc:sModuleColorBox{PROP:Fill}     = loc:lModuleColor
  ?loc:sPrivateColorBox{PROP:Fill}    = loc:lPrivateColor
  ?loc:sProtectedColorBox{PROP:Fill}  = loc:lProtectedColor
  ?loc:sVirtualColorBox{PROP:Fill}    = loc:lVirtualColor
  ?loc:sHyperlinkColorBox{PROP:Fill}  = loc:lHyperlinkColor
  ?loc:sSelectedBackBox{PROP:Fill}    = loc:lSelectedBack
  ?loc:sSelectedForeBox{PROP:Fill}    = loc:lSelectedFore
  ?loc:sNoteColorBox{PROP:Fill}       = loc:lNoteColor
  ?loc:sHighlightColor1Box{PROP:Fill} = loc:lHighlightColor1
  ?loc:sHighlightColor2Box{PROP:Fill} = loc:lHighlightColor2
  
  IF loc:bUseAssociation
     DISABLE(?loc:szEditorCommand:Prompt,?loc:szEditorCommand)
  ELSE
     ENABLE(?loc:szEditorCommand:Prompt,?loc:szEditorCommand)
  END
  
  !Viewer Options
  !======================================================================================
  loc:szViewerFont = CLIP(loc:StyleGroup.Font) & ',' & loc:StyleGroup.FontSize & ','
  IF BAND(loc:StyleGroup.FontStyle,0FFFh) >= FONT:bold
     loc:szViewerFont = loc:szViewerFont & 'Bold,'
     loc:StyleGroup.Bold = TRUE
  ELSIF BAND(loc:StyleGroup.FontStyle,0FFFh) >= FONT:regular
     loc:szViewerFont = loc:szViewerFont & 'Regular,'
     loc:StyleGroup.Bold = FALSE
  ELSE
     loc:szViewerFont = loc:szViewerFont & 'Thin,'
     loc:StyleGroup.Bold = FALSE
  END
  IF BAND(loc:StyleGroup.FontStyle,FONT:italic) = FONT:italic
     loc:szViewerFont = loc:szViewerFont & 'Italic,'
     loc:StyleGroup.Italic = TRUE
  ELSE
     loc:StyleGroup.Italic = FALSE
  END
  IF BAND(loc:StyleGroup.FontStyle,FONT:underline) = FONT:underline
     loc:szViewerFont = loc:szViewerFont & 'Underline,'
     loc:StyleGroup.Underline = TRUE
  ELSE
     loc:StyleGroup.Underline = FALSE
  END
  !IF BAND(loc:StyleGroup.FontStyle,FONT:strikeout) = FONT:strikeout
  !   loc:szViewerFont = loc:szViewerFont & 'Strikeout'
  !END
  !loc:szViewerFont = loc:szViewerFont & CLIP(srcGetColorString(loc:StyleGroup.Fore))
  IF loc:szViewerFont[LEN(loc:szViewerFont)] = ','
     loc:szViewerFont[LEN(loc:szViewerFont)] = '<0>'
  END
  
  ?loc:sViewerForeColorBox{PROP:Fill} = loc:StyleGroup.Fore
  loc:sViewerForeColor = srcGetColorString(loc:StyleGroup.Fore)
  
  ?loc:sViewerBackColorBox{PROP:Fill} = loc:StyleGroup.Back
  loc:sViewerBackColor = srcGetColorString(loc:StyleGroup.Back)
  
  ?SampleText{PROP:FontColor} = loc:StyleGroup.Fore
  ?SampleText{PROP:Color} = loc:StyleGroup.Back
  ?SampleText{PROP:Font} = loc:StyleGroup.Font
  ?SampleText{PROP:FontSize} = loc:StyleGroup.FontSize
  ?SampleText{PROP:FontStyle} = loc:StyleGroup.FontStyle
  CASE loc:StyleGroup:CaseOpt
  OF 0
     ?SampleText{PROP:Text} = 'Using Clarion to forge applications!'
  OF 1
     ?SampleText{PROP:Text} = 'USING CLARION TO FORGE APPLICATIONS!'
  OF 2
     ?SampleText{PROP:Text} = 'using clarion to forge applications!'
  END
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  PARENT.Reset(Force)


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
I           LONG
J           LONG
msgButton   LONG
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?loc:bEquates
      Q.szModuleName = CLIP(LEFT(?{PROP:Text}))
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Q.szModulePath = loc:szRoot & '\LIBSRC\' & subFolder
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
      Window{PROP:Hide} = TRUE
      winAdditionalFiles(Q,loc:bClarionVersion)
      Window{PROP:Hide} = FALSE
      ThisWindow.Reset()
    OF ?LookupRedPath:Button
      ThisWindow.Update()
       IF ~FILEDIALOG('Select Redirection File',loc:szRedFilePath,'Redrection File (*.RED)|*.RED|All Files (*.*)|*.*',File:KeepDir+File:LongName)
          IF glo:szRedFilePath
             loc:szRedFilePath = glo:szRedFilePath
          ELSE
             IF glo:bClarionVersion < CWVERSION_C70
                loc:szRedFilePath = loc:szRoot & loc:szRedFileName
             ELSE
                loc:szRedFilePath = glo:VersionQ.RedDir & loc:szRedFileName
             END
          END
       END
       PathCompactPathEx(loc:szCompactRedFilePath, loc:szRedFilePath, SIZE(loc:szCompactRedFilePath),0)
       DISPLAY(?loc:szCompactRedFilePath)
    OF ?FontLookupButton
      ThisWindow.Update()
      IF FONTDIALOG('Choose Display Font',loc:Typeface,loc:FontSize,loc:FontColor,loc:FontStyle,0)
         ThisWindow.Reset()
      END
    OF ?loc:Background
      CASE loc:Background
      OF 1  !Color
         loc:bOpaqueCheckBox = TRUE
      OF 2  !Wallpaper
         loc:bOpaqueCheckBox = FALSE
      OF 3  !None
         loc:bOpaqueCheckBox = TRUE
      END
      ThisWindow.Reset()
    OF ?Color1:Lookup
      ThisWindow.Update()
      COLORDIALOG('Background Color 1',loc:Color1)
      ThisWindow.Reset()
    OF ?Color2:Lookup
      ThisWindow.Update()
      COLORDIALOG('Background Color 2',loc:Color2)
      window{PROP:Color} = glo:Color2
      ThisWindow.Reset()
    OF ?loc:Tiled1
      ThisWindow.Reset()
    OF ?Wallpaper1:LookupFile
      ThisWindow.Update()
      Wallpaper1FileLookup.DefaultDirectory = ''
      Wallpaper1FileLookup.DefaultFile = ''
      J = LEN(loc:szWallpaper1)
      LOOP I = J TO 1 BY -1
         IF loc:szWallpaper1[I] = '\'
            Wallpaper1FileLookup.DefaultDirectory = loc:szWallpaper1[1 : I]
            Wallpaper1FileLookup.DefaultFile = loc:szWallpaper1[I+1 : J]
            BREAK
         END
      END
      loc:szWallpaper1 = Wallpaper1FileLookup.Ask(1)
      DISPLAY
      IF ~loc:szWallpaper1
         loc:szWallpaper1 = Wallpaper1FileLookup.DefaultDirectory & Wallpaper1FileLookup.DefaultFile
         DISPLAY(?loc:szWallpaper1)
      END
    OF ?loc:Tiled2
      ThisWindow.Reset()
    OF ?loc:szWallpaper2
      window{PROP:Wallpaper} = loc:szWallpaper2
      window{PROP:Tiled} = loc:Tiled2
    OF ?Wallpaper2:LookupFile
      ThisWindow.Update()
      Wallpaper2FileLookup.DefaultDirectory = ''
      Wallpaper2FileLookup.DefaultFile = ''
      J = LEN(loc:szWallpaper2)
      LOOP I = J TO 1 BY -1
         IF loc:szWallpaper2[I] = '\'
            Wallpaper2FileLookup.DefaultDirectory = loc:szWallpaper2[1 : I]
            Wallpaper2FileLookup.DefaultFile = loc:szWallpaper2[I+1 : J]
            BREAK
         END
      END
      loc:szWallpaper2 = Wallpaper2FileLookup.Ask(1)
      DISPLAY
      IF loc:szWallpaper2
         window{PROP:Wallpaper} = loc:szWallpaper2
         window{PROP:Tiled} = loc:Tiled2
      ELSE
         loc:szWallpaper2 = Wallpaper2FileLookup.DefaultDirectory & Wallpaper2FileLookup.DefaultFile
         DISPLAY(?loc:szWallpaper2)
      END
    OF ?XMLStyleSheet:Lookup
      ThisWindow.Update()
      loc:szXmlStyleSheet = FileLookup10.Ask(1)
      DISPLAY
    OF ?FavoritesMenuButton
      ThisWindow.Update()
      winFavoritesMenu(FavoritesQ)
    OF ?SelectedBackColorButton
      ThisWindow.Update()
      COLORDIALOG('Selected Back Color',loc:lSelectedBack)
      ThisWindow.Reset()
    OF ?SelectedForeColorButton
      ThisWindow.Update()
      COLORDIALOG('Selected Back Color',loc:lSelectedFore)
      ThisWindow.Reset()
    OF ?ModuleColorButton
      ThisWindow.Update()
      COLORDIALOG('Module Attribute Color',loc:lModuleColor)
      ThisWindow.Reset()
    OF ?PrivateColorButton
      ThisWindow.Update()
      COLORDIALOG('Private Attribute Color',loc:lPrivateColor)
      ThisWindow.Reset()
    OF ?ProtectedColorButton
      ThisWindow.Update()
      COLORDIALOG('Protected Attribute Color',loc:lProtectedColor)
      ThisWindow.Reset()
    OF ?VirtualColorButton
      ThisWindow.Update()
      COLORDIALOG('Virtual Method Color',loc:lVirtualColor)
      ThisWindow.Reset()
    OF ?HyperlinkColorButton
      ThisWindow.Update()
      COLORDIALOG('Hyperlink Color',loc:lHyperlinkColor)
      ThisWindow.Reset()
    OF ?NoteColor:Button
      ThisWindow.Update()
      COLORDIALOG('Note Color',loc:lNoteColor)
      ThisWindow.Reset()
    OF ?HighlightColor1:Button
      ThisWindow.Update()
      COLORDIALOG('Highlight Color 1',loc:lHighlightColor1)
      ThisWindow.Reset()
    OF ?HighlightColor2:Button
      ThisWindow.Update()
      COLORDIALOG('Highlight Color 2',loc:lHighlightColor2)
      ThisWindow.Reset()
    OF ?loc:bUseAssociation
      ThisWindow.Reset()
    OF ?LookupEditor
      ThisWindow.Update()
      sav:szEditorCommand = loc:szEditorCommand
      loc:szEditorCommand = FileLookup7.Ask(1)
      DISPLAY
      IF ~loc:szEditorCommand
         loc:szEditorCommand = sav:szEditorCommand
         DISPLAY(?loc:szEditorCommand)
      END
    OF ?incTemplatesButton
      ThisWindow.Update()
      winTemplateFiles(incTemplateQ,'Class Include File Templates')
    OF ?clwTemplatesButton
      ThisWindow.Update()
      winTemplateFiles(clwTemplateQ,'Class Source File Templates')
    OF ?tplTemplatesButton
      ThisWindow.Update()
      winTemplateFiles(tplTemplateQ,'Wrapper Generator Templates')
    OF ?ViewerFontLookupButton
      ThisWindow.Update()
      IF FONTDIALOG('Choose Font',loc:StyleGroup.Font,loc:StyleGroup.FontSize,loc:StyleGroup.Fore,loc:StyleGroup.FontStyle,0)
         ThisWindow.Reset()
      END
    OF ?ViewerForeColorButton
      ThisWindow.Update()
      COLORDIALOG('Fore Color',loc:StyleGroup.Fore)
      ThisWindow.Reset()
    OF ?ViewerBackColorButton
      ThisWindow.Update()
      COLORDIALOG('Back Color',loc:StyleGroup.Back)
      ThisWindow.Reset()
    OF ?loc:StyleGroup:CaseOpt
      ThisWindow.Reset()
    OF ?ResetButton
      ThisWindow.Update()
      CASE MESSAGE('What defaults do you want to apply?','Apply Defaults',ICON:QUESTION, |
                   '&Font|&Background|&All|Cancel',4)
      OF 1
         loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1] = loc:StyleGroup
         LOOP I = 2 TO SCE_CLW_LAST
            loc:ViewerStyles.StyleGroup[I].Font = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].Font
            loc:ViewerStyles.StyleGroup[I].FontSize = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].FontSize
            loc:ViewerStyles.StyleGroup[I].FontStyle = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].FontStyle
            loc:ViewerStyles.StyleGroup[I].Bold = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].Bold
            loc:ViewerStyles.StyleGroup[I].Italic = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].Italic
            loc:ViewerStyles.StyleGroup[I].Underline = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].Underline
         END
      OF 2
         loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1] = loc:StyleGroup
         LOOP I = 2 TO SCE_CLW_LAST
            loc:ViewerStyles.StyleGroup[I].Back = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1].Back
         END
      OF 3
         loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1] = loc:StyleGroup
         LOOP I = 2 TO SCE_CLW_LAST
            loc:ViewerStyles.StyleGroup[I] = loc:ViewerStyles.StyleGroup[SCE_CLW_DEFAULT+1]
         END
      OF 4
      END
    OF ?ClarionEditorButton
      ThisWindow.Update()
      IF glo:bClarionVersion < CWVERSION_C70
         CASE MESSAGE('What Clarion Editor Colors do you want to load?','Clarion Editor',ICON:QUESTION, |
                      '&Current|&Default|Cancel',3)
         OF 1
            DO SaveColors
            srcGetCedtColors(loc:ViewerStyles,FALSE)
            DO GetColors
            SELF.Reset()
         OF 2
            DO SaveColors
            srcGetCedtColors(loc:ViewerStyles,TRUE)
            DO GetColors
            SELF.Reset()
         OF 3
         END
      ELSE
         CASE MESSAGE('What Clarion Editor Colors do you want to load?','Clarion Editor',ICON:QUESTION, |
                      '&Current|Cancel',2)
         OF 1
            DO SaveColors
            srcGetCedtColors(loc:ViewerStyles,FALSE)
            DO GetColors
            SELF.Reset()
         OF 2
         END
      END
    OF ?OKButton
      ThisWindow.Update()
      DO SaveColors
      IF glo:lModuleColor       <> loc:lModuleColor      OR |
         glo:lPrivateColor      <> loc:lPrivateColor     OR |
         glo:lProtectedColor    <> loc:lProtectedColor   OR |
         glo:lVirtualColor      <> loc:lVirtualColor     OR |
         glo:lHyperlinkColor    <> loc:lHyperlinkColor   OR |
         glo:lSelectedBack      <> loc:lSelectedBack     OR |
         glo:lSelectedFore      <> loc:lSelectedFore     OR |
         glo:lNoteColor         <> loc:lNoteColor        OR |
         glo:lHighlightColor1   <> loc:lHighlightColor1  OR |
         glo:lHighlightColor2   <> loc:lHighlightColor2  OR |
         glo:bShowTips          <> loc:bShowTips         OR |
         glo:bOpaqueCheckBox    <> loc:bOpaqueCheckBox   OR |
         glo:bForceEdit         <> loc:bForceEdit        OR |
         glo:bUseAssociation    <> loc:bUseAssociation   OR |
         glo:Background         <> loc:Background        OR |
         glo:Color1             <> loc:Color1            OR |
         glo:Color2             <> loc:Color2            OR |
         glo:szWallpaper1       <> loc:szWallpaper1      OR |
         glo:szWallpaper2       <> loc:szWallpaper2      OR |
         glo:Tiled1             <> loc:Tiled1            OR |
         glo:Tiled2             <> loc:Tiled2            OR |
         glo:Typeface           <> loc:Typeface          OR |
         glo:FontSize           <> loc:FontSize          OR |
         glo:FontColor          <> loc:FontColor         OR |
         glo:FontStyle          <> loc:FontStyle         OR |
         glo:bUseHTMLHelp       <> loc:bUseHTMLHelp      OR |
         glo:szXmlStyleSheet    <> loc:szXmlStyleSheet   OR |
         glo:ViewerStyles       <> loc:ViewerStyles      OR |
         glo:bShowSparseTrees   <> loc:bShowSparseTrees  OR |
         glo:bMaxMRU            <> loc:bMaxMRU           OR |
         glo:CategoryDropCount  <> loc:CategoryDropCount OR |
         glo:Layout             <> loc:Layout
         bReturnValue = 1 !Color Change
      ELSE
         bReturnValue = 0 !No Change
      END
      
      glo:szRedFilePath     = loc:szRedFilePath
      glo:bAutoExpand       = loc:bAutoExpand
      glo:lModuleColor      = loc:lModuleColor
      glo:lPrivateColor     = loc:lPrivateColor
      glo:lProtectedColor   = loc:lProtectedColor
      glo:lVirtualColor     = loc:lVirtualColor
      glo:lHyperlinkColor   = loc:lHyperlinkColor
      glo:lSelectedBack     = loc:lSelectedBack
      glo:lSelectedFore     = loc:lSelectedFore
      glo:lNoteColor        = loc:lNoteColor
      glo:lHighlightColor1  = loc:lHighlightColor1
      glo:lHighlightColor2  = loc:lHighlightColor2
      !glo:bClarionVersion   = loc:bClarionVersion
      glo:bShowTips         = loc:bShowTips
      glo:bOpaqueCheckBox   = loc:bOpaqueCheckBox
      glo:bForceEdit        = loc:bForceEdit
      glo:bUseAssociation   = loc:bUseAssociation
      glo:Background        = loc:Background
      glo:Color1            = loc:Color1
      glo:Color2            = loc:Color2
      glo:szWallpaper1      = loc:szWallpaper1
      glo:szWallpaper2      = loc:szWallpaper2
      glo:Tiled1            = loc:Tiled1
      glo:Tiled2            = loc:Tiled2
      glo:Typeface          = loc:Typeface
      glo:FontSize          = loc:FontSize
      glo:FontColor         = loc:FontColor
      glo:FontStyle         = loc:FontStyle
      glo:szEditorCommand   = loc:szEditorCommand
      glo:bUseHTMLHelp      = loc:bUseHTMLHelp
      glo:szXmlStyleSheet   = loc:szXmlStyleSheet
      glo:ViewerStyles      = loc:ViewerStyles
      glo:bShowSparseTrees  = loc:bShowSparseTrees
      glo:bMaxMRU           = loc:bMaxMRU
      glo:CategoryDropCount = loc:CategoryDropCount
      glo:Layout            = loc:Layout
      
      INIMgr.Update('Options','Module Color',glo:lModuleColor)
      INIMgr.Update('Options','Private Color',glo:lPrivateColor)
      INIMgr.Update('Options','Protected Color',glo:lProtectedColor)
      INIMgr.Update('Options','Virtual Color',glo:lVirtualColor)
      INIMgr.Update('Options','Selected Color',glo:lSelectedBack)
      INIMgr.Update('Options','Selected Text',glo:lSelectedFore)
      INIMgr.Update('Options','Note Color',glo:lNoteColor)
      INIMgr.Update('Options','Highlight Color 1',glo:lHighlightColor1)
      INIMgr.Update('Options','Highlight Color 2',glo:lHighlightColor2)
      INIMgr.Update('Options','Hyperlink Color',glo:lHyperlinkColor)
      INIMgr.Update('Options','Clarion Version',glo:bClarionVersion)
      INIMgr.Update('Options','ABC Only',glo:bABCOnly)
      INIMgr.Update('Options','Show Module',glo:bShowModule)
      INIMgr.Update('Options','Show Private',glo:bShowPrivate)
      INIMgr.Update('Options','Show Protected',glo:bShowProtected)
      INIMgr.Update('Options','Current View',glo:bCurrentView)
      INIMgr.Update('Options','Show Tips',glo:bShowTips)
      INIMgr.Update('Options','Opaque Check Box',glo:bOpaqueCheckBox)
      INIMgr.Update('Options','Force Edit',glo:bForceEdit)
      INIMgr.Update('Options','Use Association',glo:bUseAssociation)
      INIMgr.Update('Options','Editor Command',glo:szEditorCommand)
      INIMgr.Update('Options','Background',glo:Background)
      INIMgr.Update('Options','Color 1',glo:Color1)
      INIMgr.Update('Options','Color 2',glo:Color2)
      INIMgr.Update('Options','Wallpaper 1',glo:szWallpaper1)
      INIMgr.Update('Options','Wallpaper 2',glo:szWallpaper2)
      INIMgr.Update('Options','Tiled 1',glo:Tiled1)
      INIMgr.Update('Options','Tiled 2',glo:Tiled2)
      INIMgr.Update('Options','Typeface',glo:Typeface)
      INIMgr.Update('Options','FontSize',glo:FontSize)
      INIMgr.Update('Options','FontColor',glo:FontColor)
      INIMgr.Update('Options','FontStyle',glo:FontStyle)
      INIMgr.Update('Options','DetailLevel',glo:bDetailLevel)
      INIMgr.Update('Options','Category',glo:szCategory)
      INIMgr.Update('Options','CategoryDropCount',glo:CategoryDropCount)
      INIMgr.Update('Options','Current Directory',glo:szCurrentDir)
      INIMgr.Update('Options','RED File Path ' & glo:bClarionVersion,glo:szRedFilePath)
      INIMgr.Update('Options','AutoExpand',glo:bAutoExpand)
      INIMgr.Update('Options','UseHTMLHelp',glo:bUseHTMLHelp)
      INIMgr.Update('Options','XmlStyleSheet',glo:szXmlStyleSheet)
      INIMgr.Update('Options','EnumSort',glo:bEnumSort)
      INIMgr.Update('Options','ShowSparseTrees',glo:bShowSparseTrees)
      INIMgr.Update('Options','MaxMRU',glo:bMaxMRU)
      INIMgr.Update('Splitter','Layout',glo:Layout)
      
      FREE(ExtraModuleQ)
      J = RECORDS(Q)
      LOOP I = 1 TO J
        GET(Q,I)
        ExtraModuleQ = Q
        ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
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

I              LONG,AUTO
J              LONG,AUTO
MouseDownRow   LONG,AUTO
Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  CASE FIELD()
  OF ?Sheet2
    CASE EVENT()
    OF EVENT:TabChanging
?      MESSAGE('we should not be here!')
       DO SaveColors
    END
  END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?TreeList
    CASE EVENT()
    OF EVENT:Expanded
      OptionQ.Icon = 1
      PUT(OptionQ)
      MouseDownRow = ?TreeList{PROPLIST:MouseDownRow}
      GET(OptionQ,MouseDownRow)
      OptionQ.Level = 1
      OptionQ.Icon = 2
      PUT(OptionQ)
      J = RECORDS(OptionQ)
      LOOP I = 1 TO J
        GET(OptionQ,I)
        IF OptionQ.szText = Heading2
           BREAK
        END
      END
      IF I > J
         I = 1
         GET(OptionQ,I)
      END
      ?TreeList{PROP:Selected} = I
      POST(EVENT:NewSelection,?TreeList)
    OF EVENT:Contracted
      OptionQ.Icon = 1
      PUT(OptionQ)
      MouseDownRow = ?TreeList{PROPLIST:MouseDownRow}
      GET(OptionQ,MouseDownRow)
      OptionQ.Level = -1
      OptionQ.Icon = 1
      PUT(OptionQ)
    END
  OF ?EditorList
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft2
         CASE ?EditorList{PROPLIST:MouseDownField}
         OF 1
            GET(EditorQ,CHOICE(?EditorList))
            IF SUB(EditorQ.szWebAddress,-4,1) = '.'
               szURL = 'http://' & EditorQ.szWebAddress
            ELSE
               szURL = 'http://' & EditorQ.szWebAddress & '/'
            END
            szNull = ''
            ShellExecute(window{prop:handle},0,szURL,0,szNull,1)
         OF 2
            GET(EditorQ,CHOICE(?EditorList))
            loc:szEditorCommand = EditorQ.szCommandLineExample
            DISPLAY(?loc:szEditorCommand)
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

I   LONG,AUTO
J   LONG,AUTO
Looped BYTE
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE FIELD()
    OF ?Sheet2
      DO GetColors
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?TreeList
      DO SaveColors
      OptionQ.Icon = 1
      PUT(OptionQ)
      GET(OptionQ,CHOICE(?TreeList))
      SELECT(OptionQ.Feq)
      CASE ABS(OptionQ.Level)
      OF 1
        Heading1 = OptionQ.szText
        IF Heading1 = 'Viewer' AND OptionQ.Level = 1
           J = RECORDS(OptionQ)
           LOOP I = CHOICE(?TreeList)+1 TO J
             GET(OptionQ,I)
             IF OptionQ.szText = Heading2
                BREAK
             END
           END
           IF I > J
              I = 1
              GET(OptionQ,I)
           END
           ?TreeList{PROP:Selected} = I
        END
      OF 2
        Heading1 = 'Viewer'
        Heading2 = OptionQ.szText
      END
      
      IF OptionQ.Level > 0
         OptionQ.Icon = 2
         PUT(OptionQ)
      END
      
      IF ?Viewer:Tab{PROP:VISIBLE}
         ?Heading2Box{PROP:Hide} = FALSE
         ?Heading2{PROP:Hide} = FALSE
      ELSE
         ?Heading2Box{PROP:Hide} = TRUE
         ?Heading2{PROP:Hide} = TRUE
      END
      SELECT(?TreeList)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!========================================================================================
loc:szEditorCommand::WndProc PROCEDURE(HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam)
!========================================================================================

    CODE
    CASE wMsg
    END
    RETURN(CallWindowProc(loc:szEditorCommand::OrigWndProc,hWnd,wMsg,wParam,lParam))

!========================================================================================
TreeList::WndProc PROCEDURE(HWND hWnd, UINT wMsg, WPARAM wParam, LPARAM lParam)
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
       rVal = CallWindowProc(TreeList::OrigWndProc,hWnd,wMsg,wParam,lParam)
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
    RETURN(CallWindowProc(TreeList::OrigWndProc,hWnd,wMsg,wParam,lParam))

