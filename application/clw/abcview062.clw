

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
!!! Calculator
!!! </summary>
Calculator           PROCEDURE                             ! Declare Procedure
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
Number     STRING(20)           !The current number displayed
Operand    REAL                 !The first operand for +,-,*,/,^ operations
Memory     REAL                 !The value contained in memory
Operation  REAL                 !The field number of the operation key
NewNumber  BYTE                 !True following = or %
Decimal    BYTE                 !True after pressing decimal point key
Digit      BYTE                 !Numeric digit represented by number key
Calculator WINDOW('Calculator'),AT(80,7,110,146),ICON('ABCVIEW.ICO'),SYSTEM,GRAY,DOUBLE,AUTO
       BUTTON('&0'),AT(29,127,14,12),FONT('Arial',12,,),KEY(KeyPad0),USE(?Zero)
       BUTTON('&1'),AT(29,111,14,12),FONT('Arial',12,,),KEY(KeyPad1),USE(?One)
       BUTTON('&2'),AT(47,111,14,12),FONT('Arial',12,,),KEY(KeyPad2),USE(?Two)
       BUTTON('&3'),AT(65,111,14,12),FONT('Arial',12,,),KEY(KeyPad3),USE(?Three)
       BUTTON('&4'),AT(29,97,14,12),FONT('Arial',12,,),KEY(KeyPad4),USE(?Four)
       BUTTON('&5'),AT(47,97,14,12),FONT('Arial',12,,),KEY(KeyPad5),USE(?Five)
       BUTTON('&6'),AT(65,97,14,12),FONT('Arial',12,,),KEY(KeyPad6),USE(?Six)
       BUTTON('&7'),AT(29,83,14,12),FONT('Arial',12,,),KEY(KeyPad7),USE(?Seven)
       BUTTON('&8'),AT(47,83,14,12),FONT('Arial',12,,),KEY(KeyPad8),USE(?Eight)
       BUTTON('&9'),AT(65,83,14,12),FONT('Arial',12,,),KEY(KeyPad9),USE(?Nine)
       BUTTON('.'),AT(47,127,14,12),FONT('Arial',12,,),KEY(DecimalKey),USE(?Decimal)
       BUTTON('CE'),AT(10,127,14,12),FONT('Arial',10,,),TIP('Clear Entry'),USE(?Clear)
       BUTTON('p'),AT(10,97,14,12),FONT('Symbol',12,,),TIP('Pi'),USE(?Pi)
       BUTTON('+/-'),AT(10,111,14,12),FONT('Arial',10,,),TIP('Reverse Sign'),USE(?Sign)
       BUTTON('x<178>'),AT(47,68,14,12),FONT('Arial',10,,),TIP('Squared'),USE(?Square)
       BUTTON('�'),AT(29,68,14,12),FONT('Symbol',12,,),TIP('Square Root'),USE(?Root)
       BUTTON('1/x'),AT(84,68,14,12),FONT('Arial',10,,),TIP('Reciprical'),USE(?Reciprical)
       BUTTON('10X'),AT(10,68,14,12),FONT('Ariel',10,,),TIP('Multiply by Ten'),USE(?TenTimes)
       BUTTON('%'),AT(10,83,14,12),FONT('Arial',12,,),TIP('Percent'),USE(?Percent)
       BUTTON('CM'),AT(29,53,14,12),FONT('Arial',11,,),TIP('Clear Memory'),USE(?MemClear)
       BUTTON(' C'),AT(10,53,14,12),FONT('Arial',11,,),TIP('Clear All'),USE(?ClearAll)
       BUTTON('RM'),AT(47,53,14,12),FONT('Arial',10,,),TIP('Recall Memory'),USE(?MemRecall)
       BUTTON(' M -'),AT(65,53,14,12),FONT('Arial',10,,),TIP('Subtract from Memory'),USE(?MemMinus)
       BUTTON(' M+'),AT(84,53,14,12),FONT('Arial',10,,),TIP('Add to Memory'),USE(?MemPlus)
       BUTTON('+'),AT(84,127,14,12),FONT('Arial',12,,),TIP('Add'),KEY(PlusKey),USE(?Add)
       BUTTON('-'),AT(84,111,14,12),FONT('Arial',12,,),TIP('Subtract'),KEY(MinusKey),USE(?Subtract)
       BUTTON('x'),AT(84,97,14,12),FONT('Arial',12,,),TIP('Multiple'),KEY(AstKey),USE(?Multiply)
       BUTTON('/'),AT(84,83,14,12),FONT('Arial',12,,),TIP('Divide'),KEY(SlashKey),USE(?Divide)
       BUTTON('Exp'),AT(65,68,14,12),FONT('Arial',8,,),TIP('Exponential'),USE(?Power)
       BUTTON('='),AT(65,127,14,12),FONT('Arial',12,,),TIP('Equal'),KEY(EnterKey),USE(?Equal)
       STRING('Memory:'),AT(4,36,30,10),LEFT
       STRING(@S20),AT(32,36,65,10),FONT(,8,,),USE(Memory),RIGHT
       ENTRY(@s20),AT(9,12,90,16),USE(Number),RIGHT(3),INS
     END

  CODE
  OPEN(Calculator)                      !Open the calculator window
  NewNumber = True                      !Start with a new number
  Decimal = False                       !No decimal point has been entered
  Operation = ?Equal                    !No outstanding operation
!-----------------------------------------------------------------------------
!
!     ACCEPT...END is a control structure that processes the events
!     posted by the open window.  These events may be related to control
!     fields (e.g. a button was pressed or a text field was entered).
!     or they may be related to the window (e.g. a non-modal window is
!     about to lose focus or the window is about be be closed by the
!     system menu).  When an ACCEPT loop cycles, these functions supply
!     information about the event that is to be processed:
!
!     EVENT()    returns the event number that occurred.  EQUATES.CLW
!                contains labels for these events.
!     FIELD()    returns the field number that currently has focus.
!                Field numbers are referenced with field equate labels.
!     SELECTED() returns the field number that is to receive focus
!                during a "new field selected" event.  For any other
!                event, SELECTED() returns 0.
!     ACCEPTED() returns the field number for any control field event.
!                For other events, ACCEPTED() returns 0.
!
!-----------------------------------------------------------------------------
  ACCEPT                                !Enable windows and wait for an event
    DISPLAY
    If NewNumber
      First# = 0
    End
    IF ACCEPTED()                         ! user has caused accepted event
      CASE ACCEPTED()                     ! Jump to the accepted field
      OF ?Zero TO ?Nine                   ! For a numeric key
        Digit = ACCEPTED() - ?Zero        !  The digit is the field number
        IF NewNumber                      !  For the first digit
          If Decimal
            Number = '.' & Digit
            NewNumber = False             !   Turn NewNumber flag off
            First# = 1
          Else
            Number = Digit                !   Set the number to the digit
            NewNumber = False             !   Turn NewNumber flag off
            Decimal = False               !   Turn decimal point flag off
          End
        ELSE                              !   For any other digit
          IF Decimal                      !    For a fractional digit
            If First# = 0
              Number = CLIP(Number) & '.' & Digit !     Concatenate the digit
              First# = 1
            ELSE
              Number = CLIP(Number) & Digit !     Concatenate the digit
            End
          ELSE                            !    For an integer digit
            Number = Number * 10 + Digit  !     Multipy by 10 and add the digit
          END                             !    End the IF
        END                               !   End the IF
        CYCLE                             !   Continue number entry
      OF ?Decimal                         ! For the decimal point key
        Decimal = True                    !  Turn decimal point flag on
        CYCLE                             !  Continue number entry
      OF ?Pi                              ! For the Pi key
        Number = 3.141592654              !  Set number to Pi
        NewNumber = TRUE                  !  Start new number
        Decimal = False
        CYCLE                             !  Continue
      OF ?Clear                           ! For the ClearEntry/Clear key
        IF NewNumber THEN                 !  completed number entry
          Operation = ?Equal              !   so Clear current calculation
        END                               !  End IF
        Number = 0                        !  Clear number
        NewNumber = 0                     !  Start new number
        Decimal = False
      END                                 ! End CASE
      IF Operation <> ?Equal              ! Complete outstanding operations
        IF ACCEPTED() = ?Percent          !  For the percent key
          Number = Number * Operand / 100 ! Calculate % value
          IF  (Operation <> ?Add )     |  !  Check not adding
          AND (Operation <> ?Subtract )   !  or subtractiong percentage
            Operation = ?Equal            !   Finished operation
          END                             !  End IF
        END                               ! End IF
        CASE Operation                    !  Jump to saved operation key
        OF ?Add                           ! For Add key
          Number += Operand               !   Add number to operand
        OF ?Subtract                      !  For Subtract key
          Number = Operand - Number       !   Subtract number from operand
        OF ?Multiply                      !  For Multiply key
          Number *= Operand               !   Multiply operand by number
        OF ?Divide                        !  For Divide key
          IF Number <> 0 THEN             !  Check for divide by zero
            Number = Operand / Number     !   Divide operand by number
          END                             !  End IF
        OF ?Power                         !  For Raise to a Power key
          Number = Operand ^ Number       !   Raise operand to number power
        END                               !  End CASE
        Decimal = False
        Operation = ?Equal                !  Operation done
      END;                                ! End IF
      CASE ACCEPTED()                     ! Jump to the accepted field
      OF ?Sign                            ! For the Change Sign key
        Number *= -1                      !  Multiply by -1
      OF ?Square                          ! For the Square key
        Number *= Number                  !  Multilpy by itself
      OF ?Root                            ! For the Square Root key
        Number = SQRT(Number)             !  Find the square root
      OF ?TenTimes                        ! For the 10X key
        Number *= 10                      !  Multiply by 10
      OF ?Reciprical                      ! For the Reciprical key
        IF Number <> 0 THEN               ! Check for divide by zero
          Number = 1/Number               !  Find the reciprical
        END                               ! End IF
      OF ?ClearAll                        ! For clear all key
        Number = 0                        !  Set number to zero
        Memory = 0                        !  Set memory to zero
      OF ?MemClear                        ! For clear memory key
        Memory = 0                        !  Set memory to zero
      OF ?MemRecall                       ! For the Recall Memory key
        Number = Memory                   !  Set number to memory
      OF ?MemMinus                        ! For subtract from memory key
        Memory -= Number                  !  Subtract number from memory
      OF ?MemPlus                         ! For the Add to Memory key
        Memory += Number                  !  Add number to memory
      OF ?Add TO ?Power                   ! For two operand operation keys
        Operation = ACCEPTED()            !  Save the operator
        Operand = Number                  !  Save the first operand
      END                                 ! End CASE
      SELECT(?Zero)                       ! Set focus to the Zero key
      NewNumber = TRUE                    ! ready for next number
      Decimal = False
    END                                   !End CASE
  END                                   !End ACCEPT
  CLOSE(Calculator)                     !Close the calculater window
