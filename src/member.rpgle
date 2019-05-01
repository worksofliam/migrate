
      //Hello
      //https://www.code400.com/inside.php?category=API
      
     h NoMain

      /INCLUDE './headers/member.rpgle'

     d PgmInfo        SDS
     d  xPgmName               1     10
     d  xParms                37     39  0
     d  xMsgID                40     46
     d  xJobName             244    253
     d  xUserId              254    263
     d  xJobNumber           264    269  0
      *
      * constants
      *
     d Q               c                   const('''')
     d Up              c                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
     d Low             c                   const('abcdefghijklmnopqrstuvwxyz')
      *
      *  Field Definitions.
      *
     d AllMembers      s             10a   inz('*ALL')
     d ApiFile         s             10
     d ApiLibrary      s             10
     d ApiMember       s             10
     d bOvr            s              1a   inz('0')
     d FileLib         s             20a
     d Format          s              8a
     d MemberName      s             10
     d nBufLen         s             10i 0
     d ObjectLib       s             10
     d OutData         s             30
     d ReceiverLen     s             10i 0 inz(100)
     d SpaceVal        s              1    inz(*BLANKS)
     d SpaceAuth       s             10    inz('*CHANGE')
     d SpaceText       s             50    inz(*BLANKS)
     d SpaceRepl       s             10    inz('*YES')
     d SpaceAttr       s             10    inz(*BLANKS)
     d UseScreen       s               n
     d UserSpaceOut    s             20
      *
      * QUSRMBRD API return Struture
      * ============================
     d Mbrd0100        ds                  inz
     d  nBytesRtn                    10i 0
     d  nBytesAval                   10i 0
     d  DBXLIB                       10a
     d  DBXFIL                       10a
     d  MbrName                      10a
     d  FileAttr                     10a
     d  SrcType                      10a
     d  dtCrtDate                    13a
     d  dtLstChg                     13a
     d  MbrText                      50a
     d  bIsSource                     1a
     d  RmtFile                       1a
     d  LglPhyFile                    1a
     d  ODPSharing                    1a
     d  filler2                       2a
     d  RecCount                     10i 0
     d  DltRecCnt                    10i 0
     d  DataSpaceSz                  10i 0
     d  AccpthSz                     10i 0
     d  NbrBasedOnMbr                10i 0
      *
      * Create userspace datastructure
      *
     d  stuff          DS
     d  StartPosit                   10i 0
     d  StartLen                     10i 0
     d  SpaceLen                     10i 0
     d  ReceiveLen                   10i 0
     d  MessageKey                   10i 0
     d  MsgDtaLen                    10i 0
     d  MsgQueNbr                    10i 0
      *
      * Date structure for retriving userspace info
      *
     d InputDs         DS
     d  UserSpace              1     20
     d  SpaceName              1     10
     d  SpaceLib              11     20
     d  InpFileLib            29     48
     d  InpFFilNam            29     38
     d  InpFFilLib            39     48
     d  InpRcdFmt             49     58
      *
      *  Data structure for the retrieve user space command
      *
     d GENDS           DS
     d  Filler3                     116
     d  OffsetHdr                    10i 0
     d  SizeHeader                   10i 0
     d  OffsetList                   10i 0
     d  Filler4                       4
     d  NbrInList                    10i 0
     d  SizeEntry                    10i 0
      *
      * Datastructure for retrieving elements from userspace
      *
     d HeaderDs        DS
     d  OutFileNam             1     10
     d  OutLibName            11     20
     d  OutType               21     25
     d  OutFormat             31     40
     d  RecordLen             41     44i 0
      *
      * Retrive object description
      *
     d RtvObjInfo      DS
     d  RoBytRtn                     10i 0
     d  RoBytAvl                     10i 0
     d  RoObjNam                     10a
     d  RoObjLib                     10a
     d  RoObjTypRt                   10a
     d  RoObjLibRt                   10a
     d  RoObjASP                     10i 0
     d  RoObjOwn                     10a
     d  RoObjDmn                      2a
     d  RoObjCrtDts                  07a
     d  RoObjCrtTim                  06a
     d  RoObjChgDts                  07a
     d  RoObjChgTim                  06a
     d  RoExtAtr                     10a
     d  RoTxtDsc                     50a
     d  RoSrcF                       10a
     d  RoSrcLib                     10a
     d  RoSrcMbr                     10a
      *
      * API Error Data Structure
      *
     d Errords         ds
     d  BytesPrv               1      4I 0 inz(%size(errords))
     d  BytesAvl               5      8I 0 inz(0)
     d  MessageId              9     15
     d  ERRxxx                16     16
     d  MessageDta            17    256

      **********************************

     P Mbrs_List       B                   Export
     D Mbrs_List       PI            10i 0
     D    pLibrary                   10A   Const
     D    pObject                    10A   Const

     c                   Eval      FileLib = pObject+pLibrary

     c                   exsr      xQUSCRTUS
      **
     c                   eval      MemberName = '*ALL'
     c                   eval      Format  = 'MBRL0200'
     c                   exsr      xQUSLMBR
      **
      **  Read back the members
      **
     c                   eval      StartPosit = 1
     c                   eval      StartLen = 140
      **
      ** First call to get data offsets(start)
      **
     c                   call(e)   'QUSRTVUS'
     c                   parm                    UserSpaceOut
     c                   parm                    StartPosit
     c                   parm                    StartLen
     c                   parm                    GENDS
     c                   parm                    ErrorDs
      **
      ** Then call to get number of entries
      **
     c                   eval      StartPosit = OffsetHdr + 1
     c                   eval      StartLen = SizeHeader
      **
     c                   call(e)   'QUSRTVUS'
     c                   parm                    UserSpaceOut
     c                   parm                    StartPosit
     c                   parm                    StartLen
     c                   parm                    HeaderDs
     c                   parm                    ErrorDs
      **
     c                   eval      StartPosit = OffsetList + 1
     c                   eval      StartLen = SizeEntry

     c                   return    NbrInList

      **========================================================================
      ** xQUSCRTUS - API to create user space
      **========================================================================
     c     xQUSCRTUS     begsr
      **
      ** Create a user space named ListMember in QTEMP.
      **
     c                   Eval      BytesPrv = 116
     c                   Eval      SpaceName = 'MEMBERS'
     c                   Eval      SpaceLib = 'QTEMP'
      **
      ** Create the user space
      **
     c                   call(e)   'QUSCRTUS'
     c                   parm      UserSpace     UserSpaceOut
     c                   parm                    SpaceAttr
     c                   parm      4096          SpaceLen
     c                   parm                    SpaceVal
     c                   parm                    SpaceAuth
     c                   parm                    SpaceText
     c                   parm                    SpaceRepl
     c                   parm                    ErrorDs
      **
     c                   endsr

      **========================================================================
      ** xQUSLMBR  - API List all members in a file
      **========================================================================
     c     xQUSLMBR      begsr
      **
     c                   eval      nBufLen = %size(MbrD0100)
      **
     c                   call(e)   'QUSLMBR'
     c                   parm                    UserSpaceOut
     c                   parm                    Format
     c                   parm                    FileLib
     c                   parm                    AllMembers
     c                   parm                    bOvr
     c                   parm                    ErrorDs
      *
     c                   endsr

     P                 E

      **********************************

     P Mbrs_Next       B                   Export
     D Mbrs_Next       PI                  LikeDS(ListDS)

     c                   call(e)   'QUSRTVUS'
     c                   parm                    UserSpaceOut
     c                   parm                    StartPosit
     c                   parm                    StartLen
     c                   parm                    ListDs
     c                   parm                    ErrorDs
      *
     c                   eval      ApiMember = LmMember

      ** This information is not needed right now
     c**                 exsr      xQUSRMBRD
      **
      ** Test comment

     c                   eval      StartPosit = StartPosit + SizeEntry

     c                   return    ListDS

     P                 E