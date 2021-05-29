

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
!!! Parse #PROMPT string
!!! </summary>
srcParsePrompt       PROCEDURE  (*CSTRING sz, *TOKENQUEUETYPE Token)!,BYTE ! Declare Procedure
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
I             LONG,AUTO
J             LONG,AUTO
K             LONG,AUTO
N             LONG,AUTO
szWork        CSTRING(1025)
szAttr        CSTRING(21)
ReturnValue   BYTE,AUTO

  CODE
  ReturnValue = Level:Cancel
  szWork = UPPER(sz) & ','
  IF szWork[1 : 9] = '#PROMPT('''
     !Get the prompt text
     !=================================================================
     I = INSTRING('''',szWork,1,10)                             !look for closing quote
     IF I                                                       !RR - need to watch for escaped quotes
        Token.szPrompt = sz[10 : I-1]                           !get the prompt
        I = INSTRING(',',szWork,1,I+1)                          !look for comma
        IF I                                                    !found comma
           J = INSTRING(')',szWork,1,I+1)                       !look for closing parenthesis
           K = INSTRING('(',szWork,1,I+1)                       !maybe spin attributes
           IF K > 0 AND K < J
              J = K
           END
           IF J                                                 !found )
              Token.szType = CLIP(LEFT(szWork[I+1 : J-1]))      !get the type
              IF Token.szType[1] = '@'
                 Token.szPicture = Token.szType
                 Token.szType = 'ENTRY'
              END

              CASE Token.szType
              OF 'SPIN'
                 DO ProcessSpin

              OF 'DROP'
                 I = INSTRING(')',szWork,1,J+1)
                 IF I
                    Token.szScope = CLIP(LEFT(sz[J+2 : I-2]))
                    J = INSTRING(')',szWork,1,I+1)              !look for closing prompt )
                 ELSE
                    J = LEN(szWork)
                 END
              END

              I = INSTRING(',',szWork,1,J+1)                        !look for comma
              IF I                                                  !found comma
                 J = INSTRING(',',szWork,1,I+1)                     !look for comma
                 IF J                                               !found comma
                    !Token.szName = '%' & szWork[I+1 : J-1] & '%'    !get token name
                    Token.szName = szWork[I+1 : J-1]                !get token name
                    IF Token.szName[1] <> '%'
                       Token.szName = '%' & Token.szName
                    END

                    !process remaining attributes
                    !===========================================
                    I = INSTRING(',',szWork,1,J+1)
                    LOOP WHILE I <> 0
                       szAttr = CLIP(LEFT(szWork[J+1 : LEN(szWork)]))
                       IF szAttr[1 : 8] = 'DEFAULT('
                          DO ProcessDefault
                       ELSIF szAttr[1 : 3] = 'AT('
                          DO ProcessAt
                       ELSIF szAttr[1 : 9] = 'PROMPTAT('
                          DO ProcessPromptAt
                       ELSIF szAttr[1 : 6] = 'VALUE('
                          DO ProcessValue
                       ELSIF szAttr[1 : 6] = 'CHOICE'
                          Token.bChoice = TRUE
                          J = I
                       END
                       I = INSTRING(',',szWork,1,J+1)
                    END
                 ELSE                                                       !no more attributes
                    Token.szName = '%' & szWork[I+1 : LEN(szWork)] & '%'    !get token name
                 END
                 ReturnValue = Level:Benign
              ELSE
                 ReturnValue = Level:Benign
              END
           END
        END
     END
  END
  RETURN ReturnValue
ProcessDefault  ROUTINE
  DATA
M       LONG,AUTO
N       LONG,AUTO

  CODE
  M = J + 9
  N = INSTRING(')',szWork,1,M)
  IF N
     Token.szDefault = sz[M : N-1]
  END
  J = I
  EXIT
ProcessAt  ROUTINE
  DATA
M       LONG,AUTO
N       LONG,AUTO

  CODE
  M = J+4
  N = INSTRING(',',szWork,1,M)
  IF N
     IF N > M
        Token.xPos = CLIP(LEFT(szWork[M : N-1]))
     END
     M = N + 1

     N = INSTRING(',',szWork,1,M)
     IF N
        IF N > M
           Token.yPos = CLIP(LEFT(szWork[M : N-1]))
        END
        M = N + 1

        N = INSTRING(',',szWork,1,M)
        IF N
           IF N > M
              Token.width = CLIP(LEFT(szWork[M : N-1]))
           END
           M = N + 1

           N = INSTRING(')',szWork,1,M)
           IF N
              IF N > M
                 Token.height = CLIP(LEFT(szWork[M : N-1]))
              END
           END
        END
     END
  END
  J = INSTRING(')',szWork,1,J+1)
  IF INSTRING(',',szWork,1,J+1)
     J = INSTRING(',',szWork,1,J+1)
  END
  EXIT
ProcessPromptAt  ROUTINE
  DATA
M       LONG,AUTO
N       LONG,AUTO

  CODE
  M = J+10
  N = INSTRING(',',szWork,1,M)
  IF N
     IF N > M
        Token.prompt_xPos = CLIP(LEFT(szWork[M : N-1]))
     END
     M = N + 1

     N = INSTRING(',',szWork,1,M)
     IF N
        IF N > M
           Token.prompt_yPos = CLIP(LEFT(szWork[M : N-1]))
        END
        M = N + 1

        N = INSTRING(',',szWork,1,M)
        IF N
           IF N > M
              Token.prompt_width = CLIP(LEFT(szWork[M : N-1]))
           END
           M = N + 1

           N = INSTRING(')',szWork,1,M)
           IF N
              IF N > M
                 Token.prompt_height = CLIP(LEFT(szWork[M : N-1]))
              END
           END
        END
     END
  END
  J = INSTRING(')',szWork,1,J+1)
  IF INSTRING(',',szWork,1,J+1)
     J = INSTRING(',',szWork,1,J+1)
  END
  EXIT
ProcessValue  ROUTINE
  DATA
M       LONG,AUTO
N       LONG,AUTO

  CODE
  M = J + 7
  N = INSTRING(')',szWork,1,M)
  IF N
     Token.szRadioValue = sz[M : N-1]
  END
  J = I
  EXIT
ProcessSpin ROUTINE
  DATA
M       LONG,AUTO
N       LONG,AUTO

  CODE
  !J-->(
  N = INSTRING(')',szWork,1,J+1)                    !look for closing attribute )

  I = INSTRING(',',szWork,1,J+1)                    !look for comma
  IF N < I                                          !make sure it wasn't found beyond end )
     I = N                                          !point to end if it was
  END
  IF I                                                  !found picture
     Token.szPicture = CLIP(LEFT(szWork[J+1 : I-1]))    !get picture
     J = I                                              !J-->, or )
     IF I < N                                           !if not finished
        I = INSTRING(',',szWork,1,J+1)                  !look for comma
        IF N < I                                        !make sure it wasn't found beyond end )
           I = N                                        !point to end if it was
        END
        IF I                                                !found low
           Token.low = CLIP(LEFT(szWork[J+1 : I-1]))        !get low
           J = I                                            !J-->, or )
           IF I < N                                         !if not finished
              I = INSTRING(',',szWork,1,J+1)                !look for comma
              IF N < I                                      !make sure it wasn't found beyond end )
                 I = N                                      !point to end if it was
              END
              IF I                                              !found high
                 Token.high = CLIP(LEFT(szWork[J+1 : I-1]))     !get high
                 J = I                                          !J-->, or )
                 I = INSTRING(')',szWork,1,J+1)                 !look for )
                 IF I                                           !found step
                    Token.step = CLIP(LEFT(szWork[J+1 : I-1]))  !get step
                    J = I                                       !J-->)
                 END
              END
           END
        END
     END
  END
  J = INSTRING(')',szWork,1,N+1)                    !look for closing prompt )
  ASSERT(J <> 0)
  IF ~J
     J = LEN(szWork)
  END
