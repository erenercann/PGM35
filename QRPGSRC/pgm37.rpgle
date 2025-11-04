      *----------------------------------------------------------------------------
     FPGM35TAB  IF   E           K DISK
     FPGM37D    CF   E             WORKSTN SFILE(LISTE:RRN001)
      *----------------------------------------------------------------------------
     D RRN001          S              4S 0 INZ(0)
     D MAX001          S              4S 0 INZ(0)
      *----------------------------------------------------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    pITEMCODE         6 0
     C                   PARM                    pSELCOD           1
      *
     C                   EVAL      pSELCOD = *BLANKS
     C                   EVAL      pITEMCODE = 0
      *
     C                   EXSR      CLR_LIST
     C                   EXSR      CRT_LIST
     C                   EXSR      DSP_LIST
      *
     C                   SETON                                        LR
      *---------------------------------------------------------------------------
     C     CLR_LIST      BEGSR
     C                   SETOFF                                       9293
     C                   SETON                                        91
     C                   WRITE     LISTEC
     C                   ENDSR
      *---------------------------------------------------------------------------
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
     C                   EVAL      SELCOD = ' '
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
     C                   EXFMT     LISTEC
     C                   IF        *IN03 = *OFF AND *IN12 = *OFF
     C                   IF        MAX001 > 0
     C     1             DO        MAX001        XX                4 0
     C     XX            CHAIN     LISTE                              99
     C                   IF        *IN99 = *OFF AND SELCOD <> ' '
     C                   EVAL      pSELCOD = '1'
     C                   EVAL      pITEMCODE = ITEMCODE
     C                   SETON                                        03
     C                   LEAVE
     C                   ENDIF
     C                   ENDDO
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   ENDSR
      *---------------------------------------------------------
