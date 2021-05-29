

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
!!! <summary>
!!! Generated from procedure template - Source
!!! Add ClassViewer to the Clarion Menu
!!! </summary>
srcAddToUserMenu     PROCEDURE  (BYTE bMode)               ! Declare Procedure
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
szIniFile           CSTRING(256),STATIC
IniFile             FILE,DRIVER('ASCII'),NAME(szIniFile)
IniRecord             RECORD
IniBuffer               STRING(256)
                      END
                    END

UserMenus           QUEUE,PRE(UserMenus)
MenuNumber            BYTE
MenuText              CSTRING(256)
                    END

bKCRCV              BYTE(FALSE)
UserApplications    QUEUE,PRE(UserApplications)
AppToken              CSTRING(33)
AppPath               CSTRING(256)
                    END

IniManager          INIClass

cc                  LONG
loc:szXMLFilename   CSTRING(261)
MyQueue             QUEUE
InitialDirectory       CSTRING(261)
Arguments              CSTRING(261)
Command                CSTRING(261)
MenuCommand            CSTRING(81)
PromptForArguments     CSTRING(6)
UseOutputPad           CSTRING(6)
                    END
Recs                LONG
I                   LONG

  CODE
  CASE glo:bClarionVersion
    OF CWVERSION_C2
       szIniFile = szRoot & '\bin\c2.ini'
    OF CWVERSION_C4
       szIniFile = szRoot & '\bin\c4.ini'
    OF CWVERSION_C5
       szIniFile = szRoot & '\bin\c5pe.ini'
    OF CWVERSION_C5EE
       szIniFile = szRoot & '\bin\c5ee.ini'
    OF CWVERSION_C55
       szIniFile = szRoot & '\bin\c55pe.ini'
    OF CWVERSION_C55EE
       szIniFile = szRoot & '\bin\c55ee.ini'
    OF CWVERSION_C60
       szIniFile = szRoot & '\bin\c60pe.ini'
    OF CWVERSION_C60EE
       szIniFile = szRoot & '\bin\c60ee.ini'
    OF CWVERSION_C70
       !no ini file for c7
  END
  IF glo:bClarionVersion < CWVERSION_C70
     OPEN(IniFile,ReadOnly+DenyNone)
     SET(IniFile)
     NEXT(IniFile)
     LOOP UNTIL ERRORCODE()
        CASE UPPER(CLIP(IniFile.IniRecord.IniBuffer))
        OF '[USER MENUS]'
           DO ProcessUserMenus
        OF '[USER APPLICATIONS]'
           DO ProcessUserApplications
        ELSE
           NEXT(IniFile)
        END
     END
     CLOSE(IniFile)

     IF bMode = 0
        IF bKCRCV = TRUE
           MESSAGE('Class Viewer is already installed on the Accessories Menu','Class Viewer',ICON:EXCLAMATION)
        ELSE
           IniManager.Init(szIniFile)
           GET(UserMenus,RECORDS(UserMenus))
           UserMenus.MenuNumber += 1
           IniFile.IniRecord.IniBuffer = 'A&ccessories/&Class Viewer|KCRCV'
           IniManager.Update('User Menus',UserMenus.MenuNumber,IniFile.IniRecord.IniBuffer)
           IniManager.Update('User Applications','KCRCV',LONGPATH() & '\abcview.exe')

           !delete the .dat file
           szIniFile = szIniFile[1 : LEN(szIniFile)-3] & 'dat'
           _Remove(szIniFile)

           MESSAGE('Class Viewer has been added to the Accessories Menu.','Class Viewer',ICON:EXCLAMATION)
        END
     END

  ELSE
     !CSIDL_APPDATA   EQUATE(01ah)
     cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
     CASE glo:bClarionVersion
       OF CWVERSION_C70
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\Clarion-tools.xml'
       OF CWVERSION_C80
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\8.0\Clarion-tools.xml'
       OF CWVERSION_C90
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\9.0\Clarion-tools.xml'
       OF CWVERSION_C100
          loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\10.0\Clarion-tools.xml'
     END
     IF ~Xml:LoadFromFile(loc:szXMLFileName,FALSE,FALSE)
        IF NOT Xml:FindNextNode('TOOLS','TOOL')
           Recs = Xml:loadQueue(MyQueue,TRUE,TRUE)
           LOOP I = 1 TO Recs
              GET(MyQueue,I)
              IF MyQueue.MenuCommand = 'Class Viewer'
                 bKCRCV = TRUE
                 BREAK
              END
           END

           IF bMode = 0
              IF bKCRCV = TRUE
                 MESSAGE('Class Viewer is already installed on the Tools Menu','Class Viewer',ICON:EXCLAMATION)
              ELSE
                 CLEAR(MyQueue)
                 MyQueue.InitialDirectory   = ''
                 MyQueue.Arguments          = ''
                 MyQueue.Command            = LONGPATH() & '\abcview.exe'
                 MyQueue.MenuCommand        = 'Class Viewer'
                 MyQueue.PromptForArguments = 'False'
                 MyQueue.UseOutputPad       = 'False'
                 ADD(MyQueue)
              END

              !cc = kcr_SHGetFolderPath(0,01ah,0,0,loc:szXMLFileName)
              !loc:szXMLFileName = loc:szXMLFileName & '\SoftVelocity\Clarion\7.0\Clarion-tools2.xml'
              REMOVE(loc:szXMLFileName & '.bak')
              RENAME(loc:szXMLFileName,loc:szXMLFileName & '.bak')
              IF ~Xml:CreateXMLFile(loc:szXMLFileName)
                 Xml:CreateParent('TOOLS')
                 Xml:CreateAttribute('VERSION','1')
                 Xml:AddParent()
                 Xml:AddFromQueue(MyQueue,'TOOL')
                 Xml:CloseParent()
                 Xml:CloseXMLFile()
                 MESSAGE('Class Viewer has been added to the Tools Menu.','Class Viewer',ICON:EXCLAMATION)
              END
           END
           !Xml:DebugMyQueue(MyQueue,'MyQueue Contents')
        END
        Xml:Free()
     END
  END
  RETURN(bKCRCV)
ProcessUserMenus  ROUTINE
  DATA
I   LONG
J   LONG
szWork  CSTRING(256)

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       UserMenus.MenuNumber = IniFile.IniRecord.IniBuffer[1 : I-1]
       UserMenus.MenuText   = IniFile.IniRecord.IniBuffer[I+1 : J]
       ADD(UserMenus,+UserMenus.MenuNumber)
    END
    NEXT(IniFile)
  END
  EXIT

ProcessUserApplications  ROUTINE
  DATA
I   LONG
J   LONG

  CODE
  NEXT(IniFile)
  LOOP UNTIL ERRORCODE() OR IniFile.IniRecord.IniBuffer[1] = '['
    J = LEN(CLIP(IniFile.IniRecord.IniBuffer))
    I = INSTRING('=',IniFile.IniRecord.IniBuffer)
    IF I > 1
       UserApplications.AppToken = IniFile.IniRecord.IniBuffer[1 : I-1]
       UserApplications.AppPath  = IniFile.IniRecord.IniBuffer[I+1 : J]
       ADD(UserApplications)
       IF UPPER(UserApplications.AppToken) = 'KCRCV'
          bKCRCV = TRUE
       END
    END
    NEXT(IniFile)
  END
  EXIT
