**FREE
CTL-OPT NOMAIN;

// IBM's include file for QUSROBJD API data structures
/INCLUDE QSYSINC/QRPGLESRC,QUSROBJD        

// Prototype the call to IBM's QUSROBJD API 
DCL-PR GetObjDesc EXTPGM('QUSROBJD');
    Receiver CHAR(32765) OPTIONS(*VARSIZE);
    Length   INT(10) CONST;
    Format   CHAR(8) CONST;
    ObjectName CHAR(20) CONST;
    ObjectType CHAR(10) CONST;
END-PR;



// Return the ASP for an object
DCL-PROC GetObjAsp EXPORT;
    DCL-PI *N CHAR(10);
        Library CHAR(10) CONST;
        Object  CHAR(10) CONST;
        ObjType CHAR(10) CONST;
    END-PI;

    GetObjDesc(QUSD0400:%SIZE(QUSD0400):'OBJD0400':Object+Library:ObjType);

    IF QUSOASPD <> '*NONE' AND QUSOASPD <> '*SYSBAS';
        RETURN QUSOASPD;    
    ELSE;
        RETURN *BLANKS;
    ENDIF;

END-PROC;    
