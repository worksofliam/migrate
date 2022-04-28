# migrate

Tool to migrate source members to streamfiles.

### Installation

1. `git clone` this repository
2. Run `gmake` (available from yum)

### Usage instructions

1. `ADDLIBLE MIGRATE` (or whatever library you built into)
2. `MIGSRCPF` has four parameters.
   1. `LIBRARY` is the library with the source members
   2. `SOURCEPF` is the source physical file with the source members
   3. `OUTDIR` is the directory files will be created in. Parameter must not end with a `/` (forward slash). For example, **`/mydir` is valid** but `/mydir/` is not.
   4. `ASPDEV` is the ASP device where the library stands. Default is the system ASP (*SYSBAS).

A new directory will be created in your specified output directory with the name of the source physical file, which will then contain the copied source members.

### Examples

```
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/mydir')
MIGSRCPF LIBRARY(DEVLIB) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo')
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo')
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo') ASPDEV(MYASP)
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo') ASPDEV(*SYSBAS)
```