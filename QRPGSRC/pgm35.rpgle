      *---------------------------------------------------------------------------------------------
     FPGM35TAB  UF A E           K DISK
     FPGM35D    CF   E             WORKSTN
      *---------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------
     C                   EVAL      ITEMCODE1 = 0
     C                   EVAL      MSGACK = *BLANKS
     C                   EVAL      DATE0 = *DAY*1000000+*MONTH*10000+ *YEAR
     C                   DOW       *IN03 = *OFF AND
     C                             *IN12 = *OFF AND
     C                             *IN10 = *OFF
     C                   EXFMT     EKRAN1
     C                   EVAL      MSGACK = *BLANKS
     C                   IF        *IN04 = *ON
     C                   EXSR      KOD_BUL
     C                   ENDIF
     C                   IF        *IN10 = *ON
     C                   EXSR      ADIM3
     C                   ENDIF
     C                   IF        *IN03 = *OFF AND
     C                             *IN12 = *OFF AND
     C                             *IN04 = *OFF AND
     C                             *IN05 = *OFF
     C                   EVAL      MSGACK = *BLANKS
     C                   EVAL      ITEMCODE = ITEMCODE1
     C     ITEMCODE      CHAIN     PGM35TABR                          99
     C                   IF        *IN99 = *OFF
     C                   EXSR      ADIM2
     C                   ELSE
     C                   EVAL      MSGACK = '**KAYIT BULUNAMADI**'
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
      *
     C                   SETON                                        LR
      *--------------------------------------------------------------------
     C     ADIM2         BEGSR
     C                   SETOFF                                       23
     C                   EVAL      DATE0 = *DAY*1000000+*MONTH*10000+ *YEAR
     C                   DOW       *IN03 = *OFF AND *IN10 = *OFF AND
     C                             *IN12 = *OFF AND *IN23 = *OFF
     C                   EXFMT     EKRAN2
     C                   EVAL      MSGACK = *BLANKS
     C                   IF        *IN23 = *ON
     C                   EXSR      DELETE
     C                   ENDIF
     C                   IF        *IN03 = *OFF AND *IN12 = *OFF AND
     C                             *IN10 = *OFF AND *IN23 = *OFF
     C                   EXSR      KONTROL
     C                   IF        *IN30 = *OFF
      **kay`t ok
     C                   UPDATE    PGM35TABR
     C                   SETON                                        12
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C   12              SETOFF                                       12
     C                   ENDSR
      *-------------------------------------------------------------------
      *KONTROL REGISTER
      *-------------------------------------------------------------------
     C     KONTROL       BEGSR
     C                   SETOFF                                       30
     C                   EVAL      MSGACK = *BLANKS
      *
     C  N30              IF        ITEMCODE = 0
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'ITEMCODE BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        PRODNAME = *BLANKS
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'PRODNAME BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        LENGHT = 0
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'LENGHT BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        QUANTITY = 0
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'QUANTITY BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        LOCATION = *BLANKS
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'LOCATION BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        BOXNUMBR = 0
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'BOXNUMBER BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        COLORCOD = *BLANKS
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'COLORCOD BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        TYPE = *BLANKS
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'TYPE BOS OLAMAZ..'
     C                   ENDIF
      *
     C  N30              IF        DEPOTCOD = 0
     C                   SETON                                        30
     C                   EVAL      MSGACK = 'DEPOTCOD BOS OLAMAZ..'
     C                   ENDIF
      *
     C                   ENDSR
      *-----------------------------------------------------------------
      *WRITE REGISTER
      *-----------------------------------------------------------------
     C     ADIM3         BEGSR
     C                   EVAL      DATE0 = *DAY*1000000+*MONTH*10000+ *YEAR
     C                   EVAL      ITEMCODE = 0
     C                   EVAL      PRODNAME = *BLANKS
     C                   EVAL      LENGHT = 0
     C                   EVAL      QUANTITY = 0
     C                   EVAL      LOCATION = *BLANKS
     C                   EVAL      BOXNUMBR = 0
     C                   EVAL      COLORCOD = *BLANKS
     C                   EVAL      TYPE = *BLANKS
     C                   EVAL      DEPOTCOD = 0
     C                   EVAL      MSGACK = *BLANKS
     C                   IF        ITEMCODE > 0
     C                   ENDIF
     C                   DOW       *IN03 = *OFF AND *IN12 = *OFF
     C                   EXFMT     EKRAN3
     C**                 IF        *IN03 = *OFF AND *IN12 = *OFF AND
     C**                           *IN23 = *OFF
     C                   EXSR      KONTROL
     C**                 EXFMT     EKRAN3
     C                   IF        *IN30 = *OFF
     C                   WRITE     PGM35TABR
     C                   SETON                                        12
     C**                 ENDIF
     C                   ENDIF
     C                   ENDDO
     C   12              SETOFF                                       12
     C                   ENDSR
      *----------------------------------------------------------------------
      *DELETE REGISTER
      *----------------------------------------------------------------------
     C     DELETE        BEGSR
     C                   EVAL      MSGACK = 'SILMEK ICIN TEKRAR F23 BASINIZ.'
     C                   IF        *IN23 = *ON
     C                   EXFMT     EKRAN2
     C                   IF        *IN23 = *ON
     C                   DELETE    PGM35TABR
     C                   EVAL      MSGACK = 'KAYIT SILINMISTIR.'
     C                   ELSE
     C                   EVAL      MSGACK = 'SILME ISLEMI IPTAL EDILDI.'
     C                   ENDIF
     C                   ENDIF
     C                   SETON                                        12
     C   12              SETOFF                                       12
     C                   ENDSR
      *-----------------------------------------------------------------
     C     KOD_BUL       BEGSR
     C                   CALL      'PGM37'
     C                   PARM      0             pITEMCODE         6 0
     C                   PARM      ' '           pSELCOD           1
      *
     C                   IF        pSELCOD <> ' '
     C                   EVAL      ITEMCODE1 = pITEMCODE
     C                   ENDIF
     C                   ENDSR
