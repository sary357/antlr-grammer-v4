CREATE OR REPLACE PROCEDURE ODS_JCIC.SP_BAM087
is

------------------------------------------------------------------------
-- Fubon JCIC ODS
--
-- Purpose:       BAM087 授信額度,擔保品,金額,還款紀錄資訊 (多筆 B33,資料年月自9405開始)
-- ETL Method:    Delete Insert

-- SA Doc:
-- SD Check Script:
--
--
-- Modification History
-- Person      Date         需求單/專案代碼   Comments
-- ---------   ----------   ---------------   ---------------------------------------------------
-- Gina          20101217                     First Version
-- Gina          20110816                     Change ETL Method TI to DI(因SOURCE只保留近40天資料)
-- Gina          20130523   201305210312-00   調整ATOM資料來源，防止主機清檔不一致造成資料重覆INSERT
----------------------------------------------------------------------------------------------

    v_DM_Subject                    varchar2( 30 ) := Upper( 'ODS_JCIC' );
    v_Program_Name                  varchar2( 30 ) := Upper( 'SP_BAM087' );
    v_Trans_Strategy                varchar2( 50 ) := 'DI';
    v_Trans_SN                      number( 15 );
    v_Job_SN                        number( 15 );
    v_Trans_Log                     varchar2( 4000 );
    v_Trans_Time_Line               varchar2( 2000 );
    v_Start_DateTime                date := sysdate;
    v_End_DateTime                  date;
    v_Period                        number;
    v_Period_String                 varchar2( 1000 );

    v_Pre_Row_Count                 number( 15 );
    v_Result_Row_Count              number( 15 );
    v_Insert_Row_Count              number( 15 );
    v_Delete_Row_Count              number( 15 );
    v_Snap_Date                     DATE:=sysdate;
begin


-- ==============================================
-- STAGE 1.0 : Get Trans_SN  and Set ETL Begine Log
-- ==============================================


    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, '1.0.1' );

    select    nvl( max( trans_sn ), 0 ) + 1 Trans_SN,
              nvl( max( decode( job_name, v_Program_Name, job_sn, 0 )), 0 ) + 1 Job_SN
      into    v_Trans_SN, v_Job_SN
      from    ods_system.dm_etl_log;

    ods_system.sp_DM_ETL_Log( v_trans_sn => v_Trans_SN,
                              v_DM_Subject => v_DM_Subject,
                              v_job_name => v_Program_Name,
                              v_job_sn => v_Job_SN,
                              v_status => 'S',
                              v_Data_Date => to_char( sysdate, 'YYYYMMDD' ),
                              v_remark => v_Trans_Time_Line );


-- ==============================================
-- STAGE 1.1 : Get Original Row Counts  and  Max Data's Date
-- ==============================================

    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, '1.1.1' );

    select    count(*)
      into    v_Pre_Row_Count
      from    ODS_JCIC.BAM087;


-- ==============================================
-- STAGE 2.0 : Insert Data into Target Table
-- ==============================================

    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, '2.0.0' );

      delete from ODS_JCIC.BAM087
      where IDN IN (select IDN from ODS_JCIC.DSA_ATOM where ATOM = 'BAM087' and DATA_COUNT > 0 group by IDN);

    v_Delete_Row_Count    := SQL%ROWCOUNT;
      commit work;

    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, '2.0.1' );
    ods_system.sp_DM_ETL_Log( v_trans_sn => v_Trans_SN,
                              v_status => 'T',
                              v_remark => v_Trans_Time_Line );


     insert into ODS_JCIC.BAM087
     (
        IDN,
        SDATE,
        DATA_YYYYMM,
        DATA_YYY,
        DATA_MM,
        MAIN_CODE,
        BANK_CODE,
        BANK_NAME,
        ACCOUNT_CODE,
        ACCOUNT_CODE2,
        PURPOSE_CODE,
        CONTRACT_AMT1,
        CONTRACT_AMT,
        LOAN_AMT,
        PASS_DUE_AMT,
        PAY_CODE_12,
        IS_KIND,
        PROJECT_CODE,
        CO_LOAN,
        UN_MARK,
        U_YYYMMDD,
        U_RATE,
        IB_MARK,
        IAB_BAN,
        IAB_NAME,
        CONTRACT_MARK,
        CONTRACT_CODE,
        CONTRACT_CODE1,
        CON_BAN,
        CON_NAME,
        ACT_Y_MARK,
        CONTRACT_AMT_Y,
        QSEQNO,
        SNAP_DATETIME
     )
     select
        TRIM(b.IDN)            IDN,
        b.SDATE                 SDATE,
        to_char((trim(a.DATA_YYY)*100+191100)+trim(a.DATA_MM)*1, 'FM999999')    DATA_YYYYMM,
        TRIM(a.DATA_YYY)       DATA_YYY,
        TRIM(a.DATA_MM)        DATA_MM,
        substr(trim(BANK_CODE),1,3)      MAIN_CODE,
        TRIM(a.BANK_CODE)      BANK_CODE,
        TRIM(a.BANK_NAME)      BANK_NAME,
        TRIM(a.ACCOUNT_CODE)   ACCOUNT_CODE,
        TRIM(a.ACCOUNT_CODE2)  ACCOUNT_CODE2,
        TRIM(a.PURPOSE_CODE)   PURPOSE_CODE,
        a.CONTRACT_AMT1  CONTRACT_AMT1,
        a.CONTRACT_AMT   CONTRACT_AMT,
        a.LOAN_AMT       LOAN_AMT,
        a.PASS_DUE_AMT   PASS_DUE_AMT,
        TRIM(a.PAY_CODE_12)    PAY_CODE_12,
        TRIM(a.IS_KIND)        IS_KIND,
        TRIM(a.PROJECT_CODE)   PROJECT_CODE,
        TRIM(a.CO_LOAN)        CO_LOAN,
        TRIM(a.UN_MARK)        UN_MARK,
        to_date(trim(a.U_YYYMMDD), 'YYYYMMDD')      U_YYYMMDD,
        a.U_RATE                U_RATE,
        TRIM(a.IB_MARK)        IB_MARK,
        TRIM(a.IAB_BAN)        IAB_BAN,
        TRIM(a.IAB_NAME)       IAB_NAME,
        TRIM(a.CONTRACT_MARK)  CONTRACT_MARK,
        TRIM(a.CONTRACT_CODE)  CONTRACT_CODE,
        TRIM(a.CONTRACT_CODE1) CONTRACT_CODE1,
        TRIM(a.CON_BAN)        CON_BAN,
        TRIM(a.CON_NAME)       CON_NAME,
        TRIM(a.ACT_Y_MARK)     ACT_Y_MARK,
        a.CONTRACT_AMT_Y        CONTRACT_AMT_Y,
        TRIM(a.QSEQNO)         QSEQNO,
        v_Snap_Date            SNAP_DATETIME
    from
        TB_MJC.MQ_T_BAM087@SRC_CLMDB a,
        ODS_JCIC.DSA_ATOM b
    where
        trim(a.QSEQNO) = b.QSEQNO and
        b.ATOM = 'BAM087' and
        b.DATA_COUNT > 0;

    v_Insert_Row_Count    := SQL%ROWCOUNT;

    commit work;




-- ==============================================
-- STAGE 3.0.1 : Get Result Row Count
-- ==============================================

    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, '3.0.1' );
    ods_system.sp_DM_ETL_Log( v_trans_sn => v_Trans_SN,
                              v_status => 'A',
                              v_remark => v_Trans_Time_Line );


    select    count(*)
      into    v_Result_Row_Count
      from    ODS_JCIC.BAM087;


-- ==============================================
-- STAGE 3.0.2 : Set ETL Ending Log
-- ==============================================

    ods_system.sp_DM_ETL_TimeLine( v_Trans_Time_Line, 'END' );

    v_End_DateTime := sysdate;
    v_Period := ( v_End_DateTime - v_Start_DateTime    ) * 86400;
    v_Period_String := trim( to_char( mod( trunc( v_Period / 3600 ), 60 ), '00' )) || ':' || trim( to_char( mod( trunc( v_Period / 60 ), 60 ), '00' )) || ':' || trim( to_char( mod( v_Period, 60 ), '00' ));

    v_Trans_Log := 'ODS_JCIC : TransSN = ' || v_Trans_SN || ' ( ' || v_Result_Row_Count || ' Rows )' ||
                   chr( 13 ) || chr( 10 ) || 'ETL Strategy: ' || v_Trans_Strategy || ', ETL Incremential Time Base : Full Inc.' ||
                   chr( 13 ) || chr( 10 ) || 'Before Transformation Row Counts - BAM087: ' || v_Pre_Row_Count || ' Rows' ||
                   chr( 13 ) || chr( 10 ) || 'Delete Row Counts - BAM087: ' || v_Delete_Row_Count || ' Rows' ||
                   chr( 13 ) || chr( 10 ) || 'Insert Row Counts - BAM087: ' || v_Insert_Row_Count || ' Rows' ||
                   chr( 13 ) || chr( 10 ) || 'ETL Time Line : ' || v_Trans_Time_Line ||
                   chr( 13 ) || chr( 10 ) || 'Total Executing Times : ' || v_Period_String;

    ods_system.sp_DM_ETL_Log( v_trans_sn => v_Trans_SN,
                              v_status => 'F',
                              v_remark => v_Trans_Log );

exception
    when others then

        rollback;

        ods_system.sp_DM_ETL_Log( v_trans_sn => v_Trans_SN,
                                  v_status => 'E',
                                  v_remark => 'SQL error : ' || SQLErrM || chr( 13 ) || chr( 10 ) || v_Trans_Time_Line );

end;
/
