

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
   INCLUDE('csciviewer.inc'),ONCE

lMouseX   LONG
lMouseY   LONG
!!! <summary>
!!! Generated from procedure template - Window
!!! Clarion Class Viewer
!!! </summary>
Main PROCEDURE 

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
SPLITTERHEIGHT  EQUATE(8)
PANELMINIMUMX   EQUATE(75)
Splitter1_XPos  LONG
Splitter2_XPos  LONG
Splitter2_YPos  LONG
ListWithFocus   LONG(-1)
oHH           &tagHTMLHelp
  COMPILE('***',_Scintilla_)
!==========================================================!
!ToolTip for Scintilla Viewer                              !
!==========================================================!
Viewer_tt            ToolTipClass                          !
hwndViewer_TT        HWND                                  !
!==========================================================!
! ***
FilesOpened          BYTE                                  ! 
I                    LONG                                  ! 
J                    LONG                                  ! 
K                    LONG                                  ! 
MyParent             LIKE(ClassQ.szClassName)              ! 
FldEqu               LONG                                  ! 
szClassViewDatafile  CSTRING('ClassView.DAT<0>{242}')      ! 
lLatchControl        LONG                                  ! 
sClassTip            CSTRING('View Class Hierarchy')       ! 
sStructureTip        CSTRING('View Structures')            ! 
sEquateTip           CSTRING('View Equates')               ! 
sOptionsTip          CSTRING('Edit User Preferences')      ! 
szSubKey             CSTRING(255)                          ! 
szValueName          CSTRING(255)                          ! 
szValue              CSTRING(255)                          ! 
hKeyExtension        ULONG                                 ! 
pType                ULONG                                 ! 
pData                ULONG                                 ! 
RetVal               LONG                                  ! 
ViewerThreadQ        QUEUE(THREADQTYPE),PRE()              ! 
                     END                                   ! 
CategoryQueue        QUEUE(CATEGORYQUEUETYPE),PRE(CategoryQueue) ! 
                     END                                   ! 
bViewClasses         BYTE                                  ! 
bViewInterfaces      BYTE                                  ! 
bViewCallTree        BYTE                                  ! 
bViewStructures      BYTE                                  ! 
bViewEquates         BYTE                                  ! 
szObjectName         CSTRING(61)                           ! 
HistoryQueue         QUEUE,PRE(HistoryQueue)               ! 
ObjectName           CSTRING(31)                           ! 
ObjectView           BYTE                                  ! 
lObjectDropListPointer LONG                                ! 
bProtected           BYTE                                  ! 
bModule              BYTE                                  ! 
bPrivate             BYTE                                  ! 
szText               LIKE(TreeQ.szText)                    ! 
                     END                                   ! 
lHistoryPointer      LONG                                  ! 
bHyperLinking        BYTE                                  ! 
szObjectType         CSTRING(11)                           ! 
szCommandLine        CSTRING(256),AUTO                     ! 
FileClarion100       BYTE                                  ! 
FileClarion110       BYTE                                  ! 
FileClarion90        BYTE                                  ! 
FileClarion80        BYTE                                  ! 
FileClarion70        BYTE                                  ! 
FileClarion60EE      BYTE                                  ! 
FileClarion60        BYTE                                  ! 
FileClarion55EE      BYTE                                  ! 
FileClarion55        BYTE                                  ! 
FileClarion50EE      BYTE                                  ! 
FileClarion50        BYTE                                  ! 
FileClarion40        BYTE                                  ! 
FileClarion20        BYTE                                  ! 
bTrackMouse          BYTE                                  ! 
bCount               BYTE                                  ! Timer Tick Count
bDetailNewSelection  BYTE                                  ! 
bCurrentDetailLevel  BYTE                                  ! 
LocatorQ             QUEUE,PRE(lq)                         ! 
character            STRING(1)                             ! 
                     END                                   ! 
loc:ForceSmartScan   BYTE                                  ! 
Viewer               kcrAsciiViewerClass                   ! 
ViewerActive         BYTE                                  ! 
lFirstFavoriteMenuFeq LONG                                 ! 
lLastFavoriteMenuFeq LONG                                  ! 
loc:szViewerStyle    CSTRING(256)                          ! 
loc:szAsciiFilename  LIKE(szAsciiFilename)                 ! 
loc:ObjectCount      STRING(15)                            ! 
bAddToClarionMenu    BYTE                                  ! Show 'Add to Clarion Menu' on help menu if true
lFirstMRUMenuFeq     LONG
lLastMRUMenuFeq      LONG

locator              IncrementalLocatorClass
szLocator            LIKE(ClassNameQ.szClassName)

bc                   &BrowseClass
TreeStateQ           QUEUE,PRE(TSQ)
szClassName          LIKE(ClassQ.szClassName)
state                  BYTE,DIM(1000)                       !room for 8000 queue entries
                     END

AsciiFilename        STRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
AsciiFile            FILE,DRIVER('ASCII'),NAME(AsciiFilename),PRE(A1),THREAD
RECORD                RECORD,PRE()
TextLine                STRING(255)
                      END
                     END

bEnableFolding       BYTE(TRUE)
Window               WINDOW('ClassViewer'),AT(,,318,228),FONT('Microsoft Sans Serif',10,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,TILED,ALRT(EscKey),ALRT(F5Key),ALRT(PlusKey),ALRT(MinusKey),ALRT(BSKey),ALRT(SpaceKey), |
  ALRT(CtrlF5),CENTER,ICON('abcview.ico'),GRAY,IMM,MAX,PALETTE(256),SYSTEM,TIMER(10),WALLPAPER('WALLPAPER.GIF')
                       MENUBAR,USE(?MenuBar)
                         MENU('&File'),USE(?File)
                           ITEM('Clarion &11'),USE(FileClarion110),CHECK
                           ITEM('Clarion &10'),USE(FileClarion100),CHECK
                           ITEM('Clarion &9'),USE(FileClarion90),CHECK
                           ITEM('Clarion &8'),USE(FileClarion80),CHECK
                           ITEM('Clarion &7'),USE(FileClarion70),CHECK
                           ITEM('Clarion &6.0 EE'),USE(FileClarion60EE),CHECK
                           ITEM('Clarion &6.0'),USE(FileClarion60),CHECK
                           ITEM('Clarion &5.5 EE'),USE(FileClarion55EE),CHECK
                           ITEM('Clarion &5.5'),USE(FileClarion55),CHECK
                           ITEM('&Clarion 5.0 EE'),USE(FileClarion50EE),CHECK
                           ITEM('&Clarion 5.0'),USE(FileClarion50),CHECK
                           ITEM('Clarion &4.0'),USE(FileClarion40),CHECK
                           ITEM('Clarion &2.0'),USE(FileClarion20),CHECK
                           ITEM,USE(?SEPARATOR1),SEPARATOR
                           MENU('&Recent'),USE(?FileRecent)
                           END
                           ITEM,USE(?SEPARATOR2),SEPARATOR
                           ITEM('E&xit'),USE(?FileExit)
                         END
                         MENU('&Tree'),USE(?Tree)
                           ITEM('E&xpand All<09H>    Ctrl+Grey Plus'),USE(?TreeExpand),LEFT(16),KEY(CtrlPlus),ICON('expand.ico')
                           ITEM('C&ontract All<09H>    Ctrl+Grey Minus'),USE(?TreeContract),LEFT(16),KEY(CtrlMinus),ICON('contract.ico')
                           ITEM,USE(?SEPARATOR3),SEPARATOR
                           ITEM('&Expand Branch<09H>    Grey Plus'),USE(?TreeExpandBranch),LEFT(16),KEY(PlusKey)
                           ITEM('&Contract Branch<09H>    Grey Minus'),USE(?TreeContractBranch),LEFT(16),KEY(MinusKey)
                           ITEM,USE(?SEPARATOR4),SEPARATOR
                         END
                         MENU('&View'),USE(?View)
                           ITEM('C&lasses    <09H>Ctrl+L'),USE(bViewClasses),LEFT(16),KEY(CtrlL),CHECK,ICON('class.ico')
                           ITEM('&Interfaces<09H>Ctrl+I'),USE(bViewInterfaces),LEFT(16),KEY(CtrlI),CHECK,ICON('intrface.ico')
                           ITEM('Call &Tree<09H>Ctrl+T'),USE(bViewCallTree),LEFT(16),KEY(CtrlT),CHECK,ICON('tree.ico')
                           ITEM('Str&uctures<09H>Ctrl+U'),USE(bViewStructures),LEFT(16),KEY(CtrlU),CHECK,ICON('structyp.ico')
                           ITEM('&Equates    <09H>Ctrl+E'),USE(bViewEquates),LEFT(16),KEY(CtrlE),CHECK,ICON('efolder.ico')
                           ITEM,USE(?SEPARATOR5),SEPARATOR
                           ITEM('&Definition<09H>Ctrl+Enter'),USE(?ViewSource),LEFT(16),KEY(CtrlEnter),ICON('data.ico')
                           ITEM('&Help        <09H>Ctrl+H'),USE(?ViewHelp),LEFT(16),KEY(CtrlH),ICON('help.ico')
                           ITEM('&Notes    <09H>Ctrl+N'),USE(?ViewNotes),LEFT(16),KEY(CtrlN),ICON('note.ico')
                         END
                         MENU('T&ools'),USE(?Tools)
                           ITEM('&Options...<09H> {14}Ctrl+O'),AT(,,80),USE(?ToolsOptions),LEFT(16),KEY(CtrlO),ICON('options.ico')
                           ITEM('&Refresh Tree<09H> {14}Ctrl+R'),AT(,,80),USE(?ToolsRefreshTree),LEFT(16),KEY(CtrlR), |
  ICON('refresh.ico')
                           ITEM('Add Class &Wizard<09H>Ctrl+W'),AT(,,80),USE(?ToolsAddClassWizard),LEFT(16),KEY(CtrlW), |
  ICON('classwiz.ico')
                           ITEM('&Browse Database<09H>Ctrl+B'),AT(,,80),USE(?ToolsBrowseDatabase),LEFT(16),KEY(CtrlB), |
  ICON('BrowseDatabase.ico')
                           ITEM('&Statistics<09H> {14}Ctrl+S'),USE(?ToolsStatistics),LEFT(16),KEY(CtrlS),ICON('stats.ico')
                           ITEM('&Calculator<09H> {14}Ctrl+Shift+C'),USE(?ToolsCalculator),LEFT(16),KEY(CtrlShiftC),ICON('calc.ico')
                           ITEM,USE(?SEPARATOR6),SEPARATOR
                           MENU('Fa&vorites'),USE(?ToolsFavorites),LEFT(16)
                             ITEM('&Edit Favorites...'),USE(?ToolsFavoritesAddtoFavorites)
                           END
                           ITEM('&Find Notes<09H> {14}Ctrl+F'),USE(?ToolsFindNotes),LEFT(16),KEY(CtrlF)
                           ITEM('Clear Histor&y<09H> {14}Ctrl+Y'),AT(,,80),USE(?ToolsClearHistory),LEFT(16),KEY(CtrlY), |
  DISABLE
                           ITEM('Add to Clarion &Menu'),USE(?HelpAddtoClarionMenu),LEFT(16),ICON('cw.ico')
                           ITEM,USE(?SEPARATOR7),SEPARATOR
                           MENU('&XML Export'),USE(?ToolsXMLExport),LEFT(16)
                             ITEM('&Database to XML'),USE(?FileExportToXML)
                             ITEM('&Tree to XML'),USE(?TreeExportToXML)
                           END
                         END
                         MENU('&Help'),USE(?HelpMenu),MSG('Windows Help')
                           ITEM('&Contents'),USE(?HelpContents),LEFT(16),ICON('HelpContents.ico'),MSG('View the co' & |
  'ntents of the help file')
                           ITEM('&Search for Help On...'),USE(?HelpSearch),LEFT(16),MSG('Search for help on a subject'), |
  STD(STD:HelpSearch)
                           ITEM('&How to Use Help'),USE(?HelpOnHelp),LEFT(16),MSG('How to use Windows Help'),STD(STD:HelpOnHelp)
                           ITEM,USE(?SEPARATOR8),SEPARATOR
                           ITEM('&About Class Viewer'),USE(?HelpAboutClassViewer),LEFT(16),ICON('Help.ICO')
                           ITEM('Just the FA&Qs'),USE(?HelpJusttheFAQs),LEFT(16),ICON('RedPin.ico')
                         END
                       END
                       PANEL,AT(0,0,,0),USE(?Panel4),FULL,BEVEL(0,0,2048)
                       IMAGE('toolbar.bmp'),AT(0,0,,14),USE(?Image13),FULL
                       PANEL,AT(0,14,,14),USE(?Panel4:2),FULL,BEVEL(0,0,2048),FILL(00E2A981h)
                       PANEL,AT(0,28,,2),USE(?Panel4:3),FULL,BEVEL(0,0,2048)
                       LIST,AT(8,32,100,174),USE(?ObjectDropList),FONT(,,COLOR:INACTIVECAPTION,,CHARSET:ANSI),LEFT(2), |
  VSCROLL,ALRT(MouseRight),ALRT(EnterKey),COLOR(COLOR:White,COLOR:White,COLOR:INACTIVECAPTION), |
  FORMAT('252L(2)|T@s63@'),FROM(ClassQ)
                       BUTTON,AT(4,1,12,12),USE(?ExpandButton),ICON('expand.ico'),FLAT,SKIP,TIP('Expand Tree')
                       BUTTON,AT(18,1,12,12),USE(?ContractButton),ICON('contract.ico'),FLAT,SKIP,TIP('Contract Tree')
                       PANEL,AT(32,1,2,12),USE(?Panel5),BEVEL(0,0,24576)
                       REGION,AT(108,32,2,192),USE(?SplitterBar),IMM
                       BUTTON,AT(35,1,12,12),USE(?ClassRegion),ICON('class.ico'),FLAT,SKIP,TIP('View Classes')
                       BUTTON,AT(49,1,12,12),USE(?InterfaceRegion),ICON('intrface.ico'),FLAT,SKIP,TIP('View Interfaces')
                       BUTTON,AT(63,1,12,12),USE(?TreeRegion),ICON('tree.ico'),FLAT,SKIP,TIP('View Method Call Tree')
                       BUTTON,AT(77,1,12,12),USE(?StructureRegion),ICON('structyp.ico'),FLAT,SKIP,TIP('View Structures')
                       BUTTON,AT(91,1,12,12),USE(?EquateRegion),ICON('efolder.ico'),FLAT,SKIP,TIP('View Equates')
                       PANEL,AT(105,1,2,12),USE(?Panel2),BEVEL(0,0,24576)
                       BUTTON,AT(108,1,12,12),USE(?ViewSourceButton),ICON('data.ico'),FLAT,SKIP,TIP('View Source File')
                       BUTTON,AT(122,1,12,12),USE(?HelpButton),ICON('help.ico'),FLAT,SKIP,TIP('View Clarion Help')
                       BUTTON,AT(136,1,12,12),USE(?ViewNoteButton),ICON('note.ico'),FLAT,SKIP,TIP('View Progra' & |
  'mmer Notes')
                       PANEL,AT(150,1,2,12),USE(?Panel3),BEVEL(0,0,24576)
                       BUTTON,AT(153,1,12,12),USE(?OptionsButton),ICON('options.ico'),FLAT,SKIP,TIP('Edit Appli' & |
  'cation Options')
                       BUTTON,AT(167,1,12,12),USE(?RefreshButton),ICON('refresh.ico'),FLAT,SKIP,TIP('Refresh Tree')
                       BUTTON,AT(181,1,12,12),USE(?AddClassWizardButton),ICON('classwiz.ico'),FLAT,SKIP,TIP('Add Class Wizard')
                       BUTTON,AT(195,1,12,12),USE(?CallTreeButton),ICON('BrowseDatabase.ico'),FLAT,SKIP,TIP('Browse Database')
                       PANEL,AT(209,1,2,12),USE(?Panel6),BEVEL(0,0,24576)
                       PROMPT('&Category:'),AT(8,17,31,8),USE(?glo:szCategory:Prompt),TRN
                       LIST,AT(41,16,52,10),USE(glo:szCategoryChoice),LEFT(2),VSCROLL,DROP(20),FORMAT('80L(2)@s20@'), |
  FROM(CategoryQueue),TIP('Select Category Filter')
                       PROMPT('&Detail:'),AT(116,17,24,8),USE(?glo:bDetailLevel:Prompt),TRN
                       SPIN(@n3),AT(142,16,14,10),USE(glo:bDetailLevel),CENTER,COLOR(COLOR:White),RANGE(0,9),STEP(1), |
  TIP('Select Detail Level')
                       PANEL,AT(108,14,2,14),USE(?SplitterBar:2),BEVEL(0,0,20640)
                       BUTTON,AT(264,2,10,10),USE(?HyperlinkButton),ICON('REDO.ICO'),DISABLE,FLAT,TIP('Hyperlink')
                       BUTTON,AT(276,2,10,10),USE(?PrevHyperlink),ICON('LEFTXP16.ICO'),DISABLE,FLAT,TIP('Move to Pr' & |
  'evious Hyperlink')
                       BUTTON,AT(288,2,10,10),USE(?NextHyperlink),ICON('RIGHTXP16.ICO'),DISABLE,FLAT,TIP('Move to Ne' & |
  'xt Hyperlink')
                       LIST,AT(300,2,10,10),USE(?HistoryList),VSCROLL,COLOR(COLOR:White),DISABLE,DROP(10),FLAT,FORMAT('120L(2)~Hy' & |
  'perlink History~@s30@'),FROM(HistoryQueue),TIP('HyperLink History')
                       LIST,AT(110,32,200,98),USE(?TreeList),FONT(,,COLOR:INACTIVECAPTION,,CHARSET:ANSI),VSCROLL, |
  ALRT(MouseRight),ALRT(MouseLeft2),COLOR(COLOR:White,COLOR:White,COLOR:INACTIVECAPTION),FORMAT('8L|IP@p p@' & |
  '250LIYPTS(1024)@s255@'),FROM(TreeQ),TIP('Double Click to Open.')
                       LIST,AT(110,133,200,74),USE(?AsciiBox),FONT('Courier New',9,,FONT:regular,CHARSET:ANSI),VSCROLL, |
  ALRT(MouseLeft2),COLOR(COLOR:White),IMM
                       TEXT,AT(110,133,200,74),USE(?sciControl:Region),BOXED
                       STRING(@s255),AT(110,158,154,6),USE(loc:szAsciiFilename),FONT('Tahoma',7,COLOR:Black,FONT:regular, |
  CHARSET:ANSI),LEFT,TRN
                       REGION,AT(110,130,200,2),USE(?VerticalSplitter),IMM
                       IMAGE('pick.ico'),AT(8,207,10,8),USE(?LocatorImage),CENTERED
                       STRING(''),AT(18,207,100),USE(?locator),FONT('Tahoma',8,,FONT:regular,CHARSET:ANSI),LEFT(2), |
  TRN
                       BOX,AT(8,216,10,8),USE(?VirtualBox),COLOR(00B99D7Fh),FILL(COLOR:Fuchsia),HIDE,LINEWIDTH(1), |
  ROUND
                       STRING('Virtual'),AT(20,215),USE(?VirtualString),TRN
                       BOX,AT(56,216,10,8),USE(?ProtectedBox),COLOR(00B99D7Fh),FILL(COLOR:Maroon),HIDE,LINEWIDTH(1), |
  ROUND
                       STRING('Protected'),AT(68,215),USE(?ProtectedString),TRN
                       BOX,AT(108,216,10,8),USE(?PrivateBox),COLOR(00B99D7Fh),FILL(COLOR:Red),HIDE,LINEWIDTH(1),ROUND
                       STRING('Private'),AT(120,215),USE(?PrivateString),TRN
                       BOX,AT(152,216,10,8),USE(?ModuleBox),COLOR(00B99D7Fh),FILL(COLOR:Purple),HIDE,LINEWIDTH(1), |
  ROUND
                       STRING('Module'),AT(164,215),USE(?ModuleString),TRN
                       CHECK('Sparse Tree'),AT(213,2,50,10),USE(glo:bShowSparseTrees),HIDE
                       CHECK(' Pro&tected'),AT(160,17,44,8),USE(glo:bShowProtected),COLOR(00E2A981h),TIP('Show Prote' & |
  'cted Attributes'),TRN
                       CHECK(' &Private'),AT(210,17,36,8),USE(glo:bShowPrivate),COLOR(00E2A981h),TIP('Show Priva' & |
  'te Attributes'),TRN
                       CHECK(' &Module'),AT(260,17,36,8),USE(glo:bShowModule),COLOR(00E2A981h),TIP('Show Modul' & |
  'e Attributes'),TRN
                       BOX,AT(8,216,10,8),USE(?EquateBox),COLOR(00B99D7Fh),FILL(COLOR:White),HIDE,LINEWIDTH(1),ROUND
                       IMAGE('efolder.ico'),AT(8,216,10,8),USE(?Equate:Image),CENTERED,HIDE
                       STRING('Grouped'),AT(20,215),USE(?GroupdEquate:String),HIDE,TRN
                       BOX,AT(56,216,10,8),USE(?EnumerationBox),COLOR(00B99D7Fh),FILL(COLOR:White),HIDE,LINEWIDTH(1), |
  ROUND
                       IMAGE('efolder2.ico'),AT(56,216,10,8),USE(?Enumeration:Image),CENTERED,HIDE
                       STRING('Enumerated'),AT(68,215),USE(?EnumeratedEquate:String),HIDE,TRN
                       STRING('Loading...'),AT(196,211,66,14),USE(?LoadingString),FONT('Tahoma',16,COLOR:Navy,FONT:bold, |
  CHARSET:ANSI),TRN
                       STRING('Saving...'),AT(196,211,66,14),USE(?SavingString),FONT('Tahoma',16,COLOR:Navy,FONT:bold, |
  CHARSET:ANSI),HIDE,TRN
                       BUTTON,AT(179,211,14,14),USE(?VcrTop),ICON('VCRFIRST.ICO')
                       BUTTON,AT(193,211,14,14),USE(?VcrRewind),ICON('VCRPRIOR.ICO')
                       BUTTON,AT(207,211,14,14),USE(?VcrBack),ICON('VCRUP.ICO')
                       BUTTON,AT(221,211,14,14),USE(?VcrPlay),ICON('VCRDOWN.ICO')
                       BUTTON,AT(235,211,14,14),USE(?VcrFastForward),ICON('VCRNEXT.ICO')
                       BUTTON,AT(249,211,14,14),USE(?VcrBottom),ICON('VCRLAST.ICO')
                       BUTTON('E&xit'),AT(266,211,45,14),USE(?CloseButton),TIP('Exit the ClassViewer Application')
                       GROUP,AT(30,76,258,58),USE(?RefreshGroup),HIDE
                         BOX,AT(32,78,258,58),USE(?Box5),COLOR(COLOR:Black),FILL(COLOR:Black),LINEWIDTH(1)
                         BOX,AT(30,76,258,58),USE(?Panel7),COLOR(COLOR:Blue),FILL(COLOR:BTNFACE),LINEWIDTH(1)
                         STRING('Building Class Hierarchy'),AT(34,80,252,10),USE(?ProcessString),FONT(,,,FONT:bold, |
  CHARSET:ANSI),CENTER,TRN
                         STRING('Scanning:'),AT(34,119,252,10),USE(?ScanString),CENTER,TRN
                         STRING(@n_4),AT(241,119),USE(glo:lLineNum),HIDE,TRN
                         PANEL,AT(59,91,202,16),USE(?Panel8),BEVEL(-1,-1),FILL(00C8FFFFh)
                         PANEL,AT(59,109,202,6),USE(?Panel8:2),BEVEL(-1,-1),FILL(00C8FFFFh)
                         IMAGE('progress.gif'),AT(60,92,0,14),USE(?ProgressBox),TILED
                         IMAGE('sm_progress.gif'),AT(60,110,0,4),USE(?ProgressBox:2),TILED
                       END
                       IMAGE('tcorner.gif'),AT(311,220),USE(?SizeGrip)
                     END

XML_Queue          QUEUE,PRE(XML)
ClassName            CSTRING(64)
ParentClassName      CSTRING(64)
DeclarationPath      CSTRING(256)
DeclarationLine      LONG
DefinitionPath       CSTRING(256)
IsABCClass           CSTRING(6)
IsInterface          CSTRING(6)
Private              CSTRING(6)
                   END

szClarionKeywords    CSTRING(4096)
szCompilerDirectives CSTRING(4096)
szBuiltinProcsFuncs  CSTRING(4096)
szStructDataTypes    CSTRING(4096)
szAttributes         CSTRING(4096)
szStandardEquates    CSTRING(4096)

sav:TreeQ:szText     LIKE(TreeQ.szText)

MRU_Queue   QUEUE,PRE(MRU_Queue)
szName        CSTRING(64)
szSortName    CSTRING(64)
szObjectType  CSTRING(10)
MenuFeq       LONG
            END

lFirstControlFeq    LONG
lLastControlFeq     LONG
CtrlQueue    QUEUE,PRE(CtrlQueue)
ControlFeq        LONG  !the button
MenuFeq           LONG  !corresponding menu option
                END

bSyncView       BYTE(FALSE)
bSizeOnMaximize BYTE(FALSE)

szIniFile       STRING(256),STATIC
IniFile         FILE,DRIVER('ASCII'),NAME(szIniFile)
IniRecord         RECORD
IniBuffer           STRING(256)
                  END
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
TakeNewSelection       PROCEDURE(),BYTE,PROC,DERIVED
TakeSelected           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
HasFocus               BYTE
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
Resize                 PROCEDURE(),BYTE,PROC,DERIVED
                     END

SciControl           CLASS(CSciViewer)                     ! Scintilla using ?sciControl:Region
Colourise              PROCEDURE(LONG lStart,LONG lEnd),DERIVED
FindWindowTakeCloseWindow PROCEDURE(),DERIVED
FindWindowTakeOpenWindow PROCEDURE(),DERIVED
Init                   PROCEDURE(*WINDOW W,LONG feq,UNSIGNED id,BOOL Themed = 0),BYTE,DERIVED
OpenFile               PROCEDURE(*CSTRING szFileName),BOOL,PROC,DERIVED
SetBuffer              PROCEDURE(),DERIVED
TakeEvent              PROCEDURE(),BYTE,DERIVED
TakeOpenWindow         PROCEDURE(),BYTE,DERIVED
                     END

  COMPILE('***',_Scintilla_)
bControlInitialised  BOOL(FALSE)
  !***
szLastClassName      CSTRING(64)
szLastCallName       CSTRING(64)
szLastStructureName  CSTRING(64)
szLastEnumName       CSTRING(64)
PopupString          STRING(16)
PopupMgr             PopupClass
ObjectPopupMgr       PopupClass
comctl32             CSTRING('comctl32.dll')
lLastLevel           LONG
szCaptionVersion     CSTRING(10)
szCaptionView        CSTRING(32)
MyErrors             GROUP
Number                 USHORT(3)
                       USHORT(Msg:DeleteNote)
                       BYTE(Level:User)
                       PSTRING('Confirm Delete')
                       PSTRING('Are you sure you want to delete the note?')
                       USHORT(Msg:SaveNote)
                       BYTE(Level:User)
                       PSTRING('Save Note')
                       PSTRING('Do you want to save the changes to this note?')
                       USHORT(Msg:QueryRefresh)
                       BYTE(Level:User)
                       PSTRING('Confirm Refresh')
                       PSTRING('Are you sure you want to re-scan the source files?')
                     END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
  !------------------------------------
  !Style for ?TreeList
  !------------------------------------
!---------------------------------------------------------------------------
LoadRedirectionQueue    ROUTINE
  DATA
loc:szSection       CSTRING(256)
loc:szRoot          CSTRING(256)
loc:build           CSTRING(5)
I                   LONG
J                   LONG

  CODE
     FREE(RedirectionQueue)

     CASE glo:bClarionVersion
       OF CWVERSION_C2
          loc:szSection = 'Clarion for Windows V2.0'
       OF CWVERSION_C4
          loc:szSection = 'Clarion 4'
       OF CWVERSION_C5
          loc:szSection = 'Clarion 5'
       OF CWVERSION_C5EE
          loc:szSection = 'Clarion 5  Enterprise Edition'
       OF CWVERSION_C55
          loc:szSection = 'Clarion 5.5'
       OF CWVERSION_C55EE
          loc:szSection = 'Clarion 5.5  Enterprise Edition'
       OF CWVERSION_C60
          loc:szSection = 'Clarion 6.0'
       OF CWVERSION_C60EE
          loc:szSection = 'Clarion 6.0  Enterprise Edition'
       OF CWVERSION_C70
          loc:szSection = 'Clarion 7.'
       OF CWVERSION_C80
          loc:szSection = 'Clarion 8.'
       OF CWVERSION_C90
          loc:szSection = 'Clarion 9.'
       OF CWVERSION_C100
          loc:szSection = 'Clarion 10.'
       OF CWVERSION_C110
          loc:szSection = 'Clarion 11.'
     END
     
     stop('loadredirectionqueue: glo:bClarionVersion=' & glo:bClarionVersion)

     IF glo:bClarionVersion < CWVERSION_C70
        loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory from win.ini
        IF loc:szRoot[LEN(loc:szRoot)] = '\'
           loc:szRoot[LEN(loc:szRoot)] = '<0>'                                 !remove trailing backslash
        END
     ELSE
        !look for latest clarion7 or greater install
        LOOP I = 1 TO RECORDS(glo:VersionQ)
           GET(glo:VersionQ,I)
           IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
              IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                 loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                 loc:szRoot = glo:VersionQ.Root
                 IF NOT glo:VersionQ.RedirectionMacros &= NULL
                    FREE(RedirectionQueue)
                    LOOP J = 1 TO RECORDS(glo:VersionQ.RedirectionMacros)
                       GET(glo:VersionQ.RedirectionMacros,J)
                       RedirectionQueue.Token = glo:VersionQ.RedirectionMacros.Token
                       RedirectionQueue.Path  = glo:VersionQ.RedirectionMacros.Path
                       ADD(RedirectionQueue,+RedirectionQueue.Token)
                    END
                 END
              END
           END
        END
     END

     RedirectionQueue.Token = '%ROOT%'
     GET(RedirectionQueue,+RedirectionQueue.Token)
     IF ERRORCODE()
        RedirectionQueue.Token = '%ROOT%'
        RedirectionQueue.Path  = loc:szRoot
        ADD(RedirectionQueue,+RedirectionQueue.Token)
     END

     CASE glo:bClarionVersion
       OF CWVERSION_C2
          szIniFile = loc:szRoot & '\bin\c2.ini'
       OF CWVERSION_C4
          szIniFile = loc:szRoot & '\bin\c4.ini'
       OF CWVERSION_C5
          szIniFile = loc:szRoot & '\bin\c5pe.ini'
       OF CWVERSION_C5EE
          szIniFile = loc:szRoot & '\bin\c5ee.ini'
       OF CWVERSION_C55
          szIniFile = loc:szRoot & '\bin\c55pe.ini'
       OF CWVERSION_C55EE
          szIniFile = loc:szRoot & '\bin\c55ee.ini'
       OF CWVERSION_C60
          szIniFile = loc:szRoot & '\bin\c60pe.ini'
       OF CWVERSION_C60EE
          szIniFile = loc:szRoot & '\bin\c60ee.ini'
       OF CWVERSION_C70 OROF CWVERSION_C80 OROF CWVERSION_C90 OROF CWVERSION_C100 
       OROF CWVERSION_C110  ! mr 2021-05-29
          !this needs work
          IF glo:VersionQ.IniFile = ''
             szIniFile = ''
          ELSE
             szIniFile = loc:szRoot & glo:VersionQ.IniFile
          END
     END
     IF szIniFile <> ''
        OPEN(IniFile,ReadOnly+DenyNone)
        SET(IniFile)
        NEXT(IniFile)
        LOOP UNTIL ERRORCODE()
           CASE UPPER(CLIP(IniFile.IniRecord.IniBuffer))
           OF '[REDIRECTION MACROS]'
              !look for other redirection macros
              DO ProcessRedirectionMacros
           ELSE
              NEXT(IniFile)
           END
        END
        CLOSE(IniFile)
     ELSE
        IF glo:bClarionVersion >= CWVERSION_C70
            !currently nothing to do
        END
     END

     RedirectionQueue.Token = '%ROOT%'
     GET(RedirectionQueue,+RedirectionQueue.Token)
     szRoot = RedirectionQueue.Path
  EXIT
ProcessRedirectionMacros  ROUTINE
  DATA
I   LONG
J   LONG
szWork  CSTRING(256)

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    IF IniFile.IniRecord.IniBuffer[J] = '\'
       IniFile.IniRecord.IniBuffer[J] = '<0>'                                 !remove trailing backslash
    END
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       RedirectionQueue.Token = '%' & UPPER(IniFile.IniRecord.IniBuffer[1 : I-1]) & '%'
       GET(RedirectionQueue,+RedirectionQueue.Token)
       IF ERRORCODE()
          RedirectionQueue.Token = '%' & UPPER(IniFile.IniRecord.IniBuffer[1 : I-1]) & '%'
          RedirectionQueue.Path  = CLIP(LEFT(IniFile.IniRecord.IniBuffer[I+1 : J]))
          ADD(RedirectionQueue,+RedirectionQueue.Token)
       ELSE
          RedirectionQueue.Path  = CLIP(LEFT(IniFile.IniRecord.IniBuffer[I+1 : J]))
          PUT(RedirectionQueue)
       END
    END
    NEXT(IniFile)
  END
  EXIT
LoadMRU_Queue   ROUTINE
  J = 0
  INIMgr.Fetch('MRU','Records',J)
  LOOP I = 1 TO J
     INIMgr.Fetch('MRU','Name' & FORMAT(I,@N02),MRU_Queue.szName)
     IF MRU_Queue.szName <> ''
        INIMgr.Fetch('MRU','Sort' & FORMAT(I,@N02),MRU_Queue.szSortName)
        INIMgr.Fetch('MRU','Type' & FORMAT(I,@N02),MRU_Queue.szObjectType)
        ADD(MRU_Queue,I)
     END
  END
  EXIT
SaveMRU_Queue   ROUTINE
  J = RECORDS(MRU_Queue)
  INIMgr.Update('MRU','Records',J)
  LOOP I = 1 TO RECORDS(MRU_Queue)
     GET(MRU_Queue,I)
     INIMgr.Update('MRU','Name' & FORMAT(I,@N02),MRU_Queue.szName)
     INIMgr.Update('MRU','Sort' & FORMAT(I,@N02),MRU_Queue.szSortName)
     INIMgr.Update('MRU','Type' & FORMAT(I,@N02),MRU_Queue.szObjectType)
  END
  EXIT
UpdateMRU_Queue ROUTINE
   DATA
szSearch    CSTRING(64)

   CODE
   IF KEYCODE() = MouseLeft
      CASE glo:bCurrentView
      OF VIEW:CLASSES
         GET(ClassNameQ,CHOICE(?ObjectDropList))
         szSearch = ClassNameQ.szSortName
      OF VIEW:INTERFACES
         GET(ClassNameQ,CHOICE(?ObjectDropList))
         szSearch = ClassNameQ.szSortName
      OF VIEW:STRUCTURES
         GET(StructNameQ,CHOICE(?ObjectDropList))
         szSearch = StructNameQ.szStructureSort
      END

      J = RECORDS(MRU_Queue)
      IF J <> 0
         LOOP I = 1 TO J
            GET(MRU_Queue,I)
            IF MRU_Queue.szSortName = szSearch
               BREAK
            END
         END
         IF INRANGE(I,2,J)
            DELETE(MRU_Queue)
         END
      ELSE
         I = 0
      END
      IF I <> 1
         CASE glo:bCurrentView
         OF VIEW:CLASSES
            MRU_Queue.szObjectType = 'CLASS'
            MRU_Queue.szName = ClassNameQ.szClassName
            MRU_Queue.szSortName = ClassNameQ.szSortName
         OF VIEW:INTERFACES
            MRU_Queue.szObjectType = 'INTERFACE'
            MRU_Queue.szName = ClassNameQ.szClassName
            MRU_Queue.szSortName = ClassNameQ.szSortName
         OF VIEW:STRUCTURES
            MRU_Queue.szObjectType = 'STRUCTURE'
            MRU_Queue.szName = StructNameQ.szStructureName
            MRU_Queue.szSortName = StructNameQ.szStructureSort
         END
         ADD(MRU_Queue,1)
         J = RECORDS(MRU_Queue)
         LOOP WHILE J > glo:bMaxMRU
            GET(MRU_Queue,J)
            DELETE(MRU_Queue)
            J = RECORDS(MRU_Queue)
         END
         DO CreateMRUMenu
      END
   END

   EXIT
CreateMRUMenu  ROUTINE
  DATA

  CODE
  DO DestroyMRUMenu

  J = RECORDS(MRU_Queue)
  LOOP I = 1 TO J
     GET(MRU_Queue,I)
?    ASSERT(MRU_Queue.MenuFeq = 0)
     IF MRU_Queue.MenuFeq = 0
        MRU_Queue.MenuFeq = CREATE(0,CREATE:ITEM,?FileRecent)
        PUT(MRU_Queue)
        CASE I
        OF 1
           lFirstMRUMenuFeq = MRU_Queue.MenuFeq
           IF J = 1
              lLastMRUMenuFeq = MRU_Queue.MenuFeq
           END
        OF J
           lLastMRUMenuFeq = MRU_Queue.MenuFeq
        END
        MRU_Queue.MenuFeq{PROP:Text} = MRU_Queue.szName
        MRU_Queue.MenuFeq{PROP:Left} = 16
        CASE MRU_Queue.szObjectType
        OF 'CLASS'
           MRU_Queue.MenuFeq{PROP:ICON} = '~class.ico'
        OF 'INTERFACE'
           MRU_Queue.MenuFeq{PROP:ICON} = '~intrface.ico'
        OF 'STRUCTURE'
           MRU_Queue.MenuFeq{PROP:ICON} = '~structyp.ico'
        END
        UNHIDE(MRU_Queue.MenuFeq)
     END
  END

  EXIT
DestroyMRUMenu  ROUTINE
  J = RECORDS(MRU_Queue)
  LOOP I = 1 TO J
     GET(MRU_Queue,I)
     IF MRU_Queue.MenuFeq <> 0
        DESTROY(MRU_Queue.MenuFeq)
        MRU_Queue.MenuFeq = 0
        PUT(MRU_Queue)
     END
  END
  lFirstMRUMenuFeq = 0
  lLastMRUMenuFeq = 0

  EXIT
ProcessMRUMenu    ROUTINE
  DATA

szURL   CSTRING(256)
szNull  CSTRING(2)

  CODE

  J = RECORDS(MRU_Queue)
  LOOP I = 1 TO J
     GET(MRU_Queue,I)
     IF MRU_Queue.MenuFeq = ACCEPTED()
        CASE MRU_Queue.szObjectType
        OF 'CLASS'
           IF lLatchControl <> ?ClassRegion
              DO SetupClassView
           END
           ClassNameQ:szSortName = MRU_Queue.szSortName
           GET(ClassNameQ,+ClassNameQ:szSortName)
           ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
           DISPLAY(?ObjectDropList)
           SELECT(?ObjectDropList)
           SETKEYCODE(MouseLeft)
           POST(EVENT:Accepted,?ObjectDropList)
        OF 'INTERFACE'
           IF lLatchControl <> ?InterfaceRegion
              DO SetupInterfaceView
           END
           ClassNameQ:szSortName = MRU_Queue.szSortName
           GET(ClassNameQ,+ClassNameQ:szSortName)
           ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
           DISPLAY(?ObjectDropList)
           SELECT(?ObjectDropList)
           SETKEYCODE(MouseLeft)
           POST(EVENT:Accepted,?ObjectDropList)
        OF 'STRUCTURE'
           IF lLatchControl <> ?StructureRegion
              DO SetupStructureView
           END
           StructNameQ.szStructureSort = MRU_Queue.szSortName
           GET(StructNameQ,+StructNameQ.szStructureSort)
           ?ObjectDropList{PROP:Selected} = POINTER(StructNameQ)
           DISPLAY(?ObjectDropList)
           SELECT(?ObjectDropList)
           SETKEYCODE(MouseLeft)
           POST(EVENT:Accepted,?ObjectDropList)
        END
        BREAK
     END
  END

  EXIT
GetAppPath  ROUTINE
 szSubKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\abcview.exe'
 RetVal = RegOpenKeyEx(HKEY_CURRENT_USER,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
 IF RetVal <> ERROR_SUCCESS
    RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
 END
 IF RetVal = ERROR_SUCCESS
    szValueName = 'DataPath'
    pType = REG_SZ
    pData = SIZE(szValue)
    RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(szValue),pData)
    RetVal = RegCloseKey(hKeyExtension)
 END

 !First Command Line Parameter is DataPath
 !and it overrides the registry entry
 !=====================================================================
 IF COMMAND('1')
    szValue = COMMAND('1')
 END

 IF ~CLIP(szValue)
    szValue = LONGPATH(PATH())
 END

 IF szValue[LEN(CLIP(szValue))] = '\'
    szValue[LEN(CLIP(szValue))] = '<0>'
 END
 EXIT
PopupMenu   ROUTINE
 DATA
lObjectId               LONG
bSeparate               BYTE
lModuleId               LONG
bEditDefinition         BYTE
bEditSource             BYTE
loc:bForceEdit          LIKE(glo:bForceEdit)
sav:TreeQ:lLineNum      LIKE(TreeQ:lLineNum)
sav:TreeQ:lIncludeId    LIKE(TreeQ:lIncludeId)

 CODE
 DO SyncQueues

 !Remove Popup Manager Menu Options
 PopupMgr.DeleteItem('SparseTree')
 PopupMgr.DeleteItem('Declaration')
 PopupMgr.DeleteItem('Definition')
 PopupMgr.DeleteItem('Separator1')
 PopupMgr.DeleteItem('Source')
 PopupMgr.DeleteItem('Callers')
 PopupMgr.DeleteItem('Separator2')
 PopupMgr.DeleteItem('Edit')
 PopupMgr.DeleteItem('EditDeclaration')
 PopupMgr.DeleteItem('EditDefinition')
 PopupMgr.DeleteItem('EditSource')
 PopupMgr.DeleteItem('Separator4')
 PopupMgr.DeleteItem('Notes')
 PopupMgr.DeleteItem('Properties')
 PopupMgr.DeleteItem('Help')
 PopupMgr.DeleteItem('Separator5')
 PopupMgr.DeleteItem('Hyperlink')
 PopupMgr.DeleteItem('Separator6')
 PopupMgr.DeleteItem('View')
 PopupMgr.DeleteItem('Classes')
 PopupMgr.DeleteItem('Interfaces')
 PopupMgr.DeleteItem('CallTree')
 PopupMgr.DeleteItem('Structures')
 PopupMgr.DeleteItem('Equates')
 PopupMgr.DeleteItem('Separator7')
 PopupMgr.DeleteItem('Sort')
 PopupMgr.DeleteItem('Alphabetic')
 PopupMgr.DeleteItem('Canonical')

 !Set Popup Manager Menu Options
 PopupMgr.AddItem('&Declaration','Declaration')

 IF TreeQ:wIcon = ICON:METHOD               |
 AND glo:bCurrentView <> VIEW:INTERFACES    |
 AND TreeQ.lModuleId <> 0                   |
 AND TreeQ.lSourceLine
     PopupMgr.AddItem('De&finition','Definition')
     bEditDefinition = TRUE
 END
 PopupMgr.AddItem('-','Separator1')

 IF glo:bCurrentView = VIEW:CALLS   |
 AND ABS(TreeQ.lLevel) > 1          |
 AND TreeQ.lOccurranceLine
     PopupMgr.AddItem('&Source','Source')
     bEditSource = TRUE
     bSeparate = TRUE
 END
 IF glo:bCurrentView = VIEW:CALLS
    PopupMgr.AddItem('&Callers','Callers')
    bSeparate = TRUE
 END
 IF bSeparate = TRUE
    bSeparate = FALSE
    PopupMgr.AddItem('-','Separator2')
 END

!==============================================================================
!new code build 2003.06.10
!==============================================================================
 PopupMgr.AddItem('Edit')
 PopupMgr.AddItem('-','Separator4')
!==============================================================================
!end new code build 2003.06.10
!==============================================================================

 IF TreeQ.szHelpFile
    PopupMgr.AddItem('&Help','Help')
 END

 PopupMgr.AddItem('&Notes','Notes')

 IF TreeQ:wIcon = ICON:CLASS OR TreeQ:wIcon = ICON:NEWCLASS
    PopupMgr.AddItem('&Properties','Properties','Notes',1)
 END

 IF (TreeQ:wIcon = ICON:PROPERTY OR TreeQ:wIcon = ICON:STRUCTURE)
    IF INSTRING('&',TreeQ.szText)
       IF srcIsClassReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName,lObjectId)
          PopupMgr.AddItem('-','Separator5')
          PopupMgr.AddItem('Hyper&link','Hyperlink')
          ClassQ.szClassName = szObjectName
          GET(ClassQ,+ClassQ.szClassName)
          szObjectType = CHOOSE(ClassQ:bInterface=TRUE,'INTERFACE','CLASS')
          bSeparate = TRUE
       ELSIF srcIsStructureReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName)
          PopupMgr.AddItem('-','Separator5')
          PopupMgr.AddItem('Hyper&link','Hyperlink')
          szObjectType = 'STRUCTURE'
          bSeparate = TRUE
       END
    ELSIF INSTRING('LIKE(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('LIKE(',UPPER(TreeQ.szText),1)+5 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          PopupMgr.AddItem('-','Separator5')
          PopupMgr.AddItem('Hyper&link','Hyperlink')
          szObjectType = 'STRUCTURE'
          bSeparate = TRUE
       END
    ELSIF INSTRING('GROUP(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('GROUP(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          PopupMgr.AddItem('-','Separator5')
          PopupMgr.AddItem('Hyper&link','Hyperlink')
          szObjectType = 'STRUCTURE'
          bSeparate = TRUE
       END
    ELSIF INSTRING('QUEUE(',UPPER(TreeQ.szText),1)
       IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('QUEUE(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
          PopupMgr.AddItem('-','Separator5')
          PopupMgr.AddItem('Hyper&link','Hyperlink')
          szObjectType = 'STRUCTURE'
          bSeparate = TRUE
       END
    END
 END

 PopupMgr.AddItem('-','Separator6')
 PopupMgr.AddItem('&View','View')

 !==============================================================================
 !new code build 2003.08.12
 !==============================================================================
 IF glo:bCurrentView = VIEW:EQUATES
    J = POINTER(TreeQ)
    GET(TreeQ,1)
    IF TreeQ.szText <> '*EQUATES*'
       PopupMgr.AddItem('-','Separator7')
       PopupMgr.AddItem('&Sort','Sort')

       PopupMgr.AddItem('&Alphabetic','Alphabetic','Sort',2)
       PopupMgr.AddItem('&Canonical','Canonical','Sort',2)
    END
    GET(TreeQ,J)
 END
 !==============================================================================
 !end of new code build 2003.08.12
 !==============================================================================

 PopupMgr.AddItem('&Classes','Classes','View',2)
 PopupMgr.AddItemEvent('Classes',EVENT:Accepted,?bViewClasses)
 PopupMgr.SetItemCheck('Classes',bViewClasses)
 PopupMgr.SetItemEnable('Classes',CHOOSE(?bViewClasses{PROP:Disable}=TRUE,FALSE,TRUE))

 PopupMgr.AddItem('&Interfaces','Interfaces','Classes',2)
 PopupMgr.AddItemEvent('Interfaces',EVENT:Accepted,?bViewInterfaces)
 PopupMgr.SetItemCheck('Interfaces',bViewInterfaces)
 PopupMgr.SetItemEnable('Interfaces',CHOOSE(?bViewInterfaces{PROP:Disable}=TRUE,FALSE,TRUE))

 PopupMgr.AddItem('Call &Tree','CallTree','Interfaces',2)
 PopupMgr.AddItemEvent('CallTree',EVENT:Accepted,?bViewCallTree)
 PopupMgr.SetItemCheck('CallTree',bViewCallTree)
 PopupMgr.SetItemEnable('CallTree',CHOOSE(?bViewCallTree{PROP:Disable}=TRUE,FALSE,TRUE))

 PopupMgr.AddItem('&Structures','Structures','CallTree',2)
 PopupMgr.AddItemEvent('Structures',EVENT:Accepted,?bViewStructures)
 PopupMgr.SetItemCheck('Structures',bViewStructures)
 PopupMgr.SetItemEnable('Structures',CHOOSE(?bViewStructures{PROP:Disable}=TRUE,FALSE,TRUE))

 PopupMgr.AddItem('&Equates','Equates','Structures',2)
 PopupMgr.AddItemEvent('Equates',EVENT:Accepted,?bViewEquates)
 PopupMgr.SetItemCheck('Equates',bViewEquates)
 PopupMgr.SetItemEnable('Equates',CHOOSE(?bViewEquates{PROP:Disable}=TRUE,FALSE,TRUE))

 IF glo:bCurrentView = VIEW:CLASSES
    PopupMgr.AddItem('-','Separator7','Equates',2)
    PopupMgr.AddItem('&Sparse Tree','SparseTree','Separator7',2)
    PopupMgr.AddItemEvent('SparseTree',EVENT:Accepted,?glo:bShowSparseTrees)
    PopupMgr.SetItemCheck('SparseTree',glo:bShowSparseTrees)
 END

 PopupMgr.AddItem('D&eclaration','EditDeclaration','Edit',2)

 IF bEditDefinition
    PopupMgr.AddItem('De&finition','EditDefinition','EditDeclaration',2)
    IF bEditSource
       PopupMgr.AddItem('&Source','EditSource','EditDefinition',2)
    END
 ELSE
    IF bEditSource
       PopupMgr.AddItem('&Source','EditSource','EditDeclaration',2)
    END
 END
!==============================================================================
!end new code build 2003.06.10
!==============================================================================

 PopupString = PopupMgr.Ask()

 CASE PopupString
   OF 'Help'
      IF UPPER(SUB(TreeQ.szHelpFile,LEN(TreeQ.szHelpFile)-2,3)) = 'CHM'
         IF oHH &= NULL
            oHH &= NEW tagHTMLHelp
            oHH.Init(TreeQ.szHelpFile)
         ELSE
            oHH.SetHelpFile( TreeQ.szHelpFile)
         END
         I = INSTRING(':',TreeQ.szContextString)
         IF I > 0
            oHH.KeyWordLookup(SUB(TreeQ.szContextString,1,I-1))
         ELSE
            oHH.KeyWordLookup(TreeQ.szContextString)
         END
         oHH.KeyWordLookup(TreeQ.szContextString)
         !oHH.ShowTopic(TreeQ.szContextString)
         oHH.SetHelpFile( 'ABCVIEW.CHM' )
      ELSE
         HELP(TreeQ.szHelpFile,TreeQ.szContextString)
         HELP('abcview.hlp')
      END

   OF 'Declaration'
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = FALSE
      CASE TreeQ:wIcon
        OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
           srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
        OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
           srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
        OF ICON:METHOD
           CASE glo:bCurrentView
             OF VIEW:CLASSES OROF VIEW:CALLS
                S" = TreeQ.szSearch[LEN(ClassQ.szClassName)+2 : LEN(TreeQ.szSearch)]
                I = INSTRING('.',S")
                IF I
                   ClassQ.szClassSort = UPPER(S"[1 : I-1])
                   GET(ClassQ,+ClassQ.szClassSort)
                   srcViewAsciiFile(ClassQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
                ELSE
                   IF TreeQ.lIncludeId
                      srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
                   ELSE
                      srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
                   END
                END
           ELSE
              srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
           END
        OF ICON:INTERFACEFOLDER OROF ICON:NEWINTERFACEFOLDER
           CASE glo:bCurrentView
             OF VIEW:CLASSES
                ClassQ.szClassSort = UPPER(TreeQ.szText)
                GET(ClassQ,+ClassQ.szClassSort)
                srcViewAsciiFile(ClassQ.lIncludeId,ClassQ.lLineNum,ViewerThreadQ)
           ELSE
                srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
           END
      ELSE
           srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
      END
      glo:bForceEdit = loc:bForceEdit
   OF 'Definition'
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = FALSE
      srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lSourceLine,ViewerThreadQ)
      glo:bForceEdit = loc:bForceEdit
   OF 'Source'
      J = POINTER(TreeQ)
      K = ABS(TreeQ.lLevel)
      LOOP I = J TO 1 BY -1
        GET(TreeQ,I)
        IF ABS(TreeQ.lLevel) < K
           BREAK
        END
      END
      lModuleId = TreeQ.lModuleId
      GET(TreeQ,J)
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = FALSE
      srcViewAsciiFile(lModuleId,TreeQ.lOccurranceLine,ViewerThreadQ)
      glo:bForceEdit = loc:bForceEdit
   OF 'Callers'
      winViewCallers(TreeQ.szSearch)
   OF 'EditDeclaration'
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = TRUE
      CASE TreeQ:wIcon
        OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
           srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
        OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
           srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
        OF ICON:METHOD
           CASE glo:bCurrentView
             OF VIEW:CLASSES OROF VIEW:CALLS
                S" = TreeQ.szSearch[LEN(ClassQ.szClassName)+2 : LEN(TreeQ.szSearch)]
                I = INSTRING('.',S")
                IF I
                   ClassQ.szClassSort = UPPER(S"[1 : I-1])
                   GET(ClassQ,+ClassQ.szClassSort)
                   srcViewAsciiFile(ClassQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
                ELSE
                   IF TreeQ.lIncludeId
                      srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
                   ELSE
                      srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
                   END
                END
           ELSE
              srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
           END
        OF ICON:INTERFACEFOLDER OROF ICON:NEWINTERFACEFOLDER
           CASE glo:bCurrentView
             OF VIEW:CLASSES
                ClassQ.szClassSort = UPPER(TreeQ.szText)
                GET(ClassQ,+ClassQ.szClassSort)
                srcViewAsciiFile(ClassQ.lIncludeId,ClassQ.lLineNum,ViewerThreadQ)
           ELSE
                srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
           END
      ELSE
           srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
      END
      glo:bForceEdit = loc:bForceEdit
   OF 'EditDefinition'
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = TRUE
      srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lSourceLine,ViewerThreadQ)
      glo:bForceEdit = loc:bForceEdit
   OF 'EditSource'
      J = POINTER(TreeQ)
      K = ABS(TreeQ.lLevel)
      LOOP I = J TO 1 BY -1
        GET(TreeQ,I)
        IF ABS(TreeQ.lLevel) < K
           BREAK
        END
      END
      lModuleId = TreeQ.lModuleId
      GET(TreeQ,J)
      loc:bForceEdit = glo:bForceEdit
      glo:bForceEdit = TRUE
      srcViewAsciiFile(lModuleId,TreeQ.lOccurranceLine,ViewerThreadQ)
      glo:bForceEdit = loc:bForceEdit
!==============================================================================
!end of new code build 2003.06.10
!==============================================================================
   OF 'Notes'
      POST(EVENT:Accepted,?ViewNoteButton)
   OF 'Properties'
      ClassQ.szClassSort = UPPER(TreeQ.szText)
      GET(ClassQ,+ClassQ.szClassSort)
      CategoryQ.szClassName = ClassQ.szClassName
      GET(CategoryQ,+CategoryQ.szClassName)
      IF ~winClassProperties(CategoryQueue)
         !loc:TreeQ:szText = TreeQ.szText       !2004.02.26 RR
         srcRefreshTree()
         DO FillClassNameQ
         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
           GET(TreeQ,I)
           !IF TreeQ.szText = loc:TreeQ:szText
           IF TreeQ.szText = sav:TreeQ:szText
              BREAK
           END
         END
         IF I > J
            GET(TreeQ,1)
            ?TreeList{PROP:Selected} = 1
         ELSE
            ?TreeList{PROP:Selected} = I
         END

         !now find the base node and expand it
         J = POINTER(TreeQ)
         LOOP I = J to 1 BY -1
           GET(TreeQ,I)
           IF ABS(TreeQ.lLevel) = 1
              TreeQ.lLevel = ABS(TreeQ.lLevel)
              PUT(TreeQ)
              BREAK
           END
         END

         !get our queue record
         GET(TreeQ,J)
      END
   OF 'Hyperlink'
      DO SetupHyperlink
      DO ProcessHyperlink
!==============================================================================
!new code build 2003.08.18
!==============================================================================
   OF 'Alphabetic'
      glo:bEnumSort = 0  !alphabetic
      SORT(TreeQ,+TreeQ:lModuleId,+TreeQ:lLevel,+TreeQ:szText) !+TreeQ:szSearch)
      GET(TreeQ,2)
      sav:TreeQ:lLineNum = TreeQ:lLineNum
      sav:TreeQ:lIncludeId = TreeQ:lIncludeId
      GET(TreeQ,1)
      TreeQ:lLineNum = sav:TreeQ:lLineNum
      TreeQ:lIncludeId = sav:TreeQ:lIncludeId
      PUT(TreeQ)
      DO ProcessNewSelection
   OF 'Canonical'
      glo:bEnumSort = 1  !canonical
      SORT(TreeQ,+TreeQ:lModuleId,+TreeQ:lLevel,+TreeQ:lLineNum)
      GET(TreeQ,2)
      sav:TreeQ:lLineNum = TreeQ:lLineNum
      sav:TreeQ:lIncludeId = TreeQ:lIncludeId
      GET(TreeQ,1)
      TreeQ:lLineNum = sav:TreeQ:lLineNum
      TreeQ:lIncludeId = sav:TreeQ:lIncludeId
      PUT(TreeQ)
      DO ProcessNewSelection
!==============================================================================
!end of new code build 2003.08.18
!==============================================================================
 END

 EXIT
ObjectPopupMenu   ROUTINE
 DATA
ObjectPopupString   CSTRING(21)

 CODE

 !Remove Object Popup Manager Menu Options
 ObjectPopupMgr.DeleteItem('AllClasses')
 ObjectPopupMgr.DeleteItem('AbcClasses')
 ObjectPopupMgr.DeleteItem('NonClasses')
 ObjectPopupMgr.DeleteItem('AddClass')
 ObjectPopupMgr.DeleteItem('Template')

 !Set Popup Manager Menu Options
 IF ?ObjectDropList{PROPLIST:MouseDownZone} = LISTZONE:header
    ObjectPopupMgr.AddItem('&All Classes','AllClasses')
    ObjectPopupMgr.AddItem('&ABC Classes','AbcClasses')
    ObjectPopupMgr.AddItem('&Non-ABC','NonClasses')
    CASE glo:bABCOnly
      OF 0
         ObjectPopupMgr.SetItemCheck('AllClasses',TRUE)
      OF 1
         ObjectPopupMgr.SetItemCheck('AbcClasses',TRUE)
      OF 2
         ObjectPopupMgr.SetItemCheck('NonClasses',TRUE)
    END
 ELSE
    ObjectPopupMgr.AddItem('&Add Class Wizard...','AddClass')
    IF ~RECORDS(incTemplateQ) OR ~RECORDS(clwTemplateQ)
       ObjectPopupMgr.SetItemEnable('AddClass',FALSE)
    END

    CASE glo:bCurrentView
      OF VIEW:CLASSES
         ObjectPopupMgr.AddItem('&Generate Wrapper...','Template')
         IF ~RECORDS(tplTemplateQ)
            ObjectPopupMgr.SetItemEnable('Template',FALSE)
         END
    END
 END
 ObjectPopupString = ObjectPopupMgr.Ask()

 CASE ObjectPopupString
   OF 'AllClasses'
      glo:bABCOnly = 0
      DO ABCOnlyFlagChanged
   OF 'AbcClasses'
      glo:bABCOnly = 1
      DO ABCOnlyFlagChanged
   OF 'NonClasses'
      glo:bABCOnly = 2
      DO ABCOnlyFlagChanged
   OF 'AddClass'
      IF winAddClass() = Level:Benign           !call the add class dialog
         loc:ForceSmartScan = TRUE
         POST(EVENT:Accepted,?RefreshButton)
      END
   OF 'Template'
      GET(ClassNameQ,CHOICE(?ObjectDropList))
      IF winGenerateTemplate(ClassNameQ.szClassName) = Level:Benign   !call the Template Generator
      END
 END

 EXIT
ABCOnlyFlagChanged   ROUTINE
   CASE glo:bCurrentView
     OF VIEW:CLASSES OROF VIEW:INTERFACES
        CASE glo:bABCOnly
        OF 0
           ?ObjectDropList{PROP:Format} = '252L(2)Y|~All Classes~C@s63@'
        OF 1
           ?ObjectDropList{PROP:Format} = '252L(2)Y|~ABC Classes~C@s63@'
        OF 2
           ?ObjectDropList{PROP:Format} = '252L(2)Y|~Non-ABC Classes~C@s63@'
        END
        POST(EVENT:Accepted,?glo:szCategoryChoice)
     OF VIEW:CALLS
        CASE glo:bABCOnly
        OF 0
           ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~All Classes~C@s63@'
        OF 1
           ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~ABC Classes~C@s63@'
        OF 2
           ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~Non-ABC Classes~C@s63@'
        END
        POST(EVENT:Accepted,?glo:szCategoryChoice)
   END
SetupHyperlink  ROUTINE
   IF RECORDS(HistoryQueue)
      GET(HistoryQueue,RECORDS(HistoryQueue))
   ELSE
      CLEAR(HistoryQueue)
   END
   IF HistoryQueue.ObjectName <> TreeQ.szClassName
      HistoryQueue.ObjectName = TreeQ.szClassName   !szObjectName
      HistoryQueue.ObjectView = glo:bCurrentView
      CASE HistoryQueue.ObjectView
      OF VIEW:CLASSES
         HistoryQueue.lObjectDropListPointer = POINTER(ClassNameQ)
      OF VIEW:STRUCTURES
         HistoryQueue.lObjectDropListPointer = POINTER(StructNameQ)
      OF VIEW:INTERFACES
         HistoryQueue.lObjectDropListPointer = POINTER(ClassNameQ)
      END
      HistoryQueue.szText = TreeQ.szText
      HistoryQueue.bProtected = glo:bShowProtected
      HistoryQueue.bPrivate = glo:bShowPrivate
      HistoryQueue.bModule = glo:bShowModule
      ADD(HistoryQueue)
   ELSE
      HistoryQueue.szText = TreeQ.szText
      PUT(HistoryQueue)
   END
   lHistoryPointer = RECORDS(HistoryQueue)+1
   ?HistoryList{PROP:Selected} = lHistoryPointer

   !enable/disable buttons
   ThisWindow.Reset()
ProcessHyperlink    ROUTINE
   bHyperLinking = TRUE

   CASE szObjectType
   OF 'CLASS'
      IF lLatchControl <> ?ClassRegion
         DO SetupClassView
      END
      ClassNameQ:szSortName = UPPER(szObjectName)
      GET(ClassNameQ,+ClassNameQ:szSortName)
      ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
      DISPLAY(?ObjectDropList)
      SELECT(?ObjectDropList)
      POST(EVENT:Accepted,?ObjectDropList)

   OF 'STRUCTURE'
      IF lLatchControl <> ?StructureRegion
         DO SetupStructureView
      END
      StructNameQ.szStructureSort = UPPER(szObjectName)
      GET(StructNameQ,+StructNameQ.szStructureSort)
      ?ObjectDropList{PROP:Selected} = POINTER(StructNameQ)
      DISPLAY(?ObjectDropList)
      SELECT(?ObjectDropList)
      POST(EVENT:Accepted,?ObjectDropList)

   OF 'INTERFACE'
      IF lLatchControl <> ?InterfaceRegion
         DO SetupInterfaceView
      END
      ClassNameQ:szSortName = UPPER(szObjectName)
      GET(ClassNameQ,+ClassNameQ:szSortName)
      ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
      DISPLAY(?ObjectDropList)
      SELECT(?ObjectDropList)
      POST(EVENT:Accepted,?ObjectDropList)

   END
   EXIT
ViewSource  ROUTINE
  CASE TreeQ:wIcon
    OF ICON:METHOD
       IF glo:bCurrentView <> VIEW:INTERFACES     |
       AND TreeQ.lModuleId <> 0                   |
       AND TreeQ.lSourceLine
          !Definition
          srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lSourceLine,ViewerThreadQ)
       ELSE
          !Declaration
          CASE glo:bCurrentView
            OF VIEW:CLASSES OROF VIEW:CALLS
               S" = TreeQ.szSearch[LEN(ClassQ.szClassName)+2 : LEN(TreeQ.szSearch)]
               I = INSTRING('.',S")
               IF I
                  ClassQ.szClassSort = UPPER(S"[1 : I-1])
                  GET(ClassQ,+ClassQ.szClassSort)
                     srcViewAsciiFile(ClassQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
               ELSE
                  srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
               END
          ELSE
             srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
          END
       END
    OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
       srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
    OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
       srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lLineNum,ViewerThreadQ)
    OF ICON:INTERFACEFOLDER OROF ICON:NEWINTERFACEFOLDER
       CASE glo:bCurrentView
         OF VIEW:CLASSES
            ClassQ.szClassSort = UPPER(TreeQ.szText)
            GET(ClassQ,+ClassQ.szClassSort)
            srcViewAsciiFile(ClassQ.lIncludeId,ClassQ.lLineNum,ViewerThreadQ)
       ELSE
            IF TreeQ.lModuleId
               srcViewAsciiFile(TreeQ.lModuleId,TreeQ.lSourceLine,ViewerThreadQ)
            ELSE
               srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
            END
       END
  ELSE
       srcViewAsciiFile(TreeQ.lIncludeId,TreeQ.lLineNum,ViewerThreadQ)
  END
  EXIT
SetTreeStyles   ROUTINE
  ?TreeList{PROPSTYLE:TextColor,STYLE:NORMAL} = COLOR:BLACK
  ?TreeList{PROPSTYLE:BackColor,STYLE:NORMAL} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:NORMAL} = glo:lSelectedFore    !COLOR:HIGHLIGHTTEXT    !COLOR:BLACK
  ?TreeList{PROPSTYLE:BackSelected,STYLE:NORMAL} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle

  ?TreeList{PROPSTYLE:TextColor,STYLE:MODULE} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:MODULE} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:MODULE} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:MODULE} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:MODULE} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:MODULE} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:MODULE} = glo:FontStyle

  ?TreeList{PROPSTYLE:TextColor,STYLE:PRIVATE} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PRIVATE} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PRIVATE} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PRIVATE} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PRIVATE} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PRIVATE} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PRIVATE} = glo:FontStyle

  ?TreeList{PROPSTYLE:TextColor,STYLE:PROTECTED} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PROTECTED} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PROTECTED} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PROTECTED} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PROTECTED} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PROTECTED} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PROTECTED} = glo:FontStyle

  ?TreeList{PROPSTYLE:TextColor,STYLE:VIRTUAL} = glo:lVirtualColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:VIRTUAL} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:VIRTUAL} = glo:lVirtualColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:VIRTUAL} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:VIRTUAL} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:VIRTUAL} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:VIRTUAL} = glo:FontStyle

  ?TreeList{PROPSTYLE:TextColor,STYLE:NORMAL_NEW} = COLOR:BLACK
  ?TreeList{PROPSTYLE:BackColor,STYLE:NORMAL_NEW} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:NORMAL_NEW} = glo:lSelectedFore    !COLOR:HIGHLIGHTTEXT    !COLOR:BLACK
  ?TreeList{PROPSTYLE:BackSelected,STYLE:NORMAL_NEW} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:NORMAL_NEW} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:NORMAL_NEW} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:NORMAL_NEW} = FONT:BOLD

  ?TreeList{PROPSTYLE:TextColor,STYLE:MODULE_NEW} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:MODULE_NEW} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:MODULE_NEW} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:MODULE_NEW} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:MODULE_NEW} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:MODULE_NEW} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:MODULE_NEW} = FONT:BOLD

  ?TreeList{PROPSTYLE:TextColor,STYLE:PRIVATE_NEW} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PRIVATE_NEW} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PRIVATE_NEW} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PRIVATE_NEW} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PRIVATE_NEW} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PRIVATE_NEW} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PRIVATE_NEW} = FONT:BOLD

  ?TreeList{PROPSTYLE:TextColor,STYLE:PROTECTED_NEW} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PROTECTED_NEW} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PROTECTED_NEW} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PROTECTED_NEW} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PROTECTED_NEW} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PROTECTED_NEW} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PROTECTED_NEW} = FONT:BOLD

  ?TreeList{PROPSTYLE:TextColor,STYLE:VIRTUAL_NEW} = glo:lVirtualColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:VIRTUAL_NEW} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:VIRTUAL_NEW} = glo:lVirtualColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:VIRTUAL_NEW} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:VIRTUAL_NEW} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:VIRTUAL_NEW} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:VIRTUAL_NEW} = FONT:BOLD

  ?TreeList{PROPSTYLE:TextColor,STYLE:NORMAL_HYPERLINK} = glo:lHyperlinkColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:NORMAL_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:NORMAL_HYPERLINK} = glo:lHyperlinkColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:NORMAL_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:NORMAL_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:NORMAL_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:NORMAL_HYPERLINK} = glo:FontStyle + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:MODULE_HYPERLINK} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:MODULE_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:MODULE_HYPERLINK} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:MODULE_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:MODULE_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:MODULE_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:MODULE_HYPERLINK} = glo:FontStyle + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:PRIVATE_HYPERLINK} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PRIVATE_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PRIVATE_HYPERLINK} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PRIVATE_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PRIVATE_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PRIVATE_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PRIVATE_HYPERLINK} = glo:FontStyle + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:PROTECTED_HYPERLINK} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PROTECTED_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PROTECTED_HYPERLINK} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PROTECTED_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PROTECTED_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PROTECTED_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PROTECTED_HYPERLINK} = glo:FontStyle + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:NORMAL_NEW_HYPERLINK} = glo:lHyperlinkColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:NORMAL_NEW_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:NORMAL_NEW_HYPERLINK} = glo:lHyperlinkColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:NORMAL_NEW_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:NORMAL_NEW_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:NORMAL_NEW_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:NORMAL_NEW_HYPERLINK} = FONT:BOLD + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:MODULE_NEW_HYPERLINK} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:MODULE_NEW_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:MODULE_NEW_HYPERLINK} = glo:lModuleColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:MODULE_NEW_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:MODULE_NEW_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:MODULE_NEW_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:MODULE_NEW_HYPERLINK} = FONT:BOLD + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:PRIVATE_NEW_HYPERLINK} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PRIVATE_NEW_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PRIVATE_NEW_HYPERLINK} = glo:lPrivateColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PRIVATE_NEW_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PRIVATE_NEW_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PRIVATE_NEW_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PRIVATE_NEW_HYPERLINK} = FONT:BOLD + FONT:UNDERLINE

  ?TreeList{PROPSTYLE:TextColor,STYLE:PROTECTED_NEW_HYPERLINK} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackColor,STYLE:PROTECTED_NEW_HYPERLINK} = COLOR:WHITE
  ?TreeList{PROPSTYLE:TextSelected,STYLE:PROTECTED_NEW_HYPERLINK} = glo:lProtectedColor
  ?TreeList{PROPSTYLE:BackSelected,STYLE:PROTECTED_NEW_HYPERLINK} = glo:lSelectedBack
  ?TreeList{PROPSTYLE:FontName,STYLE:PROTECTED_NEW_HYPERLINK} = glo:Typeface
  ?TreeList{PROPSTYLE:FontSize,STYLE:PROTECTED_NEW_HYPERLINK} = glo:FontSize
  ?TreeList{PROPSTYLE:FontStyle,STYLE:PROTECTED_NEW_HYPERLINK} = FONT:BOLD + FONT:UNDERLINE

  ?TreeList{PROPLIST:BackColor} = COLOR:WHITE

  ! Object List
  ?ObjectDropList{PROPSTYLE:TextColor,STYLE:NORMAL} = COLOR:BLACK
  ?ObjectDropList{PROPSTYLE:BackColor,STYLE:NORMAL} = COLOR:WHITE
  ?ObjectDropList{PROPSTYLE:TextSelected,STYLE:NORMAL} = glo:lSelectedFore  !COLOR:HIGHLIGHTTEXT    !COLOR:BLACK
  ?ObjectDropList{PROPSTYLE:BackSelected,STYLE:NORMAL} = glo:lSelectedBack
  ?ObjectDropList{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?ObjectDropList{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?ObjectDropList{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle

  ?ObjectDropList{PROPSTYLE:TextColor,STYLE:NORMAL_NEW} = COLOR:BLACK
  ?ObjectDropList{PROPSTYLE:BackColor,STYLE:NORMAL_NEW} = COLOR:WHITE
  ?ObjectDropList{PROPSTYLE:TextSelected,STYLE:NORMAL_NEW} = glo:lSelectedFore  !COLOR:HIGHLIGHTTEXT    !COLOR:BLACK
  ?ObjectDropList{PROPSTYLE:BackSelected,STYLE:NORMAL_NEW} = glo:lSelectedBack
  ?ObjectDropList{PROPSTYLE:FontName,STYLE:NORMAL_NEW} = glo:Typeface
  ?ObjectDropList{PROPSTYLE:FontSize,STYLE:NORMAL_NEW} = glo:FontSize
  ?ObjectDropList{PROPSTYLE:FontStyle,STYLE:NORMAL_NEW} = FONT:BOLD

  ?ObjectDropList{PROP:SelectedFillColor} = glo:lSelectedBack

  ?glo:szCategoryChoice{PROP:SelectedColor}     = glo:lSelectedFore
  ?glo:szCategoryChoice{PROP:SelectedFillColor} = glo:lSelectedBack
  ?glo:szCategoryChoice{PROP:Drop}              = glo:CategoryDropCount

  ?ModuleBox{PROP:Fill}    = glo:lModuleColor
  ?PrivateBox{PROP:Fill}   = glo:lPrivateColor
  ?ProtectedBox{PROP:Fill} = glo:lProtectedColor
  ?VirtualBox{PROP:Fill}   = glo:lVirtualColor

  CASE glo:Background
  OF 1  !Color
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = glo:Color1
  OF 2  !Wallpaper
     window{PROP:Wallpaper} = glo:szWallpaper1
     window{PROP:Tiled} = glo:Tiled1
     window{PROP:Color} = COLOR:NONE
  OF 3  !None
     window{PROP:Wallpaper} = ''
     window{PROP:Color} = COLOR:NONE
  END

  J = LASTFIELD()
  LOOP I = 0 TO J
     IF INRANGE(I,?File,?Panel4-1)  !Skip Menu
        CYCLE
     END
     CASE I
     OF ?LoadingString OROF ?SavingString OROF ?ProcessString   |
     OROF ?loc:szAsciiFilename
        !Do Nothing
     OF ?AsciiBox
        SETFONT(I,,glo:FontSize,glo:FontColor,glo:FontStyle,0)
     OF ?TreeList
        SETFONT(I,glo:Typeface,glo:FontSize+2,glo:FontColor,glo:FontStyle,0)
     ELSE
        SETFONT(I,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
     END
  END

  ?glo:bShowProtected{PROP:Background} = ?Panel4:2{PROP:Fill}
  ?glo:bShowPrivate{PROP:Background} = ?Panel4:2{PROP:Fill}
  ?glo:bShowModule{PROP:Background} = ?Panel4:2{PROP:Fill}

  ?ProgressBox{PROP:Color} = COLOR:NAVY !glo:lSelectedBack
  ?ProgressBox{PROP:Fill}  = COLOR:NAVY !glo:lSelectedBack
  ?ProgressBox:2{PROP:Color} = COLOR:NAVY !glo:lSelectedBack
  ?ProgressBox:2{PROP:Fill}  = COLOR:NAVY !glo:lSelectedBack

  CASE glo:bClarionVersion
    OF CWVERSION_C2 OROF CWVERSION_C4 OROF CWVERSION_C5 OROF CWVERSION_C5EE
       DISABLE(?InterfaceRegion)
  ELSE
       ENABLE(?InterfaceRegion)
  END

  IF glo:bUseHTMLHelp
     ?HelpSearch{PROP:STD} = ''
     ?HelpOnHelp{PROP:STD} = ''

     IF oHH &= NULL
        oHH &= NEW tagHTMLHelp
        oHH.Init( 'ABCVIEW.CHM' )
        oHH.SetTopic('Main_Window.htm')
     END

  ELSE
     ?HelpSearch{PROP:STD} = STD:HelpSearch
     ?HelpOnHelp{PROP:STD} = STD:HelpOnHelp

     IF ~oHH &= NULL
        oHH.Kill()
        DISPOSE( oHH )
     END

     ALIAS()
  END
  IF bAddToClarionMenu = FALSE
     HIDE(?HelpAddtoClarionMenu)
  END

  EXIT
SetAsciiBoxStyle    ROUTINE
  ?AsciiBox{PROP:HSCROLL} = FALSE
  ?AsciiBox{PROP:FORMAT} = '24L(2)|~Line#~L(0)@n05@250L(2)Y~' & CLIP(AsciiFileName) & '~S(1024)@s255@'
  ?AsciiBox{PROP:SelectedColor} = COLOR:BLACK
  ?AsciiBox{PROP:SelectedFillColor} = glo:lSelectedBack
  ?AsciiBox{PROPLIST:BackColor,1} = COLOR:BTNFACE

  ?AsciiBox{PROPSTYLE:TextColor,1} = COLOR:BLACK
  ?AsciiBox{PROPSTYLE:BackColor,1} = COLOR:WHITE
  ?AsciiBox{PROPSTYLE:TextSelected,1} = glo:lSelectedFore  !COLOR:BLACK
  ?AsciiBox{PROPSTYLE:BackSelected,1} = glo:lSelectedBack
  ?AsciiBox{PROPSTYLE:FontName,1} = 'Courier New'
  ?AsciiBox{PROPSTYLE:FontSize,1} = glo:FontSize
  ?AsciiBox{PROPSTYLE:FontStyle,1} = glo:FontStyle

  ?AsciiBox{PROPSTYLE:TextColor,2} = glo:lHighlightColor2
  ?AsciiBox{PROPSTYLE:BackColor,2} = COLOR:BTNFACE
  ?AsciiBox{PROPSTYLE:TextSelected,2} = glo:lHighlightColor2
  ?AsciiBox{PROPSTYLE:BackSelected,2} = glo:lSelectedBack
  ?AsciiBox{PROPSTYLE:FontName,2} = 'Courier New'
  ?AsciiBox{PROPSTYLE:FontSize,2} = glo:FontSize
  ?AsciiBox{PROPSTYLE:FontStyle,2} = glo:FontStyle

  ?AsciiBox{PROPSTYLE:TextColor,3} = glo:lHighlightColor1
  ?AsciiBox{PROPSTYLE:BackColor,3} = COLOR:BTNFACE
  ?AsciiBox{PROPSTYLE:TextSelected,3} = glo:lHighlightColor1
  ?AsciiBox{PROPSTYLE:BackSelected,3} = glo:lSelectedBack
  ?AsciiBox{PROPSTYLE:FontName,3} = 'Courier New'
  ?AsciiBox{PROPSTYLE:FontSize,3} = glo:FontSize
  ?AsciiBox{PROPSTYLE:FontStyle,3} = glo:FontStyle
SyncQueues  ROUTINE
 CASE TreeQ:wIcon
   OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
      StructureQ.szStructureName = TreeQ.szClassName
      StructureQ.szDataLabel = TreeQ.szContextString
      GET(StructureQ,+StructureQ.szStructureName,+StructureQ.szDataLabel)
   OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
      EnumQ.szEnumName = TreeQ.szClassName
      EnumQ.szEnumLabel = TreeQ.szContextString
      GET(EnumQ,+EnumQ.szEnumName,+EnumQ.szEnumLabel)
   OF ICON:METHOD
      IF glo:bCurrentView = VIEW:CALLS
         CallNameQ.szSortName = UPPER(TreeQ.szText)
         GET(CallNameQ,+CallNameQ.szSortName)
      END
 END
 CASE glo:bCurrentView
   OF VIEW:CLASSES OROF VIEW:CALLS OROF VIEW:INTERFACES
      ClassQ.szClassSort = UPPER(TreeQ.szClassName)
      GET(ClassQ,+ClassQ.szClassSort)
      ASSERT(~ERRORCODE())
 END
 EXIT
DrawLatchBox    ROUTINE
  bViewClasses = FALSE
  bViewInterfaces = FALSE
  bViewCallTree = FALSE
  bViewStructures = FALSE
  bViewEquates = FALSE
  ENABLE(?bViewClasses,?bViewEquates)
  ENABLE(?ClassRegion,?EquateRegion)

  DISABLE(lLatchControl)   !
  CASE lLatchControl
  OF ?ClassRegion
     bViewClasses = TRUE
     DISABLE(?bViewClasses)
  OF ?InterfaceRegion
     bViewInterfaces = TRUE
     DISABLE(?bViewInterfaces)
  OF ?TreeRegion
     bViewCallTree = TRUE
     DISABLE(?bViewCallTree)
  OF ?StructureRegion
     bViewStructures = TRUE
     DISABLE(?bViewStructures)
  OF ?EquateRegion
     bViewEquates = TRUE
     DISABLE(?bViewEquates)
  END
  DISPLAY(?bViewClasses,?bViewEquates)
  EXIT
ProcessNewSelection ROUTINE
  DATA
lObjectId           LONG
LineNo              LONG
ModuleId            LONG
I                   LONG
J                   LONG
K                   LONG
szAsciiFilename     CSTRING(256)

  CODE
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szCaptionVersion = '2.0'
    OF CWVERSION_C4
       szCaptionVersion = '4.0'
    OF CWVERSION_C5
       szCaptionVersion = '5.0'
    OF CWVERSION_C5EE
       szCaptionVersion = '5.0 EE'
    OF CWVERSION_C55
       szCaptionVersion = '5.5'
    OF CWVERSION_C55EE
       szCaptionVersion = '5.5 EE'
    OF CWVERSION_C60
       szCaptionVersion = '6.0'
    OF CWVERSION_C60EE
       szCaptionVersion = '6.0 EE'
    OF CWVERSION_C70
       szCaptionVersion = '7'
    OF CWVERSION_C80
       szCaptionVersion = '8'
    OF CWVERSION_C90
       szCaptionVersion = '9'
    OF CWVERSION_C100
       szCaptionVersion = '10'
    OF CWVERSION_C110            ! mr 2021-05-29
       szCaptionVersion = '11'   ! mr 2021-05-29
  END
  CASE glo:bCurrentView
    OF VIEW:CLASSES OROF VIEW:INTERFACES
       szCaptionView = CHOOSE(glo:bCurrentView = VIEW:CLASSES,'Classes','Interfaces')
       ClassQ.szClassName = TreeQ.szClassName
       GET(ClassQ,+ClassQ.szClassName)
       szLastClassName = ClassNameQ.szClassName
    OF VIEW:STRUCTURES
       szCaptionView = 'Structures'
       szLastStructureName = StructNameQ.szStructureName
    OF VIEW:EQUATES
       szCaptionView = 'Equates'
       szLastEnumName = EnumNameQ.szEnumName
    OF VIEW:CALLS
       szCaptionView = 'Method Calls'
       szLastCallName = CallNameQ.szCallName
  END
  IF TreeQ:szHelpFile
     ENABLE(?HelpButton)
  ELSE
     DISABLE(?HelpButton)
  END

  IF (TreeQ:wIcon = ICON:PROPERTY OR TreeQ:wIcon = ICON:STRUCTURE)
     IF INSTRING('&',TreeQ.szText)
        IF srcIsClassReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName,lObjectId)
           ClassQ.szClassName = szObjectName
           GET(ClassQ,+ClassQ.szClassName)
           szObjectType = CHOOSE(ClassQ:bInterface=TRUE,'INTERFACE','CLASS')
           ENABLE(?HyperlinkButton)
        ELSIF srcIsStructureReference(TreeQ.szText[INSTRING('&',TreeQ.szText) : LEN(TreeQ.szText)],szObjectName)
           szObjectType = 'STRUCTURE'
           ENABLE(?HyperlinkButton)
        ELSE
           DISABLE(?HyperlinkButton)
        END
     ELSIF INSTRING('LIKE(',UPPER(TreeQ.szText),1)
          IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('LIKE(',UPPER(TreeQ.szText),1)+5 : INSTRING(')',TreeQ.szText)-1],szObjectName)
             szObjectType = 'STRUCTURE'
             ENABLE(?HyperlinkButton)
          END
     ELSIF INSTRING('GROUP(',UPPER(TreeQ.szText),1)
          IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('GROUP(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
             szObjectType = 'STRUCTURE'
             ENABLE(?HyperlinkButton)
          END
     ELSIF INSTRING('QUEUE(',UPPER(TreeQ.szText),1)
          IF srcIsStructureReference('&' & TreeQ.szText[INSTRING('QUEUE(',UPPER(TreeQ.szText),1)+6 : INSTRING(')',TreeQ.szText)-1],szObjectName)
             szObjectType = 'STRUCTURE'
             ENABLE(?HyperlinkButton)
          END
     ELSE
        DISABLE(?HyperlinkButton)
     END
  ELSE
     DISABLE(?HyperlinkButton)
  END

  NoteQ.bClarionVersion = glo:bClarionVersion
  IF TreeQ.szContextString
     NoteQ.szLookup = UPPER(TreeQ.szContextString)
  ELSE
     NoteQ.szLookup = UPPER(TreeQ.szText)
  END
  GET(NoteQ,+NoteQ.bClarionVersion,+NoteQ.szLookup)
  IF ERRORCODE()
     ?ViewNoteButton{PROP:Icon} = '~newnote.ico'
     IF glo:bShowTips
        IF hwndTT
           tt.updatetiptext(?ViewNoteButton{PROP:HANDLE},'Add User Notes',0)
        END
     END
  ELSE
     ?ViewNoteButton{PROP:Icon} = '~note.ico'
     IF glo:bShowTips
        IF hwndTT
           tt.updatetiptext(?ViewNoteButton{PROP:HANDLE},'View User Notes',0)
        END
     END
  END

  ?LoadingString{PROP:Hide} = TRUE

  Window{PROP:Text} = 'ClassViewer [Clarion ' & szCaptionVersion & ' - ' & szCaptionView & ']'

  !====================================================================
  !Code for AsciiViewer
  !====================================================================
  IF TreeQ:wIcon = ICON:METHOD              |
  AND glo:bCurrentView = VIEW:CLASSES       |
  AND TreeQ.lModuleId <> 0                  |
  AND TreeQ.lSourceLine <> 0                        !View Definition
      ModuleId = TreeQ.lModuleId
      LineNo = TreeQ.lSourceLine

  ELSIF glo:bCurrentView = VIEW:CALLS   |
     AND ABS(TreeQ.lLevel) > 1          |
     AND TreeQ.lOccurranceLine <> 0                 !View Source
        J = POINTER(TreeQ)
        K = ABS(TreeQ.lLevel)
        LOOP I = J TO 1 BY -1
          GET(TreeQ,I)
          IF ABS(TreeQ.lLevel) < K
             BREAK
          END
        END
        ModuleId = TreeQ.lModuleId
        GET(TreeQ,J)
        LineNo = TreeQ.lOccurranceLine
  ELSE                                              !View Declaration
     CASE TreeQ:wIcon
       OF ICON:STRUCTURE OROF ICON:STRUCTUREFOLDER
          ModuleId = TreeQ.lModuleId
          LineNo = TreeQ.lLineNum
       OF ICON:EQUATE OROF ICON:EQUATEFOLDER OROF ICON:ENUMFOLDER
          ModuleId = TreeQ.lModuleId
          LineNo = TreeQ.lLineNum
       OF ICON:METHOD
          ModuleId = TreeQ.lIncludeId
          LineNo = TreeQ.lLineNum
       OF ICON:INTERFACEFOLDER OROF ICON:NEWINTERFACEFOLDER
          ModuleId = TreeQ.lIncludeId
          LineNo = TreeQ.lLineNum
     ELSE
          ModuleId = TreeQ.lIncludeId
          LineNo = TreeQ.lLineNum
     END
  END

  OMIT('***',_Scintilla_)
  IF ModuleId = 0
     IF ViewerActive
        Viewer.Kill()
        ViewerActive = FALSE
     END
  ELSE
     ModuleQ.lModuleId = ModuleId
     GET(ModuleQ,+ModuleQ.lModuleId)
    ASSERT(~ERRORCODE())
     IF ViewerActive AND AsciiFilename <> ModuleQ.szModulePath & ModuleQ.szModuleName
        Viewer.Kill()
        ViewerActive = FALSE
     END
     IF ViewerActive = FALSE
        AsciiFilename = ModuleQ.szModulePath & ModuleQ.szModuleName
        ViewerActive = Viewer.Init(AsciiFile,A1:Textline,AsciiFilename,?AsciiBox,GlobalErrors,EnableSearch+EnablePrint)
        DO SetAsciiBoxStyle
     END
     Viewer.DisplayPage(LineNo)
  END
  !***

  COMPILE('***',_Scintilla_)
  IF ModuleId = 0
     IF ViewerActive
        SciControl.ClearBuffer()
        ViewerActive = FALSE
     END
  ELSE
     ModuleQ.lModuleId = ModuleId
     GET(ModuleQ,+ModuleQ.lModuleId)
    ASSERT(~ERRORCODE())
     IF ViewerActive AND AsciiFilename <> ModuleQ.szModulePath & ModuleQ.szModuleName
        SciControl.ClearBuffer()
        ViewerActive = FALSE
     END
     IF ViewerActive = FALSE
        szAsciiFilename = CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName)
        loc:szAsciiFilename = '  Filename:  ' & szAsciiFilename
        DISPLAY(?loc:szAsciiFilename)
        SciControl.SetReadOnly(FALSE)
        ViewerActive = SciControl.OpenFile(szAsciiFilename)
        IF ViewerActive = TRUE
           SciControl.SetReadOnly(TRUE)
        END
     END
     sciControl.GoToLine(LineNo + ?sciControl:Region{PROP:LineCount})
     SciControl.GoToLine(LineNo-1)
  END
  !***
ExpandTree    ROUTINE
  J = RECORDS(TreeQ)
  LOOP I = 1 TO J
    GET(TreeQ,I)
    TreeQ.lLevel = ABS(TreeQ.lLevel)
    PUT(TreeQ)
  END
  GET(TreeQ,1)
  ?TreeList{PROP:Selected} = 1
  DISPLAY(?TreeList)
  SELECT(?TreeList)
  DO SaveTreeState
  EXIT
ContractTree    ROUTINE
  DATA
ABS:TreeQ:lLevel    LIKE(TreeQ.lLevel)
  CODE
  J = RECORDS(TreeQ)
  GET(TreeQ,J)
  ABS:TreeQ:lLevel = ABS(TreeQ.lLevel)
  lLastLevel = ABS:TreeQ:lLevel
  LOOP I = J TO 1 BY -1
    GET(TreeQ,I)
    ABS:TreeQ:lLevel = ABS(TreeQ.lLevel)
    IF ABS:TreeQ:lLevel > lLastLevel
       lLastLevel = ABS:TreeQ:lLevel
       TreeQ.lLevel = ABS:TreeQ:lLevel
    ELSIF ABS:TreeQ:lLevel < lLastLevel
       lLastLevel = ABS:TreeQ:lLevel
       TreeQ.lLevel = -1 * ABS:TreeQ:lLevel
    ELSE
       TreeQ.lLevel = ABS:TreeQ:lLevel
    END
    PUT(TreeQ)
  END
  GET(TreeQ,1)
  ?TreeList{PROP:Selected} = 1
  DISPLAY(?TreeList)
  SELECT(?TreeList)
  DO SaveTreeState
  EXIT
FillClassNameQ   ROUTINE
  DATA
loc:szSortName LIKE(ClassNameQ.szSortName)

  CODE
  loc:szSortName = ClassNameQ.szSortName
  FREE(ClassNameQ)
  J = RECORDS(ClassQ)
  LOOP I = 1 TO J
    GET(ClassQ,I)
    IF ~glo:bShowPrivate AND ClassQ.bPrivate
       CYCLE
    ELSIF glo:bCurrentView = VIEW:CLASSES AND ClassQ.bInterface
       CYCLE
    ELSIF glo:bCurrentView = VIEW:INTERFACES AND ~ClassQ:bInterface
       CYCLE
    ELSE
       !filter the class name queue
       IF glo:bCurrentView = VIEW:CLASSES
          IF glo:szCategory
             CategoryQ.szClassName = ClassQ.szClassName
             GET(CategoryQ,+CategoryQ.szClassName)
             IF CategoryQ.szCategory <> glo:szCategory
                CYCLE
             END
          END
       END

       ClassNameQ.szClassName = ClassQ.szClassName
       ClassNameQ.szSortName = UPPER(ClassQ.szClassName)

       !=======================================================================
       OldClassQ.szClassName = ClassQ.szClassName
       GET(OldClassQ,+OldClassQ.szClassName)
       IF ERRORCODE()
          ClassNameQ.lStyle = STYLE:NORMAL_NEW
       ELSE
          ClassNameQ.lStyle = STYLE:NORMAL
       END
       !=======================================================================

       GET(ClassNameQ,+ClassNameQ.szSortName)
       IF ERRORCODE()
          CASE glo:bABCOnly
          OF 0
             ADD(ClassNameQ,+ClassNameQ.szSortName)
          OF 1
             IF srcIsBaseClassABC(ClassQ.szClassName)
                ADD(ClassNameQ,+ClassNameQ.szSortName)
             END
          OF 2
             IF ~srcIsBaseClassABC(ClassQ.szClassName)
                ADD(ClassNameQ,+ClassNameQ.szSortName)
             END
          END
       END
    END
  END
  SORT(ClassNameQ,+ClassNameQ.szSortName)
  ClassNameQ.szSortName = loc:szSortName
  GET(ClassNameQ,+ClassNameQ.szSortName)
  ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
  EXIT
FillStructNameQ   ROUTINE
  FREE(StructNameQ)
  J = RECORDS(StructureQ)
  LOOP I = 1 TO J
    GET(StructureQ,I)
    IF ~glo:bShowPrivate AND StructureQ.bPrivate
       CYCLE
    ELSE
       StructNameQ.szStructureName = StructureQ.szStructureName
       StructNameQ.szStructureSort = UPPER(StructureQ.szStructureName)
       GET(StructNameQ,+StructNameQ.szStructureSort)
       IF ERRORCODE()
          ADD(StructNameQ,+StructNameQ.szStructureSort)
       END
     END
  END
  SORT(StructNameQ,+StructNameQ.szStructureSort)
  StructNameQ.szStructureSort = UPPER(glo:szParentClassName)
  GET(StructNameQ,+StructNameQ.szStructureSort)
  EXIT
FillEnumNameQ   ROUTINE
  FREE(EnumNameQ)
  J = RECORDS(EnumQ)
  LOOP I = 1 TO J
    GET(EnumQ,I)
    IF ~glo:bShowPrivate AND EnumQ.bPrivate
       CYCLE
    ELSE
       EnumNameQ.szEnumName = EnumQ.szEnumName
       EnumNameQ.szEnumSort = UPPER(EnumQ.szEnumName)
       GET(EnumNameQ,+EnumNameQ.szEnumSort)
       IF ERRORCODE()
          ADD(EnumNameQ,+EnumNameQ.szEnumSort)
       END
    END
  END
  SORT(EnumNameQ,+EnumNameQ.szEnumSort)
  EnumNameQ.szEnumSort = UPPER(glo:szParentClassName)
  GET(EnumNameQ,+EnumNameQ.szEnumSort)
  EXIT
FillCallNameQ   ROUTINE
  DATA
szCurrentClass  CSTRING(65)
K               LONG

  CODE
  SORT(ClassQ,+ClassQ.szClassSort)
  SORT(MethodQ,+MethodQ.lClassId,+MethodQ.szMethodSort)
  FREE(CallNameQ)
  J = RECORDS(CallQ)
  LOOP I = 1 TO J
    GET(CallQ,I)
    K = INSTRING('.',CallQ.szCallingMethod)
    IF K
       ClassQ.szClassSort = UPPER(CallQ.szCallingMethod[1 : K-1])
       GET(ClassQ,+ClassQ.szClassSort)
       CategoryQ.szClassName = ClassQ.szClassName
       GET(CategoryQ,+CategoryQ.szClassName)
       MethodQ.lClassId = ClassQ.lClassId
       MethodQ.szMethodSort = UPPER(CallQ.szCallingMethod[K+1 : LEN(CallQ.szCallingMethod)])
       GET(MethodQ,+MethodQ.lClassId,+MethodQ.szMethodSort)
       IF ~ERRORCODE()
          IF ~glo:bShowPrivate AND MethodQ.bPrivate
             CYCLE
          ELSIF ~glo:bShowModule AND MethodQ.bModule
             CYCLE
          ELSIF glo:szCategory AND CategoryQ.szCategory <> glo:szCategory
             CYCLE
          ELSE
             CASE glo:bABCOnly
             OF 1
                IF ~srcIsBaseClassABC(ClassQ.szClassSort)
                   CYCLE
                END
             OF 2
                IF srcIsBaseClassABC(ClassQ.szClassSort)
                   CYCLE
                END
             END
             CallNameQ.szCallName = CallQ.szCallingMethod
             CallNameQ.szSortName = UPPER(CallQ.szCallingMethod)
             GET(CallNameQ,+CallNameQ.szSortName)
             IF ERRORCODE()
                CallNameQ.szCallName = CallQ.szCallingMethod
                CallNameQ.szSortName = UPPER(CallQ.szCallingMethod)
                CallNameQ.lLevel = 2
                CallNameQ.lStyle = STYLE:NORMAL
                CallNameQ.bExpandedAbove = FALSE
                ADD(CallNameQ,+CallNameQ.szSortName)
                K = INSTRING('.',CallNameQ.szCallName)
                IF UPPER(szCurrentClass) <> UPPER(CallNameQ.szCallName[1 : K-1])
                   szCurrentClass = CallNameQ.szCallName[1 : K-1]
                   CallNameQ.szCallName = szCurrentClass
                   CallNameQ.lLevel = -1
                   CallNameQ.szSortName = UPPER(szCurrentClass)
                   CallNameQ.bExpandedAbove = FALSE

                   !=======================================================================
                   OldClassQ.szClassName = ClassQ.szClassName
                   GET(OldClassQ,+OldClassQ.szClassName)
                   IF ERRORCODE()
                      CallNameQ.lStyle = STYLE:NORMAL_NEW
                   ELSE
                      CallNameQ.lStyle = STYLE:NORMAL
                   END
                   !=======================================================================

                   ADD(CallNameQ,+CallNameQ.szSortName)
                END
             END
          END
       END
    END
  END

  SORT(CallNameQ,+CallNameQ.szSortName)

  CallNameQ.szSortName = UPPER(szLastCallName)
  GET(CallNameQ,+CallNameQ.szSortName)
  IF ERRORCODE()
     GET(CallNameQ,1)
     CallNameQ.lLevel = ABS(CallNameQ.lLevel)
     PUT(CallNameQ)
     GET(CallNameQ,2)
     szLastCallName = CallNameQ.szCallName
  END

  EXIT
FillOldClassQ   ROUTINE
  DATA
sav:szClassViewDatafile LIKE(szClassViewDatafile)

  CODE
  sav:szClassViewDatafile = szClassViewDatafile
  FREE(OldClassQ)
  CASE glo:bClarionVersion
    OF CWVERSION_C4
       szClassViewDatafile = 'CVIEW20S.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C5
       szClassViewDatafile = 'CVIEW40S.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C5EE
       szClassViewDatafile = 'CVIEW40S.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C55
       szClassViewDatafile = 'CVIEW50S.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C55EE
       szClassViewDatafile = 'CVIEW50E.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C60
       szClassViewDatafile = 'CVIEW55S.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C60EE
       szClassViewDatafile = 'CVIEW55E.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C70
       szClassViewDatafile = 'CVIEW60E.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C80
       szClassViewDatafile = 'CVIEW70.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C90
       szClassViewDatafile = 'CVIEW80.DAT'
       DO _FillOldClassQ
    OF CWVERSION_C100
       szClassViewDatafile = 'CVIEW100.DAT'  !mr 2021-05-29
       DO _FillOldClassQ
    OF CWVERSION_C110                        ! mr 2021-05-29
       szClassViewDatafile = 'CVIEW110.DAT'  ! mr 2021-05-29
       DO _FillOldClassQ                     ! mr 2021-05-29
  END
  szClassViewDatafile = sav:szClassViewDatafile

_FillOldClassQ   ROUTINE
  szClassViewDatafile = szValue & '\' & szClassViewDatafile
  IF Access:Memory(szClassViewDatafile,ACTION:LOAD) = LEVEL:Benign
     J = RECORDS(ClassQ)
     LOOP I = 1 TO J
       GET(ClassQ,I)
       OldClassQ.szClassName = ClassQ.szClassName
       ADD(OldClassQ,+OldClassQ.szClassName)
     END
     DO FillOldMethodQ
     DO FillOldPropertyQ
  END
FillOldMethodQ  ROUTINE
  DATA
N   LONG
P   LONG
  CODE
  SORT(ClassQ,+ClassQ.lClassId)
  N = RECORDS(MethodQ)
  LOOP P = 1 TO N
     GET(MethodQ,P)
     ClassQ.lClassId = MethodQ.lClassId
     GET(ClassQ,+ClassQ.lClassId)
     OldMethodQ.szClassName = ClassQ.szClassSort
     OldMethodQ.szMethodName = MethodQ.szMethodSort
     OldMethodQ.szPrototype = UPPER(MethodQ.szPrototype)
     ADD(OldMethodQ,+OldMethodQ.szClassName,+OldMethodQ.szMethodName,+OldMethodQ.szPrototype)
  END
  SORT(ClassQ,+ClassQ.szClassSort)
  EXIT
FillOldPropertyQ    ROUTINE
  DATA
N   LONG
P   LONG
  CODE
  SORT(ClassQ,+ClassQ.lClassId)
  N = RECORDS(PropertyQ)
  LOOP P = 1 TO N
     GET(PropertyQ,P)
     ClassQ.lClassId = PropertyQ.lClassId
     GET(ClassQ,+ClassQ.lClassId)
     OldPropertyQ.szClassName = ClassQ.szClassSort
     OldPropertyQ.szPropertyName = PropertyQ.szPropertySort
     ADD(OldPropertyQ,+OldPropertyQ.szClassName,+OldPropertyQ.szPropertyName)
  END
  SORT(ClassQ,+ClassQ.szClassSort)
  EXIT
FillCategoryQueue   ROUTINE
  FREE(CategoryQueue)
  J = RECORDS(CategoryQ)
  LOOP I = 1 TO J
    GET(CategoryQ,I)
    ClassQ.szClassName = CategoryQ.szClassName
    GET(ClassQ,+ClassQ.szClassName)
    IF ~ERRORCODE() AND ClassQ.szParentClassName = ''
       IF CategoryQ.szCategory
          CategoryQueue.szCategory = CategoryQ.szCategory
       ELSE
          CategoryQueue.szCategory = ' ALL'
       END
       GET(CategoryQueue,+CategoryQueue.szCategory)
       IF ERRORCODE()
          IF CategoryQ.szCategory
             CategoryQueue.szCategory = CategoryQ.szCategory
          ELSE
             CategoryQueue.szCategory = ' ALL'
          END
          ADD(CategoryQueue,+CategoryQueue.szCategory)
       END
    END
  END
  IF ~glo:szCategoryChoice
     glo:szCategoryChoice = ' ALL'
  END
  J = RECORDS(CategoryQueue)
  LOOP I = 1 TO J
    GET(CategoryQueue,I)
    IF CategoryQueue.szCategory = glo:szCategoryChoice
       BREAK
    END
  END
  IF ThisWindow.Opened
     ?glo:szCategoryChoice{PROP:Selected} = POINTER(CategoryQueue)
  END
InitExtraModuleQ    ROUTINE
  DATA

I               LONG
loc:szFileName  CSTRING(261)
subFolder       CSTRING(5)

  CODE
  IF glo:bClarionVersion > CWVERSION_C60EE
     subFolder = 'win\'
  ELSE
     subFolder = ''
  END
  LOOP I = 1 TO 8
    CASE I
    OF 1
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'equates.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'equates.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 2
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'errors.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'errors.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 3
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'property.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'property.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 4
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'prnprop.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'prnprop.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 5
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'keycodes.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'keycodes.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 6
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'tplequ.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'tplequ.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 7
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'winequ.clw'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'winequ.clw'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    OF 8
       loc:szFileName = szRoot & '\libsrc\' & subFolder & 'windows.inc'
       IF _access(loc:szFileName,0) = 0
          ExtraQ:bClarionVersion = glo:bClarionVersion
          ExtraModuleQ.szModuleName = 'windows.inc'
          ExtraModuleQ.szModulePath = szRoot & '\LIBSRC\' & subFolder
          ADD(ExtraModuleQ,+ExtraModuleQ.szModuleName,+ExtraModuleQ.szModulePath)
       END
    END
  END

  EXIT
SetupClassView  ROUTINE
   lLatchControl = ?ClassRegion           !make this the latched control
   DO DrawLatchBox
   glo:bCurrentView = VIEW:CLASSES        !view classes

   DO RefreshControls

   IF ~bHyperLinking
      srcRefreshTree()
   END

   DO FillClassNameQ
   DO FillCategoryQueue

   ?ObjectDropList{PROP:From} = ClassNameQ
   CASE glo:bABCOnly
   OF 0
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~All Classes~C@s63@'
   OF 1
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~ABC Classes~C@s63@'
   OF 2
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~Non-ABC Classes~C@s63@'
   END

   J = RECORDS(ClassNameQ)
   LOOP I = 1 TO J
      GET(ClassNameQ,I)
      IF ClassNameQ.szClassName = szObjectName
         BREAK
      END
   END
   IF I > J
      I = 1
   END
   GET(ClassNameQ,I)
   ?ObjectDropList{PROP:Selected} = I
   EXIT
SetupInterfaceView  ROUTINE
   lLatchControl = ?InterfaceRegion       !make this the latched control
   DO DrawLatchBox
   glo:bCurrentView = VIEW:INTERFACES     !view interfaces

   DO RefreshControls

   IF ~bHyperLinking
      srcRefreshTree()
   END

   DO FillClassNameQ
   DO FillCategoryQueue

   ?ObjectDropList{PROP:From} = ClassNameQ

   CASE glo:bABCOnly
   OF 0
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~All Classes~C@s63@'
   OF 1
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~ABC Classes~C@s63@'
   OF 2
      ?ObjectDropList{PROP:Format} = '252L(2)Y|~Non-ABC Classes~C@s63@'
   END

   J = RECORDS(ClassNameQ)
   LOOP I = 1 TO J
      GET(ClassNameQ,I)
      IF ClassNameQ.szClassName = szObjectName
         BREAK
      END
   END
   IF I > J
      I = 1
   END
   GET(ClassNameQ,I)
   ?ObjectDropList{PROP:Selected} = I
   EXIT
SetupStructureView  ROUTINE
   lLatchControl = ?StructureRegion       !make this the latched control
   DO DrawLatchBox
   glo:bCurrentView = VIEW:STRUCTURES     !view structures

   DO RefreshControls

   IF ~bHyperLinking
      GET(StructureQ,1)
      glo:szParentClassName = StructureQ.szStructureName
      srcRefreshTree()
   ELSE
      glo:szParentClassName = StructureQ.szStructureName
   END

   DO FillStructNameQ
   ?ObjectDropList{PROP:From} = StructNameQ
   ?ObjectDropList{PROP:Format} = '252L(2)|@s63@'

   J = RECORDS(StructNameQ)
   LOOP I = 1 TO J
      GET(StructNameQ,I)
      IF StructNameQ.szStructureName = szObjectName
         BREAK
      END
   END
   IF I > J
      I = 1
   END
   GET(StructNameQ,I)
   ?ObjectDropList{PROP:Selected} = I
   EXIT
SaveData    ROUTINE
  DATA
loc:sCurrentCursor  STRING(4)

  CODE
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szClassViewDatafile = 'CVIEW20S.DAT'
       FileClarion20 = FALSE
       ENABLE(?FileClarion20)
    OF CWVERSION_C4
       szClassViewDatafile = 'CVIEW40S.DAT'
       FileClarion40 = FALSE
       ENABLE(?FileClarion40)
    OF CWVERSION_C5
       szClassViewDatafile = 'CVIEW50S.DAT'
       FileClarion50 = FALSE
       ENABLE(?FileClarion50)
    OF CWVERSION_C5EE
       szClassViewDatafile = 'CVIEW50E.DAT'
       FileClarion50EE = FALSE
       ENABLE(?FileClarion50EE)
    OF CWVERSION_C55
       szClassViewDatafile = 'CVIEW55S.DAT'
       FileClarion55 = FALSE
       ENABLE(?FileClarion55)
    OF CWVERSION_C55EE
       szClassViewDatafile = 'CVIEW55E.DAT'
       FileClarion55EE = FALSE
       ENABLE(?FileClarion55EE)
    OF CWVERSION_C60
       szClassViewDatafile = 'CVIEW60S.DAT'
       FileClarion60 = FALSE
       ENABLE(?FileClarion60)
    OF CWVERSION_C60EE
       szClassViewDatafile = 'CVIEW60E.DAT'
       FileClarion60EE = FALSE
       ENABLE(?FileClarion60EE)
    OF CWVERSION_C70
       szClassViewDatafile = 'CVIEW70.DAT'
       FileClarion70 = FALSE
       ENABLE(?FileClarion70)
    OF CWVERSION_C80
       szClassViewDatafile = 'CVIEW80.DAT'
       FileClarion80 = FALSE
       ENABLE(?FileClarion80)
    OF CWVERSION_C90
       szClassViewDatafile = 'CVIEW90.DAT'
       FileClarion90 = FALSE
       ENABLE(?FileClarion90)
    OF CWVERSION_C100
       szClassViewDatafile = 'CVIEW100.DAT'
       FileClarion100 = FALSE
       ENABLE(?FileClarion100)
    OF CWVERSION_C110                          ! mr 2021-05-29
       szClassViewDatafile = 'CVIEW110.DAT'    ! mr 2021-05-29
       FileClarion110 = FALSE                  ! mr 2021-05-29   
       ENABLE(?FileClarion110)                 ! mr 2021-05-29 
  END

  INIMgr.Update('Options','RED File Path ' & glo:bClarionVersion,glo:szRedFilePath)

  szClassViewDatafile = szValue & '\' & szClassViewDatafile
  loc:sCurrentCursor = glo:sCurrentCursor
  glo:sCurrentCursor = CURSOR:WAIT
  SETCURSOR(glo:sCurrentCursor)
  ?SavingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
  ?SavingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
  HIDE(?VCRTop,?VCRBottom)
  UNHIDE(?SavingString)
  DISPLAY()
  Access:Memory(szClassViewDatafile,ACTION:SAVE)
  HIDE(?SavingString)
  UNHIDE(?VCRTop,?VCRBottom)
  glo:sCurrentCursor = loc:sCurrentCursor
  SETCURSOR(glo:sCurrentCursor)
  EXIT
LoadData    ROUTINE
  DATA
loc:build           CSTRING(5)
loc:szSection       CSTRING(256)
loc:szRoot          CSTRING(261)
loc:szRedFileName   CSTRING(261)
loc:szXMLFilename   CSTRING(261)
loc:sCurrentCursor  STRING(4)
cc                  LONG

i                   LONG

  CODE
  DO FillOldClassQ

  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szClassViewDatafile = 'CVIEW20S.DAT'
       FileClarion20 = TRUE
       DISABLE(?FileClarion20)
       loc:szSection = 'Clarion for Windows V2.0'
       loc:szRedFileName = '\bin\cw20.red'
    OF CWVERSION_C4
       szClassViewDatafile = 'CVIEW40S.DAT'
       FileClarion40 = TRUE
       DISABLE(?FileClarion40)
       loc:szSection = 'Clarion 4'
       loc:szRedFileName = '\bin\clarion4.red'
    OF CWVERSION_C5
       szClassViewDatafile = 'CVIEW50S.DAT'
       FileClarion50 = TRUE
       DISABLE(?FileClarion50)
       loc:szSection = 'Clarion 5'
       loc:szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C5EE
       szClassViewDatafile = 'CVIEW50E.DAT'
       FileClarion50EE = TRUE
       DISABLE(?FileClarion50EE)
       loc:szSection = 'Clarion 5  Enterprise Edition'
       loc:szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C55
       szClassViewDatafile = 'CVIEW55S.DAT'
       FileClarion55 = TRUE
       DISABLE(?FileClarion55)
       loc:szSection = 'Clarion 5.5'
       loc:szRedFileName = '\bin\c55pe.red'
    OF CWVERSION_C55EE
       szClassViewDatafile = 'CVIEW55E.DAT'
       FileClarion55EE = TRUE
       DISABLE(?FileClarion55EE)
       loc:szSection = 'Clarion 5.5  Enterprise Edition'
       loc:szRedFileName = '\bin\c55ee.red'
    OF CWVERSION_C60
       szClassViewDatafile = 'CVIEW60S.DAT'
       FileClarion60 = TRUE
       DISABLE(?FileClarion60)
       loc:szSection = 'Clarion 6.0'
       loc:szRedFileName = '\bin\c60pe.red'
    OF CWVERSION_C60EE
       szClassViewDatafile = 'CVIEW60E.DAT'
       FileClarion60EE = TRUE
       DISABLE(?FileClarion60EE)
       loc:szSection = 'Clarion 6.0  Enterprise Edition'
       loc:szRedFileName = '\bin\c60ee.red'
    OF CWVERSION_C70
       szClassViewDatafile = 'CVIEW70.DAT'
       FileClarion70 = TRUE
       DISABLE(?FileClarion70)
       loc:szSection = 'Clarion 7.'

       !need to get red filename this from xml file
       !CSIDL_APPDATA   EQUATE(01ah)
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END

       !look for latest clarion7 install
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C80
       szClassViewDatafile = 'CVIEW80.DAT'
       FileClarion80 = TRUE
       DISABLE(?FileClarion80)
       loc:szSection = 'Clarion 8.'

       !need to get red filename this from xml file
       !CSIDL_APPDATA   EQUATE(01ah)
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END

       !look for latest clarion8 install
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C90
       szClassViewDatafile = 'CVIEW90.DAT'
       FileClarion90 = TRUE
       DISABLE(?FileClarion90)
       loc:szSection = 'Clarion 9.'

       !need to get red filename this from xml file
       !CSIDL_APPDATA   EQUATE(01ah)
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END

       !look for latest clarion9 install
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C100 
       szClassViewDatafile = 'CVIEW100.DAT'
       FileClarion100 = TRUE
       DISABLE(?FileClarion100)
       loc:szSection = 'Clarion 10.'

       !need to get red filename this from xml file
       !CSIDL_APPDATA   EQUATE(01ah)
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END

       !look for latest clarion10 install
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END
       
    !mr 2021-05-29 - added this OF block
    OF CWVERSION_C110                            
       szClassViewDatafile = 'CVIEW110.DAT'
       FileClarion110 = TRUE
       DISABLE(?FileClarion110)
       loc:szSection = 'Clarion 11.'

       !need to get red filename this from xml file
       !CSIDL_APPDATA   EQUATE(01ah)
       IF RECORDS(glo:VersionQ) = 0
          cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\11.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END

       !look for latest clarion11 install
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

  END

  DO LoadRedirectionQueue
  loc:szRoot = szRoot

  IF glo:bClarionVersion < CWVERSION_C70
     glo:szRedFilePath = loc:szRoot & loc:szRedFileName
  ELSE
     glo:szRedFilePath = glo:VersionQ.RedDir & '\' & loc:szRedFileName
  END
  INIMgr.Fetch('Options','RED File Path ' & glo:bClarionVersion,glo:szRedFilePath)

  szClassViewDatafile = szValue & '\' & szClassViewDatafile
  loc:sCurrentCursor = glo:sCurrentCursor
  glo:sCurrentCursor = CURSOR:WAIT
  SETCURSOR(glo:sCurrentCursor)
  ?LoadingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
  ?LoadingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
  HIDE(?VCRTop,?VCRBottom)
  UNHIDE(?LoadingString)
  DISPLAY(?LoadingString)
  cc = Access:Memory(szClassViewDatafile,ACTION:LOAD)
  IF (cc <> Level:Benign) OR (cc = Level:Benign AND RECORDS(ModuleQ) = 0)
     HIDE(?LoadingString)
     HIDE(?TreeList)
     HIDE(?AsciiBox)
   COMPILE('***',_Scintilla_)
     SciControl.SetHide(TRUE)
   !***
     HIDE(?loc:szAsciiFilename)
     HIDE(?VirtualBox,?EnumeratedEquate:String)
     HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)
     HIDE(?ObjectDropList)
     HIDE(?SplitterBar)
     HIDE(?SplitterBar:2)
     HIDE(?VerticalSplitter)
     HIDE(?HyperlinkButton,?HistoryList)
     HIDE(?VcrTop,?VcrBottom)

     FREE(TreeStateQ)

     IF ~RECORDS(ExtraModuleQ)
        DO InitExtraModuleQ
     END

   COMPILE('***',_Scintilla_)
     SciControl.SetReadOnly(FALSE)
     SciControl.ClearAll()
     loc:szAsciiFilename = '  Filename:'
     DISPLAY(?loc:szAsciiFilename)
   !***

     glo:bRefreshAll = TRUE
     srcRefreshQueues(?ProcessString,?ScanString,?ProgressBox,?ProgressBox:2,?RefreshGroup)
     glo:bRefreshAll = FALSE
     srcRefreshQueues(?ProcessString,?ScanString,?ProgressBox,?ProgressBox:2,?RefreshGroup)

     UNHIDE(?ObjectDropList)
     UNHIDE(?SplitterBar)
     UNHIDE(?SplitterBar:2)
     UNHIDE(?VerticalSplitter)
     UNHIDE(?HyperlinkButton,?HistoryList)
     UNHIDE(?TreeList)
   OMIT('***',_scintilla_)
     UNHIDE(?AsciiBox)
   !***
   COMPILE('***',_Scintilla_)
     SciControl.SetReadOnly(TRUE)
     SciControl.SetHide(FALSE)
   !***
     UNHIDE(?loc:szAsciiFilename)
     ?SavingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
     ?SavingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
     UNHIDE(?SavingString)
     DISPLAY()
     Access:Memory(szClassViewDatafile,ACTION:SAVE)
     HIDE(?SavingString)
     UNHIDE(?VcrTop,?VcrBottom)
  ELSE
     srcRefreshTree()
  END

  DO SetTreeStyles

  OMIT('***',UseDefaultWordlist=1)
  srcGetWordList(szClarionKeywords, szCompilerDirectives, szBuiltinProcsFuncs, szStructDataTypes, szAttributes, szStandardEquates)
  !***

  lLatchControl = 0
  CASE glo:bCurrentView
    OF VIEW:CLASSES
       POST(EVENT:Accepted,?ClassRegion)
    OF VIEW:STRUCTURES
       POST(EVENT:Accepted,?StructureRegion)
    OF VIEW:EQUATES
       POST(EVENT:Accepted,?EquateRegion)
    OF VIEW:CALLS
       IF RECORDS(CallNameQ)
          szLastCallName = CallNameQ.szCallName
       ELSE
          szLastCallName = 'WindowManager.Run'
       END
       POST(EVENT:Accepted,?TreeRegion)
    OF VIEW:INTERFACES
       POST(EVENT:Accepted,?InterfaceRegion)
  END

  HIDE(?LoadingString)
  UNHIDE(?VCRTop,?VCRBottom)
  glo:sCurrentCursor = loc:sCurrentCursor
  SETCURSOR(glo:sCurrentCursor)
  EXIT
SetScreenLayout ROUTINE
  DATA
X       LONG
Y       LONG

  CODE

  ?LocatorImage{PROP:Hide} = TRUE
  ?Locator{PROP:Hide} = false

  glo:Layout = 0
  INIMgr.Fetch('Splitter','Layout',glo:Layout)


  CASE glo:Layout
  OF 1
     X = 80
     INIMgr.Fetch('Splitter','XPos',X)
     Y = 210
     INIMgr.Fetch('Splitter','VXPos',Y)
     Splitter1_XPos = X
     Splitter2_XPos = Y

     ?TreeList{PROP:Height} = ?ObjectDropList{PROP:Height}
     ?TreeList{PROP:Width} = X+2 - Y
     ?TreeList{PROP:XPos} = X+2

     ?AsciiBox{PROP:Height} = ?ObjectDropList{PROP:Height} - SPLITTERHEIGHT + 2
     ?AsciiBox{PROP:Width} = Window{PROP:Width} - (Y+3) - 8
     ?AsciiBox{PROP:XPos} = Y+3
     ?AsciiBox{PROP:YPos} = ?ObjectDropList{PROP:YPos} + SPLITTERHEIGHT - 2

     ?SplitterBar{PROP:Height} = ?TreeList{PROP:Height} !+ 18
     ?SplitterBar{PROP:YPos} = ?TreeList{PROP:YPos} !- 18

     ?VerticalSplitter{PROP:XPos} = Y
     ?VerticalSplitter{PROP:YPos} = ?TreeList{PROP:YPos}
     ?VerticalSplitter{PROP:Width} = 2
     ?VerticalSplitter{PROP:Height} = ?TreeList{PROP:Height}

  ELSE  !default layout
     INIMgr.Fetch('Splitter','XPos', X)
     INIMgr.Fetch('Splitter','YPos', Y)
     Splitter1_XPos = X
     Splitter2_YPos = Y

     ?TreeList{PROP:YPos} = ?ObjectDropList{PROP:YPos}
     ?SplitterBar{PROP:Height} = ?ObjectDropList{PROP:Height}
     ?SplitterBar{PROP:YPos} = ?ObjectDropList{PROP:YPos}
     ?VerticalSplitter{PROP:XPos} = ?TreeList{PROP:XPos}
     ?VerticalSplitter{PROP:YPos} = ?TreeList{PROP:YPos} + ?TreeList{PROP:Height}
     ?VerticalSplitter{PROP:Width} = ?TreeList{PROP:Width}
     ?VerticalSplitter{PROP:Height} = 2
  END

  ?ObjectDropList{PROP:SelectedFillColor} = glo:lSelectedBack
  CASE glo:bCurrentView
    OF VIEW:CLASSES OROF VIEW:INTERFACES
       GET(ClassNameQ,1)
       ?ObjectDropList{PROP:From} = ClassNameQ
       ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
       CASE glo:bABCOnly
       OF 0
          ?ObjectDropList{PROP:Format} = '252L(2)Y|~All Classes~C@s63@'
       OF 1
          ?ObjectDropList{PROP:Format} = '252L(2)Y|~ABC Classes~C@s63@'
       OF 2
          ?ObjectDropList{PROP:Format} = '252L(2)Y|~Non-ABC Classes~C@s63@'
       END
    OF VIEW:STRUCTURES
       GET(StructNameQ,1)
       ?ObjectDropList{PROP:From} = StructNameQ
       ?ObjectDropList{PROP:Selected} = POINTER(StructNameQ)
       ?ObjectDropList{PROP:Format} = '252L(2)|@s63@'
    OF VIEW:EQUATES
       GET(EnumNameQ,1)
       ?ObjectDropList{PROP:From} = EnumNameQ
       ?ObjectDropList{PROP:Selected} = POINTER(EnumNameQ)
       ?ObjectDropList{PROP:Format} = '252L(2)|@s63@'
    OF VIEW:CALLS
       GET(CallNameQ,1)
       ?ObjectDropList{PROP:From} = CallNameQ
       ?ObjectDropList{PROP:Selected} = POINTER(CallNameQ)
       CASE glo:bABCOnly
       OF 0
          ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~All Classes~C@s63@'
       OF 1
          ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~ABC Classes~C@s63@'
       OF 2
          ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~Non-ABC Classes~C@s63@'
       END
  END
  EXIT
RefreshControls ROUTINE
   CASE glo:bCurrentView
   OF VIEW:CLASSES
      HIDE(?EquateBox,?EnumeratedEquate:String)
      UNHIDE(?VirtualBox,?VirtualString)
      UNHIDE(?glo:bShowProtected,?glo:bShowModule)
      IF glo:bShowProtected
         UNHIDE(?ProtectedBox,?ProtectedString)
      ELSE
         HIDE(?ProtectedBox,?ProtectedString)
      END
      IF glo:bShowPrivate
         UNHIDE(?PrivateBox,?PrivateString)
      ELSE
         HIDE(?PrivateBox,?PrivateString)
      END
      IF glo:bShowModule
         UNHIDE(?ModuleBox,?ModuleString)
      ELSE
         HIDE(?ModuleBox,?ModuleString)
      END
      !UNHIDE(?glo:bABCOnly+1,?glo:bDetailLevel)
      UNHIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)

   OF VIEW:INTERFACES
      HIDE(?EquateBox,?EnumeratedEquate:String)
      UNHIDE(?VirtualBox,?VirtualString)
      HIDE(?ProtectedBox,?glo:bShowModule)
      HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)

   OF VIEW:CALLS
      HIDE(?EquateBox,?EnumeratedEquate:String)
      UNHIDE(?VirtualBox,?VirtualString)
      UNHIDE(?glo:bShowProtected,?glo:bShowModule)
      IF glo:bShowProtected
         UNHIDE(?ProtectedBox,?ProtectedString)
      ELSE
         HIDE(?ProtectedBox,?ProtectedString)
      END
      IF glo:bShowPrivate
         UNHIDE(?PrivateBox,?PrivateString)
      ELSE
         HIDE(?PrivateBox,?PrivateString)
      END
      IF glo:bShowModule
         UNHIDE(?ModuleBox,?ModuleString)
      ELSE
         HIDE(?ModuleBox,?ModuleString)
      END
      !HIDE(?glo:bABCOnly,?glo:bDetailLevel)
      HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)

      !UNHIDE(?glo:bABCOnly+1,?glo:szCategoryChoice)   !?glo:bDetailLevel)
      UNHIDE(?glo:szCategory:Prompt,?glo:szCategoryChoice)

   OF VIEW:STRUCTURES
      HIDE(?EquateBox,?EnumeratedEquate:String)
      HIDE(?VirtualBox,?glo:bShowModule)
      IF glo:bShowPrivate
         UNHIDE(?PrivateBox,?PrivateString)
      ELSE
         HIDE(?PrivateBox,?PrivateString)
      END
      UNHIDE(?glo:bShowPrivate)
      !HIDE(?glo:bABCOnly,?glo:bDetailLevel)
      HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)

   OF VIEW:EQUATES
      HIDE(?VirtualBox,?glo:bShowModule)
      UNHIDE(?EquateBox,?EnumeratedEquate:String)
      IF glo:bShowPrivate
         UNHIDE(?PrivateBox,?PrivateString)
      ELSE
         HIDE(?PrivateBox,?PrivateString)
      END
      UNHIDE(?glo:bShowPrivate)
      !HIDE(?glo:bABCOnly,?glo:bDetailLevel)
      HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)
   END

   DISPLAY()
   EXIT
ExpandParentNodes   ROUTINE
  DATA
MyParent    LIKE(ClassQ.szClassName)
pByte       LONG
pBit        BYTE
n           LONG
qRecords    LONG
  CODE

  CASE glo:bCurrentView
  OF VIEW:CLASSES OROF VIEW:INTERFACES
     GET(TreeQ,1)
     TreeStateQ.szClassName = TreeQ.szClassName
     GET(TreeStateQ,+TreeStateQ.szClassName)
     IF ~ERRORCODE()
        qRecords = RECORDS(TreeQ)
        pByte = 0
        n = 0
        LOOP UNTIL n > qRecords OR pByte > 1000
          pByte += 1
          pBit = 0
          LOOP 8 TIMES
            pBit += 1
            n += 1
            IF n > qRecords
               BREAK
            ELSIF BAND(TreeStateQ.state[pByte],BSHIFT(1,8-pBit))
               GET(TreeQ,n)
               TreeQ.lLevel = ABS(TreeQ.lLevel)
               PUT(TreeQ)
            END
          END
        END
     END
  END

  !Expand Starting Node
  !----------------------------------------------
  GET(TreeQ,I)
  IF glo:bAutoExpand OR I = 1
     TreeQ.lLevel = ABS(TreeQ.lLevel)
     PUT(TreeQ)
  END

  !Look for parents and expand them
  !----------------------------------------------
  ClassQ.szClassSort = UPPER(TreeQ.szClassName)
  GET(ClassQ,+ClassQ.szClassSort)
  MyParent = ClassQ.szParentClassName
  LOOP J = I TO 1 BY -1
    GET(TreeQ,J)
    IF TreeQ.szSearch = MyParent
       TreeQ.lLevel = ABS(TreeQ.lLevel)
       PUT(TreeQ)
       ClassQ.szClassSort = UPPER(TreeQ.szClassName)
       GET(ClassQ,+ClassQ.szClassSort)
       MyParent = ClassQ.szParentClassName
    END
    IF ABS(TreeQ.lLevel) = 1
       TreeQ.lLevel = ABS(TreeQ.lLevel)
       PUT(TreeQ)
       BREAK
    END
  END

  !get starting node and select it
  !----------------------------------------------
  GET(TreeQ,I)
  ?TreeList{PROP:Selected} = POINTER(TreeQ)

  !get matching class record
  !----------------------------------------------
  ClassQ.szClassSort = UPPER(TreeQ.szClassName)
  GET(ClassQ,+ClassQ.szClassSort)

  EXIT
ProcessNewDetailLevel   ROUTINE
  DATA
loc:TreeQ:szText    LIKE(TreeQ.szText)
loc:sCurrentCursor  STRING(4)

  CODE
  IF bCurrentDetailLevel <> glo:bDetailLevel
     bCurrentDetailLevel = glo:bDetailLevel
     loc:sCurrentCursor = glo:sCurrentCursor
     glo:sCurrentCursor = CURSOR:WAIT
     SETCURSOR(glo:sCurrentCursor)

     GET(TreeQ,CHOICE(?TreeList))
     loc:TreeQ:szText = TreeQ.szText

     DO FillCallNameQ

     FREE(TreeStateQ)

     srcRefreshTree()

     DO FillClassNameQ
     DO FillCategoryQueue

     J = RECORDS(TreeQ)
     IF J
        LOOP I = 1 TO J
          GET(TreeQ,I)
          IF TreeQ.szText = loc:TreeQ:szText
             BREAK
          END
        END
        IF I > J
           I = 1
        END
        DO ExpandParentNodes
     END

     glo:sCurrentCursor = loc:sCurrentCursor
     SETCURSOR(glo:sCurrentCursor)
  END
SaveTreeState   ROUTINE
  DATA
pByte   LONG,AUTO
pBit    BYTE,AUTO

  CODE
    !save our position in the treeq
    K = POINTER(TreeQ)

    !Make sure we have a TreeStateQ record for this class
    GET(TreeQ,1)
    TreeStateQ.szClassName = TreeQ.szClassName
    GET(TreeStateQ,+TreeStateQ.szClassName)
    IF ERRORCODE()
       CLEAR(TreeStateQ)
       TreeStateQ.szClassName = TreeQ.szClassName
       ADD(TreeStateQ,+TreeStateQ.szClassName)
    END

    !spin through treeq and save expanded/contracted state in TreeStateQ
    CLEAR(TreeStateQ.state[])
    pBit = 0
    J = RECORDS(TreeQ)
    LOOP I = 1 TO J
      GET(TreeQ,I)
      pByte = INT((I-1)/8)+1
      IF pByte > 1000
         BREAK
      ELSE
         IF pBit < 8
            pBit += 1
         ELSE
            pBit = 1
         END
         IF TreeQ.lLevel > 0
            TreeStateQ.state[pByte] = BOR(TreeStateQ.state[pByte],BSHIFT(1,8-pBit))
         END
      END
    END
    PUT(TreeStateQ)

    !reget our treeq record
    GET(TreeQ,K)

    EXIT
SetAlerts   ROUTINE
  ?ObjectDropList{PROP:ALRT,255} = Key0
  ?ObjectDropList{PROP:ALRT,255} = Key1
  ?ObjectDropList{PROP:ALRT,255} = Key2
  ?ObjectDropList{PROP:ALRT,255} = Key3
  ?ObjectDropList{PROP:ALRT,255} = Key4
  ?ObjectDropList{PROP:ALRT,255} = Key5
  ?ObjectDropList{PROP:ALRT,255} = Key6
  ?ObjectDropList{PROP:ALRT,255} = Key7
  ?ObjectDropList{PROP:ALRT,255} = Key8
  ?ObjectDropList{PROP:ALRT,255} = Key9
  ?ObjectDropList{PROP:ALRT,255} = AKey
  ?ObjectDropList{PROP:ALRT,255} = BKey
  ?ObjectDropList{PROP:ALRT,255} = CKey
  ?ObjectDropList{PROP:ALRT,255} = DKey
  ?ObjectDropList{PROP:ALRT,255} = EKey
  ?ObjectDropList{PROP:ALRT,255} = FKey
  ?ObjectDropList{PROP:ALRT,255} = GKey
  ?ObjectDropList{PROP:ALRT,255} = HKey
  ?ObjectDropList{PROP:ALRT,255} = IKey
  ?ObjectDropList{PROP:ALRT,255} = JKey
  ?ObjectDropList{PROP:ALRT,255} = KKey
  ?ObjectDropList{PROP:ALRT,255} = LKey
  ?ObjectDropList{PROP:ALRT,255} = MKey
  ?ObjectDropList{PROP:ALRT,255} = NKey
  ?ObjectDropList{PROP:ALRT,255} = OKey
  ?ObjectDropList{PROP:ALRT,255} = PKey
  ?ObjectDropList{PROP:ALRT,255} = QKey
  ?ObjectDropList{PROP:ALRT,255} = RKey
  ?ObjectDropList{PROP:ALRT,255} = SKey
  ?ObjectDropList{PROP:ALRT,255} = TKey
  ?ObjectDropList{PROP:ALRT,255} = UKey
  ?ObjectDropList{PROP:ALRT,255} = VKey
  ?ObjectDropList{PROP:ALRT,255} = WKey
  ?ObjectDropList{PROP:ALRT,255} = XKey
  ?ObjectDropList{PROP:ALRT,255} = YKey
  ?ObjectDropList{PROP:ALRT,255} = ZKey
  ?ObjectDropList{PROP:ALRT,255} = ShiftA
  ?ObjectDropList{PROP:ALRT,255} = ShiftB
  ?ObjectDropList{PROP:ALRT,255} = ShiftC
  ?ObjectDropList{PROP:ALRT,255} = ShiftD
  ?ObjectDropList{PROP:ALRT,255} = ShiftE
  ?ObjectDropList{PROP:ALRT,255} = ShiftF
  ?ObjectDropList{PROP:ALRT,255} = ShiftG
  ?ObjectDropList{PROP:ALRT,255} = ShiftH
  ?ObjectDropList{PROP:ALRT,255} = ShiftI
  ?ObjectDropList{PROP:ALRT,255} = ShiftJ
  ?ObjectDropList{PROP:ALRT,255} = ShiftK
  ?ObjectDropList{PROP:ALRT,255} = ShiftL
  ?ObjectDropList{PROP:ALRT,255} = ShiftM
  ?ObjectDropList{PROP:ALRT,255} = ShiftN
  ?ObjectDropList{PROP:ALRT,255} = ShiftO
  ?ObjectDropList{PROP:ALRT,255} = ShiftP
  ?ObjectDropList{PROP:ALRT,255} = ShiftQ
  ?ObjectDropList{PROP:ALRT,255} = ShiftR
  ?ObjectDropList{PROP:ALRT,255} = ShiftS
  ?ObjectDropList{PROP:ALRT,255} = ShiftT
  ?ObjectDropList{PROP:ALRT,255} = ShiftU
  ?ObjectDropList{PROP:ALRT,255} = ShiftV
  ?ObjectDropList{PROP:ALRT,255} = ShiftW
  ?ObjectDropList{PROP:ALRT,255} = ShiftX
  ?ObjectDropList{PROP:ALRT,255} = ShiftY
  ?ObjectDropList{PROP:ALRT,255} = ShiftZ
  ?ObjectDropList{PROP:ALRT,255} = 445  !underscore
  EXIT
CreateFavoritesMenu  ROUTINE
  DATA

  CODE
  DO DestroyFavoritesMenu

  J = RECORDS(FavoritesQ)
  LOOP I = 1 TO J
     GET(FavoritesQ,I)
?    ASSERT(FavoritesQ.MenuFeq = 0)
     IF FavoritesQ.MenuFeq = 0
        FavoritesQ.MenuFeq = CREATE(0,CREATE:ITEM,?ToolsFavorites,FavoritesQ.SequenceNo)
        PUT(FavoritesQ)
        CASE I
        OF 1
           lFirstFavoriteMenuFeq = FavoritesQ.MenuFeq
           IF J = 1
              lLastFavoriteMenuFeq = FavoritesQ.MenuFeq
           END
        OF J
           lLastFavoriteMenuFeq = FavoritesQ.MenuFeq
        END
        FavoritesQ.MenuFeq{PROP:Text} = FavoritesQ.szName
        UNHIDE(FavoritesQ.MenuFeq)
     END
  END

  LOOP I = 1 TO J
     GET(FavoritesQ,I)
     DO CreateFavoriteButton
  END

  EXIT

CreateFavoriteButton ROUTINE
  DATA
X           LONG,AUTO
N           LONG,AUTO
lFollows    LONG,AUTO
szFile      CSTRING(261)
szDirectory CSTRING(261)
szResult    CSTRING(261)

lResult     LONG
hkResult    ULONG
szSubKey    CSTRING(256)
szValueName CSTRING(32)
dwType      ULONG
DataBuffer  CSTRING(64)
dwData      ULONG

  CODE

  N = RECORDS(CtrlQueue)
  IF (?Panel6{PROP:XPOS} + 3 + (N * 14)) <= (?HyperlinkButton{PROP:XPOS} - 14)

     CtrlQueue.ControlFeq = CREATE(0,CREATE:BUTTON)
     CtrlQueue.MenuFeq = FavoritesQ.MenuFeq
     ADD(CtrlQueue,+CtrlQueue.ControlFeq)

     N = RECORDS(CtrlQueue)
     IF N = 1
        lFirstControlFeq = CtrlQueue.ControlFeq
        lFollows = ?Panel6 !?CallTreeButton
     ELSE
        lFollows = lLastControlFeq
     END

     lLastControlFeq = CtrlQueue.ControlFeq


     !X = ?CallTreeButton{PROP:XPOS} + (N * 14)
     X = ?Panel6{PROP:XPOS} + 3 + ((N-1) * 14)
     SETPOSITION(CtrlQueue.ControlFeq,X,1,12,12)

     CtrlQueue.ControlFeq{PROP:TRN} = TRUE
     CtrlQueue.ControlFeq{PROP:FLAT} = TRUE
     CtrlQueue.ControlFeq{PROP:SKIP} = TRUE
     CtrlQueue.ControlFeq{PROP:FOLLOWS} = lFollows

     IF hwndTT
        X = INSTRING('&',FavoritesQ.szName)
        N = LEN(FavoritesQ.szName)
        IF X
           tt.addtip(CtrlQueue.ControlFeq{PROP:HANDLE},FavoritesQ.szName[1 : X-1] & FavoritesQ.szName[X+1 : N],0)
        ELSE
           tt.addtip(CtrlQueue.ControlFeq{PROP:HANDLE},FavoritesQ.szName,0)
        END

     END

     CtrlQueue.ControlFeq{PROP:ICON} = '~UNKNOWN.ICO'
     IF UPPER(SUB(FavoritesQ.szPath,-12,12)) = 'CSSEARCH.EXE'
        CtrlQueue.ControlFeq{PROP:ICON} = '~CSSEARCH.ICO'
     ELSIF UPPER(SUB(FavoritesQ.szPath,-3,3)) = 'EXE'
        CtrlQueue.ControlFeq{PROP:ICON} = SHORTPATH(FavoritesQ.szPath) & '[0]'
     ELSIF INSTRING(':',FavoritesQ.szPath[3 : LEN(FavoritesQ.szPath)])
        N = INSTRING(':',FavoritesQ.szPath[3 : LEN(FavoritesQ.szPath)])
        szSubKey = FavoritesQ.szPath[1 : N+1] & '\Shell\open\command'
        lResult = RegOpenKeyEx(HKEY_CLASSES_ROOT,szSubKey,0,KEY_QUERY_VALUE,hkResult)
        IF lResult = ERROR_SUCCESS
           szValueName = ''
           dwData = 64
           lResult = RegQueryValueEx(hkResult,szValueName,0,dwType,ADDRESS(DataBuffer),dwData)
           IF lResult = ERROR_SUCCESS
              IF DataBuffer[1] = '"'
                 N = INSTRING('"',DataBuffer[2 : dwData])
                 CtrlQueue.ControlFeq{PROP:ICON} = SHORTPATH(DataBuffer[2 : N]) & '[0]'
              ELSE
                 N = INSTRING(' ',DataBuffer)
                 IF N
                    CtrlQueue.ControlFeq{PROP:ICON} = SHORTPATH(DataBuffer[1 : N-1]) & '[0]'
                 ELSE
                    CtrlQueue.ControlFeq{PROP:ICON} = SHORTPATH(CLIP(DataBuffer)) & '[0]'
                 END
              END
           END
           lResult = RegCloseKey(hkResult)
        END
     ELSE
        N = LEN(FavoritesQ.szPath)
        szDirectory = ''
        LOOP X = N TO 1 BY -1
           IF FavoritesQ.szPath[X] = '\'
              szFile = FavoritesQ.szPath[X+1 : N] ! Filename Only
              szDirectory = UPPER( FavoritesQ.szPath[1: X-1] )
              BREAK
           END  ! Pos Directory Separator
        END
        IF CLIP(szDirectory) = ''
           szFile = FavoritesQ.szPath
           szDirectory = PATH()
        END  ! Pos Directory Required
        IF FindExecutable(szFile,szDirectory,szResult) > 32
           CtrlQueue.ControlFeq{PROP:ICON} = SHORTPATH(szResult) & '[0]'
        END
     END

     CtrlQueue.ControlFeq{PROP:HIDE} = FALSE
  END

  EXIT
DestroyFavoritesMenu  ROUTINE
  J = RECORDS(FavoritesQ)
  LOOP I = 1 TO J
     GET(FavoritesQ,I)
     IF FavoritesQ.MenuFeq <> 0
        DESTROY(FavoritesQ.MenuFeq)
        FavoritesQ.MenuFeq = 0
        PUT(FavoritesQ)
     END
  END
  lFirstFavoriteMenuFeq = 0
  lLastFavoriteMenuFeq = 0

  DO DestroyCtrlQueue

  EXIT

DestroyCtrlQueue ROUTINE
  J = RECORDS(CtrlQueue)
  LOOP I = 1 TO J
     GET(CtrlQueue,I)
     IF CtrlQueue.ControlFeq <> 0
        IF hwndTT
           tt.deltool(CtrlQueue.ControlFeq{PROP:HANDLE})
        END
        DESTROY(CtrlQueue.ControlFeq)
     END
  END
  FREE(CtrlQueue)
  lFirstControlFeq = 0
  lLastControlFeq = 0
ProcessFavoritesMenu    ROUTINE
  DATA

szURL   CSTRING(256)
szNull  CSTRING(2)

  CODE

  J = RECORDS(FavoritesQ)
  LOOP I = 1 TO J
     GET(FavoritesQ,I)
     IF FavoritesQ.MenuFeq = ACCEPTED()
        szURL = FavoritesQ.szPath
        szNull = ''
        ShellExecute(window{prop:handle},0,szURL,0,szNull,1)
        BREAK
     END
  END

  EXIT

ProcessFavoriteButton   ROUTINE
  DATA

szURL   CSTRING(256)
szNull  CSTRING(2)

  CODE

  CtrlQueue.ControlFeq = ACCEPTED()
  GET(CtrlQueue,+CtrlQueue.ControlFeq)
  IF ~ERRORCODE()
     J = RECORDS(FavoritesQ)
     LOOP I = 1 TO J
        GET(FavoritesQ,I)
        IF FavoritesQ.MenuFeq = CtrlQueue.MenuFeq
           szURL = FavoritesQ.szPath
           szNull = ''
           ShellExecute(window{prop:handle},0,szURL,0,szNull,1)
           BREAK
        END
     END
  END
  EXIT
SaveViewerStyles    ROUTINE
  LOOP K = 1 TO SCE_CLW_LAST
     loc:szViewerStyle = CLIP(glo:ViewerStyles.StyleGroup[K].Font) & ',' & |
                         glo:ViewerStyles.StyleGroup[K].FontSize   & ',' & |
                         glo:ViewerStyles.StyleGroup[K].FontStyle  & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Bold       & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Italic     & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Underline  & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Fore       & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Back       & ',' & |
                         glo:ViewerStyles.StyleGroup[K].EolFilled  & ',' & |
                         glo:ViewerStyles.StyleGroup[K].CaseOpt    & ',' & |
                         glo:ViewerStyles.StyleGroup[K].Visible    & ',' & |
                         glo:ViewerStyles.StyleGroup[K].HotSpot
     INIMgr.Update('Options','ViewerStyle'& FORMAT(K-1,@n02),loc:szViewerStyle)
  END
SetDefaultClarionVersion    ROUTINE
  DATA
loc:szSection       CSTRING(256)
loc:szRoot          CSTRING(256)

  CODE
  loc:szSection = 'Clarion for Windows V2.0'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C2
  END

  loc:szSection = 'Clarion 4'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C4
  END

  loc:szSection = 'Clarion 5'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C5
  END

  loc:szSection = 'Clarion 5  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C5EE
  END

  loc:szSection = 'Clarion 5.5'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C55
  END

  loc:szSection = 'Clarion 5.5  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C55EE
  END

  loc:szSection = 'Clarion 6.0'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C60
  END

  loc:szSection = 'Clarion 6.0  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF loc:szRoot
     glo:bClarionVersion = CWVERSION_C60EE
  END


  !Clarion 7 is not in win.ini file
  !look in registry
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion7'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF loc:szRoot
        glo:bClarionVersion = CWVERSION_C70
     END
  END

  !Clarion 8 is not in win.ini file
  !look in registry
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion8'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF loc:szRoot
        glo:bClarionVersion = CWVERSION_C80
     END
  END

  !Clarion 9 is not in win.ini file
  !look in registry
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion9'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF loc:szRoot
        glo:bClarionVersion = CWVERSION_C90
     END
  END

  !Clarion 10 is not in win.ini file
  !look in registry
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion10'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF loc:szRoot
        glo:bClarionVersion = CWVERSION_C100
     END
  END
  
  !mr added this block 2021-05-29
  !Clarion 11 is not in win.ini file
  !look in registry
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion11'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF loc:szRoot
        glo:bClarionVersion = CWVERSION_C110
     END
  END

  IF ~glo:bClarionVersion
     glo:bClarionVersion = CWVERSION_C55EE
  END

  EXIT
TakeHtmlHelp    ROUTINE
  CASE ACCEPTED()
    OF ?HelpOnHelp
       oHH.SetHelpFile( 'NTHELP.CHM' )
       oHH.ShowTopic('htmlhelp_overview.htm')
       oHH.SetHelpFile( 'ABCVIEW.CHM' )
    OF ?HelpContents
       oHH.SetHelpFile( 'ABCVIEW.CHM' )
       oHH.ShowTOC()
    OF ?HelpSearch
       oHH.SetHelpFile( 'ABCVIEW.CHM' )
       oHH.ShowSearch()
  ELSE
       oHH.SetHelpFile( 'ABCVIEW.CHM' )
       oHH.SetTopic('Main_Window.htm')
  END
  EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

loc:build           CSTRING(5)
loc:szSection       CSTRING(256)
loc:szRoot          CSTRING(261)
loc:szRedFileName   CSTRING(261)
loc:szXMLFileName   CSTRING(261)
loc:sCurrentCursor  STRING(4)
X                   LONG
Y                   LONG
W                   LONG
H                   LONG

hm  UNSIGNED
hr  UNSIGNED
mi  LIKE(MENUINFO),PRE()

szType              CSTRING('IMAGE')
szBitmap            CSTRING(33)
hInst               LONG                              !application instance handle
hRes                LONG                              !Resource Handle for BitMap
hMem                LONG                              !global handle
hBitmap             LONG                              !Bitmap handle
hBmp                LONG                              !resized bitmap for brush
lpBM                LONG                              !pointer to BM resource data
pBM                 &BITMAPFILEHEADER
pBI                 &BITMAPINFOHEADER
pBMI                &BITMAPINFO
lpBits              LONG
hDC                 LONG
szLibName           CSTRING(33)
cy                  LONG
  CODE
  GlobalErrors.SetProcedureName('Main')
  SYSTEM{PROP:ICON} = '~ABCVIEW.ICO'
  glo:sCurrentCursor = CURSOR:Arrow
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel4
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  !Get User Options
  glo:lModuleColor    = COLOR:PURPLE
  INIMgr.Fetch('Options','Module Color',glo:lModuleColor)

  glo:lPrivateColor   = COLOR:RED
  INIMgr.Fetch('Options','Private Color',glo:lPrivateColor)

  glo:lProtectedColor = COLOR:MAROON
  INIMgr.Fetch('Options','Protected Color',glo:lProtectedColor)

  glo:lVirtualColor   = COLOR:FUSCHIA
  INIMgr.Fetch('Options','Virtual Color',glo:lVirtualColor)

  glo:lSelectedBack   = 09C613BH    !080FFFFh
  INIMgr.Fetch('Options','Selected Color',glo:lSelectedBack)

  glo:lSelectedFore   = COLOR:WHITE
  INIMgr.Fetch('Options','Selected Text',glo:lSelectedFore)

  glo:lNoteColor      = COLOR:WHITE
  INIMgr.Fetch('Options','Note Color',glo:lNoteColor)

  glo:lHighlightColor1  = COLOR:BLUE
  INIMgr.Fetch('Options','Highlight Color 1',glo:lHighlightColor1)

  glo:lHighlightColor2  = COLOR:TEAL
  INIMgr.Fetch('Options','Highlight Color 2',glo:lHighlightColor2)

  glo:lHyperlinkColor  = COLOR:BLACK
  INIMgr.Fetch('Options','Hyperlink Color',glo:lHyperlinkColor)

  DO SetDefaultClarionVersion
  INIMgr.Fetch('Options','Clarion Version',glo:bClarionVersion)

  glo:bABCOnly        = TRUE
  INIMgr.Fetch('Options','ABC Only',glo:bABCOnly)

  glo:bShowModule     = FALSE
  INIMgr.Fetch('Options','Show Module',glo:bShowModule)

  glo:bShowPrivate    = FALSE
  INIMgr.Fetch('Options','Show Private',glo:bShowPrivate)

  glo:bShowProtected  = FALSE
  INIMgr.Fetch('Options','Show Protected',glo:bShowProtected)

  glo:bCurrentView    = VIEW:CLASSES
  INIMgr.Fetch('Options','Current View',glo:bCurrentView)

  glo:bShowTips       = TRUE
  INIMgr.Fetch('Options','Show Tips',glo:bShowTips)

  glo:bOpaqueCheckBox = TRUE
  INIMgr.Fetch('Options','Opaque Check Box',glo:bOpaqueCheckBox)

  glo:bForceEdit      = FALSE
  INIMgr.Fetch('Options','Force Edit',glo:bForceEdit)

  glo:bUseAssociation = FALSE
  INIMgr.Fetch('Options','Use Association',glo:bUseAssociation)

  glo:szEditorCommand = 'Notepad.exe %1'
  INIMgr.Fetch('Options','Editor Command',glo:szEditorCommand)

  glo:Background = 3    !None
  INIMgr.Fetch('Options','Background',glo:Background)

  glo:Color1          = COLOR:BTNFACE
  INIMgr.Fetch('Options','Color 1',glo:Color1)

  glo:Color2          = COLOR:BTNFACE
  INIMgr.Fetch('Options','Color 2',glo:Color2)

  glo:szWallpaper1    = '~WALLPAPER.GIF'
  INIMgr.Fetch('Options','Wallpaper 1',glo:szWallpaper1)

  glo:szWallpaper2    = '~WALLPAPER.GIF'
  INIMgr.Fetch('Options','Wallpaper 2',glo:szWallpaper2)

  glo:Tiled1          = FALSE
  INIMgr.Fetch('Options','Tiled 1',glo:Tiled1)

  glo:Tiled2          = FALSE
  INIMgr.Fetch('Options','Tiled 2',glo:Tiled2)

  glo:Typeface = 'Tahoma'
  INIMgr.Fetch('Options','Typeface',glo:Typeface)

  glo:FontSize = 10
  INIMgr.Fetch('Options','FontSize',glo:FontSize)

  glo:FontColor = COLOR:BLACK
  INIMgr.Fetch('Options','FontColor',glo:FontColor)

  glo:FontStyle = FONT:REGULAR
  INIMgr.Fetch('Options','FontStyle',glo:FontStyle)

  glo:bDetailLevel = 1
  INIMgr.Fetch('Options','DetailLevel',glo:bDetailLevel)

  glo:szCategory = ''
  INIMgr.Fetch('Options','Category',glo:szCategory)
  IF glo:szCategory
     glo:szCategoryChoice = glo:szCategory
  ELSE
     glo:szCategoryChoice = ' ALL'
  END

  glo:CategoryDropCount = 10
  INIMgr.Fetch('Options','CategoryDropCount',glo:CategoryDropCount)

  glo:szCurrentDir = LONGPATH(PATH())
  INIMgr.Fetch('Options','Current Directory',glo:szCurrentDir)
  SETPATH(glo:szCurrentDir)

  DO LoadMRU_Queue

  CASE glo:bClarionVersion
    OF CWVERSION_C2
       loc:szSection = 'Clarion for Windows V2.0'
       loc:szRedFileName = '\bin\cw20.red'
    OF CWVERSION_C4
       loc:szSection = 'Clarion 4'
       loc:szRedFileName = '\bin\clarion4.red'
    OF CWVERSION_C5
       loc:szSection = 'Clarion 5'
       loc:szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C5EE
       loc:szSection = 'Clarion 5  Enterprise Edition'
       loc:szRedFileName = '\bin\clarion5.red'
    OF CWVERSION_C55
       loc:szSection = 'Clarion 5.5'
       loc:szRedFileName = '\bin\c55pe.red'
    OF CWVERSION_C55EE
       loc:szSection = 'Clarion 5.5  Enterprise Edition'
       loc:szRedFileName = '\bin\c55ee.red'
    OF CWVERSION_C60
       loc:szSection = 'Clarion 6.0'
       loc:szRedFileName = '\bin\c60pe.red'
    OF CWVERSION_C60EE
       loc:szSection = 'Clarion 6.0  Enterprise Edition'
       loc:szRedFileName = '\bin\c60ee.red'
    OF CWVERSION_C70
       loc:szSection = 'Clarion 7.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          hr = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       !find latest version
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C80
       loc:szSection = 'Clarion 8.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          hr = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       !find latest version
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C90
       loc:szSection = 'Clarion 9.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          hr = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       !find latest version
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

    OF CWVERSION_C100
       loc:szSection = 'Clarion 10.'
       !get redirection file from xml file
       IF RECORDS(glo:VersionQ) = 0
          hr = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\ClarionProperties.xml'
          srcReadClarionProps(loc:szXMLFileName)
       END
       !find latest version
       LOOP I = 1 TO RECORDS(glo:VersionQ)
          GET(glo:VersionQ,I)
          IF UPPER(SUB(glo:VersionQ.VersionName,1,LEN(loc:szSection))) = UPPER(loc:szSection)
             IF SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4) > loc:build AND ~INSTRING('CLARION.NET',UPPER(glo:VersionQ.Path),1)
                loc:build = SUB(glo:VersionQ.VersionName,LEN(loc:szSection)+3,4)
                loc:szRedFileName = glo:VersionQ.RedFile
             END
          END
       END

  END

  DO LoadRedirectionQueue

  loc:szRoot = szRoot

  IF glo:bClarionVersion < CWVERSION_C70
     glo:szRedFilePath = loc:szRoot & loc:szRedFileName
  ELSE
     glo:szRedFilePath = glo:VersionQ.RedDir & '\' & loc:szRedFileName
  END

  INIMgr.Fetch('Options','RED File Path ' & glo:bClarionVersion,glo:szRedFilePath)

  glo:bAutoExpand = TRUE
  INIMgr.Fetch('Options','AutoExpand',glo:bAutoExpand)

  glo:bUseHTMLHelp = FALSE
  INIMgr.Fetch('Options','UseHTMLHelp',glo:bUseHTMLHelp)

  glo:szXmlStyleSheet = ''
  INIMgr.Fetch('Options','XmlStyleSheet',glo:szXmlStyleSheet)

  glo:bEnumSort = 0
  INIMgr.Fetch('Options','EnumSort',glo:bEnumSort)

  glo:bShowSparseTrees = 0
  INIMgr.Fetch('Options','ShowSparseTrees',glo:bShowSparseTrees)

  glo:bMaxMRU = 10
  INIMgr.Fetch('Options','MaxMRU',glo:bMaxMRU)

  IF srcAddToUserMenu(1) = TRUE  !check if already present; param 0 = update, 1 = query
     bAddToClarionMenu = FALSE
  ELSE
     bAddToClarionMenu = TRUE
  END

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

  DO GetAppPath
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  !Initialize Popup Manager(s)
  PopupMgr.Init()
  ObjectPopupMgr.Init()
  szLastCallName = 'WindowManager.Run'
  !Add program error messages
  GlobalErrors.AddErrors(MyErrors)
  LOOP I = 48 TO 57
    LocatorQ.character = CHR(I)
    ADD(LocatorQ)
  END
  LOOP I = 65 TO 90
    LocatorQ.character = CHR(I)
    ADD(LocatorQ)
  END
  LocatorQ.character = '_'
  ADD(LocatorQ)
  SORT(LocatorQ,+LocatorQ.character)
  SELF.Open(Window)                                        ! Open window
  0{PROP:Hide} = TRUE     !Hide the window
  Window{PROP:Buffer} = 1
  
  0{PROP:Pixels} = TRUE
  ?Box5{PROP:Ypos} = ?Box5{PROP:Ypos} + 1
  !?Box6{PROP:Height} = (?Box6{PROP:Height} + 1)
  0{PROP:Pixels} = FALSE
  
  !COMPILE('End_Compile',_DEBUG_)
  ?CallTreeButton{PROP:Hide} = FALSE
  !End_Compile
  
  loc:sCurrentCursor = glo:sCurrentCursor
  glo:sCurrentCursor = CURSOR:WAIT
  SETCURSOR(glo:sCurrentCursor)
  !Build Menu of Clarion Versions
  
  loc:szSection = 'Clarion for Windows V2.0'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion20{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 4'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion40{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 5'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion50{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 5  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion50EE{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 5.5'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion55{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 5.5  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion55EE{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 6.0'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion60{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 6.0  Enterprise Edition'
  loc:szRoot = GETINI(loc:szSection,'root')                              !get root directory
  IF ~loc:szRoot
     ?FileClarion60EE{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 7.0'
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion7'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF ~loc:szRoot
        ?FileClarion70{PROP:Hide} = TRUE
     END
  ELSE
     ?FileClarion70{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 8.0'
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion8'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF ~loc:szRoot
        ?FileClarion80{PROP:Hide} = TRUE
     END
  ELSE
     ?FileClarion80{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 9.0'
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion9'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF ~loc:szRoot
        ?FileClarion90{PROP:Hide} = TRUE
     END
  ELSE
     ?FileClarion90{PROP:Hide} = TRUE
  END
  
  loc:szSection = 'Clarion 10.0'
  szSubKey = 'SOFTWARE\SoftVelocity\Clarion10'
  RetVal = RegOpenKeyEx(HKEY_LOCAL_MACHINE,szSubKey,0,KEY_QUERY_VALUE,hKeyExtension)
  IF RetVal = ERROR_SUCCESS
     szValueName = 'root'
     pType = REG_SZ
     pData = SIZE(loc:szRoot)
     RegQueryValueEx(hKeyExtension,szValueName,0,pType,ADDRESS(loc:szRoot),pData)
     RetVal = RegCloseKey(hKeyExtension)
     IF ~loc:szRoot
        ?FileClarion100{PROP:Hide} = TRUE
     END
  ELSE
     ?FileClarion100{PROP:Hide} = TRUE
  END
  
  IF ~glo:bClarionVersion
     IF ?FileClarion100{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C100
     ELSIF ?FileClarion90{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C90
     ELSIF ?FileClarion80{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C80
     ELSIF ?FileClarion70{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C70
     ELSIF ?FileClarion60EE{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C60EE
     ELSIF ?FileClarion60{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C60
     ELSIF ?FileClarion55EE{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C55EE
     ELSIF ?FileClarion55{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C55
     ELSIF ?FileClarion50EE{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C5EE
     ELSIF ?FileClarion50{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C5
     ELSIF ?FileClarion40{PROP:Hide} = FALSE
        glo:bClarionVersion = CWVERSION_C4
     ELSE
        glo:bClarionVersion = CWVERSION_C2
     END
  END
  DO CreateMRUMenu
  hm = GetMenu(Window{PROP:Handle})
  IF hm
     mi.cbSize = SIZE(mi)
     mi.fMask = MIM_BACKGROUND + MIM_MAXHEIGHT
     hr = GetMenuInfo(hm,mi)
     mi.hbrBack = CreateSolidBrush(0F9DAC3H) !0E2A981H)
     hr = SetMenuInfo(hm,mi)
  END
  ?HistoryList{PROP:DropWidth} = 120
  
  bc &= NULL
  Locator.Init(0,LocatorQ.Character,TRUE,bc)
  Locator.Shadow = ''
  Do DefineListboxStyle
  OMIT('***',_Scintilla_)
  HIDE(?SciControl:Region)
  !***
  COMPILE('***',_Scintilla_)
  !======================================================================
  !scintilla support
  !======================================================================
  HIDE(?AsciiBox)
  !***
  HIDE(?sciControl:Region)
  ReturnValue = SciControl.Init(Window, ?sciControl:Region, 1006)
  SciControl.SetContextMenuEvent(EVENT:USER+1)
  IF ReturnValue = Level:Benign
     ThisWindow.AddItem(SciControl.WindowComponent)
  END
  COMPILE('***',_Scintilla_)
  IF ReturnValue = Level:Benign
     bControlInitialised = TRUE
  ELSE
     bControlInitialised = FALSE
  END
  !***

  !Set Tree Icons
  ?TreeList{PROP:IconList,ICON:CLASS} = '~class.ico'
  ?TreeList{PROP:IconList,ICON:NEWCLASS} = '~newclass.ico'
  ?TreeList{PROP:IconList,ICON:INTERFACEFOLDER} = '~intrface.ico'
  ?TreeList{PROP:IconList,ICON:NEWINTERFACEFOLDER} = '~newintrface.ico'
  ?TreeList{PROP:IconList,ICON:PROPERTYFOLDER} = '~pfolder.ico'
  ?TreeList{PROP:IconList,ICON:PROPERTY} = '~property.ico'
  ?TreeList{PROP:IconList,ICON:METHODFOLDER} = '~mfolder.ico'
  ?TreeList{PROP:IconList,ICON:METHOD} = '~method.ico'
  ?TreeList{PROP:IconList,ICON:STRUCTUREFOLDER} = '~structyp.ico'
  ?TreeList{PROP:IconList,ICON:STRUCTURE} = '~property.ico'
  ?TreeList{PROP:IconList,ICON:EQUATEFOLDER} = '~efolder.ico'
  ?TreeList{PROP:IconList,ICON:ENUMFOLDER} = '~efolder2.ico'
  ?TreeList{PROP:IconList,ICON:EQUATE} = '~equate.ico'
  ?TreeList{PROP:IconList,ICON:INTERFACE} = '~method.ico'
  ?TreeList{PROP:IconList,ICON:NOTE} = '~note2.ico'

  !Set Tree Styles
  DO SetTreeStyles

  ?ObjectDropList{PROP:DropWidth} = 155

  ?glo:bShowProtected{PROP:Background} = ?Panel4:2{PROP:Fill}
  ?glo:bShowPrivate{PROP:Background} = ?Panel4:2{PROP:Fill}
  ?glo:bShowModule{PROP:Background} = ?Panel4:2{PROP:Fill}

  DO SetScreenLayout
  Resizer.Init(AppStrategy:NoResize,Resize:SetMinSize)     ! Don't change the windows controls when window resized
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('Main',Window)                              ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  Locator.SetAlerts(?ObjectDropList)
  DO SetAlerts
  Window{PROP:HLP} = '~MAIN'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Main_Window.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Main_Window.htm')
     END
  ?HelpContents{PROP:STD} = ''
  ?HelpSearch{PROP:STD} = ''
  ?HelpOnHelp{PROP:STD} = ''
  END
  
  SELF.HasFocus = TRUE
  
  GET(MRU_Queue,1)
  IF ~ERRORCODE() AND MRU_Queue.MenuFeq <> 0
     POST(EVENT:Accepted,MRU_Queue.MenuFeq)
  ELSE
     CASE glo:bCurrentView
       OF VIEW:CLASSES
          POST(EVENT:Accepted,?ClassRegion)
       OF VIEW:STRUCTURES
          POST(EVENT:Accepted,?StructureRegion)
       OF VIEW:EQUATES
          POST(EVENT:Accepted,?EquateRegion)
       OF VIEW:CALLS
          POST(EVENT:Accepted,?TreeRegion)
       OF VIEW:INTERFACES
          POST(EVENT:Accepted,?InterfaceRegion)
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

loc:sCurrentCursor  STRING(4)
X   LONG
Y   LONG
W   LONG
H   LONG
  CODE
  DO DestroyFavoritesMenu
  tt.Kill()                                                !ToolTipClass Cleanup
  PopupMgr.Kill()
  ObjectPopupMgr.Kill()
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


  DO SaveMRU_Queue
  DO SaveViewerStyles

  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szClassViewDatafile = 'CVIEW20S.DAT'
    OF CWVERSION_C4
       szClassViewDatafile = 'CVIEW40S.DAT'
    OF CWVERSION_C5
       szClassViewDatafile = 'CVIEW50S.DAT'
    OF CWVERSION_C5EE
       szClassViewDatafile = 'CVIEW50E.DAT'
    OF CWVERSION_C55
       szClassViewDatafile = 'CVIEW55S.DAT'
    OF CWVERSION_C55EE
       szClassViewDatafile = 'CVIEW55E.DAT'
    OF CWVERSION_C60
       szClassViewDatafile = 'CVIEW60S.DAT'
    OF CWVERSION_C60EE
       szClassViewDatafile = 'CVIEW60E.DAT'
    OF CWVERSION_C70
       szClassViewDatafile = 'CVIEW70.DAT'
    OF CWVERSION_C80
       szClassViewDatafile = 'CVIEW80.DAT'
    OF CWVERSION_C90
       szClassViewDatafile = 'CVIEW90.DAT'
    OF CWVERSION_C100
       szClassViewDatafile = 'CVIEW100.DAT'
    !OF CWVERSION_C71
    !   szClassViewDatafile = 'CVIEW71.DAT'
  END
  szClassViewDatafile = szValue & '\' & szClassViewDatafile
  loc:sCurrentCursor = glo:sCurrentCursor
  glo:sCurrentCursor = CURSOR:WAIT
  SETCURSOR(glo:sCurrentCursor)
  ?SavingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
  ?SavingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
  HIDE(?VCRTop,?VCRBottom)
  UNHIDE(?SavingString)
  DISPLAY()
  Access:Memory(szClassViewDatafile,ACTION:SAVE)
  HIDE(?SavingString)
  UNHIDE(?VCRTop,?VCRBottom)
  glo:sCurrentCursor = loc:sCurrentCursor
  SETCURSOR(glo:sCurrentCursor)
  J = RECORDS(ViewerThreadQ)
  LOOP I = 1 TO J
    GET(ViewerThreadQ,I)
    POST(EVENT:CloseWindow,,ViewerThreadQ.lThreadId)
  END
  FREE(HistoryQueue)
  FREE(TreeStateQ)

  LOOP i = 1 TO RECORDS(glo:VersionQ)
     GET(glo:VersionQ,i)
     IF NOT glo:VersionQ.RedirectionMacros &= NULL
        FREE(glo:VersionQ.RedirectionMacros)
        DISPOSE(glo:VersionQ.RedirectionMacros)
        glo:VersionQ.RedirectionMacros &= NULL
        PUT(glo:VersionQ)
     END
  END
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('Main',Window)                           ! Save window data to non-volatile store
  END
  IF SELF.Opened
    INIMgr.Update('Splitter','Layout',glo:Layout)
    CASE glo:Layout
    OF 1
      INIMgr.Update('Splitter','XPos',?SplitterBar{PROP:XPos})
      INIMgr.Update('Splitter','VXPos',?VerticalSplitter{PROP:XPos})
    ELSE
      INIMgr.Update('Splitter','XPos',?SplitterBar{PROP:XPos})
      INIMgr.Update('Splitter','YPos',?VerticalSplitter{PROP:YPos})
    END
  END
  GlobalErrors.SetProcedureName
  OMIT('***',_Scintilla_)
  IF ViewerActive
     Viewer.Kill()
  END
  !***
  IF ~oHH &= NULL
    oHH.Kill()
    DISPOSE( oHH )
  END
  glo:lMainThread = 0
  POST(EVENT:CloseWindow,,1)
  RETURN ReturnValue


ThisWindow.Open PROCEDURE

X   LONG
Y   LONG
  CODE
  PARENT.Open
  hwndTT = tt.init(Window{PROP:HANDLE},1)                  !ToolTipClass Initialization
  IF hwndTT
     tt.addtip(?ExpandButton{PROP:HANDLE},'Expand All',0)
     ?ExpandButton{PROP:TIP} = ''                          ! Clear tip property to avoid two tips
     tt.addtip(?ClassRegion{PROP:HANDLE},sClassTip,0)
     ?ClassRegion{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.addtip(?InterfaceRegion{PROP:HANDLE},'View Interfaces',0)
     ?InterfaceRegion{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
     tt.addtip(?TreeRegion{PROP:HANDLE},'View Method Call Tree',0)
     ?TreeRegion{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?StructureRegion{PROP:HANDLE},sStructureTip,0)
     ?StructureRegion{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
     tt.addtip(?EquateRegion{PROP:HANDLE},'View Enumerated Equates',0)
     ?EquateRegion{PROP:TIP} = ''                          ! Clear tip property to avoid two tips
     tt.addtip(?ViewSourceButton{PROP:HANDLE},'View Source',0)
     ?ViewSourceButton{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?HelpButton{PROP:HANDLE},'View Help',0)
     ?HelpButton{PROP:TIP} = ''                            ! Clear tip property to avoid two tips
     tt.addtip(?ViewNoteButton{PROP:HANDLE},'View User Notes',0)
     ?ViewNoteButton{PROP:TIP} = ''                        ! Clear tip property to avoid two tips
     tt.addtip(?OptionsButton{PROP:HANDLE},sOptionsTip,0)
     ?OptionsButton{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?RefreshButton{PROP:HANDLE},'Refresh Tree',0)
     ?RefreshButton{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?CloseButton{PROP:HANDLE},?CloseButton{PROP:TIP},0)
     ?CloseButton{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.addtip(?ContractButton{PROP:HANDLE},'Contract All',0)
     ?ContractButton{PROP:TIP} = ''                        ! Clear tip property to avoid two tips
     tt.addtip(?glo:szCategoryChoice{PROP:HANDLE},?glo:szCategoryChoice{PROP:TIP},0)
     ?glo:szCategoryChoice{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.addtip(?glo:bDetailLevel{PROP:HANDLE},?glo:bDetailLevel{PROP:TIP},0)
     ?glo:bDetailLevel{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?glo:bShowProtected{PROP:HANDLE},?glo:bShowProtected{PROP:TIP},0)
     ?glo:bShowProtected{PROP:TIP} = ''                    ! Clear tip property to avoid two tips
     tt.addtip(?glo:bShowPrivate{PROP:HANDLE},?glo:bShowPrivate{PROP:TIP},0)
     ?glo:bShowPrivate{PROP:TIP} = ''                      ! Clear tip property to avoid two tips
     tt.addtip(?PrevHyperlink{PROP:HANDLE},?PrevHyperlink{PROP:TIP},0)
     ?PrevHyperlink{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?HistoryList{PROP:HANDLE},?HistoryList{PROP:TIP},0)
     ?HistoryList{PROP:TIP} = ''                           ! Clear tip property to avoid two tips
     tt.addtip(?NextHyperlink{PROP:HANDLE},?NextHyperlink{PROP:TIP},0)
     ?NextHyperlink{PROP:TIP} = ''                         ! Clear tip property to avoid two tips
     tt.addtip(?HyperlinkButton{PROP:HANDLE},?HyperlinkButton{PROP:TIP},0)
     ?HyperlinkButton{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
     tt.addtip(?glo:bShowModule{PROP:HANDLE},?glo:bShowModule{PROP:TIP},0)
     ?glo:bShowModule{PROP:TIP} = ''                       ! Clear tip property to avoid two tips
     tt.addtip(?CallTreeButton{PROP:HANDLE},?CallTreeButton{PROP:TIP},0)
     ?CallTreeButton{PROP:TIP} = ''                        ! Clear tip property to avoid two tips
     tt.addtip(?AddClassWizardButton{PROP:HANDLE},?AddClassWizardButton{PROP:TIP},0)
     ?AddClassWizardButton{PROP:TIP} = ''                  ! Clear tip property to avoid two tips
     tt.SetTipTextColor(8388608)
  END
  IF ~glo:bShowTips
     ?ClassRegion{PROP:Tip} = 'View Classes'
     ?InterfaceRegion{PROP:Tip} = 'View Interfaces'
     ?TreeRegion{PROP:Tip} = 'View Method Call Tree'
     ?StructureRegion{PROP:Tip} = 'View Structures'
     ?EquateRegion{PROP:Tip} = 'View Enumerated Equates'
  END
  
  DO FillOldClassQ
  
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szClassViewDatafile = 'CVIEW20S.DAT'
       FileClarion20 = TRUE
       DISABLE(?FileClarion20)
    OF CWVERSION_C4
       szClassViewDatafile = 'CVIEW40S.DAT'
       FileClarion40 = TRUE
       DISABLE(?FileClarion40)
    OF CWVERSION_C5
       szClassViewDatafile = 'CVIEW50S.DAT'
       FileClarion50 = TRUE
       DISABLE(?FileClarion50)
    OF CWVERSION_C5EE
       szClassViewDatafile = 'CVIEW50E.DAT'
       FileClarion50EE = TRUE
       DISABLE(?FileClarion50EE)
    OF CWVERSION_C55
       szClassViewDatafile = 'CVIEW55S.DAT'
       FileClarion55 = TRUE
       DISABLE(?FileClarion55)
    OF CWVERSION_C55EE
       szClassViewDatafile = 'CVIEW55E.DAT'
       FileClarion55EE = TRUE
       DISABLE(?FileClarion55EE)
    OF CWVERSION_C60
       szClassViewDatafile = 'CVIEW60S.DAT'
       FileClarion60 = TRUE
       DISABLE(?FileClarion60)
    OF CWVERSION_C60EE
       szClassViewDatafile = 'CVIEW60E.DAT'
       FileClarion60EE = TRUE
       DISABLE(?FileClarion60EE)
    OF CWVERSION_C70
       szClassViewDatafile = 'CVIEW70.DAT'
       FileClarion70 = TRUE
       DISABLE(?FileClarion70)
    OF CWVERSION_C80
       szClassViewDatafile = 'CVIEW80.DAT'
       FileClarion80 = TRUE
       DISABLE(?FileClarion80)
    OF CWVERSION_C90
       szClassViewDatafile = 'CVIEW90.DAT'
       FileClarion90 = TRUE
       DISABLE(?FileClarion90)
    OF CWVERSION_C100
       szClassViewDatafile = 'CVIEW100.DAT'
       FileClarion100 = TRUE
       DISABLE(?FileClarion100)
  END
  szClassViewDatafile = szValue & '\' & szClassViewDatafile
  
  IF Access:Memory(szClassViewDatafile,ACTION:LOAD) <> LEVEL:Benign
     IF glo:lLoadingThread
        POST(EVENT:CloseWindow,,glo:lLoadingThread)
        SetWindowPos(Window{PROP:Handle},HWND_TOP,0,0,0,0,BOR(BOR(SWP_NOMOVE,SWP_NOSIZE),SWP_SHOWWINDOW))
        SetForegroundWindow(Window{PROP:Handle})
        Window{PROP:Active} = TRUE
     END
     0{PROP:HIDE} = FALSE
     DO CreateFavoritesMenu
  
     IF ~RECORDS(ExtraModuleQ)
        DO InitExtraModuleQ
     END
  
     HIDE(?LoadingString)
     HIDE(?VCRTop,?VCRBottom)
     HIDE(?TreeList)
     HIDE(?AsciiBox)
   COMPILE('***',_Scintilla_)
     SciControl.SetHide(TRUE)
   !***
     HIDE(?loc:szAsciiFilename)
     HIDE(?VirtualBox,?EnumeratedEquate:String)
     HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)
     HIDE(?ObjectDropList)
     HIDE(?SplitterBar)
     HIDE(?SplitterBar:2)
     HIDE(?VerticalSplitter)
  
     HIDE(?HyperlinkButton,?HistoryList)
     HIDE(?LocatorImage,?locator)
  
     FREE(TreeStateQ)
     glo:bRefreshAll = TRUE
     srcRefreshQueues(?ProcessString,?ScanString,?ProgressBox,?ProgressBox:2,?RefreshGroup)
     glo:bRefreshAll = FALSE
     srcRefreshQueues(?ProcessString,?ScanString,?ProgressBox,?ProgressBox:2,?RefreshGroup)
  
     UNHIDE(?ObjectDropList)
     UNHIDE(?SplitterBar)
     UNHIDE(?SplitterBar:2)
     UNHIDE(?VerticalSplitter)
     UNHIDE(?HyperlinkButton,?HistoryList)
     UNHIDE(?LocatorImage,?locator)
     UNHIDE(?TreeList)
   OMIT('***',_scintilla_)
     UNHIDE(?AsciiBox)
   !***
   COMPILE('***',_Scintilla_)
     SciControl.SetHide(FALSE)
   !***
     UNHIDE(?loc:szAsciiFilename)
     glo:bCurrentView = VIEW:CLASSES
     ?SavingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
     ?SavingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
     UNHIDE(?SavingString)
     DISPLAY()
     Access:Memory(szClassViewDatafile,ACTION:SAVE)
     HIDE(?SavingString)
     UNHIDE(?VCRTop,?VCRBottom)
  ELSE
     HIDE(?LoadingString)
     UNHIDE(?VCRTop,?VCRBottom)
     IF glo:lLoadingThread
        POST(EVENT:CloseWindow,,glo:lLoadingThread)
        SetWindowPos(Window{PROP:Handle},HWND_TOP,0,0,0,0,BOR(BOR(SWP_NOMOVE,SWP_NOSIZE),SWP_SHOWWINDOW))
        SetForegroundWindow(Window{PROP:Handle})
        Window{PROP:Active} = TRUE
        0{PROP:HIDE} = FALSE
        DO CreateFavoritesMenu
        DISPLAY()
     END
  END
  
  IF RECORDS(CallNameQ)
     szLastCallName = CallNameQ.szCallName
  ELSE
     szLastCallName = 'WindowManager.Run'
  END
  
  GET(TreeQ,1)
  TreeQ.lLevel = ABS(TreeQ.lLevel)
  PUT(TreeQ)
  ?TreeList{PROP:Selected} = 1


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  PARENT.Reset(Force)
  IF RECORDS(HistoryQueue)
     ?ToolsClearHistory{PROP:Disable} = FALSE
     IF lHistoryPointer = 1
        ?PrevHyperlink{PROP:Disable} = TRUE
     ELSE
        ?PrevHyperlink{PROP:Disable} = FALSE
     END
     IF lHistoryPointer >= RECORDS(HistoryQueue)
        ?NextHyperlink{PROP:Disable} = TRUE
     ELSE
        ?NextHyperlink{PROP:Disable} = FALSE
     END
     ?HistoryList{PROP:Disable} = FALSE
  ELSE
     ?ToolsClearHistory{PROP:Disable} = TRUE
     ?PrevHyperlink{PROP:Disable} = TRUE
     ?NextHyperlink{PROP:Disable} = TRUE
     ?HistoryList{PROP:Disable} = TRUE
  END

  IF glo:bShowPrivate
     ENABLE(?glo:bShowModule)
  ELSE
     DISABLE(?glo:bShowModule)
  END

  IF ~RECORDS(incTemplateQ) OR ~RECORDS(clwTemplateQ)
     DISABLE(?ToolsAddClassWizard)
     DISABLE(?AddClassWizardButton)
  ELSE
     ENABLE(?ToolsAddClassWizard)
     ENABLE(?AddClassWizardButton)
  END


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
loc:TreeQ:szText    LIKE(TreeQ.szText)
RefreshNeeded       BYTE,AUTO
szURL               CSTRING(256)
szNull              CSTRING(2)
cc                  LONG            !completion code
X                   LONG
Y                   LONG
loc:Layout          BYTE
loc:sCurrentCursor  STRING(4)

szProperty          CSTRING('fold')
szPropertyValue0    CSTRING('0')
szPropertyValue1    CSTRING('1')
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?ToolsFavoritesAddtoFavorites
      DO DestroyFavoritesMenu
    OF ?HelpContents
      IF glo:bUseHTMLHelp AND ~oHH &= NULL
         oHH.SetHelpFile( 'ABCVIEW.CHM' )
         oHH.ShowTOC()
      ELSE
         HELP( , 'CONTENTS')
      END
    OF ?HelpSearch
      IF glo:bUseHTMLHelp AND ~oHH &= NULL
         oHH.SetHelpFile( 'ABCVIEW.CHM' )
         oHH.ShowSearch()
      END
    OF ?HelpOnHelp
      IF glo:bUseHTMLHelp AND ~oHH &= NULL
         oHH.SetHelpFile( 'NTHELP.CHM' )
         oHH.ShowTopic('htmlhelp_overview.htm')
         oHH.SetHelpFile( 'ABCVIEW.CHM' )
      END
    END
  ReturnValue = PARENT.TakeAccepted()
    IF INRANGE(ACCEPTED(),lFirstFavoriteMenuFeq,lLastFavoriteMenuFeq)
       DO ProcessFavoritesMenu
    ELSIF INRANGE(ACCEPTED(),lFirstMRUMenuFeq,lLastMRUMenuFeq)
       DO ProcessMRUMenu
    ELSIF INRANGE(ACCEPTED(),lFirstControlFeq,lLastControlFeq)
       DO ProcessFavoriteButton
    END
    CASE ACCEPTED()
    OF ?FileClarion100
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C100
      LOOP i = 1 TO RECORDS(glo:VersionQ)
         GET(glo:VersionQ,i)
         IF NOT glo:VersionQ.RedirectionMacros &= NULL
            FREE(glo:VersionQ.RedirectionMacros)
            DISPOSE(glo:VersionQ.RedirectionMacros)
            glo:VersionQ.RedirectionMacros &= NULL
            PUT(glo:VersionQ)
         END
      END
      FREE(glo:VersionQ)
      DO LoadData
    OF ?FileClarion90
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C90
      LOOP i = 1 TO RECORDS(glo:VersionQ)
         GET(glo:VersionQ,i)
         IF NOT glo:VersionQ.RedirectionMacros &= NULL
            FREE(glo:VersionQ.RedirectionMacros)
            DISPOSE(glo:VersionQ.RedirectionMacros)
            glo:VersionQ.RedirectionMacros &= NULL
            PUT(glo:VersionQ)
         END
      END
      FREE(glo:VersionQ)
      DO LoadData
      
    OF ?FileClarion80
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C80
      LOOP i = 1 TO RECORDS(glo:VersionQ)
         GET(glo:VersionQ,i)
         IF NOT glo:VersionQ.RedirectionMacros &= NULL
            FREE(glo:VersionQ.RedirectionMacros)
            DISPOSE(glo:VersionQ.RedirectionMacros)
            glo:VersionQ.RedirectionMacros &= NULL
            PUT(glo:VersionQ)
         END
      END
      FREE(glo:VersionQ)
      DO LoadData
    OF ?FileClarion70
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C70
      LOOP i = 1 TO RECORDS(glo:VersionQ)
         GET(glo:VersionQ,i)
         IF NOT glo:VersionQ.RedirectionMacros &= NULL
            FREE(glo:VersionQ.RedirectionMacros)
            DISPOSE(glo:VersionQ.RedirectionMacros)
            glo:VersionQ.RedirectionMacros &= NULL
            PUT(glo:VersionQ)
         END
      END
      FREE(glo:VersionQ)
      DO LoadData
    OF ?FileClarion60EE
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C60EE
      DO LoadData
    OF ?FileClarion60
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C60
      DO LoadData
    OF ?FileClarion55EE
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C55EE
      DO LoadData
    OF ?FileClarion55
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C55
      DO LoadData
    OF ?FileClarion50EE
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C5EE
      DO LoadData
    OF ?FileClarion50
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C5
      DO LoadData
    OF ?FileClarion40
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C4
      DO LoadData
    OF ?FileClarion20
      ThisWindow.Update()
      DO SaveData
      glo:bClarionVersion = CWVERSION_C2
      DO LoadData
    OF ?FileExit
      ThisWindow.Update()
      POST(EVENT:Accepted,?CloseButton)
    OF ?TreeExpand
      ThisWindow.Update()
      POST(EVENT:Accepted,?ExpandButton)
    OF ?TreeContract
      ThisWindow.Update()
      POST(EVENT:Accepted,?ContractButton)
    OF ?TreeExpandBranch
      ThisWindow.Update()
      GET(TreeQ,CHOICE(?TreeList))
      TreeQ:lLevel = ABS(TreeQ:lLevel)
      PUT(TreeQ)
      DISPLAY(?TreeList)
    OF ?TreeContractBranch
      ThisWindow.Update()
      J = CHOICE(?TreeList)
      IF J < RECORDS(TreeQ)
         GET(TreeQ,J + 1)
         K = ABS(TreeQ:lLevel)
         GET(TreeQ,J)
         IF ABS(TreeQ:lLevel) < K
            TreeQ:lLevel = ABS(TreeQ:lLevel) * -1
            PUT(TreeQ)
            DISPLAY(?TreeList)
         END
      END
    OF ?bViewClasses
      ThisWindow.Update()
      POST(EVENT:Accepted,?ClassRegion)
    OF ?bViewInterfaces
      ThisWindow.Update()
      POST(EVENT:Accepted,?InterfaceRegion)
    OF ?bViewCallTree
      ThisWindow.Update()
      POST(EVENT:Accepted,?TreeRegion)
    OF ?bViewStructures
      ThisWindow.Update()
      POST(EVENT:Accepted,?StructureRegion)
    OF ?bViewEquates
      ThisWindow.Update()
      POST(EVENT:Accepted,?EquateRegion)
    OF ?ViewSource
      ThisWindow.Update()
      POST(EVENT:Accepted,?ViewSourceButton)
    OF ?ViewHelp
      ThisWindow.Update()
      POST(EVENT:Accepted,?HelpButton)
    OF ?ViewNotes
      ThisWindow.Update()
      POST(EVENT:Accepted,?ViewNoteButton)
    OF ?ToolsOptions
      ThisWindow.Update()
      POST(EVENT:Accepted,?OptionsButton)
    OF ?ToolsRefreshTree
      ThisWindow.Update()
      POST(EVENT:Accepted,?RefreshButton)
    OF ?ToolsAddClassWizard
      ThisWindow.Update()
      POST(EVENT:Accepted,?AddClassWizardButton)
    OF ?ToolsBrowseDatabase
      ThisWindow.Update()
      POST(EVENT:Accepted,?CallTreeButton)
    OF ?ToolsStatistics
      ThisWindow.Update()
      winShowStatistics()
      ThisWindow.Reset
    OF ?ToolsCalculator
      ThisWindow.Update()
      START(Calculator, 25000)
      ThisWindow.Reset
    OF ?ToolsFavoritesAddtoFavorites
      ThisWindow.Update()
      winFavoritesMenu(FavoritesQ)
      ThisWindow.Reset
      DO CreateFavoritesMenu
    OF ?ToolsFindNotes
      ThisWindow.Update()
      bSyncView = winFindNotes()
    OF ?ToolsClearHistory
      ThisWindow.Update()
      FREE(HistoryQueue)
      lHistoryPointer = 0
      ThisWindow.Reset()
    OF ?HelpAddtoClarionMenu
      ThisWindow.Update()
      IF srcFindWindow('CLARION') <> 0
         MESSAGE('This procedure will not work if the Clarion IDE is running.|' & |
                 'Please exit the Clarion IDE and try again.','Clarion IDE is running',ICON:HAND)
      ELSE
         srcAddToUserMenu(0)
         bAddtoClarionMenu = FALSE
         HIDE(?HelpAddtoClarionMenu)
         ThisWindow.Reset
      END
    OF ?FileExportToXML
      ThisWindow.Update()
      winExportDatabaseToXML()
      ThisWindow.Reset
    OF ?TreeExportToXML
      ThisWindow.Update()
      srcExportTreeToXML()
      ThisWindow.Reset
    OF ?HelpAboutClassViewer
      ThisWindow.Update()
      AboutDevuna()
      ThisWindow.Reset
    OF ?HelpJusttheFAQs
      ThisWindow.Update()
      szURL = 'http://www.devuna.com/ToolsForClarion/ClassViewer/ClassViewerFAQ.aspx'
      szNull = ''
      ShellExecute(window{prop:handle},0,szURL,0,szNull,1)
    OF ?ObjectDropList
      Locator.Shadow = ''
      ?Locator{PROP:Text} = Locator.Shadow
      HIDE(?LocatorImage)

      CASE glo:bCurrentView
        OF VIEW:CLASSES OROF VIEW:INTERFACES
           IF RECORDS(ClassNameQ) > 0
              GET(ClassNameQ,CHOICE(?ObjectDropList))

              IF RECORDS(ClassHierarchyQueue)
                 FREE(ClassHierarchyQueue)
                 RefreshNeeded = TRUE
              END

              !Find Parent Class Category
              ClassQ.szClassSort = UPPER(ClassNameQ.szClassName)
              GET(ClassQ,+ClassQ.szClassSort)

              IF glo:bShowSparseTrees
                 ClassHierarchyQueue.szClassName = ClassQ.szClassName
                 ADD(ClassHierarchyQueue,1)
              END

              LOOP UNTIL ClassQ.szParentClassName = ''
                 ClassQ.szClassSort = UPPER(ClassQ.szParentClassName)
                 GET(ClassQ,+ClassQ.szClassSort)
                 IF ERRORCODE()
                    GET(ClassNameQ,CHOICE(?ObjectDropList))
                    ClassQ.szClassSort = UPPER(ClassNameQ.szClassName)
                    GET(ClassQ,+ClassQ.szClassSort)
                    IF ClassQ.lModuleId
                       ModuleQ.lModuleId = ClassQ.lModuleId
                    ELSE
                       ModuleQ.lModuleId = ClassQ.lIncludeId
                    END
                    GET(ModuleQ,+ModuleQ.lModuleId)
                    MESSAGE('Parent Class [' & ClassQ.szParentClassName & '] for class '   & |
                            ClassNameQ.szClassName & ' is undefined.'                              & |
                            '|Declared in ' & CLIP(ModuleQ.szModulePath & ModuleQ.szModuleName)    & |
                            '|Please check your source files.'                                     & |
                            '|A Class Stub has been added to allow the Tree to be constructed.', |
                            'Unexpected Error',ICON:HAND)
                    !=============================================================
                    !Add a dummy class record for the missing parent
                    !=============================================================
                    SORT(ClassQ,+ClassQ.lClassID)
                    GET(ClassQ,RECORDS(ClassQ))
                    X = ClassQ.lClassID + 1
                    SORT(ClassQ,+ClassQ.szClassSort)
                    GET(ClassNameQ,CHOICE(?ObjectDropList))
                    ClassQ.szClassSort = UPPER(ClassNameQ.szClassName)
                    GET(ClassQ,+ClassQ.szClassSort)

                    !Add Parent to same Category as derived class
                    CategoryQ.szClassName = ClassQ.szClassName
                    GET(CategoryQ,+CategoryQ.szClassName)
                    CategoryQ.szClassName = ClassQ.szParentClassName
                    ADD(CategoryQ,+CategoryQ.szClassName)

                    ClassQ.szClassName = ClassQ.szParentClassName
                    ClassQ.szParentClassName = ''
                    ClassQ.lIncludeId = 0
                    ClassQ.lModuleId = 0
                    !ClassQ.bIsABC .. same as derived class
                    ClassQ.lLineNum = 0
                    ClassQ.lClassID = X
                    ClassQ.szParentClassSort = ''
                    ClassQ.szClassSort = UPPER(ClassQ.szClassName)
                    ClassQ.bPrivate = FALSE
                    ClassQ.bInterface = FALSE
                    ClassQ.bModified = FALSE
                    ADD(ClassQ,+ClassQ.szClassSort)
                    !=============================================================
                    BREAK
                 ELSE
                    IF glo:bShowSparseTrees
                       ClassHierarchyQueue.szClassName = ClassQ.szClassName
                       ADD(ClassHierarchyQueue,1)
                    END
                 END
              END

              IF RECORDS(ClassHierarchyQueue)
                 TreeStateQ.szClassName = ClassHierarchyQueue.szClassName
                 GET(TreeStateQ,+TreeStateQ.szClassName)
                 IF ~ERRORCODE()
                    DELETE(TreeStateQ)
                 END
                 RefreshNeeded = TRUE
              END

              IF glo:szParentClassName <> ClassQ.szClassSort
                 !save the tree state here for glo:parentclassname
                 DO SaveTreeState
                 glo:szParentClassName = ClassQ.szClassSort
                 RefreshNeeded = TRUE
              END

              CategoryQ.szClassName = ClassQ.szClassName
              GET(CategoryQ,CategoryQ.szClassName)
              !Check Detail Level Filter
              IF glo:bDetailLevel < CategoryQ.bDetailLevel
                 glo:bDetailLevel = CategoryQ.bDetailLevel
                 RefreshNeeded = TRUE
              END

              !Get Selected Class Record
              ClassQ.szClassSort = UPPER(ClassNameQ.szClassName)
              GET(ClassQ,+ClassQ.szClassSort)
              szLastClassName = ClassQ.szClassName

              DO UpdateMRU_Queue

              !Refresh the tree if needed
              IF RefreshNeeded
                 I = POINTER(ClassNameQ)
                 J = POINTER(NoteQ)
                 srcRefreshTree()
                 GET(ClassNameQ,I)
                 ?ObjectDropList{PROP:Selected} = I
                 GET(NoteQ,J)
                 RefreshNeeded = FALSE
              END

              J = RECORDS(TreeQ)
              LOOP I = 1 TO J
                 GET(TreeQ,I)
                 IF ERRORCODE()
                    BREAK
                 ELSE
                    IF TreeQ.szClassName = szLastClassName   !ClassQ.szClassName
                       IF ~bHyperLinking
                          BREAK
                       ELSIF TreeQ.szText = HistoryQueue.szText
                          bHyperLinking = FALSE
                          BREAK
                       END
                    END
                 END
              END
              IF I > J
                 I = 1
              END

              DO ExpandParentNodes
              POST(EVENT:NewSelection,?TreeList)
           END

        OF VIEW:STRUCTURES
           IF RECORDS(StructNameQ) > 0
              GET(StructNameQ,CHOICE(?ObjectDropList))
              szLastStructureName = StructNameQ.szStructureName

              !Find Parent Structure
              StructureQ.szStructureSort = StructNameQ.szStructureSort
              GET(StructureQ,+StructureQ.szStructureSort)
              glo:szParentClassName = StructureQ.szStructureName

              DO UpdateMRU_Queue

              srcRefreshTree()

              J = RECORDS(TreeQ)
              LOOP I = 1 TO J
                 GET(TreeQ,I)
                 IF ERRORCODE()
                    BREAK
                 ELSE
                    IF TreeQ.szClassName = StructNameQ.szStructureName
                       IF ~bHyperLinking
                          BREAK
                       ELSIF TreeQ.szText = HistoryQueue.szText
                          bHyperLinking = FALSE
                          BREAK
                       END
                    END
                 END
              END
              IF I > J
                 I = 1
              END
              DO ExpandParentNodes
              ?ObjectDropList{PROP:Selected} = POINTER(StructNameQ)
           END

        OF VIEW:EQUATES
           IF RECORDS(EnumNameQ) > 0
              GET(EnumNameQ,CHOICE(?ObjectDropList))
              szLastEnumName = EnumNameQ.szEnumName

              glo:szParentClassName = EnumNameQ.szEnumName
              srcRefreshTree()

              J = RECORDS(TreeQ)
              LOOP I = 1 TO J
                 GET(TreeQ,I)
                 IF ERRORCODE()
                    BREAK
                 ELSE
                    IF TreeQ.szClassName = EnumNameQ.szEnumName
                       BREAK
                    END
                 END
              END
              IF I > J
                 I = 1
              END
              DO ExpandParentNodes
              ?ObjectDropList{PROP:Selected} = POINTER(EnumNameQ)
           END

        OF VIEW:CALLS
           IF RECORDS(CallNameQ) > 0
              GET(CallNameQ,CHOICE(?ObjectDropList))
              CASE ABS(CallNameQ.lLevel)
              OF 1
                 POST(EVENT:DroppingDown,?ObjectDropList)
              OF 2
                 szLastCallName = CallNameQ.szCallName
                 srcRefreshTree()
                 J = RECORDS(TreeQ)
                 LOOP I = 1 TO J
                    GET(TreeQ,I)
                    IF ERRORCODE()
                       BREAK
                    ELSE
                       IF TreeQ.szText = szLastCallName
                          BREAK
                       END
                    END
                 END
                 IF I > J
                    I = 1
                 END
                 DO ExpandParentNodes
                 ?ObjectDropList{PROP:Selected} = POINTER(CallNameQ)
              END
           END
      END

      IF glo:lLoadingThread
         POST(EVENT:CloseWindow,,glo:lLoadingThread)
         SetWindowPos(Window{PROP:Handle},HWND_TOP,0,0,0,0,BOR(BOR(SWP_NOMOVE,SWP_NOSIZE),SWP_SHOWWINDOW))
         SetForegroundWindow(Window{PROP:Handle})
         Window{PROP:Active} = TRUE
      END

      !Make sure screen is visible
      IF 0{PROP:Hide} = TRUE
         0{PROP:Hide} = FALSE
         DO CreateFavoritesMenu
      END
      glo:sCurrentCursor = CURSOR:ARROW
      SETCURSOR(glo:sCurrentCursor)
    OF ?ExpandButton
      ThisWindow.Update()
      DO ExpandTree
    OF ?ContractButton
      ThisWindow.Update()
      DO ContractTree
    OF ?ClassRegion
      ThisWindow.Update()
      IF lLatchControl <> ?ClassRegion          !if this control is not the latched control
      
         glo:szParentClassName = ''
      
         DO SetupClassView
      
         szLastClassName = ClassNameQ.szClassName
      
         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
            GET(TreeQ,I)
            IF ERRORCODE()
               BREAK
            ELSE
               IF TreeQ.szClassName = szLastClassName
                  BREAK
               END
            END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         IF glo:bAutoExpand OR I = 1
            TreeQ.lLevel = ABS(TreeQ.lLevel)
            PUT(TreeQ)
         END
      
      END
      
      ?TreeList{PROP:Selected} = POINTER(TreeQ)
      
      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?InterfaceRegion
      ThisWindow.Update()
      IF lLatchControl <> ?InterfaceRegion      !if this control is not the latched control
      
         glo:szParentClassName = ''
         DO SetupInterfaceView
      
         szLastClassName = ClassNameQ.szClassName
      
         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
            GET(TreeQ,I)
            IF ERRORCODE()
               BREAK
            ELSE
               IF TreeQ.szClassName = szLastClassName
                  BREAK
               END
            END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         IF glo:bAutoExpand OR I = 1
            TreeQ.lLevel = ABS(TreeQ.lLevel)
            PUT(TreeQ)
         END
      END
      ?TreeList{PROP:Selected} = POINTER(TreeQ)
      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?TreeRegion
      ThisWindow.Update()
      IF lLatchControl <> ?TreeRegion           !if this control is not the latched control

         lLatchControl = ?TreeRegion            !make this the latched control
         DO DrawLatchBox
         glo:bCurrentView = VIEW:CALLS          !view call tree

         DO RefreshControls

         IF ~szLastCallName
            szLastCallName = 'WindowManager.Run'
         END
         DO FillCallNameQ

         CallNameQ.szCallName = szLastCallName
         CallNameQ.szSortName = UPPER(szLastCallName)
         GET(CallNameQ,+CallNameQ.szSortName)

         srcRefreshTree()

         ?ObjectDropList{PROP:From} = CallNameQ
         CASE glo:bABCOnly
         OF 0
            ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~All Classes~C@s63@'
         OF 1
            ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~ABC Classes~C@s63@'
         OF 2
            ?ObjectDropList{PROP:Format} = '252L(2)Y|T(R)~Non-ABC Classes~C@s63@'
         END

         DO FillCategoryQueue

         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
            GET(TreeQ,I)
            IF ERRORCODE()
               BREAK
            ELSE
               IF TreeQ.szText = szLastCallName
                  BREAK
               END
            END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         IF glo:bAutoExpand OR I = 1
            TreeQ.lLevel = ABS(TreeQ.lLevel)
            PUT(TreeQ)
         END
      END
      ?TreeList{PROP:Selected} = POINTER(TreeQ)
      ?ObjectDropList{PROP:Selected} = POINTER(CallNameQ)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?StructureRegion
      ThisWindow.Update()
      IF lLatchControl <> ?StructureRegion      !if this control is not the latched control
      
         DO SetupStructureView
      
         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
            GET(TreeQ,I)
            IF ERRORCODE()
               BREAK
            ELSE
               IF TreeQ.szClassName = szLastStructureName
                  BREAK
               END
            END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         IF glo:bAutoExpand OR I = 1
            TreeQ.lLevel = ABS(TreeQ.lLevel)
            PUT(TreeQ)
         END
      END
      ?TreeList{PROP:Selected} = POINTER(TreeQ)
      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?EquateRegion
      ThisWindow.Update()
      IF lLatchControl <> ?EquateRegion         !if this control is not the latched control
         lLatchControl = ?EquateRegion          !make this the latched control
         DO DrawLatchBox
         glo:bCurrentView = VIEW:EQUATES        !view equates
      
         DO RefreshControls
      
         GET(EnumQ,1)
         glo:szParentClassName = EnumQ.szEnumName
      
         srcRefreshTree()
         DO FillEnumNameQ
         ?ObjectDropList{PROP:From} = EnumNameQ
         ?ObjectDropList{PROP:Format} = '252L(2)|@s63@'
      
         J = RECORDS(TreeQ)
         LOOP I = 1 TO J
            GET(TreeQ,I)
            IF ERRORCODE()
               BREAK
            ELSE
               IF TreeQ.szClassName = szLastEnumName
                  BREAK
               END
            END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         IF glo:bAutoExpand OR I = 1
            TreeQ.lLevel = ABS(TreeQ.lLevel)
            PUT(TreeQ)
         END
      END
      
      ?TreeList{PROP:Selected} = POINTER(TreeQ)
      ?ObjectDropList{PROP:Selected} = POINTER(EnumNameQ)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?ViewSourceButton
      ThisWindow.Update()
      GET(TreeQ,CHOICE(?TreeList))
      DO SyncQueues
      DO ViewSource
      SELECT(?TreeList)
    OF ?HelpButton
      ThisWindow.Update()
      GET(TreeQ,CHOICE(?TreeList))
      IF UPPER(SUB(TreeQ.szHelpFile,LEN(TreeQ.szHelpFile)-2,3)) = 'CHM'
         IF oHH &= NULL
            oHH &= NEW tagHTMLHelp
            oHH.Init(TreeQ.szHelpFile)
         ELSE
            oHH.SetHelpFile( TreeQ.szHelpFile )
         END
         I = INSTRING(':',TreeQ.szContextString)
         IF I > 0
            oHH.KeyWordLookup(SUB(TreeQ.szContextString,1,I-1))
         ELSE
            oHH.KeyWordLookup(TreeQ.szContextString)
         END
         !oHH.ShowTopic(TreeQ.szContextString)
         oHH.SetHelpFile( 'ABCVIEW.CHM' )
      ELSE
         HELP(TreeQ.szHelpFile,TreeQ.szContextString)
         HELP('abcview.hlp')
      END
      SELECT(?TreeList)
    OF ?ViewNoteButton
      ThisWindow.Update()
      GET(TreeQ,CHOICE(?TreeList))
      IF TreeQ.szContextString
         winViewNote(glo:bClarionVersion,TreeQ.szContextString)
      ELSE
         winViewNote(glo:bClarionVersion,TreeQ.szText)
      END
    OF ?OptionsButton
      ThisWindow.Update()
      DO DestroyFavoritesMenu
      loc:Layout = glo:Layout
      CASE winOptions()
        OF 0  !User Cancelled
        OF 1  !Color Change
           DO SetTreeStyles
           DO SaveViewerStyles
       COMPILE('***',_Scintilla_)
           SciControl.SetColors(glo:ViewerStyles)
           IF glo:Typeface
              SciControl.SetTypeface(glo:Typeface)
           END
       !***
           glo:szParentClassName = ''
      END

      DO CreateFavoritesMenu

      IF loc:Layout <> glo:Layout
         INIMgr.Update('Splitter','Layout',glo:Layout)
         DO SetScreenLayout
         POST(EVENT:Sized)
      END

      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?RefreshButton
      ThisWindow.Update()
      IF winGetScanOptions(loc:ForceSmartScan) = Level:Benign
         loc:sCurrentCursor = glo:sCurrentCursor
         glo:sCurrentCursor = CURSOR:WAIT
         SETCURSOR(glo:sCurrentCursor)
         !Save Current Info
         CASE glo:bCurrentView
           OF VIEW:CLASSES
              szObjectName = ClassNameQ.szClassName
           OF VIEW:STRUCTURES
              szObjectName = StructNameQ.szStructureName
           OF VIEW:EQUATES
              glo:szParentClassName = EnumNameQ.szEnumName
           OF VIEW:CALLS
              szLastCallName = CallNameQ.szCallName
           OF VIEW:INTERFACES
              szObjectName = ClassNameQ.szClassName
         END

         CASE glo:bClarionVersion
           OF CWVERSION_C2
              szClassViewDatafile = 'CVIEW20S.DAT'
           OF CWVERSION_C4
              szClassViewDatafile = 'CVIEW40S.DAT'
           OF CWVERSION_C5
              szClassViewDatafile = 'CVIEW50S.DAT'
           OF CWVERSION_C5EE
              szClassViewDatafile = 'CVIEW50E.DAT'
           OF CWVERSION_C55
              szClassViewDatafile = 'CVIEW55S.DAT'
           OF CWVERSION_C55EE
              szClassViewDatafile = 'CVIEW55E.DAT'
           OF CWVERSION_C60
              szClassViewDatafile = 'CVIEW60S.DAT'
           OF CWVERSION_C60EE
              szClassViewDatafile = 'CVIEW60E.DAT'
           OF CWVERSION_C70
              szClassViewDatafile = 'CVIEW70.DAT'
           OF CWVERSION_C80
              szClassViewDatafile = 'CVIEW80.DAT'
           OF CWVERSION_C90
              szClassViewDatafile = 'CVIEW90.DAT'
           OF CWVERSION_C100
              szClassViewDatafile = 'CVIEW100.DAT'
         END
         szClassViewDatafile = szValue & '\' & szClassViewDatafile
         Access:Memory(szClassViewDatafile,ACTION:SAVE)
         DO FillOldClassQ
         Access:Memory(szClassViewDatafile,ACTION:LOAD)

         HIDE(?TreeList)
         HIDE(?AsciiBox)
       COMPILE('***',_Scintilla_)
         SciControl.SetHide(TRUE)
       !***
         HIDE(?VCRTop,?VCRBottom)
         HIDE(?loc:szAsciiFilename)
         HIDE(?VirtualBox,?EnumeratedEquate:String)
         !HIDE(?glo:bABCOnly,?glo:bDetailLevel)
         HIDE(?glo:szCategory:Prompt,?glo:bDetailLevel)
         HIDE(?ObjectDropList)
         HIDE(?SplitterBar)
         HIDE(?SplitterBar:2)
         HIDE(?VerticalSplitter)
         HIDE(?HyperlinkButton,?HistoryList)

         FREE(TreeStateQ)
         cc = srcRefreshQueues(?ProcessString,?ScanString,?ProgressBox,?ProgressBox:2,?RefreshGroup)

         UNHIDE(?ObjectDropList)
         UNHIDE(?SplitterBar)
         UNHIDE(?SplitterBar:2)
         UNHIDE(?VerticalSplitter)
         UNHIDE(?HyperlinkButton,?HistoryList)
         !!!UNHIDE(?glo:bABCOnly)
         UNHIDE(?HyperlinkButton,?HistoryList)
         UNHIDE(?TreeList)
       OMIT('***',_scintilla_)
         UNHIDE(?AsciiBox)
       !***
       COMPILE('***',_Scintilla_)
         SciControl.SetHide(FALSE)
       !***
         UNHIDE(?loc:szAsciiFilename)
         IF ~cc    !Successful Scan
            CASE glo:bClarionVersion
              OF CWVERSION_C2
                 szClassViewDatafile = 'CVIEW20S.DAT'
              OF CWVERSION_C4
                 szClassViewDatafile = 'CVIEW40S.DAT'
              OF CWVERSION_C5
                 szClassViewDatafile = 'CVIEW50S.DAT'
              OF CWVERSION_C5EE
                 szClassViewDatafile = 'CVIEW50E.DAT'
              OF CWVERSION_C55
                 szClassViewDatafile = 'CVIEW55S.DAT'
              OF CWVERSION_C55EE
                 szClassViewDatafile = 'CVIEW55E.DAT'
              OF CWVERSION_C60
                 szClassViewDatafile = 'CVIEW60S.DAT'
              OF CWVERSION_C60EE
                 szClassViewDatafile = 'CVIEW60E.DAT'
              OF CWVERSION_C70
                 szClassViewDatafile = 'CVIEW70.DAT'
              OF CWVERSION_C80
                 szClassViewDatafile = 'CVIEW80.DAT'
              OF CWVERSION_C90
                 szClassViewDatafile = 'CVIEW90.DAT'
              OF CWVERSION_C100
                 szClassViewDatafile = 'CVIEW100.DAT'
            END
            szClassViewDatafile = szValue & '\' & szClassViewDatafile
            ?SavingString{PROP:XPos} = (?CloseButton{PROP:XPos} - 90)
            ?SavingString{PROP:YPos} = (?CloseButton{PROP:YPos} + 0)
            UNHIDE(?SavingString)
            DISPLAY()
            Access:Memory(szClassViewDatafile,ACTION:SAVE)
            HIDE(?SavingString)
            UNHIDE(?VCRTop,?VCRBottom)
            glo:sCurrentCursor = loc:sCurrentCursor
            SETCURSOR(glo:sCurrentCursor)

            lLatchControl = 0

            CASE glo:bCurrentView
              OF VIEW:CLASSES
                 POST(EVENT:Accepted,?ClassRegion)
              OF VIEW:STRUCTURES
                 POST(EVENT:Accepted,?StructureRegion)
              OF VIEW:EQUATES
                 POST(EVENT:Accepted,?EquateRegion)
              OF VIEW:CALLS
                 IF RECORDS(CallNameQ)
                    szLastCallName = CallNameQ.szCallName
                 ELSE
                    szLastCallName = 'WindowManager.Run'
                 END
                 DO FillCallNameQ
                 POST(EVENT:Accepted,?TreeRegion)
              OF VIEW:INTERFACES
                 POST(EVENT:Accepted,?InterfaceRegion)
            END
         ELSE
            DO RefreshControls
         END
      END
      SELECT(?ObjectDropList)
      loc:ForceSmartScan = FALSE
    OF ?AddClassWizardButton
      ThisWindow.Update()
      IF winAddClass() = Level:Benign     !call the add class dialog
         loc:ForceSmartScan = TRUE
         POST(EVENT:Accepted,?RefreshButton)
      END
    OF ?CallTreeButton
      ThisWindow.Update()
      szObjectName = winBrowseCallQ()
      IF szObjectName <> ''
         szObjectType = 'CLASS'
         DO ProcessHyperlink
      ELSE
         SELECT(?ObjectDropList)
      END
    OF ?glo:szCategoryChoice
      CASE glo:szCategoryChoice
        OF ' ALL'
         glo:szCategory = ''
      ELSE
         glo:szCategory = glo:szCategoryChoice
      END
      glo:szParentClassName = ''
      
      GET(TreeQ,CHOICE(?TreeList))
      loc:TreeQ:szText = TreeQ.szText
      
      DO FillCallNameQ
      
      FREE(TreeStateQ)
      
      srcRefreshTree()
      
      DO FillClassNameQ
      DO FillCategoryQueue
      
      J = RECORDS(TreeQ)
      IF J
         LOOP I = 1 TO J
           GET(TreeQ,I)
           IF TreeQ.szText = loc:TreeQ:szText
              BREAK
           END
         END
         IF I > J
            I = 1
         END
         GET(TreeQ,I)
         ?TreeList{PROP:Selected} = I
      END
      
      IF glo:bAutoExpand OR I = 1
         TreeQ.lLevel = ABS(TreeQ.lLevel)
         PUT(TreeQ)
      END
      
      DO SaveTreeState
      
      ?ObjectDropList{PROP:Selected} = 1
      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?glo:bDetailLevel
      DO ProcessNewDetailLevel
    OF ?HyperlinkButton
      ThisWindow.Update()
       DO SetupHyperlink
       DO ProcessHyperlink
    OF ?PrevHyperlink
      ThisWindow.Update()
      IF HistoryQueue.ObjectName <> TreeQ.szClassName
         HistoryQueue.ObjectName = TreeQ.szClassName
         HistoryQueue.ObjectView = glo:bCurrentView
         CASE HistoryQueue.ObjectView
         OF VIEW:CLASSES
            HistoryQueue.lObjectDropListPointer = POINTER(ClassNameQ)
         OF VIEW:STRUCTURES
            HistoryQueue.lObjectDropListPointer = POINTER(StructNameQ)
         OF VIEW:INTERFACES
            HistoryQueue.lObjectDropListPointer = POINTER(ClassNameQ)
         END
         HistoryQueue.szText = TreeQ.szText
         HistoryQueue.bProtected = glo:bShowProtected
         HistoryQueue.bPrivate = glo:bShowPrivate
         HistoryQueue.bModule = glo:bShowModule
         ADD(HistoryQueue)
         lHistoryPointer = POINTER(HistoryQueue)
      ELSE
         HistoryQueue.szText = TreeQ.szText
         PUT(HistoryQueue)
      END
      
      lHistoryPointer -= 1
      
      IF lHistoryPointer = 1
         ?PrevHyperlink{PROP:Disable} = TRUE
      ELSE
         ?PrevHyperlink{PROP:Disable} = FALSE
      END
      IF RECORDS(HistoryQueue) > 1
         IF lHistoryPointer < RECORDS(HistoryQueue)
            ?NextHyperlink{PROP:Disable} = FALSE
         ELSE
            ?NextHyperlink{PROP:Disable} = TRUE
         END
      ELSE
         ?NextHyperlink{PROP:Disable} = TRUE
      END
      
      GET(HistoryQueue,lHistoryPointer)
      ?HistoryList{PROP:Selected} = lHistoryPointer
      
      CASE HistoryQueue.ObjectView
      OF VIEW:CLASSES
         szObjectType = 'CLASS'
      OF VIEW:STRUCTURES
         szObjectType = 'STRUCTURE'
      OF VIEW:INTERFACES
         szObjectType = 'INTERFACE'
      END
      szObjectName = HistoryQueue.ObjectName
      DO ProcessHyperlink
      RETURN Level:Notify
    OF ?NextHyperlink
      ThisWindow.Update()
      lHistoryPointer += 1
      IF lHistoryPointer = RECORDS(HistoryQueue)
         ?NextHyperlink{PROP:Disable} = TRUE
      ELSE
         ?NextHyperlink{PROP:Disable} = FALSE
      END
      ?PrevHyperlink{PROP:Disable} = FALSE
      
      GET(HistoryQueue,lHistoryPointer)
      ?HistoryList{PROP:Selected} = lHistoryPointer
      
      CASE HistoryQueue.ObjectView
      OF VIEW:CLASSES
         szObjectType = 'CLASS'
      OF VIEW:STRUCTURES
         szObjectType = 'STRUCTURE'
      OF VIEW:INTERFACES
         szObjectType = 'INTERFACE'
      END
      szObjectName = HistoryQueue.ObjectName
      DO ProcessHyperlink
      RETURN Level:Notify
    OF ?HistoryList
      lHistoryPointer = CHOICE(?HistoryList)
      ThisWindow.Reset()
      
      GET(HistoryQueue,lHistoryPointer)
      
      CASE HistoryQueue.ObjectView
      OF VIEW:CLASSES
         szObjectType = 'CLASS'
      OF VIEW:STRUCTURES
         szObjectType = 'STRUCTURE'
      OF VIEW:INTERFACES
         szObjectType = 'INTERFACE'
      END
      szObjectName = HistoryQueue.ObjectName
      DO ProcessHyperlink
    OF ?glo:bShowSparseTrees
      glo:bShowSparseTrees = ABS(glo:bShowSparseTrees - 1)
      SELECT(?ObjectDropList)
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?glo:bShowProtected
      IF glo:bShowProtected
         UNHIDE(?ProtectedBox,?ProtectedString)
      ELSE
         HIDE(?ProtectedBox,?ProtectedString)
      END
      GET(TreeQ,CHOICE(?TreeList))
      IF ERRORCODE()
         loc:TreeQ:szText = ''
      ELSE
         loc:TreeQ:szText = TreeQ.szText
      END
      
      FREE(TreeStateQ)
      srcRefreshTree()
      CASE glo:bCurrentView
        OF VIEW:CLASSES
           DO FillClassNameQ
           DO FillCategoryQueue
        OF VIEW:CALLS
           IF RECORDS(CallNameQ)
              szLastCallName = CallNameQ.szCallName
           ELSE
              szLastCallName = 'WindowManager.Run'
           END
           DO FillCallNameQ
           DO FillCategoryQueue
        OF VIEW:INTERFACES
           DO FillClassNameQ
        OF VIEW:STRUCTURES
           DO FillStructNameQ
        OF VIEW:EQUATES
           DO FillEnumNameQ
      END
      J = RECORDS(TreeQ)
      IF J
         LOOP I = 1 TO J
           GET(TreeQ,I)
           IF TreeQ.szText = loc:TreeQ:szText
              BREAK
           END
         END
         IF I > J
            I = 1
         END
         DO ExpandParentNodes
      END
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?glo:bShowPrivate
      IF glo:bShowPrivate
         UNHIDE(?PrivateBox,?PrivateString)
         ENABLE(?glo:bShowModule)
      ELSE
         HIDE(?PrivateBox,?PrivateString)
         glo:bShowModule = FALSE
         HIDE(?ModuleBox,?ModuleString)
         DISABLE(?glo:bShowModule)
      END
      GET(TreeQ,CHOICE(?TreeList))
      IF ERRORCODE()
         CLEAR(TreeQ)
      END
      loc:TreeQ:szText = TreeQ.szText
      
      FREE(TreeStateQ)
      srcRefreshTree()
      CASE glo:bCurrentView
        OF VIEW:CLASSES
           DO FillClassNameQ
           DO FillCategoryQueue
        OF VIEW:CALLS
           IF RECORDS(CallNameQ)
              szLastCallName = CallNameQ.szCallName
           ELSE
              szLastCallName = 'WindowManager.Run'
           END
           DO FillCallNameQ
           DO FillCategoryQueue
        OF VIEW:INTERFACES
           DO FillClassNameQ
        OF VIEW:STRUCTURES
           DO FillStructNameQ
        OF VIEW:EQUATES
           DO FillEnumNameQ
      END
      J = RECORDS(TreeQ)
      IF J
         LOOP I = 1 TO J
           GET(TreeQ,I)
           IF TreeQ.szText = loc:TreeQ:szText
              BREAK
           END
         END
         IF I > J
            I = 1
         END
         DO ExpandParentNodes
      END
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?glo:bShowModule
      IF glo:bShowModule
         UNHIDE(?ModuleBox,?ModuleString)
      ELSE
         HIDE(?ModuleBox,?ModuleString)
      END
      GET(TreeQ,CHOICE(?TreeList))
      IF ERRORCODE()
         CLEAR(TreeQ)
      END
      loc:TreeQ:szText = TreeQ.szText
      
      FREE(TreeStateQ)
      srcRefreshTree()
      
      CASE glo:bCurrentView
        OF VIEW:CLASSES
           DO FillClassNameQ
           DO FillCategoryQueue
        OF VIEW:CALLS
           IF RECORDS(CallNameQ)
              szLastCallName = CallNameQ.szCallName
           ELSE
              szLastCallName = 'WindowManager.Run'
           END
           DO FillCallNameQ
           DO FillCategoryQueue
        OF VIEW:INTERFACES
           DO FillClassNameQ
        OF VIEW:STRUCTURES
           DO FillStructNameQ
        OF VIEW:EQUATES
           DO FillEnumNameQ
      END
      J = RECORDS(TreeQ)
      IF J
         LOOP I = 1 TO J
           GET(TreeQ,I)
           IF TreeQ.szText = loc:TreeQ:szText
              BREAK
           END
         END
         IF I > J
            I = 1
         END
         DO ExpandParentNodes
      END
      SETKEYCODE(0)
      POST(EVENT:Accepted,?ObjectDropList)
    OF ?VcrTop
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         SciControl.DocumentStart()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber())
      ELSE
      !***
         SETKEYCODE(CtrlHome)
         FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
    OF ?VcrRewind
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         SciControl.PageUp()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber())
      ELSE
      !***
         SETKEYCODE(PgUpKey)
         FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
    OF ?VcrBack
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         !SciControl.LineScrollUp()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber()-1)
      ELSE
      !***
        SETKEYCODE(UpKey)
        FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
      
    OF ?VcrPlay
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         !SciControl.LineScrollDown()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber()+1)
      ELSE
      !***
        SETKEYCODE(DownKey)
        FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
      
    OF ?VcrFastForward
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         SciControl.PageDown()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber())
      ELSE
      !***
        SETKEYCODE(PgDnKey)
        FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
      
    OF ?VcrBottom
      ThisWindow.Update()
      COMPILE('***',_Scintilla_)
      IF ListWithFocus = -1
         SciControl.DocumentEnd()
         SciControl.GoToLine(SciControl.GetCurrentLineNumber())
      ELSE
      !***
        SETKEYCODE(CtrlEnd)
        FORWARDKEY(ListWithFocus)
      COMPILE('***',_Scintilla_)
      END
      !***
      
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
X                   LONG
Y                   LONG
rc                  LIKE(RECT)
QueueLimit          LONG
ScrollBarWidth      LONG
  CODE
  LOOP                                                     ! This method receives all events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeEvent()
    CASE EVENT()
      OF EVENT:Accepted
         IF ~oHH &= NULL
            oHH.SetTopic('Main_Window.htm')
         END

      OF EVENT:Selected

      OF EVENT:Timer
         IF bCount > 0
            bCount -= 1
         ELSE
            Window{PROP:Timer} = 0
            IF bDetailNewSelection
               bDetailNewSelection = FALSE
               DO ProcessNewDetailLevel
            END
         END

      OF EVENT:User

    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
QueueLimit      LONG
ScrollBarWidth  LONG
fld             LONG
MouseDownRow    LONG
X               LONG
Y               LONG
W               LONG
PanelX          LONG    !X position for Option Panel controls
AsciiBoxHeight  LONG
vXPos           LONG,AUTO
XMin            LONG,AUTO
XMax            LONG,AUTO
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
  !  Fld = FIELD()
  !  CASE Fld
  !  OF   ?ClassRegion
  !  OROF ?InterfaceRegion
  !  OROF ?TreeRegion
  !  OROF ?StructureRegion
  !  OROF ?EquateRegion
  !    CASE EVENT()
  !    OF EVENT:MouseIn
  !       IF lLatchControl <> Fld
  !          IF SYSTEM{PROP:ThemeActive} = 1
  !             ?ThemeButton{PROP:XPos} = Fld{PROP:XPos}
  !             ?ThemeButton{PROP:YPos} = Fld{PROP:YPos}
  !             UNHIDE(?ThemeButton)
  !          ELSE
  !             ?Button{PROP:XPos} = Fld{PROP:XPos}
  !             ?Button{PROP:YPos} = Fld{PROP:YPos}
  !             UNHIDE(?Button)
  !          END
  !       END
  !    OF EVENT:MouseOut
  !       IF SYSTEM{PROP:ThemeActive} = 1
  !          HIDE(?ThemeButton)
  !       ELSE
  !          HIDE(?Button)
  !       END
  !    END
  !  END
  CASE FIELD()
  OF ?ObjectDropList
    CASE EVENT()
    OF EVENT:LoseFocus
       Locator.Shadow = ''
       ?ObjectDropList{PROP:SelectedFillColor} = COLOR:Silver
       ?ObjectDropList{PROPSTYLE:BackSelected,STYLE:NORMAL} = COLOR:Silver
       ?ObjectDropList{PROPSTYLE:BackSelected,STYLE:NORMAL_NEW} = COLOR:Silver
    OF EVENT:Expanding
       IF glo:bCurrentView = VIEW:CALLS
          I = ?ObjectDropList{PROPLIST:MouseDownRow}
          GET(CallNameQ,I)
          CallNameQ.lLevel = 1
          PUT(CallNameQ)
       END
    OF EVENT:Contracting
       IF glo:bCurrentView = VIEW:CALLS
          I = ?ObjectDropList{PROPLIST:MouseDownRow}
          GET(CallNameQ,I)
          CallNameQ.lLevel = -1
          PUT(CallNameQ)
       END
    OF EVENT:AlertKey
       CASE KEYCODE()
         OF MouseRight
            CASE glo:bCurrentView
            OF VIEW:CLASSES OROF VIEW:INTERFACES
               GET(ClassNameQ,CHOICE(?ObjectDropList))
               DO ObjectPopupMenu
            END
         OF EnterKey
            IF Locator.Shadow <> ''
               SETKEYCODE(MouseLeft)
               POST(EVENT:Accepted,?ObjectDropList)
            END
      
         ! New Code ===================================================
       ELSE
            CASE glo:bCurrentView
              OF VIEW:CLASSES OROF VIEW:INTERFACES
                 IF Locator.TakeKey()
                    LOOP X = 1 TO RECORDS(ClassNameQ)
                      GET(ClassNameQ,X)
                      IF ClassNameQ.szSortName[1 : LEN(CLIP(Locator.Shadow))] >= UPPER(Locator.Shadow)
                         ?ObjectDropList{PROP:Selected} = POINTER(ClassNameQ)
                         DISPLAY(?ObjectDropList)
                         BREAK
                      END
                    END
                    ?Locator{PROP:Text} = Locator.Shadow
                 ELSE
                    Locator.Shadow = ''
                    ?Locator{PROP:Text} = Locator.Shadow
                    !DO UpdateMRU_Queue
                 END
                 IF Locator.Shadow = ''
                    ?LocatorImage{PROP:Hide} = TRUE
                 ELSE
                    ?LocatorImage{PROP:Hide} = FALSE
                 END
      
              OF VIEW:CALLS
                 IF Locator.TakeKey()
                    LOOP X = 1 TO RECORDS(CallNameQ)
                      GET(CallNameQ,X)
                      IF CallNameQ.szSortName[1 : LEN(CLIP(Locator.Shadow))] >= UPPER(Locator.Shadow)
                         ?ObjectDropList{PROP:Selected} = POINTER(CallNameQ)
                         DISPLAY(?ObjectDropList)
                         BREAK
                      END
                    END
                    ?Locator{PROP:Text} = Locator.Shadow
                 ELSE
                    Locator.Shadow = ''
                    ?Locator{PROP:Text} = Locator.Shadow
                 END
                 IF Locator.Shadow = ''
                    ?LocatorImage{PROP:Hide} = TRUE
                 ELSE
                    ?LocatorImage{PROP:Hide} = FALSE
                 END
                 GET(CallNameQ,CHOICE(?ObjectDropList))
                 CASE ABS(CallNameQ.lLevel)
                 OF 1
                    CYCLE
                 END
      
              OF VIEW:STRUCTURES
                 IF Locator.TakeKey()
                    LOOP X = 1 TO RECORDS(StructNameQ)
                      GET(StructNameQ,X)
                      IF StructNameQ.szStructureSort[1 : LEN(CLIP(Locator.Shadow))] >= UPPER(Locator.Shadow)
                         ?ObjectDropList{PROP:Selected} = POINTER(StructNameQ)
                         DISPLAY(?ObjectDropList)
                         BREAK
                      END
                    END
                    ?Locator{PROP:Text} = Locator.Shadow
                 ELSE
                    Locator.Shadow = ''
                    ?Locator{PROP:Text} = Locator.Shadow
                    !DO UpdateMRU_Queue
                 END
                 IF Locator.Shadow = ''
                    ?LocatorImage{PROP:Hide} = TRUE
                 ELSE
                    ?LocatorImage{PROP:Hide} = FALSE
                 END
      
              OF VIEW:EQUATES
                 IF Locator.TakeKey()
                    LOOP X = 1 TO RECORDS(EnumNameQ)
                      GET(EnumNameQ,X)
                      IF EnumNameQ.szEnumSort[1 : LEN(CLIP(Locator.Shadow))] >= UPPER(Locator.Shadow)
                         ?ObjectDropList{PROP:Selected} = POINTER(EnumNameQ)
                         DISPLAY(?ObjectDropList)
                         BREAK
                      END
                    END
                    ?Locator{PROP:Text} = Locator.Shadow
                 ELSE
                    Locator.Shadow = ''
                    ?Locator{PROP:Text} = Locator.Shadow
                 END
                 IF Locator.Shadow = ''
                    ?LocatorImage{PROP:Hide} = TRUE
                 ELSE
                    ?LocatorImage{PROP:Hide} = FALSE
                 END
            END
            CYCLE
         ! End New Code ===================================================
       END
    END
  OF ?SplitterBar
    CASE EVENT()
    OF EVENT:MouseDown
       IF SELF.HasFocus
          bTrackMouse = TRUE
          ?SplitterBar{PROP:Color} = COLOR:BLACK
          ?SplitterBar{PROP:Fill} = COLOR:BLUE
       END
    OF EVENT:MouseUp
      SETKEYCODE(0)
      ?SplitterBar{PROP:Color} = COLOR:NONE
      ?SplitterBar{PROP:Fill} = COLOR:NONE
      
      IF bTrackMouse
         X = Splitter1_XPos
         Splitter2_XPos = ?VerticalSplitter{PROP:XPos}
         PanelX = CHOOSE(X < PANELMINIMUMX,PANELMINIMUMX,X)
      
         ?ObjectDropList{PROP:Width} = X-8
      
         ?SplitterBar{PROP:XPos} = X
         ?SplitterBar:2{PROP:XPos} = PanelX
      
         CASE glo:Layout
         OF 1
            ?TreeList{PROP:XPos} = X+2
            ?TreeList{PROP:Width} = Splitter2_XPos - (X+2)
            ?AsciiBox{PROP:XPos} = Splitter2_XPos + 3
            ?AsciiBox{PROP:Width} = Window{PROP:Width}-(Splitter2_XPos + 3)-8
         ELSE
            ?TreeList{PROP:XPos} = X+2
            ?TreeList{PROP:Width} = Window{PROP:Width}-(X+2)-8
            ?VerticalSplitter{PROP:XPos} = X+2
            ?VerticalSplitter{PROP:Width} = Window{PROP:Width}-(X+2)-8
            ?AsciiBox{PROP:XPos} = X+3
            ?AsciiBox{PROP:Width} = Window{PROP:Width}-(X+3)-8
         END
      
         COMPILE('***',_Scintilla_)
         !======================================================================
         !scintilla support
         !======================================================================
         SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
         SciControl.Reset(FALSE)
         !======================================================================
         !***
         SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
      
         ?glo:szCategoryChoice{PROP:Width} = PanelX - ?glo:szCategoryChoice{PROP:XPos} - 2
      
         ?glo:bDetailLevel:Prompt{PROP:XPos} = PanelX + 8
         ?glo:bDetailLevel{PROP:XPos} = PanelX + 36
         ?glo:bShowProtected{PROP:XPos} = PanelX + 54
         ?glo:bShowPrivate{PROP:XPos} = PanelX + 104
         ?glo:bShowModule{PROP:XPos} = PanelX + 154
      END
      
      bTrackMouse = FALSE
      
      !fix up the screen
      IF ?glo:bDetailLevel:Prompt{PROP:HIDE} = FALSE
         HIDE(?glo:bDetailLevel:Prompt,?glo:bDetailLevel)
         UNHIDE(?glo:bDetailLevel:Prompt,?glo:bDetailLevel)
      END
      IF ?glo:bShowProtected{PROP:HIDE} = FALSE
         HIDE(?glo:bShowProtected)
         UNHIDE(?glo:bShowProtected)
      END
      IF ?glo:bShowPrivate{PROP:HIDE} = FALSE
         HIDE(?glo:bShowPrivate)
         UNHIDE(?glo:bShowPrivate)
      END
      IF ?glo:bShowModule{PROP:HIDE} = FALSE
         HIDE(?glo:bShowModule)
         UNHIDE(?glo:bShowModule)
      END
      
      SELF.Reset(TRUE)
    OF EVENT:MouseIn
      IF SELF.HasFocus
         SETCURSOR(CURSOR:SIZEWE)
      END
    OF EVENT:MouseOut
      SETCURSOR()
    OF EVENT:MouseMove
      IF SELF.HasFocus AND KEYCODE() = MouseLeft AND bTrackMouse
         X = MouseX()
         Y = MouseY()
         IF INRANGE(Y,?ObjectDropList{PROP:YPos}+0,?ObjectDropList{PROP:YPos}+?ObjectDropList{PROP:Height}+0)
            CASE glo:Layout
            OF 1
               vXPos = ?VerticalSplitter{PROP:XPos}
            ELSE
               vXPos = Window{PROP:Width}-192
            END
            XMax = Window{PROP:Width}-192
            XMax = CHOOSE(XMax>vXPos,vXPos-2,XMax)

            IF INRANGE(X,8,XMax)
               PanelX = CHOOSE(X < PANELMINIMUMX,PANELMINIMUMX,X)
               ?SplitterBar{PROP:Color} = COLOR:BLACK
               ?SplitterBar{PROP:Fill} = COLOR:BLUE
               ?SplitterBar{PROP:XPos} = X
               Splitter1_XPos = X
            END
         END
      END
    END
  OF ?TreeList
    CASE EVENT()
    OF EVENT:Expanded
      X = ?TreeList{PROPLIST:MouseDownRow}
      GET(TreeQ,X)
      TreeQ.lLevel = ABS(TreeQ.lLevel)
      PUT(TreeQ)
      ?TreeList{PROP:Selected} = X
      DO SaveTreeState
    OF EVENT:Contracted
      X = ?TreeList{PROPLIST:MouseDownRow}
      GET(TreeQ,X)
      TreeQ.lLevel = ABS(TreeQ.lLevel) * -1
      PUT(TreeQ)
      ?TreeList{PROP:Selected} = X
      DO SaveTreeState
    OF EVENT:AlertKey
      CASE KEYCODE()
        OF MouseRight
           sav:TreeQ:szText = TreeQ.szText  !2004.02.26 RR
           GET(TreeQ,CHOICE(?TreeList))
           DO PopupMenu
        OF MouseLeft2
           GET(TreeQ,CHOICE(?TreeList))
           IF ?TreeList{PROPLIST:MouseUpZone} = LISTZONE:ICON AND |
              TreeQ.wNoteIcon = ICON:NOTE AND ?TreeList{PROPLIST:MouseUpField} = 1
              POST(EVENT:ACCEPTED,?ViewNoteButton)
           ELSIF INRANGE(TreeQ.lStyle,STYLE:NORMAL_HYPERLINK,STYLE:PROTECTED_NEW_HYPERLINK)
              POST(EVENT:DroppingDown,?HyperlinkButton)
           ELSE
              POST(EVENT:ACCEPTED,?ViewSourceButton)
           END
           CYCLE
      END
    OF EVENT:PreAlertKey
      CASE KEYCODE()
      OF MouseRight
         MouseDownRow = ?TreeList{PROPLIST:MouseDownRow}
         GET(TreeQ,MouseDownRow)
         ?TreeList{PROP:Selected} = MouseDownRow
         DISPLAY(?TreeList)
      END
    END
  OF ?AsciiBox
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseLeft2
         POST(EVENT:Accepted,?ViewSourceButton)
      END
    END
    OMIT('***',_Scintilla_)
    Viewer.TakeEvent(EVENT())
    !***
  OF ?VerticalSplitter
    CASE EVENT()
    OF EVENT:MouseDown
       IF SELF.HasFocus
          bTrackMouse = TRUE
          ?VerticalSplitter{PROP:Color} = COLOR:BLACK
          ?VerticalSplitter{PROP:Fill} = COLOR:BLUE
       END
    OF EVENT:MouseUp
      SETKEYCODE(0)
      ?VerticalSplitter{PROP:Color} = COLOR:NONE
      ?VerticalSplitter{PROP:Fill} = COLOR:NONE
      
      CASE glo:Layout
      OF 1
         IF bTrackMouse
            X = Splitter2_XPos
            IF X > Window{PROP:Width}-13
               X = Window{PROP:Width}-13
            END
            ?TreeList{PROP:Width} = X - ?TreeList{PROP:XPos}
            ?AsciiBox{PROP:XPos} =  X+3
            ?AsciiBox{PROP:Width} = (Window{PROP:Width}-8) - (X+4)
            COMPILE('***',_Scintilla_)
            !======================================================================
            !scintilla support
            !======================================================================
            SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
            SciControl.Reset(FALSE)
            !======================================================================
            !***
            SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
         END
      ELSE
         ?TreeList{PROP:Height} = Splitter2_YPos-?TreeList{PROP:YPos}
         ?AsciiBox{PROP:YPos} = Splitter2_YPos+SPLITTERHEIGHT
         ?AsciiBox{PROP:Height} = Window{PROP:Height}-(Splitter2_YPos+SPLITTERHEIGHT)-22
      
         AsciiBoxHeight = ?AsciiBox{Prop:Height}
      
         OMIT('***',_Scintilla_)
         ?AsciiBox{Prop:Items} = ?AsciiBox{Prop:Items}
         !***
      
         COMPILE('***',_Scintilla_)
         lh = ?SciControl:Region{PROP:LineHeight}
         h = AsciiBoxHeight
         lc = int(h / lh)
         ?AsciiBox{Prop:Items} = lc
         !***
      
         ?AsciiBox{PROP:Ypos} = ?AsciiBox{PROP:Ypos} + (AsciiBoxHeight - ?AsciiBox{Prop:Height})
         ?VerticalSplitter{PROP:Ypos} = ?VerticalSplitter{PROP:Ypos} + (AsciiBoxHeight - ?AsciiBox{Prop:Height})
         ?TreeList{PROP:Height} = ?TreeList{PROP:Height} + (AsciiBoxHeight - ?AsciiBox{Prop:Height})
      
         COMPILE('***',_Scintilla_)
         !======================================================================
         !scintilla support
         !======================================================================
         SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
         SciControl.Reset(FALSE)
         !======================================================================
         !***
         SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
      END
      bTrackMouse = FALSE
      
      OMIT('***',_Scintilla_)
      Viewer.DisplayPage()
      !***
      
      SELF.Reset(TRUE)
    OF EVENT:MouseIn
      IF SELF.HasFocus
         CASE(glo:Layout)
         OF 1
            SETCURSOR(CURSOR:SIZEWE)
         ELSE
            SETCURSOR(CURSOR:SIZENS)
         END
      END
    OF EVENT:MouseOut
      SETCURSOR()
    OF EVENT:MouseMove
      IF SELF.HasFocus AND KEYCODE() = MouseLeft AND bTrackMouse
         X = MouseX()
         Y = MouseY()
         CASE glo:Layout
         OF 1
            IF INRANGE(Y,?ObjectDropList{PROP:YPos}+0,?ObjectDropList{PROP:YPos}+?ObjectDropList{PROP:Height}+0)
               vXPos = ?SplitterBar{PROP:XPos}+3
               XMin = 10
               XMin = CHOOSE(XMin<vXPos,vXPos,XMin)
               IF INRANGE(X,XMin,Window{PROP:Width}-13)
                  ?VerticalSplitter{PROP:Color} = COLOR:BLACK
                  ?VerticalSplitter{PROP:Fill} = COLOR:BLUE
                  ?VerticalSplitter{PROP:XPos} = X
                  Splitter2_XPos = X
               END
            END
         ELSE
            IF INRANGE(Y,74,Window{PROP:Height}-42)
               IF INRANGE(X,?VerticalSplitter{PROP:XPos}+0,?VerticalSplitter{PROP:XPos}+?VerticalSplitter{PROP:Width}+0)
                  ?VerticalSplitter{PROP:Color} = COLOR:BLACK
                  ?VerticalSplitter{PROP:Fill} = COLOR:BLUE
                  ?VerticalSplitter{PROP:YPos} = Y
                  Splitter2_YPos = Y
               END
            END
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
loc:TreeQ:szText     LIKE(TreeQ.szText)
  CODE
  LOOP                                                     ! This method receives all NewSelection events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeNewSelection()
    CASE FIELD()
    OF ?glo:bDetailLevel
      bCount = 10
      bDetailNewSelection = TRUE
      Window{PROP:Timer} = 10
    OF ?TreeList
      GET(TreeQ,CHOICE(?TreeList))
      IF ERRORCODE()
         CLEAR(TreeQ)
      END
      DO ProcessNewSelection
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeSelected PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  !SELF.HasFocus = TRUE
  LOOP                                                     ! This method receives all Selected events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeSelected()
    IF SELECTED() <> ?ObjectDropList
       Locator.Shadow = ''
       ?Locator{PROP:Text} = Locator.Shadow
       HIDE(?LocatorImage)
    END
    CASE FIELD()
    OF ?ObjectDropList
      !ListWithFocus = ?ObjectDropList
    OF ?TreeList
      !ListWithFocus = ?TreeList
    OF ?AsciiBox
      !ListWithFocus = ?AsciiBox
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
FirstTime   BYTE(TRUE),STATIC
X           LONG,AUTO
Y           LONG,AUTO
PanelX      LONG,AUTO
vXPos       LONG,AUTO
MinX        LONG,AUTO
MaxX        LONG,AUTO
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:GainFocus
      SELF.HasFocus = TRUE
    OF EVENT:LoseFocus
      SELF.HasFocus = FALSE
      bTrackMouse = FALSE
      ?SplitterBar{PROP:Color} = COLOR:NONE
      ?SplitterBar{PROP:Fill} = COLOR:NONE
      ?VerticalSplitter{PROP:Color} = COLOR:NONE
      ?VerticalSplitter{PROP:Fill} = COLOR:NONE
    OF EVENT:PreAlertKey
      IF KEYCODE() <> EscKey
         CYCLE
      END
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
        OF F5Key
           POST(EVENT:Accepted,?RefreshButton)
        OF CtrlF5
           loc:ForceSmartScan = TRUE
           POST(EVENT:Accepted,?RefreshButton)
        OF PlusKey
           GET(TreeQ,CHOICE(?TreeList))
           TreeQ:lLevel = ABS(TreeQ:lLevel)
           PUT(TreeQ)
           DISPLAY(?TreeList)
        OF MinusKey
           J = CHOICE(?TreeList)
           IF J < RECORDS(TreeQ)
              GET(TreeQ,J + 1)
              K = ABS(TreeQ:lLevel)
              GET(TreeQ,J)
              IF ABS(TreeQ:lLevel) < K
                 TreeQ:lLevel = ABS(TreeQ:lLevel) * -1
                 PUT(TreeQ)
                 DISPLAY(?TreeList)
              END
           END
        OF BSKey OROF SpaceKey
           IF FOCUS() = ?ObjectDropList
              SETKEYCODE(0)
              POST(EVENT:Accepted,?ObjectDropList)
           END
      END
    OF EVENT:DoResize
      CASE glo:Layout
      OF 1
         X = ?SplitterBar{PROP:XPos}
         vXPos = ?VerticalSplitter{PROP:XPos}
         MaxX = Window{PROP:Width}-192
         MaxX = CHOOSE(MaxX<vXPos,MaxX,vXPos)
         IF X < 8
            X = 8
         ELSIF X > MaxX
            X = MaxX
         END
      
         vXPos = ?SplitterBar{PROP:XPos}
         MinX = 10
         MinX = CHOOSE(vXPos>MinX,vXPos,MinX)
         Y = ?VerticalSplitter{PROP:XPos}
         IF Y < MinX
            Y = MinX
         ELSIF Y > Window{PROP:Width}-10
            Y = Window{PROP:Width}-10
         END
      
         PanelX = CHOOSE(X < PANELMINIMUMX,PANELMINIMUMX,X)
      
         ?ObjectDropList{PROP:Width} = X-8
      
         ?TreeList{PROP:XPos} = X+2
         ?TreeList{PROP:Width} = Y - (X+2)
      
         ?AsciiBox{PROP:XPos} = Y+3
         ?AsciiBox{PROP:Width} = Window{PROP:Width}-(Y+2)-8
      
         ?SplitterBar{PROP:Height} = ?TreeList{PROP:Height}
         ?SplitterBar{PROP:YPos} = ?TreeList{PROP:YPos}
         ?SplitterBar{PROP:XPos} = X
         ?SplitterBar:2{PROP:XPos} = PanelX
         Splitter1_XPos = X
      
         ?VerticalSplitter{PROP:XPos} = Y
         Splitter2_XPos = Y
         ?VerticalSplitter{PROP:Height} = ?TreeList{PROP:Height}
      
          COMPILE('***',_Scintilla_)
         !======================================================================
         !scintilla support
         !======================================================================
         SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
         SciControl.Reset(FALSE)
         !======================================================================
          !***
         SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
      ELSE
         X = ?SplitterBar{PROP:XPos}
         IF X < 75
            X = 75
         ELSIF X > Window{PROP:Width}-192
            X = Window{PROP:Width}-192
         END
      
         Y = ?VerticalSplitter{PROP:YPos}
         IF Y < 74
            Y = 74
         ELSIF Y > Window{PROP:Height}-42
            Y = Window{PROP:Height}-42
         END
      
         PanelX = CHOOSE(X < PANELMINIMUMX,PANELMINIMUMX,X)
      
         ?ObjectDropList{PROP:Width} = X-8
      
         ?TreeList{PROP:XPos} = X+2
         ?TreeList{PROP:Width} = Window{PROP:Width}-(X+2)-8
         ?TreeList{PROP:Height} = Y-?TreeList{PROP:YPos}
      
         ?AsciiBox{PROP:XPos} = X+3
         ?AsciiBox{PROP:YPos} = Y+SPLITTERHEIGHT
         ?AsciiBox{PROP:Width} = Window{PROP:Width}-(X+2)-9
         ?AsciiBox{PROP:Height} = Window{PROP:Height}-(Y+SPLITTERHEIGHT)-22
      
         ?SplitterBar{PROP:Height} = ?TreeList{PROP:Height} + ?AsciiBox{PROP:Height} + SPLITTERHEIGHT
         ?SplitterBar{PROP:YPos} = ?TreeList{PROP:YPos}
         ?SplitterBar{PROP:XPos} = X
         Splitter1_XPos = X
         ?SplitterBar:2{PROP:XPos} = PanelX
      
         ?VerticalSplitter{PROP:XPos} = X+2
         ?VerticalSplitter{PROP:YPos} = Y
         Splitter2_YPos = Y
         ?VerticalSplitter{PROP:Width} = Window{PROP:Width}-(X+2)-8
         ?VerticalSplitter{PROP:Height} = 2
      
          COMPILE('***',_Scintilla_)
         !======================================================================
         !scintilla support
         !======================================================================
         SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
         SciControl.Reset(FALSE)
         !======================================================================
          !***
         SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
      END
      
      ?glo:szCategoryChoice{PROP:Width} = PanelX - ?glo:szCategoryChoice{PROP:XPos} - 2
      ?glo:bDetailLevel:Prompt{PROP:XPos} = PanelX + 8
      ?glo:bDetailLevel{PROP:XPos} = PanelX + 36
      ?glo:bShowProtected{PROP:XPos} = PanelX + 54
      ?glo:bShowPrivate{PROP:XPos} = PanelX + 104
      ?glo:bShowModule{PROP:XPos} = PanelX + 154
      
      DO CreateFavoritesMenu
      
      POST(EVENT:MouseUp,?SplitterBar)
      POST(EVENT:MouseUp,?VerticalSplitter)
    OF EVENT:Iconize
      IF IsZoomed(0{PROP:Handle})
         bSizeOnMaximize = TRUE
      ELSE
         bSizeOnMaximize = FALSE
      END
      J = RECORDS(ViewerThreadQ)
      LOOP I = 1 TO J
         GET(ViewerThreadQ,I)
         POST(EVENT:Iconize,,ViewerThreadQ.lThreadId)
      END
    OF EVENT:Maximized
      IF bSizeOnMaximize
         bSizeOnMaximize = FALSE
         POST(EVENT:Sized)
      END
    OF EVENT:Restore
      J = RECORDS(ViewerThreadQ)
      LOOP I = 1 TO J
         GET(ViewerThreadQ,I)
         POST(EVENT:Restore,,ViewerThreadQ.lThreadId)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window
  LOOP FldEqu = ?ExpandButton TO ?Panel6
    SELF.SetStrategy(FldEqu, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  END
  
  SELF.SetStrategy(?ObjectDropList, Resize:FixLeft+Resize:FixTop, Resize:LockWidth+Resize:ConstantBottom)
  
  SELF.SetStrategy(?glo:szCategory:Prompt, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?glo:szCategoryChoice, Resize:FixLeft+Resize:FixTop, Resize:LockHeight+Resize:ConstantRight)
  SELF.SetStrategy(?glo:bDetailLevel:Prompt, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?glo:bDetailLevel, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  
  SELF.SetStrategy(?glo:bShowProtected, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?glo:bShowPrivate, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?glo:bShowModule, Resize:FixLeft+Resize:FixTop, Resize:LockSize)
  
  SELF.SetStrategy(?HyperlinkButton, Resize:FixRight+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?PrevHyperlink, Resize:FixRight+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?NextHyperlink, Resize:FixRight+Resize:FixTop, Resize:LockSize)
  SELF.SetStrategy(?HistoryList, Resize:FixRight+Resize:FixTop, Resize:LockSize)
  
  SELF.SetStrategy(?Locator, Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  
  SELF.SetStrategy(?VcrTop, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VcrRewind, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VcrBack, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VcrPlay, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VcrFastForward, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VcrBottom, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  
  SELF.SetStrategy(?VirtualBox,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?VirtualString,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?ProtectedBox,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?ProtectedString,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?PrivateBox,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?PrivateString,Resize:FixLeft+Resize:FixBottom, Resize:LockSize)
  
  SELF.SetStrategy(?CloseButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize)
  SELF.SetStrategy(?SizeGrip, Resize:FixRight+Resize:FixBottom, Resize:LockSize)


Resizer.Resize PROCEDURE

ReturnValue          BYTE,AUTO

PanelX               LONG,AUTO
vXPos1               LONG,AUTO
vXPos2               LONG,AUTO
vcrXPos              LONG,AUTO
vcrYPos              LONG,AUTO

  CODE
  vXPos1 = ?SplitterBar{prop:XPos}
  vXPos2 = ?VerticalSplitter{prop:XPos}
  ReturnValue = PARENT.Resize()
  ?HistoryList{PROP:XPos}     = Window{PROP:Width} - 18
  ?NextHyperlink{PROP:XPos}   = Window{PROP:Width} - 30 !29
  ?PrevHyperlink{PROP:XPos}   = Window{PROP:Width} - 42 !40
  ?HyperlinkButton{PROP:XPos} = Window{PROP:Width} - 54 !51
  
  ?LocatorImage{PROP:YPos} = ?ObjectDropList{PROP:YPos} + ?ObjectDropList{PROP:Height} + 1
  ?Locator{PROP:YPos} = ?LocatorImage{PROP:YPos}
  
  CASE glo:Layout
  OF 1
     ?ObjectDropList{PROP:Width} = vXPos1 - 8
     ?SplitterBar{PROP:Height} = ?ObjectDropList{PROP:Height}
     ?SplitterBar{PROP:YPos} = ?ObjectDropList{PROP:YPos}
     ?SplitterBar{PROP:XPos} = vXPos1
  
     ?TreeList{PROP:XPos} = vXPos1+2
     ?TreeList{PROP:YPos} = ?ObjectDropList{PROP:YPos}
     ?TreeList{PROP:Width} = vXPos2-(vXPos1+2)
     ?TreeList{PROP:Height} = ?ObjectDropList{PROP:Height}
  
     ?VerticalSplitter{PROP:XPos} = vXPos2
     ?VerticalSplitter{PROP:YPos} = ?TreeList{PROP:YPos}
  
     ?AsciiBox{PROP:XPos} = ?VerticalSplitter{PROP:XPos} + 3
     ?AsciiBox{PROP:YPos} = ?VerticalSplitter{PROP:YPos} + SPLITTERHEIGHT - 2
     ?AsciiBox{PROP:Height} = ?ObjectDropList{PROP:Height} - SPLITTERHEIGHT + 2
     ?AsciiBox{PROP:Width} = Window{PROP:Width} - ?AsciiBox{PROP:XPos} - 9
  
  ELSE  !default
     ?TreeList{PROP:YPos} = ?ObjectDropList{PROP:YPos}
  
     ?VerticalSplitter{PROP:XPos} = ?TreeList{PROP:XPos}
     ?VerticalSplitter{PROP:YPos} = ?TreeList{PROP:YPos} + ?TreeList{PROP:Height}
     ?VerticalSplitter{PROP:Width} = ?TreeList{PROP:Width}
  
     ?AsciiBox{PROP:XPos} = ?TreeList{PROP:XPos}+1
     ?AsciiBox{PROP:YPos} = ?TreeList{PROP:YPos} + ?TreeList{PROP:Height} + SPLITTERHEIGHT
     ?AsciiBox{PROP:Width} = ?TreeList{PROP:Width}-1
     ?AsciiBox{PROP:Height} = Window{PROP:Height} - ?VerticalSplitter{PROP:YPos} - (22 + SPLITTERHEIGHT)   !24
  
     ?SplitterBar{PROP:Height} = ?ObjectDropList{PROP:Height}
     ?SplitterBar{PROP:YPos} = ?TreeList{PROP:YPos}
     ?SplitterBar{PROP:XPos} = ?TreeList{PROP:XPos} - 2
  END
  
  PanelX = ?TreeList{PROP:XPos} - 2
  PanelX = CHOOSE(PanelX < PANELMINIMUMX, PANELMINIMUMX, PanelX)
  
  ?SplitterBar:2{PROP:XPos} = PanelX
  
  COMPILE('***',_Scintilla_)
  !======================================================================
  !scintilla support
  !======================================================================
  SETPOSITION(?SciControl:Region,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos},?AsciiBox{PROP:Width},?AsciiBox{PROP:Height})
  SciControl.Reset(FALSE)
  !======================================================================
  !***
  SETPOSITION(?loc:szAsciiFilename,?AsciiBox{PROP:XPos},?AsciiBox{PROP:YPos}-6,?AsciiBox{PROP:Width},)
  
  ?ModuleBox{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?ModuleString{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?EquateBox{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?Equate:Image{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?GroupdEquate:String{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?EnumerationBox{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?Enumeration:Image{PROP:YPos} = ?VirtualBox{PROP:YPos}
  ?EnumeratedEquate:String{PROP:YPos} = ?VirtualBox{PROP:YPos}
  
  ?Panel7{PROP:XPos} = (Window{PROP:Width} - ?RefreshGroup{PROP:Width})/2
  ?ProcessString{PROP:XPos} = ?Panel7{PROP:XPos}+4
  ?ScanString{PROP:XPos} = ?Panel7{PROP:XPos}+4
  ?glo:lLineNum{PROP:XPos} = ?Panel7{PROP:XPos}+211
  ?Panel8{PROP:XPos} = ?Panel7{PROP:XPos}+29
  ?Panel8:2{PROP:XPos} = ?Panel7{PROP:XPos}+29
  ?ProgressBox{PROP:XPos} = ?Panel7{PROP:XPos}+30
  ?ProgressBox:2{PROP:XPos} = ?Panel7{PROP:XPos}+30
  ?Box5{PROP:XPos} = ?Panel7{PROP:XPos}+2
  !?Box6{PROP:XPos} = ?Panel7{PROP:XPos}+?Panel7{PROP:Width}  !258
  
  DO DrawLatchBox
  
  OMIT('***',_Scintilla_)
  Viewer.DisplayPage()
  !***
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
foldQ           QUEUE,PRE(foldQ)
foldLine          LONG
                END

Indx            LONG
Jndx            LONG
szText          CSTRING(1024)
cchText         LONG
foldLevel       LONG
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


SciControl.FindWindowTakeCloseWindow PROCEDURE

  CODE
  Viewer_tt.Kill()
  PARENT.FindWindowTakeCloseWindow


SciControl.FindWindowTakeOpenWindow PROCEDURE

Fld     LONG,AUTO
  CODE
  !  hwndViewer_tt = Viewer_tt.init(0{PROP:HANDLE},1) !ToolTipClass Initialization
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
        IF glo:bClarionVersion >= CWVERSION_C70 !CWVERSION_C71
           szStandardEquates = szStandardEquates & |
                               ' BEEP: BUTTON: CHARSET: COLOR: CREATE: CURSOR: DATATYPE: DDE: DOCK: DRIVEROP: '   & |
                               'EVENT: FF_: FILE: FONT: ICON: LISTZONE: MATCH: OCX: OCXEVENT: PAPER: PAPERBIN: '  & |
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
     OF SCEN_SETFOCUS
        ListWithFocus = -1
     !OF SCEN_KILLFOCUS
     !   ListWithFocus = 0
  
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
  COMPILE('***',_Scintilla_)
  !======================================================================
  !scintilla support
  !======================================================================
  IF bControlInitialised
     SciControl.UsePopup(FALSE)
     SciControl.SetDefaults()
  END
  !***
  RETURN ReturnValue

