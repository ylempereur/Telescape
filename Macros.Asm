;SAVE"Macros.Asm"
*--------------------------------
         LIST    ON
*--------------------------------
; Macro Routines v1.0
*--------------------------------
         LIST    OFF
*================================
* D0='0'-'9' or 0-9
*--------------------------------
StartMacro
         AND     #$0F,D0
         LSL     #2,D0
         LEA     MacroTbl(A5),A0
         MOVE.L  0(A0,D0),MacroPtr(A5)
         CLR.B   F.MacRt(A5)
         CLR.L   MacroWT(A5)
         MOVE.B  #1,F.Macro(A5)
         RTS
*--------------------------------
StopMacro
         CLR.B   F.Macro(A5)
         RTS
*--------------------------------
MacroIdl TST.B   F.Macro(A5)
         BEQ.S   .1
         MOVE.L  Ticks,D0
         CMP.L   MacroWt(A5),D0
         BLO.S   .1
         CMP.B   #1,F.Macro(A5)
         BNE     .29
         MOVE.L  MacroPtr(A5),A4
         MOVE.B  (A4)+,D0
         BEQ.S   .2
         CMP.B   #'*,D0
         BEQ.S   .4
         CMP.B   #'~,D0
         BEQ.S   .5
         CMP.B   #'&,D0
         BEQ     SCAN
         CMP.B   #'`,D0
         BEQ     RSCAN
         CMP.B   #'\,D0
         BEQ.S   .6
         CMP.B   #'^,D0
         BEQ.S   .7
         CMP.B   #'>,D0
         BEQ     .11
         CMP.B   #'<,D0
         BEQ     .11
         CMP.B   #'",D0
         BEQ     .13
.0       MOVE    CHQCnt(A5),D1
         CMP     #128,D1
         BHS.S   .1
         MOVE.L  A4,MacroPtr(A5)
         LEA     CHQ(A5),A0
         MOVE.B  D0,0(A0,D1)
         ADDQ    #1,CHQCnt(A5)
         _ObscureCursor
.1       RTS
.2       TST.B   F.MacRt(A5)
         BNE.S   .3
         CLR.B   F.Macro(A5)
         RTS
.3       MOVE.L  MacPtrRt(A5),MacroPtr(A5)
         CLR.B   F.MacRt(A5)
         BRA     MacroIdl
.4       MOVE.L  A4,MacroPtr(A5)
         MOVE.L  Ticks,A0
         ADD     #30,A0
         MOVE.L  A0,MacroWt(A5)
         RTS
.5       MOVE.L  A4,MacroPtr(A5)
         MOVEQ   #3,D7
         BSR     Beeps
         BRA     MacroIdl
.6       TST.B   (A4)
         BEQ.S   .0
         MOVE.B  (A4)+,D0
         BRA.S   .0
.7       MOVE.B  (A4),D1
         CMP.B   #$7F,D1
         BHI.S   .0
         CMP.B   #$60,D1
         BLO.S   .8
         AND.B   #$5F,D1
.8       CMP.B   #$3F,D1
         BLO.S   .0
         BNE.S   .9
         MOVEQ   #$7F,D1
         BRA.S   .10
.9       AND.B   #$3F,D1
.10      MOVE.B  D1,D0
         ADDQ.L  #1,A4
         BRA     .0
.11      MOVE.B  (A4),D1
         CMP.B   #'0,D1
         BLO     .0
         CMP.B   #'9,D1
         BHI     .0
         ADDQ.L  #1,A4
         CMP.B   #'>,D0
         BEQ.S   .12
         MOVE.L  A4,MacPtrRt(A5)
         MOVE.B  #1,F.MacRt(A5)
.12      CMP.B   #'&,D1
         BEQ     SCAN
         AND     #$0F,D1
         LSL     #2,D1
         LEA     MacroTbl(A5),A0
         MOVE.L  0(A0,D1),MacroPtr(A5)
         BRA     MacroIdl
.13      CLR     D1
.14      LEA     DskNam(A5),A1
         CLR     D2
.15      MOVE.B  (A4),D0
         BEQ.S   .22
         CMP.B   #'",D0
         BEQ.S   .22
         CMP.B   #'|,D0
         BEQ.S   .22
         CMP.B   #'^,D0
         BNE.S   .19
         MOVE.B  1(A4),D3
         CMP.B   #$7F,D3
         BHI.S   .21
         CMP.B   #$60,D3
         BLO.S   .16
         AND.B   #$5F,D3
.16      CMP.B   #$3F,D3
         BLO.S   .21
         BNE.S   .17
         MOVEQ   #$7F,D3
         BRA.S   .18
.17      AND.B   #$3F,D3
.18      BRA.S   .20
.19      CMP.B   #'\,D0
         BNE.S   .21
         MOVE.B  1(A4),D3
         BEQ.S   .21
.20      ADDQ.L  #1,A4
         MOVE.B  D3,D0
.21      ADDQ.L  #1,A4
         CMP     #40,D2
         BHS.S   .15
         MOVE.B  D0,(A1)+
         ADDQ    #1,D2
         BRA.S   .15
.22      LEA     ShStr+16(A5),A0
         CMP     #16,D2
         BLS.S   .24
         MOVEQ   #16,D2
         BRA.S   .24
.23      MOVE.B  -(A1),D0
         CMP.B   -(A0),D0
         BNE.S   .26
.24      DBRA    D2,.23
         TST     D1
         BNE     .12
.25      MOVE.B  (A4)+,D0
         BEQ     .2
         CMP.B   #'",D0
         BNE.S   .25
         MOVE.L  A4,MacroPtr(A5)
         BRA     MacroIdl
.26      MOVE.B  (A4)+,D0
         CMP.B   #'|,D0
         BNE.S   .28
         MOVE.B  (A4),D1
         CMP.B   #'&,D1
         BEQ.S   .27
         CMP.B   #'0,D1
         BLO     .13
         CMP.B   #'9,D1
         BHI     .13
.27      ADDQ.L  #1,A4
         BRA     .14
.28      RTS
.29      BSR     LdProt
         BSR     LdMacro
         BSR     LdTerm
         BSR     DispKeys
         MOVEQ   #'1,D0
         BSR     StartMacro
         BRA     MacroIdl
RSCAN    LEA     PBCAct(A5),A0
         MOVE    PBNum(A5),D0
         CLR.B   0(A0,D0)
SCAN     BSR     StopMacro
         TST.B   F.BBS(A5)
         BNE.S   .2
         BSR     TestPB
         BEQ.S   .2
         LEA     PBCAct(A5),A0
         MOVE    PBNum(A5),D0
.0       ADDQ    #1,D0
         CMP     #20,D0
         BLO.S   .1
         CLR     D0
.1       TST.B   0(A0,D0)
         BEQ.S   .0
         MOVE    D0,PBNum(A5)
         MOVE.L  Ticks,A0
         ADD     #15,A0
         MOVE.L  A0,MacroWT(A5)
         MOVE.B  #2,F.Macro(A5)
.2       RTS
TestPB   LEA     PBCAct(A5),A0
         MOVE.L  (A0)+,D0
         OR.L    (A0)+,D0
         OR.L    (A0)+,D0
         OR.L    (A0)+,D0
         OR.L    (A0),D0
         RTS
*--------------------------------
LdMacro  CLR.L   -(SP)
         MOVE.L  #$4D43524F,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
CvMacro  LEA     Macro(A5),A1
         LEA     MacroTbl(A5),A2
         MOVEQ   #9,D7
.0       MOVE.L  A1,(A2)+
.1       MOVE.B  (A0)+,(A1)+
         BNE.S   .1
         DBRA    D7,.0
         BSR     StopMacro
         RTS
SvMacro  CLR.L   -(SP)
         MOVE.L  #$4D43524F,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP),A0
         _HNoPurge
         LEA     Macro(A5),A2
         MOVEQ   #10-1,D0
.0       TST.B   (A2)+
         BNE.S   .0
         DBRA    D0,.0
         LEA     Macro(A5),A0
         MOVE.L  (SP),A1
         SUB.L   A0,A2
         MOVE.L  A2,D0
         _PtrToXHand
         MOVE.L  (SP),-(SP)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         MOVE.L  (SP)+,A0
         _HPurge
         RTS
*--------------------------------
Macros   CLR.L   -(SP)
         CLR.L   -(SP)
         PEA     WERect(PC)
         PEA     NullStr(PC)
         MOVE.B  #1,-(SP)
         MOVE    #32,-(SP)
         MOVE.L  #-1,-(SP)
         CLR.B   -(SP)
         CLR.L   -(SP)
         _NewWindow
         MOVE.L  (SP),DialPtr(A5)
         _SetPort
         CLR     -(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         MOVE    #1,-(SP)
         _TextFace
         MOVE    #1,-(SP)
         _TextMode
         LEA     TiRect(PC),A2
         LEA     MATitle(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         CLR     -(SP)
         _TextFace
         LEA     MAB0(PC),A2
         BSR     FrBton
         LEA     MAB0Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     MAB1(PC),A2
         BSR     FrBton
         LEA     MAB1Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     MAB2(PC),A2
         BSR     FrBton
         LEA     MAB2Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     MAB3(PC),A2
         BSR     FrBton
         LEA     MAB3Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     MAB4(PC),A2
         BSR     FrBton
         LEA     MAB4Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         LEA     MACX(PC),A2
         BSR     FrDisp
         MOVE.L  (A5),A0
         PEA     gray(A0)
         _PenPat
         MOVE    MACX(PC),D4
         ADDQ    #1,D4
         MOVE    MACX+2(PC),D5
         ADDQ    #2,D5
         MOVE    MACX+6(PC),D6
         SUBQ    #3,D6
         MOVEQ   #'0,D7
         BRA.S   .1
.0       MOVE    D5,-(SP)
         MOVE    D4,-(SP)
         _MoveTo
         MOVE    D6,-(SP)
         MOVE    D4,-(SP)
         _LineTo
.1       MOVE    D5,-(SP)
         SUB     #9,(SP)
         MOVE    D4,-(SP)
         ADD     #11,(SP)
         _MoveTo
         MOVE    D7,-(SP)
         _DrawChar
         ADD     #14,D4
         ADDQ    #1,D7
         CMP.B   #'9,D7
         BLS.S   .0
         LEA     MAC0(PC),A2
         LEA     MacroTbl(A5),A3
         LEA     hTE0(A5),A4
         MOVEQ   #10-1,D7
.2       CLR.L   -(SP)
         MOVE.L  A2,-(SP)
         MOVE.L  A2,-(SP)
         _TENew
         MOVE.L  (SP)+,A0
         MOVE.L  A0,(A4)
         MOVE.L  (A0),A0
         MOVE    #-1,teCROnly(A0)
         MOVE.L  (A3),A0
         MOVE.L  A0,-(SP)
         CLR.L   D0
.3       TST.B   (A0)+
         BEQ.S   .4
         ADDQ.L  #1,D0
         BRA.S   .3
.4       MOVE.L  D0,-(SP)
         MOVE.L  (A4),-(SP)
         _TESetText
         MOVE.L  A2,-(SP)
         MOVE.L  (A4),-(SP)
         _TEUpdate
         ADDQ.L  #8,A2
         ADDQ.L  #4,A3
         ADDQ.L  #4,A4
         DBRA    D7,.2
         CLR.B   MABTrk(A5)
         CLR.B   MABFl(A5)
         CLR     MACAct(A5)
         MOVE.L  hTE0(A5),MAhTE(A5)
         MOVE.L  MAhTE(A5),-(SP)
         _TEActivate
         CLR.B   MAExit(A5)
.5       BSR     MAEvent
         TST.B   MAExit(A5)
         BEQ.S   .5
         MOVE.L  MAhTE(A5),-(SP)
         _TEDeactivate
         LEA     Macro(A5),A2
         LEA     MacroTbl(A5),A3
         LEA     hTE0(A5),A4
         MOVEQ   #9,D7
.6       CMP.B   #1,MAExit(A5)
         BNE.S   .10
         CLR.L   -(SP)
         MOVE.L  (A4),-(SP)
         _TEGetText
         MOVE.L  (SP),A0
         _GetHandleSize
         CMP.L   #80,D0
         BLS.S   .7
         MOVEQ   #80,D0
.7       MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         MOVE.L  A2,(A3)+
         BRA.S   .9
.8       MOVE.B  (A0)+,(A2)+
.9       DBRA    D0,.8
         CLR.B   (A2)+
.10      MOVE.L  (A4)+,-(SP)
         _TEDispose
         DBRA    D7,.6
         CMP.B   #1,MAExit(A5)
         BNE.S   .11
         BSR     StopMacro
.11      MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         RTS
*--------------------------------
MAEvent  _SystemTask
         MOVE.L  MAhTE(A5),-(SP)
         _TEIdle
         CLR.B   -(SP)
         MOVE    #$012F,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   MARt
         MOVE    What(A5),D0
         ADD     D0,D0
         MOVE    .0(PC,D0),D0
         JMP     .0(PC,D0)
.0       DATA    /MARt-.0
         DATA    /MAMD-.0
         DATA    /MAMU-.0
         DATA    /MAKD-.0
         DATA    /MARt-.0
         DATA    /MAKD-.0
         DATA    /MARt-.0
         DATA    /MARt-.0
         DATA    /MAAC-.0
MAAC     BSR     Active
MARt     TST.B   MABTrk(A5)
         BEQ.S   MABOff
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   MABOn
MABOff   TST.B   MABFl(A5)
         BEQ.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         CLR.B   MABFl(A5)
.0       RTS
MABOn    TST.B   MABFl(A5)
         BNE.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         MOVE.B  #1,MABFl(A5)
.0       RTS
MAMD     CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     WERect(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .1
         PEA     Where(A5)
         _GlobalToLocal
         LEA     MAB0(PC),A2
         MOVEQ   #0,D7
.0       CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  A2,-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .2
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #15,D7
         BLO.S   .0
.1       MOVE    #4,-(SP)
         _SysBeep
         BRA     MARt
.2       CMP     #5,D7
         BHS.S   .3
         OR.B    #$80,D7
         MOVE.B  D7,MABTrk(A5)
         MOVE.L  A2,MABPtr(A5)
         BRA     MARt
.3       SUBQ    #5,D7
         CMP     MACAct(A5),D7
         BEQ.S   .4
         MOVE.L  MAhTE(A5),-(SP)
         _TEDeactivate
         MOVE    D7,MACAct(A5)
         LEA     hTE0(A5),A0
         LSL     #2,D7
         MOVE.L  0(A0,D7),MAhTE(A5)
         CLR.L   -(SP)
         CLR.L   -(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TESetSelect
         MOVE.L  MAhTE(A5),-(SP)
         _TEActivate
.4       MOVE.L  Where(A5),-(SP)
         MOVE    Modify(A5),D0
         BTST    #9,D0
         BNE.S   .5
         CLR.B   -(SP)
         BRA.S   .6
.5       MOVE.B  #1,-(SP)
.6       MOVE.L  MAhTE(A5),-(SP)
         _TEClick
         BRA     MARt
MAMU     MOVE.B  MABTrk(A5),D7
         BEQ     MARt
         BSR     MABOff
         CLR.B   MABTrk(A5)
         PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BEQ     MARt
         AND.B   #$7F,D7
         BNE.S   .0
         MOVE.B  #1,MAExit(A5)
         BRA     MARt
.0       CMP.B   #1,D7
         BNE.S   .1
         MOVE.B  #2,MAExit(A5)
         BRA     MARt
.1       CMP.B   #2,D7
         BNE.S   .2
         MOVE.L  MAhTE(A5),-(SP)
         _TECut
         BRA     MARt
.2       CMP.B   #3,D7
         BNE.S   .3
         MOVE.L  MAhTE(A5),-(SP)
         _TECopy
         BRA     MARt
.3       MOVE.L  MAhTE(A5),-(SP)
         _TEPaste
         BRA     MARt
MAKD     MOVE    Modify(A5),D0
         BTST    #8,D0
         BNE     MARt
         MOVE.L  Message(A5),D0
         CMP.B   #$03,D0
         BEQ.S   .0
         CMP.B   #$0D,D0
         BNE.S   .1
.0       MOVE.B  #1,MAExit(A5)
         BRA     MARt
.1       CMP.B   #$09,D0
         BNE.S   .3
         MOVE.L  MAhTE(A5),-(SP)
         _TEDeactivate
         MOVE    MACAct(A5),D0
         ADDQ    #1,D0
         CMP     #10,D0
         BLO.S   .2
         MOVEQ   #0,D0
.2       MOVE    D0,MACAct(A5)
         LEA     hTE0(A5),A0
         LSL     #2,D0
         MOVE.L  0(A0,D0),MAhTE(A5)
         CLR.L   -(SP)
         MOVE.L  #32767,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TESetSelect
         MOVE.L  MAhTE(A5),-(SP)
         _TEActivate
         BRA     MARt
.3       MOVE    D0,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEKey
         BRA     MARt
*--------------------------------
WERect   DATA    /26,/6,/235,/506
TiRect   DATA    /0,/0,/25,/500
MACX     DATA    /25,/9,/168,/496
MAB0     DATA    /176,/368,/201,/428
MAB1     DATA    /176,/436,/201,/496
MAB2     DATA    /176,/9,/201,/69
MAB3     DATA    /176,/77,/201,/137
MAB4     DATA    /176,/145,/201,/205
MAC0     DATA    /28,/12,/39,/493
MAC1     DATA    /42,/12,/53,/493
MAC2     DATA    /56,/12,/67,/493
MAC3     DATA    /70,/12,/81,/493
MAC4     DATA    /84,/12,/95,/493
MAC5     DATA    /98,/12,/109,/493
MAC6     DATA    /112,/12,/123,/493
MAC7     DATA    /126,/12,/137,/493
MAC8     DATA    /140,/12,/151,/493
MAC9     DATA    /154,/12,/165,/493
MATitle  STR     "- Macros -"
MAB0Str  STR     "OK"
MAB1Str  STR     "Cancel"
MAB2Str  STR     "Cut"
MAB3Str  STR     "Copy"
MAB4Str  STR     "Paste"
*--------------------------------
MacroX   HEX     00000000000000000000
*--------------------------------
PhoBok   CLR.L   -(SP)
         CLR.L   -(SP)
         PEA     WERect(PC)
         PEA     NullStr(PC)
         MOVE.B  #1,-(SP)
         MOVE    #32,-(SP)
         MOVE.L  #-1,-(SP)
         CLR.B   -(SP)
         CLR.L   -(SP)
         _NewWindow
         MOVE.L  (SP),DialPtr(A5)
         _SetPort
         CLR     -(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         MOVE    #1,-(SP)
         _TextFace
         MOVE    #1,-(SP)
         _TextMode
         LEA     TiRect(PC),A2
         LEA     PBTitle(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         CLR     -(SP)
         _TextFace
         LEA     PBB0(PC),A2
         BSR     FrBton
         LEA     PBB0Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     PBB1(PC),A2
         BSR     FrBton
         LEA     PBB1Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     PBB2(PC),A2
         BSR     FrBton
         LEA     PBB2Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     PBB3(PC),A2
         BSR     FrBton
         LEA     PBB3Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     PBB4(PC),A2
         BSR     FrBton
         LEA     PBB4Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         LEA     PBCX(PC),A2
         BSR     FrDisp
         MOVE.L  (A5),A0
         PEA     gray(A0)
         _PenPat
         MOVE    #250,-(SP)
         MOVE    PBCX(PC),-(SP)
         ADDQ    #2,(SP)
         _MoveTo
         MOVE    #250,-(SP)
         MOVE    PBCX+4(PC),-(SP)
         SUBQ    #3,(SP)
         _LineTo
         MOVE    PBCX(PC),D4
         ADDQ    #1,D4
         MOVE    PBCX+2(PC),D5
         ADDQ    #2,D5
         MOVE    PBCX+6(PC),D6
         SUBQ    #3,D6
         MOVEQ   #10-1,D7
         BRA.S   .1
.0       MOVE    D5,-(SP)
         MOVE    D4,-(SP)
         _MoveTo
         MOVE    D6,-(SP)
         MOVE    D4,-(SP)
         _LineTo
.1       ADD     #14,D4
         DBRA    D7,.0
         LEA     PBC0(PC),A2
         MOVEQ   #0,D7
.2       CLR.L   -(SP)
         MOVE.L  #$5048424B,-(SP)
         MOVE    D7,-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A3
         BSR     DrawDisp
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #20,D7
         BLO.S   .2
         CLR.B   PBBTrk(A5)
         CLR.B   PBBFl(A5)
         LEA     PBCAct(A5),A0
         CLR.L   (A0)+
         CLR.L   (A0)+
         CLR.L   (A0)+
         CLR.L   (A0)+
         CLR.L   (A0)
.3       CLR.B   PBExit(A5)
.4       BSR     PBEvent
         MOVE.B  PBExit(A5),D6
         BEQ.S   .4
         CMP.B   #2,D6
         BHI.S   .6
         MOVE    #19,PBNum(A5)
         CMP.B   #1,D6
         BNE.S   .5
         BSR     SCAN
.5       MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         RTS
.6       CMP.B   #5,D6
         BEQ.S   .12
         LEA     PBCAct(A5),A0
         MOVEQ   #0,D7
.7       TST.B   0(A0,D7)
         BNE.S   .8
         ADDQ    #1,D7
         CMP     #20,D7
         BLO.S   .7
         BRA.S   .3
.8       MOVE    D7,PBNum(A5)
         MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         CMP.B   #3,D6
         BNE.S   .11
         BSR     PHName
         BSR     LdProt
         BSR     Protocol
         CMP.B   #1,MAExit(A5)
         BNE.S   .9
         BSR     SvProt
.9       BSR     LdMacro
         BSR     Macros
         CMP.B   #1,MAExit(A5)
         BNE.S   .10
         BSR     SvMacro
.10      BSR     LdTerm
         BSR     Terminal
         CMP.B   #1,MAExit(A5)
         BNE     PhoBok
         BSR     SvTerm
         BRA     PhoBok
.11      BSR     LdProt
         BSR     LdMacro
         BRA     LdTerm
.12      MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         CLR.L   -(SP)
         MOVE.L  #$50534554,-(SP)
         MOVE    #1,-(SP)
         _GetResource
         MOVE.L  (SP),A1
         MOVE.L  (A1),A1
         LEA     PBCAct(A5),A0
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         RTS
*--------------------------------
PBEvent  _SystemTask
         CLR.B   -(SP)
         MOVE    #$012F,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   PBRt
         MOVE    What(A5),D0
         ADD     D0,D0
         MOVE    .0(PC,D0),D0
         JMP     .0(PC,D0)
.0       DATA    /PBRt-.0
         DATA    /PBMD-.0
         DATA    /PBMU-.0
         DATA    /PBKD-.0
         DATA    /PBRt-.0
         DATA    /PBKD-.0
         DATA    /PBRt-.0
         DATA    /PBRt-.0
         DATA    /PBAC-.0
PBAC     BSR     Active
PBRt     TST.B   PBBTrk(A5)
         BEQ.S   PBBOff
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  PBBPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   PBBOn
PBBOff   TST.B   PBBFl(A5)
         BEQ.S   .0
         MOVE.L  PBBPtr(A5),A2
         BSR     BInvert
         CLR.B   PBBFl(A5)
.0       RTS
PBBOn    TST.B   PBBFl(A5)
         BNE.S   .0
         MOVE.L  PBBPtr(A5),A2
         BSR     BInvert
         MOVE.B  #1,PBBFl(A5)
.0       RTS
PBMD     CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     WERect(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .1
         PEA     Where(A5)
         _GlobalToLocal
         LEA     PBB0(PC),A2
         MOVEQ   #0,D7
.0       CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  A2,-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .2
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #25,D7
         BLO.S   .0
.1       MOVE    #4,-(SP)
         _SysBeep
         BRA     PBRt
.2       CMP     #5,D7
         BHS.S   .3
         OR.B    #$80,D7
         MOVE.B  D7,PBBTrk(A5)
         MOVE.L  A2,PBBPtr(A5)
         BRA     PBRt
.3       SUBQ    #5,D7
         LEA     PBCAct(A5),A0
         EOR.B   #1,0(A0,D7)
         LEA     PBC0(PC),A0
         LSL     #3,D7
         LEA     0(A0,D7),A2
         BSR     DInvert
         BRA     PBRt
PBMU     MOVE.B  PBBTrk(A5),D7
         BEQ     PBRt
         BSR     PBBOff
         CLR.B   PBBTrk(A5)
         PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  PBBPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BEQ     PBRt
         AND.B   #$7F,D7
         ADDQ.B  #1,D7
         MOVE.B  D7,PBExit(A5)
         BRA     PBRt
PBKD     MOVE    Modify(A5),D0
         BTST    #8,D0
         BNE     PBRt
         MOVE.L  Message(A5),D0
         CMP.B   #$03,D0
         BEQ.S   .0
         CMP.B   #$0D,D0
         BNE.S   .1
.0       MOVE.B  #1,PBExit(A5)
.1       BRA     PBRt
*--------------------------------
* A2=Rect, A3=String
*--------------------------------
DrawDisp LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00010001,-(SP)
         _InsetRect
         CLR.L   -(SP)
         _NewRgn
         MOVE.L  (SP),A4
         _GetClip
         PEA     -8(A6)
         _ClipRect
         MOVE    -6(A6),-(SP)
         ADDQ    #1,(SP)
         MOVE    -8(A6),-(SP)
         ADD     #9,(SP)
         _MoveTo
         MOVE.L  A3,-(SP)
         _DrawString
         MOVE.L  A4,-(SP)
         _SetClip
         MOVE.L  A4,-(SP)
         _DisposRgn
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
DInvert  LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00010001,-(SP)
         _InsetRect
         PEA     -8(A6)
         _InverRect
         UNLK    A6
         RTS
*--------------------------------
PBCX     DATA    /25,/11,/168,/490
PBB0     DATA    /176,/362,/201,/422
PBB1     DATA    /176,/430,/201,/490
PBB2     DATA    /176,/11,/201,/71
PBB3     DATA    /176,/79,/201,/139
PBB4     DATA    /176,/147,/201,/207
PBC0     DATA    /27,/13,/40,/250
PBC1     DATA    /41,/13,/54,/250
PBC2     DATA    /55,/13,/68,/250
PBC3     DATA    /69,/13,/82,/250
PBC4     DATA    /83,/13,/96,/250
PBC5     DATA    /97,/13,/110,/250
PBC6     DATA    /111,/13,/124,/250
PBC7     DATA    /125,/13,/138,/250
PBC8     DATA    /139,/13,/152,/250
PBC9     DATA    /153,/13,/166,/250
PBC10    DATA    /27,/251,/40,/488
PBC11    DATA    /41,/251,/54,/488
PBC12    DATA    /55,/251,/68,/488
PBC13    DATA    /69,/251,/82,/488
PBC14    DATA    /83,/251,/96,/488
PBC15    DATA    /97,/251,/110,/488
PBC16    DATA    /111,/251,/124,/488
PBC17    DATA    /125,/251,/138,/488
PBC18    DATA    /139,/251,/152,/488
PBC19    DATA    /153,/251,/166,/488
PBTitle  STR     "- Directory -"
PBB0Str  STR     "Dial"
PBB1Str  STR     "Cancel"
PBB2Str  STR     "Modify"
PBB3Str  STR     "Load"
PBB4Str  STR     "Set"
         ADJST
*--------------------------------
LdProt   CLR.L   -(SP)
         MOVE.L  #$50524F54,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         MOVE.B  (A0)+,BAUDR+1(A5)
         MOVE.B  (A0)+,DBITS+1(A5)
         MOVE.B  (A0)+,PARITY+1(A5)
         MOVE.B  (A0)+,SBITS+1(A5)
         MOVE.B  (A0)+,DUPLEX+1(A5)
         MOVE.B  (A0)+,LineFd+1(A5)
         MOVE.B  (A0)+,FLXON+1(A5)
UpdProt  MOVE.L  Window1(A5),-(SP)       ; v1.0+
         _SetPort                        ; v1.0+
         BSR     INIPROT
         MOVE    FLXON(A5),D1
         MOVE.B  D1,Lite3(A5)
         MOVE    LineFd(A5),D1
         MOVE.B  D1,Lite4(A5)
         MOVE    DUPLEX(A5),D1
         EOR.B   #1,D1
         MOVE.B  D1,Lite5(A5)
         BSR     SETDPRO
         BSR     DISCR2
         RTS
SvProt   CLR.L   -(SP)
         MOVE.L  #$50524F54,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP),A0
         _HNoPurge
         MOVE.L  (SP),A0
         MOVE.L  (A0),A0
         MOVE.B  BAUDR+1(A5),(A0)+
         MOVE.B  DBITS+1(A5),(A0)+
         MOVE.B  PARITY+1(A5),(A0)+
         MOVE.B  SBITS+1(A5),(A0)+
         MOVE.B  DUPLEX+1(A5),(A0)+
         MOVE.B  LineFd+1(A5),(A0)+
         MOVE.B  FLXON+1(A5),(A0)+
         MOVE.L  (SP),-(SP)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         MOVE.L  (SP)+,A0
         _HPurge
         RTS
*--------------------------------
Protocol MOVE    BAUDR(A5),T.BAUDR(A5)
         MOVE    DBITS(A5),T.DBITS(A5)
         MOVE    PARITY(A5),T.PARITY(A5)
         MOVE    SBITS(A5),T.SBITS(A5)
         MOVE    DUPLEX(A5),T.DUPLEX(A5)
         MOVE    LineFd(A5),T.LineFd(A5)
         MOVE    FLXON(A5),T.FLXON(A5)
         BSR     PROTCL
         CMP.B   #1,MAExit(A5)
         BNE.S   .0
         MOVE    T.BAUDR(A5),BAUDR(A5)
         MOVE    T.DBITS(A5),DBITS(A5)
         MOVE    T.PARITY(A5),PARITY(A5)
         MOVE    T.SBITS(A5),SBITS(A5)
         MOVE    T.DUPLEX(A5),DUPLEX(A5)
         MOVE    T.LineFd(A5),LineFd(A5)
         MOVE    T.FLXON(A5),FLXON(A5)
         BSR     UpdProt
.0       RTS
*--------------------------------
PROTCL   CLR.L   -(SP)
         MOVE    #2,-(SP)
         CLR.L   -(SP)
         MOVE.L  #-1,-(SP)
         _GetNewDialog
         MOVE.L  (SP)+,DialPtr(A5)
         BSR     INICNT
         MOVE.L  DialPtr(A5),-(SP)
         _ShowWindow
MPROLP   CLR.L   -(SP)
         PEA     ItmHit(A5)
         _ModalDialog
         MOVE    ItmHit(A5),D0
         ADD     D0,D0
         MOVE    DITBL(PC,D0),D0
         JMP     DITBL(PC,D0)
DITBL    DATA    /MPROLP-DITBL
         DATA    /PROK-DITBL
         DATA    /PRCAN-DITBL
         DATA    /MPROLP-DITBL
         DATA    /MPROLP-DITBL
         DATA    /MPROLP-DITBL
         DATA    /MPROLP-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRBAUD-DITBL
         DATA    /PRPARIT-DITBL
         DATA    /PRPARIT-DITBL
         DATA    /PRPARIT-DITBL
         DATA    /PRPARIT-DITBL
         DATA    /PRPARIT-DITBL
         DATA    /PRDBITS-DITBL
         DATA    /PRDBITS-DITBL
         DATA    /PRSBITS-DITBL
         DATA    /PRSBITS-DITBL
         DATA    /PRSBITS-DITBL
         DATA    /PRLF-DITBL
         DATA    /PRXON-DITBL
         DATA    /PRDUP-DITBL
PROK     MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         MOVE.B  #1,MAExit(A5)
         RTS
PRCAN    MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         MOVE.B  #2,MAExit(A5)
         RTS
PRBAUD   MOVE    T.BAUDR(A5),D6
         ADD     #7,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #7,D0
         MOVE    D0,T.BAUDR(A5)
         BRA     MPROLP
PRPARIT  MOVE    T.PARITY(A5),D6
         ADD     #13,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #13,D0
         MOVE    D0,T.PARITY(A5)
         BRA     MPROLP
PRDBITS  MOVE    T.DBITS(A5),D6
         ADD     #18,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #18,D0
         MOVE    D0,T.DBITS(A5)
         BRA     MPROLP
PRSBITS  MOVE    T.SBITS(A5),D6
         ADD     #20,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #20,D0
         MOVE    D0,T.SBITS(A5)
         BRA     MPROLP
PRLF     MOVE    T.LineFd(A5),D7
         EOR     #1,D7
         MOVE    D7,T.LineFd(A5)
         MOVE    #23,D6
         BSR     SETVAL
         BRA     MPROLP
PRXON    MOVE    T.FLXON(A5),D7
         EOR     #1,D7
         MOVE    D7,T.FLXON(A5)
         MOVE    #24,D6
         BSR     SETVAL
         BRA     MPROLP
PRDUP    MOVE    T.DUPLEX(A5),D7
         EOR     #1,D7
         MOVE    D7,T.DUPLEX(A5)
         MOVE    #25,D6
         EOR     #1,D7
         BSR     SETVAL
         BRA     MPROLP
INICNT   MOVE    T.BAUDR(A5),D6
         ADD     #7,D6
         BSR     SETCTL
         MOVE    T.PARITY(A5),D6
         ADD     #13,D6
         BSR     SETCTL
         MOVE    T.DBITS(A5),D6
         ADD     #18,D6
         BSR     SETCTL
         MOVE    T.SBITS(A5),D6
         ADD     #20,D6
         BSR     SETCTL
         MOVE    #23,D6
         MOVE    T.LineFd(A5),D7
         BSR     SETVAL
         MOVE    #24,D6
         MOVE    T.FLXON(A5),D7
         BSR     SETVAL
         MOVE    #25,D6
         MOVE    T.DUPLEX(A5),D7
         EOR     #1,D7
         BSR     SETVAL
         RTS
CLRCTL   CLR     D7
         BRA.S   SETVAL
SETCTL   MOVE    #1,D7
SETVAL   MOVE.L  DIALPTR(A5),-(SP)
         MOVE    D6,-(SP)
         PEA     DTYPE(A5)
         PEA     DITEM(A5)
         PEA     DBOX(A5)
         _GetDItem
         MOVE.L  DITEM(A5),-(SP)
         MOVE    D7,-(SP)
         _SetCtlValue
         RTS
*--------------------------------
PHName   CLR.L   -(SP)
         CLR.L   -(SP)
         PEA     PHRect(PC)
         PEA     NullStr(PC)
         MOVE.B  #1,-(SP)
         MOVE    #32,-(SP)
         MOVE.L  #-1,-(SP)
         CLR.B   -(SP)
         CLR.L   -(SP)
         _NewWindow
         MOVE.L  (SP),DialPtr(A5)
         _SetPort
         CLR     -(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         CLR     -(SP)
         _TextFace
         MOVE    #1,-(SP)
         _TextMode
         MOVE    #8,-(SP)
         MOVE    #19,-(SP)
         _MoveTo
         PEA     PHTitle(PC)
         _DrawString
         LEA     PHB0(PC),A2
         BSR     FrBton
         LEA     PHB0Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     PHB1(PC),A2
         BSR     FrBton
         LEA     PHB1Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         LEA     PHCX(PC),A2
         BSR     FrDisp
         LEA     PHC0(PC),A2
         CLR.L   -(SP)
         MOVE.L  A2,-(SP)
         MOVE.L  A2,-(SP)
         _TENew
         MOVE.L  (SP)+,MAhTE(A5)
         MOVE.L  MAhTE(A5),A0
         MOVE.L  (A0),A0
         MOVE    #-1,teCROnly(A0)
         CLR.L   -(SP)
         MOVE.L  #$5048424B,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         CLR.L   D0
         MOVE.B  (A0)+,D0
         MOVE.L  A0,-(SP)
         MOVE.L  D0,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TESetText
         MOVE.L  A2,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEUpdate
         CLR.B   MABTrk(A5)
         CLR.B   MABFl(A5)
         CLR.L   -(SP)
         MOVE.L  #32767,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TESetSelect
         MOVE.L  MAhTE(A5),-(SP)
         _TEActivate
         CLR.B   MAExit(A5)
.0       BSR     PHEvent
         TST.B   MAExit(A5)
         BEQ.S   .0
         MOVE.L  MAhTE(A5),-(SP)
         _TEDeactivate
         CMP.B   #1,MAExit(A5)
         BNE.S   .4
         CLR.L   -(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEGetText
         MOVE.L  (SP),A0
         _GetHandleSize
         CMP.L   #39,D0
         BLS.S   .1
         MOVEQ   #39,D0
.1       MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         LEA     DskNam(A5),A1
         MOVE.B  D0,(A1)+
         BRA.S   .3
.2       MOVE.B  (A0)+,(A1)+
.3       DBRA    D0,.2
.4       MOVE.L  MAhTE(A5),-(SP)
         _TEDispose
         CMP.B   #1,MAExit(A5)
         BNE.S   .5
         CLR.L   -(SP)
         MOVE.L  #$5048424B,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP),A0
         _HNoPurge
         LEA     DskNam(A5),A0
         MOVE.L  (SP),A1
         CLR.L   D0
         MOVE.B  (A0),D0
         ADDQ.L  #1,D0
         _PtrToXHand
         MOVE.L  (SP),-(SP)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         MOVE.L  (SP)+,A0
         _HPurge
.5       MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         RTS
*--------------------------------
PHEvent  _SystemTask
         MOVE.L  MAhTE(A5),-(SP)
         _TEIdle
         CLR.B   -(SP)
         MOVE    #$002F,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   PHRt
         MOVE    What(A5),D0
         ADD     D0,D0
         MOVE    .0(PC,D0),D0
         JMP     .0(PC,D0)
.0       DATA    /PHRt-.0
         DATA    /PHMD-.0
         DATA    /PHMU-.0
         DATA    /PHKD-.0
         DATA    /PHRt-.0
         DATA    /PHKD-.0
PHRt     TST.B   MABTrk(A5)
         BEQ.S   PHBOff
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   PHBOn
PHBOff   TST.B   MABFl(A5)
         BEQ.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         CLR.B   MABFl(A5)
.0       RTS
PHBOn    TST.B   MABFl(A5)
         BNE.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         MOVE.B  #1,MABFl(A5)
.0       RTS
PHMD     CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     PHRect(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .1
         PEA     Where(A5)
         _GlobalToLocal
         LEA     PHB0(PC),A2
         MOVEQ   #0,D7
.0       CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  A2,-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .2
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #3,D7
         BLO.S   .0
.1       MOVE    #4,-(SP)
         _SysBeep
         BRA     PHRt
.2       CMP     #2,D7
         BHS.S   .3
         OR.B    #$80,D7
         MOVE.B  D7,MABTrk(A5)
         MOVE.L  A2,MABPtr(A5)
         BRA     PHRt
.3       MOVE.L  Where(A5),-(SP)
         MOVE    Modify(A5),D0
         BTST    #9,D0
         BNE.S   .4
         CLR.B   -(SP)
         BRA.S   .5
.4       MOVE.B  #1,-(SP)
.5       MOVE.L  MAhTE(A5),-(SP)
         _TEClick
         BRA     PHRt
PHMU     MOVE.B  MABTrk(A5),D7
         BEQ     PHRt
         BSR     PHBOff
         CLR.B   MABTrk(A5)
         PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BEQ     PHRt
         AND.B   #$7F,D7
         ADDQ.B  #1,D7
         MOVE.B  D7,MAExit(A5)
         BRA     PHRt
PHKD     MOVE    Modify(A5),D0
         BTST    #8,D0
         BNE     PHRt
         MOVE.L  Message(A5),D0
         CMP.B   #$03,D0
         BEQ.S   .0
         CMP.B   #$0D,D0
         BNE.S   .1
.0       MOVE.B  #1,MAExit(A5)
         BRA     PHRt
.1       CMP.B   #$09,D0
         BEQ     PHRt
         MOVE    D0,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEKey
         BRA     PHRt
*--------------------------------
PHRect   DATA    /90,/128,/175,/385
PHCX     DATA    /27,/8,/44,/249
PHB0     DATA    /52,/121,/77,/181
PHB1     DATA    /52,/189,/77,/249
PHC0     DATA    /30,/11,/41,/246
PHTitle  STR     "Enter Name:"
PHB0Str  STR     "OK"
PHB1Str  STR     "Cancel"
*--------------------------------
         END
