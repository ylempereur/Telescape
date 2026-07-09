;SAVE"Transfer.Asm"
*--------------------------------
         LIST    ON
*--------------------------------
; Transfer Routines v1.0
*--------------------------------
         LIST    OFF
*================================
RecvAbrt TST     F.Rcv(A5)
         BNE     AbortRcv
         CLR     MaxBlk(A5)
         MOVE    #100,-(SP)
         MOVE    #70,-(SP)
         PEA     Prompts(PC)
         PEA     DfltNam(PC)
         CLR.L   -(SP)
         PEA     SFRPut(A5)
         MOVE    #19,-(SP)
         CLR.L   -(SP)
         MOVE    #3,-(SP)
         _Pack3
         TST.B   SFRPut+Good(A5)
         BEQ     MnuOut
         BSR     RestScrn
         LEA     SFRPut(A5),A4
         BSR     DeleteF
         BNE.S   .2
         CMP     #3,MODE(A5)
         BEQ     DnlApp
         BSR     CreateF
         BNE.S   .2
         BSR     GetInfo
         BNE.S   .2
         MOVE.L  #TYPTXT,32(A0)
         MOVE.L  #CREAT,36(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE.S   .2
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .1
         BSR     InitS
         MOVE    MODE(A5),D0
         BNE.S   .0
         BSR     Rcv1
         BRA     MnuOut
.0       CMP     #1,D0
         BNE.S   DnLoad
         BSR     Rcv2
         BRA     MnuOut
.1       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         MOVE    (SP)+,D7
.2       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     DeleteF
         MOVE    (SP)+,D7
         BSR     DosErr
         BRA     MnuOut
DnLoad   BSR     Ropen
.0       BSR     Rread
         BNE.S   .1
         MOVE.L  #128,D1
         BSR     WriteX
         BEQ.S   .0
         BRA.S   .2
.1       CMP     #1,D7
         BNE.S   .2
         BSR     FlshS
         BNE.S   .3
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .3
         BSR     Rclose
         BRA     MnuOut
.2       MOVE    D7,-(SP)
         BSR     Rabort
         MOVE    (SP)+,D7
.3       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BSR     DeleteF
         BSR     Rclose
         MOVE    (SP)+,D7
         BSR     DosErr
         BRA     MnuOut
DnlApp   LEA     SFRPut+fName(A5),A0
         LEA     TmpNam(A5),A1
         BSR     CopyStr
         BSR     Ropen
         BSR     Rread
         BNE     .4
         LEA     XBuf(A5),A0
         TST.B   0(A0)
         BNE     .6
         TST.B   74(A0)
         BNE     .6
         TST.B   82(A0)
         BNE     .6
         BSR     LdHdr
         BNE     .6
         BSR     Disp2
         LEA     SFRPut(A5),A4
         BSR     GetInfo
         BNE.S   .20
         LEA     TmpNam(A5),A0
         LEA     SFRPut+fName(A5),A1
         BSR     CopyStr
         BRA.S   .21
.20      CMP     #-43,D7
         BNE     .4
.21      BSR     CreateF
         BNE     .3
         MOVE.L  Type(A5),32(A0)
         MOVE.L  Creator(A5),36(A0)
         MOVE    Flags(A5),40(A0)
         AND     #$F800,40(A0)
         MOVE.L  Location(A5),42(A0)
         MOVE    Folder(A5),46(A0)
         MOVE.L  FlCrDat(A5),72(A0)
         MOVE.L  FlMdDat(A5),76(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE     .3
         BSR     MaxBin
         ADDQ    #1,MaxBlk(A5)
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .2
         MOVE.L  DataLen(A5),Length(A5)
         BSR     GetBlk
         BNE.S   .2
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .2
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenRsrc
         BNE.S   .2
         MOVE.L  RsrcLen(A5),Length(A5)
         BSR     GetBlk
         BNE.S   .2
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .2
         MOVE.B  Locked(A5),D0
         AND.B   #$01,D0
         BEQ.S   .0
         LEA     SFRPut(A5),A4
         BSR     SetLock
         BNE.S   .3
.0       BSR     Rread
         BEQ.S   .0
         CMP     #1,D7
         BEQ.S   .1
         BSR     Rabort
.1       BSR     Rclose
         BRA     MnuOut
.2       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         MOVE    (SP)+,D7
.3       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     DeleteF
         MOVE    (SP)+,D7
.4       MOVE    D7,-(SP)
         BSR     Rabort
         BSR     Rclose
         MOVE    (SP)+,D7
         BSR     DosErr
         BRA     MnuOut
.6       LEA     SFRPut(A5),A4
         BSR     CreateF
         BNE.S   .12
         BSR     GetInfo
         BNE.S   .12
         MOVE.L  #TYPTXT,32(A0)
         MOVE.L  #CREAT,36(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE.S   .12
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .12
         BSR     InitS
         BRA.S   .8
.7       BSR     Rread
         BNE.S   .11
.8       LEA     XBuf(A5),A1
         MOVEQ   #128-1,D1
.9       MOVE.B  (A1)+,D0
         BEQ.S   .10
         CMP.B   #LF,D0
         BEQ.S   .10
         CMP.B   #SUB,D0
         BEQ.S   .10
         BSR     WriteS
         BNE.S   .12
.10      DBRA    D1,.9
         BRA.S   .7
.11      CMP     #1,D7
         BNE.S   .12
         BSR     FlshS
         BNE.S   .13
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .13
         BSR     Rclose
         BRA     MnuOut
.12      MOVE    D7,-(SP)
         BSR     Rabort
         MOVE    (SP)+,D7
.13      MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BSR     DeleteF
         BSR     Rclose
         MOVE    (SP)+,D7
         BSR     DosErr
         BRA     MnuOut
AbortRcv BSR     EndRcv
         BRA     MnuOut
PausRest MOVE    F.Rcv(A5),D0
         BEQ     MnuOut
         CMP     #1,D0
         BNE     RestRcv
         BSR     Rcv2
         BRA     MnuOut
RestRcv  BSR     Rcv1
         BRA     MnuOut
EndRcv   TST     F.Rcv(A5)
         BEQ.S   .0
         BSR     FlshS
         BNE.S   .1
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .1
         BSR     Rcv0
.0       RTS
.1       MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BSR     Rcv0
         MOVE    (SP)+,D7
         BSR     DosErr
         RTS
*--------------------------------
SendAbrt TST     F.Snd(A5)
         BNE     AbortSnd
         CLR     MaxBlk(A5)
         MOVE    #70,-(SP)
         MOVE    #70,-(SP)
         PEA     NullStr(PC)
         CLR.L   -(SP)
         CMP     #3,MODE(A5)
         BNE.S   .0
         MOVE    #-1,-(SP)
         CLR.L   -(SP)
         BRA.S   .1
.0       MOVE    #1,-(SP)
         PEA     TypeList(PC)
.1       CLR.L   -(SP)
         PEA     SFRGet(A5)
         MOVE    #20,-(SP)
         CLR.L   -(SP)
         MOVE    #4,-(SP)
         _Pack3
         TST.B   SFRGet+Good(A5)
         BEQ     MnuOut
         BSR     RestScrn
         CMP     #3,MODE(A5)
         BEQ     AppUpl
         LEA     SFRGet(A5),A4
         BSR     GetInfo
         BNE.S   .4
         MOVE.L  54(A0),DataLen(A5)
         BSR     MaxTxt
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     OpenData
         BNE.S   .3
         CLR     LodLen(A5)
         MOVE.L  Ticks,PaceTime(A5)
         MOVE.B  #1,F.Prompt(A5)
         MOVE    MODE(A5),D0
         MOVE    D0,SMODE(A5)
         BNE.S   .2
         BSR     Snd1
         BRA     MnuOut
.2       CMP     #1,D0
         BNE.S   UpLoad
         MOVE.B  #DC2,LodBuffer(A5)
         MOVE    #1,LodLen(A5)
         CLR     LodPtr(A5)
         BSR     Snd1
         BRA     MnuOut
.3       MOVE    D7,-(SP)
         LEA     SFRGet(A5),A4
         BSR     CloseF
         MOVE    (SP)+,D7
.4       BSR     DosErr
         BRA     MnuOut
UpLoad   BSR     Sopen
         BNE.S   .2
.0       BSR     ClrBuf
         BSR     ReadX
         BNE.S   .2
         TST.L   D1
         BEQ.S   .1
         BSR     Swrite
         BEQ.S   .0
         BRA.S   .2
.1       LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .2
         BSR     Sclose
         BRA     MnuOut
.2       MOVE    D7,-(SP)
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BSR     Sabort
         MOVE    (SP)+,D7
         BSR     DosErr
         BRA     MnuOut
AppUpl   LEA     SFRGet(A5),A4
         BSR     GetInfo
         BNE     .2
         MOVE.L  32(A0),Type(A5)
         MOVE.L  36(A0),Creator(A5)
         MOVE    40(A0),Flags(A5)
         AND     #$FF00,Flags(A5)
         MOVE.L  42(A0),Location(A5)
         MOVE    46(A0),Folder(A5)
         MOVE    30(A0),Locked(A5)
         AND     #$0100,Locked(A5)
         MOVE.L  54(A0),DataLen(A5)
         MOVE.L  64(A0),RsrcLen(A5)
         MOVE.L  72(A0),FlCrDat(A5)
         MOVE.L  76(A0),FlMdDat(A5)
         BSR     MaxBin
         BSR     Sopen
         BNE.S   .1
         BSR     SvHdr
         BNE.S   .1
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     OpenData
         BNE.S   .0
         MOVE.L  DataLen(A5),Length(A5)
         BSR     PutBlk
         BNE.S   .0
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .0
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     OpenRsrc
         BNE.S   .0
         MOVE.L  RsrcLen(A5),Length(A5)
         BSR     PutBlk
         BNE.S   .0
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .0
         BSR     Sclose
         BRA     MnuOut
.0       MOVE    D7,-(SP)
         LEA     SFRGet(A5),A4
         BSR     CloseF
         MOVE    (SP)+,D7
.1       MOVE    D7,-(SP)
         BSR     Sabort
         MOVE    (SP)+,D7
.2       BSR     DosErr
         BRA     MnuOut
AbortSnd BSR     EndSnd
         BRA     MNUOUT
RestPaus MOVE    F.Snd(A5),D0
         BEQ     MNUOUT
         CMP     #1,D0
         BNE     RestSnd
         BSR     Snd2
         BRA     MNUOUT
RestSnd  BSR     Snd1
         BRA     MNUOUT
EndSnd   TST     F.Snd(A5)
         BEQ.S   .0
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BSR     Snd0
.0       RTS
*--------------------------------
SvHdr    BSR     ClrBuf
         LEA     SFRGet+fName(A5),A0
         LEA     XBuf+1(A5),A1
         BSR     CopyStr
         LEA     Type(A5),A0
         LEA     XBuf+65(A5),A1
         MOVEQ   #34-1,D0
.0       MOVE.B  (A0)+,(A1)+
         DBRA    D0,.0
         BRA     Swrite
*--------------------------------
LdHdr    LEA     XBuf+1(A5),A0
         MOVEQ   #3,D7
         CMP.B   #63,(A0)
         BHI.S   .1
         LEA     SFRPut+fName(A5),A1
         BSR     CopyStr
         LEA     XBuf+65(A5),A0
         LEA     Type(A5),A1
         MOVEQ   #34-1,D0
.0       MOVE.B  (A0)+,(A1)+
         DBRA    D0,.0
         CLR     D7
.1       RTS
*--------------------------------
PutBlk   TST.L   Length(A5)
         BEQ.S   .0
         BSR     ClrBuf
         BSR     ReadX
         BNE.S   .0
         SUB.L   D1,Length(A5)
         BSR     Swrite
         BEQ.S   PutBlk
.0       RTS
*--------------------------------
GetBlk   BSR     InitS
.0       TST.L   Length(A5)
         BEQ.S   .3
.1       BSR     Rread
         BNE.S   .4
         MOVE.L  #128,D1
         CMP.L   Length(A5),D1
         BLS.S   .2
         MOVE.L  Length(A5),D1
.2       BSR     WriteX
         BNE.S   .4
         SUB.L   D1,Length(A5)
         BNE.S   .1
.3       BSR     FlshS
.4       RTS
*--------------------------------
CopyStr  CLR     D0
         MOVE.B  (A0),D0
.0       MOVE.B  (A0)+,(A1)+
         DBRA    D0,.0
         RTS
*--------------------------------
Ropen    BSR     BegXRcv
         BSR     INIXMOD
         MOVE.L  Ticks,XTime(A5)
         MOVE.L  XTime(A5),XTimeT(A5)
         CLR     Block(A5)
         CLR.B   F.First(A5)
         CLR.B   F.CRC(A5)
         RTS
Rread    ADDQ    #1,Block(A5)
.0       CLR     ErrCnt(A5)
         TST.B   F.First(A5)
         BEQ.S   .1
         MOVEQ   #ACK,D0
         BRA.S   .2
.1       BSR     WaitQ
         MOVEQ   #NAK,D0
         TST.B   F.First(A5)
         BNE.S   .2
         TST.B   F.CRC(A5)
         BNE.S   .2
         MOVEQ   #'C,D0
.2       BSR     Snd
.3       BSR     DRBlk
         MOVE    #160,Srch(A5)
         MOVEQ   #2,D0
         BSR     Recv
         BCC.S   .8
         CMP.B   #EOT,D0
         BNE.S   .4
         MOVEQ   #1,D7
         RTS
.4       CMP.B   #CAN,D0
         BNE.S   .7
.5       MOVEQ   #2,D7
         RTS
.6       MOVEQ   #1,D0
         BSR     Recv
         BCC.S   .8
.7       CMP.B   #SOH,D0
         BEQ.S   .10
         SUBQ    #1,Srch(A5)
         BNE.S   .6
.8       TST.B   AbortFl(A5)
         BNE.S   .5
         BSR     TOErr
         CMP     #2,ErrCnt(A5)
         BNE.S   .9
         TST.B   F.First(A5)
         BNE.S   .9
         MOVE.B  #1,F.CRC(A5)
.9       ADDQ    #1,ErrCnt(A5)
         CMP     #10,ErrCnt(A5)
         BLO     .1
         BRA.S   .5
.10      MOVE.B  #1,F.First(A5)
         MOVEQ   #1,D0
         BSR     Recv
         BCC.S   .8
         MOVE.B  D0,Blk(A5)
         MOVEQ   #1,D0
         BSR     Recv
         BCC.S   .8
         NOT.B   D0
         CMP.B   Blk(A5),D0
         BEQ.S   .11
         BSR     BNErr
         BRA.S   .9
.11      CLR     XCRC(A5)
         CLR     XBPtr(A5)
.12      MOVEQ   #1,D0
         BSR     Recv
         BCC.S   .8
         LEA     XBuf(A5),A0
         MOVE    XBPtr(A5),D1
         MOVE.B  D0,0(A0,D1)
         TST.B   F.CRC(A5)
         BEQ.S   .13
         ADD.B   D0,XCRC(A5)
         BRA.S   .14
.13      BSR.S   .19
.14      ADDQ    #1,XBPtr(A5)
         CMP     #128,XBPtr(A5)
         BLO.S   .12
         TST.B   F.CRC(A5)
         BEQ.S   .15
         MOVEQ   #1,D0
         BSR     Recv
         BCC     .8
         CMP.B   XCRC(A5),D0
         BEQ.S   .16
         BSR     CSErr
         BRA     .9
.15      MOVEQ   #1,D0
         BSR     Recv
         BCC     .8
         BSR.S   .19
         MOVEQ   #1,D0
         BSR     Recv
         BCC     .8
         BSR.S   .19
         TST     XCRC(A5)
         BEQ.S   .16
         BSR     CRCErr
         BRA     .9
.16      MOVE    Block(A5),D0
         CMP.B   Blk(A5),D0
         BNE.S   .17
         MOVEQ   #0,D7
         RTS
.17      SUBQ    #1,D0
         CMP.B   Blk(A5),D0
         BNE.S   .18
         BSR     WBErr
         BRA     .0
.18      BSR     SyErr
         BRA     .5
.19      MOVE    XCRC(A5),D2
         MOVEQ   #8-1,D1
.20      LSL.B   #1,D0
         ROXL    #1,D2
         BCC.S   .21
         EOR     #$1021,D2
.21      DBRA    D1,.20
         MOVE    D2,XCRC(A5)
         RTS
Rabort   BSR     AbErr
         BSR     WaitQ
         MOVEQ   #CAN,D0
         BRA     Snd
Rclose   BSR     Cmplt
         MOVEQ   #3,D7
         BSR     Beeps
         BSR     WaitQ
         MOVEQ   #ACK,D0
         BSR     Snd
         BSR     WaitQ
         BSR     RESXMOD
         BRA     EndXRcv
*--------------------------------
Sopen    BSR     BegXSnd
         BSR     INIXMOD
         MOVE.L  Ticks,XTime(A5)
         MOVE.L  XTime(A5),XTimeT(A5)
         CLR     Block(A5)
         CLR.B   F.CRC(A5)
.0       BSR     GTLEN
         BEQ.S   .1
         BSR     GET1B
         BRA.S   .0
.1       CLR     ErrCnt(A5)
.2       MOVEQ   #0,D0
         BSR     Recv
         BCS.S   .5
         TST.B   AbortFl(A5)
         BNE.S   .4
.3       ADDQ    #1,ErrCnt(A5)
         CMP     #120,ErrCnt(A5)
         BLO.S   .2
.4       MOVEQ   #2,D7
         RTS
.5       CMP.B   #CAN,D0
         BEQ.S   .4
         CMP.B   #'C,D0
         BEQ.S   .6
         CMP.B   #NAK,D0
         BNE.S   .3
         MOVE.B  #1,F.CRC(A5)
.6       MOVEQ   #0,D7
         RTS
Swrite   ADDQ    #1,Block(A5)
         CLR     ErrCnt(A5)
.0       TST.B   AbortFl(A5)
         BNE     .8
         BSR     DSBlk
         MOVEQ   #SOH,D0
         BSR     Snd
         MOVE    Block(A5),D0
         BSR     Snd
         NOT.B   D0
         BSR     Snd
         CLR     XCRC(A5)
         CLR     XBPtr(A5)
.1       LEA     XBuf(A5),A0
         MOVE    XBPtr(A5),D1
         MOVE.B  0(A0,D1),D0
         BSR     Snd
         TST.B   F.CRC(A5)
         BEQ.S   .2
         ADD.B   D0,XCRC(A5)
         BRA.S   .3
.2       BSR     .12
.3       ADDQ    #1,XBPtr(A5)
         CMP     #128,XBPtr(A5)
         BLO.S   .1
         TST.B   F.CRC(A5)
         BEQ.S   .4
         MOVE.B  XCRC(A5),D0
         BRA.S   .5
.4       MOVEQ   #0,D0
         BSR.S   .12
         MOVEQ   #0,D0
         BSR.S   .12
         MOVE.B  XCRC(A5),D0
         BSR     Snd
         MOVE    XCRC(A5),D0
.5       BSR     Snd
         MOVE    #192,Srch(A5)
.6       MOVEQ   #2,D0
         BSR     Recv
         BCC.S   .10
         CMP.B   #CAN,D0
         BEQ.S   .8
         CMP.B   #ACK,D0
         BEQ.S   .11
         CMP.B   #NAK,D0
         BNE.S   .9
         BSR     NAKErr
.7       ADDQ    #1,ErrCnt(A5)
         CMP     #10,ErrCnt(A5)
         BLO     .0
.8       MOVEQ   #2,D7
         RTS
.9       SUBQ    #1,Srch(A5)
         BNE.S   .6
.10      TST.B   AbortFl(A5)
         BNE.S   .8
         BSR     TOErr
         BRA.S   .7
.11      MOVEQ   #0,D7
         RTS
.12      MOVE    XCRC(A5),D2
         MOVEQ   #8-1,D1
.13      LSL.B   #1,D0
         ROXL    #1,D2
         BCC.S   .14
         EOR     #$1021,D2
.14      DBRA    D1,.13
         MOVE    D2,XCRC(A5)
         RTS
Sabort   BSR     AbErr
         BSR     WaitQ
         MOVEQ   #CAN,D0
         BSR     Snd
         BRA.S   Sclos
Sclose   CLR     ErrCnt(A5)
.0       MOVEQ   #EOT,D0
         BSR     Snd
         MOVE    #192,Srch(A5)
.1       MOVEQ   #2,D0
         BSR     Recv
         BCC.S   .2
         CMP.B   #ACK,D0
         BEQ.S   Sclos
         SUBQ    #1,Srch(A5)
         BNE.S   .1
.2       BSR     TOErr
         TST.B   AbortFl(A5)
         BNE.S   Sclos
         ADDQ    #1,ErrCnt(A5)
         CMP     #10,ErrCnt(A5)
         BLO.S   .0
Sclos    BSR     Cmplt
         MOVEQ   #3,D7
         BSR     Beeps
         BSR     RESXMOD
         BRA     EndXSnd
*--------------------------------
WaitQ    MOVEQ   #0,D0
         BSR     Recv
         BCS.S   WaitQ
         RTS
Recv     LSL     #2,D0
         MOVE    TmOut(A5),D1
         LSL     #4,D1
         ADD     D0,D1
         MOVE.L  Ticks,D0
         ADD.L   TblTOut(PC,D1),D0
         MOVE.L  D0,TimeOut(A5)
.0       BSR     IDLEX
         TST.B   AbortFl(A5)
         BNE.S   .2
         BSR     GTLEN
         BNE.S   .1
         MOVE.L  Ticks,D0
         CMP.L   TimeOut(A5),D0
         BLO.S   .0
.2       AND     #$FE,CCR
         RTS
.1       BSR     ARWRCV
         BSR     GET1B
         OR      #1,CCR
         RTS
Snd      MOVEM.L D0,-(SP)
         BSR     Put1B
         BSR     ARWSND
         BSR     IDLEX
         MOVEM.L (SP)+,D0
         RTS
TblTOut  DATA    01*60,05*60,10*60,0
         DATA    02*60,15*60,30*60,0
         DATA    03*60,30*60,60*60,0
*--------------------------------
WriteX   LEA     XBuf(A5),A0
         MOVE.L  SavPtr(A5),A1
         MOVE.L  D1,D0
         BRA.S   .1
.0       MOVE.B  (A0)+,(A1)+
.1       DBRA    D0,.0
         MOVE.L  A1,SavPtr(A5)
         ADD.L   D1,SavLen(A5)
         MOVE.L  #1024,D0
         SUB.L   SavLen(A5),D0
         CMP.L   #128,D0
         BLO.S   FlshS
         CLR     D7
         RTS
WriteS   MOVE.L  SavPtr(A5),A0
         MOVE.B  D0,(A0)
         ADDQ.L  #1,SavPtr(A5)
         ADDQ.L  #1,SavLen(A5)
         CMP.L   #1024,SavLen(A5)
         BHS.S   FlshS
         CLR     D7
         RTS
FlshS    LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    SFRPut+RefNum(A5),24(A0)
         PEA     SavBuffer(A5)
         MOVE.L  (SP)+,32(A0)
         MOVE.L  SavLen(A5),36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Write
         MOVE    16(A0),D7
InitS    PEA     SavBuffer(A5)
         MOVE.L  (SP)+,SavPtr(A5)
         CLR.L   SavLen(A5)
         TST     D7
         RTS
Save1B   CMP     #1,F.Rcv(A5)
         BNE.S   .1
         MOVE.L  D0,-(SP)
         BSR     WriteS
         BEQ.S   .0
         MOVE    D7,-(SP)
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BSR     Rcv0
         MOVE    (SP)+,D7
         BSR     DosErr
.0       MOVE.L  (SP)+,D0
.1       RTS
*--------------------------------
ClrBuf   LEA     XBuf(A5),A0
         MOVEQ   #128/4-1,D1
.0       CLR.L   (A0)+
         DBRA    D1,.0
         RTS
ReadX    LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    SFRGet+RefNum(A5),24(A0)
         PEA     XBuf(A5)
         MOVE.L  (SP)+,32(A0)
         MOVE.L  #128,36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Read
         MOVE.L  40(A0),D1
         MOVE    16(A0),D7
         BEQ.S   .0
         CMP     #-39,D7
.0       RTS
*--------------------------------
Disp2    MOVE    #0,-(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         MOVE    #0,-(SP)
         _TextMode
         LEA     XRC0(PC),A2
         BSR     CErase
         LEA     SFRPut+fName(A5),A3
         BSR     ClipString
         MOVE    #15,D3
         BRA     DrawCenter
*--------------------------------
DspWord  MOVE    D0,-(SP)
         LSR     #8,D0
         BSR.S   DspByte
         MOVE    (SP)+,D0
DspByte  MOVE.B  D0,-(SP)
         LSR.B   #4,D0
         BSR.S   DspDigit
         MOVE.B  (SP)+,D0
DspDigit AND.B   #$0F,D0
         OR.B    #$30,D0
         CMP.B   #$3A,D0
         BLO.S   .0
         ADDQ.B  #7,D0
.0       MOVE.B  D0,(A0)+
         RTS
*--------------------------------
RestScrn LINK    A6,#-2
         MOVE    #3,-2(A6)
.0       MOVE    #$0141,D0
         BSR     EVENT0
         SUBQ    #1,-2(A6)
         BNE.S   .0
         UNLK    A6
         RTS
IDLEX    MOVE.L  Window1(A5),-(SP)
         _SetPort
         _SystemTask
         BSR     IDLITE
         MOVE    #$0141,D0
         BSR     EVENT0
         MOVE.L  DialPtr(A5),-(SP)
         _SetPort
         BSR     TrackAb
         MOVE.L  Ticks,D1
         CMP.L   XTimeT(A5),D1
         BLO.S   .0
         ADD.L   #60,XTimeT(A5)
         SUB.L   XTime(A5),D1
         BSR     DSPHR
         MOVE    #0,-(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         LEA     XRC5(PC),A2
         LEA     DskNam(A5),A3
         MOVE    #14,D3
         BSR     DrawCenter
.0       RTS
TrackAb  CLR.B   -(SP)
         MOVE    #$002F,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   TrAbRt
         MOVE    What(A5),D0
         ADD     D0,D0
         MOVE    TrkTbl(PC,D0),D0
         JMP     TrkTbl(PC,D0)
TrkTbl   DATA    /TrAbRt-TrkTbl
         DATA    /TrAbMD-TrkTbl
         DATA    /TrAbMU-TrkTbl
         DATA    /TrAbKD-TrkTbl
         DATA    /TrAbRt-TrkTbl
         DATA    /TrAbKD-TrkTbl
TrAbRt   TST.B   XRB0Trk(A5)
         BEQ.S   .2
         PEA     Where(A5)
         _GetMouse
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     XRB0(PC)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .0
.2       TST.B   XRB0Fl(A5)
         BEQ.S   .1
         LEA     XRB0(PC),A2
         BSR     BInvert
         CLR.B   XRB0Fl(A5)
         BRA.S   .1
.0       TST.B   XRB0Fl(A5)
         BNE.S   .1
         LEA     XRB0(PC),A2
         BSR     BInvert
         MOVE.B  #1,XRB0Fl(A5)
.1       RTS
TrAbMD   PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     XRB0(PC)
         _PtInRect
         TST.B   (SP)+
         BNE.S   .0
         MOVE    #4,-(SP)
         _SysBeep
         BRA.S   .1
.0       MOVE.B  #1,XRB0Trk(A5)
.1       BRA     TrAbRt
TrAbMU   TST.B   XRB0Trk(A5)
         BEQ.S   .0
         CLR.B   XRB0Trk(A5)
         PEA     Where(A5)
         _GlobalToLocal
         CLR.B   -(SP)
         MOVE.L  Where(A5),-(SP)
         PEA     XRB0(PC)
         _PtInRect
         TST.B   (SP)+
         BEQ.S   .0
         MOVE.B  #1,AbortFl(A5)
.0       BRA     TrAbRt
TrAbKD   MOVE    Modify(A5),D0
         BTST    #8,D0
         BNE.S   .1
         MOVE.L  Message(A5),D0
         CMP.B   #$03,D0
         BEQ.S   .0
         CMP.B   #$0D,D0
         BNE.S   .1
.0       MOVE.B  #1,AbortFl(A5)
.1       BRA     TrAbRt
MaxTxt   MOVE.L  DataLen(A5),D0
         ADD.L   #127,D0
         LSR.L   #7,D0
         MOVE    D0,MaxBlk(A5)
         RTS
MaxBin   MOVE.L  DataLen(A5),D0
         ADD.L   #127,D0
         AND.L   #$FFFFFF80,D0
         MOVE.L  RsrcLen(A5),D1
         ADD.L   #127,D1
         AND.L   #$FFFFFF80,D1
         ADD.L   D1,D0
         ADD.L   #128,D0
         LSR.L   #7,D0
         MOVE    D0,MaxBlk(A5)
         RTS
DRBLK    MOVE    #'R,-(SP)
         BRA.S   DBLK
DSBLK    MOVE    #'S,-(SP)
DBLK     LEA     XRC1(PC),A2
         BSR     CScroll
         _DrawChar
         PEA     Xm0(PC)
         _DrawString
         MOVE    BLOCK(A5),D1
         BSR     DSPNUM
         PEA     DskNam(A5)
         _DrawString
         PEA     Xm1(PC)
         _DrawString
         MOVE    #129,-(SP)
         _TextFont
         MOVE    #18,-(SP)
         _TextSize
         MOVE    #0,-(SP)
         _TextMode
         MOVE    MAXBLK(A5),D1
         BEQ.S   .0
         SUB     BLOCK(A5),D1
         BCC.S   .1
         CLR     D1
         BRA.S   .1
.0       MOVE    BLOCK(A5),D1
.1       MOVEQ   #4,D2
         BSR     DSPNM0
         LEA     XRC2(PC),A2
         LEA     DskNam(A5),A3
         MOVE    #22,D3
         BSR     DrawCenter
         RTS
CMPLT    LEA     XRC1(PC),A2
         BSR     CScroll
         PEA     Xm9(PC)
         _DrawString
         BRA.S   RTERR
TOERR    PEA     Xm2(PC)
         BRA.S   DDERR
NAKERR   PEA     Xm3(PC)
         BRA.S   DDERR
CSERR    PEA     Xm4(PC)
         BRA.S   DDERR
WBERR    PEA     Xm5(PC)
         BRA.S   DDERR
SYERR    PEA     Xm6(PC)
         BRA.S   DDERR
CRCERR   PEA     Xm10(PC)
         BRA.S   DDERR
BNERR    PEA     Xm11(PC)
DDERR    LEA     XRC1(PC),A2
         BSR     CScroll
         _DrawString
         PEA     Xm7(PC)
         _DrawString
         BRA.S   INVERR
ABERR    LEA     XRC1(PC),A2
         BSR     CScroll
         PEA     Xm8(PC)
         _DrawString
INVERR   MOVE    XRC1+6(PC),-(SP)
         SUB     #2,(SP)
         MOVE    XRC1+4(PC),-(SP)
         SUB     #2,(SP)
         MOVE    XRC1+2(PC),-(SP)
         ADD     #2,(SP)
         MOVE    XRC1+4(PC),-(SP)
         SUB     #13,(SP)
         MOVE.L  A7,-(SP)
         _InverRect
         ADDQ    #8,A7
RTERR    MOVE    #0,-(SP)
         _TextMode
         RTS
INIXMOD  MOVE.L  Window1(A5),-(SP)
         _SetPort
         MOVE    DBITS(A5),-(SP)
         MOVE    PARITY(A5),-(SP)
         MOVE    #1,DBITS(A5)
         MOVE    #0,PARITY(A5)
         BSR     INIPROT
         BSR     SETDPRO
         BSR     DISCR2
         MOVE    (SP)+,PARITY(A5)
         MOVE    (SP)+,DBITS(A5)
         MOVE.L  DialPtr(A5),-(SP)
         _SetPort
         RTS
RESXMOD  MOVE.L  Window1(A5),-(SP)
         _SetPort
         BSR     INIPROT
         BSR     SETDPRO
         BSR     DISCR2
         MOVE.L  DialPtr(A5),-(SP)
         _SetPort
         RTS
DSPNUM   MOVEQ   #3,D2
DSPNM0   LEA     TenExp(PC),A0
         LEA     DskNam(A5),A1
         CLR.B   (A1)+
         MOVEQ   #5,D4
.0       MOVEQ   #'0,D0
.1       MOVE    D1,D3
         SUB     (A0),D3
         BCS.S   .2
         MOVE    D3,D1
         ADDQ.B  #1,D0
         BRA.S   .1
.2       CMP.B   #'0,D0
         BNE.S   .3
         CMP.B   D4,D2
         BLO.S   .4
.3       MOVEQ   #5,D2
         MOVE.B  D0,(A1)+
         ADDQ.B  #1,DskNam(A5)
.4       ADDQ.L  #2,A0
         SUBQ.B  #1,D4
         BNE.S   .0
         RTS
TenExp   DATA    /10000
         DATA    /1000
         DATA    /100
         DATA    /10
         DATA    /1
DSPHR    LEA     HrExp(PC),A0
         LEA     DskNam(A5),A1
         MOVE.B  #5,(A1)+
         MOVEQ   #4,D3
.0       MOVEQ   #'0,D0
.1       MOVE.L  D1,D2
         SUB.L   (A0),D2
         BCS.S   .2
         MOVE.L  D2,D1
         ADDQ.B  #1,D0
         BRA.S   .1
.2       CMP.B   #2,D3
         BNE.S   .3
         MOVE.B  #':,(A1)+
.3       MOVE.B  D0,(A1)+
         ADDQ.L  #4,A0
         SUBQ.B  #1,D3
         BNE.S   .0
         RTS
HrExp    DATA    36000
         DATA    3600
         DATA    600
         DATA    60
Beeps    BRA.S   .2
.0       MOVE.L  Ticks,D0
         ADD.L   #4,D0
.1       CMP.L   Ticks,D0
         BHI.S   .1
.2       MOVE    #4,-(SP)
         _SysBeep
         SUBQ    #1,D7
         BNE.S   .0
         RTS
Rcv0     CLR     F.Rcv(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #1,-(SP)
         PEA     StrRcFl(PC)
         _SetItem
         MOVE    #2,-(SP)
         PEA     StrPaRc(PC)
         _SetItem
         MOVE    #2,-(SP)
         _DisableItem
         MOVEQ   #1,D0
         BSR     OFFLITE
         RTS
Rcv1     MOVE    #1,F.Rcv(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #1,-(SP)
         PEA     StrAbRc(PC)
         _SetItem
         MOVE    #2,-(SP)
         PEA     StrPaRc(PC)
         _SetItem
         MOVE    #2,-(SP)
         _EnableItem
         MOVEQ   #1,D0
         BSR     BLKLITE
         RTS
Rcv2     MOVE    #2,F.Rcv(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #1,-(SP)
         PEA     StrAbRc(PC)
         _SetItem
         MOVE    #2,-(SP)
         PEA     StrRsRc(PC)
         _SetItem
         MOVE    #2,-(SP)
         _EnableItem
         MOVEQ   #1,D0
         BSR     ONLITE
         RTS
*--------------------------------
BegXRcv  BSR     Rcv1
         PEA     SFRPut+fName(A5)
         BRA.S   BegX
BegXSnd  BSR     Snd1
         PEA     SFRGet+fName(A5)
BegX     CLR.L   -(SP)
         CLR.L   -(SP)
         PEA     XRW0(PC)
         PEA     NullStr(PC)
         MOVE.B  #1,-(SP)
         MOVE    #32,-(SP)
         MOVE.L  #-1,-(SP)
         CLR.B   -(SP)
         CLR.L   -(SP)
         _NewWindow
         MOVE.L  (SP),DialPtr(A5)
         _SetPort
;
         MOVE    #0,-(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         MOVE    #0,-(SP)
         _TextFace
         MOVE    #1,-(SP)
         _TextMode
         LEA     XRB0(PC),A2
         BSR     FrBton
         LEA     XRB0Str(PC),A3
         MOVE    #17,D3
         BSR     DrawCenter
         CLR.B   XRB0Fl(A5)
         CLR.B   XRB0Trk(A5)
         CLR.B   AbortFl(A5)
;
         MOVE    #0,-(SP)
         _TextMode
         LEA     XRC0(PC),A2
         BSR     FrDisp
         MOVE.L  (SP)+,A3
         BSR     ClipString
         MOVE    #15,D3
         BSR     DrawCenter
;
         LEA     XRC1(PC),A2
         BSR     FrDisp
;
         MOVE    #129,-(SP)
         _TextFont
         MOVE    #18,-(SP)
         _TextSize
         LEA     XRC2(PC),A2
         BSR     FrDisp
         LEA     NumStr(PC),A3
         MOVE    #22,D3
         BSR     DrawCenter
;
         LEA     XRC3(PC),A2
         BSR     FrDisp
         LEA     XRC3Str(PC),A3
         MOVE    #18,D3
         BSR     DrawCenter
         CLR.B   XRC3Fl(A5)
;
         LEA     XRC4(PC),A2
         BSR     FrDisp
         LEA     XRC4Str(PC),A3
         MOVE    #18,D3
         BSR     DrawCenter
         CLR.B   XRC4Fl(A5)
;
         MOVE    #0,-(SP)
         _TextFont
         MOVE    #12,-(SP)
         _TextSize
         LEA     XRC5(PC),A2
         BSR     FrDisp
         LEA     XRC5Str(PC),A3
         MOVE    #14,D3
         BSR     DrawCenter
;
         RTS
EndXRcv  BSR     EndX
         BSR     Rcv0
         RTS
EndXSnd  BSR     EndX
         BSR     Snd0
         RTS
EndX     MOVE.L  DialPtr(A5),-(SP)
         _DisposWindow
         MOVE.L  Window1(A5),-(SP)
         _SetPort
         RTS
*--------------------------------
ARWRCV   TST.B   XRC3Fl(A5)
         BNE.S   .0
         LEA     XRC3(PC),A2
         BSR     CInvert
         MOVE.B  #1,XRC3Fl(A5)
.0       TST.B   XRC4Fl(A5)
         BEQ.S   .1
         LEA     XRC4(PC),A2
         BSR     CInvert
         CLR.B   XRC4Fl(A5)
.1       RTS
ARWSND   TST.B   XRC4Fl(A5)
         BNE.S   .0
         LEA     XRC4(PC),A2
         BSR     CInvert
         MOVE.B  #1,XRC4Fl(A5)
.0       TST.B   XRC3Fl(A5)
         BEQ.S   .1
         LEA     XRC3(PC),A2
         BSR     CInvert
         CLR.B   XRC3Fl(A5)
.1       RTS
*--------------------------------
* A2=Rect
*--------------------------------
FrDisp   LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         _PenNormal
         PEA     -8(A6)
         _EraseRect
         PEA     -8(A6)
         MOVE    #1,-(SP)
         MOVE    #0,-(SP)
         _InsetRect
         PEA     -8(A6)
         _FrameRect
         PEA     -8(A6)
         MOVE    #-1,-(SP)
         MOVE    #1,-(SP)
         _InsetRect
         PEA     -8(A6)
         _FrameRect
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
FrBton   LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         _PenNormal
         MOVE    #10,-(SP)
         _PenMode
         PEA     -8(A6)
         _EraseRect
         PEA     -8(A6)
         MOVE    #1,-(SP)
         MOVE    #0,-(SP)
         _InsetRect
         PEA     -8(A6)
         _FrameRect
         PEA     -8(A6)
         MOVE    #-1,-(SP)
         MOVE    #1,-(SP)
         _InsetRect
         PEA     -8(A6)
         _FrameRect
         PEA     -8(A6)
         MOVE    #3,-(SP)
         MOVE    #2,-(SP)
         _InsetRect
         PEA     -8(A6)
         _FrameRect
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect, A3=String
*--------------------------------
ClipString
         MOVE.L  A3,A0
         LEA     ClpNam(A5),A1
         MOVE.L  A1,A3
         BSR     CopyStr
         MOVE    6(A2),D3
         SUB     2(A2),D3
         SUBQ    #6,D3
         CLR     -(SP)
         MOVE.L  A3,-(SP)
         _StringWidth
         CMP     (SP)+,D3
         BGE.S   .2
         SUBQ.B  #1,(A3)
         CLR     -(SP)
         MOVE    #'…,-(SP)
         _CharWidth
         SUB     (SP)+,D3
.0       CLR     -(SP)
         MOVE.L  A3,-(SP)
         _StringWidth
         CMP     (SP)+,D3
         BGE.S   .1
         SUBQ.B  #1,(A3)
         BNE.S   .0
.1       ADDQ.B  #1,(A3)
         MOVEQ   #0,D0
         MOVE.B  (A3),D0
         MOVE.B  #'…,0(A3,D0)
.2       RTS
*--------------------------------
* A2=Rect, A3=String, D3=∂Y
*--------------------------------
DrawCenter
         LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00020002,-(SP)
         _InsetRect
         CLR.L   -(SP)
         _NewRgn
         MOVE.L  (SP),A4
         _GetClip
         PEA     -8(A6)
         _ClipRect
         CLR     -(SP)
         MOVE.L  A3,-(SP)
         _StringWidth
         MOVE    6(A2),D0
         SUB     2(A2),D0
         SUB     (SP)+,D0
         ASR     #1,D0
         ADD     2(A2),D0
         MOVE    D0,-(SP)
         MOVE    (A2),-(SP)
         ADD     D3,(SP)
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
CScroll  LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00020002,-(SP)
         _InsetRect
         CLR.L   -(SP)
         _NewRgn
         MOVE.L  (SP)+,A3
         PEA     -8(A6)
         CLR     -(SP)
         MOVE    #-11,-(SP)
         MOVE.L  A3,-(SP)
         _ScrollRect
         MOVE.L  A3,-(SP)
         _DisposRgn
         MOVE    #128,-(SP)
         _TextFont
         MOVE    #9,-(SP)
         _TextSize
         MOVE    #1,-(SP)
         _TextMode
         MOVE    2(A2),-(SP)
         ADD     #4,(SP)
         MOVE    4(A2),-(SP)
         SUB     #4,(SP)
         _MoveTo
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
CErase   LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00020002,-(SP)
         _InsetRect
         PEA     -8(A6)
         _EraseRect
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
CInvert  LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00030003,-(SP)
         _InsetRect
         PEA     -8(A6)
         _InverRect
         UNLK    A6
         RTS
*--------------------------------
* A2=Rect
*--------------------------------
BInvert  LINK    A6,#-8
         MOVE.L  (A2),-8(A6)
         MOVE.L  4(A2),-4(A6)
         PEA     -8(A6)
         MOVE.L  #$00040004,-(SP)
         _InsetRect
         PEA     -8(A6)
         _InverRect
         UNLK    A6
         RTS
*--------------------------------
XRW0     DATA    /44,/335,/200,/487
XRB0     DATA    /124,/97,/149,/145
XRC0     DATA    /7,/7,/28,/145
XRC1     DATA    /35,/7,/149,/74
XRC2     DATA    /35,/81,/63,/145
XRC3     DATA    /70,/81,/91,/111
XRC4     DATA    /70,/115,/91,/145
XRC5     DATA    /98,/81,/117,/145
NullStr  STR     ""
XRB0Str  STR     "Abort"
NumStr   STR     "0000"
XRC3Str  HEX     0180
XRC4Str  HEX     0181
XRC5Str  STR     "00:00"
Prompts  STR     "Save document as:"
DfltNam  STR     "?"
StrRcFl  STR     "Receive File…"
StrAbRc  STR     "End Receive"
StrPaRc  STR     "Pause Receive"
StrRsRc  STR     "Resume Receive"
Xm0      STR     "   ["
Xm1      STR     "]"
Xm2      STR     "T   "
Xm3      STR     "NAK "
Xm4      STR     "CS  "
Xm5      STR     "WB  "
Xm6      STR     "SYC "
Xm7      STR     "[ERR]"
Xm8      STR     "[Abort]"
Xm9      STR     "[Complete]"
Xm10     STR     "CRC "
Xm11     STR     "BD# "
         ADJST
*--------------------------------
Snd0     CLR     F.Snd(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #4,-(SP)
         PEA     StrSnFl(PC)
         _SetItem
         MOVE    #5,-(SP)
         PEA     StrPaSn(PC)
         _SetItem
         MOVE    #5,-(SP)
         _DisableItem
         MOVEQ   #2,D0
         BSR     OFFLITE
         RTS
Snd1     MOVE    #1,F.Snd(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #4,-(SP)
         PEA     StrAbSn(PC)
         _SetItem
         MOVE    #5,-(SP)
         PEA     StrPaSn(PC)
         _SetItem
         MOVE    #5,-(SP)
         _EnableItem
         MOVEQ   #2,D0
         BSR     BLKLITE
         RTS
Snd2     MOVE    #2,F.Snd(A5)
         CLR.L   -(SP)
         MOVE    #2,-(SP)
         _GetMHandle
         MOVE.L  (SP),-(SP)
         MOVE.L  (SP),-(SP)
         MOVE    #4,-(SP)
         PEA     StrAbSn(PC)
         _SetItem
         MOVE    #5,-(SP)
         PEA     StrRsSn(PC)
         _SetItem
         MOVE    #5,-(SP)
         _EnableItem
         MOVEQ   #2,D0
         BSR     ONLITE
         RTS
TypeList ASC     "TEXT"
StrSnFl  STR     "Send File…"
StrAbSn  STR     "Abort Send"
StrPaSn  STR     "Pause Send"
StrRsSn  STR     "Resume Send"
         ADJST
*--------------------------------
TRANSFER CLR.L   -(SP)
         MOVE    #3,-(SP)
         CLR.L   -(SP)
         MOVE.L  #-1,-(SP)
         _GetNewDialog
         MOVE.L  (SP)+,DialPtr(A5)
         BSR     INITRA
         MOVE.L  DialPtr(A5),-(SP)
         _ShowWindow
TRALP    CLR.L   -(SP)
         PEA     ItmHit(A5)
         _ModalDialog
         MOVE    ItmHit(A5),D0
         ADD     D0,D0
         MOVE    TRTBL(PC,D0),D0
         JMP     TRTBL(PC,D0)
TRTBL    DATA    /TRALP-TRTBL
         DATA    /TROK-TRTBL
         DATA    /TRCAN-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRMODE-TRTBL
         DATA    /TRMODE-TRTBL
         DATA    /TRMODE-TRTBL
         DATA    /TRMODE-TRTBL
         DATA    /TRTOUT-TRTBL
         DATA    /TRTOUT-TRTBL
         DATA    /TRTOUT-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
         DATA    /TRALP-TRTBL
TROK     MOVE    #15,D6
         BSR     GETTXT
         BSR     CNVNUM
         MOVE.L  D0,T.CPace(A5)
         MOVE    #16,D6
         BSR     GETTXT
         BSR     CNVNUM
         MOVE.L  D0,T.LPace(A5)
         MOVE    #17,D6
         BSR     GETTXT
         MOVE.B  DskNam(A5),D0
         BEQ.S   .3
         MOVE.B  DskNam+1(A5),D0
         CMP.B   #'^,D0
         BNE.S   .3
         CMP.B   #2,DskNam(A5)
         BLO.S   .3
         MOVE.B  DskNam+2(A5),D1
         CMP.B   #$7F,D1
         BHI.S   .3
         CMP.B   #$60,D1
         BLO.S   .0
         AND.B   #$5F,D1
.0       CMP.B   #$3F,D1
         BLO.S   .3
         BNE.S   .1
         MOVEQ   #$7F,D1
         BRA.S   .2
.1       AND.B   #$3F,D1
.2       MOVE.B  D1,D0
.3       MOVE.B  D0,T.Prompt(A5)
         MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         ORI     #1,CCR
         RTS
TRCAN    MOVE.L  DialPtr(A5),-(SP)
         _DisposDialog
         ANDI    #$FE,CCR
         RTS
TRMODE   MOVE    T.Mode(A5),D6
         ADD     #5,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #5,D0
         MOVE    D0,T.Mode(A5)
         BRA     TRALP
TRTOUT   MOVE    T.TmOut(A5),D6
         ADD     #9,D6
         BSR     CLRCTL
         MOVE    ItmHit(A5),D6
         BSR     SETCTL
         MOVE    ItmHit(A5),D0
         SUB     #9,D0
         MOVE    D0,T.TmOut(A5)
         BRA     TRALP
INITRA   MOVE    T.Mode(A5),D6
         ADD     #5,D6
         BSR     SETCTL
         MOVE    T.TmOut(A5),D6
         ADD     #9,D6
         BSR     SETCTL
         LEA     DskNam(A5),A0
         MOVE.L  T.CPace(A5),D0
         MOVE    #0,-(SP)
         _Pack7
         MOVE    #15,D6
         BSR     SETTXT
         LEA     DskNam(A5),A0
         MOVE.L  T.LPace(A5),D0
         MOVE    #0,-(SP)
         _Pack7
         MOVE    #16,D6
         BSR     SETTXT
         LEA     DskNam(A5),A0
         MOVE.B  T.Prompt(A5),D0
         BEQ.S   .2
         CMP.B   #$20,D0
         BLO.S   .0
         CMP.B   #$7F,D0
         BNE.S   .1
         MOVEQ   #'?-$40,D0
.0       ADD.B   #$40,D0
         MOVE.B  D0,2(A0)
         MOVE.B  #'^,1(A0)
         MOVEQ   #2,D0
         BRA.S   .2
.1       MOVE.B  D0,1(A0)
         MOVEQ   #1,D0
.2       MOVE.B  D0,(A0)
         MOVE    #17,D6
         BSR     SETTXT
         RTS
SETTXT   MOVE.L  A0,D7
         MOVE.L  DialPtr(A5),-(SP)
         MOVE    D6,-(SP)
         PEA     DTYPE(A5)
         PEA     DITEM(A5)
         PEA     DBOX(A5)
         _GetDItem
         MOVE.L  DITEM(A5),-(SP)
         MOVE.L  D7,-(SP)
         _SetIText
         RTS
GETTXT   MOVE.L  DialPtr(A5),-(SP)
         MOVE    D6,-(SP)
         PEA     DTYPE(A5)
         PEA     DITEM(A5)
         PEA     DBOX(A5)
         _GetDItem
         MOVE.L  DITEM(A5),-(SP)
         PEA     DskNam(A5)
         _GetIText
         RTS
CNVNUM   LEA     DskNam(A5),A0
         MOVE    #1,-(SP)
         _Pack7
         RTS
*--------------------------------
         END
