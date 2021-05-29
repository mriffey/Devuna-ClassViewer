

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
!!! extract prototype attribute from passed string
!!! </summary>
srcGetPrototypeAttr  PROCEDURE  (STRING sAttribute, STRING sString) !,STRING ! Declare Procedure
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
I           LONG,AUTO
J           LONG,AUTO
szReturn    CSTRING(1024)

  CODE
  CASE(sAttribute)
    OF 'DLL'
       I = INSTRING(',DLL(',sString,1,1)
       IF I
          I += 5
          J = INSTRING(')',sString,1,I)-1
          szReturn = sString[I : J]
       ELSE
          szReturn = ''
       END
    OF 'NAME'
       I = INSTRING(',NAME(''',sString,1,1)
       IF I
          I += 7
          J = INSTRING('''',sString,1,I)-1
          szReturn = sString[I : J]
       ELSE
          szReturn = ''
       END
    OF 'CALLCONV'
       IF INSTRING(',PASCAL,',sString,1,1) OR (SUB(CLIP(sString),-7,7) = ',PASCAL')
          szReturn = 'PASCAL'
       ELSIF INSTRING(',C,',sString,1,1) OR (SUB(CLIP(sString),-2,2) = ',C')
          szReturn = 'C'
       ELSE
          szReturn = ''
       END
    OF 'RETURN'
       szReturn = CLIP(sString)
       szReturn = srcGetReturnType(szReturn)
  END
  RETURN(szReturn)
