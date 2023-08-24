# migrate

Tool to migrate source members to streamfiles.

### Installation

1. `git clone` this repository
2. Run `gmake` (available from yum)

### Optional: `gmake` Installation Notes
1. Make sure `5770SS1 option 13` is installed (`GO LICPGM`, option 10, review the list of installed LPPs)
2. Install `gmake` by running `yum install make-gnu`

### Usage instructions

1. `ADDLIBLE MIGRATE` (or whatever library you built into)
2. Create `OUTDIR()` directory where files will be placed. In the below example it would be `CRTDIR '/mydir'` otherwise you will get this error: `CPFA0A9 - Object not found`
3. `MIGSRCPF` has three parameters.
   1. `LIBRARY` is the library with the source members
   2. `SOURCEPF` is the source physical file with the source members
   3. `OUTDIR` is the directory files will be created in. Parameter must not end with a `/` (forward slash). For example, **`/mydir` is valid** but `/mydir/` is not.

A new directory will be created in your specified output directory with the name of the source physical file, which will then contain the copied source members.

### Examples

```
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/mydir')
MIGSRCPF LIBRARY(DEVLIB) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo')
MIGSRCPF LIBRARY(TESTPROJ) SOURCEPF(QRPGLESRC) OUTDIR('/myrepo')
```