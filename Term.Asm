;SAVE"Term.Asm"
*--------------------------------
         LIST    ON
*--------------------------------
; Terminal Emulator v1.0
*--------------------------------
         LIST    OFF
*================================
LdTerm   CLR.L   -(SP)
         MOVE.L  #$5445524D,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
CvTerm   LEA     TermDef(A5),A1
.0       MOVE.B  (A0)+,(A1)+
         BNE.S   .0
         BRA     Compl
SvTerm   CLR.L   -(SP)
         MOVE.L  #$5445524D,-(SP)
         MOVE    PBNum(A5),-(SP)
         _GetResource
         MOVE.L  (SP),A0
         _HNoPurge
         LEA     TermDef(A5),A2
.0       TST.B   (A2)+
         BNE.S   .0
         LEA     TermDef(A5),A0
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
Terminal CLR.L   -(SP)
         CLR.L   -(SP)
         PEA     TRRect(PC)
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
         LEA     TRiRect(PC),A2
         LEA     TRTitle(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         CLR     -(SP)
         _TextFace
         LEA     TRB0(PC),A2
         BSR     FrBton
         LEA     TRB0Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     TRB1(PC),A2
         BSR     FrBton
         LEA     TRB1Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     TRB2(PC),A2
         BSR     FrBton
         LEA     TRB2Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     TRB3(PC),A2
         BSR     FrBton
         LEA     TRB3Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         LEA     TRB4(PC),A2
         BSR     FrBton
         LEA     TRB4Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         LEA     TRCX(PC),A2
         BSR     FrDisp
         LEA     TRC0(PC),A2
         CLR.L   -(SP)
         MOVE.L  A2,-(SP)
         MOVE.L  A2,-(SP)
         _TENew
         MOVE.L  (SP)+,MAhTE(A5)
         MOVE.L  MAhTE(A5),A0
         MOVE.L  (A0),A0
         LEA     WdBrk(PC),A1
         MOVE.L  A1,teWordBreak(A0)
         LEA     TermDef(A5),A0
         MOVE.L  A0,-(SP)
         CLR.L   D0
.0       TST.B   (A0)+
         BEQ.S   .1
         ADDQ.L  #1,D0
         BRA.S   .0
.1       MOVE.L  D0,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TESetText
         MOVE.L  A2,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEUpdate
         CLR.B   MABTrk(A5)
         CLR.B   MABFl(A5)
         MOVE.L  MAhTE(A5),-(SP)
         _TEActivate
         CLR.B   MAExit(A5)
.2       BSR     TREvent
         TST.B   MAExit(A5)
         BEQ.S   .2
         MOVE.L  MAhTE(A5),-(SP)
         _TEDeactivate
         CMP.B   #1,MAExit(A5)
         BNE.S   .6
         CLR.L   -(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEGetText
         MOVE.L  (SP),A0
         _GetHandleSize
         CMP.L   #1023,D0
         BLS.S   .3
         MOVE    #1023,D0
.3       MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         LEA     TermDef(A5),A1
         BRA.S   .5
.4       MOVE.B  (A0)+,(A1)+
.5       DBRA    D0,.4
         CLR.B   (A1)
.6       MOVE.L  MAhTE(A5),-(SP)
         _TEDispose
         CMP.B   #1,MAExit(A5)
         BNE.S   .7
         BSR     Compl
.7       MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         RTS
*--------------------------------
TREvent  _SystemTask
         MOVE.L  MAhTE(A5),-(SP)
         _TEIdle
         CLR.B   -(SP)
         MOVE    #$012F,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   TRRt
         MOVE    What(A5),D0
         ADD     D0,D0
         MOVE    .0(PC,D0),D0
         JMP     .0(PC,D0)
.0       DATA    /TRRt-.0
         DATA    /TRMD-.0
         DATA    /TRMU-.0
         DATA    /TRKD-.0
         DATA    /TRRt-.0
         DATA    /TRKD-.0
         DATA    /TRRt-.0
         DATA    /TRRt-.0
         DATA    /TRAC-.0
TRAC     BSR     Active
TRRt     TST.B   MABTrk(A5)
         BEQ.S   TRBOff
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   TRBOn
TRBOff   TST.B   MABFl(A5)
         BEQ.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         CLR.B   MABFl(A5)
.0       RTS
TRBOn    TST.B   MABFl(A5)
         BNE.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     BInvert
         MOVE.B  #1,MABFl(A5)
.0       RTS
TRMD     CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     TRRect(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .1
         PEA     Where(A5)
         _GlobalToLocal
         LEA     TRB0(PC),A2
         MOVEQ   #0,D7
.0       CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  A2,-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .2
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #6,D7
         BLO.S   .0
.1       MOVE    #4,-(SP)
         _SysBeep
         BRA     TRRt
.2       CMP     #5,D7
         BHS.S   .3
         OR.B    #$80,D7
         MOVE.B  D7,MABTrk(A5)
         MOVE.L  A2,MABPtr(A5)
         BRA     TRRt
.3       MOVE.L  Where(A5),-(SP)
         MOVE    Modify(A5),D0
         BTST    #9,D0
         BNE.S   .4
         CLR.B   -(SP)
         BRA.S   .5
.4       MOVE.B  #1,-(SP)
.5       MOVE.L  MAhTE(A5),-(SP)
         _TEClick
         BRA     TRRt
TRMU     MOVE.B  MABTrk(A5),D7
         BEQ     TRRt
         BSR     TRBOff
         CLR.B   MABTrk(A5)
         PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BEQ     TRRt
         AND.B   #$7F,D7
         BNE.S   .0
         MOVE.B  #1,MAExit(A5)
         BRA     TRRt
.0       CMP.B   #1,D7
         BNE.S   .1
         MOVE.B  #2,MAExit(A5)
         BRA     TRRt
.1       CMP.B   #2,D7
         BNE.S   .2
         MOVE.L  MAhTE(A5),-(SP)
         _TECut
         BRA     TRRt
.2       CMP.B   #3,D7
         BNE.S   .3
         MOVE.L  MAhTE(A5),-(SP)
         _TECopy
         BRA     TRRt
.3       MOVE.L  MAhTE(A5),-(SP)
         _TEPaste
         BRA     TRRt
TRKD     MOVE    Modify(A5),D0
         BTST    #8,D0
         BNE     TRRt
         MOVE.L  Message(A5),D0
         CMP.B   #$03,D0
         BEQ.S   .0
         CMP.B   #$0D,D0
         BNE.S   .1
.0       MOVE.B  #1,MAExit(A5)
         BRA     TRRt
.1       CMP.B   #$09,D0
         BEQ     TRRt
         MOVE    D0,-(SP)
         MOVE.L  MAhTE(A5),-(SP)
         _TEKey
         BRA     TRRt
WdBrk    CMP.B   #' ,0(A0,D0)
         BLS.S   .0
         CMP.B   #':,0(A0,D0)
         BNE.S   .1
.0       MOVE.B  #1,D0
         RTS
.1       CLR.B   D0
         RTS
*--------------------------------
TRRect   DATA    /27,/7,/231,/505
TRiRect  DATA    /0,/0,/25,/498
TRCX     DATA    /25,/9,/163,/490
TRB0     DATA    /171,/362,/196,/422
TRB1     DATA    /171,/430,/196,/490
TRB2     DATA    /171,/9,/196,/69
TRB3     DATA    /171,/77,/196,/137
TRB4     DATA    /171,/145,/196,/205
TRC0     DATA    /28,/12,/160,/487
TRTitle  STR     "- Terminal Emulator -"
TRB0Str  STR     "OK"
TRB1Str  STR     "Cancel"
TRB2Str  STR     "Cut"
TRB3Str  STR     "Copy"
TRB4Str  STR     "Paste"
*--------------------------------
TermDefX ASC     "TTY:bl=^G:bs=^H:ht=^I:lf=^J:ff=^L:cr=^M:"
         ASC     "ke=^M:kc=^L:kl=^H:kr=^I:ku=^J:kd=^J:"
         ASC     "k8=^Q:k9=^S:"
         ASC     "l0=F0:l1=F1:l2=F2:l3=F3:"
         ASC     "l4=F4:l5=F5:l6=F6:l7=F7:l8=Xon:l9=Xoff"
         HEX     00
         ADJST
*--------------------------------
Compl    LEA     TermDef(A5),A0
         LEA     TermLstI(A5),A1
         LEA     TermLstO(A5),A2
         LEA     TermLstF(A5),A3
         CLR     D5
         CLR     D6
         CLR     D7
         CLR     CMYX(A5)
         CLR     CMO0(A5)
         CLR     CMO1(A5)
         CLR     TermIM(A5)
.0       MOVE.B  (A0)+,D0
         BEQ     .11
         CMP.B   #':,D0
         BNE.S   .0
.1       CLR     D4
         MOVE.B  (A0)+,D0
         BEQ     .11
         LSL     #8,D0
         MOVE.B  (A0)+,D0
         BEQ     .11
         LEA     TCTbl(PC),A4
         MOVEQ   #0,D1
.2       CMP     (A4)+,D0
         BEQ.S   .4
         ADDQ    #1,D1
         CMP     #53,D1
         BLO.S   .2
.3       MOVEM.L A0-A3,-(SP)
         MOVE    #4,-(SP)
         _SysBeep
         MOVEM.L (SP)+,A0-A3
         BRA.S   .0
.4       MOVE.B  (A0)+,D0
         BEQ     .11
         CMP.B   #'=,D0
         BNE.S   .3
         CMP     #24,D1
         BHS.S   .7
         CMP     #510,D5
         BHS.S   .3
         MOVE.B  D1,(A1)+
         MOVE.L  A1,A4
         CLR.B   (A1)+
         ADDQ    #2,D5
.5       BSR     Comp1B
         TST     D1
         BNE.S   .6
         CMP     #511,D5
         BHS.S   .3
         CMP.B   #127,(A4)
         BHS.S   .3
         MOVE.B  D0,(A1)+
         ADDQ.B  #1,(A4)
         ADDQ    #1,D5
         BRA.S   .5
.6       CMP     #1,D1
         BEQ.S   .1
         BRA     .11
.7       CMP     #33,D1
         BHS.S   .9
         SUB     #24,D1
         CMP     #254,D6
         BHS.S   .3
         LEA     CChrTbl(PC),A4
         MOVE.B  0(A4,D1),(A2)+
         MOVE.L  A2,A4
         CLR.B   (A2)+
         ADDQ    #2,D6
.8       BSR     Comp1B
         TST     D1
         BNE.S   .6
         CMP     #255,D6
         BHS     .3
         CMP.B   #127,(A4)
         BHS     .3
         MOVE.B  D0,(A2)+
         ADDQ.B  #1,(A4)
         ADDQ    #1,D6
         BRA.S   .8
.9       SUB     #33,D1
         CMP     #510,D7
         BHS     .3
         MOVE.B  D1,(A3)+
         MOVE.L  A3,A4
         CLR.B   (A3)+
         ADDQ    #2,D7
.10      BSR     Comp1B
         TST     D1
         BNE.S   .6
         CMP     #511,D7
         BHS     .3
         CMP.B   #127,(A4)
         BHS     .3
         MOVE.B  D0,(A3)+
         ADDQ.B  #1,(A4)
         ADDQ    #1,D7
         BRA.S   .10
.11      MOVE.B  #$FF,(A1)
         MOVE.B  #$FF,(A2)
         MOVE.B  #$FF,(A3)
         RTS
CChrTbl  HEX     0308090D1B1C1D1E1F
         ADJST
TCTbl    ASC     "nublbshtlfffcrnlupdnrtlthovphpcmcsclicdcimeiildl"
         ASC     "kekbktkskcklkrkukd"
         ASC     "k0k1k2k3k4k5k6k7k8k9l0l1l2l3l4l5l6l7l8l9"
Comp1B   MOVE.B  (A0)+,D0
         BEQ     .15
         CMP.B   #'\,D0
         BNE.S   .0
         MOVEQ   #$1B,D0
         BRA     .14
.0       CMP.B   #'^,D0
         BNE.S   .4
         MOVE.B  (A0),D1
         BEQ     .14
         CMP.B   #$7F,D1
         BHI     .14
         CMP.B   #$60,D1
         BLO.S   .1
         AND.B   #$5F,D1
.1       CMP.B   #$3F,D1
         BLO     .14
         BNE.S   .2
         MOVEQ   #$7F,D1
         BRA.S   .3
.2       AND.B   #$3F,D1
.3       MOVE.B  D1,D0
         ADDQ.L  #1,A0
         BRA     .14
.4       CMP.B   #'%,D0
         BNE     .13
         MOVE.B  (A0)+,D0
         BEQ     .15
         CMP.B   #'r,D0
         BNE.S   .5
         MOVE    #1,CMYX(A5)
         BRA.S   Comp1B
.5       CMP.B   #'i,D0
         BNE.S   .6
         MOVE    #1,CMO0(A5)
         MOVE    #1,CMO1(A5)
         BRA.S   Comp1B
.6       CMP.B   #'b,D0
         BNE.S   .61
         MOVE.B  #$FD,D0
         BRA     .14
.61      CMP.B   #'.,D0
         BNE.S   .7
         MOVE.B  #$FE,D0
         BRA     .14
.7       CMP.B   #'+,D0
         BNE.S   .11
         CLR     D0
         MOVE.B  (A0)+,D0
         BEQ     .15
         TST     D4
         BNE.S   .8
         MOVE    D0,CMO0(A5)
         BRA.S   .9
.8       CMP     #1,D4
         BNE.S   .10
         MOVE    D0,CMO1(A5)
.9       ADDQ    #1,D4
.10      MOVE.B  #$FE,D0
         BRA.S   .14
.11      CMP.B   #'#,D0
         BNE.S   .12
         MOVE.B  #$FF,D0
         BRA.S   .14
.12      CMP.B   #'$,D0
         BNE.S   .14
         MOVE.B  (A0)+,D0
         BEQ.S   .15
         AND     #7,D0
         LSL     #3,D0
         MOVE.B  (A0)+,D1
         BEQ.S   .15
         AND     #7,D1
         OR      D1,D0
         LSL     #3,D0
         MOVE.B  (A0)+,D1
         BEQ.S   .15
         AND     #7,D1
         OR      D1,D0
         BRA.S   .14
.13      CMP.B   #':,D0
         BNE.S   .14
         MOVEQ   #1,D1
         RTS
.14      MOVEQ   #0,D1
         RTS
.15      MOVEQ   #2,D1
         RTS
*--------------------------------
LNRect   DATA    /276,/0,/278,/502
DLine    PEA     LNRect(PC)
         _PaintRect
         RTS
*--------------------------------
F0Rect   DATA    /282,/17,/295,/62
F1Rect   DATA    /282,/64,/295,/109
F2Rect   DATA    /282,/111,/295,/156
F3Rect   DATA    /282,/158,/295,/203
F4Rect   DATA    /282,/205,/295,/250
F5Rect   DATA    /282,/252,/295,/297
F6Rect   DATA    /282,/299,/295,/344
F7Rect   DATA    /282,/346,/295,/391
F8Rect   DATA    /282,/393,/295,/438
F9Rect   DATA    /282,/440,/295,/485
*--------------------------------
DispKeys LEA     F0Rect(PC),A2
         MOVEQ   #10,D3
.0       LEA     TermLstF(A5),A3
         CLR     D0
.1       CMP.B   #$FF,(A3)
         BEQ.S   .2
         CMP.B   (A3)+,D3
         BEQ.S   .3
         MOVE.B  (A3)+,D0
         ADD     D0,A3
         BRA.S   .1
.2       LEA     NullStr(PC),A3
.3       BSR     DrawKey
         ADDQ.L  #8,A2
         ADDQ.B  #1,D3
         CMP.B   #20,D3
         BLO.S   .0
         CLR.B   MABTrk(A5)
         CLR.B   MABFl(A5)
         RTS
*--------------------------------
* A2=Rect, A3=Str
*--------------------------------
DrawKey  LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         _PenNormal
         PEA     -8(A6)
         _FrameRect
         PEA     -8(A6)
         MOVE.L  #$00010001,-(SP)
         _InsetRect
         PEA     -8(A6)
         _EraseRect
         CLR.L   -(SP)
         _NewRgn
         MOVE.L  (SP),A4
         _GetClip
         PEA     -8(A6)
         _ClipRect
         CLR     D1
         MOVE.B  (A3),D1
         BEQ.S   .1
         CMP     #7,D1
         BLS.S   .0
         MOVEQ   #7,D1
.0       MULU    #6,D1
         SUBQ    #1,D1
         MOVE    -2(A6),D0
         SUB     -6(A6),D0
         SUB     D1,D0
         ASR     #1,D0
         ADD     -6(A6),D0
         MOVE    D0,-(SP)
         MOVE    -8(A6),-(SP)
         ADD     #9,(SP)
         _MoveTo
         MOVE.L  A3,-(SP)
         _DrawString
.1       MOVE.L  A4,-(SP)
         _SetClip
         MOVE.L  A4,-(SP)
         _DisposRgn
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
FInvert  LINK    A6,#-8
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
INITXT   MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         MOVE    #0,-(SP)
         _TextFace
         MOVE    #1,-(SP)
         _TextMode
         RTS
INITSC   CLR.L   -(SP)
         MOVE    #128,-(SP)
         CLR.L   -(SP)
         MOVE.L  #-1,-(SP)
         _GetNewWindow
         MOVE.L  (SP)+,Window1(A5)
         CLR.B   FlAct(A5)
         CLR.L   -(SP)
         _NewRgn
         MOVE.L  (SP)+,Region1(A5)
         LEA     Screen2(A5),A0
         MOVE.L  #$20202020,D0
         MOVE    #80/4-1,D1
.0       MOVE.L  D0,(A0)+
         DBRA    D1,.0
INTSC    MOVE.L  Window1(A5),-(SP)
         _SetPort
         BSR     INITXT
         BSR     DLine
         CLR.B   FlCrs(A5)
         MOVE.L  Ticks,CrsTime(A5)
         CLR     QCnt(A5)
         BRA     DoFF
OUTCH    MOVEM.L D0-D7/A0-A3,-(SP)
         CMP     #32,QCnt(A5)
         BLO.S   .0
         CLR     QCnt(A5)
.0       LEA     TermQ(A5),A0
         MOVE    QCnt(A5),D1
         MOVE.B  D0,0(A0,D1)
         ADDQ    #1,QCnt(A5)
.1       LEA     TermLstI(A5),A1
         CLR     D6
         CLR     D7
.2       LEA     TermQ(A5),A0
         MOVE    QCnt(A5),D1
         MOVE.B  (A1)+,D6
         BMI     .12
         CLR     D2
         MOVE.B  (A1)+,D2
         BEQ.S   .2
         MOVE.L  A1,A2
         ADD     D2,A2
         CLR     PARAM0(A5)
         CLR     PARAM1(A5)
         CLR     D5
.3       CMP.B   #$FD,(A1)
         BNE.S   .31
         CLR     D3
         MOVE.B  (A0)+,D3
         MOVE    D3,D0
         AND.B   #$0F,D3
         LSR.B   #4,D0
         AND.B   #$07,D0
         ADD.B   .39(PC,D0),D3
         SUBQ    #1,D1
         BRA.S   .6
.39      DATA    #00,#10,#20,#30,#40,#50,#60,#70
.31      CMP.B   #$FE,(A1)
         BLO.S   .8
         BHI.S   .4
         CLR     D3
         MOVE.B  (A0)+,D3
         SUBQ    #1,D1
         BRA.S   .6
.4       CLR     D3
.5       MOVE.B  (A0),D0
         CMP.B   #'0,D0
         BLO.S   .6
         CMP.B   #'9,D0
         BHI.S   .6
         AND     #$0F,D0
         MOVE    D3,-(SP)
         LSL     #2,D3
         ADD     (SP)+,D3
         ADD     D3,D3
         ADD     D0,D3
         ADDQ.L  #1,A0
         SUBQ    #1,D1
         BNE.S   .5
         BRA.S   .10
.6       ADDQ.L  #1,A1
         LEA     PARAM0(A5),A3
         MOVE    D3,0(A3,D5)
         CMP     #10,D5
         BEQ.S   .9
         ADDQ    #2,D5
         BRA.S   .9
.8       CMP.B   (A0)+,(A1)+
         BNE.S   .11
         SUBQ    #1,D1
.9       SUBQ    #1,D2
         BEQ.S   .15
         TST     D1
         BNE.S   .3
.10      MOVEQ   #1,D7
.11      MOVE.L  A2,A1
         BRA     .2
.12      TST     D7
         BNE.S   .18
         BSR     OUTPLT
         SUBQ    #1,QCnt(A5)
         BEQ.S   .18
         LEA     TermQ(A5),A0
         MOVE    QCnt(A5),D0
         BRA.S   .14
.13      MOVE.B  1(A0),(A0)+
.14      DBRA    D0,.13
         BRA     .1
.15      LEA     TermQ(A5),A0
         MOVE    QCnt(A5),D0
         MOVE    D1,QCnt(A5)
         SUB     D1,D0
         BRA.S   .17
.16      MOVE.B  0(A0,D0),(A0)+
.17      DBRA    D1,.16
         BSR     OffCrs
         MOVE.L  Ticks,CrsTime(A5)
         ADD     D6,D6
         MOVE    TermTbl(PC,D6),D0
         JSR     DoBL(PC,D0)
         TST     QCnt(A5)
         BNE     .1
.18      MOVEM.L (SP)+,D0-D7/A0-A3
         RTS
TermTbl  DATA    /DoNU-DoBL
         DATA    /DoBL-DoBL
         DATA    /DoBS-DoBL
         DATA    /DoHT-DoBL
         DATA    /DoLF-DoBL
         DATA    /DoFF-DoBL
         DATA    /DoCR-DoBL
         DATA    /DoNL-DoBL
         DATA    /DoUP-DoBL
         DATA    /DoDN-DoBL
         DATA    /DoRT-DoBL
         DATA    /DoLT-DoBL
         DATA    /DoHO-DoBL
         DATA    /DoVP-DoBL
         DATA    /DoHP-DoBL
         DATA    /DoCM-DoBL
         DATA    /DoCS-DoBL
         DATA    /DoCL-DoBL
         DATA    /DoIC-DoBL
         DATA    /DoDC-DoBL
         DATA    /DoIM-DoBL
         DATA    /DoEI-DoBL
         DATA    /DoIL-DoBL
         DATA    /DoDL-DoBL
DoBL     MOVE    #4,-(SP)
         _SysBeep
DoNU     RTS
DoBS     TST     ColCrs(A5)
         BEQ.S   .0
         SUBQ    #1,ColCrs(A5)
         BRA.S   .1
.0       TST     RowCrs(A5)
         BEQ.S   .2
         MOVE    #79,ColCrs(A5)
         SUBQ    #1,RowCrs(A5)
.1       TST     TermIM(A5)
         BEQ.S   .2
         BSR     DoDC
.2       RTS
DoHT     MOVEQ   #$09,D0
         BSR     Save1B
         ADDQ    #8,ColCrs(A5)
         AND     #$FFF8,ColCrs(A5)
         CMP     #80,ColCrs(A5)
         BLO.S   .0
         CLR     ColCrs(A5)
         BSR     NwLn
.0       RTS
OUTPLT   MOVE.B  TermQ(A5),D0
         BSR     Save1B
         TST.B   D0
         BEQ.S   LORT
         CMP.B   #$D9,D0
         BHS.S   LORT
         BSR     OffCrs
         MOVE.L  Ticks,CrsTime(A5)
         TST     TermIM(A5)
         BEQ.S   .0
         BSR     DoIC
.0       BSR     LOCATE
         LEA     Screen(A5),A0
         MOVE    RowCrs(A5),D0
         MULU    #80,D0
         ADD     ColCrs(A5),D0
         ADD     D0,A0
         CMP.B   #$20,(A0)
         BEQ.S   .1
         BSR     ERACHR
.1       MOVE.B  TermQ(A5),(A0)
         MOVE    PosX(A5),-(SP)
         MOVE    PosY(A5),-(SP)
         _MoveTo
         MOVE.B  TermQ(A5),D0
         MOVE    D0,-(SP)
         _DrawChar
         ADDQ    #1,ColCrs(A5)
         CMP     #80,ColCrs(A5)
         BLO.S   LORT
         CLR     ColCrs(A5)
NwLn     ADDQ    #1,RowCrs(A5)
         CMP     #24,RowCrs(A5)
         BLO.S   LORT
         BSR     SCROLL
         MOVE    #23,RowCrs(A5)
LORT     RTS
DoLF     TST     LineFd(A5)
         BEQ.S   NwLn
         RTS
DoCR     MOVEQ   #$0D,D0
         BSR     Save1B
         CLR     ColCrs(A5)
         TST     LineFd(A5)
         BNE.S   NwLn
         RTS
DoNL     MOVEQ   #$0D,D0
         BSR     Save1B
         CLR     ColCrs(A5)
         BRA.S   NwLn
ClsRect  DATA    /8,/11,/272,/491
DoFF     MOVEQ   #$0D,D0
         BSR     Save1B
         LEA     Screen(A5),A0
         MOVE.L  #$20202020,D0
         MOVE    #1920/4-1,D1
.0       MOVE.L  D0,(A0)+
         DBRA    D1,.0
         PEA     ClsRect(PC)
         _EraseRect
DoHO     CLR     RowCrs(A5)
         CLR     ColCrs(A5)
         RTS
DoUP     SUBQ    #1,RowCrs(A5)
         BPL.S   .0
         MOVE    #23,RowCrs(A5)
.0       RTS
DoDN     ADDQ    #1,RowCrs(A5)
         CMP     #24,RowCrs(A5)
         BLO.S   .0
         CLR     RowCrs(A5)
.0       RTS
DoRT     ADDQ    #1,ColCrs(A5)
         CMP     #80,ColCrs(A5)
         BLO.S   .0
         CLR     ColCrs(A5)
.0       RTS
DoLT     SUBQ    #1,ColCrs(A5)
         BPL.S   .0
         MOVE    #79,ColCrs(A5)
.0       RTS
DoVP     MOVEQ   #$0D,D0
         BSR     Save1B
         MOVE    PARAM0(A5),D0
         AND     #$001F,D0
         CMP     #24,D0
         BLO.S   .0
         CLR     D0
.0       MOVE    D0,RowCrs(A5)
         RTS
DoHP     MOVEQ   #$0D,D0
         BSR     Save1B
         MOVE    PARAM0(A5),D0
         CMP     #80,D0
         BLO.S   .0
         CLR     D0
.0       MOVE    D0,ColCrs(A5)
         RTS
DoCM     MOVEQ   #$0D,D0
         BSR     Save1B
         MOVE    PARAM0(A5),D0
         MOVE    PARAM1(A5),D1
         SUB     CMO0(A5),D0
         SUB     CMO1(A5),D1
         TST     CMYX(A5)
         BEQ.S   .0
         EXG     D0,D1
.0       AND     #$001F,D0
         CMP     #24,D0
         BLO.S   .1
         CLR     D0
.1       CMP     #80,D1
         BLO.S   .2
         CLR     D1
.2       MOVE    D0,RowCrs(A5)
         MOVE    D1,ColCrs(A5)
         RTS
DoCS     BSR     DoCL
         MOVE    RowCrs(A5),D7
         CMP     #23,D7
         BHS.S   .2
         ADDQ    #1,D7
         LEA     Screen(A5),A0
         MOVE    D7,D0
         MULU    #80,D0
         ADD     D0,A0
         MOVE.L  #$20202020,D0
         MOVEQ   #24,D1
         SUB     D7,D1
         MULU    #80/4,D1
         BRA.S   .1
.0       MOVE.L  D0,(A0)+
.1       DBRA    D1,.0
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         MOVE    #11,Rect+2(A5)
         MOVE    #272,Rect+4(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         _EraseRect
.2       RTS
DoCL     MOVE    RowCrs(A5),D7
         MOVE    ColCrs(A5),D6
         LEA     Screen(A5),A0
         MOVE    D7,D0
         MULU    #80,D0
         ADD     D6,D0
         ADD     D0,A0
         MOVEQ   #$20,D0
         MOVEQ   #79,D1
         SUB     D6,D1
.0       MOVE.B  D0,(A0)+
         DBRA    D1,.0
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         ADD     #11,D7
         MOVE    D7,Rect+4(A5)
         MULU    #6,D6
         ADD     #11,D6
         MOVE    D6,Rect+2(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         _EraseRect
         RTS
DoIC     MOVE    RowCrs(A5),D7
         MOVE    ColCrs(A5),D6
         LEA     Screen(A5),A0
         MOVE    D7,D0
         MULU    #80,D0
         ADD     D6,D0
         ADD     D0,A0
         MOVEQ   #$20,D0
         MOVEQ   #79,D2
         SUB     D6,D2
.0       MOVE.B  (A0),D1
         MOVE.B  D0,(A0)+
         MOVE.B  D1,D0
         DBRA    D2,.0
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         ADD     #11,D7
         MOVE    D7,Rect+4(A5)
         MULU    #6,D6
         ADD     #11,D6
         MOVE    D6,Rect+2(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         MOVE    #6,-(SP)
         CLR     -(SP)
         MOVE.L  Region1(A5),-(SP)
         _ScrollRect
         RTS
DoDC     MOVE    RowCrs(A5),D7
         MOVE    ColCrs(A5),D6
         LEA     Screen(A5),A0
         MOVE    D7,D0
         MULU    #80,D0
         ADD     D6,D0
         ADD     D0,A0
         MOVEQ   #79,D1
         SUB     D6,D1
         BRA.S   .1
.0       MOVE.B  1(A0),(A0)+
.1       DBRA    D1,.0
         MOVE.B  #$20,(A0)
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         ADD     #11,D7
         MOVE    D7,Rect+4(A5)
         MULU    #6,D6
         ADD     #11,D6
         MOVE    D6,Rect+2(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         MOVE    #-6,-(SP)
         CLR     -(SP)
         MOVE.L  Region1(A5),-(SP)
         _ScrollRect
         RTS
DoIM     MOVE    #1,TermIM(A5)
         RTS
DoEI     CLR     TermIM(A5)
         RTS
DoIL     CLR     ColCrs(A5)
         MOVE    RowCrs(A5),D7
         LEA     Screen+1920(A5),A0
         MOVEQ   #23,D1
         SUB     D7,D1
         MULU    #80/4,D1
         BRA.S   .1
.0       MOVE.L  -84(A0),-(A0)
.1       DBRA    D1,.0
         MOVE.L  #$20202020,D0
         MOVEQ   #80/4-1,D1
.2       MOVE.L  D0,-(A0)
         DBRA    D1,.2
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         MOVE    #11,Rect+2(A5)
         MOVE    #272,Rect+4(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         CLR     -(SP)
         MOVE    #11,-(SP)
         MOVE.L  Region1(A5),-(SP)
         _ScrollRect
         RTS
DoDL     CLR     ColCrs(A5)
         MOVE    RowCrs(A5),D7
         LEA     Screen(A5),A0
         MOVE    D7,D0
         MULU    #80,D0
         ADD     D0,A0
         MOVEQ   #23,D1
         SUB     D7,D1
         MULU    #80/4,D1
         BRA.S   .1
.0       MOVE.L  80(A0),(A0)+
.1       DBRA    D1,.0
         MOVE.L  #$20202020,D0
         MOVEQ   #80/4-1,D1
.2       MOVE.L  D0,(A0)+
         DBRA    D1,.2
         MULU    #11,D7
         ADDQ    #8,D7
         MOVE    D7,Rect(A5)
         MOVE    #11,Rect+2(A5)
         MOVE    #272,Rect+4(A5)
         MOVE    #491,Rect+6(A5)
         PEA     Rect(A5)
         CLR     -(SP)
         MOVE    #-11,-(SP)
         MOVE.L  Region1(A5),-(SP)
         _ScrollRect
         RTS
*--------------------------------
LOCATE   MOVE    ColCrs(A5),D0
         MULU    #6,D0
         ADD     #11,D0
         MOVE    D0,PosX(A5)
         MOVE    RowCrs(A5),D0
         MULU    #11,D0
         ADD     #17,D0
         MOVE    D0,PosY(A5)
         RTS
ERACHR   MOVE.L  A0,-(SP)
         MOVE    PosY(A5),D0
         SUB     #9,D0
         MOVE    D0,Rect(A5)
         ADD     #11,D0
         MOVE    D0,Rect+4(A5)
         MOVE    PosX(A5),D0
         MOVE    D0,Rect+2(A5)
         ADDQ    #6,D0
         MOVE    D0,Rect+6(A5)
         PEA     Rect(A5)
         _EraseRect
         MOVE.L  (SP)+,A0
         RTS
INVCRS   BSR     LOCATE
         MOVE    PosY(A5),D0
         MOVE    D0,Rect(A5)
         ADDQ    #1,D0
         MOVE    D0,Rect+4(A5)
         MOVE    PosX(A5),D0
         SUBQ    #1,D0
         MOVE    D0,Rect+2(A5)
         ADDQ    #7,D0
         MOVE    D0,Rect+6(A5)
         PEA     Rect(A5)
         _InverRect
         RTS
ONCRS    TST.B   FlAct(A5)
         BEQ.S   .0
         TST.B   FlCrs(A5)
         BNE.S   .0
         BSR     INVCRS
         MOVE.B  #1,FlCrs(A5)
.0       RTS
OFFCRS   TST.B   FlAct(A5)
         BEQ.S   .0
         TST.B   FlCrs(A5)
         BEQ.S   .0
         BSR     INVCRS
         CLR.B   FlCrs(A5)
.0       RTS
SCROLL   LEA     Screen(A5),A0
         MOVE    #80*23/4-1,D1
.0       MOVE.L  80(A0),(A0)+
         DBRA    D1,.0
         MOVE.L  #$20202020,D0
         MOVE    #80/4-1,D1
.1       MOVE.L  D0,(A0)+
         DBRA    D1,.1
         PEA     ClsRect(PC)
         MOVE    #0,-(SP)
         MOVE    #-11,-(SP)
         MOVE.L  Region1(A5),-(SP)
         _ScrollRect
         RTS
*--------------------------------
         END
