

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

!!! <summary>
!!! Generated from procedure template - Window
!!! Add a New Class File
!!! </summary>
winAddClass PROCEDURE 

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
RetVal               LONG(Level:Cancel)                    ! 
szClassName          LIKE(classQ.szClassName)              ! 
szParentClassName    LIKE(classQ.szParentClassName)        ! 
szInterfaces         CSTRING(256)                          ! 
szCategory           LIKE(CategoryQ.szCategory)            ! 
IncFileName          CSTRING(256)                          ! 
ClwFileName          CSTRING(256)                          ! 
CategoryQueue        QUEUE(CATEGORYQUEUETYPE),PRE(CategoryQueue) ! 
                     END                                   ! 
ClassQueue           QUEUE,PRE(ClassQueue)                 ! 
szClassName          CSTRING(64)                           ! 
szSortName           CSTRING(64)                           ! 
                     END                                   ! 
InterfaceQueue       QUEUE,PRE(InterfaceQueue)             ! 
szClassName          CSTRING(64)                           ! 
wIcon                SHORT                                 ! 
lStyle               LONG                                  ! 
szSortName           CSTRING(64)                           ! 
                     END                                   ! 
incTemplateName      CSTRING(61)                           ! 
clwTemplateName      CSTRING(61)                           ! 
BaseMethodQ          QUEUE,PRE(BaseMethodQ)                ! 
szMethod             CSTRING(1025)                         ! 
wIcon                SHORT                                 ! 
lStyle               LONG                                  ! 
                     END                                   ! 
GenerationDate       CSTRING(31)                           ! 
GenerationTime       CSTRING(31)                           ! 
PopupMgr             PopupClass                            ! 
bGenerateInterfaceCallbacks BYTE                           ! 
bProcessingInc       BYTE                                  ! 
PropertyQueue        QUEUE,PRE(PropertyQueue)              ! 
szPropertyName       CSTRING(64)                           ! 
wIcon                SHORT                                 ! 
lStyle               LONG                                  ! 
szDataType           CSTRING(64)                           ! 
szSortName           CSTRING(64)                           ! 
                     END                                   ! 
Template    QUEUE,TYPE
szText        CSTRING(1024)
            END
PreTemplate QUEUE(Template),PRE(PreTemplate)
            END
IncTemplate QUEUE(Template),PRE(IncTemplate)
Mark          BYTE
            END
ClwTemplate QUEUE(Template),PRE(ClwTemplate)
            END
pTemplate   &Template
q           &TEMPLATEQTYPE

szMethodName  CSTRING(256)
szPrototype   CSTRING(256)
szReturnType  CSTRING(33)

Current     GROUP
Tab           LONG
XPos          LONG(8)
YPos          LONG(20)
Width         LONG(0)
Height        LONG(0)
Option        LONG(0)
            END

Indent      BYTE

TabQueue    QUEUE,PRE(TabQueue)
Feq           LONG
            END

Token       QUEUE(TOKENQUEUETYPE),PRE(Token)
            END
Window               WINDOW('Add Class Wizard'),AT(,,176,164),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,TILED,CENTER, |
  GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       SHEET,AT(4,4,169,139),USE(?Sheet1),JOIN,COLOR(COLOR:BTNFACE)
                         TAB('Templates'),USE(?Templates:Tab)
                           BUTTON('&Next'),AT(73,146,48,14),USE(?NextButton),TIP('Define the class generation parameters.')
                           PROMPT('.inc Template:'),AT(8,20),USE(?incTemplateName:Prompt),TRN
                           LIST,AT(8,30,148,10),USE(incTemplateName),VSCROLL,COLOR(COLOR:White),DROP(10),FORMAT('90L(2)@s60@'), |
  FROM(incTemplateQ),TIP('Select the template to be used for<0DH,0AH>creating the class' & |
  ' include (inc) file.')
                           BUTTON('...'),AT(158,30,10,10),USE(?EditIncTemplate:Button),SKIP,TIP('Edit the selected' & |
  ' inc Template.')
                           PROMPT('.clw Template:'),AT(8,44),USE(?clwTemplateName:Prompt),TRN
                           LIST,AT(8,54,148,10),USE(clwTemplateName),VSCROLL,COLOR(COLOR:White),DROP(10),FORMAT('90L(2)@s60@'), |
  FROM(clwTemplateQ),TIP('Select the template to be used for<0DH,0AH>creating the class' & |
  ' source (clw) file.')
                           BUTTON('...'),AT(158,54,10,10),USE(?EditClwTemplate:Button),SKIP,TIP('Edit the selected' & |
  ' clw Template.')
                           PROMPT('Select the template files to be used in creating the class include (inc) and so' & |
  'urce (clw) files.'),AT(8,68,160,20),USE(?Templates:Prompt),TRN
                         END
                         TAB('General'),USE(?General:Tab),HIDE
                           PROMPT('C&ategory:'),AT(8,20),USE(?szCategory:Prompt),TRN
                           COMBO(@s63),AT(8,30,160,10),USE(szCategory),VSCROLL,COLOR(COLOR:White),DROP(10,160),FORMAT('252L(2)@s63@?'), |
  FROM(CategoryQueue),TIP('Enter the Class Category/Template Family<0DH,0AH>or select a' & |
  'n existing category from the list.')
                           PROMPT('&Class Name:'),AT(8,44),USE(?szClassName:Prompt),TRN
                           ENTRY(@s63),AT(8,54,160,10),USE(szClassName),COLOR(COLOR:White),REQ,TIP('Enter the Name' & |
  ' of your class.')
                           PROMPT('&Base Class:'),AT(8,68),USE(?szParentClass:Prompt),TRN
                           LIST,AT(8,78,160,10),USE(szParentClassName),VSCROLL,COLOR(COLOR:White),DROP(10,160),FORMAT('252L(2)@s63@'), |
  FROM(ClassQueue),TIP('If your class is derived from another class,<0DH,0AH>select the' & |
  ' Base  Class from the drop list.')
                           PROMPT('.i&nc File:'),AT(8,92),USE(?IncFileName:Prompt),TRN
                           ENTRY(@s255),AT(8,102,146,10),USE(IncFileName),COLOR(COLOR:White),REQ,TIP('Select the f' & |
  'ilename for the <0DH,0AH>generated include (inc) file.')
                           BUTTON('...'),AT(158,102,10,10),USE(?LookupFile),SKIP
                           PROMPT('.cl&w File:'),AT(8,116),USE(?ClwFileName:Prompt),TRN
                           ENTRY(@s255),AT(8,126,146,10),USE(ClwFileName),COLOR(COLOR:White),REQ,TIP('Select the f' & |
  'ilename for the <0DH,0AH>generated source (clw) file.')
                           BUTTON('...'),AT(158,126,10,10),USE(?LookupClwFile),SKIP
                         END
                         TAB('Methods'),USE(?Methods:Tab),HIDE
                           PROMPT('Select the base class methods that will be implemented by the class.'),AT(8,20,160, |
  20),USE(?Methods:Prompt),TRN
                           LIST,AT(8,40,160,98),USE(?Methods),HVSCROLL,ALRT(MouseRight),ALRT(MouseLeft),COLOR(COLOR:White), |
  FORMAT('252L(2)IY@s63@'),FROM(BaseMethodQ),TIP('Select the Base Class methods that yo' & |
  'u<0DH,0AH>want to derive in your class.<0DH,0AH>Right Click for popup menu.')
                         END
                         TAB('Properties'),USE(?Properties:Tab),HIDE
                           PROMPT('Select the properties for which you want accessor methods created.'),AT(8,20,160,20), |
  USE(?Properties:Prompt),TRN
                           LIST,AT(8,40,160,98),USE(?Properties),HVSCROLL,ALRT(MouseLeft),COLOR(COLOR:White),FORMAT('252L(2)IY@s63@'), |
  FROM(PropertyQueue),TIP('Select the Properties for which you want<0DH,0AH>accessor me' & |
  'thods added to your class.')
                         END
                         TAB('Interfaces'),USE(?Interfaces:Tab),HIDE
                           PROMPT('Select the interfaces that will be implemented by the class.'),AT(8,20,160,20),USE(?Interfaces:Prompt), |
  TRN
                           LIST,AT(8,40,160,88),USE(?Interfaces),HVSCROLL,ALRT(MouseLeft),COLOR(COLOR:White),FORMAT('252L(2)IY@s63@'), |
  FROM(InterfaceQueue),TIP('Select the Interfaces that will be<0DH,0AH>implemented by y' & |
  'our class.')
                           CHECK(' &Generate Interface Callbacks'),AT(8,130),USE(bGenerateInterfaceCallbacks),TIP('Check this' & |
  ' option to have ClassViewer<0DH,0AH>generate Interface Callback methods.'),TRN
                         END
                       END
                       BUTTON('&Finish'),AT(73,146,48,14),USE(?OkButton),HIDE,TIP('Generate the class include ' & |
  '(inc) and source(clw) files.  <0DH,0AH>Note:  Existing files will be overwritten.')
                       BUTTON('Cancel'),AT(125,146,48,14),USE(?CancelButton),TIP('Close the Add Class Wiz ard ' & |
  '<0DH,0AH>and return to the main screen.')
                     END

tt          ToolTipClass
hwndTT      HWND
ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Open                   PROCEDURE(),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
IncFileLookup        SelectFileClass
ClwFileLookup        SelectFileClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(RetVal)

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
  !------------------------------------
  !Style for ?Methods
  !------------------------------------
  !------------------------------------
  !Style for ?Properties
  !------------------------------------
  !------------------------------------
  !Style for ?Interfaces
  !------------------------------------
!---------------------------------------------------------------------------
FillClassQueues   ROUTINE
  DATA
I       LONG,AUTO
J       LONG,AUTO

  CODE
  FREE(ClassQueue)
  FREE(InterfaceQueue)

  !add blank records
  !====================================================================
  ClassQueue.szClassName = ''
  ClassQueue.szSortName  = ''
  ADD(ClassQueue)

  J = RECORDS(ClassQ)
  LOOP I = 1 TO J
    GET(ClassQ,I)
    IF ClassQ.bInterface
       InterfaceQueue.szClassName = ClassQ.szClassName
       InterfaceQueue.szSortName  = ClassQ.szClassSort
       InterfaceQueue.wIcon = 2
       InterfaceQueue.lStyle = 0
       ADD(InterfaceQueue)
    ELSE
       ClassQueue.szClassName = ClassQ.szClassName
       ClassQueue.szSortName  = ClassQ.szClassSort
       ADD(ClassQueue)
    END
  END

  SORT(ClassQueue,+ClassQueue.szSortName)
  SORT(InterfaceQueue,+InterfaceQueue.szSortName)
  EXIT
FillCategoryQueue   ROUTINE
  DATA
I       LONG,AUTO
J       LONG,AUTO

  CODE
  FREE(CategoryQueue)
  J = RECORDS(CategoryQ)
  LOOP I = 1 TO J
    GET(CategoryQ,I)
    CategoryQueue.szCategory = UPPER(CategoryQ.szCategory)
    GET(CategoryQueue,+CategoryQueue.szCategory)
    IF ERRORCODE()
       ADD(CategoryQueue,+CategoryQueue.szCategory)
    END
  END

  !szCategory = 'ABC'
  !CategoryQueue.szCategory = szCategory
  !GET(CategoryQueue,+CategoryQueue.szCategory)
  !IF ERRORCODE()
     GET(CategoryQueue,1)
  !END
  IF ThisWindow.Opened
     ?szCategory{PROP:Selected} = POINTER(CategoryQueue)
  END
FillBaseMethodQ ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
lSourceLine LONG,AUTO

  CODE
  FREE(BaseMethodQ)
  SORT(ClassQ,+ClassQ.szClassSort)
  ClassQ.szClassSort = UPPER(szParentClassName)
  GET(ClassQ,+ClassQ.szClassSort)
  IF ~ERRORCODE()
     J = RECORDS(MethodQ)
     LOOP I = 1 TO J
        GET(MethodQ,I)
        IF MethodQ.lClassId = ClassQ.lClassId
           IF MethodQ.bPrivate = TRUE OR MethodQ.bModule = TRUE
              CYCLE
           ELSE
              lSourceLine = srcGetSourceLine(ClassQ.lIncludeId,MethodQ.szMethodName,MethodQ.szPrototype,BaseMethodQ.szMethod)
              BaseMethodQ.wIcon = 2
              BaseMethodQ.lStyle = 0
              ADD(BaseMethodQ)
           END
        END
     END
  END
  EXIT
FillPropertyQueue   ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO

  CODE
  FREE(PropertyQueue)
  ClassQ.szClassSort = UPPER(szParentClassName)
  GET(ClassQ,+ClassQ.szClassSort)
  IF ~ERRORCODE()
     J = RECORDS(PropertyQ)
     LOOP I = 1 TO J
        GET(PropertyQ,I)
        IF PropertyQ.lClassId = ClassQ.lClassId
           IF PropertyQ.bPrivate = TRUE OR PropertyQ.bModule = TRUE
              CYCLE
           ELSE
              PropertyQueue.szPropertyName = PropertyQ.szPropertyName
              PropertyQueue.wIcon = 2
              PropertyQueue.lStyle = 0
              PropertyQueue.szDataType = PropertyQ.szDataType
              PropertyQueue.szSortName = PropertyQ.szPropertySort
              ADD(PropertyQueue)
           END
        END
     END
  END
  SORT(PropertyQueue,+PropertyQueue.szSortName)
  EXIT
LoadDefaultTokens   ROUTINE
  Token.szName = '%CLASSNAME'
  Token.szValue &= szClassName
  Token.szPrompt = 'Class Name:'
  Token.szDefault = ''
  Token.PromptFeq = ?szClassName:Prompt
  Token.EntryFeq = ?szClassName
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%BASECLASS'
  Token.szValue &= szParentClassName
  Token.szPrompt = 'Base Class:'
  Token.szDefault = ''
  Token.PromptFeq = ?szParentClass:Prompt
  Token.EntryFeq = ?szParentClassName
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%CATEGORY'
  Token.szValue &= szCategory
  Token.szPrompt = 'Category:'
  Token.szDefault = ''
  Token.PromptFeq = ?szCategory:Prompt
  Token.EntryFeq = ?szCategory
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%INCFILENAME'
  Token.szValue &= IncFileName
  Token.szPrompt = 'inc Filename:'
  Token.szDefault = ''
  Token.PromptFeq = ?IncFileName:Prompt
  Token.EntryFeq = ?IncFileName
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%CLWFILENAME'
  Token.szValue &= ClwFileName
  Token.szPrompt = 'clw Filename:'
  Token.szDefault = ''
  Token.PromptFeq = ?ClwFileName:Prompt
  Token.EntryFeq = ?ClwFileName
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%DATE'
  Token.szValue &= GenerationDate
  Token.szPrompt = 'Generation Date:'
  Token.szDefault = ''
  Token.PromptFeq = 0
  Token.EntryFeq = 0
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%TIME'
  Token.szValue &= GenerationTime
  Token.szPrompt = 'Generation Time:'
  Token.szDefault = ''
  Token.PromptFeq = 0
  Token.EntryFeq = 0
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%METHODS'
  Token.szValue &= NULL
  Token.szPrompt = 'Base Class Methods:'
  Token.szDefault = ''
  Token.PromptFeq = ?Methods:Prompt
  Token.EntryFeq = ?Methods
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%INTERFACES'
  Token.szValue &= NULL
  Token.szPrompt = 'Implemented Interfaces:'
  Token.szDefault = ''
  Token.PromptFeq = ?Interfaces:Prompt
  Token.EntryFeq = ?Interfaces
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  !add tokens
  Token.szName = '%METHODNAME'
  Token.szValue &= szMethodName
  Token.szPrompt = 'Method Name:'
  Token.szDefault = ''
  Token.PromptFeq = 0
  Token.EntryFeq = 0
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%PROTOTYPE'
  Token.szValue &= szPrototype
  Token.szPrompt = 'Prototype:'
  Token.szDefault = ''
  Token.PromptFeq = 0
  Token.EntryFeq = 0
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  Token.szName = '%RETURNTYPE'
  Token.szValue &= szReturnType
  Token.szPrompt = 'Return Type:'
  Token.szDefault = ''
  Token.PromptFeq = 0
  Token.EntryFeq = 0
  Token.bFree = FALSE
  ADD(Token,+Token.szName)

  EXIT
InitializeTemplates ROUTINE
  !The IncTemplate queue should be filled from a user defined text file
  !============================================================================
  DO LoadIncTemplate

  !The ClwTemplate queue should be filled from a user defined text file
  !============================================================================
  DO LoadClwTemplate
  EXIT
LoadIncTemplate ROUTINE
  pTemplate &= incTemplate
  szAsciiFileName = incTemplateQ.szPath
  IF szAsciiFileName = ''
     szAsciiFileName = 'incTemplate.txt'
     INIMgr.Fetch('Options','incTemplate',szAsciiFileName)
  END
  INIMgr.Update('Options','incTemplate',szAsciiFileName)
  DO LoadTemplate
  EXIT
LoadClwTemplate ROUTINE
  pTemplate &= clwTemplate
  szAsciiFileName = clwTemplateQ.szPath
  IF szAsciiFileName = ''
     szAsciiFileName = 'clwTemplate.txt'
     INIMgr.Fetch('Options','clwTemplate',szAsciiFileName)
  END
  INIMgr.Update('Options','clwTemplate',szAsciiFileName)
  DO LoadTemplate
  EXIT
LoadTemplate ROUTINE
  OPEN(SourceFile)
  IF ERRORCODE()
     MESSAGE('Template File (' & szAsciiFileName & ')',ERROR(),ICON:EXCLAMATION)
  ELSE
     SET(SourceFile)
     LOOP
        NEXT(SourceFile)
        IF ERRORCODE()
           BREAK
        ELSE
           IF UPPER(SourceFile.sText[1 : 7]) = '#PROMPT'
              DO ParseToken
           ELSIF UPPER(SourceFile.sText[1 : 7]) = '#PREFIX'
              DO SetupPrefix
           ELSE
              pTemplate.szText = CLIP(SourceFile.sText)
              ADD(pTemplate)
           END
        END
     END
     CLOSE(SourceFile)
  END
  EXIT
SetupPrefix  ROUTINE
  LOOP
     NEXT(SourceFile)
     IF ERRORCODE()
        BREAK
     ELSE
        IF UPPER(SourceFile.sText[1 : 10]) = '#ENDPREFIX'
           BREAK
        ELSE
           PreTemplate.szText = CLIP(SourceFile.sText)
           ADD(PreTemplate)
        END
     END
  END
  EXIT
ParseToken ROUTINE
  DATA
pStart  LONG,AUTO
pEnd    LONG,AUTO
szText  CSTRING(1025)

  CODE
  !process prompt
  CLEAR(Token)
  szText = CLIP(SourceFile.sText)
  IF srcParsePrompt(szText,Token) = Level:Benign
     DO AddToken
  END
  EXIT
AddToken   ROUTINE
  DATA
sz  &CSTRING
lp  &REAL
I   LONG,AUTO
J   LONG,AUTO
szScope LIKE(Token.szScope)

  CODE
  GET(Token,+Token.szName)
  IF ERRORCODE()
     !Create tab if necessary
     !=================================================================
     IF Current.Tab = 0
        Current.Tab = CREATE(0,CREATE:TAB,?Sheet1)
        TabQueue.Feq = Current.Tab
        ADD(TabQueue)
        Current.Tab{PROP:Text} = 'User ' & RECORDS(TabQueue) & ' ...'
        SETFONT(Current.Tab,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        UNHIDE(Current.Tab)
     END

     IF Token.szType <> 'RADIO' AND Current.Option <> 0
        Current.xPos -= 4
        Current.Option = 0
     END

     CASE Token.szType
     OF 'ENTRY' OROF 'DROP' OROF 'SPIN' OROF 'TEXT'
        !Create the prompt
        !=================================================================
        Token.PromptFeq = CREATE(0,CREATE:PROMPT,Current.Tab)
        Token.PromptFeq{PROP:Text} = Token.szPrompt
        Token.PromptFeq{PROP:TRN} = TRUE
        SETFONT(Token.PromptFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetPromptPosition
        Current.yPos += Token.PromptFeq{PROP:Height}
     END

     !Create the entry field
     !=================================================================
     CASE Token.szType
     OF 'CHECK'
        Token.EntryFeq = CREATE(0,CREATE:CHECK,Current.Tab)
        Token.EntryFeq{PROP:Text} = Token.szPrompt
        Token.nValue &= NEW(REAL)
      ASSERT(~Token.nValue &= NULL)
        Token.nValue = Token.szDefault
        lp &= Token.nValue
        Token.EntryFeq{PROP:Use} = lp
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4

     OF 'DROP'
        Token.EntryFeq = CREATE(0,CREATE:DROPLIST,Current.Tab)
        Token.szValue &= NEW(CSTRING(256))
      ASSERT(~Token.szValue &= NULL)
        IF Token.szDefault = ''
           Token.szDefault = SUB(Token.szScope,1,INSTRING('|',Token.szScope)-1)
        END
        Token.szValue = Token.szDefault
        sz &= Token.szValue
        Token.EntryFeq{PROP:Use} = sz
        Token.EntryFeq{PROP:Drop} = 10
        Token.EntryFeq{PROP:Text} = '@S254'
        szScope = Token.szScope
        Token.EntryFeq{PROP:From} = szScope
        Token.EntryFeq{PROP:VScroll} = TRUE
        Token.EntryFeq{PROP:Background} = COLOR:WHITE
        Token.EntryFeq{PROP:Format} = '80L(2)@s254@'
        Token.EntryFeq{PROP:Selected} = 1
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4

     OF 'ENTRY'
        Token.EntryFeq = CREATE(0,CREATE:ENTRY,Current.Tab)
        Token.EntryFeq{PROP:Text} = Token.szPicture
        Token.EntryFeq{PROP:Background} = COLOR:WHITE
        Token.szValue &= NEW(CSTRING(256))
      ASSERT(~Token.szValue &= NULL)
        Token.szValue = Token.szDefault
        sz &= Token.szValue
        Token.EntryFeq{PROP:Use} = sz
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4

     OF 'OPTION'
        Token.EntryFeq = CREATE(0,CREATE:OPTION,Current.Tab)
        Current.Option = Token.EntryFeq
        Token.EntryFeq{PROP:Boxed} = TRUE
        Token.EntryFeq{PROP:Text} = Token.szPrompt
        IF Token.bChoice = TRUE
           Token.nValue &= NEW(REAL)
         ASSERT(~Token.nValue &= NULL)
           Token.nValue = Token.szDefault
           lp &= Token.nValue
           Token.EntryFeq{PROP:Use} = lp
        ELSE
           Token.szValue &= NEW(CSTRING(256))
         ASSERT(~Token.szValue &= NULL)
           Token.szValue = Token.szDefault
           sz &= Token.szValue
           Token.EntryFeq{PROP:Use} = sz
        END
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += 10
        Current.xPos += 4

     OF 'RADIO'
        Token.EntryFeq = CREATE(0,CREATE:RADIO,Current.Option)
        Token.EntryFeq{PROP:Text} = Token.szPrompt
        IF Token.szRadioValue
           Token.EntryFeq{PROP:Value} = Token.szRadioValue
        END
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4

     OF 'SPIN'
        Token.EntryFeq = CREATE(0,CREATE:SPIN,Current.Tab)
        Token.EntryFeq{PROP:Text} = Token.szPicture
        Token.EntryFeq{PROP:Background} = COLOR:WHITE
        IF Token.low
           Token.EntryFeq{PROP:Range,1} = Token.low
        ELSE
           Token.EntryFeq{PROP:Range,1} = -2147483648
        END
        IF Token.high
           Token.EntryFeq{PROP:Range,2} = Token.high
        ELSE
           Token.EntryFeq{PROP:Range,2} = 2147483647
        END
        Token.EntryFeq{PROP:Step} = 1
        IF Token.step
           Token.EntryFeq{PROP:Step} = Token.step
        END
        Token.EntryFeq{PROP:Right} = TRUE
        Token.nValue &= NEW(REAL)
      ASSERT(~Token.nValue &= NULL)
        Token.nValue = Token.szDefault
        lp &= Token.nValue
        Token.EntryFeq{PROP:Use} = lp
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4

     OF 'TEXT'
        Token.EntryFeq = CREATE(0,CREATE:TEXT,Current.Tab)
        Token.EntryFeq{PROP:Text} = Token.szPicture
        Token.EntryFeq{PROP:Background} = COLOR:WHITE
        Token.EntryFeq{PROP:HScroll} = TRUE
        Token.EntryFeq{PROP:VScroll} = TRUE
        Token.szValue &= NEW(CSTRING(256))
      ASSERT(~Token.szValue &= NULL)
        Token.szValue = Token.szDefault
        sz &= Token.szValue
        Token.EntryFeq{PROP:Use} = sz
        SETFONT(Token.EntryFeq,glo:Typeface,glo:FontSize,glo:FontColor,glo:FontStyle,0)
        DO SetControlPosition
        Current.yPos += Token.EntryFeq{PROP:Height} + 4
     END

     IF Current.yPos > 126 !150
        Current.xPos = 8
        Current.yPos = 20
        Current.Tab = 0
     END

     !add token to queue
     !=================================================================
     Token.bFree = TRUE
     ADD(Token,+Token.szName)

     !unhide the controls
     !=================================================================
     IF Token.PromptFeq
        UNHIDE(Token.PromptFeq)
     END
     IF Token.EntryFeq
        UNHIDE(Token.EntryFeq)
     END
  END
  EXIT
SetPromptPosition  ROUTINE
  SETPOSITION(Token.PromptFeq,Current.xPos,Current.yPos,,)
  IF Token.prompt_xPos
     Current.xPos = Token.prompt_xPos
     Token.PromptFeq{PROP:xPos} = Current.xPos
     !SETPOSITION(Token.PromptFeq,Current.xPos,,,)
  END
  IF Token.prompt_yPos
     Current.yPos = Token.prompt_yPos
     Token.PromptFeq{PROP:yPos} = Current.yPos
     !SETPOSITION(Token.PromptFeq,,Current.yPos,,)
  END
  IF Token.prompt_width
     Current.width = Token.prompt_width
     IF (Current.xPos + Current.width) > 168
        Current.width = (168 - Current.xPos)
     END
     Token.PromptFeq{PROP:width} = Current.width
     !SETPOSITION(Token.PromptFeq,,,Current.width,)
  END
  IF Token.prompt_height
     Current.height = Token.prompt_height
     IF (Current.yPos + Current.height) > 136
        Current.height = (136 - Current.yPos)
     END
     Token.PromptFeq{PROP:height} = Current.height
     !SETPOSITION(Token.PromptFeq,,,,Current.height)
  END
SetControlPosition  ROUTINE
  SETPOSITION(Token.EntryFeq,Current.xPos,Current.yPos,,)
  IF Token.xPos
     Current.xPos = Token.xPos
     Token.EntryFeq{PROP:xPos} = Current.xPos
     !SETPOSITION(Token.EntryFeq,Current.xPos,,,)
  END

  IF Token.yPos
     Current.yPos = Token.yPos
     Token.EntryFeq{PROP:yPos} = Current.yPos
     !SETPOSITION(Token.EntryFeq,,Current.yPos,,)
  END
  IF Token.width
     Current.width = Token.width
     IF (Current.xPos + Current.width) > 168
        Current.width = (168 - Current.xPos)
     END
     Token.EntryFeq{PROP:width} = Current.width
     !SETPOSITION(Token.EntryFeq,,,Current.width,)
  END
  IF Token.height
     Current.height = Token.height
     IF (Current.yPos + Current.height) > 136
        Current.height = (136 - Current.yPos)
     END
     Token.EntryFeq{PROP:height} = Current.height
     !SETPOSITION(Token.EntryFeq,,,,Current.height)
  END
Finish  ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
ModulePath  CSTRING(256)
ModuleName  CSTRING(256)


  CODE
  UPDATE()

  !write the inc file
  !====================================================================
  bProcessingInc = TRUE
  pTemplate &= IncTemplate
  IF INSTRING('\',IncFileName)
     szAsciiFileName = IncFileName
  ELSE
     szAsciiFileName = glo:szCurrentDir & '\' & IncFileName
  END
  DO WriteFile

  !write the clw file
  !====================================================================
  bProcessingInc = FALSE
  pTemplate &= ClwTemplate
  IF INSTRING('\',ClwFileName)
     szAsciiFileName = ClwFileName
  ELSE
     szAsciiFileName = glo:szCurrentDir & '\' & ClwFileName
  END
  DO WriteFile

  !add/update the module
  !====================================================================
  IF INSTRING('\',IncFileName)
     J = LEN(CLIP(IncFileName))
     LOOP I = J TO 1 BY -1
        IF IncFileName[I] = '\'
           BREAK
        END
     END
     ModulePath = UPPER(IncFileName[1 : I])
     ModuleName = UPPER(IncFileName[I+1 : J])
  ELSE
     ModulePath = UPPER(glo:szCurrentDir)
     ModuleName = UPPER(IncFileName)
  END
  IF ModulePath[LEN(ModulePath)] <> '\'
     ModulePath = ModulePath & '\'
  END

  SORT(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
  ModuleQ.szModulePath = ModulePath
  ModuleQ.szModuleName = ModuleName
  GET(ModuleQ,+ModuleQ.szModulePath,+ModuleQ.szModuleName)
  IF ERRORCODE()
     SORT(ModuleQ,+ModuleQ.lModuleId)
     GET(ModuleQ,RECORDS(ModuleQ))
     ModuleQ.szModulePath = ModulePath
     ModuleQ.szModuleName = ModuleName
     ModuleQ.lModuleId += 1
     ModuleQ.lDate = 0
     ModuleQ.lTime = 0
     ADD(ModuleQ,+ModuleQ.lModuleId)
  ELSE
     ModuleQ:lDate = 0
     ModuleQ:lTime = 0
     PUT(ModuleQ)
  END

  ClassNameQ.szClassName = szClassName
  RetVal = Level:Benign
  EXIT
WriteFile   ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
N           LONG,AUTO
P           LONG,AUTO
pToken      LONG,AUTO
pLastToken  LONG,AUTO
szNumber    CSTRING(33)
bResult     LONG,AUTO

  CODE
  IF EXISTS(szAsciiFilename)
     bResult = MESSAGE(szAsciiFilename & ' already exists.|Are you sure you want to overwrite this file?','Add Class Wizard',ICON:QUESTION,BUTTON:YES+BUTTON:NO,BUTTON:NO)
  ELSE
     bResult = BUTTON:YES
  END
  IF bResult = BUTTON:YES
     GenerationDate = FORMAT(TODAY(),@D17)
     GenerationTime = FORMAT(CLOCK(),@T3)
     pLastToken = RECORDS(Token)
     CREATE(SourceFile)
     IF ~ERRORCODE()
        OPEN(SourceFile)
        J = RECORDS(pTemplate)
        LOOP I = 1 TO J
          GET(pTemplate,I)
          SourceFile.sText = pTemplate.szText

          !Is this the CLASS string?
          !===============================================================
          K = INSTRING(' CLASS,',UPPER(SourceFile.sText),1)
          IF K
             K += 5
             !add parent class if selected
             !============================================================
             IF szParentClassName <> ''
                SourceFile.sText = SourceFile.sText[1 : K] & '(%BASECLASS)' & SourceFile.sText[K+1 : LEN(SourceFile.sText)]
                K += 12
             END
             !add interfaces selected
             !============================================================
             K += 1
             N = RECORDS(InterfaceQueue)
             LOOP P = N TO 1 BY -1
                GET(InterfaceQueue,P)
                IF InterfaceQueue.wIcon = 1
                   SourceFile.sText = SourceFile.sText[1 : K] & 'IMPLEMENTS(' & InterfaceQueue.szClassName & '),' & SourceFile.sText[K+1 : LEN(SourceFile.sText)]
                END
             END
          END

          IF SUB(UPPER(pTemplate.szText),1,11) = '%INTERFACES'
             DO AddInterfaces
          ELSIF SUB(UPPER(pTemplate.szText),1,8) = '%METHODS'
             Indent = SUB(pTemplate.szText,9,LEN(pTemplate.szText))
             DO AddMethods
          ELSIF SUB(UPPER(pTemplate.szText),1,11) = '%PROPERTIES'
             Indent = SUB(pTemplate.szText,12,LEN(pTemplate.szText))
             DO AddPropertyMethods
          ELSE
             K = INSTRING('%',pTemplate.szText)
             IF K
                LOOP pToken = 1 TO pLastToken
                   GET(Token,pToken)
                   IF ~Token.szValue &= NULL
                      SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,Token.szValue)
                   ELSE
                      IF Token.szPicture
                         szNumber = FORMAT(Token.nValue,Token.szPicture)
                         SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,szNumber)
                      ELSE
                         SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,Token.nValue)
                      END
                   END
                   IF ~INSTRING('%',SourceFile.sText)
                      BREAK
                   END
                END
             END
             ADD(SourceFile)
          END
        END
        CLOSE(SourceFile)
     ELSE
        MESSAGE('Error Creating ' & szAsciiFileName,ERROR(),ICON:HAND)
     END
  END
  EXIT
AddMethods  ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
M           LONG,AUTO
N           LONG,AUTO
Delimiter   STRING(1)
ReturnType  CSTRING(32)
szParam     CSTRING(1025)

  CODE

  !Generate Base Class derived methods
  !====================================================================
  J = RECORDS(BaseMethodQ)
  LOOP I = 1 TO J
     GET(BaseMethodQ,I)
     IF BaseMethodQ.wIcon = 1
        IF pTemplate &= ClwTemplate
           SourceFile.sText = ''
           ADD(SourceFile)

           DO InsertMethodPrefix

           ReturnType = srcGetReturnType(BaseMethodQ.szMethod)
           DO ChangeAttributesToComments
           SourceFile.sText = szClassName & '.' & BaseMethodQ.szMethod
           ADD(SourceFile)
           SourceFile.sText = ''
           ADD(SourceFile)

           IF ReturnType
              CASE ReturnType
              OF 'STRING'   |
              OROF 'CSTRING'
                 SourceFile.sText = 'ReturnValue ' & ReturnType & '(32)'
              ELSE
                 SourceFile.sText = 'ReturnValue ' & ReturnType
              END
              ADD(SourceFile)
           END

           SourceFile.sText = ''
           ADD(SourceFile)
           SourceFile.sText = '  CODE'
           ADD(SourceFile)
           SourceFile.sText = ''
           ADD(SourceFile)

           !get parameter block
           !===========================================================
           M = INSTRING('(',BaseMethodQ.szMethod)
           IF M
              N = INSTRING(')',BaseMethodQ.szMethod)
              IF N
                 szParam = BaseMethodQ.szMethod[M : N]
              ELSE
            ASSERT(N > 0)
              END
           ELSE
             szParam = '()'
           END

           !find label separator
           !===========================================================
           K = INSTRING(' ',BaseMethodQ.szMethod)
           IF K
              K -= 1
           END
           IF ~K
              K = LEN(BaseMethodQ.szMethod)
           END

           IF ReturnType
              SourceFile.sText = '  ReturnValue = PARENT.' & BaseMethodQ.szMethod[1 : K] & srcGetParameters(szParam)
              ADD(SourceFile)
              SourceFile.sText = ''
              ADD(SourceFile)
              SourceFile.sText = '  RETURN ReturnValue'
              ADD(SourceFile)
           ELSE
              SourceFile.sText = '  PARENT.' & BaseMethodQ.szMethod[1 : K] & srcGetParameters(szParam)
              ADD(SourceFile)
              SourceFile.sText = ''
              ADD(SourceFile)
              SourceFile.sText = '  RETURN'
              ADD(SourceFile)
           END
           SourceFile.sText = ''
           ADD(SourceFile)

        ELSE
           K = INSTRING(' ',BaseMethodQ.szMethod)
           IF K
              IF K < Indent+1
                 BaseMethodQ.szMethod = SUB(BaseMethodQ.szMethod[1 : K] & ALL(' ',Indent),1,Indent) & |
                                        BaseMethodQ.szMethod[K : LEN(BaseMethodQ.szMethod)]
              END
           END
           SourceFile.sText = BaseMethodQ.szMethod
           ADD(SourceFile)
        END
     END
  END

  !Generate Interface Callbacks
  !====================================================================
  IF bGenerateInterfaceCallbacks = TRUE
     DO AddInterfaceCallbacks
  END


  EXIT
AddPropertyMethods  ROUTINE
  DATA
I               LONG,AUTO
J               LONG,AUTO
K               LONG,AUTO
szDataType      CSTRING(64)
szGetMethodName CSTRING(64)
szSetMethodName CSTRING(64)

  CODE

  !Generate Property Accessor methods
  !====================================================================
  J = RECORDS(PropertyQueue)
  LOOP I = 1 TO J
     GET(PropertyQueue,I)
     IF PropertyQueue.wIcon = 1

        K = INSTRING('(',PropertyQueue.szDataType)
        IF K
           szDataType = PropertyQueue.szDataType[1 : K-1]
        ELSE
           szDataType = PropertyQueue.szDataType
        END
        szGetMethodName = 'get_' & PropertyQueue.szPropertyName
        szSetMethodName = 'set_' & PropertyQueue.szPropertyName
        K = LEN(szGetMethodName)
        IF K < Indent+1
           szGetMethodName = SUB(szGetMethodName[1 : K] & ALL(' ',Indent),1,Indent)
           szSetMethodName = SUB(szSetMethodName[1 : K] & ALL(' ',Indent),1,Indent)
        END


        IF pTemplate &= ClwTemplate
           SourceFile.sText = szClassName & '.' & CLIP(szGetMethodName) & ' PROCEDURE(),' & szDataType
           ADD(SourceFile)
           SourceFile.sText = '  CODE'
           ADD(SourceFile)
           SourceFile.sText = '  RETURN(SELF.' & PropertyQueue.szPropertyName & ')'
           ADD(SourceFile)
           SourceFile.sText = ''
           ADD(SourceFile)
           SourceFile.sText = szClassName & '.' & CLIP(szSetMethodName) & ' PROCEDURE(' & szDataType & ' newValue),' & szDataType
           ADD(SourceFile)
           SourceFile.sText = 'oldValue LIKE(' & PropertyQueue.szPropertyName & ')'
           ADD(SourceFile)
           SourceFile.sText = '  CODE'
           ADD(SourceFile)
           SourceFile.sText = '  oldValue = SELF.get_' & PropertyQueue.szPropertyName & '()'
           ADD(SourceFile)
           SourceFile.sText = '  SELF.' & PropertyQueue.szPropertyName & ' = newValue'
           ADD(SourceFile)
           SourceFile.sText = '  RETURN(oldValue)'
           ADD(SourceFile)
           SourceFile.sText = ''
           ADD(SourceFile)
        ELSE
           SourceFile.sText = szGetMethodName & ' PROCEDURE(),' & szDataType
           ADD(SourceFile)
           SourceFile.sText = szSetMethodName & ' PROCEDURE(' & szDataType & ' newValue),' & szDataType
           ADD(SourceFile)
        END

     END
  END
  EXIT
InsertMethodPrefix  ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
pToken      LONG,AUTO
pLastToken  LONG,AUTO
szNumber    CSTRING(33),AUTO

  CODE

  K = INSTRING(' ',BaseMethodQ.szMethod)
  IF K
     szMethodName = szClassName & '.' & BaseMethodQ.szMethod[1 : K]
  ELSE
     szMethodName = szClassName & '.' & BaseMethodQ.szMethod
  END
  szPrototype  = srcGetPrototype(BaseMethodQ.szMethod)
  szReturnType = srcGetReturnType(BaseMethodQ.szMethod)

  pLastToken = RECORDS(Token)
  J = RECORDS(PreTemplate)

  LOOP I = 1 TO J
    GET(PreTemplate,I)
    SourceFile.sText = PreTemplate.szText
    K = INSTRING('%',PreTemplate.szText)
    IF K
       LOOP pToken = 1 TO pLastToken
          GET(Token,pToken)
          IF ~Token.szValue &= NULL
             SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,Token.szValue)
          ELSE
             IF Token.szPicture
                szNumber = FORMAT(Token.nValue,Token.szPicture)
                SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,szNumber)
             ELSE
                SourceFile.sText = srcReplaceString(SourceFile.sText,Token.szName,Token.nValue)
             END
          END
          IF ~INSTRING('%',SourceFile.sText)
             BREAK
          END
       END
    END
    ADD(SourceFile)
  END

  EXIT
AddInterfaces   ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
lSourceLine LONG,AUTO
szLineText  CSTRING(1025)
szParamText CSTRING(1025)
ReturnType  CSTRING(32)

  CODE
  !Generate Interface Callbacks
  !====================================================================
  !IF bGenerateInterfaceCallbacks = TRUE
  !   DO AddInterfaceCallbacks
  !END

  !Generate Interface Methods
  !====================================================================
  J = RECORDS(InterfaceQueue)
  LOOP I = 1 TO J
     GET(InterfaceQueue,I)
     IF InterfaceQueue.wIcon = 1
        ClassQ.szClassSort = InterfaceQueue.szSortName
        GET(ClassQ,+ClassQ.szClassSort)
        IF ~ERRORCODE()
           J = RECORDS(MethodQ)
           LOOP I = 1 TO J
              GET(MethodQ,I)
              IF MethodQ.lClassId = ClassQ.lClassId
                 IF MethodQ.bPrivate = TRUE OR MethodQ.bModule = TRUE
                    CYCLE
                 ELSE
                    SourceFile.sText = ''
                    ADD(SourceFile)
                    lSourceLine = srcGetSourceLine(ClassQ.lIncludeId,MethodQ.szMethodName,MethodQ.szPrototype,szLineText)

                    BaseMethodQ.szMethod = ClassQ.szClassName & '.' & szLineText
                    DO InsertMethodPrefix

                    BaseMethodQ.szMethod = szLineText
                    ReturnType = srcGetReturnType(BaseMethodQ.szMethod)
                    DO ChangeAttributesToComments
                    szLineText = BaseMethodQ.szMethod
                    SourceFile.sText = szClassName & '.' & ClassQ.szClassName & '.' & szLineText
                    ADD(SourceFile)
                    SourceFile.sText = ''
                    ADD(SourceFile)

                    IF ReturnType
                       CASE ReturnType
                       OF 'STRING'   |
                       OROF 'CSTRING'
                          SourceFile.sText = 'ReturnValue ' & ReturnType & '(32)'
                       ELSE
                          SourceFile.sText = 'ReturnValue ' & ReturnType
                       END
                       ADD(SourceFile)
                       SourceFile.sText = ''
                       ADD(SourceFile)
                    END

                    SourceFile.sText = '  CODE'
                    ADD(SourceFile)
                    SourceFile.sText = ''
                    ADD(SourceFile)

                    IF ReturnType
                       IF bGenerateInterfaceCallbacks = TRUE
                          SourceFile.sText = '  ReturnValue = SELF.' & MethodQ.szMethodName & srcGetParameters(MethodQ.szPrototype)
                          ADD(SourceFile)
                          SourceFile.sText = ''
                          ADD(SourceFile)
                       END
                       SourceFile.sText = '  RETURN ReturnValue'
                       ADD(SourceFile)
                    ELSE
                       IF bGenerateInterfaceCallbacks = TRUE
                          lSourceLine = srcGetSourceLine(ClassQ.lModuleId,MethodQ.szMethodName,MethodQ.szPrototype,szParamText)
                          SourceFile.sText = '  SELF.' & MethodQ.szMethodName & srcGetParameters(MethodQ.szPrototype)
                          ADD(SourceFile)
                          SourceFile.sText = ''
                          ADD(SourceFile)
                       END
                       SourceFile.sText = '  RETURN'
                       ADD(SourceFile)
                    END

                    SourceFile.sText = ''
                    ADD(SourceFile)
                 END
              END
           END
        END
     END
  END
AddInterfaceCallbacks   ROUTINE
  DATA
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO
lSourceLine LONG,AUTO
szLineText  CSTRING(1025)
ReturnType  CSTRING(32)

  CODE
  J = RECORDS(InterfaceQueue)
  LOOP I = 1 TO J
     GET(InterfaceQueue,I)
     IF InterfaceQueue.wIcon = 1
        ClassQ.szClassSort = InterfaceQueue.szSortName
        GET(ClassQ,+ClassQ.szClassSort)
        IF ~ERRORCODE()
           J = RECORDS(MethodQ)
           LOOP I = 1 TO J
              GET(MethodQ,I)
              IF MethodQ.lClassId = ClassQ.lClassId
                 IF MethodQ.bPrivate = TRUE OR MethodQ.bModule = TRUE
                    CYCLE
                 ELSE
                    lSourceLine = srcGetSourceLine(ClassQ.lIncludeId,MethodQ.szMethodName,MethodQ.szPrototype,szLineText)

                    IF bProcessingInc = TRUE
                       K = INSTRING(' ',szLineText)
                       IF K
                          IF K < Indent+1
                             szLineText = SUB(szLineText[1 : K] & ALL(' ',Indent),1,Indent) & |
                                          szLineText[K : LEN(szLineText)]
                          END
                       END
                       SourceFile.sText = szLineText
                       ADD(SourceFile)
                    ELSE
                       SourceFile.sText = ''
                       ADD(SourceFile)
                       lSourceLine = srcGetSourceLine(ClassQ.lIncludeId,MethodQ.szMethodName,MethodQ.szPrototype,szLineText)
                       BaseMethodQ.szMethod = szLineText

                       DO InsertMethodPrefix

                       ReturnType = srcGetReturnType(BaseMethodQ.szMethod)
                       DO ChangeAttributesToComments
                       szLineText = BaseMethodQ.szMethod
                       SourceFile.sText = szClassName & '.' & szLineText
                       ADD(SourceFile)
                       SourceFile.sText = ''
                       ADD(SourceFile)

                       IF ReturnType
                          CASE ReturnType
                          OF 'STRING'   |
                          OROF 'CSTRING'
                             SourceFile.sText = 'ReturnValue ' & ReturnType & '(32)'
                          ELSE
                             SourceFile.sText = 'ReturnValue ' & ReturnType
                          END
                          ADD(SourceFile)
                          SourceFile.sText = ''
                          ADD(SourceFile)
                       END

                       SourceFile.sText = '  CODE'
                       ADD(SourceFile)
                       SourceFile.sText = ''
                       ADD(SourceFile)

                       IF ReturnType
                          SourceFile.sText = '  RETURN ReturnValue'
                       ELSE
                          SourceFile.sText = '  RETURN'
                       END

                       ADD(SourceFile)
                       SourceFile.sText = ''
                       ADD(SourceFile)
                    END
                 END
              END
           END
        END
     END
  END
ChangeAttributesToComments  ROUTINE
  DATA
K           LONG,AUTO
Delimiter   STRING(1)

  CODE
  K = INSTRING('PROCEDURE(',BaseMethodQ.szMethod,1)
  IF K
     Delimiter = ')'
  ELSE
     K = INSTRING('PROCEDURE,',BaseMethodQ.szMethod,1)
     IF K
        Delimiter = ','
     ELSE
        K = INSTRING('FUNCTION(',BaseMethodQ.szMethod,1)
        IF K
           Delimiter = ')'
        ELSE
           K = INSTRING('FUNCTION,',BaseMethodQ.szMethod,1)
           IF K
              Delimiter = ','
           END
        END
     END
  END

  IF K
     LOOP K = 1 TO LEN(BaseMethodQ.szMethod)
        IF BaseMethodQ.szMethod[K] = Delimiter
           CASE Delimiter
           OF ')'
              IF CLIP(BaseMethodQ.szMethod[K+1 : LEN(BaseMethodQ.szMethod)]) <> ''
                 BaseMethodQ.szMethod = BaseMethodQ.szMethod[1 : K] & '!' & BaseMethodQ.szMethod[K+1 : LEN(BaseMethodQ.szMethod)]
              END
           OF ','
              IF CLIP(BaseMethodQ.szMethod[K : LEN(BaseMethodQ.szMethod)]) <> ''
                 BaseMethodQ.szMethod = BaseMethodQ.szMethod[1 : K-1] & '!' & BaseMethodQ.szMethod[K : LEN(BaseMethodQ.szMethod)]
              END
           END
           BREAK
        END
     END
  END
PopupMenu   ROUTINE
 DATA
PopupString STRING(16),AUTO
I           LONG,AUTO
J           LONG,AUTO
K           LONG,AUTO

 CODE
 !Remove Popup Manager Menu Options
 PopupMgr.DeleteItem('CheckAll')
 PopupMgr.DeleteItem('UncheckAll')

 !Set Popup Manager Menu Options
 PopupMgr.AddItem('&Check All','CheckAll')
 PopupMgr.AddItem('&Uncheck All','UncheckAll')

 PopupString = PopupMgr.Ask()

 CASE PopupString
   OF 'CheckAll'
      J = RECORDS(BaseMethodQ)
      K = POINTER(BaseMethodQ)
      LOOP I = 1 TO J
         GET(BaseMethodQ,I)
         BaseMethodQ.wIcon = 1
         BaseMethodQ.lStyle = 1
         PUT(BaseMethodQ)
      END
      GET(BaseMethodQ,K)
      DISPLAY(?Methods)
   OF 'UncheckAll'
      J = RECORDS(BaseMethodQ)
      K = POINTER(BaseMethodQ)
      LOOP I = 1 TO J
         GET(BaseMethodQ,I)
         BaseMethodQ.wIcon = 2
         BaseMethodQ.lStyle = 0
         PUT(BaseMethodQ)
      END
      GET(BaseMethodQ,K)
      DISPLAY(?Methods)
 END
 EXIT
EditSource  ROUTINE
  DATA
I               LONG,AUTO
J               LONG,AUTO
lSearchLine     LONG(1)
szCommandLine   CSTRING(256)

  CODE
  szCommandline = 'Notepad.exe ' & q.szPath
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
                        q.szPath & |
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
       RUN('Notepad.exe ' & q.szPath)
    END
  END
  EXIT

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG,AUTO
J   LONG,AUTO
szName  LIKE(incTemplateQ.szName),AUTO
  CODE
  GlobalErrors.SetProcedureName('winAddClass')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?NextButton
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(Window)                                        ! Open window
  DO LoadDefaultTokens                                    !load the default tokens
  DO FillClassQueues                                      !fill the lookup queues
  Do DefineListboxStyle
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
  
  ?Interfaces{PROP:IconList,1} = '~checkyes.ico'
  ?Interfaces{PROP:IconList,2} = '~checkno.ico'
  ?Interfaces{PROPSTYLE:TextColor,1} = COLOR:BLUE
  ?Interfaces{PROPSTYLE:BackColor,1} = COLOR:BTNFACE
  ?Interfaces{PROPSTYLE:TextSelected,1} = glo:lSelectedFore !COLOR:BLUE
  ?Interfaces{PROPSTYLE:BackSelected,1} = glo:lSelectedBack
  ?Interfaces{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?Interfaces{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?Interfaces{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle
  
  ?Methods{PROP:IconList,1} = '~checkyes.ico'
  ?Methods{PROP:IconList,2} = '~checkno.ico'
  ?Methods{PROPSTYLE:TextColor,1} = COLOR:BLUE
  ?Methods{PROPSTYLE:BackColor,1} = COLOR:BTNFACE
  ?Methods{PROPSTYLE:TextSelected,1} = glo:lSelectedFore !COLOR:BLUE
  ?Methods{PROPSTYLE:BackSelected,1} = glo:lSelectedBack
  ?Methods{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?Methods{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?Methods{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle
  
  ?Properties{PROP:IconList,1} = '~checkyes.ico'
  ?Properties{PROP:IconList,2} = '~checkno.ico'
  ?Properties{PROPSTYLE:TextColor,1} = COLOR:BLUE
  ?Properties{PROPSTYLE:BackColor,1} = COLOR:BTNFACE
  ?Properties{PROPSTYLE:TextSelected,1} = glo:lSelectedFore !COLOR:BLUE
  ?Properties{PROPSTYLE:BackSelected,1} = glo:lSelectedBack
  ?Properties{PROPSTYLE:FontName,STYLE:NORMAL} = glo:Typeface
  ?Properties{PROPSTYLE:FontSize,STYLE:NORMAL} = glo:FontSize
  ?Properties{PROPSTYLE:FontStyle,STYLE:NORMAL} = glo:FontStyle
  
  DO FillCategoryQueue
  
  IF ~RECORDS(incTemplateQ)
     incTemplateQ.szPath = PATH() & '\' & 'IncTemplate.txt'
     IF EXISTS(incTemplateQ.szPath)
        incTemplateQ.szName = 'Sample INC Template'
        ADD(incTemplateQ)
     END
  END
  SORT(incTemplateQ,incTemplateQ.szPath)
  INIMgr.Fetch('Options','incTemplate',incTemplateQ.szPath)
  incTemplateQ.szPath = UPPER(incTemplateQ.szPath)
  GET(incTemplateQ,+incTemplateQ.szPath)
  IF ERRORCODE()
     SORT(incTemplateQ,incTemplateQ.szName)
     GET(incTemplateQ,1)
  ELSE
     szName = incTemplateQ.szName
     SORT(incTemplateQ,incTemplateQ.szName)
     GET(incTemplateQ,+incTemplateQ.szName)
     IF ERRORCODE()
        GET(incTemplateQ,1)
     END
  END
  incTemplateName = incTemplateQ.szName
  ?incTemplateName{PROP:Selected} = POINTER(incTemplateQ)
  
  IF ~RECORDS(clwTemplateQ)
     clwTemplateQ.szPath = PATH() & '\' & 'ClwTemplate.txt'
     IF EXISTS(clwTemplateQ.szPath)
        clwTemplateQ.szName = 'Sample CLW Template'
        ADD(clwTemplateQ)
     END
  END
  SORT(clwTemplateQ,clwTemplateQ.szName)
  SORT(clwTemplateQ,clwTemplateQ.szPath)
  INIMgr.Fetch('Options','clwTemplate',clwTemplateQ.szPath)
  clwTemplateQ.szPath = UPPER(clwTemplateQ.szPath)
  GET(clwTemplateQ,+clwTemplateQ.szPath)
  IF ERRORCODE()
     SORT(clwTemplateQ,clwTemplateQ.szName)
     GET(clwTemplateQ,1)
  ELSE
     szName = clwTemplateQ.szName
     SORT(clwTemplateQ,clwTemplateQ.szName)
     GET(clwTemplateQ,+clwTemplateQ.szName)
     IF ERRORCODE()
        GET(clwTemplateQ,1)
     END
  END
  clwTemplateName = clwTemplateQ.szName
  ?clwTemplateName{PROP:Selected} = POINTER(clwTemplateQ)
  popupmgr.init()
  IncFileLookup.Init
  IncFileLookup.ClearOnCancel = True
  IncFileLookup.Flags=BOR(IncFileLookup.Flags,FILE:LongName) ! Allow long filenames
  IncFileLookup.Flags=BOR(IncFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  IncFileLookup.SetMask('Include Files','*.inc')           ! Set the file mask
  IncFileLookup.WindowTitle='Include Filename'
  ClwFileLookup.Init
  ClwFileLookup.ClearOnCancel = True
  ClwFileLookup.Flags=BOR(ClwFileLookup.Flags,FILE:LongName) ! Allow long filenames
  ClwFileLookup.Flags=BOR(ClwFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  ClwFileLookup.SetMask('Clarion Source Files','*.clw')    ! Set the file mask
  ClwFileLookup.WindowTitle='Clarion Source Filename'
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINADDCLASS'
  IF glo:bUseHTMLHelp
     IF ohh &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
     END
  END
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG,AUTO
J   LONG,AUTO
  CODE
  tt.Kill()                                                !ToolTipClass Cleanup
  ReturnValue = PARENT.Kill()
  J = RECORDS(Token)
  LOOP I = 1 TO J
    GET(Token,I)
    IF Token.bFree
       IF ~Token.szValue &= NULL
          DISPOSE(Token.szValue)
          Token.szValue &= NULL
       END
       IF ~Token.nValue &= NULL
          DISPOSE(Token.nValue)
          Token.nValue &= NULL
       END
       IF Token.PromptFeq
          DESTROY(Token.PromptFeq)
          Token.PromptFeq = 0
       END
       IF Token.EntryFeq
          DESTROY(Token.EntryFeq)
          Token.EntryFeq = 0
       END
       PUT(Token)
    END
  END
  FREE(Token)
  
  J = RECORDS(TabQueue)
  LOOP I = 1 TO J
     GET(TabQueue,I)
     IF TabQueue.Feq
        DESTROY(TabQueue.Feq)
        TabQueue.Feq = 0
        PUT(TabQueue)
     END
  END
  FREE(TabQueue)
  
  FREE(ClassQueue)
  FREE(InterfaceQueue)
  FREE(CategoryQueue)
  popupmgr.kill()
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
    OF ?NextButton
      ThisWindow.Update()
      HIDE(?Templates:Tab)
      UNHIDE(?General:Tab)
      UNHIDE(?Interfaces:Tab)
      UNHIDE(?OKButton)
      DO InitializeTemplates                                  !Load Templates (adds user tokens)
      SELECT(?General:Tab)
    OF ?incTemplateName
      GET(incTemplateQ,CHOICE(?incTemplateName))
    OF ?EditIncTemplate:Button
      ThisWindow.Update()
      q &= incTemplateQ
      DO EditSource
    OF ?clwTemplateName
      GET(clwTemplateQ,CHOICE(?clwTemplateName))
    OF ?EditClwTemplate:Button
      ThisWindow.Update()
      q &= clwTemplateQ
      DO EditSource
    OF ?szClassName
      IF IncFileName = ''
         IncFileName = szClassName & '.inc'
         DISPLAY(?IncFileName)
      END
      IF ClwFileName = ''
         ClwFileName = szClassName & '.clw'
         DISPLAY(?ClwFileName)
      END
    OF ?szParentClassName
      IF szParentClassName <> ''
         DO FillBaseMethodQ
         UNHIDE(?Methods:Tab)
         DO FillPropertyQueue
         UNHIDE(?Properties:Tab)
      ELSE
         FREE(BaseMethodQ)
         HIDE(?Methods:Tab)
         FREE(PropertyQueue)
         HIDE(?Properties:Tab)
      END
    OF ?LookupFile
      ThisWindow.Update()
      IncFileName = IncFileLookup.Ask(1)
      DISPLAY
    OF ?LookupClwFile
      ThisWindow.Update()
      ClwFileName = ClwFileLookup.Ask(1)
      DISPLAY
    OF ?OkButton
      ThisWindow.Update()
      IF szClassName = ''
         SELECT(?szClassName)
      ELSIF incFileName = ''
         SELECT(?incFileName)
      ELSIF clwFileName = ''
         SELECT(?clwFileName)
      ELSE
         DO Finish     !Do the Finish Processing
         POST(Event:CloseWindow)
      END
    OF ?CancelButton
      ThisWindow.Update()
      RetVal = Level:Cancel
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
MouseDownRow    LONG
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?Methods
    CASE EVENT()
    OF EVENT:AlertKey
      CASE KEYCODE()
      OF MouseRight
         DO PopupMenu
      OF MouseLeft
         MouseDownRow = ?Methods{PROPLIST:MouseDownRow}
         GET(BaseMethodQ,MouseDownRow)
         BaseMethodQ.wIcon = CHOOSE(BaseMethodQ.wIcon=2,1,2)
         BaseMethodQ.lStyle = CHOOSE(BaseMethodQ.wIcon=2,0,1)
         PUT(BaseMethodQ)
         DISPLAY(?Methods)
      END
    END
  OF ?Properties
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = MouseLeft
         MouseDownRow = ?Properties{PROPLIST:MouseDownRow}
         GET(PropertyQueue,MouseDownRow)
         PropertyQueue.wIcon = CHOOSE(PropertyQueue.wIcon=2,1,2)
         PropertyQueue.lStyle = CHOOSE(PropertyQueue.wIcon=2,0,1)
         PUT(PropertyQueue)
         DISPLAY(?Properties)
      END
    END
  OF ?Interfaces
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = MouseLeft
         MouseDownRow = ?Interfaces{PROPLIST:MouseDownRow}
         GET(InterfaceQueue,MouseDownRow)
         InterfaceQueue.wIcon = CHOOSE(InterfaceQueue.wIcon=2,1,2)
         InterfaceQueue.lStyle = CHOOSE(InterfaceQueue.wIcon=2,0,1)
         PUT(InterfaceQueue)
         DISPLAY(?Interfaces)
      END
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

