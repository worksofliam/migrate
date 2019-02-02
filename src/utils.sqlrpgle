        Ctl-Opt NoMain;
        
        Dcl-Proc Utils_Lower Export;
          Dcl-Pi *N Char(10);
            pValue Char(10) Value;
          End-Pi;
          
          EXEC SQL SET :pValue = LOWER(:pValue);
          
          Return pValue;
        End-Proc;