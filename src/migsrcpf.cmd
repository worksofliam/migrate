             CMD        Prompt('Migrate Source PF')
             
             PARM       KWD(LIBRARY)  TYPE(*CHAR) LEN(10) +
                        PROMPT('Source Library')
             PARM       KWD(SOURCEPF) TYPE(*CHAR) LEN(10) +
                        PROMPT('Source PF') ALWUNPRT(*NO)
             PARM       KWD(OUTDIR) TYPE(*CHAR) LEN(128)  +
                        PROMPT('Output Directory') ALWUNPRT(*NO) 