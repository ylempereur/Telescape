;SAVE"RamSDOpen.Asm"
*===============================*
* Version 2.0        (07/16/86) *
*===============================*
RSDHndl  EQU     $28A
*--------------------------------
RAMSDOpen
         LINK    A6,#-50
         MOVEM.L D2-D3/A2-A3,-(SP)
         CLR     10(A6)
         TST.B   ROM85
         BPL.L   .5
         MOVEQ   #-6,D2
         MOVE.B  8(A6),D1
         BEQ.S   .0
         MOVEQ   #-8,D2
.0       JSR     RSD_2(PC)
         BNE.S   .2
         SUBQ    #1,D2
         JSR     RSD_2(PC)
         BNE.S   .2
         TST.B   7(A0)
         BNE.L   .5
         MOVEQ   #-1,D0
         BTST    #6,5(A0)
         BNE.S   .2
         JSR     RSD_3(PC)
         BNE.S   .2
         MOVE.L  RSDHndl,D0
         BGT.S   .4
         MOVEQ   #2,D1
         MOVE.L  ROMBase,A0
         ADDQ    #8,A0
         MOVE    (A0),D0
         CMP.B   #255,D0
         BEQ.S   .1
         LSR     #8,D0
         BNE.S   .5
         MOVEQ   #1,D1
.1       SUBQ    #4,A7
         MOVE.L  #$53455244,-(SP)        ;"SERD"
         MOVE    D1,-(SP)
         _GetResource
         MOVE.L  (SP),D3
         BNE.S   .3
         ADDQ    #4,A7
         MOVE    ResErr,D0
         BNE.S   .2
         MOVE    #-192,D0
.2       JMP     RSD_1(PC)
.3       _DetachResource
         MOVE.L  D3,A0
         BSET    #7,(A0)
         MOVE.L  A0,RSDHndl
         CLR.B   RSDHndl
.4       MOVE.L  RSDHndl,A3
         MOVE.L  (A3),A3
         MOVEQ   #-23,D0
         CMP.L   #$53455244,4(A3)        ;"SERD"
         BNE.S   .2
         MOVE.B  8(A6),D1
         BTST    D1,RSDHndl
         BNE.S   .5
         JSR     RSD_4(PC)
         BSET    D1,RSDHndl
         MOVEQ   #1,D0
         JSR     (A3)
.5       MOVEQ   #1,D2
         LEA     -50(A6),A0
         LEA     RSD_5(PC),A1
         TST.B   8(A6)
         BEQ.S   .6
         LEA     RSD_6(PC),A1
.6       MOVE.L  A1,18(A0)
         CLR     22(A0)
         CLR.B   27(A0)
         _Open
         BNE.S   RSD_1
         CLR     D1
         MOVE.B  (A1)+,D1
         ADD     D1,A1
         DBRA    D2,.6
RSD_0    MOVEM.L (SP)+,D2-D3/A2-A3
         UNLK    A6
         MOVE.L  (SP)+,A0
         ADDQ    #2,A7
         JMP     (A0)
RSD_1    MOVE    D0,10(A6)
         BRA.S   RSD_0
*--------------------------------
RAMSDClose
         LINK    A6,#-50
         MOVEM.L D2-D3/A2-A3,-(SP)
         MOVE.B  8(A6),D1
         JSR     RSD_4(PC)
         TST     ROM85
         BPL.S   RSD_0
         MOVE.L  RSDHndl,D0
         BLE.S   RSD_0
         AND.L   Lo3Bytes,D0
         MOVE.L  D0,A0
         MOVE.L  (A0),A0
         CMP.L   #$53455244,4(A0)        ;"SERD"
         BNE.S   RSD_0
         BCLR    D1,RSDHndl
         MOVEQ   #0,D0
         JSR     (A0)
         TST.B   RSDHndl
         BNE.S   RSD_0
         MOVE.L  RSDHndl,A0
         _DisposHandle
         MOVEQ   #-1,D0
         MOVE.L  D0,RSDHndl
         BRA.S   RSD_0
*--------------------------------
RSD_2    LEA     -50(A6),A0
         MOVE    D2,24(A0)
         MOVE    #1,26(A0)
         _Status
         BNE.S   .0
         MOVE.L  28(A0),A0
         MOVE.L  (A0),A0
         BRA.S   .1
.0       MOVEQ   #-22,D0
.1       RTS
*--------------------------------
RSD_3    MOVEQ   #0,D0
         MOVE.L  D2,-(SP)
         MOVE.B  SPConfig,D2
         TST.B   D1
         BNE.S   .0
         LSR.B   #4,D2
.0       AND.B   #$0F,D2
         BEQ.S   .1
         SUBQ.B  #2,D2
         BEQ.S   .1
         MOVEQ   #-98,D0
         BRA.S   .3
.1       MOVE.B  PortBUse,D2
         TST.B   D1
         BNE.S   .2
         MOVE.B  PortAUse,D2
.2       BCLR    #7,D2
         BNE.S   .3
         EOR.B   #2,D2
         BEQ.S   .3
         MOVEQ   #-97,D0
.3       MOVE.L  (SP)+,D2
         TST     D0
         RTS
*--------------------------------
RSD_4    MOVEQ   #-6,D0
         TST.B   D1
         BEQ.S   .0
         MOVEQ   #-8,D0
.0       LEA     -50(A6),A0
         MOVE    D0,24(A0)
         _Close
         SUBQ    #1,24(A0)
         _Close
         TST     ROM85
         BPL.S   .1
         MOVE    SR,D0
         OR      #$0600,SR
         MOVE.L  SCCWr,A0
         MOVE.B  #9,(A0)
         MOVE    (SP),(SP)
         MOVE.B  #10,(A0)
         MOVE    D0,SR
.1       RTS
*--------------------------------
RSD_5    STR     ".AIn"
         STR     ".AOut"
RSD_6    STR     ".BIn"
         STR     ".BOut"
*--------------------------------
         END
