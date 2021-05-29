   PROGRAM


  INCLUDE('cwHH.INC'),ONCE
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

   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('CSIDL.EQU'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('SPECIALFOLDER.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('Devuna.CLW','equates'),ONCE
   INCLUDE('KCRAPI.INC'),ONCE
   INCLUDE('kcrAsciiFileClass.inc'),ONCE
   INCLUDE('XMLClass.inc'),ONCE
   INCLUDE('CSciViewer.inc'),ONCE

TreeStyles            ITEMIZE(1),PRE(STYLE)
NORMAL                  EQUATE
PRIVATE                 EQUATE
PROTECTED               EQUATE
MODULE                  EQUATE
VIRTUAL                 EQUATE
NORMAL_NEW              EQUATE
PRIVATE_NEW             EQUATE
PROTECTED_NEW           EQUATE
MODULE_NEW              EQUATE
VIRTUAL_NEW             EQUATE
NORMAL_HYPERLINK        EQUATE  !Hyperlink's need to remain consecutive
PRIVATE_HYPERLINK       EQUATE  !
PROTECTED_HYPERLINK     EQUATE  !
MODULE_HYPERLINK        EQUATE  !
NORMAL_NEW_HYPERLINK    EQUATE  !
PRIVATE_NEW_HYPERLINK   EQUATE  !
PROTECTED_NEW_HYPERLINK EQUATE  !
MODULE_NEW_HYPERLINK    EQUATE  !Hyperlink's need to remain consecutive
                      END

TreeIcons         ITEMIZE(1),PRE(ICON)
CLASS               EQUATE
NEWCLASS            EQUATE
INTERFACEFOLDER     EQUATE
NEWINTERFACEFOLDER  EQUATE
PROPERTYFOLDER      EQUATE
METHODFOLDER        EQUATE
STRUCTUREFOLDER     EQUATE
EQUATEFOLDER        EQUATE
INTERFACE           EQUATE
PROPERTY            EQUATE
METHOD              EQUATE
STRUCTURE           EQUATE
EQUATE              EQUATE
ENUMFOLDER          EQUATE
NOTE                EQUATE
                  END
CONTRACTIONLEVEL  EQUATE(ICON:PROPERTYFOLDER)

TreeViews         ITEMIZE(1),PRE(VIEW)
CLASSES             EQUATE
STRUCTURES          EQUATE
EQUATES             EQUATE
CALLS               EQUATE
INTERFACES          EQUATE
                  END

ClarionVersions   ITEMIZE(1)
CWVERSION_C2        EQUATE
CWVERSION_C4        EQUATE
CWVERSION_C5        EQUATE
CWVERSION_C5EE      EQUATE
CWVERSION_C55       EQUATE
CWVERSION_C55EE     EQUATE
CWVERSION_C60       EQUATE
CWVERSION_C60EE     EQUATE
CWVERSION_C70       EQUATE
CWVERSION_C80       EQUATE
CWVERSION_C90       EQUATE
CWVERSION_C100      EQUATE
CWVERSION_C110      EQUATE ! mr 2021-05-29
                  END

Msg:DeleteNote    EQUATE(50)
Msg:SaveNote      EQUATE(51)
Msg:QueryRefresh  EQUATE(52)

SEARCHQTYPE       QUEUE,TYPE
szPath               CSTRING(1024)
                  END

MODULEQTYPE       QUEUE,TYPE
szModuleName        CSTRING(64)
szModulePath        CSTRING(256)
bClarionVersion     BYTE
                  END

THREADQTYPE       QUEUE,TYPE
lThreadId           LONG
                  END

CATEGORYQUEUETYPE QUEUE,TYPE
szCategory          CSTRING(64)
                  END

TREEQUEUETYPE     QUEUE,TYPE !Tree Queue Type
sNote                STRING(1)
wNoteIcon            SHORT
szText               CSTRING(384)
wIcon                SHORT
lLevel               LONG
lStyle               LONG
szTipText            CSTRING(256)
szSearch             CSTRING(64)
szClassName          CSTRING(64)
szContextString      CSTRING(256)
szHelpFile           CSTRING(256)
lLineNum             LONG
lSourceLine          LONG
lIncludeId           LONG
lModuleId            LONG
lOccurranceLine      LONG
                   END

TEMPLATEQTYPE      QUEUE,TYPE
szName               CSTRING(61)
szPath               CSTRING(256)
                   END

FAVORITESQTYPE     QUEUE,TYPE
szName               CSTRING(61)
szPath               CSTRING(256)
SequenceNo           BYTE
MenuFeq              LONG
                   END

TOKENQUEUETYPE  QUEUE,TYPE
szPrompt            CSTRING(61)
szType              CSTRING(21)
szPicture           CSTRING(21)
szName              CSTRING(61)
szDefault           CSTRING(256)
szRadioValue        CSTRING(256)
szScope             CSTRING(256)
low                 CSTRING(21)
high                CSTRING(21)
step                CSTRING(21)
bChoice             BYTE
xPos                LONG
yPos                LONG
width               LONG
height              LONG
prompt_xPos         LONG
prompt_yPos         LONG
prompt_width        LONG
prompt_height       LONG
szValue             &CSTRING
nValue              &REAL
PromptFeq           LONG
EntryFeq            LONG
bFree               BYTE
                END

CURSOR:VSPLITBAR    EQUATE('<0FFH,02H,08H,7FH>')

NORMAL_PRIORITY_CLASS   EQUATE(00000020h)
IDLE_PRIORITY_CLASS     EQUATE(00000040h)
HIGH_PRIORITY_CLASS     EQUATE(00000080h)
REALTIME_PRIORITY_CLASS EQUATE(00000100h)

FLOODFILLSURFACE    EQUATE(1)

MIM_MAXHEIGHT       EQUATE(000000001h)
MIM_BACKGROUND      EQUATE(000000002h)
MIM_HELPID          EQUATE(000000004h)
MIM_MENUDATA        EQUATE(000000008h)
MIM_STYLE           EQUATE(000000010h)
MIM_APPLYTOSUBMENUS EQUATE(080000000h)

DI_MASK             EQUATE(00001)
DI_IMAGE            EQUATE(00002)
DI_NORMAL           EQUATE(00003)
DI_COMPAT           EQUATE(00004)
DI_DEFAULTSIZE      EQUATE(00008)
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('COOLTIPS.INC'),ONCE
   INCLUDE('iQXML.INC','Equates')
 OMIT('_EndOfInclude_',_ImpExGlobalDataPresent_)
_ImpExGlobalDataPresent_    EQUATE(1)
!----------------------------------------------------------------------
! Import Export Global Data variables and equates
!----------------------------------------------------------------------
ImpexActionEquates      ITEMIZE(0),PRE(ACTION)
SAVE                        EQUATE
LOAD                        EQUATE
DELETE                      EQUATE
IDENTIFY                    EQUATE
                        END
!_EndOfInclude_
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('KCRQEIP.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('KCRQEIP.INC'),ONCE
   INCLUDE('ABEIP.INC')
   INCLUDE('KCRQEIP.INC')

   MAP
     MODULE('ABCVIEW_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
     MODULE('ABCVIEW001.CLW')
Main                   PROCEDURE   !Clarion Class Viewer
     END
     MODULE('ABCVIEW002.CLW')
srcRefreshQueues       FUNCTION(LONG ProcessString, LONG ScanString, LONG ProgressBox, LONG FileProgressBox, LONG RefreshGroup),LONG,PROC   !Scan Source Files and fill Queues
     END
     MODULE('ABCVIEW003.CLW')
srcAddDerivedClass     PROCEDURE(STRING szParentClass, LONG lTreeLevel)   !Add Derived Class to Tree
     END
     MODULE('ABCVIEW004.CLW')
srcRefreshTree         PROCEDURE   !Refresh the Class Hierarchy Tree
     END
     MODULE('ABCVIEW005.CLW')
srcAddProperties       PROCEDURE(LONG lTreeLevel)   !Add Class Properties to Tree
     END
     MODULE('ABCVIEW006.CLW')
srcAddMethods          PROCEDURE(LONG lTreeLevel)   !Add Class Methods to Tree
     END
     MODULE('ABCVIEW007.CLW')
winOptions             FUNCTION(),BYTE   !Edit User Preferences
     END
     MODULE('ABCVIEW008.CLW')
srcGetColorString      FUNCTION(long lColor),STRING   !Return Color String
     END
     MODULE('ABCVIEW009.CLW')
winViewAsciiFile       PROCEDURE(STRING szFileName, STRING pWhat)   !View Ascii File
srcViewAsciiFile       PROCEDURE(LONG lModuleId, *? pWhat, *THREADQTYPE pThreadQ)   !
winSciViewAsciiFile    PROCEDURE(STRING sFileName, LONG LineNo)   !Scintilla Ascii File Viewer
     END
     MODULE('ABCVIEW010.CLW')
srcGetSourceLine       FUNCTION(LONG lModuleId, STRING sMethod, STRING sPrototype, <*CSTRING Buffer>),LONG   !Get Method Definition Start Line
     END
     MODULE('ABCVIEW011.CLW')
Access:Memory          FUNCTION(*CSTRING szFileName,BYTE bMode),LONG,PROC   !
     END
     MODULE('ABCVIEW012.CLW')
srcEqual               FUNCTION(STRING S1,STRING S2),BOOL   !Compare with blanks suppressed
     END
     MODULE('ABCVIEW013.CLW')
srcGetPrototype        FUNCTION(STRING sString),STRING   !extract prototype from passed string
     END
     MODULE('ABCVIEW014.CLW')
srcRemoveLabels        FUNCTION(STRING s),STRING   !Remove labels from passed prototype string
     END
     MODULE('ABCVIEW015.CLW')
srcGetLabel            FUNCTION(STRING s),STRING   !Get Statement Label
     END
     MODULE('ABCVIEW016.CLW')
srcGetStatement        FUNCTION(STRING s),STRING   !Get Data Statement
     END
     MODULE('ABCVIEW017.CLW')
srcAddStructures       PROCEDURE   !Add Class Structures to Tree
     END
     MODULE('ABCVIEW018.CLW')
srcAddEquates          PROCEDURE   !Add Itemized Equates to Tree
     END
     MODULE('ABCVIEW019.CLW')
srcGetEquateValue      FUNCTION(STRING szEnumLabel,*BYTE bIsHexValue),STRING   !Find Equate Value
     END
     MODULE('ABCVIEW020.CLW')
srcBuildCallQueue      PROCEDURE(LONG ScanString, LONG ProgressBox, LONG FileProgressBox)   !Build Method Calling Queue
     END
     MODULE('ABCVIEW021.CLW')
srcGetCalledMethods    PROCEDURE(STRING s,STRING szSelf, STRING szParent)   !get called methods from string
     END
     MODULE('ABCVIEW022.CLW')
srcIsClassReference    FUNCTION(STRING szDataType, *CSTRING szClassName, *LONG lClassID),BOOL   !Is datatype a reference to a class
     END
     MODULE('ABCVIEW023.CLW')
winBrowseCallQ         FUNCTION(),STRING   !Browse the CallQ
     END
     MODULE('ABCVIEW024.CLW')
srcReplaceString       FUNCTION(STRING s, STRING sAttribute, *ANY sNewValue),STRING   !Replace a string
     END
     MODULE('ABCVIEW025.CLW')
srcAddCalls            PROCEDURE(STRING szTreeName, STRING szCallingMethod, LONG lTreeLevel)   !Add Method Calls to Tree
     END
     MODULE('ABCVIEW026.CLW')
srcResolveName         FUNCTION(STRING szName, STRING szSelf, STRING szParent),STRING   !resolve name references
     END
     MODULE('ABCVIEW027.CLW')
srcIsClassMethod       FUNCTION(STRING szName),BOOL   !Is name a class method
     END
     MODULE('ABCVIEW028.CLW')
srcIsInterfaceReference FUNCTION(STRING szDataType),BOOL   !Is datatype an interface reference
     END
     MODULE('ABCVIEW029.CLW')
srcIsInterfaceMethod   FUNCTION(STRING szName),BOOL   !Is name an interface method
     END
     MODULE('ABCVIEW030.CLW')
winAdditionalFiles     PROCEDURE(*MODULEQTYPE pModuleQ, BYTE bClarionVersion)   !Edit Additional Files List
     END
     MODULE('ABCVIEW031.CLW')
winViewNote            PROCEDURE(BYTE bClarionVersion, STRING szLookup)   !View Annotation
     END
     MODULE('ABCVIEW032.CLW')
winClassProperties     FUNCTION(*CATEGORYQUEUETYPE CategoryQueue),BYTE   !Edit Class Properties
     END
     MODULE('ABCVIEW033.CLW')
winViewCallers         PROCEDURE(STRING psCalledMethod)   !View Methods that Call passed Method
     END
     MODULE('ABCVIEW034.CLW')
AboutDevuna            PROCEDURE   !About Devuna
     END
     MODULE('ABCVIEW035.CLW')
srcIsStructureReference FUNCTION(STRING szDataType, *CSTRING szStructName),BOOL   !Is datatype a reference to a structure
     END
     MODULE('ABCVIEW036.CLW')
srcAddInterfaces       PROCEDURE(LONG lTreeLevel)   !Add Class Interfaces to Tree
     END
     MODULE('ABCVIEW037.CLW')
srcIsBaseClassABC      FUNCTION(*CSTRING pszClass),BYTE   !Returns TRUE is Base Class is ABC
     END
     MODULE('ABCVIEW038.CLW')
winGetScanOptions      FUNCTION(BYTE ForceSmartScan=0),LONG   !Get Scan Options
     END
     MODULE('ABCVIEW039.CLW')
winLoading             PROCEDURE   !Splash Screen
     END
     MODULE('ABCVIEW040.CLW')
_main                  PROCEDURE   !
     END
     MODULE('ABCVIEW041.CLW')
ProgramIsRunning       FUNCTION(String SemaphoreValue, String WindowTitle),Byte   !
     END
     MODULE('ABCVIEW042.CLW')
srcWordWrap            PROCEDURE(*CSTRING s,LONG w)   !Insert CRLF to word wrap
     END
     MODULE('ABCVIEW043.CLW')
winExportDatabaseToXML PROCEDURE   !
     END
     MODULE('ABCVIEW044.CLW')
srcNormalizeString     FUNCTION(STRING s),STRING   !Normalize String for XML Output
     END
     MODULE('ABCVIEW045.CLW')
srcExportTreeToXML     PROCEDURE   !
     END
     MODULE('ABCVIEW046.CLW')
winFindNotes           FUNCTION(),LONG   !Display The Note Queue
     END
     MODULE('ABCVIEW047.CLW')
srcFindComment         FUNCTION(STRING s),LONG   !Find Comment Marker
     END
     MODULE('ABCVIEW048.CLW')
winAddClass            FUNCTION(),BYTE   !Add a New Class File
     END
     MODULE('ABCVIEW049.CLW')
winTemplateFiles       PROCEDURE(*TEMPLATEQTYPE pTemplateQ, STRING sCaption)   !Edit Template Files List
     END
     MODULE('ABCVIEW050.CLW')
srcGetReturnType       FUNCTION(*CSTRING sz),STRING   !Get Procedure Return Type
     END
     MODULE('ABCVIEW051.CLW')
srcGetParameters       FUNCTION(*CSTRING sz),STRING   !Get parameters from passed prototype
     END
     MODULE('ABCVIEW052.CLW')
srcParsePrompt         FUNCTION(*CSTRING sz, *TOKENQUEUETYPE Token),BYTE   !Parse #PROMPT string
     END
     MODULE('ABCVIEW053.CLW')
winFavoritesMenu       PROCEDURE(*FAVORITESQTYPE pFavoritesMenuQ)   !Edit Favorites Menu List
     END
     MODULE('ABCVIEW054.CLW')
srcRemoveWhitespace    FUNCTION(*STRING s),STRING   !Remove unnecessary white space from passed string
     END
     MODULE('ABCVIEW055.CLW')
winUpdateProperty      PROCEDURE   !Update Class Property
     END
     MODULE('ABCVIEW056.CLW')
winUpdateMethod        PROCEDURE   !Update Class Method
     END
     MODULE('ABCVIEW057.CLW')
srcGetWordList         FUNCTION(*CSTRING ClarionKeywords, *CSTRING CompilerDirectives, *CSTRING BuiltinProcsFuncs, *CSTRING StructDataTypes, *CSTRING Attributes, *CSTRING StandardEquates),LONG,PROC   !Get CEDT word list
     END
     MODULE('ABCVIEW058.CLW')
srcGetCedtColors       PROCEDURE(*COLORGROUPTYPE ColorGroup, LONG LoadDefault=0)   !Get CEDT colors list
     END
     MODULE('ABCVIEW059.CLW')
winShowStatistics      PROCEDURE   !
     END
     MODULE('ABCVIEW060.CLW')
srcAddToUserMenu       FUNCTION(BYTE bMode),BYTE,PROC   !Add ClassViewer to the Clarion Menu
     END
     MODULE('ABCVIEW061.CLW')
srcFindWindow          FUNCTION(STRING sWindowText),LONG   !
     END
     MODULE('ABCVIEW062.CLW')
Calculator             PROCEDURE   !Calculator
     END
     MODULE('ABCVIEW063.CLW')
winGenerateTemplate    FUNCTION(*CSTRING szClassName),LONG,PROC   !Class Wrapper Template Generator
     END
     MODULE('ABCVIEW064.CLW')
srcGetPrototypeAttr    FUNCTION(STRING sAttribute, STRING sString),STRING   !extract prototype attribute from passed string
     END
     MODULE('ABCVIEW065.CLW')
srcGetImplements       FUNCTION(LONG lClassId, *CSTRING Buffer),LONG   !Get Class Interface Implementations
     END
     MODULE('ABCVIEW066.CLW')
srcGetLineComments     FUNCTION(STRING sFilename, LONG lLineNum),STRING   !Get Method Definition Start Line
     END
     MODULE('ABCVIEW067.CLW')
srcFindModule          PROCEDURE(*CSTRING szModulePath, *CSTRING szModuleName)   !Find location of included file
     END
     MODULE('ABCVIEW068.CLW')
srcReadClarionProps    PROCEDURE(*CSTRING szXmlFilename)   !
     END
     MODULE('ABCVIEW069.CLW')
srcColorFromName       FUNCTION(STRING KnownColorName),STRING   !Returns RGB value for named color
     END
     MODULE('ABCVIEW070.CLW')
srcGetSearchFoldersFromRedFile PROCEDURE(*SEARCHQTYPE pSearchQueue, *CSTRING pRedFilename)   !
     END
     INCLUDE('Devuna.CLW','map'),ONCE
     INCLUDE('KCRAPIFNC.INC'),ONCE
     INCLUDE('CWUTIL.INC'),ONCE
     MODULE('CLIB')
       strtoul(*CSTRING s,*ULONG endptr,SIGNED base),ULONG,RAW,NAME('_strtoul'),PROC
       ultoa(ULONG num,*CSTRING s,SIGNED radix),ULONG,RAW,NAME('_ultoa'),PROC
     END
     MODULE('win32.lib')
        CreateMutex (<*LONG>,BOOL,<*CSTRING>),HANDLE,RAW, |
                     PASCAL,NAME('CreateMutexA'),PROC
        CreateSemaphore(<*SECURITY_ATTRIBUTES lpSemaphoreAttributes>, |
                        LONG lInitialCount, |
                        LONG lMaximumCount, |
                        *CSTRING lpName),   |
                        LONG,RAW,PASCAL,NAME('CreateSemaphoreA')
        FindWindow(<*CSTRING lpClassName>, |
                  *CSTRING lpWindowName),|
                  UNSIGNED,PASCAL,RAW,NAME('FindWindowA')
        IsIconic(UNSIGNED),BOOL,PASCAL
        CreateBrushIndirect(*LOGBRUSH),UNSIGNED,PASCAL,RAW
        ExtFloodFill(UNSIGNED, SIGNED, SIGNED, ULONG, UNSIGNED),BOOL,PASCAL,PROC
        FrameRect(HDC, *RECT, UNSIGNED),SIGNED,PASCAL,RAW,PROC
        OffsetRect(*RECT, SIGNED, SIGNED),PASCAL,RAW
     
        GetMenuInfo(UNSIGNED hMenu, *MENUINFO lpmi),BOOL,RAW,PASCAL,PROC
        SetMenuInfo(UNSIGNED hMenu, *MENUINFO lpmi),BOOL,RAW,PASCAL,PROC
        CreatePatternBrush(UNSIGNED hBitmap),UNSIGNED,PASCAL
        FindResource(Unsigned hModule,  | ! Handle to the module whose executable file contains the resource
                     Long lpName,       | ! Specifies the name of the resource
                     Long lpType        | ! Specifies the resource type
                     ),Unsigned,Pascal,Raw,Name('FindResourceA')
        LoadResource(Unsigned hModule,  | ! Handle to the resource to be locked
                     Long hResInfo      |
                    ),Unsigned,Pascal,Raw ! If the loaded resource is locked, the return value is a pointer to the first byte of the resource; otherwise, it is NULL.
        LockResource(Unsigned hResData),Long,Pascal
     END
     MODULE('shell32.lib')
        FindExecutable(*CSTRING lpFile, *CSTRING lpDirectory, *CSTRING lpResult),ULONG,RAW,PROC,PASCAL,NAME('FindExecutableA')
        ExtractIconEx(*CSTRING lpszFile, LONG nIconIndex, LONG phIconLarge, LONG phIconSmall, LONG nIcons),LONG,RAW,PROC,PASCAL,NAME('ExtractIconExA')
     END
     MODULE('User32.lib')
        DestroyIcon(LONG hIcon),LONG,PROC,PASCAL
        DrawIconEx(LONG hdc, LONG xLeft, LONG yTop, LONG hIcon, LONG cxWidth, LONG cyWidth, LONG istepIfAniCur, LONG hbrFlickerFreeDraw, LONG diFlags),LONG,PROC,PASCAL
     END
     MODULE('shlwapi.lib')
       PathCompactPathEx(*CSTRING pszOut, *CSTRING pszSrc, UNSIGNED cchMax, DWORD dwFlags),BOOL,RAW,PROC,PASCAL,NAME('PathCompactPathExA')
     END
        INCLUDE('iQXML.INC','Modules')
   END

glo:Version          CSTRING('2017.07.03<0,0,0>')
glo:hwnd_main        LONG
glo:lMainThread      LONG
glo:lLoadingThread   LONG
glo:bRefreshAll      BYTE
szIniFilename        CSTRING(256)
szRoot               CSTRING(256),THREAD,AUTO
szShared             CSTRING(256),THREAD,AUTO
szAsciiFilename      CSTRING(256),THREAD,AUTO
glo:szRedFilePath    CSTRING(256),THREAD,AUTO
glo:szCurrentDir     CSTRING(256),THREAD,AUTO
glo:bCurrentView     BYTE(1)
glo:lModuleColor     LONG
glo:lPrivateColor    LONG(COLOR:RED)
glo:lProtectedColor  LONG(COLOR:MAROON)
glo:lVirtualColor    LONG(COLOR:FUSCHIA)
glo:lSelectedBack    LONG(COLOR:NAVY)
glo:lSelectedFore    LONG
glo:lNoteColor       LONG
glo:lHighlightColor1 LONG
glo:lHighlightColor2 LONG
glo:lHyperlinkColor  LONG
glo:bClarionVersion  BYTE(2)
glo:bABCOnly         BYTE(TRUE)
glo:bShowModule      BYTE
glo:bShowPrivate     BYTE
glo:bShowProtected   BYTE
glo:bShowTips        BYTE(1)
glo:bOpaqueCheckBox  BYTE
glo:bForceEdit       BYTE
glo:bUseAssociation  BYTE
glo:szEditorCommand  CSTRING(256)
glo:Background       BYTE(2)
glo:Color1           LONG
glo:Color2           LONG
glo:szWallpaper1     CSTRING(256)
glo:szWallpaper2     CSTRING(256)
glo:Tiled1           BYTE
glo:Tiled2           BYTE
glo:Typeface         STRING(31)
glo:FontSize         LONG
glo:FontColor        LONG
glo:FontStyle        LONG
glo:lLineNum         LONG
glo:szCategory       CSTRING(64)
glo:szCategoryChoice CSTRING(64)
glo:CategoryDropCount BYTE(10)
glo:bDetailLevel     BYTE
glo:szParentClassName CSTRING(64)
glo:bAutoExpand      BYTE
glo:sCurrentCursor   STRING(4)
glo:bUseHTMLHelp     BYTE
glo:szXmlStyleSheet  CSTRING(256)
glo:ViewerStyles     LIKE(COLORGROUPTYPE)
glo:bEnumSort        BYTE
glo:bShowSparseTrees BYTE
glo:bMaxMRU          BYTE
glo:Layout           BYTE
ExtraModuleQ         QUEUE,PRE(ExtraQ)
szModuleName           CSTRING(64)
szModulePath           CSTRING(256)
bClarionVersion        BYTE
                     END
ModuleQ              QUEUE,PRE(ModuleQ)
szModulePath           CSTRING(256)
szModuleName           CSTRING(64)
lModuleId              LONG
lDate                  LONG
lTime                  LONG
                     END
ClassQ               QUEUE,PRE(ClassQ)
szClassName            CSTRING(64)
szParentClassName      CSTRING(64)
lIncludeId             LONG
lModuleId              LONG
bIsABC                 BYTE
lLineNum               LONG
lClassID               LONG
szParentClassSort      CSTRING(64)
szClassSort            CSTRING(64)
bPrivate               BYTE
bInterface             BYTE
bModified              BYTE
                     END
ClassNameQ           QUEUE,PRE(ClassNameQ)
szClassName            CSTRING(64)
lStyle                 LONG
szSortName             CSTRING(64)
                     END
PropertyQ            QUEUE,PRE(PropertyQ)
szPropertyName         CSTRING(64)
szDataType             CSTRING(64)
bPrivate               BYTE
bProtected             BYTE
lLineNum               LONG
lClassID               LONG
szPropertySort         CSTRING(64)
bModule                BYTE
                     END
MethodQ              QUEUE,PRE(MethodQ)
szMethodName           CSTRING(64)
szPrototype            CSTRING(256)
bPrivate               BYTE
bProtected             BYTE
bVirtual               BYTE
lLineNum               LONG
lSourceLine            LONG
lClassID               LONG
szMethodSort           CSTRING(64)
bModule                BYTE
bExtends               BYTE
bFinal                 BYTE
bProc                  BYTE
szDLL                  CSTRING(32)
szExtName              CSTRING(64)
szCallConv             CSTRING(7)
szReturnType           CSTRING(64)
                     END
StructNameQ          QUEUE,PRE()
szStructureName        CSTRING(64)
szStructureSort        CSTRING(64)
                     END
StructureQ           QUEUE,PRE(StructureQ)
szStructureName        CSTRING(64)
szDataLabel            CSTRING(64)
szDataType             CSTRING(64)
lModuleId              LONG
lLineNum               LONG
szStructureSort        CSTRING(64)
bPrivate               BYTE
                     END
EnumNameQ            QUEUE,PRE()
szEnumName             CSTRING(64)
szEnumSort             CSTRING(64)
                     END
EnumQ                QUEUE,PRE(EnumQ)
szEnumName             CSTRING(64)
szEnumPrefix           CSTRING(64)
szEnumLabel            CSTRING(64)
szEnumValue            CSTRING(256)
lModuleId              LONG
lLineNum               LONG
szEnumSort             CSTRING(64)
bIsHexValue            BYTE
bPrivate               BYTE
bIsEquate              BYTE
                     END
TreeQ                QUEUE,PRE(TreeQ)
sNote                  STRING(1)
wNoteIcon              SHORT
szNoteTip              CSTRING(256)
szText                 CSTRING(384)
wIcon                  SHORT
lLevel                 LONG
lStyle                 LONG
szTipText              CSTRING(256)
szSearch               CSTRING(64)
szClassName            CSTRING(64)
szContextString        CSTRING(256)
szHelpFile             CSTRING(256)
lLineNum               LONG
lSourceLine            LONG
lIncludeId             LONG
lModuleId              LONG
lOccurranceLine        LONG
szPrototype            CSTRING(256)
                     END
CallQ                QUEUE,PRE(CallQ)
szCallingMethod        CSTRING(64)
szCalledMethod         CSTRING(64)
lLineNum               LONG
                     END
CallNameQ            QUEUE,PRE(CallNameQ)
szCallName             CSTRING(64)
lLevel                 LONG
lStyle                 LONG
szSortName             CSTRING(64)
bExpandedAbove         BYTE
                     END
szClassSort          CSTRING(128)
EquateQ              QUEUE,PRE(EquateQ)
szLabel                CSTRING(64)
szValue                CSTRING(256)
lModuleId              LONG
lLineNum               ULONG
bIsHexValue            BYTE
                     END
NoteQ                QUEUE,PRE(NoteQ)
bClarionVersion        BYTE
szLookup               CSTRING(384)
szNote                 CSTRING(2048)
                     END
CategoryQ            QUEUE,PRE(CategoryQ)
szClassName            CSTRING(64)
szCategory             CSTRING(64)
bDetailLevel           BYTE
                     END
OldClassQ            QUEUE,PRE(OldClassQ)
szClassName            CSTRING(64)
                     END
OldMethodQ           QUEUE,PRE(OldMethodQ)
szClassName            CSTRING(64)
szMethodName           CSTRING(64)
szPrototype            CSTRING(256)
                     END
OldPropertyQ         QUEUE,PRE(OldPropertyQ)
szClassName            CSTRING(64)
szPropertyName         CSTRING(64)
szPrototype            CSTRING(256)
                     END
incTemplateQ         QUEUE(TEMPLATEQTYPE),PRE(incTemplateQ)
                     END
clwTemplateQ         QUEUE(TEMPLATEQTYPE),PRE(clwTemplateQ)
                     END
tplTemplateQ         QUEUE(TEMPLATEQTYPE),PRE(tplTemplateQ)
                     END
FavoritesQ           QUEUE(FAVORITESQTYPE),PRE(FavoritesQ)
                     END
RedirectionQueue     QUEUE,PRE(RedirectionQueue)
Token                  CSTRING(33)
Path                   CSTRING(256)
                     END
Glo:iQErrorMessageText STRING(128)
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
!endregion

SourceFile          FILE,DRIVER('ASCII'),NAME(szAsciiFilename),PRE(ASC),CREATE,THREAD
Record                RECORD
sText                   STRING(1024)
                      END
                    END


FileNameQ            QUEUE,PRE(FNQ),THREAD  !queue of source files we have scanned
sFileName              STRING(FILE:MaxFilePath)
                     END

SourceLineQ          QUEUE,PRE(SLQ),THREAD  !queue of source files we have scanned
sFileName              STRING(FILE:MaxFilePath)
sMethodName            STRING(256)
sMethodPrototype       STRING(256)
lSourceLine            LONG
szLineText             CSTRING(1025)
                     END

LineCommentQ          QUEUE,PRE(LCQ),THREAD  !queue of source files we have scanned
sFileName              STRING(FILE:MaxFilePath)
lSourceLine            LONG
szComment              CSTRING(1025)
                     END

DotEndQ              QUEUE,PRE(DEQ),THREAD  !queue of source files we have scanned
sFileName              STRING(FILE:MaxFilePath)
lSourceLine            LONG
                     END

ClassHierarchyQueueType QUEUE,TYPE
szClassName                 LIKE(ClassNameQ.szClassName)
                        END

ClassHierarchyQueue  QUEUE(ClassHierarchyQueueType),PRE(CHQ)
                     END

RedirectionQueueType    QUEUE,TYPE
Token                      CSTRING(33)
Path                       CSTRING(File:MaxFilePath+1)
                        END

ClarionVersionQueueType QUEUE,TYPE
VersionName                STRING(100)
Path                       CSTRING(File:MaxFilePath+1)
IsWindowsVersion           CSTRING(6)
IniFile                    CSTRING(81)
Libsrc                     CSTRING(1024)
RedFile                    CSTRING(81)
SupportsInclude            CSTRING(6)
RedirectionMacros          &RedirectionQueueType
Root                       CSTRING(File:MaxFilePath+1)
RedDir                     CSTRING(File:MaxFilePath+1)
                        END
glo:VersionQ            QUEUE(ClarionVersionQueueType),PRE(VQ)
                        END
glo:StructureQCopy      QUEUE(StructureQ),PRE(SQC)
                        END

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
svSpecialFolder        SpecialFolder
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  HELP('abcview.hlp')                                      ! Open the applications help file
  GlobalErrors.Init(GlobalErrorStatus)
  szIniFilename = PATH() & '\ABCVIEW.INI'
  IF _access(szIniFilename,0) = -1
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  svSpecialFolder.CreateDirIn(SV:CSIDL_PERSONAL, 'ClassViewer' & '\' & '' )
  INIMgr.Init(svSpecialFolder.GetDir(SV:CSIDL_PERSONAL, 'ClassViewer' & '\' & '') & '\' & 'abcview.INI', NVD_INI)
  DctInit()
  ELSE
     FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
     FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
     FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
     INIMgr.Init(szIniFilename, NVD_INI)
     DctInit
  END
  SYSTEM{PROP:Icon} = 'abcview.ico'
  _main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()

