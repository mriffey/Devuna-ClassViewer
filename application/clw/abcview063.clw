

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
!!! Class Wrapper Template Generator
!!! </summary>
winGenerateTemplate PROCEDURE (*CSTRING szClassName) !,LONG,PROC

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
tplQ        QUEUE
Text          CSTRING(SIZE(SourceFile.sText)+1)
            END
lReturnValue         LONG                                  ! 
TemplateFileName     CSTRING(256),STATIC                   ! 
WizardFileName       CSTRING(256),STATIC                   ! 
bInherited      BYTE
szDefined       LIKE(ClassQ.szClassName)
Window               WINDOW('Generate Wrapper'),AT(,,182,104),DOUBLE,CENTER,GRAY
                       PANEL,AT(4,4,174,78),USE(?Panel1)
                       STRING('Press OK to Generate a Wrapper Template for:'),AT(10,8),USE(?TitleString),TRN
                       STRING(@s63),AT(10,18,160,10),USE(szClassName),FONT(,,,FONT:bold),CENTER
                       PROMPT('Wrapper Generator Template:'),AT(10,28),USE(?tplTemplateName:Prompt),TRN
                       LIST,AT(10,38,148,10),USE(WizardFileName),VSCROLL,COLOR(COLOR:White),DROP(10),FORMAT('90L(2)@s60@'), |
  FROM(tplTemplateQ),TIP('Select the template to be used for<0DH,0AH>creating the wrapp' & |
  'er template.')
                       BUTTON('...'),AT(162,38,10,10),USE(?EditTplTemplate:Button),SKIP,TIP('Edit the selected' & |
  ' Wrapper Generator Template.')
                       PROMPT('Generated Template File:'),AT(10,52),USE(?TemplateFileName:Prompt),TRN
                       ENTRY(@s255),AT(10,62,148,10),USE(TemplateFileName),COLOR(COLOR:White),REQ,TIP('Select the' & |
  ' filename for the <0DH,0AH>generated template (tpl) file.')
                       BUTTON('...'),AT(162,62,10,10),USE(?LookupFile)
                       BUTTON('&OK'),AT(83,86,45,14),USE(?OkButton),DEFAULT,DISABLE
                       BUTTON('Cancel'),AT(133,86,45,14),USE(?CancelButton)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Reset                  PROCEDURE(BYTE Force=0),DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
TemplateFileLookup   SelectFileClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(lReturnValue)

LoadWizardTemplate ROUTINE
  szAsciiFileName = tplTemplateQ.szPath   !WizardFileName
  IF szAsciiFileName = ''
     szAsciiFileName = 'TplWizard.txt'
     INIMgr.Fetch('Options','TplWizardTemplate',szAsciiFileName)
  END
  INIMgr.Update('Options','TplWizardTemplate',szAsciiFileName)
  DO LoadTemplate
  EXIT
LoadTemplate ROUTINE

  DATA
I           LONG
J           LONG
K           LONG
upperText   CSTRING(SIZE(SourceFile.sText)+1)

  CODE
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
           !parse classname
           tplQ.Text = ''
           upperText = UPPER(CLIP(SourceFile.sText))
           I = 1
           K = LEN(upperText)
           J = INSTRING('{{CLASSNAME}',upperText,1,1)
           LOOP WHILE J <> 0
              tplQ.Text = tplQ.Text & SourceFile.sText[I : J-1] & szClassName
              I = J + 11
              J = INSTRING('{{CLASSNAME}',upperText,1,I)
           END
           IF I < K
              tplQ.Text = tplQ.Text & SourceFile.sText[I : K]
           END

           !parse class category
           SourceFile.sText = tplQ.Text
           upperText = UPPER(CLIP(SourceFile.sText))
           tplQ.Text = ''
           I = 1
           K = LEN(upperText)
           J = INSTRING('{{CATEGORY}',upperText,1,1)
           LOOP WHILE J <> 0
              tplQ.Text = tplQ.Text & SourceFile.sText[I : J-1] & CategoryQ.szCategory
              I = J + 10
              J = INSTRING('{{CATEGORY}',upperText,1,I)
           END
           IF I < K
              tplQ.Text = tplQ.Text & SourceFile.sText[I : K]
           END



           !parse Add Class Group
           upperText = UPPER(CLIP(tplQ.Text))
           IF upperText[1 : 15] = '{{ADDCLASSGROUP}'
              DO WriteAddClassGroup
           ELSE
              ADD(tplQ)
           END
        END
     END
     CLOSE(SourceFile)
  END
  EXIT
WriteTemplate   ROUTINE

  DATA
I           LONG
J           LONG

  CODE
  szAsciiFileName = TemplateFileName
  IF szAsciiFileName = ''
     szAsciiFileName = szClassName & '.tpl'
  END

  CREATE(SourceFile)
  IF ERRORCODE()
     MESSAGE('Template File (' & szAsciiFileName & ')',ERROR(),ICON:EXCLAMATION)
  ELSE
     OPEN(SourceFile)
     IF ERRORCODE()
        MESSAGE('Template File (' & szAsciiFileName & ')',ERROR(),ICON:EXCLAMATION)
     ELSE
        J = RECORDS(tplQ)
        LOOP I = 1 TO J
          GET(tplQ,I)
          SourceFile.sText = tplQ.Text
          ADD(SourceFile)
        END
        DO WriteAddClassGroup
        CLOSE(SourceFile)
        INIMgr.Update('Options','TplWizardOutput',szAsciiFileName)
     END
  END
  EXIT
WriteAddClassGroup  ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  SETCURSOR(CURSOR:WAIT)
  tplQ.Text = '#! ======================================================================================='
  ADD(tplQ)
  tplQ.Text = '#! %AddClass - Add the Class to the ABC variables'
  ADD(tplQ)
  tplQ.Text = '#! ======================================================================================='
  ADD(tplQ)
  tplQ.Text = '#GROUP(%AddClass)'
  ADD(tplQ)
  DO AddClass
  SETCURSOR()
  EXIT
AddClass    ROUTINE
  IF UPPER(ModuleQ.szModulePath) = UPPER(szRoot & '\Libsrc\') & CHOOSE(glo:bClarionVersion > CWVERSION_C60EE,'win\','')
     tplQ.Text = '  #RETURN          #! Not Required - Class defined in ' & ModuleQ.szModulePath & ModuleQ:szModuleName
     ADD(tplQ)
  ELSE
     tplQ.Text = '  #FIX(%pClassName,''' & szClassName & ''')'
     ADD(tplQ)
     tplQ.Text= '  #IF(%pClassName = ''' & szClassName & ''')'
     ADD(tplQ)
     tplQ.Text = '    #RETURN'
     ADD(tplQ)
     tplQ.Text = '  #ENDIF'
     ADD(tplQ)

     tplQ.Text = '  #ADD(%pClassName,''' & szClassName & ''')'
     ADD(tplQ)
     tplQ.Text = '  #SET(%pClassCategory,''' & CategoryQ.szCategory & ''')'
     ADD(tplQ)
     tplQ.Text = '  #SET(%pClassIncFile,''' & ModuleQ.szModulePath & ModuleQ.szModuleName & ''')'
     ADD(tplQ)
     tplQ.Text = '  #SET(%pClassParent,''' & ClassQ.szParentClassName & ''')'
     ADD(tplQ)

     bInherited = FALSE
     szDefined = szClassName
     DO AddClassInterfaces
     DO AddClassMethods
     DO AddClassProperties

     LOOP WHILE ClassQ.szParentClassName
        ClassQ.szClassSort = UPPER(ClassQ.szParentClassName)
        GET(ClassQ,+ClassQ.szClassSort)
        IF ERRORCODE()
           CLEAR(ClassQ)
        END

        ModuleQ.lModuleId = ClassQ.lIncludeId
        GET(ModuleQ,+ModuleQ.lModuleId)
        IF ERRORCODE()
           CLEAR(ModuleQ)
        END

        bInherited = TRUE
        szDefined = ClassQ.szClassName
        DO AddClassInterfaces
        DO AddClassMethods
        DO AddClassProperties
     END
  END

  EXIT
AddClassInterfaces  ROUTINE
  DATA
lSourceLine     LONG
szImplements    CSTRING(1025)
I               LONG
J               LONG
K               LONG

  CODE
  lSourceLine = srcGetImplements(ClassQ.lClassID,szImplements)
  IF szImplements
     I = 1
     J = LEN(szImplements)
     K = INSTRING(',',szImplements,1,I)
     LOOP WHILE K
        tplQ.Text = '  #ADD(%pClassImplements,''' & szImplements[I : K-1] & ''')'
        ADD(tplQ)
        I = K+1
        K = INSTRING(',',szImplements,1,I)
     END
     IF I < J
        tplQ.Text = '  #ADD(%pClassImplements,''' & szImplements[I : J] & ''')'
        ADD(tplQ)
     END
  END
  EXIT
AddClassMethods ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  MethodQ.lClassID = ClassQ.lClassID
  GET(MethodQ,+MethodQ.lClassID)
  IF ~ERRORCODE()
     J = RECORDS(MethodQ)
     I = POINTER(MethodQ)
     LOOP I = I TO J
        GET(MethodQ,I)
        IF MethodQ.lClassID = ClassQ.lClassID
           DO AddMethod
        ELSE
           BREAK
        END
     END
  END
  EXIT
AddMethod   ROUTINE
  DATA
szPrototype    CSTRING(1025)

  CODE
  IF ~(bInherited AND MethodQ.bPrivate)
     IF ~MethodQ.bModule
        tplQ.Text = '  #!'
        ADD(tplQ)
        tplQ.Text = '  #ADD(%pClassMethod,''' & MethodQ.szMethodName & ''')'
        ADD(tplQ)

        IF MethodQ.szReturnType
           szPrototype = MethodQ.szPrototype & ',' & MethodQ.szReturnType
        ELSE
           szPrototype = MethodQ.szPrototype
        END
        tplQ.Text = '  #FIX(%pClassMethodPrototype,''' & szPrototype & ''')'
        ADD(tplQ)
        tplQ.Text = '  #IF(%pClassMethodPrototype <> ''' & szPrototype & ''')'
        ADD(tplQ)
        tplQ.Text = '    #ADD(%pClassMethodPrototype,''' & szPrototype & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodFinal,' & MethodQ.bFinal & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodPrivate,' & MethodQ.bPrivate & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodVirtual,' & MethodQ.bVirtual & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodProtected,' & MethodQ.bProtected & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodProcAttribute,' & MethodQ.bProc & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodInherited,' & bInherited & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodDefined,''' & szDefined & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodReturnType,''' & MethodQ.szReturnType & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodParentCall,''PARENT.' & MethodQ.szMethodName & srcGetParameters(MethodQ.szPrototype) & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodDll,''' & MethodQ.szDll & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodExtName,''' & MethodQ.szExtName & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodCallConv,''' & MethodQ.szCallConv & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassMethodExtends,' & MethodQ.bExtends & ')'
        ADD(tplQ)
        tplQ.Text = '  #ENDIF'
        ADD(tplQ)
     END
  END
  EXIT
AddClassProperties ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  PropertyQ.lClassID = ClassQ.lClassID
  GET(PropertyQ,+PropertyQ.lClassID)
  IF ~ERRORCODE()
     J = RECORDS(PropertyQ)
     I = POINTER(PropertyQ)
     LOOP I = I TO J
        GET(PropertyQ,I)
        IF PropertyQ.lClassID = ClassQ.lClassID
           DO AddProperty
        ELSE
           BREAK
        END
     END
  END
  EXIT
AddProperty ROUTINE
  IF ~(bInherited AND PropertyQ.bPrivate)
     IF ~PropertyQ.bModule
        tplQ.Text = '  #!'
        ADD(tplQ)
        tplQ.Text = '  #FIX(%pClassProperty,''' & PropertyQ.szPropertyName & ''')'
        ADD(tplQ)
        tplQ.Text = '  #IF(%pClassProperty = ''' & PropertyQ.szPropertyName & ''')'
        ADD(tplQ)
        tplQ.Text = '    #ADD(%pClassProperty,''' & PropertyQ.szPropertyName & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassPropertyPrototype,''' & PropertyQ:szDataType & ''')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassPropertyPrivate,' & PropertyQ.bPrivate & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassPropertyProtected,' & PropertyQ.bProtected & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassPropertyInherited,' & bInherited & ')'
        ADD(tplQ)
        tplQ.Text = '    #SET(%pClassPropertyDefined,''' & szDefined & ''')'
        ADD(tplQ)
        tplQ.Text = '  #ENDIF'
        ADD(tplQ)
     END
  END
  EXIT
EditSource  ROUTINE
  DATA
I               LONG,AUTO
J               LONG,AUTO
lSearchLine     LONG(1)
szCommandLine   CSTRING(256)

  CODE
  szCommandline = 'Notepad.exe ' & tplTemplateQ.szPath
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
                        tplTemplateQ.szPath & |
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
       RUN('Notepad.exe ' & tplTemplateQ.szPath)
    END
  END
  EXIT
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
  GlobalErrors.SetProcedureName('winGenerateTemplate')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.Open(Window)                                        ! Open window
  Do DefineListboxStyle
  TemplateFileLookup.Init
  TemplateFileLookup.ClearOnCancel = True
  TemplateFileLookup.Flags=BOR(TemplateFileLookup.Flags,FILE:LongName) ! Allow long filenames
  TemplateFileLookup.Flags=BOR(TemplateFileLookup.Flags,FILE:Save) ! Allow save Dialog
  TemplateFileLookup.SetMask('Template Files (*.tpl)','*.tpl') ! Set the file mask
  TemplateFileLookup.AddMask('All Files','*.*')            ! Add additional masks
  TemplateFileLookup.WindowTitle='Template Filename...'
  INIMgr.Fetch('Options','TplWizardOutput',TemplateFileName)
  IF TemplateFileName = ''
     TemplateFileName = szClassName & '.tpl'
  END
  TemplateFileLookup.DefaultFile = TemplateFileName
  TemplateFileName = ''                                 !Force user to select
  
  CategoryQ.szClassName = ClassNameQ.szClassName
  GET(CategoryQ,+CategoryQ.szClassName)
  IF ERRORCODE() OR CategoryQ.szCategory = ''
     CategoryQ.szCategory = 'ABC'
  END
  
  ClassQ.szClassSort = ClassNameQ.szSortName
  GET(ClassQ,+ClassQ.szClassSort)
  IF ERRORCODE()
     CLEAR(ClassQ)
  END
  
  ModuleQ.lModuleId = ClassQ.lIncludeId
  GET(ModuleQ,+ModuleQ.lModuleId)
  IF ERRORCODE()
     CLEAR(ModuleQ)
  END
  
  IF ~RECORDS(tplTemplateQ)
     tplTemplateQ.szPath = PATH() & '\' & 'TplWizard.txt'
     IF EXISTS(tplTemplateQ.szPath)
        tplTemplateQ.szName = 'Sample Wrapper Template'
        ADD(tplTemplateQ)
     END
  END
  
  GET(tplTemplateQ,1)
  ?WizardFileName{PROP:Selected} = 1
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINGENERATETEMPLATE'
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
  ?szClassName{PROP:FontStyle} = FONT:BOLD
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


ThisWindow.Reset PROCEDURE(BYTE Force=0)

  CODE
  SELF.ForcedReset += Force
  IF Window{Prop:AcceptAll} THEN RETURN.
  PARENT.Reset(Force)
  GET(tplTemplateQ,CHOICE(?WizardFileName))
  IF ERRORCODE()
     DISABLE(?OKButton)
  ELSE
     IF tplTemplateQ.szName <> '' AND TemplateFileName <> ''
        ENABLE(?OKButton)
     ELSE
        DISABLE(?OKButton)
     END
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
    OF ?WizardFileName
      ThisWindow.Reset()
    OF ?EditTplTemplate:Button
      ThisWindow.Update()
      DO EditSource
    OF ?TemplateFileName
      ThisWindow.Reset()
    OF ?LookupFile
      ThisWindow.Update()
      TemplateFileName = TemplateFileLookup.Ask(1)
      DISPLAY
      SELF.Reset()
    OF ?OkButton
      ThisWindow.Update()
      DO LoadWizardTemplate
      DO WriteTemplate
      POST(EVENT:CloseWindow)
    OF ?CancelButton
      ThisWindow.Update()
      POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

