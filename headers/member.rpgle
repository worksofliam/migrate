
      **
      ** List the members
      **
      //TODO: Make ListDs a template
     d ListDs          DS
     d  LmMember                     10
     d  LmType                       10
     d  LmCreationDt                  7
     d  LmCreationTm                  6
     d  LmLastChgDt                   7
     d  LmLastChgTm                   6
     d  LmDescription                50

     D Mbrs_List       PR            10i 0
     D    pLibrary                   10A   Const
     D    pObject                    10A   Const

     D Mbrs_Next       PR                  LikeDS(ListDs)
