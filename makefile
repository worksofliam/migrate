DBGVIEW=*NONE
BIN_LIB=MIGRATE

all: clean $(BIN_LIB).lib migsrcpf.pgm migsrcpf.cmd

migsrcpf.pgm: migsrcpf.rpgle member.rpgle utils.sqlrpgle

%.lib:
	-system -q "CRTLIB $*"

%.pgm:
	$(eval modules := $(patsubst %,$(BIN_LIB)/%,$(basename $(filter %.rpgle %.sqlrpgle,$(notdir $^)))))
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(modules))"

%.rpgle:
	system "CRTRPGMOD MODULE($(BIN_LIB)/$*) SRCSTMF('./src/$*.rpgle') DBGVIEW($(DBGVIEW))"

%.sqlrpgle:
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('./src/$*.sqlrpgle') COMMIT(*NONE) OBJTYPE(*MODULE) DBGVIEW($(DBGVIEW))"

%.cmd:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QCMDSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('./src/$*.cmd') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QCMDSRC.file/$*.mbr') MBROPT(*ADD)"
	system "CRTCMD CMD($(BIN_LIB)/$*) PGM($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QCMDSRC)"

clean:
	-system "CLRLIB $(BIN_LIB)"
