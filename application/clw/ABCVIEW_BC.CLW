  MEMBER('abcview.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('abcview_BC0.CLW')
abcview_BC0:DctInit             PROCEDURE()
abcview_BC0:DctKill             PROCEDURE()
abcview_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  abcview_BC0:DctInit
  abcview_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  abcview_BC0:DctKill

