        //No **FREE
        
        /INCLUDE './headers/utils.rpgle'
        /INCLUDE './headers/std.rpgle'
        /INCLUDE './headers/member.rpgle'
        
        Dcl-Pi MIGSRCPF;
          pLibrary Char(10);
          pSRCPF   Char(10);
          pOutDir  Char(128);
        End-Pi;
        
        Dcl-S DirName Varchar(128);
        Dcl-S MbrCnt  Int(5);
        Dcl-S IterNum Int(5);
        
        //TODO: CPYTOSTMF
        
        DirName = %TrimR(pOutDir) + '/' +  %TrimR(Utils_Lower(pSRCPF)) + '/';
        If (system('MKDIR DIR(''' + DirName + ''')') = 0);
        
          MbrCnt = Mbrs_List(pLibrary:pSRCPF);
          Dsply ('Member count: ' + %Char(MbrCnt));
          
          For Iternum = 1 to MbrCnt;
            ListDS = Mbrs_Next();
            LmMember = Utils_Lower(LmMember);
            LmType = Utils_Lower(LmType);
            
            Dsply ('   ' + %TrimR(LmMember) + '.' + %TrimR(LmType));
          Endfor;
        
        Else;
          
          Dsply ('Directory may already exist.');
        
        Endif;
        
        Return;