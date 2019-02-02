        //No **FREE
        
        /INCLUDE './headers/member.rpgle'
        
        Dcl-Pi MIGSRCPF;
          pLibrary Char(10);
          pSRCPF   Char(10);
          pOutDir  Char(128);
        End-Pi;
        
        Dcl-S MbrCnt  Int(5);
        Dcl-S IterNum Int(5);
        
        MbrCnt = Mbrs_List(pLibrary:pSRCPF);
        Dsply ('Member count: ' + %Char(MbrCnt));
        
        For Iternum = 1 to MbrCnt;
          ListDS = Mbrs_Next();
          Dsply ('   ' + %TrimR(LmMember) + '.' + %TrimR(LmType));
        Endfor;
        
        Return;