;SAVE"GrDrvr.Asm"
*--------------------------------
         LIST    ON
*--------------------------------
; Graphic Driver v1.0
*--------------------------------
         LIST    OFF
*================================
ChkGrph  CMP     #4,ColCrs(A5)
         BNE.S   .1
         CMP.L   #$2347414C,ShStr+12(A5)
         BEQ.S   .0
         CMP.L   #$2367616C,ShStr+12(A5)
         BNE.S   .1
.0       BSR     GrDrvr
.1       RTS
LCUC     CMP.B   #'a,D0
         BLO.S   .0
         CMP.B   #'z,D0
         BHI.S   .0
         AND.B   #$5F,D0
.0       RTS
LETTER   BSR     LCUC
         CMP.B   #'A,D0
         BLO.S   CHNOK
         CMP.B   #'Z,D0
         BHI.S   CHNOK
CHOK     OR      #1,CCR
         RTS
DIGIT    CMP.B   #'0,D0
         BLO.S   CHNOK
         CMP.B   #'9,D0
         BLS.S   CHOK
CHNOK    AND     #$FE,CCR
         RTS
ClipIt   MOVE.L  D0,-(SP)
         MOVE.L  Region1(A5),-(SP)
         _GetClip
         PEA     ClpRct(PC)
         _ClipRect
         MOVE.L  (SP)+,D0
         RTS
UnClip   MOVE.L  D0,-(SP)
         MOVE.L  Region1(A5),-(SP)
         _SetClip
         MOVE.L  (SP)+,D0
         RTS
GNCHR    BSR     IDLE
         BSR     SEND
         BSR     GTLEN
         BEQ.S   GNCHR
         BSR     GET1CHR
         CMP.B   #$20,D0
         BLS.S   GNCHR
         BSR     Save1B
         RTS
GNCHR0   BSR     IDLE
         BSR     SEND
         BSR     GTLEN
         BEQ.S   GNCHR0
         BSR     GET1CHR
         CMP.B   #$20,D0
         BLO.S   GNCHR0
         BSR     Save1B
         RTS
GrDrvr   MOVEQ   #6,D0
         BSR     BLKLITE
         BSR     OffCrs
         MOVE.L  Ticks,CrsTime(A5)
         BSR     DoFF
         MOVE    #23,RowCrs(A5)
         PEA     ClpRct(PC)
         _FrameRect
GrDr     BSR     GNCHR
Gr8      BSR     LETTER
         BCC.S   .0
         MOVE.B  D0,TEMPCH(A5)
         BSR     GNCHR
         BSR     LETTER
         BCS.S   .1
.0       _PenNormal
         BSR     INITXT
         MOVEQ   #6,D0
         BRA     OFFLITE
.1       MOVE.B  D0,TEMPCH+1(A5)
         CLR     PARPTR(A5)
.2       CLR     TEMPNM(A5)
         CLR.B   FlNm(A5)
.3       BSR     GNCHR
         BSR     DIGIT
         BCC.S   .4
         AND     #$F,D0
         MOVE    TEMPNM(A5),D1
         MOVE    D1,D2
         LSL     #2,D1
         ADD     D2,D1
         LSL     #1,D1
         ADD     D0,D1
         MOVE    D1,TEMPNM(A5)
         MOVE.B  #1,FlNm(A5)
         BRA.S   .3
.4       TST.B   FlNm(A5)
         BEQ.S   .9
         LEA     PARAM0(A5),A0
         MOVE    PARPTR(A5),D1
         MOVE    TEMPNM(A5),0(A0,D1)
.9       CMP     #10,PARPTR(A5)
         BEQ.S   .5
         ADDQ    #2,PARPTR(A5)
.5       CMP.B   #',',D0
         BEQ.S   .2
         MOVE.B  D0,TEMPNM(A5)
         LEA     TOPC(PC),A0
         LEA     TOFF(PC),A1
         MOVE    TEMPCH(A5),D0
.6       TST     (A0)
         BEQ.S   .0
         CMP     (A0)+,D0
         BEQ.S   .7
         ADDQ.L  #2,A1
         BRA.S   .6
.7       MOVE    (A1),D0
         BSR     ClipIt
         JSR     Gr(PC,D0)
         BSR     UnClip
         MOVE.B  TEMPNM(A5),D0
         BRA     Gr8
Gr
GrPS     MOVE    PARAM0(A5),-(SP)
         MOVE    PARAM1(A5),-(SP)
         _PenSize
         RTS
GrPM     MOVE    PARAM0(A5),-(SP)
         _PenMode
         RTS
GrPP     PEA     PARAM0(A5)
         _PenPat
         RTS
GrPN     _PenNormal
         RTS
GrMT     MOVE    PARAM0(A5),D0
         ADD     #11,D0
         MOVE    D0,-(SP)
         MOVE    PARAM1(A5),D0
         ADD     #8,D0
         MOVE    D0,-(SP)
         _MoveTo
         RTS
GrMV     MOVE    PARAM0(A5),-(SP)
         MOVE    PARAM1(A5),-(SP)
         _Move
         RTS
GrLT     MOVE    PARAM0(A5),D0
         ADD     #11,D0
         MOVE    D0,-(SP)
         MOVE    PARAM1(A5),D0
         ADD     #8,D0
         MOVE    D0,-(SP)
         _LineTo
         RTS
GrLN     MOVE    PARAM0(A5),-(SP)
         MOVE    PARAM1(A5),-(SP)
         _Line
         RTS
GrTF     MOVE    PARAM0(A5),-(SP)
         _TextFont
         RTS
GrTA     MOVE    PARAM0(A5),-(SP)
         _TextFace
         RTS
GrTM     MOVE    PARAM0(A5),-(SP)
         _TextMode
         RTS
GrTS     MOVE    PARAM0(A5),-(SP)
         _TextSize
         RTS
GrDS     TST.L   (SP)+
         MOVE    #256,TEMPCH(A5)
.0       BSR     UnClip
         BSR     GNCHR0
         CMP.B   TEMPNM(A5),D0
         BEQ.S   .1
         BSR     ClipIt
         MOVE    D0,-(SP)
         _DrawChar
         SUBQ    #1,TEMPCH(A5)
         BNE.S   .0
         BSR     UnClip
.1       BRA     GrDr
OffRect  MOVE.L  PARAM0(A5),Rect(A5)
         MOVE.L  PARAM2(A5),Rect+4(A5)
         ADD     #8,Rect(A5)
         ADD     #11,Rect+2(A5)
         ADD     #8,Rect+4(A5)
         ADD     #11,Rect+6(A5)
         RTS
GrFR     BSR     OffRect
         PEA     Rect(A5)
         _FrameRect
         RTS
GrPR     BSR     OffRect
         PEA     Rect(A5)
         _PaintRect
         RTS
GrER     BSR     OffRect
         PEA     Rect(A5)
         _EraseRect
         RTS
GrIR     BSR     OffRect
         PEA     Rect(A5)
         _InverRect
         RTS
GrFO     BSR     OffRect
         PEA     Rect(A5)
         _FrameOval
         RTS
GrPO     BSR     OffRect
         PEA     Rect(A5)
         _PaintOval
         RTS
GrEO     BSR     OffRect
         PEA     Rect(A5)
         _EraseOval
         RTS
GrIO     BSR     OffRect
         PEA     Rect(A5)
         _InvertOval
         RTS
GrFD     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _FrameRoundRect
         RTS
GrPD     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _PaintRoundRect
         RTS
GrED     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _EraseRoundRect
         RTS
GrID     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _InverRoundRect
         RTS
GrFA     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _FrameArc
         RTS
GrPA     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _PaintArc
         RTS
GrEA     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _EraseArc
         RTS
GrIA     BSR     OffRect
         PEA     Rect(A5)
         MOVE    PARAM4(A5),-(SP)
         MOVE    PARAM5(A5),-(SP)
         _InvertArc
         RTS
GrWT     TST.L   (SP)+
         BSR     UnClip
         MOVEQ   #DC3,D0
         BSR     PUT1CHR
         CLR.L   -(SP)
         _TickCount
         CLR.L   D0
         MOVE    PARAM0(A5),D0
         ADD.L   D0,(SP)
.0       BSR     IDLE
         CLR.L   -(SP)
         _TickCount
         MOVE.L  (SP)+,D0
         CMP.L   (SP),D0
         BLO.S   .0
         TST.L   (SP)+
         MOVEQ   #DC1,D0
         BSR     PUT1CHR
         MOVE.B  TEMPNM(A5),D0
         BRA     Gr8
ClpRct   DATA    /8,/11,/261,/491
TOPC     ASC     'PSPMPPPNMTMVLTLNTFTATMTSDS'
         ASC     'FRPRERIRFOPOEOIOFDPDEDID'
         ASC     'FAPAEAIAWT'
         DATA    /0
TOFF     DATA    /GrPS-Gr,/GrPM-Gr,/GrPP-Gr,/GrPN-Gr
         DATA    /GrMT-Gr,/GrMV-Gr,/GrLT-Gr,/GrLN-Gr
         DATA    /GrTF-Gr,/GrTA-Gr,/GrTM-Gr,/GrTS-Gr
         DATA    /GrDS-Gr,/GrFR-Gr,/GrPR-Gr,/GrER-Gr
         DATA    /GrIR-Gr,/GrFO-Gr,/GrPO-Gr,/GrEO-Gr
         DATA    /GrIO-Gr,/GrFD-Gr,/GrPD-Gr,/GrED-Gr
         DATA    /GrID-Gr,/GrFA-Gr,/GrPA-Gr,/GrEA-Gr
         DATA    /GrIA-Gr,/GrWT-Gr
*--------------------------------
MINBBS   MOVE.L  HndTMSF(A5),-(SP)
         MOVE.L  (SP),A0
         MOVE.L  (A0),A0
         MOVE.B  #1,4(A0)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         _HideCursor
         CLR.B   MesBuf(A5)
         CLR.L   CallCnt(A5)
         LEA     MacroX(PC),A0
         BSR     CvMacro
         LEA     TermDefX(PC),A0
         BSR     CvTerm
         BSR     DispKeys
         BSR     GTCTS
         BNE.S   .0
         MOVE.B  #0,F.CTS(A5)
         BRA.S   .1
.0       MOVE.B  #1,F.CTS(A5)
.1       MOVE    #1,DBITS(A5)
         MOVE    #4,PARITY(A5)
         MOVE    #0,SBITS(A5)
Reset    AND.B   #$7F,F.CTS(A5)
         MOVE    #1,BAUDR(A5)
         BSR     UpdProt
.0       BSR     Quiet
         MOVE.B  #1,Device(A5)
         LEA     StrIni1(PC),A0
         BSR     SndCom
         TST.B   D0
         BEQ.S   .2
         CMP.B   #$FC,D0
         BEQ     Local
         CMP.B   #$FF,D0
         BNE.S   .1
         OR.B    #$80,F.CTS(A5)
.1       MOVEQ   #CR,D0
         BSR     PUT1CHR
         BRA.S   .0
.2       CLR.B   Device(A5)
         LEA     StrCaRe(PC),A0
         BSR     SndStr
         LEA     DskNam(A5),A0
         MOVE.L  CallCnt(A5),D0
         MOVE    #0,-(SP)
         _Pack7
         BSR     SndStr
         TST.B   F.BBS(A5)
         BEQ.S   .3
         LEA     StrPwOt(PC),A0
         BSR     SndStr
.3       LEA     StrWait(PC),A0
         BSR     SndStr
Wait     MOVE.B  #1,Device(A5)
         BSR     GetCom
         TST.B   D0
         BNE.S   .3
         CLR     D1
         MOVE.B  XBuf(A5),D1
         CMP     #4,D1
         BLO.S   Wait
         SUBQ    #4,D1
         LEA     XBuf+1(A5),A0
         ADD     D1,A0
         MOVEQ   #4-1,D1
.0       LSL.L   #8,D0
         MOVE.B  (A0)+,D0
         DBRA    D1,.0
         CMP.L   #$4E454354,D0
         BEQ.S   Logon
         CMP.L   #$20333030,D0
         BEQ.S   Logon
         CMP.L   #$31323030,D0
         BNE.S   .1
         MOVE    #2,BAUDR(A5)
         BRA.S   .2
.1       CMP.L   #$32343030,D0
         BNE.S   Wait
         MOVE    #3,BAUDR(A5)
.2       BSR     UpdProt
         BRA.S   Logon
.3       CMP.B   #$FE,D0
         BEQ.S   Wait
         CMP.B   #$FC,D0
         BNE     Reset
         LEA     StrNA(PC),A0
         BSR     SndCom
Local    CLR.B   Device(A5)
         BRA.S   Log0
Logon    BSR     Wait1S
Log0     ADDQ.L  #1,CallCnt(A5)
Men0     LEA     LstMen1(PC),A0
         BSR     SndLst
Com0     LEA     StrCom(PC),A0
         BSR     SndStr
.0       BSR     GTLEN
         BEQ.S   .1
         BSR     GET1CHR
         BRA.S   .0
.1       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   Special
         CMP.B   #CR,D0
         BEQ.S   Men0
         BSR     LCUC
         CMP.B   #'R,D0
         BEQ     ReadFSys
         CMP.B   #'L,D0
         BEQ     LeavTSys
         CMP.B   #'D,D0
         BEQ     DownB
         CMP.B   #'U,D0
         BEQ     UpB
         CMP.B   #'C,D0
         BEQ     Chat
         CMP.B   #'G,D0
         BEQ.S   GoodB
         CMP.B   #'Z,D0
         BEQ     SysZ
         BRA.S   .1
Special  CMP.B   #$FC,D0
         BEQ     BrkChat
         CMP.B   #$FD,D0
         BNE.S   .0
         LEA     StrIL(PC),A0
         BRA.S   Discon
.0       CMP.B   #$FE,D0
         BNE.S   Clean
         LEA     StrTO(PC),A0
Discon   BSR     SndStr
         LEA     StrDis(PC),A0
         BSR     SndStr
         TST.B   Device(A5)
         BEQ.S   Clean
         BSR     Wait1S
         BSR     Wait1S
         LEA     StrLOF(PC),A0
         BSR     SndStr
         BSR     Wait1S
         BSR     Wait1S
         BSR     Quiet
         LEA     StrHgUp(PC),A0
         BSR     SndCom
Clean    BSR     Wait1S
         BRA     Reset
GoodB    BSR     SndChr
         LEA     StrSure(PC),A0
         BSR     SndStr
.0       BSR     GetKey
         CMP.B   #$FC,D0
         BHS     Special
         CMP.B   #CR,D0
         BEQ.S   .1
         BSR     LCUC
         CMP.B   #'N,D0
         BEQ.S   .2
         CMP.B   #'Y,D0
         BNE.S   .0
         BSR     SndChr
         MOVEQ   #CR,D0
.1       BSR     SndChr
         LEA     StrBye(PC),A0
         BRA.S   Discon
.2       BSR     SndChr
         BRA     Com0
Chat     BSR     SndChr
         LEA     StrPSys(PC),A0
         BSR     SndStr
         MOVEQ   #32,D7
         BSR     Beeps
         LEA     StrSysP(PC),A0
         BSR     SndStr
         BRA     Com0
BrkChat  LEA     StrBkCh(PC),A0
         BSR     SndStr
.0       MOVEQ   #'>,D0
         BSR     SndChr
         BSR     Input
         TST.B   D0
         BEQ.S   .0
         CMP.B   #$FC,D0
         BNE     Special
         LEA     StrEdCh(PC),A0
         BSR     SndStr
         BRA     Com0
ReadFSys BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     NamBBS
         BSR     OpenData
         BNE.S   .1
         BSR     ReadMes
         BNE.S   .1
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .1
         TST.L   Length(A5)
         BEQ.S   .0
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #FF,D0
         BSR     SndChr
         LEA     MesBuf(A5),A0
         BSR     SndMes
         TST.B   D0
         BNE     Special
.0       BRA     Com0
.1       LEA     SFRGet(A5),A4
         BSR     CloseF
         LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA     Com0
LeavTSys BSR     SndChr
         BSR     Edit
         CMP.B   #$FC,D0
         BHS     Special
         TST.B   D0
         BNE.S   .0
         LEA     StrSvD(PC),A0
         BSR     SndStr
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     NamBBS
         BSR     OpenData
         BNE.S   .1
         BSR     MovToEOF
         BNE.S   .1
         BSR     WriteMes
         BNE.S   .1
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .1
.0       BRA     Com0
.1       LEA     SFRPut(A5),A4
         BSR     CloseF
         LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA     Com0
DownB    BSR     SndChr
         TST.B   Device(A5)
         BNE.S   .0
         LEA     StrNLoc(PC),A0
         BSR     SndStr
         BRA     Com0
.0       LEA     StrPass(PC),A0
         BSR     SndStr
         BSR     Inpas
         TST.B   D0
         BNE     Special
         BSR     HshPss
         MOVE.L  HndTMSF(A5),A0
         MOVE.L  (A0),A0
         CMP     2(A0),D1
         BEQ.S   .1
         CMP     #$1D0C,D1
         BNE     Com0
.1       LEA     StrFlNm(PC),A0
         BSR     SndStr
         BSR     Input
         TST.B   D0
         BNE     Special
         TST.B   XBuf(A5)
         BEQ     Com0
         LEA     SFRGet(A5),A4
         BSR     NamFil
         BSR     GetInfo
         BNE.S   .5
         CMP.L   #TYPTXT,32(A0)
         BNE.S   .5
         LEA     StrSndg(PC),A0
         BSR     SndStr
         LEA     SFRGet+fName(A5),A0
         BSR     SndStr
         MOVEQ   #CR,D0
         BSR     SndChr
         CLR     MaxBlk(A5)
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     OpenData
         BNE.S   .6
         BSR     Sopen
         BNE.S   .4
.2       BSR     ClrBuf
         BSR     ReadX
         BNE.S   .4
         TST.L   D1
         BEQ.S   .3
         BSR     Swrite
         BEQ.S   .2
         BRA.S   .4
.3       LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .4
         BSR     Sclose
.10      BSR     RestScrn
         BSR     Wait1S
         BRA     .1
.4       LEA     SFRGet(A5),A4
         BSR     CloseF
         BSR     Sabort
.5       LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA.S   .10
.6       LEA     SFRGet(A5),A4
         BSR     CloseF
         BRA.S   .5
UpB      BSR     SndChr
         TST.B   Device(A5)
         BNE.S   .0
         LEA     StrNLoc(PC),A0
         BSR     SndStr
         BRA     Com0
.0       LEA     StrFlNm(PC),A0
         BSR     SndStr
         BSR     Input
         TST.B   D0
         BNE     Special
         CMP.B   #64,XBuf(A5)
         BHS     .7
         LEA     SFRPut(A5),A4
         BSR     NamFil
         BSR     GetInfo
         BEQ     .7
         CMP     #-43,D7
         BNE     .7
         BSR     CreateF
         BNE     .6
         BSR     GetInfo
         BNE     .6
         MOVE.L  #TYPTXT,32(A0)
         MOVE.L  #CREAT,36(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE     .6
         LEA     StrRcvg(PC),A0
         BSR     SndStr
         LEA     SFRPut+fName(A5),A0
         BSR     SndStr
         MOVEQ   #CR,D0
         BSR     SndChr
         CLR     MaxBlk(A5)
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .5
         BSR     InitS
         BSR     Ropen
.1       BSR     Rread
         BNE.S   .2
         MOVE.L  #128,D1
         BSR     WriteX
         BEQ.S   .1
         BRA.S   .3
.2       CMP     #1,D7
         BNE.S   .3
         BSR     FlshS
         BNE.S   .4
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .4
         BSR     Rclose
.10      BSR     RestScrn
         BRA     Com0
.3       BSR     Rabort
.4       LEA     SFRPut(A5),A4
         BSR     CloseF
         BSR     DeleteF
         BSR     Rclose
         BRA.S   .7
.5       LEA     SFRPut(A5),A4
         BSR     CloseF
.6       LEA     SFRPut(A5),A4
         BSR     DeleteF
.7       LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA.S   .10
SysZ     BSR     SndChr
         LEA     StrPass(PC),A0
         BSR     SndStr
         BSR     Inpas
         TST.B   D0
         BNE     Special
         BSR     HshPss
         MOVE.L  HndTMSF(A5),A0
         MOVE.L  (A0),A0
         CMP     (A0),D1
         BEQ.S   Men1
         CMP     #$1D0C,D1
         BNE     Com0
Men1     LEA     LstMen2(PC),A0
         BSR     SndLst
Com1     LEA     StrCom(PC),A0
         BSR     SndStr
.0       BSR     GTLEN
         BEQ.S   .1
         BSR     GET1CHR
         BRA.S   .0
.1       BSR     GetKey
         CMP.B   #$FC,D0
         BHS     Special
         CMP.B   #CR,D0
         BEQ.S   Men1
         BSR     LCUC
         CMP.B   #'R,D0
         BEQ.S   ReadTSys
         CMP.B   #'C,D0
         BEQ     LeavFSys
         CMP.B   #'E,D0
         BEQ     ErasTSys
         CMP.B   #'Z,D0
         BEQ     PassZ
         CMP.B   #'D,D0
         BEQ     PassD
         CMP.B   #'B,D0
         BEQ     ExitB
         CMP.B   #'Q,D0
         BEQ     QuitB
         BRA.S   .1
ReadTSys BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     NamBBS
         BSR     OpenData
         BNE.S   .6
.0       BSR     ReadMes
         BNE.S   .6
         TST.L   Length(A5)
         BEQ.S   .4
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #FF,D0
         BSR     SndChr
         LEA     MesBuf(A5),A0
         BSR     SndMes
         TST.B   D0
         BNE.S   .5
         LEA     StrRead(PC),A0
         BSR     SndStr
.1       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   .5
         CMP.B   #CR,D0
         BEQ.S   .2
         BSR     LCUC
         CMP.B   #'N,D0
         BEQ.S   .2
         CMP.B   #'S,D0
         BEQ.S   .3
         BRA.S   .1
.2       BSR     SndChr
         BRA.S   .0
.3       BSR     SndChr
.4       LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .6
         MOVEQ   #CR,D0
         BSR     SndChr
         BRA     Com1
.5       MOVE.B  D0,-(SP)
         LEA     SFRGet(A5),A4
         BSR     CloseF
         MOVE.B  (SP)+,D0
         BRA     Special
.6       LEA     SFRGet(A5),A4
         BSR     CloseF
         LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA     Com1
LeavFSys BSR     SndChr
         BSR     Edit
         CMP.B   #$FC,D0
         BHS     Special
         TST.B   D0
         BNE.S   .0
         LEA     StrSvD(PC),A0
         BSR     SndStr
         LEA     SFRPut(A5),A4
         BSR     NamBBS
         BSR     DeleteF
         BNE.S   .2
         BSR     CreateF
         BNE.S   .2
         BSR     GetInfo
         BNE.S   .2
         MOVE.L  #$4D657373,32(A0)
         MOVE.L  #CREAT,36(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE.S   .2
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .1
         BSR     WriteMes
         BNE.S   .1
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .1
.0       BRA     Com1
.1       LEA     SFRPut(A5),A4
         BSR     CloseF
.2       LEA     SFRPut(A5),A4
         BSR     DeleteF
         LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA     Com1
ErasTSys BSR     SndChr
         LEA     StrSure(PC),A0
         BSR     SndStr
.0       BSR     GetKey
         CMP.B   #$FC,D0
         BHS     Special
         CMP.B   #CR,D0
         BEQ     .1
         BSR     LCUC
         CMP.B   #'N,D0
         BEQ     .1
         CMP.B   #'Y,D0
         BNE.S   .0
         BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #1,D0
         LEA     0,A2
         LEA     SFRGet(A5),A4
         BSR     NamBBS
         BSR     OpenData
         BNE.S   .2
         BSR     ReadMes
         BNE.S   .2
         LEA     SFRGet(A5),A4
         BSR     CloseF
         BNE.S   .2
         LEA     SFRPut(A5),A4
         BSR     NamBBS
         BSR     DeleteF
         BNE.S   .4
         TST.L   Length(A5)
         BEQ.S   .5
         BSR     CreateF
         BNE.S   .4
         BSR     GetInfo
         BNE.S   .4
         MOVE.L  #$4D657373,32(A0)
         MOVE.L  #CREAT,36(A0)
         _SetFileInfo
         MOVE    16(A0),D7
         BNE.S   .4
         MOVEQ   #2,D0
         LEA     0,A2
         LEA     SFRPut(A5),A4
         BSR     OpenData
         BNE.S   .3
         BSR     WriteMes
         BNE.S   .3
         LEA     SFRPut(A5),A4
         BSR     CloseF
         BNE.S   .3
         MOVEQ   #CR,D0
.1       BSR     SndChr
         BRA     Com1
.2       LEA     SFRGet(A5),A4
         BSR     CloseF
         BRA.S   .5
.3       LEA     SFRPut(A5),A4
         BSR     CloseF
.4       LEA     SFRPut(A5),A4
         BSR     DeleteF
.5       LEA     StrOSErr(PC),A0
         BSR     SndStr
         BRA     Com1
PassZ    BSR     SndChr
         LEA     StrPass(PC),A0
         BSR     SndStr
         BSR     Input
         TST.B   D0
         BNE     Special
         TST.B   XBuf(A5)
         BEQ.S   .0
         BSR     HshPss
         MOVE.L  HndTMSF(A5),-(SP)
         MOVE.L  (SP),A0
         MOVE.L  (A0),A0
         MOVE    D1,(A0)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
.0       BRA     Com1
PassD    BSR     SndChr
         LEA     StrPass(PC),A0
         BSR     SndStr
         BSR     Input
         TST.B   D0
         BNE     Special
         TST.B   XBuf(A5)
         BEQ.S   .0
         BSR     HshPss
         MOVE.L  HndTMSF(A5),-(SP)
         MOVE.L  (SP),A0
         MOVE.L  (A0),A0
         MOVE    D1,2(A0)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
.0       BRA     Com1
ExitB    BSR     SndChr
         BRA     Men0
QuitB    BSR     SndChr
         TST.B   Device(A5)
         BEQ.S   .0
         LEA     StrNRem(PC),A0
         BSR     SndStr
         BRA     Com1
.0       LEA     StrTer(PC),A0
         BSR     SndStr
         CLR.L   -(SP)
         MOVE.L  #$544D5346,-(SP)
         MOVE    #1,-(SP)
         _GetResource
         MOVE.L  (SP),A0
         MOVE.L  (A0),A0
         CLR.B   4(A0)
         _ChangedResource
         CLR     -(SP)
         _CurResFile
         _UpdateResFile
         _ShowCursor
         CLR.B   F.BBS(A5)
         BRA     MnuOut
*--------------------------------
STS      MACRO
         DO      ]#=1
         STR     "]1"
         FIN
         DO      ]#=2
         DATA    #:2-:1
:1       ASC     "]1"
         HEX     ]2
:2
         FIN
         DO      ]#=3
         DATA    #:2-:1
:1       HEX     ]1
         ASC     "]2"
         HEX     ]3
:2
         FIN
         ENDM
*--------------------------------
StrIni1  STS     "ATM0V1X1S0=1",0D
StrNA    STS     "ATS0=0",0D
StrLOF   STR     "+++"
StrHgUp  STS     "ATH0",0D
StrCaRe  STS     0C,"Calls received:",20
StrPwOt  STR        " since power-out."
StrWait  STS     0D,"Waiting for a call...",0D
LstMen1  STS     0D0C,"Telescape Message Service",0D
         STS          "-------------------------",0D0D
         STS     "<R>ead ...... Read Message",0D
         STS     "<L>eave ..... Leave Message",0D
         STS     "<D>ownload .. Files or Applications",0D
         STS     "<U>pload .... Files or Applications",0D
         STS     "<C>hat ...... Chat With Sysop",0D
         STS     "<G>oodbye ... Terminate Session",0D
         HEX     00
LstMen2  STS     0D0C,"Sysop Remote Utilities",0D
         STS          "----------------------",0D0D
         STS     "<R>ead ..... Read Messages",0D
         STS     "<C>reate ... Create Message",0D
         STS     "<E>rase .... Erase Messages",0D
         STS     "<Z> ........ Change Password",0D
         STS     "<D> ........ Change Password",0D
         STS     "<B>ack ..... Back to Main Menu",0D
         STS     "<Q>uit ..... Quit to Terminal",0D
         HEX     00
StrCom   STS     0D,"Command:",20
StrPass  STS     0D,"Password:",20
StrLn    STS     0D,"Line number:",20
StrFlNm  STS     0D,"FileName:",20
StrMes   STS     0D,"Enter message text",2E
StrEdt   STS     0D,"<L>ist, <E>dit, <C>ontinue, <S>ave or <A>bort?",20
StrRead  STS     0D,"<S>top or <N>ext?",20
StrSure  STS     0D,"Are you sure (Y/N)?",20
StrSndg  STS     0D,"Sending:",20
StrRcvg  STS     0D,"Receiving:",20
StrSvD   STS     0D,"Saving message to disk...",0D
StrPSys  STS     0D,"Paging Sysop, please wait...",0D
StrSysP  STS     "Sysop will break into Chat if available.",0D
StrBfl   STS     0D,"*** Buffer Full! ***",0D
StrNRem  STS     0D,"*** Remote Mode! ***",0D
StrNLoc  STS     0D,"*** Local Mode! ***",0D
StrTer   STS     0D,"*** Back to Terminal Mode ***",0D
StrBkCh  STS     0D,"*** Sysop Breaking into Chat ***",0D
StrEdCh  STS     0D,"*** Chat Mode Ended ***",0D
StrNY    STS     0D,"*** Function not yet implemented ***",0D
StrTO    STS     0D,"*** Time-Out ***",0D
StrIL    STS     0D,"*** Instant Logoff by Sysop ***",0D
StrOSErr STS     0D,"*** File System Error ***",0D
StrBye   STS     0D,"Telescape Message Service",0D
StrDis   STS     "Disconnecting...",0D
MesName  STR     "Messages.BBS"
         ADJST
*--------------------------------
GetKChr  CLR.B   -(SP)
         MOVE    #$0829,-(SP)
         PEA     EventRecord(A5)
         _GetNextEvent
         TST.B   (SP)+
         BEQ.S   GtNOK
         MOVE    What(A5),D0
         CMP     #11,D0
         BEQ.S   .2
         CMP     #3,D0
         BEQ.S   .0
         CMP     #5,D0
         BNE.S   GtNOK
.0       MOVE.L  Message(A5),D0
         MOVE    Modify(A5),D1
         BTST    #8,D1
         BEQ.S   GtOK
         CMP.B   #$03,D0
         BNE.S   .1
         MOVEQ   #$FD,D0         ;Instant Logoff
         BRA.S   GtOK
.1       CMP.B   #'.,D0
         BNE.S   GtNOK
         MOVEQ   #$FC,D0         ;Local Logon or Chat
         BRA.S   GtOK
.2       MOVE    Message(A5),D0
         AND.B   #$20,D0
         BEQ.S   GtNOK
         AND     #$2000,D0
         BNE.S   .3
         CMP.B   #0,F.CTS(A5)
         BEQ.S   .4
         BRA.S   GtNOK
.3       CMP.B   #1,F.CTS(A5)
         BNE.S   GtNOK
.4       MOVEQ   #$FF,D0         ;Carrier Loss
GtOK     OR      #1,CCR
         RTS
GetLChr  BSR     GTLEN
         BEQ.S   GtNOK
         BSR     GET1CHR
         BRA.S   GtOK
GtNOK    AND     #$FE,CCR
         RTS
InKey    BSR     GetKChr
         BCS.S   .0
         TST.B   Device(A5)
         BEQ.S   GtNOK
         BSR     GetLChr
.0       RTS
GetKey   MOVE.L  Ticks,D0
         ADD.L   #2*60*60,D0
         MOVE.L  D0,TimeOut(A5)
.0       BSR     InKey
         BCS.S   .1
         _SystemTask
         BSR     IDLITE
         BSR     IDLCRS
         MOVE.L  Ticks,D0
         CMP.L   TimeOut(A5),D0
         BLO.S   .0
         MOVEQ   #$FE,D0         ;Time-Out
.1       RTS
Input    CLR.B   Charac(A5)
         BRA.S   Inp
Inpas    MOVE.B  #1,Charac(A5)
Inp      BSR     GTLEN
         BEQ.S   Inp0
         BSR     GET1CHR
         BRA.S   Inp
Inp0     CLR.B   XBuf(A5)
.0       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   .5
         CMP.B   #$20,D0
         BLO.S   .3
         CMP.B   #$7F,D0
         BEQ.S   .0
         CMP.B   #76,XBuf(A5)
         BHS.S   .2
         LEA     XBuf(A5),A0
         CLR     D1
         MOVE.B  (A0),D1
         MOVE.B  D0,1(A0,D1)
         ADDQ.B  #1,(A0)
         TST.B   Charac(A5)
         BEQ.S   .1
         MOVEQ   #'*,D0
.1       BSR     SndChr
         BRA.S   .0
.2       MOVEQ   #BEL,D0
         BRA.S   .1
.3       CMP.B   #BS,D0
         BNE.S   .4
         TST.B   XBuf(A5)
         BEQ.S   .2
         SUBQ.B  #1,XBuf(A5)
         MOVEQ   #BS,D0
         BSR     SndChr
         MOVEQ   #' ,D0
         BSR     SndChr
         MOVEQ   #BS,D0
         BRA.S   .1
.4       CMP.B   #CR,D0
         BNE.S   .0
         BSR     SndChr
         CLR.B   D0
.5       RTS
GetCom   CLR.B   XBuf(A5)
.0       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   .2
         CMP.B   #$20,D0
         BLO.S   .1
         CMP.B   #76,XBuf(A5)
         BHS.S   .0
         LEA     XBuf(A5),A0
         CLR     D1
         MOVE.B  (A0),D1
         MOVE.B  D0,1(A0,D1)
         ADDQ.B  #1,(A0)
         BRA.S   .0
.1       CMP.B   #CR,D0
         BNE.S   .0
         CLR.B   D0
.2       RTS
SndChr   CMP.B   #CR,D0
         BNE.S   .1
         BSR     OUTCH
         TST.B   Device(A5)
         BEQ.S   .0
         BSR     PUT1CHR
.0       MOVEQ   #LF,D0
.1       BSR     OUTCH
         TST.B   Device(A5)
         BEQ.S   .2
         BSR     PUT1CHR
.2       RTS
SndStr   CLR     D0
         MOVE.B  (A0)+,D0
         MOVE.L  A0,StrPtr(A5)
         MOVE    D0,StrCnt(A5)
.0       TST     StrCnt(A5)
         BEQ.S   .1
         MOVE.L  StrPtr(A5),A0
         MOVE.B  (A0),D0
         BSR     SndChr
         ADDQ.L  #1,StrPtr(A5)
         SUBQ    #1,StrCnt(A5)
         BRA.S   .0
.1       MOVE.L  StrPtr(A5),A0
         RTS
SndLst   TST.B   (A0)
         BEQ.S   .0
         BSR     SndStr
         BRA.S   SndLst
.0       RTS
SndCom   CLR     D0
         MOVE.B  (A0)+,D0
         MOVE.L  A0,StrPtr(A5)
         MOVE    D0,StrCnt(A5)
.0       TST     StrCnt(A5)
         BEQ.S   .2
         MOVE.L  StrPtr(A5),A0
         MOVE.B  (A0),D0
         MOVE.B  D0,Charac(A5)
         BSR     PUT1CHR
.1       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   .3
         CMP.B   Charac(A5),D0
         BNE.S   .1
         ADDQ.L  #1,StrPtr(A5)
         SUBQ    #1,StrCnt(A5)
         BRA.S   .0
.2       BSR     GetCom
.3       RTS
SndMes   TST.B   (A0)
         BEQ.S   .4
         CLR     D0
         MOVE.B  (A0)+,D0
         MOVE.L  A0,StrPtr(A5)
         MOVE    D0,StrCnt(A5)
.0       TST     StrCnt(A5)
         BEQ.S   .3
         MOVE.L  StrPtr(A5),A0
         MOVE.B  (A0),D0
         BSR     SndChr
         BSR     InKey
         CMP.B   #$FC,D0
         BHS.S   .5
         BSR     LCUC
         CMP.B   #'S,D0
         BEQ.S   .4
         CMP.B   #'K,D0
         BEQ.S   .4
         CMP.B   #'P,D0
         BNE.S   .2
.1       BSR     GetKey
         CMP.B   #$FC,D0
         BHS.S   .5
         CMP.B   #CR,D0
         BNE.S   .1
.2       ADDQ.L  #1,StrPtr(A5)
         SUBQ    #1,StrCnt(A5)
         BRA.S   .0
.3       MOVEQ   #CR,D0
         BSR     SndChr
         MOVE.L  StrPtr(A5),A0
         BRA.S   SndMes
.4       CLR.B   D0
.5       RTS
List     MOVEQ   #1,D0
.0       TST.B   (A0)
         BEQ.S   .1
         MOVE.L  D0,-(SP)
         MOVE.L  A0,-(SP)
         LEA     DskNam(A5),A0
         MOVE    #0,-(SP)
         _Pack7
         BSR     SndStr
         MOVEQ   #':,D0
         BSR     SndChr
         MOVE.L  (SP)+,A0
         BSR     SndStr
         MOVE.L  A0,-(SP)
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVE.L  (SP)+,A0
         MOVE.L  (SP)+,D0
         ADDQ.L  #1,D0
         BRA.S   .0
.1       RTS
SERTXT   LEA     MesBuf(A5),A2
         CLR     D1
         MOVEQ   #1,D2
.0       MOVE.L  A2,A1
         TST.B   (A1)
         BEQ.S   .1
         MOVE.B  (A1),D1
         ADD     D1,A2
         ADDQ.L  #1,A2
         CMP     D0,D2
         BEQ.S   .1
         ADDQ    #1,D2
         BRA.S   .0
.1       MOVE.L  A2,A4
.2       MOVE.B  (A4)+,D1
         BEQ.S   .3
         ADD     D1,A4
         BRA.S   .2
.3       RTS
INSLIN   BSR     SERTXT
         MOVE.L  A2,D0
         SUB.L   A1,D0
         CLR.L   D1
         MOVE.B  XBuf(A5),D1
         ADDQ.L  #1,D1
         SUB.L   D0,D1
         BEQ.S   .9
         MOVE.L  A4,D2
         SUB.L   A2,D2
         TST.L   D1
         BPL.S   .6
         MOVE.L  A2,A3
         ADD.L   D1,A3
         BRA.S   .5
.4       MOVE.B  (A2)+,(A3)+
.5       SUBQ.L  #1,D2
         BPL.S   .4
         BRA.S   .9
.6       MOVE.L  A4,A3
         ADD.L   D1,A3
         LEA     MesBuf+2048(A5),A0
         CMP.L   A0,A3
         BHI.S   .11
         MOVE.L  A4,A2
         BRA.S   .8
.7       MOVE.B  -(A2),-(A3)
.8       SUBQ.L  #1,D2
         BPL.S   .7
.9       LEA     XBuf(A5),A0
         MOVE.B  (A0),D0
.10      MOVE.B  (A0)+,(A1)+
         SUBQ.B  #1,D0
         BCC.S   .10
         RTS
.11      LEA     StrBfl(PC),A0
         BRA     SndStr
Edit     LEA     StrMes(PC),A0
         BSR     SndStr
         CLR.B   MesBuf(A5)
.0       MOVEQ   #CR,D0
         BSR     SndChr
.1       MOVEQ   #'>,D0
         BSR     SndChr
         BSR     Input
         TST.B   D0
         BNE     .9
         TST.B   XBuf(A5)
         BEQ.S   .2
         MOVE    #10000,D0
         BSR     INSLIN
         BRA.S   .1
.2       LEA     StrEdt(PC),A0
         BSR     SndStr
.3       BSR     GetKey
         CMP.B   #$FC,D0
         BHS     .9
         CMP.B   #CR,D0
         BEQ.S   .4
         BSR     LCUC
         CMP.B   #'L,D0
         BEQ.S   .4
         CMP.B   #'E,D0
         BEQ.S   .5
         CMP.B   #'C,D0
         BEQ     .6
         CMP.B   #'S,D0
         BEQ     .7
         CMP.B   #'A,D0
         BEQ     .8
         BRA.S   .3
.4       BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         LEA     MesBuf(A5),A0
         BSR     List
         BRA.S   .2
.5       BSR     SndChr
         LEA     StrLn(PC),A0
         BSR     SndStr
         BSR     Input
         TST.B   D0
         BNE     .9
         TST.B   XBuf(A5)
         BEQ.S   .2
         LEA     XBuf(A5),A0
         MOVE    #1,-(SP)
         _Pack7
         MOVE    D0,LiNum(A5)
         BSR     SERTXT
         TST.B   (A1)
         BEQ     .2
         MOVE.L  A1,-(SP)
         MOVEQ   #'>,D0
         BSR     SndChr
         MOVE.L  (SP)+,A0
         BSR     SndStr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #'>,D0
         BSR     SndChr
         BSR     Input
         TST.B   D0
         BNE.S   .9
         TST.B   XBuf(A5)
         BEQ     .2
         MOVE    LiNum(A5),D0
         BSR     INSLIN
         BRA     .2
.6       BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         BRA     .0
.7       BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         CLR.B   D0
         BRA.S   .9
.8       BSR     SndChr
         MOVEQ   #CR,D0
         BSR     SndChr
         MOVEQ   #1,D0
.9       RTS
HshPss   LEA     XBuf(A5),A0
         CLR     D2
         MOVE.B  (A0)+,D2
         CLR     D1
         CLR     D0
         BRA.S   .1
.0       MOVE.B  (A0)+,D0
         BSR     LCUC
         ROL     #3,D1
         ADD     D0,D1
.1       DBRA    D2,.0
         RTS
NamFil   LEA     XBuf(A5),A0
         BRA.S   Nam0
NamBBS   LEA     MesName(PC),A0
Nam0     LEA     fName(A4),A1
         CLR     D1
         MOVE.B  (A0),D1
.0       MOVE.B  (A0)+,(A1)+
         DBRA    D1,.0
         CLR     vRefNum(A4)
         CLR     version(A4)
         RTS
WriteMes LEA     MesBuf(A5),A1
         MOVE.L  A1,A2
.0       TST.B   (A2)+
         BNE.S   .0
         SUB.L   A1,A2
         LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    SFRPut+RefNum(A5),24(A0)
         MOVE.L  A1,32(A0)
         MOVE.L  A2,36(A0)
         CLR     44(A0)
         CLR.L   46(A0)
         _Write
         MOVE    16(A0),D7
         RTS
ReadMes  LEA     ParaBlk(A5),A0
         CLR.L   12(A0)
         MOVE    SFRGet+RefNum(A5),24(A0)
         PEA     MesBuf(A5)
         MOVE.L  (SP)+,32(A0)
         MOVE.L  #2048,36(A0)
         MOVE    #$0080,44(A0)
         CLR.L   46(A0)
         _Read
         MOVE.L  40(A0),Length(A5)
         MOVE    16(A0),D7
         BEQ.S   .0
         CMP     #-39,D7
.0       RTS
Wait1S   MOVE.L  Ticks,D0
         ADD.L   #60,D0
.0       CMP.L   Ticks,D0
         BHI.S   .0
         RTS
Quiet    MOVE.L  Ticks,D0
         ADD.L   #60,D0
         MOVE.L  D0,TimeOut(A5)
.0       BSR     InKey
         BCS.S   Quiet
         MOVE.L  Ticks,D0
         CMP.L   TimeOut(A5),D0
         BLO.S   .0
         RTS
*--------------------------------
         END
