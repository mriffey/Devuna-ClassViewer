

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
!!! Returns RGB value for named color
!!! </summary>
srcColorFromName     PROCEDURE  (STRING KnownColorName)    ! Declare Procedure
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
KnownColor     QUEUE,STATIC
Name              CSTRING(21)
Value             CSTRING(8)
               END
oHH           &tagHTMLHelp

  CODE
      IF RECORDS(KnownColor) = 0
         DO InitializeKnownColorQueue
      END
      KnownColor.Name = KnownColorName
      GET(KnownColor,+KnownColor.Name)
      IF ~ERRORCODE()
         RETURN KnownColor.Value
      ELSE
         RETURN 0
      END
InitializeKnownColorQueue  ROUTINE
      KnownColor.Name = 'AliceBlue'
      KnownColor.Value = '#F0F8FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'AntiqueWhite'
      KnownColor.Value = '#FAEBD7'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Aqua'
      KnownColor.Value = '#00FFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Aquamarine'
      KnownColor.Value = '#7FFFD4'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Azure'
      KnownColor.Value = '#F0FFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Beige'
      KnownColor.Value = '#F5F5DC'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Bisque'
      KnownColor.Value = '#FFE4C4'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Black'
      KnownColor.Value = '#000000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'BlanchedAlmond'
      KnownColor.Value = '#FFEBCD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Blue'
      KnownColor.Value = '#0000FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'BlueViolet'
      KnownColor.Value = '#8A2BE2'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Brown'
      KnownColor.Value = '#A52A2A'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'BurlyWood'
      KnownColor.Value = '#DEB887'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'CadetBlue'
      KnownColor.Value = '#5F9EA0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Chartreuse'
      KnownColor.Value = '#7FFF00'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Chocolate'
      KnownColor.Value = '#D2691E'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Coral'
      KnownColor.Value = '#FF7F50'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'CornflowerBlue'
      KnownColor.Value = '#6495ED'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Cornsilk'
      KnownColor.Value = '#FFF8DC'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Crimson'
      KnownColor.Value = '#DC143C'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Cyan'
      KnownColor.Value = '#00FFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkBlue'
      KnownColor.Value = '#00008B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkCyan'
      KnownColor.Value = '#008B8B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkGoldenrod'
      KnownColor.Value = '#B8860B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkGray'
      KnownColor.Value = '#A9A9A9'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkGreen'
      KnownColor.Value = '#006400'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkKhaki'
      KnownColor.Value = '#BDB76B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkMagenta'
      KnownColor.Value = '#8B008B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkOliveGreen'
      KnownColor.Value = '#556B2F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkOrange'
      KnownColor.Value = '#FF8C00'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkOrchid'
      KnownColor.Value = '#9932CC'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkRed'
      KnownColor.Value = '#8B0000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkSalmon'
      KnownColor.Value = '#E9967A'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkSeaGreen'
      KnownColor.Value = '#8FBC8F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkSlateBlue'
      KnownColor.Value = '#483D8B'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkSlateGray'
      KnownColor.Value = '#2F4F4F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkTurquoise'
      KnownColor.Value = '#00CED1'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DarkViolet'
      KnownColor.Value = '#9400D3'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DeepPink'
      KnownColor.Value = '#FF1493'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DeepSkyBlue'
      KnownColor.Value = '#00BFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DimGray'
      KnownColor.Value = '#696969'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'DodgerBlue'
      KnownColor.Value = '#1E90FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Firebrick'
      KnownColor.Value = '#B22222'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'FloralWhite'
      KnownColor.Value = '#FFFAF0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'ForestGreen'
      KnownColor.Value = '#228B22'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Fuchsia'
      KnownColor.Value = '#FF00FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Gainsboro'
      KnownColor.Value = '#DCDCDC'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'GhostWhite'
      KnownColor.Value = '#F8F8FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Gold'
      KnownColor.Value = '#FFD700'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Goldenrod'
      KnownColor.Value = '#DAA520'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Gray'
      KnownColor.Value = '#808080'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Green'
      KnownColor.Value = '#008000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'GreenYellow'
      KnownColor.Value = '#ADFF2F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Honeydew'
      KnownColor.Value = '#F0FFF0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'HotPink'
      KnownColor.Value = '#FF69B4'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'IndianRed'
      KnownColor.Value = '#CD5C5C'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Indigo'
      KnownColor.Value = '#4B0082'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Ivory'
      KnownColor.Value = '#FFFFF0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Khaki'
      KnownColor.Value = '#F0E68C'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Lavender'
      KnownColor.Value = '#E6E6FA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LavenderBlush'
      KnownColor.Value = '#FFF0F5'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LawnGreen'
      KnownColor.Value = '#7CFC00'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LemonChiffon'
      KnownColor.Value = '#FFFACD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightBlue'
      KnownColor.Value = '#ADD8E6'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightCoral'
      KnownColor.Value = '#F08080'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightCyan'
      KnownColor.Value = '#E0FFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightGoldenrodYellow'
      KnownColor.Value = '#FAFAD2'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightGray'
      KnownColor.Value = '#D3D3D3'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightGreen'
      KnownColor.Value = '#90EE90'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightPink'
      KnownColor.Value = '#FFB6C1'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightSalmon'
      KnownColor.Value = '#FFA07A'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightSeaGreen'
      KnownColor.Value = '#20B2AA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightSkyBlue'
      KnownColor.Value = '#87CEFA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightSlateGray'
      KnownColor.Value = '#778899'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightSteelBlue'
      KnownColor.Value = '#B0C4DE'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LightYellow'
      KnownColor.Value = '#FFFFE0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Lime'
      KnownColor.Value = '#00FF00'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'LimeGreen'
      KnownColor.Value = '#32CD32'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Linen'
      KnownColor.Value = '#FAF0E6'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Magenta'
      KnownColor.Value = '#FF00FF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Maroon'
      KnownColor.Value = '#800000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumAquamarine'
      KnownColor.Value = '#66CDAA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumBlue'
      KnownColor.Value = '#0000CD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumOrchid'
      KnownColor.Value = '#BA55D3'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumPurple'
      KnownColor.Value = '#9370DB'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumSeaGreen'
      KnownColor.Value = '#3CB371'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumSlateBlue'
      KnownColor.Value = '#7B68EE'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumSpringGreen'
      KnownColor.Value = '#00FA9A'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumTurquoise'
      KnownColor.Value = '#48D1CC'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MediumVioletRed'
      KnownColor.Value = '#C71585'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MidnightBlue'
      KnownColor.Value = '#191970'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MintCream'
      KnownColor.Value = '#F5FFFA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'MistyRose'
      KnownColor.Value = '#FFE4E1'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Moccasin'
      KnownColor.Value = '#FFE4B5'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'NavajoWhite'
      KnownColor.Value = '#FFDEAD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Navy'
      KnownColor.Value = '#000080'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'OldLace'
      KnownColor.Value = '#FDF5E6'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Olive'
      KnownColor.Value = '#808000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'OliveDrab'
      KnownColor.Value = '#6B8E23'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Orange'
      KnownColor.Value = '#FFA500'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'OrangeRed'
      KnownColor.Value = '#FF4500'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Orchid'
      KnownColor.Value = '#DA70D6'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PaleGoldenrod'
      KnownColor.Value = '#EEE8AA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PaleGreen'
      KnownColor.Value = '#98FB98'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PaleTurquoise'
      KnownColor.Value = '#AFEEEE'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PaleVioletRed'
      KnownColor.Value = '#DB7093'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PapayaWhip'
      KnownColor.Value = '#FFEFD5'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PeachPuff'
      KnownColor.Value = '#FFDAB9'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Peru'
      KnownColor.Value = '#CD853F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Pink'
      KnownColor.Value = '#FFC0CB'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Plum'
      KnownColor.Value = '#DDA0DD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'PowderBlue'
      KnownColor.Value = '#B0E0E6'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Purple'
      KnownColor.Value = '#800080'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Red'
      KnownColor.Value = '#FF0000'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'RosyBrown'
      KnownColor.Value = '#BC8F8F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'RoyalBlue'
      KnownColor.Value = '#4169E1'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SaddleBrown'
      KnownColor.Value = '#8B4513'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Salmon'
      KnownColor.Value = '#FA8072'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SandyBrown'
      KnownColor.Value = '#F4A460'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SeaGreen'
      KnownColor.Value = '#2E8B57'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SeaShell'
      KnownColor.Value = '#FFF5EE'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Sienna'
      KnownColor.Value = '#A0522D'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Silver'
      KnownColor.Value = '#C0C0C0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SkyBlue'
      KnownColor.Value = '#87CEEB'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SlateBlue'
      KnownColor.Value = '#6A5ACD'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SlateGray'
      KnownColor.Value = '#708090'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Snow'
      KnownColor.Value = '#FFFAFA'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SpringGreen'
      KnownColor.Value = '#00FF7F'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'SteelBlue'
      KnownColor.Value = '#4682B4'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Tan'
      KnownColor.Value = '#D2B48C'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Teal'
      KnownColor.Value = '#008080'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Thistle'
      KnownColor.Value = '#D8BFD8'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Tomato'
      KnownColor.Value = '#FF6347'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Turquoise'
      KnownColor.Value = '#40E0D0'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Violet'
      KnownColor.Value = '#EE82EE'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Wheat'
      KnownColor.Value = '#F5DEB3'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'White'
      KnownColor.Value = '#FFFFFF'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'WhiteSmoke'
      KnownColor.Value = '#F5F5F5'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'Yellow'
      KnownColor.Value = '#FFFF00'
      ADD(KnownColor,+KnownColor.Name)
      KnownColor.Name = 'YellowGreen'
      KnownColor.Value = '#9ACD32'
      ADD(KnownColor,+KnownColor.Name)
      EXIT
