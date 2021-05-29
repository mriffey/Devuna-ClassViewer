

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
!!! Return Color String
!!! </summary>
srcGetColorString    PROCEDURE  (lColor)                   ! Declare Procedure
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
sReturn     CSTRING(31)

  CODE
  CASE lColor
    OF COLOR:NONE
       sReturn = 'COLOR:NONE'
    OF COLOR:SCROLLBAR
       sReturn = 'COLOR:SCROLLBAR'
    OF COLOR:BACKGROUND
       sReturn = 'COLOR:BACKGROUND'
    OF COLOR:ACTIVECAPTION
       sReturn = 'COLOR:ACTIVECAPTION'
    OF COLOR:INACTIVECAPTION
       sReturn = 'COLOR:INACTIVECAPTION'
    OF COLOR:MENU
       sReturn = 'COLOR:MENU'
    OF COLOR:WINDOW
       sReturn = 'COLOR:WINDOW'
    OF COLOR:WINDOWFRAME
       sReturn = 'COLOR:WINDOWFRAME'
    OF COLOR:MENUTEXT
       sReturn = 'COLOR:MENUTEXT'
    OF COLOR:WINDOWTEXT
       sReturn = 'COLOR:WINDOWTEXT'
    OF COLOR:CAPTIONTEXT
       sReturn = 'COLOR:CAPTIONTEXT'
    OF COLOR:ACTIVEBORDER
       sReturn = 'COLOR:ACTIVEBORDER'
    OF COLOR:INACTIVEBORDER
       sReturn = 'COLOR:INACTIVEBORDER'
    OF COLOR:APPWORKSPACE
       sReturn = 'COLOR:APPWORKSPACE'
    OF COLOR:HIGHLIGHT
       sReturn = 'COLOR:HIGHLIGHT'
    OF COLOR:HIGHLIGHTTEXT
       sReturn = 'COLOR:HIGHLIGHTTEXT'
    OF COLOR:BTNFACE
       sReturn = 'COLOR:BTNFACE'
    OF COLOR:BTNSHADOW
       sReturn = 'COLOR:BTNSHADOW'
    OF COLOR:GRAYTEXT
       sReturn = 'COLOR:GRAYTEXT'
    OF COLOR:BTNTEXT
       sReturn = 'COLOR:BTNTEXT'
    OF COLOR:INACTIVECAPTIONTEXT
       sReturn = 'COLOR:INACTIVECAPTIONTEXT'
    OF COLOR:BTNHIGHLIGHT
       sReturn = 'COLOR:BTNHIGHLIGHT'
    OF COLOR:Black
       sReturn = 'COLOR:Black'
    OF COLOR:Maroon
       sReturn = 'COLOR:Maroon'
    OF COLOR:Green
       sReturn = 'COLOR:Green'
    OF COLOR:Olive
       sReturn = 'COLOR:Olive'
    OF COLOR:Navy
       sReturn = 'COLOR:Navy'
    OF COLOR:Purple
       sReturn = 'COLOR:Purple'
    OF COLOR:Teal
       sReturn = 'COLOR:Teal'
    OF COLOR:Gray
       sReturn = 'COLOR:Gray'
    OF COLOR:Silver
       sReturn = 'COLOR:Silver'
    OF COLOR:Red
       sReturn = 'COLOR:Red'
    OF COLOR:Lime
       sReturn = 'COLOR:Lime'
    OF COLOR:Yellow
       sReturn = 'COLOR:Yellow'
    OF COLOR:Blue
       sReturn = 'COLOR:Blue'
    OF COLOR:Fuschia
       sReturn = 'COLOR:Fuschia'
    OF COLOR:Aqua
       sReturn = 'COLOR:Aqua'
    OF COLOR:White
       sReturn = 'COLOR:White'
  ELSE
    ltoa(lColor,sReturn,16)
    sReturn = '0' & UPPER(sReturn) & 'H'
  END
  RETURN(sReturn)
