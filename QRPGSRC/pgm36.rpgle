      *---------------------------------------------------------------------------------------------
     FPGM35TAB  IF   E           K DISK
     FPGM36D    CF   E             WORKSTN SFILE(LISTE:RRN001)
      *--------------------------------------------------------------
     D ITEMCODE1       S              6S 0 INZ(0)
     D ITEMCODE        S              6S 0 INZ(0)
     D MSGACK          S             77A   INZ(*BLANKS)
     D PRODNAME        S             20A   INZ(*BLANKS)
     D LENGHT          S              6S 0 INZ(0)
     D QUANTITY        S              6S 0 INZ(0)
     D LOCATION        S              4A   INZ(*BLANKS)
     D BOXNUMBR        S             10S 0 INZ(0)
     D COLORCOD        S              5A   INZ(*BLANKS)
     D TYPE            S              1A   INZ(*BLANKS)
     D DEPOTCOD        S              2S 0 INZ(0)
     D DATE0           S              8S 0 INZ(0)
     D RRN001          S              4S 0 INZ(0)
     D MAX001          S              4S 0 INZ(0)
      *--------------------------------------------------------------
     C                   EXSR      CLR_LIST
     C                   EXSR      CRT_LIST
     C                   EXSR      DSP_LIST
      *
     C                   SETON                                        LR
      *-------------------------------------------------------------------------
     C     CLR_LIST      BEGSR
     C                   SETOFF                                       9293
     C                   SETON                                        91
     C                   WRITE     LISTEC
     C                   ENDSR
      *-------------------------------------------------------------------------
     C     CRT_LIST      BEGSR
     C                   SETOFF                                       91
     C                   SETON                                        9293
     C                   EVAL      MAX001 = 0
     C                   EVAL      RRN001 = 0
     C     *LOVAL        SETLL     PGM35TABR
     C                   READ      PGM35TABR                              99
     C                   DOW       NOT *IN99
     C                   EVAL      RRN001 = RRN001 + 1
     C                   EVAL      MAX001 = RRN001
     C                   EVAL      SEQNBR = RRN001
     C                   WRITE     LISTE
     C                   READ      PGM35TABR                              99
     C                   ENDDO
     C                   ENDSR
      *------------------------------------------------------------------------
     C     DSP_LIST      BEGSR
     C                   SETOFF                                       91
     C                   SETON                                        92
     C     MAX001        COMP      0                                  93
     C                   DOW       *IN03 = *OFF AND *IN12 = *OFF
     C                   WRITE     BASLIK1
     C                   WRITE     TUSLAR1
     C                   EXFMT     LISTEC
     C                   ENDDO
     C                   ENDSR
      *-------------------------------------------------------------------
