;SAVE"Telescape.Asm"
*--------------------------------
; Telescape v1.0+      (09/10/87)
*--------------------------------
         LIST    OFF
*--------------------------------
         INCLUDE ":Sources:Library.Asm"
         INCLUDE ":Sources:Equates.Asm"
*--------------------------------
NUL      EQU     $00
SOH      EQU     $01
STX      EQU     $02
ETX      EQU     $03
EOT      EQU     $04
ENQ      EQU     $05
ACK      EQU     $06
BEL      EQU     $07
BS       EQU     $08
HT       EQU     $09
LF       EQU     $0A
VT       EQU     $0B
FF       EQU     $0C
CR       EQU     $0D
SO       EQU     $0E
SI       EQU     $0F
DLE      EQU     $10
DC1      EQU     $11
DC2      EQU     $12
DC3      EQU     $13
DC4      EQU     $14
NAK      EQU     $15
SYN      EQU     $16
ETB      EQU     $17
CAN      EQU     $18
EM       EQU     $19
SUB      EQU     $1A
ESC      EQU     $1B
FS       EQU     $1C
GS       EQU     $1D
RS       EQU     $1E
US       EQU     $1F
DEL      EQU     $7F
*--------------------------------
TYPTXT           EQU  $54455854
CREAT            EQU  $54454C45
XDLE             EQU  $90
;
Good             EQU  0
Copy             EQU  1
fType            EQU  2
vRefNum          EQU  6
version          EQU  8
fName            EQU  10
RefNum           EQU  74
;
TempRect         EQU  $9FA
TEWdBreak        EQU  $0AF6
*--------------------------------
; Application Globals
*--------------------------------
         GLOBAL  11628
;
MesBuf           DEFS 2048
Screen           DEFS 1920
Screen2          DEFS 80
SavBuffer        DEFS 1024
LodBuffer        DEFS 1024
BUFCOM           DEFS 1024
TermDef          DEFS 1024
Macro            DEFS 810
TermLstI         DEFS 512
TermLstO         DEFS 256
TermLstF         DEFS 512
XBuf             DEFS 128
ParaBlk          DEFS 80
SFRPut           DEFS 74+2
SFRGet           DEFS 74+2
TmpNam           DEFS 64
ClpNam           DEFS 64
PARCOM           DEFS 50
MacroTbl         DEFS 40
DskNam           DEFS 40
EVENTRECORD      DEFS 0
What             DEFS W
Message          DEFS L
When             DEFS L
Where            DEFS L
Modify           DEFS W
DTYPE            DEFS W
DITEM            DEFS L
DBOX             DEFS 8
CHQ              DEFS 128
CHQCnt           DEFS W
TermQ            DEFS 32
QCnt             DEFS W
TermIM           DEFS W
CMYX             DEFS W
CMO0             DEFS W
CMO1             DEFS W
ShStr            DEFS 16
hTE0             DEFS L
hTE1             DEFS L
hTE2             DEFS L
hTE3             DEFS L
hTE4             DEFS L
hTE5             DEFS L
hTE6             DEFS L
hTE7             DEFS L
hTE8             DEFS L
hTE9             DEFS L
DialPtr          DEFS L
;
Type             DEFS L
Creator          DEFS L
Flags            DEFS W
Location         DEFS L
Folder           DEFS W
Locked           DEFS W
DataLen          DEFS L
RsrcLen          DEFS L
FlCrDat          DEFS L
FlMdDat          DEFS L
Length           DEFS L
;
BAUDR            DEFS W
DBITS            DEFS W
PARITY           DEFS W
SBITS            DEFS W
DUPLEX           DEFS W
LineFd           DEFS W
FLXON            DEFS W
T.BAUDR          DEFS W
T.DBITS          DEFS W
T.PARITY         DEFS W
T.SBITS          DEFS W
T.DUPLEX         DEFS W
T.LineFd         DEFS W
T.FLXON          DEFS W
SMODE            DEFS W
MODE             DEFS W
TmOut            DEFS W
CPace            DEFS L
LPace            DEFS L
Prompt           DEFS B
T.Prompt         DEFS B
T.MODE           DEFS W
T.TmOut          DEFS W
T.CPace          DEFS L
T.LPace          DEFS L
Port             DEFS W
T.Port           DEFS W
WWINDOW          DEFS L
MENU             DEFS W
MENUITM          DEFS W
ITMHIT           DEFS W
REFCIN           DEFS W
REFCOUT          DEFS W
Window1          DEFS L
Region1          DEFS L
RowCrs           DEFS W
ColCrs           DEFS W
PosY             DEFS W
PosX             DEFS W
CrsTime          DEFS L
LiteTime         DEFS L
TEMPCH           DEFS W
PARPTR           DEFS W
TEMPNM           DEFS W
PARAM0           DEFS W
PARAM1           DEFS W
PARAM2           DEFS W
PARAM3           DEFS W
PARAM4           DEFS W
PARAM5           DEFS W
F.Rcv            DEFS W
F.Snd            DEFS W
SavPtr           DEFS L
SavLen           DEFS L
LodPtr           DEFS L
LodLen           DEFS L
TimeOut          DEFS L
PaceTime         DEFS L
MaxBlk           DEFS W
Block            DEFS W
ErrCnt           DEFS W
XBPtr            DEFS W
Srch             DEFS W
XCRC             DEFS W
XTime            DEFS L
XTimeT           DEFS L
Rect             DEFS 8
MacroPtr         DEFS L
MacPtrRt         DEFS L
MacroWt          DEFS L
PBNum            DEFS W
MAhTE            DEFS L
MABPtr           DEFS L
PBBPtr           DEFS L
MACAct           DEFS W
PBCAct           DEFS 20
HndTMSF          DEFS L
CallCnt          DEFS L
StrPtr           DEFS L
StrCnt           DEFS W
LiNum            DEFS W
MABTrk           DEFS B
PBBTrk           DEFS B
MABFl            DEFS B
PBBFl            DEFS B
MAExit           DEFS B
PBExit           DEFS B
F.Macro          DEFS B
F.MacRt          DEFS B
FlAct            DEFS B
FlCrs            DEFS B
XLOCK            DEFS B
Lite0            DEFS B
Lite1            DEFS B
Lite2            DEFS B
Lite3            DEFS B
Lite4            DEFS B
Lite5            DEFS B
Lite6            DEFS B
FlNm             DEFS B
Blk              DEFS B
PortA            DEFS B
PortB            DEFS B
XRC3Fl           DEFS B
XRC4Fl           DEFS B
XRB0Fl           DEFS B
XRB0Trk          DEFS B
AbortFl          DEFS B
F.First          DEFS B
F.CRC            DEFS B
F.Prompt         DEFS B
Device           DEFS B
Charac           DEFS B
F.BBS            DEFS B
F.CTS            DEFS B
                 DEFS *&1
;
                 DEFS grafSize
;
         ENDG
*--------------------------------
         TFILE   "Telescape.Bin"
*--------------------------------
         RFILE   "Telescape",APPL,TELE,$2000
*================================
         SEG     0,resPurgeable!resPreLoad,Var.Len,32
SEG0
SEG_1    JP      Start,1
END_1
END0
         ENDR
*================================
         SEG     1,resLocked!resPreLoad
*--------------------------------
Start    PEA     -4(A5)
         _InitGraf
         _InitFonts
         _InitWindows
         _InitMenus
         _TEInit
         CLR.L   -(SP)
         _InitDialogs
         MOVE    #1,D7
.0       CLR.L   -(SP)
         MOVE    D7,-(SP)
         _GetRMenu
         MOVE.L  (SP),D6
         CLR     -(SP)
         _InsertMenu
         CMP     #1,D7
         BNE.S   .1
         MOVE.L  D6,-(SP)
         MOVE.L  #$44525652,-(SP)
         _AddResMenu
.1       ADDQ    #1,D7
         CMP     #6,D7
         BLO.S   .0
         _DrawMenuBar
         MOVE.L  #$0000FFFF,D0
         _FlushEvents
         MOVE    #2,-(SP)
         _Pack2
         BSR     InitEB
         _InitCursor
INIT     MOVE    #1,BAUDR(A5)    ;300
         MOVE    #1,DBITS(A5)    ;8
         MOVE    #4,PARITY(A5)   ;Space
         MOVE    #0,SBITS(A5)    ;1
         MOVE    #1,DUPLEX(A5)   ;No echo
         MOVE    #0,LineFd(A5)   ;Need LF
         MOVE    #1,FLXON(A5)    ;Xon/Xoff
         CLR.L   CPace(A5)
         CLR.L   LPace(A5)
         CLR.B   Prompt(A5)
         CLR.B   XLOCK(A5)
         CLR     MODE(A5)
         CLR     TmOut(A5)
         CLR     F.Rcv(A5)
         CLR     F.Snd(A5)
         CLR.B   PortA(A5)
         CLR.B   PortB(A5)
         BSR     READCP
         MOVE    D0,Port(A5)
         CMP     #1,Port(A5)
         BLS.S   .1
         CLR     Port(A5)
         MOVE    Port(A5),T.Port(A5)
         BSR     CPORT
         BCC.S   .0
         MOVE    T.Port(A5),Port(A5)
.0       MOVE    Port(A5),D0
         BSR     CHGCP
.1       BSR     INICOM
         CLR     CHQCnt(A5)
         LEA     TermDefX(PC),A0
         BSR     CvTerm
         LEA     MacroX(PC),A0
         BSR     CvMacro
         CLR.L   -(SP)
         MOVE.L  #$544D5346,-(SP)
         MOVE    #1,-(SP)
         _GetResource
         MOVE.L  (SP)+,HndTMSF(A5)
         MOVE.L  HndTMSF(A5),A0
         MOVE.L  (A0),A0
         MOVE.B  4(A0),F.BBS(A5)
         CLR.L   -(SP)
         MOVE.L  #$50534554,-(SP)
         MOVE    #1,-(SP)
         _GetResource
         MOVE.L  (SP)+,A0
         MOVE.L  (A0),A0
         LEA     PBCAct(A5),A1
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE.L  (A0)+,(A1)+
         MOVE    #19,PBNum(A5)
         BSR     SCAN
         BSR     INITSC
         BSR     INITSC2
         BSR     INILITES
         BSR     DispKeys
         BSR     DISCR2
         CLR.L   LiteTime(A5)
.2       BSR.S   IDLE
         BSR     RECEIVE
         BSR     MacroIdl
         BSR     SEND
         BRA.S   .2
IDLE     _SystemTask
         BSR     IDLITE
         BSR     EVENT
         RTS
*--------------------------------
RECEIVE  BSR     GTLEN
         BEQ     IDLCRS
         BSR     GET1CHR
         BSR     SVSHST
         TST     FLXON(A5)
         BEQ.S   .0
         CMP.B   #DC1,D0
         BEQ     KLck0
         CMP.B   #DC3,D0
         BEQ     KLck1
.0       TST     F.Rcv(A5)
         BEQ.S   .1
         CMP.B   #DC2,D0
         BEQ     Rcv1
         CMP.B   #DC4,D0
         BEQ     Rcv2
.1       CMP.B   Prompt(A5),D0
         BNE.S   .2
         MOVE.B  #1,F.Prompt(A5)
.2       BSR     OUTCH
         BSR     ChkGrph
         RTS
GET1CHR  BSR     GET1B
         TST     PARITY(A5)
         BEQ.S   .0
         AND.B   #$7F,D0
.0       RTS
SVSHST   MOVEM.L D0-D1/A0,-(SP)
         LEA     ShStr(A5),A0
         MOVEQ   #14,D1
.0       MOVE.B  1(A0),(A0)+
         DBRA    D1,.0
         MOVE.B  D0,(A0)
         MOVEM.L (SP)+,D0-D1/A0
         RTS
IDLCRS   TST.B   FlAct(A5)
         BEQ.S   .0
         MOVE.L  Ticks,D0
         CMP.L   CrsTime(A5),D0
         BLO.S   .0
         ADD.L   CaretTime,D0
         MOVE.L  D0,CrsTime(A5)
         TST.B   FlCrs(A5)
         BEQ     ONCRS
         BNE     OFFCRS
.0       RTS
*--------------------------------
SEND     TST.B   XLOCK(A5)
         BNE     .6
         CMP     #1,F.Snd(A5)
         BNE.S   .1
         MOVE.L  Ticks,D1
         CMP.L   PaceTime(A5),D1
         BLO     .6
         TST.B   F.Prompt(A5)
         BEQ.S   .6
         BSR     Load1B
         BCC.S   .1
         MOVE.L  Ticks,D1
         CMP.B   #CR,D0
         BEQ.S   .7
         ADD.L   CPace(A5),D1
         MOVE.L  D1,PaceTime(A5)
         BRA.S   .4
.7       ADD.L   LPace(A5),D1
         MOVE.L  D1,PaceTime(A5)
         TST.B   Prompt(A5)
         BEQ.S   .4
         CLR.B   F.Prompt(A5)
         BRA.S   .4
.1       TST     CHQCnt(A5)
         BEQ.S   .6
         LEA     CHQ(A5),A0
         MOVE.B  (A0),D0
         SUBQ    #1,CHQCnt(A5)
         MOVE    CHQCnt(A5),D1
         BRA.S   .3
.2       MOVE.B  1(A0),(A0)+
.3       DBRA    D1,.2
.4       TST     DUPLEX(A5)
         BNE.S   .5
         BSR     OUTCH
.5       CMP.B   #LF,D0
         BNE.S   .9
         TST     LineFd(A5)
         BEQ.S   .8
         BRA.S   .6
.9       CMP.B   #CR,D0
         BNE.S   .8
         TST     LineFd(A5)
         BEQ.S   .8
         BSR     PUT1CHR
         MOVEQ   #LF,D0
.8       BSR     PUT1CHR
.6       RTS
PUT1CHR  TST     PARITY(A5)
         BEQ.S   .1
         CMP     #3,PARITY(A5)
         BEQ.S   .0
         AND.B   #$7F,D0
         BRA.S   .1
.0       OR.B    #$80,D0
.1       BSR     PUT1B
         RTS
*--------------------------------
Load1B   TST     LodLen(A5)
         BNE.S   .1
         BSR     LoadBuf
         TST     LodLen(A5)
         BNE.S   .1
         BSR     EndSnd
         TST     SMODE(A5)
         BNE.S   .0
         AND     #$FE,CCR
         RTS
.0       MOVE.B  #DC4,D0
         OR      #1,CCR
         RTS
.1       LEA     LodBuffer(A5),A0
         MOVE    LodPtr(A5),D1
         MOVE.B  0(A0,D1),D0
         ADDQ    #1,LodPtr(A5)
         SUBQ    #1,LodLen(A5)
         OR      #1,CCR
         RTS
LoadBuf  LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    SFRGet+RefNum(A5),24(A0)
         PEA     LodBuffer(A5)
         MOVE.L  (SP)+,32(A0)
         MOVE.L  #1024,36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Read
         MOVE    16(A0),D7
         BEQ.S   .0
         CMP     #-39,D7
         BEQ.S   .0
         BSR     DosErr
         CLR     LodLen(A5)
         RTS
.0       MOVE.L  40(A0),D0
         MOVE    D0,LodLen(A5)
         CLR     LodPtr(A5)
         RTS
*--------------------------------
EVENT    MOVE    #-1,D0
EVENT0   CLR.B   -(SP)
         MOVE    D0,-(SP)
         PEA     EVENTRECORD(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   .0
         MOVE    WHAT(A5),D0
         ADD     D0,D0
         MOVE    ETABLE(PC,D0),D0
         JMP     ETABLE(PC,D0)
.0       TST.B   F.BBS(A5)
         BNE     MINBBS
         BRA.S   EVNTRT
ETABLE   DATA    /EVNTRT-ETABLE  ;null
         DATA    /MSEDWN-ETABLE  ;mouse down
         DATA    /FKMU-ETABLE    ;mouse up
         DATA    /KEYDWN-ETABLE  ;key down
         DATA    /EVNTRT-ETABLE  ;key up
         DATA    /KEYDWN-ETABLE  ;auto-key
         DATA    /UPDATE-ETABLE  ;update
         DATA    /DSKINS-ETABLE  ;disk inserted
         DATA    /ACTVTE-ETABLE  ;activate
         DATA    /EVNTRT-ETABLE  ;
         DATA    /EVNTRT-ETABLE  ;network
         DATA    /CARIER-ETABLE  ;I/O driver
EVNTRT   TST.B   MABTrk(A5)
         BEQ.S   FKBOff
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  MABPtr(A5),-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   FKBOn
FKBOff   TST.B   MABFl(A5)
         BEQ.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     FInvert
         CLR.B   MABFl(A5)
.0       RTS
FKBOn    TST.B   MABFl(A5)
         BNE.S   .0
         MOVE.L  MABPtr(A5),A2
         BSR     FInvert
         MOVE.B  #1,MABFl(A5)
.0       RTS
ACTVTE   BSR     Active
         BRA     EVNTRT
Active   MOVE.L  Message(A5),D0
         CMP.L   Window1(A5),D0
         BNE.S   .1
         MOVE    Modify(A5),D0
         BTST    #0,D0
         BNE.S   .0
         BSR     OFFCRS
         CLR.B   FlAct(A5)
         CLR.L   -(SP)
         MOVE    #3,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #1,-(SP)
         _EnableItem
         MOVE    #3,-(SP)
         _EnableItem
         MOVE    #4,-(SP)
         _EnableItem
         MOVE    #5,-(SP)
         _EnableItem
         MOVE    #6,-(SP)
         _EnableItem
         BRA.S   .1
.0       MOVE.L  Window1(A5),-(SP)
         _SetPort
         MOVE.B  #1,FlAct(A5)
         CLR.L   -(SP)
         MOVE    #3,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #1,-(SP)
         _DisableItem
         MOVE    #3,-(SP)
         _DisableItem
         MOVE    #4,-(SP)
         _DisableItem
         MOVE    #5,-(SP)
         _DisableItem
         MOVE    #6,-(SP)
         _DisableItem
.1       RTS
UPDATE   MOVE.L  Message(A5),D0
         CMP.L   Window1(A5),D0
         BNE     EVNTRT
         MOVE.L  D0,-(SP)
         _BeginUpDate
         MOVE.L  Window1(A5),-(SP)
         _SetPort
         _PenNormal
         BSR     INITXT
         BSR     DLine
         LEA     Screen(A5),A2
         MOVE    #11,D6
         MOVE    #17,D7
         MOVE    #0,D5
.0       MOVE    D6,-(SP)
         MOVE    D7,-(SP)
         _MoveTo
         MOVE.L  A2,-(SP)
         MOVE    D5,-(SP)
         MOVE    #80,-(SP)
         _DrawText
         ADD     #11,D7
         ADD     #80,D5
         CMP     #1920,D5
         BLO.S   .0
         BSR     DispKeys
         BSR     DISCR2
         MOVE.L  Message(A5),-(SP)
         _EndUpDate
         BRA     EVNTRT
KeyDwn   _ObscureCursor
         MOVE.L  Message(A5),D0
         MOVE    Modify(A5),D1
         BTST    #8,D1
         BEQ.S   .5
         CMP.B   #$7F,D0
         BHI.S   .7
         CMP.B   #$60,D0
         BLO.S   .0
         AND.B   #$5F,D0
.0       CMP.B   #$40,D0
         BLO.S   .1
         AND.B   #$3F,D0
         BRA.S   .7
.1       CMP.B   #'?,D0
         BEQ.S   .2
         CMP.B   #'/,D0
         BNE.S   .3
.2       MOVEQ   #DEL,D0
         BRA.S   .7
.3       CMP.B   #'.,D0
         BNE.S   .4
         BSR     StopMacro
         BRA.S   .8
.4       CMP.B   #'9,D0
         BHI.S   .7
         CMP.B   #'0,D0
         BLO.S   .13
         BSR     StartMacro
         BRA.S   .8
.13      CMP.B   #$03,D0
         BNE.S   .7
         BSR.S   Break
         BRA.S   .8
.5       LEA     TermLstO(A5),A0
         CLR     D1
.6       CMP.B   #$FF,(A0)
         BEQ.S   .7
         CMP.B   (A0)+,D0
         BEQ.S   .9
         MOVE.B  (A0)+,D1
         ADD     D1,A0
         BRA.S   .6
.7       LEA     CHQ(A5),A0
         MOVE    CHQCnt(A5),D1
         CMP     #128,D1
         BHS.S   .8
         MOVE.B  D0,0(A0,D1)
         ADDQ    #1,CHQCnt(A5)
.8       BRA     EVNTRT
.9       MOVE.B  (A0)+,D1
         MOVE    CHQCnt(A5),D2
         MOVE    D2,D3
         ADD     D1,D3
         CMP     #128,D3
         BHS.S   .12
         MOVE    D3,CHQCnt(A5)
         LEA     CHQ(A5),A1
         ADD     D2,A1
         BRA.S   .11
.10      MOVE.B  (A0)+,(A1)+
.11      DBRA    D1,.10
.12      BRA     EVNTRT
Break    LEA     ParCom(A5),A0
         MOVE    RefCOut(A5),24(A0)
         MOVE    #$0C,26(A0)
         _Control
         MOVE.L  Ticks,D0
         ADD.L   #12,D0
.0       CMP.L   Ticks,D0
         BHI.S   .0
         MOVE    #$0B,26(A0)
         _Control
         RTS
MSEDWN   CLR     -(SP)
         MOVE.L  WHERE(A5),-(SP)
         PEA     WWINDOW(A5)
         _FindWindow
         MOVE    (SP)+,D0
         ADD     D0,D0
         MOVE    WTABLE(PC,D0),D0
         JMP     WTABLE(PC,D0)
WTABLE   DATA    /EVNTRT-WTABLE  ;inDesk
         DATA    /INMENU-WTABLE  ;inMenuBar
         DATA    /SYSEVN-WTABLE  ;inSysWindow
         DATA    /FKMD-WTABLE    ;inContent
         DATA    /SELECT-WTABLE  ;inDrag
         DATA    /SELECT-WTABLE  ;inGrow
         DATA    /SELECT-WTABLE  ;inGoAway
INMENU   BSR     OFFCRS
         CLR.L   -(SP)
         MOVE.L  WHERE(A5),-(SP)
         _MenuSelect
         MOVE.L  (SP)+,MENU(A5)
         MOVE    MENU(A5),D0
         ADD     D0,D0
         MOVE    MTABLE(PC,D0),D0
         JMP     MTABLE(PC,D0)
MTABLE   DATA    /MNUOUT-MTABLE
         DATA    /MNAPLE-MTABLE  ;Apple
         DATA    /MNFILE-MTABLE  ;File
         DATA    /MNEDIT-MTABLE  ;Edit
         DATA    /MNUTLY-MTABLE  ;Utilities
         DATA    /MNUSET-MTABLE  ;Settings
MNUOUT   MOVE.L  Window1(A5),-(SP)
         _SetPort
         CLR     -(SP)
         _HiliteMenu
         BRA     EVNTRT
MNAPLE   MOVE    MENUITM(A5),D0
         CMP     #1,D0
         BNE.S   DSKACC
LOGO     CLR.L   -(SP)
         MOVE    #1,-(SP)
         CLR.L   -(SP)
         MOVE.L  #-1,-(SP)
         _GetNewDialog
         MOVE.L  (SP)+,DialPtr(A5)
         MOVE.L  DialPtr(A5),-(SP)
         _ShowWindow
.0       CLR.L   -(SP)
         PEA     ItmHit(A5)
         _ModalDialog
         MOVE    ItmHit(A5),D0
         CMP     #1,D0
         BNE.S   .0
         MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         BRA     MNUOUT
DSKACC   CLR.L   -(SP)
         MOVE    #1,-(SP)
         _GetMHandle
         MOVE    MENUITM(A5),-(SP)
         PEA     DskNam(A5)
         _GetItem
         CLR     -(SP)
         PEA     DskNam(A5)
         _OpenDeskAcc
         MOVE    (SP)+,D0
         MOVE.L  WINDOW1(A5),-(SP)
         _SetPort
         BRA     MNUOUT
MNFILE   MOVE    MENUITM(A5),D0
         ADD     D0,D0
         MOVE    MFTBL(PC,D0),D0
         JMP     MFTBL(PC,D0)
MFTBL    DATA    /MNUOUT-MFTBL
         DATA    /RecvAbrt-MFTBL ;Receive File…
         DATA    /PausRest-MFTBL ;Pause Receive
         DATA    /MNUOUT-MFTBL   ;-------------
         DATA    /SendAbrt-MFTBL ;Send File…
         DATA    /RestPaus-MFTBL ;Pause Send
         DATA    /MNUOUT-MFTBL   ;-------------
         DATA    /QUIT-MFTBL     ;Quit
         INCLUDE "Transfer.Asm"
QUIT     BSR     EndRcv
         BSR     EndSnd
         MOVE.L  Window1(A5),-(SP)
         _DisposWindow
         BSR     RESCOM
         _ExitToShell
MNEDIT   MOVE    MenuItm(A5),D0
         BEQ     MnuOut
         SUBQ    #1,D0
         CLR.B   -(SP)
         MOVE    D0,-(SP)
         _SysEdit
         TST.B   (SP)+
         BRA     MnuOut
MNUTLY   MOVE    MENUITM(A5),D0
         ADD     D0,D0
         MOVE    MCTBL(PC,D0),D0
         JMP     MCTBL(PC,D0)
MCTBL    DATA    /MNUOUT-MCTBL
         DATA    /UNLKBD-MCTBL   ;Unlock Kybd.
         DATA    /MNUOUT-MCTBL   ;------------
         DATA    /EDPHBK-MCTBL   ;Directory
         DATA    /MNUOUT-MCTBL   ;------------
         DATA    /MINBBS-MCTBL   ;E-Mail
         DATA    /MNUOUT-MCTBL   ;------------
         DATA    /EDITOR-MCTBL   ;Editor
         DATA    /BINHEX-MCTBL   ;BinHex
EDPHBK   MOVE.L  Window1(A5),-(SP)
         _HideWindow
         BSR     PhoBok
         MOVE.L  Window1(A5),-(SP)
         _ShowWindow
         BRA     MNUOUT
InitEB   LEA     NamEdt(PC),A0
         LEA     SFRGet(A5),A4
         BSR     Nam0
         BSR     GetInfo
         BNE.S   .0
         CMP.L   #$4150504C,32(A0)
         BNE.S   .0
         CLR.L   -(SP)
         MOVE    #4,-(SP)
         _GetMHandle
         MOVE    #7,-(SP)
         _EnableItem
.0       LEA     NamBnHx(PC),A0
         LEA     SFRGet(A5),A4
         BSR     Nam0
         BSR     GetInfo
         BNE.S   .1
         CMP.L   #$4150504C,32(A0)
         BNE.S   .1
         CLR.L   -(SP)
         MOVE    #4,-(SP)
         _GetMHandle
         MOVE    #8,-(SP)
         _EnableItem
.1       RTS
EDITOR   BSR     EndRcv
         BSR     EndSnd
         MOVE.L  Window1(A5),-(SP)
         _DisposWindow
         BSR     RESCOM
         LEA     ParaBlk(A5),A0
         PEA     NamEdt(PC)
         MOVE.L  (SP)+,(A0)
         CLR     4(A0)
         _Launch
BINHEX   BSR     EndRcv
         BSR     EndSnd
         MOVE.L  Window1(A5),-(SP)
         _DisposWindow
         BSR     RESCOM
         LEA     ParaBlk(A5),A0
         PEA     NamBnHx(PC)
         MOVE.L  (SP)+,(A0)
         CLR     4(A0)
         _Launch
NamEdt   STR     "Editor"
NamBnHx  STR     "BinHex"
         ADJST
MNUSET   MOVE    MENUITM(A5),D0
         ADD     D0,D0
         MOVE    MSTBL(PC,D0),D0
         JMP     MSTBL(PC,D0)
MSTBL    DATA    /MNUOUT-MSTBL
         DATA    /PRTOCL-MSTBL   ;Protocol
         DATA    /TRNSFR-MSTBL   ;Transfer
         DATA    /EDMACS-MSTBL   ;Macros
         DATA    /EDTERM-MSTBL   ;Terminal
         DATA    /CNPORT-MSTBL   ;Port
EDTERM   MOVE.L  Window1(A5),-(SP)
         _HideWindow
         BSR     Terminal
         MOVE.L  Window1(A5),-(SP)
         _ShowWindow
         BRA     MNUOUT
PRTOCL   BSR     Protocol
UNLKBD   BSR     KLck0
         BRA     MNUOUT
KLck0    CLR.B   XLOCK(A5)
         CLR.L   -(SP)
         MOVE    #4,-(SP)
         _GetMHandle
         MOVE    #1,-(SP)
         _DisableItem
         MOVEQ   #0,D0
         BSR     OFFLITE
         RTS
KLck1    MOVE.B  #1,XLOCK(A5)
         CLR.L   -(SP)
         MOVE    #4,-(SP)
         _GetMHandle
         MOVE    #1,-(SP)
         _EnableItem
         MOVEQ   #0,D0
         BSR     BLKLITE
         RTS
TRNSFR   MOVE    Mode(A5),T.Mode(A5)
         MOVE    TmOut(A5),T.TmOut(A5)
         MOVE.L  CPace(A5),T.CPace(A5)
         MOVE.L  LPace(A5),T.LPace(A5)
         MOVE.B  Prompt(A5),T.Prompt(A5)
         BSR     TRANSFER
         BCC.S   .0
         MOVE    T.Mode(A5),Mode(A5)
         MOVE    T.TmOut(A5),TmOut(A5)
         MOVE.L  T.CPace(A5),CPace(A5)
         MOVE.L  T.LPace(A5),LPace(A5)
         MOVE.B  T.Prompt(A5),Prompt(A5)
.0       BRA     MNUOUT
EDMACS   MOVE.L  Window1(A5),-(SP)
         _HideWindow
         BSR     Macros
         MOVE.L  Window1(A5),-(SP)
         _ShowWindow
         BRA     MNUOUT
CNPORT   MOVE    Port(A5),T.Port(A5)
         BSR     CPORT
         BCC.S   .0
         MOVE    T.Port(A5),Port(A5)
         MOVE    Port(A5),D0
         BSR     CHGCP
         BSR     INICOM
.0       BRA     MNUOUT
SYSEVN   PEA     EVENTRECORD(A5)
         MOVE.L  WWINDOW(A5),-(SP)
         _SystemClick
         BRA     EVNTRT
FKMD     CLR.L   -(SP)
         _FrontWindow
         MOVE.L  (SP)+,D0
         CMP.L   Window1(A5),D0
         BEQ.S   FKMD0
SELECT   MOVE.L  Window1(A5),-(SP)
         _SelectWindow
         BRA     EVNTRT
FKRect   DATA    /282,/17,/295,/485
FKMD0    PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     FKRect(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .1
         LEA     F0Rect(PC),A2
         MOVEQ   #0,D7
.0       CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         MOVE.L  A2,-(SP)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .2
         ADDQ.L  #8,A2
         ADDQ    #1,D7
         CMP     #10,D7
         BLO.S   .0
.1       MOVE    #4,-(SP)
         _SysBeep
         BRA     EVNTRT
.2       MOVE.B  D7,D0
         OR.B    #$80,D7
         MOVE.B  D7,MABTrk(A5)
         MOVE.L  A2,MABPtr(A5)
         LEA     TermLstF(A5),A0
         CLR     D1
.3       CMP.B   #$FF,(A0)
         BEQ.S   .4
         CMP.B   (A0)+,D0
         BEQ.S   .5
         MOVE.B  (A0)+,D1
         ADD     D1,A0
         BRA.S   .3
.4       BSR     StartMacro
         BRA.S   .8
.5       MOVE.B  (A0)+,D1
         MOVE    CHQCnt(A5),D2
         MOVE    D2,D3
         ADD     D1,D3
         CMP     #128,D3
         BHS.S   .8
         MOVE    D3,CHQCnt(A5)
         LEA     CHQ(A5),A1
         ADD     D2,A1
         BRA.S   .7
.6       MOVE.B  (A0)+,(A1)+
.7       DBRA    D1,.6
.8       BRA     EVNTRT
FKMU     TST.B   MABTrk(A5)
         BEQ     EVNTRT
         BSR     FKBOff
         CLR.B   MABTrk(A5)
         BRA     EVNTRT
DSKINS   MOVE    Message(A5),D0
         BEQ     EVNTRT
         BSR     OFFCRS
         CLR     -(SP)
         MOVE    #100,-(SP)
         MOVE    #100,-(SP)
         MOVE.L  Message(A5),-(SP)
         MOVE    #0,-(SP)
         _Pack2
         TST     (SP)+
         BRA     EVNTRT
CARIER   MOVE    Message(A5),D0
         AND.B   #$20,D0
         BEQ     EVNTRT
         AND     #$2000,D0
         BRA     EVNTRT
*--------------------------------
CPORT    CLR.L   -(SP)
         MOVE    #4,-(SP)
         CLR.L   -(SP)
         MOVE.L  #-1,-(SP)
         _GetNewDialog
         MOVE.L  (SP)+,DialPtr(A5)
         BSR     INICP
         MOVE.L  DialPtr(A5),-(SP)
         _ShowWindow
CPLP     CLR.L   -(SP)
         PEA     ItmHit(A5)
         _ModalDialog
         MOVE    ItmHit(A5),D0
         ADD     D0,D0
         MOVE    CPTBL(PC,D0),D0
         JMP     CPTBL(PC,D0)
CPTBL    DATA    /CPLP-CPTBL
         DATA    /CPOK-CPTBL
         DATA    /CPCAN-CPTBL
         DATA    /CPLP-CPTBL
         DATA    /CPICN-CPTBL
         DATA    /CPICN-CPTBL
         DATA    /CPICN-CPTBL
         DATA    /CPICN-CPTBL
CPOK     MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         ORI     #1,CCR
         RTS
CPCAN    MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         ANDI    #$FE,CCR
         RTS
CPICN    MOVE    T.Port(A5),D6
         ADD     #4,D6
         BSR     CLRCTL
         AND     #$FFFD,ItmHit(A5)
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #4,D0
         MOVE    D0,T.Port(A5)
         BRA     CPLP
INICP    MOVE    T.Port(A5),D6
         ADD     #4,D6
         BSR     SETCTL
         RTS
READCP   CLR.L   -(SP)
         MOVE.L  #$504F5254,-(SP)
         MOVE    #1,-(SP)
         _GetResource
         MOVE.L  (SP)+,D0
         BEQ     SYSERR
         MOVE.L  D0,A0
         MOVE.L  (A0),A1
         MOVE    (A1),D0
         RTS
CHGCP    MOVE    D0,-(SP)
         BSR     READCP
         MOVE    (SP)+,(A1)
         MOVE.L  A0,-(SP)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         RTS
*--------------------------------
* File manager routines
* A4 = SFR Pointer
* EQ : No error
* NE : D7=error code
*--------------------------------
SetPar   LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         PEA     fName(A4)
         MOVE.L  (SP)+,18(A0)
         MOVE    vRefNum(A4),22(A0)
         MOVE.B  version+1(A4),26(A0)
         RTS
*--------------------------------
* Open routines
* D0 = ioPermssn
* A2 = Buffer or NIL
*--------------------------------
OpenData BSR     SetPar
         MOVE.B  D0,27(A0)
         MOVE.L  A2,28(A0)
         _Open
         MOVE    24(A0),RefNum(A4)
         MOVE    16(A0),D7
         RTS
OpenRsrc BSR     SetPar
         MOVE.B  D0,27(A0)
         MOVE.L  A2,28(A0)
         _OpenRF
         MOVE    24(A0),RefNum(A4)
         MOVE    16(A0),D7
         RTS
*--------------------------------
CloseF   LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    RefNum(A4),24(A0)
         _Close
         MOVE    16(A0),D7
         BNE.S   .0
         CLR.L   18(A0)
         MOVE    vRefNum(A4),22(A0)
         _FlushVol
         MOVE    16(A0),D7
.0       RTS
*--------------------------------
CreateF  BSR     SetPar
         _Create
         MOVE    16(A0),D7
         RTS
*--------------------------------
DeleteF  BSR     GetInfo
         BEQ.S   .0
         CMP     #-43,D7
         BRA.S   .1
.0       MOVE    #-45,D7
         BTST    #7,40(A0)
         BNE.S   .1
         _Delete
         MOVE    16(A0),D7
.1       RTS
*--------------------------------
GetInfo  BSR     SetPar
         CLR     28(A0)
         _GetFileInfo
         MOVE    16(A0),D7
         RTS
*--------------------------------
MovToEOF LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    RefNum(A4),22(A0)
         MOVE    #2,44(A0)
         CLR.L   46(A0)
         _SetFPos
         MOVE    16(A0),D7
         RTS
*--------------------------------
SetLock  BSR     SetPar
         _SetFilLock
         MOVE    16(A0),D7
         RTS
*--------------------------------
DosErr   MOVEM.L D0/D7,-(SP)
         LEA     TErr(PC),A0
.0       MOVE.B  (A0)+,D0
         BEQ.S   .1
         EXT     D0
         CMP     D0,D7
         BEQ.S   .1
         CLR     D0
         MOVE.B  (A0)+,D0
         ADD     D0,A0
         BRA.S   .0
.1       MOVE.L  A0,-(SP)
         CLR.L   -(SP)
         CLR.L   -(SP)
         CLR.L   -(SP)
         _ParamText
         CLR     -(SP)
         MOVE    #9,-(SP)
         CLR.L   -(SP)
         _StopAlert
         TST     (SP)+
         MOVEM.L (SP)+,D0/D7
         TST     D7
         RTS
*--------------------------------
ESTR     MACRO
         DATA    #]1
         STR     "]2"
         ENDM
*--------------------------------
TErr     ESTR    -33,"Directory full"
         ESTR    -34,"Disk full"
         ESTR    -35,"No such volume"
         ESTR    -36,"Disk I/O"
         ESTR    -39,"End of file"
         ESTR    -44,"Write protected diskette"
         ESTR    -45,"File locked"
         ESTR    -46,"Volume locked"
         ESTR    -47,"File busy"
TCRC     EQU     *+8
         ESTR      3,"CRC ($0000)"
         ESTR      2,"Cancel"
         ESTR      1,"End Of Text"
         ESTR      0,"File system"
         ADJST
*--------------------------------
GTLEN    LEA     PARCOM(A5),A0
         MOVE    REFCIN(A5),24(A0)
         MOVE    #2,26(A0)
         CLR.L   28(A0)
         _Status
         MOVE.L  28(A0),D0
         RTS
GTCTS    LEA     PARCOM(A5),A0
         MOVE    REFCIN(A5),24(A0)
         MOVE    #8,26(A0)
         _Status
         MOVE.B  32(A0),D0
         RTS
GET1B    LEA     PARCOM(A5),A0
         MOVE    REFCIN(A5),24(A0)
         CLR.B   -(SP)
         MOVE.L  A7,32(A0)
         MOVE.L  #1,36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Read
         MOVE.B  (SP)+,D0
         MOVE    16(A0),D7
         BNE     SYSERR
         RTS
PUT1B    LEA     PARCOM(A5),A0
         MOVE    REFCOUT(A5),24(A0)
         MOVE.B  D0,-(SP)
         MOVE.L  A7,32(A0)
         MOVE.L  #1,36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Write
         MOVE.B  (SP)+,D0
         MOVE    16(A0),D7
         BNE     SYSERR
         RTS
INICOM   LEA     PARCOM(A5),A0
         MOVEQ   #50/2-1,D0
.0       CLR     (A0)+
         DBRA    D0,.0
         TST     Port(A5)
         BNE.S   .1
         MOVE    #-6,RefCin(A5)
         MOVE    #-7,RefCout(A5)
         TST.B   PortA(A5)
         BNE     .2
         CLR     -(SP)
         MOVE    #$0000,-(SP)
         JSR     RAMSDOpen(PC)
         MOVE    (SP)+,D7
         BNE     SYSERR
         MOVE.B  #1,PortA(A5)
         BRA.S   .2
.1       MOVE    #-8,RefCin(A5)
         MOVE    #-9,RefCout(A5)
         TST.B   PortB(A5)
         BNE.S   .2
         CLR     -(SP)
         MOVE    #$0100,-(SP)
         JSR     RAMSDOpen(PC)
         MOVE    (SP)+,D7
         BNE     SYSERR
         MOVE.B  #1,PortB(A5)
.2       BSR     INIPROT
         MOVE    #9,26(A0)
         LEA     BUFCOM(A5),A1
         MOVE.L  A1,28(A0)
         MOVE    #1024,32(A0)
         _Control
         MOVE    #$A,26(A0)
         MOVE.L  #$00001113,28(A0)
         MOVE.L  #$0020FF00,32(A0)
         _Control
         _KillIO
         RTS
INIPROT  LEA     PARCOM(A5),A0
         MOVE    REFCOUT(A5),24(A0)
         MOVE    #8,26(A0)
         MOVE    BAUDR(A5),D1
         ADD     D1,D1
         MOVE    TBAUD(PC,D1),D0
         MOVE    DBITS(A5),D1
         ADD     D1,D1
         OR      TDBITS(PC,D1),D0
         MOVE    PARITY(A5),D1
         ADD     D1,D1
         OR      TPARITY(PC,D1),D0
         MOVE    SBITS(A5),D1
         ADD     D1,D1
         OR      TSBITS(PC,D1),D0
         MOVE    D0,28(A0)
         _Control
         RTS
RESCOM   TST.B   PortA(A5)
         BEQ.S   .0
         MOVE    #$0000,-(SP)
         JSR     RAMSDClose(PC)
.0       TST.B   PortB(A5)
         BEQ.S   .1
         MOVE    #$0100,-(SP)
         JSR     RAMSDClose(PC)
.1       RTS
TBAUD    DATA    /$03FF,/$017C,/$005E,/$002E,/$0016,/$000A
TDBITS   DATA    /$0400,/$0C00
TPARITY  DATA    /$0000,/$3000,/$1000,/$0000,/$0000
TSBITS   DATA    /$4000,/$8000,/$C000
SYSERR   BSR     DOSERR
         _ExitToShell
*--------------------------------
INITSC2  LEA     TblSc2(PC),A0
         LEA     Screen2(A5),A1
         MOVEQ   #80/4-1,D0
.0       MOVE.L  (A0)+,(A1)+
         DBRA    D0,.0
         RTS
INILITES MOVE.B  #0,Lite0(A5)
         MOVE.B  #0,Lite1(A5)
         MOVE.B  #0,Lite2(A5)
         MOVE    FLXON(A5),D0
         MOVE.B  D0,Lite3(A5)
         MOVE    LineFd(A5),D0
         MOVE.B  D0,Lite4(A5)
         MOVE    DUPLEX(A5),D0
         EOR.B   #1,D0
         MOVE.B  D0,Lite5(A5)
         MOVE.B  #0,Lite6(A5)
         BRA     SETDPRO
TblSc2   ASC     ' Kybd locked  Receive  Send  Xon/Xoff  L'
         ASC     'F  Echo  Graphics  Protocol:    - - -   '
TblTog   DATA    /10,/88,/142,/178,/238,/262,/298,/358
TOGGLE   LSL     #1,D0
         MOVE    #298,Rect(A5)
         MOVE    TblTog(PC,D0),D1
         ADDQ    #2,D1
         MOVE    D1,Rect+2(A5)
         MOVE    #309,Rect+4(A5)
         MOVE    TblTog+2(PC,D0),D1
         SUBQ    #1,D1
         MOVE    D1,Rect+6(A5)
         PEA     Rect(A5)
         _InverRect
         RTS
STRect   DATA    /297,/10,/310,/492
STIRect  DATA    /298,/11,/309,/491
DISCR2   _PenNormal
         PEA     STRect(PC)
         _FrameRect
         PEA     STIRect(PC)
         _EraseRect
         LEA     TblTog+2(PC),A2
         MOVEQ   #7-1,D3
.2       MOVE    (A2),-(SP)
         MOVE    #298,-(SP)
         _MoveTo
         MOVE    (A2)+,-(SP)
         MOVE    #308,-(SP)
         _LineTo
         DBRA    D3,.2
         MOVE    #11,-(SP)
         MOVE    #307,-(SP)
         _MoveTo
         PEA     Screen2(A5)
         CLR     -(SP)
         MOVE    #80,-(SP)
         _DrawText
         LEA     Lite0(A5),A2
         MOVEQ   #0,D3
.0       BTST    #0,(A2)+
         BEQ.S   .1
         MOVE    D3,D0
         BSR     TOGGLE
.1       ADDQ    #1,D3
         CMP     #7,D3
         BLO.S   .0
         RTS
SETLITE  BTST    #0,D1
         BEQ.S   OFFLITE
ONLITE   LEA     Lite0(A5),A0
         MOVE.B  0(A0,D0),D1
         MOVE.B  #1,0(A0,D0)
         BTST    #0,D1
         BNE.S   .0
         BSR     TOGGLE
.0       RTS
OFFLITE  LEA     Lite0(A5),A0
         MOVE.B  0(A0,D0),D1
         CLR.B   0(A0,D0)
         BTST    #0,D1
         BEQ.S   .0
         BSR     TOGGLE
.0       RTS
BLKLITE  LEA     Lite0(A5),A0
         BSET    #1,0(A0,D0)
         RTS
IDLITE   CLR.L   -(SP)
         _TickCount
         MOVE.L  (SP)+,D0
         CMP.L   LiteTime(A5),D0
         BLO.S   .2
         ADD.L   CaretTime,D0
         MOVE.L  D0,LiteTime(A5)
         LEA     Lite0(A5),A2
         MOVEQ   #0,D3
.0       BTST    #1,(A2)
         BEQ.S   .1
         BCHG    #0,(A2)
         MOVE    D3,D0
         BSR     TOGGLE
.1       ADDQ.L  #1,A2
         ADDQ    #1,D3
         CMP     #7,D3
         BLO.S   .0
.2       RTS
TbBaud   ASC     ' 110 3001200240048009600'
TbPar    ASC     'NEOMS '
TbBits   ASC     '78'
TbSBit   ASC     '-1  -1.5-2  '
SETDPRO  MOVE    BAUDR(A5),D1
         LSL     #2,D1
         MOVE.L  TbBaud(PC,D1),Screen2+68(A5)
         MOVE    PARITY(A5),D1
         MOVE.B  TbPar(PC,D1),Screen2+73(A5)
         MOVE    DBITS(A5),D1
         MOVE.B  TbBits(PC,D1),Screen2+75(A5)
         MOVE    SBITS(A5),D1
         LSL     #2,D1
         MOVE.L  TbSBit(PC,D1),Screen2+76(A5)
         RTS
*--------------------------------
         INCLUDE "Term.Asm"
         INCLUDE "GrDrvr.Asm"
         INCLUDE "Macros.Asm"
         INCLUDE ":Sources:RamSDOpen.Asm"
*--------------------------------
         ENDR
*================================
         INCLUDE "Resrc.Asm"
*================================
         END
