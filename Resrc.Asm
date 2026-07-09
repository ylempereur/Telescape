;SAVE"Resrc.Asm"
*--------------------------------
         LIST    ON
*--------------------------------
; Resources v1.0
*--------------------------------
         LIST    OFF
*================================
         RSRC    TELE,0,32
         STR     "Telescape v1.0 -- 06/14/85"
         ENDR
*--------------------------------
         RSRC    ICN#,128,32
         HEX     007FF80000400C0000400C0000400E00
         HEX     00430E0000448E0000430E0000400E00
         HEX     00400E0000400E00007FFE0000200600
         HEX     002DB600002DB60000200600002DB600
         HEX     002DB60000200600002DB600002DB600
         HEX     00200600007FFE0000400FC000430E20
         HEX     00484E7000430EA80054AEDC00430E2A
         HEX     00484E3700430C0A00400C0C007FF800
*
         HEX     00000000003FF800003FF800003FFC00
         HEX     003FFC00003FFC00003FFC00003FFC00
         HEX     003FFC00003FFC00003FFC00001FFC00
         HEX     001FFC00001FFC00001FFC00001FFC00
         HEX     001FFC00001FFC00001FFC00001FFC00
         HEX     001FFC00003FFC00003FFC00003FFC00
         HEX     003FFC00003FFC00003FFC00003FFC00
         HEX     003FFC00003FF800003FF80000000000
         ENDR
*--------------------------------
         RSRC    FREF,128,32
         ASC     "APPL"
         DATA    /0
         STR     ""
         ENDR
*--------------------------------
         RSRC    BNDL,128,32
         ASC     "TELE"
         DATA    /0
         DATA    /2-1
         ASC     "ICN#"
         DATA    /1-1
         DATA    /0,/128
         ASC     "FREF"
         DATA    /1-1
         DATA    /0,/128
         ENDR
*--------------------------------
         RSRC    ICON,128,36
         HEX     7FFFFFFE800000018000000180000031
         HEX     8000004981C000498220013184100081
         HEX     88100641880809019008090190082601
         HEX     901010019060C8018881200188812001
         HEX     8484C001844200018221000182100E01
         HEX     8108118180842041804220218021C021
         HEX     80100021800C0041800300818000C301
         HEX     80003C0180000001800000017FFFFFFE
         ENDR
*--------------------------------
         RSRC    ICON,129,36
         HEX     7FFFFFFE800000018000000180000001
         HEX     80FFC001808060018080500180804801
         HEX     8080440180807E018080020180800201
         HEX     80800201808002018080020180800201
         HEX     80800201808002018F8003E188800221
         HEX     8880023988FFFE298800002988000029
         HEX     8800003988000021880000218FFFFFE1
         HEX     8000000180000001800000017FFFFFFE
         ENDR
*--------------------------------
         RSRC    ICON,130,36
         HEX     007FF80000400C0000400C0000400E00
         HEX     00430E0000448E0000430E0000400E00
         HEX     00400E0000400E00007FFE0000200600
         HEX     002DB600002DB60000200600002DB600
         HEX     002DB60000200600002DB600002DB600
         HEX     00200600007FFE0000400FC000430E20
         HEX     00484E7000430EA80054AEDC00430E2A
         HEX     00484E3700430C0A00400C0C007FF800
         ENDR
*--------------------------------
         RSRC    MENU,1,4
         DATA    /1              ; Menu ID
         DATA    /0,/0
         DATA    /0              ; Menu Def.
         DATA    /0
         DATA    $FFFFFFFB       ; Enable Flags
         HEX     0114            ; Title
         STR     "About Telescape…"
         DATA    #0,#0,#0,#0     ; Icon,Keyboard,Mark,Style
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     ""
         ENDR
*--------------------------------
         RSRC    MENU,2,4
         DATA    /2
         DATA    /0,/0
         DATA    /0
         DATA    /0
         DATA    $FFFFFF93
         STR     "File"
         STR     "Receive File…"
         DATA    #0,#0,#0,#0
         STR     "Pause Receive"
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "Send File…"
         DATA    #0,#0,#0,#0
         STR     "Pause Send"
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "Quit"
         DATA    #0,#0,#0,#0
         STR     ""
         ENDR
*--------------------------------
         RSRC    MENU,3,4
         DATA    /3
         DATA    /0,/0
         DATA    /0
         DATA    /0
         DATA    $FFFFFF81
         STR     "Edit"
         STR     "Undo"
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "Cut"
         DATA    #0,#0,#0,#0
         STR     "Copy"
         DATA    #0,#0,#0,#0
         STR     "Paste"
         DATA    #0,#0,#0,#0
         STR     "Clear"
         DATA    #0,#0,#0,#0
         STR     ""
         ENDR
*--------------------------------
         RSRC    MENU,4,4
         DATA    /4
         DATA    /0,/0
         DATA    /0
         DATA    /0
         DATA    $FFFFFE29
         STR     "Utilities"
         STR     "Unlock Kybd."
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "Directory"
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "E-Mail"
         DATA    #0,#0,#0,#0
         STR     "-"
         DATA    #0,#0,#0,#0
         STR     "Editor"
         DATA    #0,#0,#0,#0
         STR     "BinHex"
         DATA    #0,#0,#0,#0
         STR     ""
         ENDR
*--------------------------------
         RSRC    MENU,5,4
         DATA    /5
         DATA    /0,/0
         DATA    /0
         DATA    /0
         DATA    $FFFFFFFF
         STR     "Settings"
         STR     "Protocol"
         DATA    #0,#0,#0,#0
         STR     "Transfer"
         DATA    #0,#0,#0,#0
         STR     "Macros"
         DATA    #0,#0,#0,#0
         STR     "Terminal"
         DATA    #0,#0,#0,#0
         STR     "Port"
         DATA    #0,#0,#0,#0
         STR     ""
         ENDR
*--------------------------------
         RSRC    DLOG,1,32
         DATA    /70,/100,/174,/400      ; Bounds
         DATA    /32                     ; Wind ID
         DATA    #0,#0                   ; Visible
         DATA    #0,#0                   ; NoGoAway
         DATA    0                       ; refCon
         DATA    /1                      ; Item ID
         STR     ""                      ; Title
         ENDR
*--------------------------------
         RSRC    DITL,1,32
         DATA    /5-1                    ; Number of Item
         DATA    0
         DATA    /64,/230,/84,/290       ; Disp Rect
         DATA    #4                      ; Type
         STR     "OK"                    ; Content
         DATA    0
         DATA    /20,/244,/52,/276
         DATA    #32+128
         DATA    #2,/130
         DATA    0
         DATA    /20,/10,/36,/200
         DATA    #8+128
         STR     "Telescape™   v1.0"
         HEX     00
         DATA    0
         DATA    /44,/10,/60,/200
         DATA    #8+128
         STR     "By Yves Lempereur"
         HEX     00
         DATA    0
         DATA    /68,/10,/84,/200
         DATA    #8+128
         STR     "Copyright 1985, Mainstay"
         ENDR
*--------------------------------
         RSRC    DLOG,2,36
         DATA    /70,/90,/250,/420
         DATA    /32
         DATA    #0,#0
         DATA    #0,#0
         DATA    0
         DATA    /2
         STR     ""
         ENDR
*--------------------------------
         RSRC    DITL,2,36
         DATA    /25-1
         DATA    0
         DATA    /150,/190,/170,/250
         DATA    #4
         STR     "OK"
         DATA    0
         DATA    /150,/260,/170,/320
         DATA    #4
         STR     "Cancel"
         DATA    0
         DATA    /10,/10,/26,/80
         DATA    #8+128
         STR     "Baud Rate"
         HEX     00
         DATA    0
         DATA    /10,/90,/26,/160
         DATA    #8+128
         STR     "Parity"
         DATA    0
         DATA    /10,/170,/26,/240
         DATA    #8+128
         STR     "Data Bits"
         HEX     00
         DATA    0
         DATA    /10,/250,/26,/320
         DATA    #8+128
         STR     "Stop Bits"
         HEX     00
         DATA    0
         DATA    /34,/10,/50,/80
         DATA    #6
         STR     "110"
         HEX     00
         DATA    0
         DATA    /50,/10,/66,/80
         DATA    #6
         STR     "300"
         HEX     00
         DATA    0
         DATA    /66,/10,/82,/80
         DATA    #6
         STR     "1200"
         DATA    0
         DATA    /82,/10,/98,/80
         DATA    #6
         STR     "2400"
         DATA    0
         DATA    /98,/10,/114,/80
         DATA    #6
         STR     "4800"
         DATA    0
         DATA    /114,/10,/130,/80
         DATA    #6
         STR     "9600"
         DATA    0
         DATA    /34,/90,/50,/160
         DATA    #6
         STR     "None"
         DATA    0
         DATA    /50,/90,/66,/160
         DATA    #6
         STR     "Even"
         DATA    0
         DATA    /66,/90,/82,/160
         DATA    #6
         STR     "Odd"
         HEX     00
         DATA    0
         DATA    /82,/90,/98,/160
         DATA    #6
         STR     "Mark"
         DATA    0
         DATA    /98,/90,/114,/160
         DATA    #6
         STR     "Space"
         HEX     00
         DATA    0
         DATA    /34,/170,/50,/240
         DATA    #6
         STR     "7 Bits"
         DATA    0
         DATA    /50,/170,/66,/240
         DATA    #6
         STR     "8 Bits"
         DATA    0
         DATA    /34,/250,/50,/320
         DATA    #6
         STR     "1 Bit"
         HEX     00
         DATA    0
         DATA    /50,/250,/66,/320
         DATA    #6
         STR     "1.5 Bits"
         DATA    0
         DATA    /66,/250,/82,/320
         DATA    #6
         STR     "2 Bits"
         DATA    0
         DATA    /138,/10,/154,/80
         DATA    #5
         STR     "Add LF"
         DATA    0
         DATA    /154,/10,/170,/90
         DATA    #5
         STR     "Xon/Xoff"
         DATA    0
         DATA    /138,/90,/154,/160
         DATA    #5
         STR     "Echo"
         ENDR
*--------------------------------
         RSRC    DLOG,3,36
         DATA    /70,/100,/261,/390
         DATA    /32
         DATA    #0,#0
         DATA    #0,#0
         DATA    0
         DATA    /3
         STR     ""
         ENDR
*--------------------------------
         RSRC    DITL,3,36
         DATA    /17-1
         DATA    0
         DATA    /131,/220,/151,/280
         DATA    #4
         STR     "OK"
         DATA    0
         DATA    /161,/220,/181,/280
         DATA    #4
         STR     "Cancel"
         DATA    0
         DATA    /10,/10,/26,/145
         DATA    #8+128
         STR     "Transfer mode:"
         DATA    0
         DATA    /10,/155,/26,/290
         DATA    #8+128
         STR     "Xmodem TimeOut:"
         HEX     00
         DATA    0
         DATA    /34,/10,/50,/145
         DATA    #6
         STR     "ASCII"
         HEX     00
         DATA    0
         DATA    /50,/10,/66,/145
         DATA    #6
         STR     "ASCII (DC2/DC4)"
         HEX     00
         DATA    0
         DATA    /66,/10,/82,/145
         DATA    #6
         STR     "Xmodem"
         DATA    0
         DATA    /82,/10,/98,/145
         DATA    #6
         STR     "MacBinary"
         HEX     00
         DATA    0
         DATA    /34,/155,/50,/290
         DATA    #6
         STR     "10 Seconds"
         DATA    0
         DATA    /50,/155,/66,/290
         DATA    #6
         STR     "30 Seconds"
         DATA    0
         DATA    /66,/155,/82,/290
         DATA    #6
         STR     "60 Seconds"
         DATA    0
         DATA    /114,/10,/130,/145
         DATA    #8+128
         STR     "Chars pace delay:"
         HEX     00
         DATA    0
         DATA    /138,/10,/154,/145
         DATA    #8+128
         STR     "Lines pace delay:"
         HEX     00
         DATA    0
         DATA    /162,/10,/178,/145
         DATA    #8+128
         STR     "Prompt char:"
         DATA    0
         DATA    /114,/147,/129,/189
         DATA    #16+128
         STR     ""
         DATA    0
         DATA    /138,/147,/153,/189
         DATA    #16+128
         STR     ""
         DATA    0
         DATA    /162,/147,/177,/169
         DATA    #16+128
         STR     ""
         ENDR
*--------------------------------
         RSRC    DLOG,4,36
         DATA    /70,/180,/178,/330
         DATA    /32
         DATA    #0,#0
         DATA    #0,#0
         DATA    0
         DATA    /4
         STR     ""
         ENDR
*--------------------------------
         RSRC    DITL,4,36
         DATA    /7-1
         DATA    0
         DATA    /78,/10,/98,/70
         DATA    #4
         STR     "OK"
         DATA    0
         DATA    /78,/80,/98,/140
         DATA    #4
         STR     "Cancel"
         DATA    0
         DATA    /10,/21,/26,/140
         DATA    #8+128
         STR     "Connection Port"
         HEX     00
         DATA    0
         DATA    /44,/10,/60,/26
         DATA    #6
         STR     ""
         DATA    0
         DATA    /44,/124,/60,/140
         DATA    #6
         STR     ""
         DATA    0
         DATA    /36,/31,/68,/63
         DATA    #32
         DATA    #2,/128
         DATA    0
         DATA    /36,/87,/68,/119
         DATA    #32
         DATA    #2,/129
         ENDR
*--------------------------------
         RSRC    ALRT,9,4
         DATA    /100,/100,/190,/400
         DATA    /9
         DATA    /$5555
         ENDR
*--------------------------------
         RSRC    DITL,9,4
         DATA    /2-1
         DATA    0
         DATA    /60,/230,/80,/290
         DATA    #4
         STR     "OK"
         DATA    0
         DATA    /27,/72,/43,/280
         DATA    #8+128
         STR     "^0 error."
         HEX     00
         ENDR
*--------------------------------
         RSRC    DLOG,19,32
         DATA    /0,/0,/104,/304
         DATA    /32
         DATA    #0,#0
         DATA    #0,#0
         DATA    0
         DATA    /19
         STR     "PF"
         ENDR
*--------------------------------
         RSRC    DITL,19,32
         DATA    /8-1
         DATA    0
         DATA    /74,/12,/92,/82
         DATA    #4
         STR     "Receive"
         HEX     00
         DATA    0
         DATA    /74,/114,/92,/184
         DATA    #4
         STR     "Cancel"
         DATA    0
         DATA    /12,/12,/28,/184
         DATA    #8+128
         STR     "Save as:"
         DATA    0
         DATA    /16,/209,/34,/295
         DATA    #0+128
         STR     ""
         DATA    0
         DATA    /43,/217,/61,/287
         DATA    #4
         STR     "Eject"
         HEX     00
         DATA    0
         DATA    /74,/217,/92,/287
         DATA    #4
         STR     "Drive"
         HEX     00
         DATA    0
         DATA    /34,/14,/50,/182
         DATA    #16
         STR     ""
         DATA    0
         DATA    /16,/200,/88,/201
         DATA    #0+128
         STR     ""
         ENDR
*--------------------------------
         RSRC    DLOG,20,32
         DATA    /0,/0,/136,/348
         DATA    /32
         DATA    #0,#0
         DATA    #0,#0
         DATA    0
         DATA    /20
         STR     "GF"
         ENDR
*--------------------------------
         RSRC    DITL,20,32
         DATA    /10-1
         DATA    0
         DATA    /28,/152,/46,/232
         DATA    #4
         STR     "Send"
         DATA    0
         DATA    /59,/1152,/77,/1232
         DATA    #4
         STR     "O"
         HEX     00
         DATA    0
         DATA    /90,/152,/108,/232
         DATA    #4
         STR     "Cancel"
         DATA    0
         DATA    /28,/248,/46,/344
         DATA    #0+128
         STR     ""
         DATA    0
         DATA    /59,/256,/77,/336
         DATA    #4
         STR     "Eject"
         HEX     00
         DATA    0
         DATA    /90,/256,/108,/336
         DATA    #4
         STR     "Drive"
         HEX     00
         DATA    0
         DATA    /11,/12,/125,/125
         DATA    #0
         STR     ""
         DATA    0
         DATA    /11,/124,/125,/140
         DATA    #0
         STR     ""
         DATA    0
         DATA    /20,/244,/116,/245
         DATA    #0
         STR     ""
         DATA    0
         DATA    /20,/1044,/116,/1145
         DATA    #8+128
         STR     "h"
         HEX     00
         ENDR
*--------------------------------
         RSRC    WIND,128,36
         DATA    /24,/5,/338,/507
         DATA    /2
         DATA    #1,#0
         DATA    #0,#0
         DATA    0
         STR     ""
         ENDR
*--------------------------------
         RSRC    WDEF,2,36
WDEF2    LINK    A6,#0
         MOVEM.L D2-D7/A1-A4,-(SP)
         LEA     8(A6),A0
         MOVE.L  (A0)+,D3        ;param
         MOVE    (A0)+,D0        ;message
         MOVE.L  (A0)+,A3        ;WindowPtr
         MOVE    (A0)+,D5        ;VarCode
         CLR.L   (A0)
         ADD     D0,D0
         MOVE    WdTbl(PC,D0),D0
         JSR     WdTbl(PC,D0)
         MOVEM.L (SP)+,D2-D7/A1-A4
         UNLK    A6
         MOVE.L  (SP)+,A0
         ADD     #12,A7
         JMP     (A0)
WdTbl    DATA    /wDraw-WdTbl
         DATA    /wHit-WdTbl
         DATA    /wCalc-WdTbl
         DATA    /Ret-WdTbl
         DATA    /Ret-WdTbl
         DATA    /Ret-WdTbl
         DATA    /Ret-WdTbl
wDraw    TST.B   wVisible(A3)
         BEQ.S   Ret
         TST     D3
         BNE.S   Ret
         LEA     TempRect,A4
         MOVE.L  structRgn(A3),A1
         MOVE.L  (A1),A1
         ADDQ    #2,A1
         MOVE.L  (A1)+,(A4)
         MOVE.L  (A1),4(A4)
         _PenNormal
         MOVE.L  #$00040004,-(SP)
         _PenSize
         MOVE.L  (A5),A0
         PEA     white(A0)
         _PenPat
         MOVE.L  A4,-(SP)
         _FrameRect
         _PenNormal
         MOVE    #10,-(SP)
         _PenMode
         MOVE.L  A4,-(SP)
         MOVE.L  #$00000001,-(SP)
         _InsetRect
         MOVE.L  A4,-(SP)
         _FrameRect
         MOVE.L  A4,-(SP)
         MOVE.L  #$0001FFFF,-(SP)
         _InsetRect
         MOVE.L  A4,-(SP)
         _FrameRect
         MOVE.L  A4,-(SP)
         MOVE.L  #$00020003,-(SP)
         _InsetRect
         MOVE.L  A4,-(SP)
         _FrameRect
         _PenNormal
Ret      RTS
wHit     CLR.B   -(SP)
         MOVE.L  D3,-(SP)
         MOVE.L  ContRgn(A3),-(SP)
         _PtInRgn
         TST.B   (SP)+
         BEQ.S   .0
         MOVEQ   #1,D0
         MOVE.L  D0,20(A6)
.0       RTS
wCalc    LEA     TempRect,A0
         MOVE.L  A0,-(SP)
         MOVE.L  portRect(A3),(A0)+
         MOVE.L  portRect+4(A3),(A0)
         MOVE.L  portBounds(A3),-(SP)
         NEG     (A7)
         NEG     2(A7)
         _OffsetRect
         MOVE.L  ContRgn(A3),-(SP)
         PEA     TempRect
         _RectRgn
         MOVE.L  structRgn(A3),-(SP)
         PEA     TempRect
         MOVE.L  (SP),-(SP)
         MOVE.L  #$FFFCFFFC,-(SP)
         _InsetRect
         _RectRgn
         RTS
         ENDR
*--------------------------------
         RSRC    PORT,1,4
         DATA    /-1
         ENDR
*--------------------------------
         RSRC    TMSF,1,4
         DATA    /0,/0,#0
         ENDR
*--------------------------------
         RSRC    PSET,1,4
         HEX     00000000000000000000
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    PHBK,0,36
         STR     "Mainstay (TMS)"
         ENDR
*--------------------------------
         RSRC    PHBK,1,36
         STR     "Ventura TBBS (MacASM support)"
         ENDR
*--------------------------------
         RSRC    PHBK,2,36
         STR     "CompuServe (VT100)"
         ENDR
*--------------------------------
         RSRC    PHBK,3,36
         STR     "CompuServe (VT52)"
         ENDR
*--------------------------------
         RSRC    PHBK,4,36
         STR     "CompuServe (Teleray)"
         ENDR
*--------------------------------
         RSRC    PHBK,5,36
         STR     "Club Mac (VT100+)"
         ENDR
*--------------------------------
         RSRC    PHBK,6,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,7,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,8,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,9,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,10,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,11,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,12,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,13,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,14,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,15,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,16,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,17,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,18,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PHBK,19,36
         STR     ""
         ENDR
*--------------------------------
         RSRC    PROT,0,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,1,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,2,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,3,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,4,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,5,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,6,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,7,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,8,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,9,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,10,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,11,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,12,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,13,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,14,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,15,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,16,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,17,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,18,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    PROT,19,32
         HEX     01010400010001
         ENDR
*--------------------------------
         RSRC    MCRO,0,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<3^M"ECT|&IER"*~"and:"******R'
         HEX     0000
         ASC     '1-(818) 991-5037'
         HEX     000000000000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,1,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<3^M"^E|&IER"*~<4^M"CT?"*Y"RD:"*<5^M'
         HEX     0000
         ASC     '1-(805) 656-3746'
         HEX     00
         ASC     'MAC;SYSOP'
         HEX     00
         ASC     'PASSWORD'
         HEX     00000000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,2,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<4^M"IER|2ECT"**ATDT<5^M"IER|2ECT"&'
         HEX     00
         ASC     '*~**^C"ID:"*<6^M"rd:"*<7^M'
         HEX     0000
         ASC     '1-(805) 499-0566'
         HEX     00
         ASC     '1-(805) 499-0371'
         HEX     00
         ASC     '74016,1741'
         HEX     00
         ASC     'PASS:WORD'
         HEX     0000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,3,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<4^M"IER|2ECT"**ATDT<5^M"IER|2ECT"&'
         HEX     00
         ASC     '*~**^C"ID:"*<6^M"rd:"*<7^M'
         HEX     0000
         ASC     '1-(805) 499-0566'
         HEX     00
         ASC     '1-(805) 499-0371'
         HEX     00
         ASC     '74016,1741'
         HEX     00
         ASC     'PASS:WORD'
         HEX     0000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,4,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<4^M"IER|2ECT"**ATDT<5^M"IER|2ECT"&'
         HEX     00
         ASC     '*~**^C"ID:"*<6^M"rd:"*<7^M'
         HEX     0000
         ASC     '1-(805) 499-0566'
         HEX     00
         ASC     '1-(805) 499-0371'
         HEX     00
         ASC     '74016,1741'
         HEX     00
         ASC     'PASS:WORD'
         HEX     0000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,5,32
         ASC     '*+++"IER|OK"**ATH^M'
         HEX     00
         ASC     '**ATDT<4^M"IER|2ECT"**ATDT<5^M"IER|2ECT"&'
         HEX     00
         ASC     '**~'
         HEX     0000
         ASC     '1-(713) 778-9419'
         HEX     00
         ASC     '1-(713) 778-9436'
         HEX     00000000
         ASC     '`'
         HEX     00
         ENDR
*--------------------------------
         RSRC    MCRO,6,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,7,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,8,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,9,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,10,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,11,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,12,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,13,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,14,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,15,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,16,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,17,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,18,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    MCRO,19,32
         HEX     00000000000000000000
         ENDR
*--------------------------------
         RSRC    TERM,0,32
         ASC     "TTY:bl=^G:bs=^H:ht=^I:lf=^J:ff=^L:cr=^M:"
         ASC     "ke=^M:kc=^L:kl=^H:kr=^I:ku=^J:kd=^J:"
         ASC     "k8=^Q:k9=^S:"
         ASC     "l0=F0:l1=F1:l2=F2:l3=F3:"
         ASC     "l4=F4:l5=F5:l6=F6:l7=F7:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,1,32
         ASC     "TTY:bl=^G:bs=^H:ht=^I:lf=^J:ff=^L:cr=^M:"
         ASC     "ke=^M:kc=^L:kl=^H:kr=^I:ku=^J:kd=^J:"
         ASC     "k8=^Q:k9=^S:"
         ASC     "l0=F0:l1=F1:l2=F2:l3=F3:"
         ASC     "l4=F4:l5=F5:l6=F6:l7=F7:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,2,32
         ASC     "VT100:bl=^G:bs=^H:ht=^I:lf=^J:lf=^K:ff=^L:cr=^M:"
         ASC     "up=\[A:dn=\[B:rt=\[C:lt=\[D:ho=\[H:"
         ASC     "cm=\[%i%#;%#H:cm=\[%#;%#f:ff=\[2J:cs=\[J:cl=\[K:nu=\<:"
         ASC     "ke=^M:kc=^L:kl=\[D:kr=\[C:ku=\[A:kd=\[B:"
         ASC     "k0=\OP:k1=\OQ:k2=\OR:k3=\OS:"
         ASC     "k4=\[A:k5=\[B:k6=\[D:k7=\[C:k8=^Q:k9=^S:"
         ASC     "l0=PF1:l1=PF2:l2=PF3:l3=PF4:"
         ASC     "l4=/%\:l5=%\/:l6=<-:l7=->:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,3,32
         ASC     "VT52:bl=^G:bs=^H:ht=^I:lf=^J:lf=^K:ff=^L:cr=^M:"
         ASC     "up=\A:dn=\B:rt=\C:lt=\D:ho=\H:"
         ASC     "cm=\Y%+ %+ :cs=\J:cl=\K:"
         ASC     "ke=^M:kc=^L:kl=\D:kr=\C:ku=\A:kd=\B:"
         ASC     "k0=\P:k1=\Q:k2=\R:k3=\S:"
         ASC     "k4=\A:k5=\B:k6=\D:k7=\C:k8=^Q:k9=^S:"
         ASC     "l0=PF1:l1=PF2:l2=PF3:l3=PF4:"
         ASC     "l4=/%\:l5=%\/:l6=<-:l7=->:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,4,32
         ASC     "Teleray:bl=^G:bs=^H:ht=^I:lf=^J:lf=^K:ff=^L:cr=^M:"
         ASC     "up=\A:dn=\B:rt=\C:lt=\D:ho=\H:"
         ASC     "cm=\Y%+ %+ :cs=\J:cs=\j:cl=\K:cl=\k:"
         ASC     "ic=\P:ic=\p:dc=\Q:dc=\q:il=\L:il=\l:dl=\M:dl=\m:"
         ASC     "ke=^M:kc=^L:kl=\D:kr=\C:ku=\A:kd=\B:"
         ASC     "k0=^Z1:k1=^Z2:k2=^Z3:k3=^Z4:"
         ASC     "k4=^Z5:k5=^Z6:k6=^Z7:k7=^Z8:k8=^Q:k9=^S:"
         ASC     "l0=F1:l1=F2:l2=F3:l3=F4:"
         ASC     "l4=F5:l5=F6:l6=F7:l7=F8:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,5,32
         ASC     "VT100+:bl=^G:bs=^H:ht=^I:lf=^J:lf=^K:lf=^L:cr=^M:"
         ASC     "up=\[A:dn=\[B:rt=\[C:lt=\[D:ho=\[H:"
         ASC     "cm=\[%i%#;%#H:cm=\[%#;%#f:ff=\[2J:cs=\[J:cl=\[K:"
         ASC     "nu=\[%#m:nu=\[%#;%#m:nu=\[%#v:nu=^O:nu=\<:"
         ASC     "ke=^M:kc=^L:kl=\[D:kr=\[C:ku=\[A:kd=\[B:"
         ASC     "k0=\OP:k1=\OQ:k2=\OR:k3=\OS:"
         ASC     "k4=\[A:k5=\[B:k6=\[D:k7=\[C:k8=^Q:k9=^S:"
         ASC     "l0=PF1:l1=PF2:l2=PF3:l3=PF4:"
         ASC     "l4=/%\:l5=%\/:l6=<-:l7=->:l8=Xon:l9=Xoff"
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,6,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,7,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,8,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,9,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,10,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,11,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,12,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,13,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,14,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,15,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,16,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,17,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,18,32
         HEX     00
         ENDR
*--------------------------------
         RSRC    TERM,19,32
         HEX     00
         ENDR
*--------------------------------
         END
