        
        /INCLUDE './headers/utils.rpgle'
        /INCLUDE './headers/std.rpgle'
        /INCLUDE './headers/member.rpgle'
        
        Dcl-Pi MIGSRCPF;
          pLibrary Char(10);
          pSRCPF   Char(10);
          pOutDir  Char(128);
          pCCSID   Char(10);
        End-Pi;
        
        Dcl-S CmdStr  Varchar(256);
        Dcl-S DirName Varchar(128);
        Dcl-S MbrCnt  Int(5);
        Dcl-S IterNum Int(5);

        DirName = %TrimR(pOutDir) + '/' +  %TrimR(Utils_Lower(pSRCPF)) + '/';
        If (system('MKDIR DIR(''' + DirName + ''')') <> 0);
          
          Dsply ('Directory may already exist.');
        
        Endif;
        
        MbrCnt = Mbrs_List(pLibrary:pSRCPF);
        Dsply ('Member count: ' + %Char(MbrCnt));
        
        For Iternum = 1 to MbrCnt;
          ListDS = Mbrs_Next();
          LmMember = Utils_Lower(LmMember);
          LmType = Utils_Lower(LmType);
          // test 123
          //Attempt to copy member to streamfile
          //Dsply ('   ' + %TrimR(LmMember) + '.' + %TrimR(LmType));
          CmdStr = 'CPYTOSTMF FROMMBR('''
                   + '/QSYS.lib/'
                   + %TrimR(pLibrary) + '.lib/'
                   + %TrimR(pSRCPF) + '.file/'
                   + %TrimR(LmMember) + '.mbr'') '
                 + 'TOSTMF('''
                   + DirName + %TrimR(LmMember) + '.'
                    + %TrimR(LmType) + ''') '
                 + 'STMFOPT(*REPLACE) STMFCCSID(' + %TrimR(pCCSID) 
                 + ') ENDLINFMT(*LF)';
                 
          //If fails, display error
          If (system(CmdStr) = 1);
            Dsply ('Failed to copy ' 
                   + %TrimR(LmMember) + '.' + %TrimR(LmType));
          Endif;
                  
        Endfor;
        
        Dsply ('Finished change.');
        
        Return;
