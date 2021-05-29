

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
!!! </summary>
srcReadClarionProps  PROCEDURE  (*CSTRING szXmlFilename)   ! Declare Procedure
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
MyQueue                 QUEUE,PRE(QUE)
ElementName                STRING(35)
                        END
MyData                  CSTRING(128)
lCnt                    LONG
lSkipToNextVersion      LONG(false)
szTestString            CSTRING(1024)
cc                      LONG  !completion code
i                       LONG

szVersionNameKey        CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,NAME,')
szPathKey               CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PATH,VALUE,')
szIsWindowsVersionKey   CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,ISWINDOWSVERSION,VALUE,')
szIniFileKey            CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,INI,VALUE,')
szLibsrcKey             CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,LIBSRC,VALUE,')
szRedFileKey            CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,NAME,VALUE,')
szSupportsIncludeKey    CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,SUPPORTSINCLUDE,VALUE,')

szPropertiesKey         CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES')

szRootKey               CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,ROOT,VALUE,')
szRedDirKey             CSTRING('CLARIONPROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,PROPERTIES,REDDIR,VALUE,')

  CODE
      CLEAR(glo:VersionQ)
      IF ~Xml:LoadFromFile(szXmlFilename)
         Xml:GotoTop()
         IF ~Xml:FindNextContent('Clarion.Versions',FALSE,FALSE)
            cc = Xml:ReadCurrentRecord(MyQueue,MyData)
            IF UPPER(MyData) = 'CLARION.VERSIONS'
               LOOP
                  IF ~Xml:ReadNextRecord(MyQueue,MyData)
                     IF lSkipToNextVersion AND Records(MyQueue) > 4 !Skip all elements until the specIFic version is over
                        CYCLE
                     ELSE
                        lSkipToNextVersion = FALSE
                     END
                     CLEAR(szTestString)
                     LOOP lCnt = 1 TO RECORDS(MyQueue)
                        GET(MyQueue,lCnt)
                        szTestString = szTestString & CLIP(MyQueue.ElementName) & ','
                     END
                     IF UPPER(szTestString) = szVersionNameKey
                        glo:VersionQ.VersionName = MyData
                        glo:VersionQ.RedirectionMacros &= NULL
                        ADD(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szPathKey
                        glo:VersionQ.Path = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szIsWindowsVersionKey
                        glo:VersionQ.IsWindowsVersion = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szIniFileKey
                        glo:VersionQ.IniFile = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szLibsrcKey
                        glo:VersionQ.Libsrc = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szRedFileKey
                        glo:VersionQ.RedFile = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szSupportsIncludeKey
                        glo:VersionQ.SupportsInclude = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString[1 : LEN(szPropertiesKey)]) = szPropertiesKey AND UPPER(MyData) = 'MACROS'
                        IF glo:VersionQ.RedirectionMacros &= NULL
                           glo:VersionQ.RedirectionMacros &= NEW RedirectionQueueType
                           glo:VersionQ.RedirectionMacros.Token = '%REDNAME%'
                           glo:VersionQ.RedirectionMacros.Path  = glo:VersionQ.RedFile
                           ADD(glo:VersionQ.RedirectionMacros)
                        END

                        LOOP WHILE lSkipToNextVersion = FALSE
                          IF ~Xml:ReadNextRecord(MyQueue,MyData)

                             CLEAR(szTestString)
                             LOOP lCnt = 1 TO RECORDS(MyQueue)
                                GET(MyQueue,lCnt)
                                szTestString = szTestString & CLIP(MyQueue.ElementName) & ','
                             END

                             i = INSTRING(',',szTestString,1,LEN(szPropertiesKey)+2)
                             IF i
                                IF MyData <> ''
                                   glo:VersionQ.RedirectionMacros.Token = '%' & UPPER(szTestString[LEN(szPropertiesKey)+2 : i-1]) & '%'
                                   glo:VersionQ.RedirectionMacros.Path  = MyData
                                   ADD(glo:VersionQ.RedirectionMacros)
                                   PUT(glo:VersionQ)
                                END
                             ELSE
                                lSkipToNextVersion = true
                             END

                             IF UPPER(szTestString) = szRootKey
                                glo:VersionQ.root = MyData
                                PUT(glo:VersionQ)
                             ELSIF UPPER(szTestString) = szRedDirKey
                                glo:VersionQ.RedDir = MyData
                                PUT(glo:VersionQ)
                             END

                          END
                        END



                     ELSIF UPPER(szTestString) = szRootKey
                        glo:VersionQ.root = MyData
                        PUT(glo:VersionQ)

                     ELSIF UPPER(szTestString) = szRedDirKey
                        glo:VersionQ.RedDir = MyData
                        PUT(glo:VersionQ)
                        lSkipToNextVersion = true

                     ELSIF RECORDS(MyQueue) < 3  !At the END of the Clarion Versions section
                        BREAK
                     END
                  ELSE
                     BREAK
                  END
               END
            END
         END
         Xml:Free()
         !Xml:DebugMyQueue(glo:VersionQ,'Versions')
      END
