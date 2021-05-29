

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
!----------------------------------------------------------------------
Access:Memory  FUNCTION(szFileName,bMode)
lQueuePointer   LONG,AUTO
lQueueRecords   LONG,AUTO
ReturnValue     LONG(Level:Benign)
sProgramName    STRING(8),AUTO
sProcVersion    STRING('03')
ulFilePointer   ULONG,AUTO
ulLength        ULONG,AUTO
szBaseFileName  CSTRING(64),AUTO
szImpExFileName CSTRING(FILE:MaxFilePath),AUTO,STATIC,THREAD
ImpExFile       FILE,DRIVER('DOS'),NAME(szImpExFileName),PRE(_DOS),CREATE,BINDABLE,THREAD
Record              RECORD,PRE()
ulRecordSize            ULONG
FileByte                BYTE,DIM(32 * 1024)
                    END
                END
 CODE
 IF szFileName[ LEN(szFileName)-3 ] = '.'
    szBaseFileName = SUB(szFileName,1,LEN(szFileName)-4)
 ELSE
    szBaseFileName = szFileName
 END
 CASE bMode
   OF ACTION:SAVE
      DO ExportData
   OF ACTION:LOAD
      DO ImportData
   OF ACTION:DELETE
      DO DeleteData
   OF ACTION:IDENTIFY
      DO ImportData
 END
 RETURN(ReturnValue)

!----------------------------------------------------------------------
DeleteData  ROUTINE
 !Remove existing backup file
 szImpExFileName = szBaseFileName & '.BAK'
 IF EXISTS(szImpExFileName)
    REMOVE(ImpExFile)
 END

 !Backup existing file
 IF szBaseFileName = szFileName
    szImpExFileName = szBaseFileName & '.MDL'
 ELSE
    szImpExFileName = szFileName
 END
 IF EXISTS(szImpExFileName)
    REMOVE(ImpExFile)
 END
!----------------------------------------------------------------------
ExportData  ROUTINE
 DO DeleteData
 !Create a new file
 CREATE(ImpExFile)
 OPEN(ImpExFile,ReadWrite+DenyAll)
 IF ~ERRORCODE()
    !Write Program Name
    sProgramName = 'ABCVIEW'
    _DOS:ulRecordSize = SIZE(sProgramName)
    memcpy(ADDRESS(_DOS:FileByte),ADDRESS(sProgramName),SIZE(sProgramName))
    ADD(ImpExFile,_DOS:ulRecordSize+4)
    !Write Procedure Version
    sProcVersion = '03'
    _DOS:ulRecordSize = SIZE(sProcVersion)
    memcpy(ADDRESS(_DOS:FileByte),ADDRESS(sProcVersion),SIZE(sProcVersion))
    ADD(ImpExFile,_DOS:ulRecordSize+4)
    !Write Identifier Field 1
    _DOS:ulRecordSize = 0
    ADD(ImpExFile,4)
    !Write Identifier Field 2
    _DOS:ulRecordSize = 0
    ADD(ImpExFile,4)
    _DOS:ulRecordSize = 0
    ADD(ImpExFile,4)

    !Save ExtraModuleQ ---------------------------
    IF SIZE(ExtraModuleQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(ExtraModuleQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(ExtraModuleQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(ExtraModuleQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(ExtraModuleQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(ExtraModuleQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(ExtraModuleQ),SIZE(ExtraModuleQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save ModuleQ ---------------------------
    IF SIZE(ModuleQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(ModuleQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(ModuleQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(ModuleQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(ModuleQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(ModuleQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(ModuleQ),SIZE(ModuleQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save ClassQ ---------------------------
    IF SIZE(ClassQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(ClassQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(ClassQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(ClassQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(ClassQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(ClassQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(ClassQ),SIZE(ClassQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save PropertyQ ---------------------------
    IF SIZE(PropertyQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(PropertyQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(PropertyQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(PropertyQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(PropertyQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(PropertyQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(PropertyQ),SIZE(PropertyQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save MethodQ ---------------------------
    IF SIZE(MethodQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(MethodQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(MethodQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(MethodQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(MethodQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(MethodQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(MethodQ),SIZE(MethodQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save StructureQ ---------------------------
    IF SIZE(StructureQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(StructureQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(StructureQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(StructureQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(StructureQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(StructureQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(StructureQ),SIZE(StructureQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save EnumQ ---------------------------
    IF SIZE(EnumQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(EnumQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(EnumQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(EnumQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(EnumQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(EnumQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(EnumQ),SIZE(EnumQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save TreeQ ---------------------------
    IF SIZE(TreeQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(TreeQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(TreeQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(TreeQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(TreeQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(TreeQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(TreeQ),SIZE(TreeQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save CallQ ---------------------------
    IF SIZE(CallQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(CallQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(CallQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(CallQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(CallQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(CallQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(CallQ),SIZE(CallQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save NoteQ ---------------------------
    IF SIZE(NoteQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(NoteQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(NoteQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(NoteQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(NoteQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(NoteQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(NoteQ),SIZE(NoteQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save CategoryQ ---------------------------
    IF SIZE(CategoryQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(CategoryQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(CategoryQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(CategoryQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(CategoryQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(CategoryQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(CategoryQ),SIZE(CategoryQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save incTemplateQ ---------------------------
    IF SIZE(incTemplateQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(incTemplateQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(incTemplateQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(incTemplateQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(incTemplateQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(incTemplateQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(incTemplateQ),SIZE(incTemplateQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save clwTemplateQ ---------------------------
    IF SIZE(clwTemplateQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(clwTemplateQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(clwTemplateQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(clwTemplateQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(clwTemplateQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(clwTemplateQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(clwTemplateQ),SIZE(clwTemplateQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save FavoritesQ ---------------------------
    IF SIZE(FavoritesQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(FavoritesQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(FavoritesQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(FavoritesQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(FavoritesQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(FavoritesQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(FavoritesQ),SIZE(FavoritesQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END

    !Save tplTemplateQ ---------------------------
    IF SIZE(tplTemplateQ) > SIZE(_DOS:Record)
       HALT('Buffer Too Small (' & SIZE(tplTemplateQ) & ')')
    END
    _DOS:ulRecordSize = RECORDS(tplTemplateQ)
    ADD(ImpExFile,4)
    lQueueRecords = RECORDS(tplTemplateQ)
    LOOP lQueuePointer = 1 TO lQueueRecords
      GET(tplTemplateQ,lQueuePointer)
      _DOS:ulRecordSize = SIZE(tplTemplateQ)
      memcpy(ADDRESS(_DOS:FileByte),ADDRESS(tplTemplateQ),SIZE(tplTemplateQ))
      ADD(ImpExFile,_DOS:ulRecordSize+4)
    END
    !Close the file
    CLOSE(ImpExFile)
 ELSE
    MESSAGE(szImpExFileName & ' [' & ERRORCODE() & '] ' & ERROR(),'Error - Save Aborted',ICON:Hand)
    ReturnValue = Level:Notify
 END

!----------------------------------------------------------------------
ImportData  ROUTINE
 sProcVersion = '01'
 IF szBaseFileName = szFileName
    szImpExFileName = szBaseFileName & '.MDL'
 ELSE
    szImpExFileName = szFileName
 END
 OPEN(ImpExFile,ReadWrite+DenyAll)
 IF ~ERRORCODE()
    !Read Program Name Length
    ulFilePointer = 1
    GET(ImpExFile,ulFilePointer,4)
    ulFilePointer += 4
    ulLength = _DOS:ulRecordSize
    GET(ImpExFile,ulFilePointer,ulLength)
    ulFilePointer += ulLength
    memcpy(ADDRESS(sProgramName),ADDRESS(_DOS:Record),ulLength)
    IF sProgramName = SUB('ABCVIEW',1,SIZE(sProgramName))
       GET(ImpExFile,ulFilePointer,4)
       IF _DOS:ulRecordSize = 2
          ulFilePointer += 4
          ulLength = _DOS:ulRecordSize
          GET(ImpExFile,ulFilePointer,ulLength)
          ulFilePointer += ulLength
          memcpy(ADDRESS(sProcVersion),ADDRESS(_DOS:Record),ulLength)
          IF sProcVersion >= '02'
             GET(ImpExFile,ulFilePointer,4)
             ulFilePointer += 4
             GET(ImpExFile,ulFilePointer,4)
             ulFilePointer += 4
          END
          IF sProcVersion >= '03'
             GET(ImpExFile,ulFilePointer,4)
             ulFilePointer += 4
          END
       END

       IF bMode <> ACTION:IDENTIFY
          !Load ExtraModuleQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(ExtraModuleQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(ExtraModuleQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(ExtraModuleQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load ModuleQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(ModuleQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(ModuleQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(ModuleQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load ClassQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(ClassQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(ClassQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(ClassQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load PropertyQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(PropertyQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(PropertyQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(PropertyQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load MethodQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(MethodQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(MethodQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(MethodQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load StructureQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(StructureQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(StructureQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(StructureQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load EnumQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(EnumQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(EnumQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(EnumQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load TreeQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(TreeQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(TreeQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(TreeQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load CallQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(CallQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(CallQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(CallQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load NoteQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(NoteQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(NoteQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(NoteQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load CategoryQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(CategoryQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(CategoryQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(CategoryQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load incTemplateQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(incTemplateQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(incTemplateQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(incTemplateQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load clwTemplateQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(clwTemplateQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(clwTemplateQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(clwTemplateQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load FavoritesQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(FavoritesQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(FavoritesQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(FavoritesQ)
               ELSE
                  BREAK
               END
             END
          END
          !Load tplTemplateQ ---------------------------
          GET(ImpExFile,ulFilePointer,4)
          IF ~ERRORCODE()
             ulFilePointer += 4
             memcpy(ADDRESS(lQueueRecords),ADDRESS(_DOS:Record),4)
             FREE(tplTemplateQ)
             LOOP lQueuePointer = 1 TO lQueueRecords
               GET(ImpExFile,ulFilePointer,4)
               IF ~ERRORCODE()
                  ulFilePointer += 4
                  ulLength = _DOS:ulRecordSize
                  GET(ImpExFile,ulFilePointer,ulLength)
                  IF ~ERRORCODE()
                     ulFilePointer += ulLength
                     memcpy(ADDRESS(tplTemplateQ),ADDRESS(_DOS:Record),ulLength)
                  END
               END
               IF ~ERRORCODE()
                  ADD(tplTemplateQ)
               ELSE
                  BREAK
               END
             END
          END
       END
       !Close the file
       CLOSE(ImpExFile)
    ELSE
       MESSAGE(szImpExFileName & ' Invalid Format','Error - Load Aborted',ICON:Hand)
       ReturnValue = Level:Notify
    END
 ELSE
    IF ERRORCODE() <> NoFileErr
       MESSAGE(szImpExFileName & ' [' & ERRORCODE() & '] ' & ERROR(),'Error - Load Aborted',ICON:Hand)
    END
    ReturnValue = Level:Notify
 END

