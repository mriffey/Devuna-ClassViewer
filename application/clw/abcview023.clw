

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
!!! Browse the CallQ
!!! </summary>
winBrowseCallQ PROCEDURE 

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
UnderscoreKey     EQUATE(01BDh)
Shadow            CSTRING(256),STATIC
oHH           &tagHTMLHelp
FilesOpened          BYTE                                  ! 
SelectedClassName    CSTRING(64)                           ! 
ViewerThreadQ   QUEUE(THREADQTYPE),PRE()              !
                END

MyClassQOrder   BYTE
MyClassQ        QUEUE,PRE(MyClassQ)
ClassQGroup        LIKE(ClassQ)
szDeclaration      CSTRING(256)
szDefinition       CSTRING(256)
                END

MyMethodQOrder  BYTE
MyMethodQ       QUEUE,PRE(MyMethodQ)
szClassName         LIKE(ClassQ:szClassName)
MethodQGroup        LIKE(MethodQ)
                END

MyPropertyQOrder BYTE
MyPropertyQ     QUEUE,PRE(MyPropertyQ)
szClassName         LIKE(ClassQ:szClassName)
PropertyQGroup      LIKE(PropertyQ)
                END
Window               WINDOW('Browse Database'),AT(,,318,230),FONT('Tahoma',10,COLOR:Black,FONT:regular,CHARSET:ANSI), |
  RESIZE,TILED,GRAY,PALETTE(256),WALLPAPER('wallpaper.gif')
                       SHEET,AT(4,4,310,204),USE(?Sheet1),COLOR(COLOR:BTNFACE)
                         TAB('Calls'),USE(?TreeTab),HIDE
                           LIST,AT(8,20,302,134),USE(?List1),VSCROLL,FLAT,FORMAT('156L(1)|~Calling Method~C(0)@s63' & |
  '@156L(1)~Called Method~C(0)@s63@'),FROM(CallQ)
                           LIST,AT(8,157,302,46),USE(?List2),VSCROLL,FLAT,FORMAT('252L(2)~Call Name~@s63@'),FROM(CallNameQ)
                         END
                         TAB('Class'),USE(?ClassTab)
                           LIST,AT(8,20,302,184),USE(?ClassList),HVSCROLL,ALRT(MouseLeft2),COLOR(COLOR:White),FLAT,FORMAT('80L(2)|M~N' & |
  'ame~@s63@#2#80L(2)|M~Parent~@s63@#3#80L(2)|M~Declaration~@s255@#14#56L(2)|M~Definiti' & |
  'on~@s255@#15#56R(2)~Line Number~L@n10@#7#'),FROM(MyClassQ)
                         END
                         TAB('Method'),USE(?MethodTab)
                           LIST,AT(8,20,302,184),USE(?MethodList),HVSCROLL,ALRT(MouseLeft2),COLOR(COLOR:White),FLAT,FORMAT('32L(2)|M~C' & |
  'lass~@s63@#1#80L(2)|M~Sort~@s63@#11#80L(2)|M~Name~@s63@#3#80L(2)|M~Prototype~@s127@#' & |
  '4#26C(2)|M~Private~L@n1@#5#34C(2)|M~Protected~L@n1@#6#22C(2)|M~Virtual~L@n1@#7#56R(2' & |
  ')|M~Line Num~L@n10@#8#56R(2)|M~Source Line~L@n10@#9#22C(2)|M~Module Flag~L@n1@#12#'),FROM(MyMethodQ)
                         END
                         TAB('Property'),USE(?PropertyTab)
                           LIST,AT(8,20,302,184),USE(?PropertyList),HVSCROLL,ALRT(MouseLeft2),COLOR(COLOR:White),FLAT, |
  FORMAT('56L(2)|M~Class~@s63@#1#80L(2)|M~Name~@s63@#3#80L(2)|M~DataType~@s63@#4#26C(2)' & |
  '|M~Private~L@n1@#5#34C(2)|M~Protected~@n1@#6#56R(2)|M~Line Number~C@n10@#7#34C(2)~Mo' & |
  'dule Flag~@n1@#10#'),FROM(MyPropertyQ)
                         END
                         TAB('Redirection'),USE(?Redirection:Tab)
                           LIST,AT(8,20,302,184),USE(?Redirection:List),VSCROLL,COLOR(COLOR:White),FORMAT('128L(2)|M~' & |
  'Token~@s32@1020L(2)|M~Path~@s255@'),FROM(RedirectionQueue)
                         END
                         TAB('Versions'),USE(?Versions:Tab)
                           LIST,AT(8,20,302,184),USE(?VersionList),HVSCROLL,COLOR(COLOR:White),FORMAT('50L(2)|M~Ve' & |
  'rsion~@s100@100L(2)|M~Path~@s255@20L(2)|M~Is Windows Version~@s5@100L(2)|M~Ini File~' & |
  '@s80@100L(2)|M~Libsrc~@s255@100L(2)|M~Red File~@s80@20L(2)|M~Supports Include~@s5@10' & |
  '0L(2)|M~Root~@s255@100L(2)|M~RedDir~@s255@'),FROM(glo:VersionQ)
                         END
                       END
                       IMAGE('pick.ico'),AT(4,211),USE(?LocatorImage),HIDE
                       STRING(@S255),AT(26,214,,10),USE(Shadow),TRN
                       BUTTON('Cl&ose'),AT(269,212,45,14),USE(?CloseButton)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop
  RETURN(SelectedClassName)

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
  GlobalErrors.SetProcedureName('winBrowseCallQ')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?List1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SelectedClassName = ''

  SORT(ClassQ,+ClassQ.lClassId)
  SORT(ModuleQ,+ModuleQ.lModuleId)

  J = RECORDS(ClassQ)
  LOOP I = 1 TO J
     GET(ClassQ,I)
     ModuleQ.lModuleId = ClassQ.lIncludeId
     GET(ModuleQ,+ModuleQ.lModuleId)
     MyClassQ.szDeclaration = ModuleQ.szModulePath & ModuleQ.szModuleName
     ModuleQ.lModuleId = ClassQ.lModuleId
     GET(ModuleQ,+ModuleQ.lModuleId)
     MyClassQ.szDefinition = ModuleQ.szModulePath & ModuleQ.szModuleName
     MyClassQ.ClassQGroup = ClassQ
     ADD(MyClassQ)
  END
  SORT(MyClassQ,+MyClassQ.ClassQGroup.szClassSort)
  MyClassQOrder = 1

  J = RECORDS(MethodQ)
  LOOP I = 1 TO J
     GET(MethodQ,I)
     ClassQ.lClassID = MethodQ.lClassID
     GET(ClassQ,+ClassQ.lClassId)
     MyMethodQ.szClassName = ClassQ.szClassName
     MyMethodQ.MethodQGroup = MethodQ
     ADD(MyMethodQ)
  END
  SORT(MyMethodQ,+MyMethodQ.szClassName,+MyMethodQ.MethodQGroup.szMethodSort)
  MyMethodQOrder = 1

  J = RECORDS(PropertyQ)
  LOOP I = 1 TO J
     GET(PropertyQ,I)
     ClassQ.lClassID = PropertyQ.lClassID
     GET(ClassQ,+ClassQ.lClassId)
     MyPropertyQ.szClassName = ClassQ.szClassName
     MyPropertyQ.PropertyQGroup = PropertyQ
     ADD(MyPropertyQ)
  END
  SORT(MyPropertyQ,+MyPropertyQ.szClassName,+MyPropertyQ.PropertyQGroup.szPropertySort)
  MyPropertyQOrder = 1
  SELF.Open(Window)                                        ! Open window
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
  
  ?ClassList{PROPLIST:Header,1} = ?ClassList{PROPLIST:Header,1} & ' +'
  ?ClassList{PROP:SelectedColor}        = glo:lSelectedFore
  ?ClassList{PROP:SelectedFillColor}    = glo:lSelectedBack
  LOOP I = AKey to ZKey
   ?ClassList{PROP:Alrt,255} = I
  END
  LOOP I = ShiftA to ShiftZ
   ?ClassList{PROP:Alrt,255} = I
  END
  ?ClassList{PROP:Alrt,255} = BSKey
  ?ClassList{PROP:Alrt,255} = UnderscoreKey
  
  ?MethodList{PROPLIST:Header,1} = ?MethodList{PROPLIST:Header,1} & ' +'
  ?MethodList{PROP:SelectedColor}       = glo:lSelectedFore
  ?MethodList{PROP:SelectedFillColor}   = glo:lSelectedBack
  LOOP I = AKey to ZKey
   ?MethodList{PROP:Alrt,255} = I
  END
  LOOP I = ShiftA to ShiftZ
   ?MethodList{PROP:Alrt,255} = I
  END
  ?MethodList{PROP:Alrt,255} = BSKey
  ?MethodList{PROP:Alrt,255} = UnderscoreKey
  
  ?PropertyList{PROPLIST:Header,1} = ?PropertyList{PROPLIST:Header,1} & ' +'
  ?PropertyList{PROP:SelectedColor}     = glo:lSelectedFore
  ?PropertyList{PROP:SelectedFillColor} = glo:lSelectedBack
  LOOP I = AKey to ZKey
   ?PropertyList{PROP:Alrt,255} = I
  END
  LOOP I = ShiftA to ShiftZ
   ?PropertyList{PROP:Alrt,255} = I
  END
  ?PropertyList{PROP:Alrt,255} = BSKey
  ?PropertyList{PROP:Alrt,255} = UnderscoreKey
  ?PropertyList{PROP:Alrt,255} = Shift7
  Resizer.Init(AppStrategy:Spread,Resize:SetMinSize)       ! Controls will spread out as the window gets bigger
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  Window{PROP:HLP} = '~WINBROWSECALLQ'
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
  FREE(MyClassQ)
  FREE(MyMethodQ)
  FREE(MyPropertyQ)
  GlobalErrors.SetProcedureName
  IF ~oHH &= NULL
    oHH.Kill()
    DISPOSE( oHH )
  END
  SORT(ClassQ,+ClassQ.szClassSort)
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
    OF ?CloseButton
      ThisWindow.Update()
       POST(EVENT:CloseWindow)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

I        LONG,AUTO
Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?Sheet1
    CASE EVENT()
    OF EVENT:TabChanging
      Shadow = ''
      DISPLAY(?Shadow)
      HIDE(?LocatorImage)
    END
  OF ?ClassList
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = BSKey
         IF LEN(Shadow) = 1
            Shadow = ''
         ELSIF LEN(Shadow) > 1
            Shadow = Shadow[1 : LEN(Shadow)-1]
         END
         EXECUTE MyClassQOrder
            BEGIN
               MyClassQ.ClassQGroup.szClassSort = UPPER(Shadow)
            END
            BEGIN
               MyClassQ.ClassQGroup.szParentClassSort = UPPER(Shadow)
               MyClassQ.ClassQGroup.szClassSort = ''
            END
         END
         GET(MyClassQ,POSITION(MyClassQ))
         ?ClassList{PROP:Selected} = POINTER(MyClassQ)
      ELSIF KEYCODE() = UnderscoreKey
         Shadow = Shadow & '_'
         EXECUTE MyClassQOrder
            BEGIN
               MyClassQ.ClassQGroup.szClassSort = UPPER(Shadow)
            END
            BEGIN
               MyClassQ.ClassQGroup.szParentClassSort = UPPER(Shadow)
               MyClassQ.ClassQGroup.szClassSort = ''
            END
         END
         GET(MyClassQ,POSITION(MyClassQ))
         ?ClassList{PROP:Selected} = POINTER(MyClassQ)
      ELSIF INRANGE(KEYCODE(),AKey,ZKey)
         Shadow = Shadow & LOWER(CHR(KEYCODE()))
         EXECUTE MyClassQOrder
            BEGIN
               MyClassQ.ClassQGroup.szClassSort = UPPER(Shadow)
            END
            BEGIN
               MyClassQ.ClassQGroup.szParentClassSort = UPPER(Shadow)
               MyClassQ.ClassQGroup.szClassSort = ''
            END
         END
         GET(MyClassQ,POSITION(MyClassQ))
         ?ClassList{PROP:Selected} = POINTER(MyClassQ)
      ELSIF INRANGE(KEYCODE(),ShiftA,ShiftZ)
         Shadow = Shadow & CHR(KEYCODE())
         EXECUTE MyClassQOrder
            BEGIN
               MyClassQ.ClassQGroup.szClassSort = UPPER(Shadow)
            END
            BEGIN
               MyClassQ.ClassQGroup.szParentClassSort = UPPER(Shadow)
               MyClassQ.ClassQGroup.szClassSort = ''
            END
         END
         GET(MyClassQ,POSITION(MyClassQ))
         ?ClassList{PROP:Selected} = POINTER(MyClassQ)
      ELSE
         CASE KEYCODE()
         OF MouseLeft2
            I = ?ClassList{PROPLIST:MouseDownRow}
            IF I = 0
               CASE ?ClassList{PROPLIST:MouseDownField}
               OF 1
                  IF MyClassQOrder <> 1
                     ?ClassList{PROPLIST:Header,MyClassQOrder} = SUB(?ClassList{PROPLIST:Header,MyClassQOrder},1,LEN(?ClassList{PROPLIST:Header,MyClassQOrder})-2)
                     SORT(MyClassQ,+MyClassQ.ClassQGroup.szClassSort)
                     MyClassQOrder = 1
                     ?ClassList{PROPLIST:Header,MyClassQOrder} = ?ClassList{PROPLIST:Header,MyClassQOrder} & ' +'
                     MyClassQ.ClassQGroup.szClassSort = UPPER(Shadow)
                     GET(MyClassQ,POSITION(MyClassQ))
                     ?ClassList{PROP:Selected} = POINTER(MyClassQ)
                  END
               OF 2
                  IF MyClassQOrder <> 2
                     ?ClassList{PROPLIST:Header,MyClassQOrder} = SUB(?ClassList{PROPLIST:Header,MyClassQOrder},1,LEN(?ClassList{PROPLIST:Header,MyClassQOrder})-2)
                     SORT(MyClassQ,+MyClassQ.ClassQGroup.szParentClassSort,+MyClassQ.ClassQGroup.szClassSort)
                     MyClassQOrder = 2
                     ?ClassList{PROPLIST:Header,MyClassQOrder} = ?ClassList{PROPLIST:Header,MyClassQOrder} & ' +'
                     MyClassQ.ClassQGroup.szParentClassSort = UPPER(Shadow)
                     GET(MyClassQ,POSITION(MyClassQ))
                     ?ClassList{PROP:Selected} = POINTER(MyClassQ)
                  END
               END
            ELSE
               GET(MyClassQ,I)
               !srcViewAsciiFile(MyClassQ.ClassQGroup.lIncludeId,MyClassQ.ClassQGroup.lLineNum,ViewerThreadQ)
               SelectedClassName = MyClassQ.ClassQGroup.szClassName
               POST(EVENT:CloseWindow)
            END
         END
      END
      IF Shadow = ''
         HIDE(?LocatorImage)
      ELSE
         UNHIDE(?LocatorImage)
      END
      DISPLAY(?Shadow)
    END
  OF ?MethodList
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = BSKey
         IF LEN(Shadow) = 1
            Shadow = ''
         ELSIF LEN(Shadow) > 1
            Shadow = Shadow[1 : LEN(Shadow)-1]
         END
         EXECUTE MyMethodQOrder
            BEGIN
               MyMethodQ.szClassName = Shadow
               MyMethodQ.MethodQGroup.szMethodName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodSort = UPPER(Shadow)
               MyMethodQ.szClassName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodName = Shadow
               MyMethodQ.szClassName = ''
            END
         END
         GET(MyMethodQ,POSITION(MyMethodQ))
         ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
      ELSIF KEYCODE() = UnderscoreKey
         Shadow = Shadow & '_'
         EXECUTE MyMethodQOrder
            BEGIN
               MyMethodQ.szClassName = Shadow
               MyMethodQ.MethodQGroup.szMethodName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodSort = UPPER(Shadow)
               MyMethodQ.szClassName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodName = Shadow
               MyMethodQ.szClassName = ''
            END
         END
         GET(MyMethodQ,POSITION(MyMethodQ))
         ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
      ELSIF INRANGE(KEYCODE(),AKey,ZKey)
         Shadow = Shadow & LOWER(CHR(KEYCODE()))
         EXECUTE MyMethodQOrder
            BEGIN
               MyMethodQ.szClassName = Shadow
               MyMethodQ.MethodQGroup.szMethodName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodSort = UPPER(Shadow)
               MyMethodQ.szClassName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodName = Shadow
               MyMethodQ.szClassName = ''
            END
         END
         GET(MyMethodQ,POSITION(MyMethodQ))
         ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
      ELSIF INRANGE(KEYCODE(),ShiftA,ShiftZ)
         Shadow = Shadow & CHR(KEYCODE())
         EXECUTE MyMethodQOrder
            BEGIN
               MyMethodQ.szClassName = Shadow
               MyMethodQ.MethodQGroup.szMethodName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodSort = UPPER(Shadow)
               MyMethodQ.szClassName = ''
            END
            BEGIN
               MyMethodQ.MethodQGroup.szMethodName = Shadow
               MyMethodQ.szClassName = ''
            END
         END
         GET(MyMethodQ,POSITION(MyMethodQ))
         ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
      ELSE
         CASE KEYCODE()
         OF MouseLeft2
            I = ?MethodList{PROPLIST:MouseDownRow}
            IF I = 0
               CASE ?MethodList{PROPLIST:MouseDownField}
               OF 1
                  IF MyMethodQOrder <> 1
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = SUB(?MethodList{PROPLIST:Header,MyMethodQOrder},1,LEN(?MethodList{PROPLIST:Header,MyMethodQOrder})-2)
                     SORT(MyMethodQ,+MyMethodQ.szClassName,+MyMethodQ.MethodQGroup.szMethodName)
                     MyMethodQOrder = 1
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = ?MethodList{PROPLIST:Header,MyMethodQOrder} & ' +'
                     MyMethodQ.szClassName = Shadow
                     GET(MyMethodQ,POSITION(MyMethodQ))
                     ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
                  END
               OF 2
                  IF MyMethodQOrder <> 2
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = SUB(?MethodList{PROPLIST:Header,MyMethodQOrder},1,LEN(?MethodList{PROPLIST:Header,MyMethodQOrder})-2)
                     SORT(MyMethodQ,+MyMethodQ.MethodQGroup.szMethodSort,+MyMethodQ.szClassName)
                     MyMethodQOrder = 2
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = ?MethodList{PROPLIST:Header,MyMethodQOrder} & ' +'
                     MyMethodQ.MethodQGroup.szMethodSort = UPPER(Shadow)
                     GET(MyMethodQ,POSITION(MyMethodQ))
                     ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
                  END
               OF 3
                  IF MyMethodQOrder <> 3
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = SUB(?MethodList{PROPLIST:Header,MyMethodQOrder},1,LEN(?MethodList{PROPLIST:Header,MyMethodQOrder})-2)
                     SORT(MyMethodQ,+MyMethodQ.MethodQGroup.szMethodName,+MyMethodQ.szClassName)
                     MyMethodQOrder = 3
                     ?MethodList{PROPLIST:Header,MyMethodQOrder} = ?MethodList{PROPLIST:Header,MyMethodQOrder} & ' +'
                     MyMethodQ.MethodQGroup.szMethodName = Shadow
                     GET(MyMethodQ,POSITION(MyMethodQ))
                     ?MethodList{PROP:Selected} = POINTER(MyMethodQ)
                  END
               END
            ELSE
               GET(MyMethodQ,I)
               ClassQ.lClassID = MyMethodQ.MethodQGroup.lClassID
               GET(ClassQ,+ClassQ.lClassID)
               !srcViewAsciiFile(ClassQ.lModuleId,MyMethodQ.MethodQGroup.lSourceLine,ViewerThreadQ)
               SelectedClassName = ClassQ.szClassName
               POST(EVENT:CloseWindow)
            END
         END
      END
      IF Shadow = ''
         HIDE(?LocatorImage)
      ELSE
         UNHIDE(?LocatorImage)
      END
      DISPLAY(?Shadow)
    END
  OF ?PropertyList
    CASE EVENT()
    OF EVENT:AlertKey
      IF KEYCODE() = BSKey
         IF LEN(Shadow) = 1
            Shadow = ''
         ELSIF LEN(Shadow) > 1
            Shadow = Shadow[1 : LEN(Shadow)-1]
         END
         EXECUTE MyPropertyQOrder
            BEGIN
               MyPropertyQ.szClassName = Shadow
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
               MyPropertyQ.szClassName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szDataType = Shadow
               MyPropertyQ.szClassName = ''
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
         END
         GET(MyPropertyQ,POSITION(MyPropertyQ))
         ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
      ELSIF KEYCODE() = UnderscoreKey
         Shadow = Shadow & '_'
         EXECUTE MyPropertyQOrder
            BEGIN
               MyPropertyQ.szClassName = Shadow
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
               MyPropertyQ.szClassName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szDataType = Shadow
               MyPropertyQ.szClassName = ''
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
         END
         GET(MyPropertyQ,POSITION(MyPropertyQ))
         ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
      ELSIF KEYCODE() = Shift7
         Shadow = Shadow & '&'
         EXECUTE MyPropertyQOrder
            BEGIN
               MyPropertyQ.szClassName = Shadow
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
               MyPropertyQ.szClassName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szDataType = Shadow
               MyPropertyQ.szClassName = ''
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
         END
         GET(MyPropertyQ,POSITION(MyPropertyQ))
         ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
      ELSIF INRANGE(KEYCODE(),AKey,ZKey)
         Shadow = Shadow & LOWER(CHR(KEYCODE()))
         EXECUTE MyPropertyQOrder
            BEGIN
               MyPropertyQ.szClassName = Shadow
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
               MyPropertyQ.szClassName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szDataType = Shadow
               MyPropertyQ.szClassName = ''
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
         END
         GET(MyPropertyQ,POSITION(MyPropertyQ))
         ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
      ELSIF INRANGE(KEYCODE(),ShiftA,ShiftZ)
         Shadow = Shadow & CHR(KEYCODE())
         EXECUTE MyPropertyQOrder
            BEGIN
               MyPropertyQ.szClassName = Shadow
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
               MyPropertyQ.szClassName = ''
            END
            BEGIN
               MyPropertyQ.PropertyQGroup.szDataType = Shadow
               MyPropertyQ.szClassName = ''
               MyPropertyQ.PropertyQGroup.szPropertyName = ''
            END
         END
         GET(MyPropertyQ,POSITION(MyPropertyQ))
         ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
      ELSE
         CASE KEYCODE()
         OF MouseLeft2
            I = ?PropertyList{PROPLIST:MouseDownRow}
            IF I = 0
               CASE ?PropertyList{PROPLIST:MouseDownField}
               OF 1
                  IF MyPropertyQOrder <> 1
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = SUB(?PropertyList{PROPLIST:Header,MyPropertyQOrder},1,LEN(?PropertyList{PROPLIST:Header,MyPropertyQOrder})-2)
                     SORT(MyPropertyQ,+MyPropertyQ.szClassName,+MyPropertyQ.PropertyQGroup.szPropertyName)
                     MyPropertyQOrder = 1
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = ?PropertyList{PROPLIST:Header,MyPropertyQOrder} & ' +'
                     MyPropertyQ.szClassName = Shadow
                     GET(MyPropertyQ,POSITION(MyPropertyQ))
                     ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
                  END
               OF 2
                  IF MyPropertyQOrder <> 2
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = SUB(?PropertyList{PROPLIST:Header,MyPropertyQOrder},1,LEN(?PropertyList{PROPLIST:Header,MyPropertyQOrder})-2)
                     SORT(MyPropertyQ,+MyPropertyQ.PropertyQGroup.szPropertyName,+MyPropertyQ.szClassName)
                     MyPropertyQOrder = 2
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = ?PropertyList{PROPLIST:Header,MyPropertyQOrder} & ' +'
                     MyPropertyQ.PropertyQGroup.szPropertyName = Shadow
                     GET(MyPropertyQ,POSITION(MyPropertyQ))
                     ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
                  END
               OF 3
                  IF MyPropertyQOrder <> 3
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = SUB(?PropertyList{PROPLIST:Header,MyPropertyQOrder},1,LEN(?PropertyList{PROPLIST:Header,MyPropertyQOrder})-2)
                     SORT(MyPropertyQ,+MyPropertyQ.PropertyQGroup.szDataType,+MyPropertyQ.szClassName,+MyPropertyQ.PropertyQGroup.szPropertyName)
                     MyPropertyQOrder = 3
                     ?PropertyList{PROPLIST:Header,MyPropertyQOrder} = ?PropertyList{PROPLIST:Header,MyPropertyQOrder} & ' +'
                     MyPropertyQ.PropertyQGroup.szDataType = Shadow
                     GET(MyPropertyQ,POSITION(MyPropertyQ))
                     ?PropertyList{PROP:Selected} = POINTER(MyPropertyQ)
                  END
               END
            ELSE
               GET(MyPropertyQ,I)
               ClassQ.lClassID = MyPropertyQ.PropertyQGroup.lClassID
               GET(ClassQ,+ClassQ.lClassID)
               !IF MyPropertyQ.PropertyQGroup.bModule = FALSE
               !   srcViewAsciiFile(ClassQ.lIncludeId,MyPropertyQ.PropertyQGroup.lLineNum,ViewerThreadQ)
               !ELSE
               !   srcViewAsciiFile(ClassQ.lModuleId,MyPropertyQ.PropertyQGroup.lLineNum,ViewerThreadQ)
               !END
               SelectedClassName = ClassQ.szClassName
               POST(EVENT:CloseWindow)
            END
         END
      END
      IF Shadow = ''
         HIDE(?LocatorImage)
      ELSE
         UNHIDE(?LocatorImage)
      END
      DISPLAY(?Shadow)
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
  SELF.SetStrategy(?Sheet1, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?Sheet1
  SELF.SetStrategy(?List1, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?List1
  SELF.SetStrategy(?List2, Resize:FixLeft+Resize:FixBottom, Resize:ConstantRight+Resize:LockHeight) ! Override strategy for ?List2
  SELF.SetStrategy(?ClassList, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?ClassList
  SELF.SetStrategy(?MethodList, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?MethodList
  SELF.SetStrategy(?PropertyList, Resize:FixLeft+Resize:FixTop, Resize:ConstantRight+Resize:ConstantBottom) ! Override strategy for ?PropertyList
  SELF.SetStrategy(?CloseButton, Resize:FixRight+Resize:FixBottom, Resize:LockSize) ! Override strategy for ?CloseButton

