

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
!!! </summary>
winExportDatabaseToXML PROCEDURE 

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
szIndent        CSTRING(256),AUTO
XMLFilename     CSTRING(256),STATIC,AUTO
XMLFile         FILE,DRIVER('DOS'),NAME(XMLFilename),PRE(XML),THREAD,CREATE
Record            RECORD
Buffer              STRING(4000)
                  END
                END
XMLFileQueue    QUEUE,PRE(afq)
Record            LIKE(XMLFile.Record)
Level             LONG
                END

xExch           XMLExchange     !object to provide export/import operations
pQueue          &QUEUE,AUTO
pFilename       &CSTRING,AUTO
bExtraModuleQ        BYTE(1)                               ! 
szExtraModuleXMLFile CSTRING(256)                          ! 
bModuleQ             BYTE(1)                               ! 
szModuleXMLFile      CSTRING(256)                          ! 
bClassQ              BYTE(1)                               ! 
szClassXMLFile       CSTRING(256)                          ! 
bPropertyQ           BYTE(1)                               ! 
szPropertyXMLFile    CSTRING(256)                          ! 
bMethodQ             BYTE(1)                               ! 
szMethodXMLFile      CSTRING(256)                          ! 
bStructureQ          BYTE(1)                               ! 
szStructureXMLFile   CSTRING(256)                          ! 
bEnumQ               BYTE(1)                               ! 
szEnumXMLFile        CSTRING(256)                          ! 
bCallQ               BYTE(1)                               ! 
szCallXMLFile        CSTRING(256)                          ! 
bNoteQ               BYTE(1)                               ! 
szNoteXMLFile        CSTRING(256)                          ! 
bCategoryQ           BYTE(1)                               ! 
szCategoryXMLFile    CSTRING(256)                          ! 
LOC:XML_ExportRes    BYTE                                  ! 
Window               WINDOW('Export Database To XML'),AT(,,260,176),FONT(,,COLOR:Black,,CHARSET:ANSI),DOUBLE,TILED, |
  CENTER,GRAY,PALETTE(256),WALLPAPER('WALLPAPER.GIF')
                       PANEL,AT(4,4,252,148),USE(?Panel1),FILL(COLOR:BTNFACE)
                       IMAGE('ok.ico'),AT(6,10,14,10),USE(?ExtraModule:Image),CENTERED
                       CHECK('Additional Modules'),AT(22,10),USE(bExtraModuleQ)
                       ENTRY(@s255),AT(98,10,140,10),USE(szExtraModuleXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,10,10,10),USE(?LookupExtraModuleXMLFile)
                       IMAGE('cancel.ico'),AT(6,24,14,10),USE(?Module:Image),CENTERED
                       CHECK('Modules'),AT(22,24),USE(bModuleQ)
                       ENTRY(@s255),AT(98,24,140,10),USE(szModuleXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,24,10,10),USE(?LookupModuleXMLFile)
                       IMAGE('blank.ico'),AT(6,38,14,10),USE(?Class:Image),CENTERED
                       CHECK('Classes'),AT(22,38),USE(bClassQ)
                       ENTRY(@s255),AT(98,38,140,10),USE(szClassXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,38,10,10),USE(?LookupClassXMLFile)
                       IMAGE('rtarrow.ico'),AT(6,52,14,10),USE(?Property:Image),CENTERED
                       CHECK('Properties'),AT(22,52),USE(bPropertyQ)
                       ENTRY(@s255),AT(98,52,140,10),USE(szPropertyXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,52,10,10),USE(?LookupPropertyXMLFile)
                       IMAGE('ok.ico'),AT(6,66,14,10),USE(?Method:Image),CENTERED
                       CHECK('Methods'),AT(22,66),USE(bMethodQ)
                       ENTRY(@s255),AT(98,66,140,10),USE(szMethodXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,66,10,10),USE(?LookupMethodXMLFile)
                       IMAGE('ok.ico'),AT(6,80,14,10),USE(?Structure:Image),CENTERED
                       CHECK('Structures'),AT(22,80),USE(bStructureQ)
                       ENTRY(@s255),AT(98,80,140,10),USE(szStructureXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,80,10,10),USE(?LookupStructureXMLFile)
                       IMAGE('ok.ico'),AT(6,94,14,10),USE(?Enum:Image),CENTERED
                       CHECK('Equates'),AT(22,94),USE(bEnumQ)
                       ENTRY(@s255),AT(98,94,140,10),USE(szEnumXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,94,10,10),USE(?LookupEnumXMLFile)
                       IMAGE('ok.ico'),AT(6,108,14,10),USE(?Call:Image),CENTERED
                       CHECK('Calls'),AT(22,108),USE(bCallQ)
                       ENTRY(@s255),AT(98,108,140,10),USE(szCallXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,108,10,10),USE(?LookupCallXMLFile)
                       IMAGE('ok.ico'),AT(6,122,14,10),USE(?Note:Image),CENTERED
                       CHECK('Notes'),AT(22,122),USE(bNoteQ)
                       ENTRY(@s255),AT(98,122,140,10),USE(szNoteXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,122,10,10),USE(?LookupNoteXMLFile)
                       IMAGE('ok.ico'),AT(6,136,14,10),USE(?Category:Image),CENTERED
                       CHECK('Categories'),AT(22,136),USE(bCategoryQ)
                       ENTRY(@s255),AT(98,136,140,10),USE(szCategoryXMLFile),COLOR(COLOR:White)
                       BUTTON('...'),AT(241,136,10,10),USE(?LookupCategoryXMLFile)
                       BUTTON('Exp&ort'),AT(161,157,45,14),USE(?OkButton),DEFAULT
                       BUTTON('&Cancel'),AT(211,157,45,14),USE(?CancelButton),STD(STD:Close)
                       BUTTON,AT(4,157,14,14),USE(?UnCheck:Button),ICON('checkno.ico'),TIP('Clear All')
                       BUTTON,AT(20,157,14,14),USE(?Check:Button),ICON('checkyes.ico'),TIP('Select All')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ExtraModuleXMLFileLookup SelectFileClass
ModuleXMLFileLookup  SelectFileClass
ClassXMLFileLookup   SelectFileClass
PropertyXMLFileLookup SelectFileClass
MethodXMLFileLookup  SelectFileClass
StructureXMLFileLookup SelectFileClass
EnumXMLFileLookup    SelectFileClass
CallXMLFileLookup    SelectFileClass
NoteXMLFileLookup    SelectFileClass
CategoryXMLFileLookup SelectFileClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
WriteXML    ROUTINE
  DATA
xmlNav      &XMLNavigator,AUTO
xmlDoc      &Document,AUTO
szTarget    CSTRING(65)
szData      CSTRING(256)
pi          &ProcessingInstruction,AUTO
cmnt        &Comment,AUTO
elem        &Element,AUTO
qWrp        QueueWrapper    !wrapper object
I           LONG,AUTO
J           LONG,AUTO
tmpBuffer   &STRING,AUTO
fileSize    LONG,AUTO
bufferSize  LONG,AUTO
filePointer LONG,AUTO
bytesRead   LONG,AUTO
bSpecialCase    BYTE(FALSE)

  CODE
  LOC:XML_ExportRes = xExch.CreateXML()                     ! Create a new XML Document
  IF LOC:XML_ExportRes = CPXMLErr:NoError
     IF glo:szXmlStyleSheet
        xmlNav &= xExch.GetNavigator()
        xmlDoc &= xExch.GetDocument()
        szTarget = 'xml-stylesheet'
        szData = 'type="text/xsl" href="' & glo:szXmlStyleSheet & '"'
        pi  &= xmlDoc.createProcessingInstruction(szTarget, szData)
        IF ~xmlNav.GoToRoot()
           xmlNav.SetXMLExchangeNode()
           elem &= xExch.GetNode()
           xmlDoc.insertBefore(pi, elem)
        END

     END

     IF FALSE
        szData = 'DOCTYPE abcview PUBLIC "-//devuna.com//abcview DTD//EN" "http://www.devuna.com/abcview.dtd"'
        cmnt &= xmlDoc.createComment(szData)
        IF ~xmlNav.GoToRoot()
           xmlNav.SetXMLExchangeNode()
           elem &= xExch.GetNode()
           xmlDoc.insertBefore(cmnt, elem)
        END
     END

     LOC:XML_ExportRes = qWrp.Init(pQueue)                  ! Initialize the wrapper object
     IF LOC:XML_ExportRes = CPXMLErr:NoError
        LOC:XML_ExportRes = xExch.toXML(qWrp)               ! put data from Queue to XML
        IF LOC:XML_ExportRes = CPXMLErr:NoError
           LOC:XML_ExportRes = xExch.saveAs(pFilename)      ! save XML doc to file
        END
     END
  END


  XMLFilename = pFilename
  OPEN(XMLFile)
  SET(XMLFile)

  !allocate buffer
  FileSize = BYTES(XMLFile) * 2
  BufferSize = FileSize * 2
  tmpBuffer &= NEW(STRING(BufferSize))         ! Create a buffer to hold the file

  filePointer = 1
  bytesRead = 0
  J = 0
  LOOP
    GET(XMLFile,filePointer)
    IF ~ERRORCODE()
       bytesRead = BYTES(XMLFile)
       filePointer += bytesRead
       LOOP I = 1 to bytesRead-1
          !<?xml version="1.0" encoding="UTF-8"?>
          IF J = 0  !first read
             tmpBuffer[1 : 43] = '<<?xml version="1.0" encoding="ISO-8859-1"?>'
             J = 43
             I = 39
          END
          IF I = 1 AND bSpecialCase = TRUE AND XMLFile.buffer[I] = '<<'
             J += 1
             tmpBuffer[J : J+1] = '<13><10>'
             J += 1
          END
          IF XMLFile.buffer[I : I+1] = '><<'
             J += 1
             tmpBuffer[J : J+2] = '><13><10>'
             J += 2
          ELSE
             J += 1
             tmpBuffer[J] = XMLFile.buffer[I]
          END
       END
       J += 1
       tmpBuffer[J] = XMLFile.buffer[I]
       IF tmpBuffer[J] = '>'
          bSpecialCase = TRUE
       END
    ELSE
       BREAK
    END
  END
  CLOSE(XMLFile)
  CREATE(XMLFile)
  OPEN(XMLFile)
  I = 1
  LOOP WHILE J > 0
     IF J <= SIZE(XMLFile.Buffer)
        XMLFile.Buffer = tmpBuffer[I : I+J]
        J = 0
     ELSE
        XMLFile.Buffer = tmpBuffer[I : I+SIZE(XMLFile.Buffer)]
        J -= SIZE(XMLFile.Buffer)
     END
     ADD(XMLFile)
     I += SIZE(XMLFile.Buffer)
  END
  CLOSE(XMLFile)
  DISPOSE(tmpBuffer)

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

I   LONG
J   LONG
  CODE
  GlobalErrors.SetProcedureName('winExportDatabaseToXML')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Panel1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  szExtraModuleXMLFile = 'extramodule.xml'
  szModuleXMLFile      = 'module.xml'
  szClassXMLFile       = 'class.xml'
  szPropertyXMLFile    = 'property.xml'
  szMethodXMLFile      = 'method.xml'
  szStructureXMLFile   = 'structure.xml'
  szEnumXMLFile        = 'equate.xml'
  szCallXMLFile        = 'call.xml'
  szNoteXMLFile        = 'note.xml'
  szCategoryXMLFile    = 'category.xml'
  SELF.Open(Window)                                        ! Open window
  !XPUnCheck:Button.Init(?UnCheck:Button, 0, 0)
  !XPUnCheck:Button.SetIconSize(32, 32)
  !XPCheck:Button.Init(?Check:Button, 0, 0)
  !XPCheck:Button.SetIconSize(32, 32)
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
  
  ?bExtraModuleQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bModuleQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bClassQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bPropertyQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bMethodQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bStructureQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bEnumQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bCallQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bNoteQ{PROP:Color} = ?Panel1{PROP:Fill}
  ?bCategoryQ{PROP:Color} = ?Panel1{PROP:Fill}
  
  ?ExtraModule:Image{PROP:Text} = '~BLANK.ICO'
  ?Module:Image{PROP:Text} = '~BLANK.ICO'
  ?Class:Image{PROP:Text} = '~BLANK.ICO'
  ?Property:Image{PROP:Text} = '~BLANK.ICO'
  ?Method:Image{PROP:Text} = '~BLANK.ICO'
  ?Structure:Image{PROP:Text} = '~BLANK.ICO'
  ?Enum:Image{PROP:Text} = '~BLANK.ICO'
  ?Call:Image{PROP:Text} = '~BLANK.ICO'
  ?Note:Image{PROP:Text} = '~BLANK.ICO'
  ?Category:Image{PROP:Text} = '~BLANK.ICO'
  Do DefineListboxStyle
  ExtraModuleXMLFileLookup.Init
  ExtraModuleXMLFileLookup.ClearOnCancel = True
  ExtraModuleXMLFileLookup.Flags=BOR(ExtraModuleXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  ExtraModuleXMLFileLookup.Flags=BOR(ExtraModuleXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  ExtraModuleXMLFileLookup.Flags=BOR(ExtraModuleXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  ExtraModuleXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  ExtraModuleXMLFileLookup.AddMask('All Files (*.*)','*.*') ! Add additional masks
  ExtraModuleXMLFileLookup.DefaultFile=szExtraModuleXMLFile
  ExtraModuleXMLFileLookup.WindowTitle='Select XML File'
  ModuleXMLFileLookup.Init
  ModuleXMLFileLookup.ClearOnCancel = True
  ModuleXMLFileLookup.Flags=BOR(ModuleXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  ModuleXMLFileLookup.Flags=BOR(ModuleXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  ModuleXMLFileLookup.Flags=BOR(ModuleXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  ModuleXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  ModuleXMLFileLookup.AddMask('All Files (*.*)','*.*')     ! Add additional masks
  ModuleXMLFileLookup.DefaultFile=szModuleXMLFile
  ModuleXMLFileLookup.WindowTitle='Select XML File'
  ClassXMLFileLookup.Init
  ClassXMLFileLookup.ClearOnCancel = True
  ClassXMLFileLookup.Flags=BOR(ClassXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  ClassXMLFileLookup.Flags=BOR(ClassXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  ClassXMLFileLookup.Flags=BOR(ClassXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  ClassXMLFileLookup.SetMask('XML Files (*.XML)','*.XML')  ! Set the file mask
  ClassXMLFileLookup.AddMask('All Files (*.*)','*.*')      ! Add additional masks
  ClassXMLFileLookup.DefaultFile=szClassXMLFile
  ClassXMLFileLookup.WindowTitle='Select XML File'
  PropertyXMLFileLookup.Init
  PropertyXMLFileLookup.ClearOnCancel = True
  PropertyXMLFileLookup.Flags=BOR(PropertyXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  PropertyXMLFileLookup.Flags=BOR(PropertyXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  PropertyXMLFileLookup.Flags=BOR(PropertyXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  PropertyXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  PropertyXMLFileLookup.AddMask('All Files (*.*)','*.*')   ! Add additional masks
  PropertyXMLFileLookup.DefaultFile=szPropertyXMLFile
  PropertyXMLFileLookup.WindowTitle='Select XML File'
  MethodXMLFileLookup.Init
  MethodXMLFileLookup.ClearOnCancel = True
  MethodXMLFileLookup.Flags=BOR(MethodXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  MethodXMLFileLookup.Flags=BOR(MethodXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  MethodXMLFileLookup.Flags=BOR(MethodXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  MethodXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  MethodXMLFileLookup.AddMask('All Files (*.*)','*.*')     ! Add additional masks
  MethodXMLFileLookup.DefaultFile=szMethodXMLFile
  MethodXMLFileLookup.WindowTitle='Select XML File'
  StructureXMLFileLookup.Init
  StructureXMLFileLookup.ClearOnCancel = True
  StructureXMLFileLookup.Flags=BOR(StructureXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  StructureXMLFileLookup.Flags=BOR(StructureXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  StructureXMLFileLookup.Flags=BOR(StructureXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  StructureXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  StructureXMLFileLookup.AddMask('All Files (*.*)','*.*')  ! Add additional masks
  StructureXMLFileLookup.DefaultFile=szStructureXMLFile
  StructureXMLFileLookup.WindowTitle='Select XML File'
  EnumXMLFileLookup.Init
  EnumXMLFileLookup.ClearOnCancel = True
  EnumXMLFileLookup.Flags=BOR(EnumXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  EnumXMLFileLookup.Flags=BOR(EnumXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  EnumXMLFileLookup.Flags=BOR(EnumXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  EnumXMLFileLookup.SetMask('XML Files (*.XML)','*.XML')   ! Set the file mask
  EnumXMLFileLookup.AddMask('All Files (*.*)','*.*')       ! Add additional masks
  EnumXMLFileLookup.DefaultFile=szEnumXMLFile
  EnumXMLFileLookup.WindowTitle='Select XML File'
  CallXMLFileLookup.Init
  CallXMLFileLookup.ClearOnCancel = True
  CallXMLFileLookup.Flags=BOR(CallXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  CallXMLFileLookup.Flags=BOR(CallXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  CallXMLFileLookup.Flags=BOR(CallXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  CallXMLFileLookup.SetMask('XML Files (*.XML)','*.XML')   ! Set the file mask
  CallXMLFileLookup.AddMask('All Files (*.)','*.*')        ! Add additional masks
  CallXMLFileLookup.DefaultFile=szCallXMLFile
  CallXMLFileLookup.WindowTitle='Select XML File'
  NoteXMLFileLookup.Init
  NoteXMLFileLookup.ClearOnCancel = True
  NoteXMLFileLookup.Flags=BOR(NoteXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  NoteXMLFileLookup.Flags=BOR(NoteXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  NoteXMLFileLookup.Flags=BOR(NoteXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  NoteXMLFileLookup.SetMask('XML Files (*.XML)','*.XML')   ! Set the file mask
  NoteXMLFileLookup.AddMask('All Files (*.*)','*.*')       ! Add additional masks
  NoteXMLFileLookup.DefaultFile=szNoteXMLFile
  NoteXMLFileLookup.WindowTitle='Select XML File'
  CategoryXMLFileLookup.Init
  CategoryXMLFileLookup.ClearOnCancel = True
  CategoryXMLFileLookup.Flags=BOR(CategoryXMLFileLookup.Flags,FILE:LongName) ! Allow long filenames
  CategoryXMLFileLookup.Flags=BOR(CategoryXMLFileLookup.Flags,FILE:Save) ! Allow save Dialog
  CategoryXMLFileLookup.Flags=BOR(CategoryXMLFileLookup.Flags,FILE:NoError) ! doesn't report errors if the file does exist on Save... or does not exist on Open
  CategoryXMLFileLookup.SetMask('XML Files (*.XML)','*.XML') ! Set the file mask
  CategoryXMLFileLookup.AddMask('All Files (*.*)','*.*')   ! Add additional masks
  CategoryXMLFileLookup.DefaultFile=szCategoryXMLFile
  CategoryXMLFileLookup.WindowTitle='Select XML File'
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINEXPORTDATABASETOXML'
  IF glo:bUseHTMLHelp
     IF oHH &= NULL
  oHH &= NEW tagHTMLHelp
  oHH.Init( 'ABCVIEW.CHM' )
  oHH.SetTopic('Export_Database_To_XML.htm')
     ELSE
        oHH.SetHelpFile( 'ABCVIEW.CHM' )
        oHH.SetTopic('Export_Database_To_XML.htm')
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
    OF ?bExtraModuleQ
      IF bExtraModuleQ
         ENABLE(?szExtraModuleXMLFile,?LookupExtraModuleXMLFile)
      ELSE
         DISABLE(?szExtraModuleXMLFile,?LookupExtraModuleXMLFile)
      END
    OF ?LookupExtraModuleXMLFile
      ThisWindow.Update()
      szExtraModuleXMLFile = ExtraModuleXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bModuleQ
      IF bModuleQ
         ENABLE(?szModuleXMLFile,?LookupModuleXMLFile)
      ELSE
         DISABLE(?szModuleXMLFile,?LookupModuleXMLFile)
      END
    OF ?LookupModuleXMLFile
      ThisWindow.Update()
      szModuleXMLFile = ModuleXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bClassQ
      IF bClassQ
         ENABLE(?szClassXMLFile,?LookupClassXMLFile)
      ELSE
         DISABLE(?szClassXMLFile,?LookupClassXMLFile)
      END
    OF ?LookupClassXMLFile
      ThisWindow.Update()
      szClassXMLFile = ClassXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bPropertyQ
      IF bPropertyQ
         ENABLE(?szPropertyXMLFile,?LookupPropertyXMLFile)
      ELSE
         DISABLE(?szPropertyXMLFile,?LookupPropertyXMLFile)
      END
    OF ?LookupPropertyXMLFile
      ThisWindow.Update()
      szPropertyXMLFile = PropertyXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bMethodQ
      IF bMethodQ
         ENABLE(?szMethodXMLFile,?LookupMethodXMLFile)
      ELSE
         DISABLE(?szMethodXMLFile,?LookupMethodXMLFile)
      END
    OF ?LookupMethodXMLFile
      ThisWindow.Update()
      szMethodXMLFile = MethodXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bStructureQ
      IF bStructureQ
         ENABLE(?szStructureXMLFile,?LookupStructureXMLFile)
      ELSE
         DISABLE(?szStructureXMLFile,?LookupStructureXMLFile)
      END
    OF ?LookupStructureXMLFile
      ThisWindow.Update()
      szStructureXMLFile = StructureXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bEnumQ
      IF bEnumQ
         ENABLE(?szEnumXMLFile,?LookupEnumXMLFile)
      ELSE
         DISABLE(?szEnumXMLFile,?LookupEnumXMLFile)
      END
    OF ?LookupEnumXMLFile
      ThisWindow.Update()
      szEnumXMLFile = EnumXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bCallQ
      IF bCallQ
         ENABLE(?szCallXMLFile,?LookupCallXMLFile)
      ELSE
         DISABLE(?szCallXMLFile,?LookupCallXMLFile)
      END
    OF ?LookupCallXMLFile
      ThisWindow.Update()
      szCallXMLFile = CallXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bNoteQ
      IF bNoteQ
         ENABLE(?szNoteXMLFile,?LookupNoteXMLFile)
      ELSE
         DISABLE(?szNoteXMLFile,?LookupNoteXMLFile)
      END
    OF ?LookupNoteXMLFile
      ThisWindow.Update()
      szNoteXMLFile = NoteXMLFileLookup.Ask(1)
      DISPLAY
    OF ?bCategoryQ
      IF bCategoryQ
         ENABLE(?szCategoryXMLFile,?LookupCategoryXMLFile)
      ELSE
         DISABLE(?szCategoryXMLFile,?LookupCategoryXMLFile)
      END
    OF ?LookupCategoryXMLFile
      ThisWindow.Update()
      szCategoryXMLFile = CategoryXMLFileLookup.Ask(1)
      DISPLAY
    OF ?OkButton
      ThisWindow.Update()
      SETCURSOR(CURSOR:WAIT)
      IF bExtraModuleQ
         ?ExtraModule:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?ExtraModule:Image)
         pQueue    &= ExtraModuleQ
         pFilename &= szExtraModuleXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?ExtraModule:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?ExtraModule:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?ExtraModule:Image)
      END
      
      IF bModuleQ
         ?Module:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Module:Image)
         pQueue    &= ModuleQ
         pFilename &= szModuleXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Module:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Module:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Module:Image)
      END
      
      IF bClassQ
         ?Class:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Class:Image)
         pQueue    &= ClassQ
         pFilename &= szClassXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Class:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Class:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Class:Image)
      END
      
      IF bPropertyQ
         ?Property:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Property:Image)
         pQueue    &= PropertyQ
         pFilename &= szPropertyXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Property:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Property:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Property:Image)
      END
      
      IF bMethodQ
         ?Method:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Method:Image)
         pQueue    &= MethodQ
         pFilename &= szMethodXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Method:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Method:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Method:Image)
      END
      
      IF bStructureQ
         ?Structure:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Structure:Image)
         pQueue    &= StructureQ
         pFilename &= szStructureXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Structure:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Structure:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Structure:Image)
      END
      
      IF bEnumQ
         ?Enum:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Enum:Image)
         pQueue    &= EnumQ
         pFilename &= szEnumXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Enum:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Enum:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Enum:Image)
      END
      
      IF bCallQ
         ?Call:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Call:Image)
         pQueue    &= CallQ
         pFilename &= szCallXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Call:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Call:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Call:Image)
      END
      
      IF bNoteQ
         ?Note:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Note:Image)
         pQueue    &= NoteQ
         pFilename &= szNoteXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Note:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Note:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Note:Image)
      END
      
      IF bCategoryQ
         ?Category:Image{PROP:Text} = '~RTARROW.ICO'
         DISPLAY(?Category:Image)
         pQueue    &= CategoryQ
         pFilename &= szCategoryXMLFile
         DO WriteXML
         IF LOC:XML_ExportRes = CPXMLErr:NoError
            ?Category:Image{PROP:Text} = '~OK.ICO'
         ELSE
            MESSAGE('Can''t export to XML file', 'Error', ICON:Hand, BUTTON:OK)
            ?Category:Image{PROP:Text} = '~CANCEL.ICO'
         END
         DISPLAY(?Category:Image)
      END
      
      SETCURSOR()
       POST(EVENT:CloseWindow)
    OF ?UnCheck:Button
      ThisWindow.Update()
      bExtraModuleQ = 0
      bModuleQ = 0
      bClassQ = 0
      bPropertyQ = 0
      bMethodQ = 0
      bStructureQ = 0
      bEnumQ = 0
      bCallQ = 0
      bNoteQ = 0
      bCategoryQ = 0
      DISPLAY()
    OF ?Check:Button
      ThisWindow.Update()
      bExtraModuleQ = 1
      bModuleQ = 1
      bClassQ = 1
      bPropertyQ = 1
      bMethodQ = 1
      bStructureQ = 1
      bEnumQ = 1
      bCallQ = 1
      bNoteQ = 1
      bCategoryQ = 1
      DISPLAY()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

