PROC scx_cpu1_cs_tdt2
;*******************************************************************************
;  Test Name:  cs_tdt2
;  Test Level: Build Verification
;  Test Type:  Functional
;
;  Test Description
;	The purpose of this procedure is to generate the default Tables
;	Definition Table for the Checksum Application.
;
;  Requirements Tested:
;	None
;
;  Prerequisite Conditions
;	None
;
;  Assumptions and Constraints
;	None.
;
;  Change History
;
;	Date		   Name		Description
;	07/18/11	Walt Moleski	Initial release.
;	02/24/15	Walt Moleski	Switched app and tables entries since
;					the DefTablesTbl is a special case.
;       03/01/17        Walt Moleski    Updated for CS 2.4.0.0 using CPU1 for
;                                       commanding and added a hostCPU variable
;                                       for the utility procs to connect to the
;                                       proper host IP address.
;
;  Arguments
;	None.
;
;  Procedures Called
;	Name			Description
;      create_tbl_file_from_cvt Procedure that creates a load file from
;                               the specified arguments and cvt
;
;  Expected Test Results and Analysis
;
;**********************************************************************

local logging = %liv (log_procedure)
%liv (log_procedure) = FALSE

#include "cs_msgdefs.h"
#include "cs_platform_cfg.h"
#include "cs_tbldefs.h"

%liv (log_procedure) = logging

;**********************************************************************
; Define local variables
;**********************************************************************
LOCAL defTblId, defPktId
local CSAppName = "CS"
local ramDir = "RAM:0"
local hostCPU = "CPU3"
local tblDefTblName = CSAppName & "." & CS_DEF_TABLES_TABLE_NAME
local tblResTblName = CSAppName & "." & CS_RESULTS_TABLES_TABLE_NAME

;;; Set the pkt and app IDs for the tables based upon the cpu being used
;; CPU1 is the default
defTblId = "0FAE"
defPktId = 4014

write ";*********************************************************************"
write ";  Define the Application Definition Table "
write ";********************************************************************"
;; States are 0=CS_STATE_EMPTY; 1=CS_STATE_ENABLED; 2=CS_STATE_DISABLED;
;;            3=CS_STATE_UNDEFINED
SCX_CPU1_CS_TBL_DEF_TABLE[0].State = CS_STATE_ENABLED
SCX_CPU1_CS_TBL_DEF_TABLE[0].Name = CSAppName & "." & CS_DEF_APP_TABLE_NAME
SCX_CPU1_CS_TBL_DEF_TABLE[1].State = CS_STATE_EMPTY
SCX_CPU1_CS_TBL_DEF_TABLE[1].Name = ""
SCX_CPU1_CS_TBL_DEF_TABLE[2].State = CS_STATE_ENABLED
SCX_CPU1_CS_TBL_DEF_TABLE[2].Name = CSAppName & "." & CS_RESULTS_APP_TABLE_NAME
SCX_CPU1_CS_TBL_DEF_TABLE[3].State = CS_STATE_EMPTY
SCX_CPU1_CS_TBL_DEF_TABLE[3].Name = ""
SCX_CPU1_CS_TBL_DEF_TABLE[4].State = CS_STATE_ENABLED
SCX_CPU1_CS_TBL_DEF_TABLE[4].Name = "LC.LC_ART"
SCX_CPU1_CS_TBL_DEF_TABLE[5].State = CS_STATE_EMPTY
SCX_CPU1_CS_TBL_DEF_TABLE[5].Name = ""
SCX_CPU1_CS_TBL_DEF_TABLE[6].State = CS_STATE_ENABLED
SCX_CPU1_CS_TBL_DEF_TABLE[6].Name = tblDefTblName
SCX_CPU1_CS_TBL_DEF_TABLE[7].State = CS_STATE_EMPTY
SCX_CPU1_CS_TBL_DEF_TABLE[7].Name = ""
SCX_CPU1_CS_TBL_DEF_TABLE[8].State = CS_STATE_DISABLED
SCX_CPU1_CS_TBL_DEF_TABLE[8].Name = tblResTblName
SCX_CPU1_CS_TBL_DEF_TABLE[9].State = CS_STATE_EMPTY
SCX_CPU1_CS_TBL_DEF_TABLE[9].Name = ""

;; Clear out the remaining entries in the table
for i = 10 to CS_MAX_NUM_TABLES_TABLE_ENTRIES-1 do
  SCX_CPU1_CS_TBL_DEF_TABLE[i].State = CS_STATE_EMPTY
  SCX_CPU1_CS_TBL_DEF_TABLE[i].Name = ""
enddo

local lastEntry = CS_MAX_NUM_TABLES_TABLE_ENTRIES - 1
local endmnemonic = "SCX_CPU1_CS_TBL_DEF_TABLE[" & lastEntry & "].Name"

;; Create the Table Load file
s create_tbl_file_from_cvt (hostCPU,defTblId,"Table Definition Table Load 2","tbl_def_tbl_ld_2",tblDefTblName,"SCX_CPU1_CS_TBL_DEF_TABLE[0].State",endmnemonic)

write ";*********************************************************************"
write ";  End procedure SCX_CPU1_cs_tdt2                              "
write ";*********************************************************************"
ENDPROC