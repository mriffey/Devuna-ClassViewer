

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
!!! Replace a string
!!! </summary>
srcReplaceString     PROCEDURE  (s, sAttribute, sNewValue) ! Declare Procedure
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
sTemp       CSTRING(1024)
sWork       CSTRING(1024)
lpAttribute LONG

  CODE
  sTemp = CLIP(s)
  lpAttribute = INSTRING(UPPER(sAttribute),UPPER(sTemp),1)
  IF lpAttribute
     LOOP WHILE lpAttribute
        sWork = SUB(sTemp,1,lpAttribute-1)
        sWork = sWork & sNewValue
        sTemp = SUB(sTemp,lpAttribute+LEN(sAttribute),LEN(sTemp)-(lpAttribute+LEN(sAttribute)-1))
        sWork = sWork & sTemp
        sTemp = sWork
        lpAttribute = INSTRING(UPPER(sAttribute),UPPER(sTemp),1)
     END
  ELSE
     sWork = sTemp
  END
  RETURN(sWork)
