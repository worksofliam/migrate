DBGVIEW=*NONE
BIN_LIB=MIGRATE

all: clean $(BIN_LIB).lib migsrcpf.pgm

migsrcpf.pgm: migsrcpf.rpgle member.rpgle

%.lib:
	-system -q "CRTLIB $*"

%.pgm:
	$(eval modules := $(patsubst %,$(BIN_LIB)/%,$(basename $(filter %.rpgle,$(notdir $^)))))
	system "CRTPGM PGM($(BIN_LIB)/$*) MODULE($(modules))"

%.rpgle:
	system "CRTRPGMOD MODULE($(BIN_LIB)/$*) SRCSTMF('./src/$*.rpgle') DBGVIEW($(DBGVIEW))"

clean:
	-system "CLRLIB $(BIN_LIB)"