DROP TABLE FeatureTest;
DROP TABLE RequestTest;
DROP TABLE RequestFeature;
DROP TABLE TaskMember;
DROP TABLE TaskOutput;
DROP TABLE History;
DROP TABLE Defect;
DROP TABLE FileDetail;

DROP TABLE TestDetail;
DROP TABLE Risk;
DROP TABLE Feature;
DROP TABLE Request;
DROP TABLE Task;
DROP TABLE Output;
DROP TABLE FileMaster;

DROP TABLE TestMaster;
DROP TABLE ProjectMember;
DROP TABLE Team;
DROP TABLE System;

DROP TABLE Member;
DROP TABLE Project;
DROP TABLE UserGroup;
DROP TABLE CodeDetail;
DROP TABLE CommonCode;

DROP SEQUENCE seq_project;
DROP SEQUENCE seq_team;
DROP SEQUENCE seq_member;
DROP SEQUENCE seq_usergroup;
DROP SEQUENCE seq_system;
DROP SEQUENCE seq_feature;
DROP SEQUENCE seq_testmaster;
DROP SEQUENCE seq_defect;
DROP SEQUENCE seq_testdetail;
DROP SEQUENCE seq_task;
DROP SEQUENCE seq_output;
DROP SEQUENCE seq_filemaster;
DROP SEQUENCE seq_filedetail;
DROP SEQUENCE seq_request;
DROP SEQUENCE seq_risk;
DROP SEQUENCE seq_history;

----------------------------------------------------------------------------------------------------------------------
-- CREATE TABLE
CREATE TABLE UserGroup (
    grp_no number NOT NULL,
    grp_nm VARCHAR2(50) NOT NULL,
    par_grp_no NUMBER NULL
);

CREATE TABLE Member (
    mem_no number NOT NULL,
    grp_no NUMBER NULL,
    login_id VARCHAR2(100) NOT NULL,
    pw VARCHAR2(200) NOT NULL,
    mem_nm VARCHAR2(10) NOT NULL,
    phone_no VARCHAR2(15) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    auth_cd CHAR(8) NOT NULL,
    pos_nm VARCHAR2(8) NULL,
    birth_dt VARCHAR2(30) NULL,
    tech_grd_cd CHAR(8) NULL,
    org VARCHAR2(70) NULL,
    use_yn VARCHAR2(1) NOT NULL,
    rec_prj NUMBER NULL
);

CREATE TABLE team (
    tm_no number NOT NULL,
    tm_nm VARCHAR2(200) NOT NULL,
    tm_cont VARCHAR2(200) NULL,
    use_yn VARCHAR2(1) NULL,
    par_tm_no NUMBER NULL,
    order_no NUMBER NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NULL,
    reg_id VARCHAR2(100) NULL,
    reg_dt DATE NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL
);

CREATE TABLE projectMember (
    mem_no NUMBER NOT NULL,
    tm_no NUMBER NOT NULL,
    prj_no NUMBER NOT NULL,
    prj_auth_cd CHAR(8) NOT NULL,
    pre_start_dt DATE NULL,
    pre_end_dt DATE NULL,
    start_dt DATE NULL,
    end_dt DATE NULL,
    use_yn VARCHAR2(1) NOT NULL,
    reg_id VARCHAR2(100) NULL,
    reg_dt DATE NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL
);

CREATE TABLE project (
    prj_no number NOT NULL,
    prj_title VARCHAR2(200) NOT NULL,
    prj_cont VARCHAR2(1000) NOT NULL,
    stat_cd CHAR(8) NOT NULL,
    prg number NOT NULL,
    org VARCHAR2(50) NOT NULL,
    pre_st_dt DATE NOT NULL,
    pre_end_dt DATE NOT NULL,
    st_dt DATE NULL,
    end_dt DATE NULL,
    use_yn VARCHAR2(1) NOT NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL
);

CREATE TABLE System (
    sys_no number NOT NULL,
    sys_ttl	VARCHAR2(100) NOT NULL,
    sys_cont VARCHAR2(1000) NOT NULL,
    prj_no NUMBER NOT NULL,
    par_sys_no NUMBER NULL,
    sys_yn VARCHAR2(10) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE Task (
    tsk_no number NOT NULL,
    order_no NUMBER NOT NULL,
    tsk_ttl VARCHAR2(100) NOT NULL,
    tsk_stat_cd CHAR(8) NOT NULL,
    pre_st_dt DATE NOT NULL,
    pre_end_dt DATE NOT NULL,
    st_dt DATE NULL,
    end_dt DATE NULL,
    weight_val NUMBER NULL,
    prg NUMBER NOT NULL,
    rel_out_nm VARCHAR2(100) NULL,
    use_yn VARCHAR2(1) NOT NULL,
    par_task_no NUMBER NULL,
    ante_task_no NUMBER NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL
);

CREATE TABLE TaskMember (
    mem_no NUMBER NOT NULL,
    tm_no NUMBER NOT NULL,
    tsk_no NUMBER NOT NULL,
    prj_no NUMBER NOT NULL
);

CREATE TABLE Feature (
    feat_no	number NOT NULL,
    feat_id	VARCHAR2(20) NOT NULL,
    feat_title VARCHAR2(100) NOT NULL,
    feat_cont VARCHAR2(500) NOT NULL,
    pre_st_dt DATE NOT NULL,
    pre_end_dt DATE NOT NULL,
    st_dt DATE NULL,
    end_dt DATE NULL,
    stat_cd CHAR(8) NOT NULL,
    pri_cd CHAR(8) NOT NULL,
    prg	NUMBER NOT NULL,
    diff_cd CHAR(8) NOT NULL,
    class_cd CHAR(8) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL,
    sys_no NUMBER NULL,
    mem_no NUMBER  NULL,
    tm_no NUMBER  NULL,
    prj_no NUMBER NOT NULL
);

CREATE TABLE CommonCode (
    common_cd_no CHAR(6) NOT NULL,
    cd_nm VARCHAR2(40) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE CodeDetail (
    cd_dtl_no CHAR(8) NOT NULL,
    common_cd_no CHAR(6) NOT NULL,
    cd_dtl_nm CHAR(40) NOT NULL,
    order_no NUMBER NOT NULL,
    field_1 NUMBER NULL,
    field_2 VARCHAR2(10) NULL,
    field_3 VARCHAR2(10) NULL,
    field_4 VARCHAR2(10) NULL,
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE FileMaster (
    fl_ms_no number NOT NULL,
    fl_cd CHAR(8) NULL,
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE FileDetail (
    fl_no number NOT NULL,
    original_ttl VARCHAR2(200) NOT NULL,
    file_path VARCHAR2(500) NOT NULL,
    fl_type VARCHAR2(80) NOT NULL,
    fl_size NUMBER NOT NULL,
    fl_ms_no NUMBER NOT NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    del_id VARCHAR2(100) NULL,
    del_dt DATE NULL
);

CREATE TABLE Output (
    opt_no number NOT NULL,
    opt_ttl VARCHAR2(100) NOT NULL,
    note VARCHAR2(1000) null,
    prj_no NUMBER NOT NULL,
    high_folder_no NUMBER NULL,
    fld_yn VARCHAR2(1) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL,
    fl_ms_no NUMBER NULL
);

CREATE TABLE TaskOutput (
    task_no NUMBER NOT NULL,
    folder_no NUMBER NOT NULL
);

CREATE TABLE TestMaster (
    test_no	number NOT NULL,
    test_id VARCHAR2(100) NOT NULL,
    test_title VARCHAR2(200) NOT NULL,
    test_cont VARCHAR2(200) NOT NULL,
    stat_cd	CHAR(8) NOT NULL,
    type_cd	CHAR(8) NOT NULL,
    test_st_dt DATE NULL,
    test_end_dt	DATE NULL,
    prj_no NUMBER NOT NULL,
    sys_work_no NUMBER NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL,
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE TestDetail (
    test_dtl_no   number NOT NULL,
    test_dtl_id   VARCHAR2(30) NULL,
    wrk_proc_cont VARCHAR2(1000) NULL,  -- 업무처리내용
    test_data VARCHAR2(1000) NULL,      -- 테스트데이터
    estimated_rlt VARCHAR2(1000)   NULL,   -- 예상결과
    test_detail_cont VARCHAR2(1000) NULL,      -- 테스트상세내용
    progress_cont VARCHAR2(1000) NULL,       -- 수행절차
    pre_cond VARCHAR2(1000)   NULL,           -- 사전조건
    test_st_dt DATE   NULL,                       -- 테스트진행일자
    test_result_cd CHAR(8) NULL,                -- 테스트결과코드
    mem_no NUMBER NULL,                         -- 테스트 담당자
    par_test_dtl_no NUMBER NULL,
    created_dt DATE NOT NULL,                       -- 생성일자
    test_no   NUMBER NOT NULL                 -- 테스트번호
);

CREATE TABLE Defect (
    df_no number NOT NULL,
    df_id VARCHAR(20) NOT NULL,
    df_ttl VARCHAR2(100) NOT NULL,
    stat_cd CHAR(8) NOT NULL,               -- 결함상태
    pri_cd CHAR(8) NOT NULL,                -- 우선순위
    type_cd CHAR(8) NOT NULL,               -- 결함구분
    df_cont VARCHAR2(500) NOT NULL,         -- 결함내용
    df_fd_dt DATE NOT NULL,                 -- 결함발견일
    due_dt DATE NULL,                       -- 결함 조치 희망일
    work_dt DATE NULL,                      -- 결함조치일자
    df_work_cont VARCHAR2(500) NULL,        -- 결함조치내용
    fl_ms_fd_no NUMBER NULL,                -- 결함발견첨부파일번호
    fl_ms_work_no NUMBER NULL,              -- 결함조치첨부파일번호
    test_no NUMBER NULL,                    -- 테스트번호
    test_dtl_no NUMBER NULL,                -- 테스트상세번호
    mem_fd_no NUMBER NOT NULL,              -- 결함발견자번호
    mem_work_no NUMBER NULL,                -- 결함조치자번호
    work_no NUMBER NULL,                    -- 업무번호
    prj_no NUMBER NOT NULL
);

CREATE TABLE FeatureTest (
    feat_no number NOT NULL,
    test_dtl_no number NOT NULL
);

CREATE TABLE Risk (
    risk_no number NOT NULL,
    risk_id VARCHAR2(20) NOT NULL,
    rsk_ttl VARCHAR2(100) NOT NULL,
    type_cd CHAR(8) NOT NULL,
    class_cd CHAR(8) NOT NULL,
    stat_cd CHAR(8) NOT NULL,
    pri_cd CHAR(8) NOT NULL,
    risk_cont VARCHAR2(1000) NOT NULL,
    risk_plan VARCHAR2(1000) NULL,
    regist_dt DATE NULL,
    due_dt DATE NULL,
    compl_dt DATE NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NULL,
    mem_no NUMBER NOT NULL,
    fl_ms_act_no NUMBER NULL,
    fl_ms_fd_no number NULL
);

CREATE TABLE History (
    history_no number NOT NULL,
    record_dt DATE NULL,
    record_cont VARCHAR(500) NOT NULL,
    risk_no NUMBER NULL,
    mem_no NUMBER NOT NULL,
    fl_ms_no NUMBER
);

CREATE TABLE Request (
    req_no number NOT NULL,
    req_nm VARCHAR2(50) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NOT NULL,
    accept_plan VARCHAR(500) NOT NULL,
    stat_cd CHAR(8) NOT NULL,
    category_cd CHAR(8) NOT NULL,
    accept VARCHAR(1) NOT NULL
);

CREATE TABLE RequestFeature (
    feat_no NUMBER NOT NULL,
    req_no NUMBER NOT NULL
);

CREATE TABLE RequestTest (
    req_no NUMBER NOT NULL,
    test_dtl_no NUMBER NOT NULL
);

----------------------------------------------------------------------------------------------------------------------
-- SEQUENCE
CREATE SEQUENCE seq_project START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_system START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_feature START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_testdetail START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_testmaster START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_defect START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_team START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_member START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_usergroup START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_output START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_task START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_filemaster START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_filedetail START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_request START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_risk START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_history START WITH 1 INCREMENT BY 1;

----------------------------------------------------------------------------------------------------------------------
-- ALTER TABLE
ALTER TABLE CommonCode ADD CONSTRAINT PK_COMMONCODE PRIMARY KEY (common_cd_no);
ALTER TABLE CodeDetail ADD CONSTRAINT PK_CODEDETAIL PRIMARY KEY (cd_dtl_no);
ALTER TABLE CodeDetail ADD CONSTRAINT FK_CommonCode_TO_CodeDetail FOREIGN KEY (common_cd_no) REFERENCES CommonCode (common_cd_no);

ALTER TABLE UserGroup ADD CONSTRAINT PK_GROUP PRIMARY KEY (grp_no);
ALTER TABLE UserGroup ADD CONSTRAINT FK_Group_To_Group FOREIGN KEY (par_grp_no) REFERENCES UserGroup (grp_no);

ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (mem_no);
ALTER TABLE Member ADD CONSTRAINT FK_Group_To_Member FOREIGN KEY (grp_no) REFERENCES UserGroup (grp_no);

ALTER TABLE Project ADD CONSTRAINT PK_PROJECT PRIMARY KEY (prj_no);

ALTER TABLE System ADD CONSTRAINT pk_sys_no_001 PRIMARY KEY (sys_no);
ALTER TABLE System ADD CONSTRAINT fk_sys_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE System ADD CONSTRAINT fk_sys_par_sys_no_003 FOREIGN KEY (par_sys_no) REFERENCES System (sys_no);

ALTER TABLE Team ADD CONSTRAINT PK_TEAM PRIMARY KEY (tm_no);
ALTER TABLE Team ADD CONSTRAINT FK_Project_To_Team FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Team ADD CONSTRAINT FK_System_To_Team FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Team ADD CONSTRAINT FK_TEAM_TO_TEAM FOREIGN KEY (par_tm_no) REFERENCES Team (tm_no);

ALTER TABLE ProjectMember ADD CONSTRAINT PK_PROJECTMEMBER PRIMARY KEY (mem_no, tm_no, prj_no);
ALTER TABLE ProjectMember ADD CONSTRAINT FK_Member_TO_ProjectMember_1 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE ProjectMember ADD CONSTRAINT FK_Team_TO_ProjectMember_1 FOREIGN KEY (tm_no) REFERENCES Team (tm_no);
ALTER TABLE ProjectMember ADD CONSTRAINT FK_Project_TO_ProjectMember_1 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);

ALTER TABLE Task ADD CONSTRAINT pk_tsk_no_001 PRIMARY KEY (tsk_no);
ALTER TABLE Task ADD CONSTRAINT fk_tsk_sys_no_002 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Task ADD CONSTRAINT fk_tsk_prj_no_003 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);

ALTER TABLE TaskMember ADD CONSTRAINT pk_tsk_mem_no_001 PRIMARY KEY (mem_no, tm_no, tsk_no, prj_no);
ALTER TABLE TaskMember ADD CONSTRAINT fk_tsk_mem_no_002 FOREIGN KEY (mem_no, tm_no, prj_no) REFERENCES ProjectMember (mem_no, tm_no, prj_no);
ALTER TABLE TaskMember ADD CONSTRAINT fk_tsk_tsk_no_003 FOREIGN KEY (tsk_no) REFERENCES Task (tsk_no) ON DELETE CASCADE;

ALTER TABLE Feature ADD CONSTRAINT pk_feat_no_001 PRIMARY KEY (feat_no);
ALTER TABLE Feature ADD CONSTRAINT fk_feat_sys_no_002 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Feature ADD CONSTRAINT FK_ProjectMember_To_Feature FOREIGN KEY(mem_no, tm_no, prj_no) REFERENCES ProjectMember (mem_no, tm_no, prj_no);

ALTER TABLE TestMaster ADD CONSTRAINT pk_tm_tes_no_001 PRIMARY KEY (test_no);
ALTER TABLE TestMaster ADD CONSTRAINT fk_tm_prj_no_tm_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE TestMaster ADD CONSTRAINT fk_tm_sys_work_no_004 FOREIGN KEY (sys_work_no) REFERENCES System (sys_no);

ALTER TABLE TestDetail ADD CONSTRAINT pk_td_test_dtl_no_001 PRIMARY KEY (test_dtl_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_no_002 FOREIGN KEY (test_no) REFERENCES TestMaster (test_no) ON DELETE CASCADE;
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_mem_no_003 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_par_test_dtl_no_004 FOREIGN KEY (par_test_dtl_no) REFERENCES TestDetail (test_dtl_no);


ALTER TABLE FeatureTest ADD CONSTRAINT pk_ft_feat_test_no_001 PRIMARY KEY (feat_no, test_dtl_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_no_002 FOREIGN KEY (feat_no) REFERENCES Feature (feat_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_test_dtl_no_003 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);

ALTER TABLE FileMaster ADD CONSTRAINT pk_fl_ms_no_001 PRIMARY KEY (fl_ms_no);

ALTER TABLE Defect ADD CONSTRAINT pk_df_no_001 PRIMARY KEY (df_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_work_no_003 FOREIGN KEY (work_no) REFERENCES System (sys_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_test_dtl_no_004 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_fd_no_005 FOREIGN KEY (fl_ms_fd_no) REFERENCES FileMaster (fl_ms_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_work_no_006 FOREIGN KEY (fl_ms_work_no) REFERENCES FileMaster (fl_ms_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_mem_001 FOREIGN KEY (mem_fd_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_mem_002 FOREIGN KEY (mem_work_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_test_no_007 FOREIGN KEY (test_no) REFERENCES TestMaster (test_no);

ALTER TABLE FileDetail ADD CONSTRAINT pk_fl_no_001 PRIMARY KEY (fl_no);
ALTER TABLE FileDetail ADD CONSTRAINT fk_fl_ms_no_002 FOREIGN KEY (fl_ms_no) REFERENCES FileMaster (fl_ms_no) ON DELETE CASCADE;

ALTER TABLE Output ADD CONSTRAINT pk_opt_no_001 PRIMARY KEY (opt_no);
ALTER TABLE Output ADD CONSTRAINT fk_opt_high_folder_no_002 FOREIGN KEY (high_folder_no) REFERENCES Output (opt_no);
ALTER TABLE Output ADD CONSTRAINT fk_opt_prj_no_003 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Output ADD CONSTRAINT fk_opt_fl_ms_no_004 FOREIGN KEY (fl_ms_no) REFERENCES FileMaster (fl_ms_no);

ALTER TABLE Risk ADD CONSTRAINT pk_risk_no_001 PRIMARY KEY (risk_no);
ALTER TABLE Risk ADD CONSTRAINT fk_risk_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Risk ADD CONSTRAINT fk_risk_sys_no_003 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Risk ADD CONSTRAINT fk_risk_mem_no_004 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE Risk ADD CONSTRAINT fk_risk_fl_ms_act_no_005 FOREIGN KEY (fl_ms_act_no) REFERENCES FileMaster (fl_ms_no);
ALTER TABLE Risk ADD CONSTRAINT fk_risk_fl_ms_fd_no_006 FOREIGN KEY (fl_ms_fd_no) REFERENCES FileMaster (fl_ms_no);

ALTER TABLE History ADD CONSTRAINT pk_history_no_001 PRIMARY KEY (history_no);
ALTER TABLE History ADD CONSTRAINT fk_history_risk_no_002 FOREIGN KEY (risk_no) REFERENCES Risk (risk_no);
ALTER TABLE History ADD CONSTRAINT fk_history_mem_no_003 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE History ADD CONSTRAINT fk_history_filemaster FOREIGN KEY (fl_ms_no) REFERENCES FileMaster(fl_ms_no) ON DELETE CASCADE;

ALTER TABLE Request ADD CONSTRAINT pk_req_no_001 PRIMARY KEY (req_no);
ALTER TABLE Request ADD CONSTRAINT fk_req_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Request ADD CONSTRAINT fk_req_sys_no_003 FOREIGN KEY (sys_no) REFERENCES System (sys_no);

ALTER TABLE RequestFeature ADD CONSTRAINT pk_req_feat_no_001 PRIMARY KEY (feat_no, req_no);
ALTER TABLE RequestFeature ADD CONSTRAINT fk_req_feat_no_002 FOREIGN KEY (feat_no) REFERENCES Feature (feat_no);
ALTER TABLE RequestFeature ADD CONSTRAINT fk_req_feat_req_no_003 FOREIGN KEY (req_no) REFERENCES Request (req_no);

ALTER TABLE RequestTest ADD CONSTRAINT pk_req_test_no_001 PRIMARY KEY (req_no, test_dtl_no);
ALTER TABLE RequestTest ADD CONSTRAINT fk_req_test_no_002 FOREIGN KEY (req_no) REFERENCES Request (req_no);
ALTER TABLE RequestTest ADD CONSTRAINT fk_req_test_test_dtl_no_003 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);

ALTER TABLE TaskOutput ADD CONSTRAINT pk_tsk_out_no_001 PRIMARY KEY (task_no, folder_no);
ALTER TABLE TaskOutput ADD CONSTRAINT fk_tsk_out_task_no_002 FOREIGN KEY (task_no) REFERENCES Task (tsk_no);
ALTER TABLE TaskOutput ADD CONSTRAINT fk_tsk_out_folder_no_003 FOREIGN KEY (folder_no) REFERENCES Output (opt_no);


ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_2 FOREIGN KEY(
                                                                  stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_3 FOREIGN KEY(
                                                                  pri_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_4 FOREIGN KEY(
                                                                type_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Risk ADD CONSTRAINT FK_Code_To_Risk_1 FOREIGN KEY(
                                                              type_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Risk ADD CONSTRAINT FK_Code_To_Risk_2 FOREIGN KEY(
                                                              class_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Risk ADD CONSTRAINT FK_Code_To_Risk_3 FOREIGN KEY(
                                                              stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Risk ADD CONSTRAINT FK_Code_To_Risk_4 FOREIGN KEY(
                                                              pri_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Member ADD CONSTRAINT FK_Code_To_Member_1 FOREIGN KEY(
                                                                  tech_grd_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Member ADD CONSTRAINT FK_Code_To_Member_2 FOREIGN KEY(
                                                                  auth_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE ProjectMember ADD CONSTRAINT FK_Code_To_ProjectMember_1 FOREIGN KEY(
                                                                                prj_auth_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Project ADD CONSTRAINT FK_Code_To_Project_1 FOREIGN KEY(
                                                                    stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Task ADD CONSTRAINT FK_Code_To_Task_1 FOREIGN KEY(
                                                              tsk_stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE FileMaster ADD CONSTRAINT FK_Code_To_FileMaster_1 FOREIGN KEY(
                                                                          fl_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Feature ADD CONSTRAINT FK_Code_To_Feature_1 FOREIGN KEY(
                                                                    stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Feature ADD CONSTRAINT FK_Code_To_Feature_2 FOREIGN KEY(
                                                                    pri_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Feature ADD CONSTRAINT FK_Code_To_Feature_3 FOREIGN KEY(
                                                                    diff_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Feature ADD CONSTRAINT FK_Code_To_Feature_4 FOREIGN KEY(
                                                                    class_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Request ADD CONSTRAINT FK_Code_To_Request_1 FOREIGN KEY(
                                                                    stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Request ADD CONSTRAINT FK_Code_To_Request_2 FOREIGN KEY(
                                                                    category_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE TestMaster ADD CONSTRAINT FK_Code_To_TestMaster_1 FOREIGN KEY(
                                                                          stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE TestMaster ADD CONSTRAINT FK_Code_To_TestMaster_2 FOREIGN KEY(
                                                                          type_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE TestDetail ADD CONSTRAINT FK_Code_To_TestDetail_1 FOREIGN KEY(
                                                                          test_result_cd) REFERENCES CodeDetail (cd_dtl_no);

----------------------------------------------------------------------------------------------------------------------
-- INDEX

----------------------------------------------------------------------------------------------------------------------
-- INSERT
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '공공', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'SI', 1);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'SI 1팀', 2);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'SI 2팀', 2);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '금융', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '보안 솔루션 개발 1팀', 5);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '핀테크', 5);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '결제 시스템 개발', 7);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '모바일 뱅킹 지원', 7);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'RDD', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'AI 개발팀', 10);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '인공지능 모델 개발', 11);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '자연어 처리', 11);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '데이터 분석팀', 10);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '신사업', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'IoT 개발팀', 15);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '5G 통신팀', 15);


INSERT INTO CommonCode VALUES ('PMS017', '직위코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS001', '프로젝트상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS002', '프로젝트권환코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS003', '이슈위험구분코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS004', '이슈위험상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS005', '이슈위험분류코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS006', '우선순위코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS007', '결함상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS008', '결함구분코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS009', '기능상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS010', '기능구분코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS011', '기능난이도', 'Y');
INSERT INTO CommonCode VALUES ('PMS012', '테스트구분코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS013', '테스트상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS014', '테스트결과상태코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS015', '기술등급코드', 'Y');
INSERT INTO CommonCode VALUES ('PMS016', '첨부출처코드', 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00101', 'PMS001', '대기', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00102', 'PMS001', '진행중', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00103', 'PMS001', '완료', 3, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00201', 'PMS002', 'PM', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00202', 'PMS002', 'PL', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00203', 'PMS002', '팀원', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00204', 'PMS002', '사업관리자', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00205', 'PMS002', '고객', 5, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00301', 'PMS003', '위험', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00302', 'PMS003', '이슈', 2, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn, FIELD_2) VALUES ('PMS00401', 'PMS004', '발생전', 1, 'Y', 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn, FIELD_2, FIELD_3) VALUES ('PMS00402', 'PMS004', '진행중', 2, 'Y', 'Y', 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn, FIELD_2, FIELD_3) VALUES ('PMS00403', 'PMS004', '조치완료', 3, 'Y', 'Y', 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn, FIELD_2, FIELD_3) VALUES ('PMS00404', 'PMS004', '취소', 4, 'Y', 'Y', 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00501', 'PMS005', '고객변심', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00502', 'PMS005', '일정지연', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00503', 'PMS005', '품질문제', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00504', 'PMS005', '인력관련', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00505', 'PMS005', '규정관련', 5, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00601', 'PMS006', '즉시', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00602', 'PMS006', '긴급', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00603', 'PMS006', '높음', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00604', 'PMS006', '보통', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00605', 'PMS006', '낮음', 5, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00701', 'PMS007', '신규', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00702', 'PMS007', '진행중', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00703', 'PMS007', '해결', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00704', 'PMS007', '취소', 4, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00801', 'PMS008', '테스트결함', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00802', 'PMS008', '일반결함', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00803', 'PMS008', '사용자 결함', 3, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00901', 'PMS009', '신규', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00902', 'PMS009', '개발중', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00903', 'PMS009', '개발완료', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00904', 'PMS009', '단위테스트완료', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00905', 'PMS009', 'PL확인', 5, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00906', 'PMS009', '고객확인', 6, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01005', 'PMS010', '일반', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01001', 'PMS010', '화면', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01002', 'PMS010', '인터페이스', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01003', 'PMS010', '프로그램', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01004', 'PMS010', '보고서', 5, 'Y');


INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01101', 'PMS011', '매우높음', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01102', 'PMS011', '높음', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01103', 'PMS011', '보통', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01104', 'PMS011', '낮음', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01105', 'PMS011', '매우낮음', 5, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01201', 'PMS012', '단위', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01202', 'PMS012', '통합', 2, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01301', 'PMS013', '진행전', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01302', 'PMS013', '진행중', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01303', 'PMS013', '결함발생', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01304', 'PMS013', '진행완료', 4, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01401', 'PMS014', '통과', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01402', 'PMS014', '실패', 2, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01501', 'PMS015', '특급', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01502', 'PMS015', '고급', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01503', 'PMS015', '중급', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01504', 'PMS015', '초급', 4, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01601', 'PMS016', '발견첨부', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01602', 'PMS016', '조치첨부', 2, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01701', 'PMS017', '부장', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01702', 'PMS017', '차장', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01703', 'PMS017', '과장', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01704', 'PMS017', '대리', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01705', 'PMS017', '주임', 5, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01706', 'PMS017', '사원', 6, 'Y');


INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '철도 운영시스템 구축', '공공 프로젝트', 'PMS00102', 30, '경찰청', '2024-10-01', '2024-10-30', '2024-10-01', '2024-10-30', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '차세대 금융 프로젝트', '금융 프로젝트', 'PMS00102', 10, '새마을금고중앙회', '2024-09-30', '2024-11-30', '2024-09-30', '2024-11-30', 'Y', 'user1', '2024-09-30', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '철도 관리 시스템 유지보수', '철도관리 프로젝트', 'PMS00101', 0, '한국철도공사', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-05', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '국방 프로젝트', '국방 프로젝트', 'PMS00101', 0, '공군 본부', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-05', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '기상청 프로젝트', '기상청 프로젝트', 'PMS00103', 0, '기상청', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-05', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, 'ERP 시스템 프로젝트', 'ERP 프로젝트', 'PMS00103', 100, 'LH공사', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, 'CRM 시스템 프로젝트', 'CRM 프로젝트', 'PMS00103', 100, '서울교통공사', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '전자결제 시스템', '전자결제 시스템', 'PMS00103', 100, '한국산업인력공단', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '국방부 시스템 유지보수', '국방부 시스템 유지보수', 'PMS00103', 100, '국방부', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '코레일 시스템', '코레일 시스템', 'PMS00103', 100, '코레일', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '티머니 시스템', '티머니 시스템', 'PMS00103', 100, '티머니', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '법무부 시스템', '법무부 시스템', 'PMS00103', 100, '대법원', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '차량관리 시스템', '차량관리 시스템', 'PMS00103', 100, 'KCC오토', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '인사관리 시스템', '인사관리 시스템', 'PMS00103', 100, '교직원공제회', '2024-10-01', '2024-10-01', '2024-10-01', '2024-10-01', 'Y', 'user1', '2024-10-01', '2024-10-01');


INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user1', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이철수', '010-1234-5678', 'hong@kcc.co.kr', 'PMS01501', 'PMS01706', '1990-01-01', 'PMS01503', '공공', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user2', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김철수', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user3', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '박철수', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user4', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '강재석', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user5', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김상중', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user6', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김연호', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user7', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이수호', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user8', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이한희', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user9', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '황철순', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user10', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '유재석', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user11', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '강호동', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user12', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이경규', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user13', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '신동엽', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'pm1', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '홍길동', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'pm2', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김길동', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'pm3', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이길동', '010-9876-5432', 'kim@kcc.co.kr', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '철도 운영시스템 구축', '테스트 내용', 'Y', 1, NULL, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '철도 운영 시스템', '테스트 내용', 'Y', 1, NULL, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '운행 관리', '테스트 내용', 'Y', 1, 1, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '스케줄 관리', '테스트 내용', 'Y', 1, 2, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '운행 모니터링', '테스트 내용', 'Y', 2, 2, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '통신 관리', '테스트 내용', 'Y', 3, 2, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '승객 서비스', '테스트 내용', 'Y', 2, 1, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '예매/발권', '테스트 내용', 'Y', 1, 6, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '고객 지원', '테스트 내용', 'Y', 2, 6, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '시설 관리', '테스트 내용', 'Y', 3, 1, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '역무/선로 관리', '테스트 내용', 'Y', 1, 9, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '안전 점검', '테스트 내용', 'Y', 2, 9, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '물류/화물 관리', '테스트 내용', 'Y', 4, 1, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '화물 예약/배차', '테스트 내용', 'Y', 1, 12, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '화물 추적/보안', '테스트 내용', 'Y', 2, 12, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '데이터 분석', '테스트 내용', 'Y', 5, 1, 1, NULL, 'user1', '2021-01-01', NULL, NULL);
INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '운행 데이터 분석', '테스트 내용', 'Y', 1, 15, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 1, 'PMS00202', '2024-10-25', '2025-02-01', '2024-10-25', NULL, 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (2, 1, 1, 'PMS00203', '2024-10-25', '2025-02-01', '2024-10-25', NULL, 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (3, 1, 1, 'PMS00202', '2024-10-25', '2025-02-01', '2024-10-25', NULL, 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 1, 'PMS00201', '2024-10-25', '2025-02-01', '2024-10-25', NULL, 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '열차 운행 관리 시스템', '시스템1 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '승객 정보 관리 시스템', '시스템2 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 시설 관리 시스템', '시스템3 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '물류 및 화물관리시스템', '시스템4 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 데이터 분석 시스템', '시스템4 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '사업관리', '사업관리', 'Y', 1, NULL, 'Y');

-- 업무 seq = 5
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '열차 스케줄 관리', '시스템1 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '실시간 위치 추적', '시스템2 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '운행 로그 기록', '시스템3 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '차량 간 통신 관리', '시스템4 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '승객 예매 관리', '시스템5 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '승차권 발급 및 검표', '시스템6 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '승객 정보 보안 관리', '시스템7 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '고객 서비스 지원', '시스템8 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '역무 시설 관리', '시스템9 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '선로 유지 보수', '시스템9 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '시설 안전 점검', '시스템9 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '신호 시스템 관리', '시스템9 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '화물 예약 및 배차 관리', '시스템9 내용', 'Y', 1, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '화물 추적 및 위치 관리', '시스템9 내용', 'Y', 1, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '화물 보험 및 보안 관리', '시스템9 내용', 'Y', 1, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '화물 운송 경로 최적화', '시스템9 내용', 'Y', 1, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '운행 데이터 수집 및 분석', '시스템9 내용', 'Y', 1, 5, 'Y');

INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 운행 관리 시스템', '시스템1 내용', 'Y', 2, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 안전 관리 시스템', '시스템2 내용', 'Y', 2, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 예약 관리 시스템', '시스템3 내용', 'Y', 2, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 차량 관리 시스템', '시스템4 내용', 'Y', 2, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '철도 기타 시스템', '시스템4 내용', 'Y', 2, NULL, 'Y');
-- 업무 seq = 5
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '열차운행계획', '시스템1 내용', 'Y', 2, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '운행실적관리', '시스템1 내용', 'Y', 2, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '일정관리', '시스템1 내용', 'Y', 2, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '근무관리', '시스템2 내용', 'Y', 2, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '운영관리', '시스템3 내용', 'Y', 2, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '위험관리', '시스템2 내용', 'Y', 2, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '품질관리', '시스템2 내용', 'Y', 2, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '안전점검', '시스템2 내용', 'Y', 2, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '교육훈련', '시스템2 내용', 'Y', 2, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '사고분석', '시스템2 내용', 'Y', 2, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '좌석관리', '시스템3 내용', 'Y', 2, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '예매관리', '시스템3 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '결제관리', '시스템3 내용', 'Y', 2, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '고객서비스', '시스템3 내용', 'Y', 2, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '할인 및 프로모션 관리', '시스템3 내용', 'Y', 2, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '차량정비', '시스템4 내용', 'Y', 2, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '차량배치', '시스템4 내용', 'Y', 2, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '차량상태모니터링', '시스템4 내용', 'Y', 2, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '부품관리', '시스템4 내용', 'Y', 2, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '차량검수', '시스템4 내용', 'Y', 2, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '통신관리', '시스템5 내용', 'Y', 2, 5, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '인적자원관리', '시스템5 내용', 'Y', 2, 5, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '조달관리', '시스템5 내용', 'Y', 2, 5, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '통합관리', '시스템5 내용', 'Y', 2, 5, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '환경관리', '시스템5 내용', 'Y', 2, 5, 'Y');


insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt,end_dt, par_task_no, reg_id, reg_dt, sys_no)
values (seq_task.nextval, 1, '요구사항 수집 및 분석', 'PMS00103', '24/10/01', '24/10/02', 100, 'Y', 1,
        '24/10/01', '24/10/02',
        0, 'pm1', '24/10/01', 5);

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no,st_dt, end_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '아키텍처 설계', 'PMS00103', '24/10/02', '24/10/03', 100, 'Y', 1,
        '24/10/02', '24/10/03',
        0, 'pm1', '24/10/02');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt,end_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '데이터베이스 설계', 'PMS00103', '24/10/03', '24/10/04', 100, 'Y', 1,
        '24/10/03', '24/10/04',
        0, 'pm1', '24/10/03');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt,end_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, 'API 설계', 'PMS00103', '24/10/04', '24/10/05', 100, 'Y', 1,
        '24/10/04', '24/10/05',
        0, 'pm1', '24/10/06');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no,st_dt, end_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, 'UI/UX 설계', 'PMS00103', '24/10/04', '24/10/05', 100, 'Y', 1,
        '24/10/04', '24/10/05',
        0, 'pm1', '24/10/09');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt, sys_no)
values (seq_task.nextval, 1, '프론트엔드 개발', 'PMS00102', '24/10/05', '24/10/12', 70, 'Y', 1,
        '24/10/05',
        0, 'pm1', '24/10/05', 6);

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt, sys_no)
values (seq_task.nextval, 1, '백엔드 개발', 'PMS00102', '24/10/05', '24/10/12', 60, 'Y', 1,
        '24/10/05',
        0, 'pm1', '24/10/05', 6);

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '화면 구성', 'PMS00102', '24/10/05', '24/10/10', 70, 'Y', 1,
        '24/10/05',
        6, 'pm1', '24/10/15');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '메인 화면 구성', 'PMS00102', '24/10/05', '24/10/09', 70, 'Y', 1,
        '24/10/05',
        8, 'pm1', '24/10/04');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '시스템 연동', 'PMS00102', '24/10/05', '24/10/10', 60, 'Y', 1,
        '24/10/05',
        7, 'pm1', '24/10/05');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, st_dt, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '외부 시스템 연동', 'PMS00102', '24/10/05', '24/10/09', 60, 'Y', 1,
        '24/10/05',
        10, 'pm1', '24/10/05');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '단위 테스트', 'PMS00101', '24/10/12', '24/10/14', 0, 'Y', 1,
        0, 'pm1', '24/10/12');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '통합 테스트', 'PMS00101', '24/10/13', '24/10/15', 0, 'Y', 1,
        0, 'pm1', '24/10/13');

insert into task
(tsk_no, order_no, tsk_ttl, tsk_stat_cd, pre_st_dt, pre_end_dt, prg, use_yn, prj_no, par_task_no, reg_id, reg_dt)
values (seq_task.nextval, 1, '성능 테스트', 'PMS00101', '24/10/13', '24/10/15', 0, 'Y', 1,
        0, 'pm1', '24/10/13');


insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (14, 1, 1, 1);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (14, 1, 1, 2);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (14, 1, 1, 3);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (14, 1, 1, 4);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (14, 1, 1, 5);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (1, 1, 1, 6);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (2, 1, 1, 6);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (1, 1, 1, 7);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (2, 1, 1, 7);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (1, 1, 1, 8);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (2, 1, 1, 9);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (1, 1, 1, 10);

insert into taskmember
(mem_no, tm_no, prj_no, tsk_no)
values (2, 1, 1, 11);

INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no, class_cd)
VALUES (seq_feature.nextval, 'F001', 'RSTR110', '기능1 내용', '2024-10-25', '2024-10-31', '2024-10-25', '2024-10-29', 'PMS00906', 'PMS00603', 100, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no, class_cd)
VALUES (seq_feature.nextval, 'F002', 'RSTR111', '기능2 내용', '2024-10-25', '2024-10-31', '2024-10-25', '2024-11-01', 'PMS00906', 'PMS00603', 100, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no, class_cd)
VALUES (seq_feature.nextval, 'F003', 'RSTR123', '기능3 내용', '2024-11-01', '2024-11-10', '2024-11-02', null, 'PMS00902', 'PMS00603', 10, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');

-- 테스트 데이터 INSERT 문 시작

-- 테스트 1
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_001', '열차 시간표 조회 및 검증 테스트', '열차 시간표를 조회하고 검증하는 테스트', 'PMS01301',
           'PMS01201', 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 2
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_002', '열차 좌석 예약 및 확인 테스트', '열차 좌석을 예약하고 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2023-02-12', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 3
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_003', '열차 예약 내역 확인 및 상세 정보 조회 테스트', '예약된 열차 티켓의 상세 정보를 확인하는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-03-05', 'YYYY-MM-DD'), TO_DATE('2023-03-06', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 4
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_004', '예약된 열차 티켓 취소 및 환불 처리 테스트', '예약된 티켓을 취소하고 환불을 처리하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-04-20', 'YYYY-MM-DD'), TO_DATE('2023-04-21', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 5
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_005', '열차 탑승권 출력 및 모바일 티켓 발급 테스트', '탑승권을 출력하고 모바일 티켓을 발급하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-16', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 6
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_006', '열차 서비스 신규 회원가입 및 이메일 인증 테스트', '신규 회원가입을 하고 이메일 인증을 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-06-11', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 7
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_007', '회원 로그인 및 세션 유지 기능 테스트', '로그인 후 세션이 유지되는지 확인하는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-07-05', 'YYYY-MM-DD'), TO_DATE('2023-07-06', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 8
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_008', '비밀번호 찾기 및 재설정 이메일 발송 테스트', '비밀번호를 찾고 재설정 이메일을 발송하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-08-20', 'YYYY-MM-DD'), TO_DATE('2023-08-21', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 9
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_009', '회원 정보 수정 및 프로필 사진 업데이트 테스트', '회원 정보를 수정하고 프로필 사진을 변경하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-16', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 10
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_010', '회원 탈퇴 및 데이터 삭제 처리 테스트', '회원 탈퇴를 진행하고 데이터가 삭제되는지 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-11', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 11
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_011', '열차 공지사항 조회 및 상세 내용 확인 테스트', '공지사항을 조회하고 상세 내용을 확인하는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-11-05', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 12
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_012', '이벤트 참여 및 포인트 적립 기능 테스트', '이벤트에 참여하고 포인트가 적립되는지 확인하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_DATE('2023-12-21', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 13
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_013', '포인트 적립 및 사용 내역 조회 테스트', '포인트를 적립하고 사용 내역을 조회하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-01-25', 'YYYY-MM-DD'), TO_DATE('2023-01-26', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 14
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_014', '포인트 사용 및 결제 금액 차감 테스트', '포인트를 사용하여 결제 금액이 차감되는지 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-02-15', 'YYYY-MM-DD'), TO_DATE('2023-02-16', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 15
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_015', '실시간 열차 위치 조회 및 지연 정보 알림 테스트', '실시간으로 열차 위치를 조회하고 지연 정보를 받는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-03-11', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 16
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_016', '예약된 좌석 변경 및 추가 요금 결제 테스트', '예약된 좌석을 변경하고 추가 요금을 결제하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-04-05', 'YYYY-MM-DD'), TO_DATE('2023-04-06', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 17
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_017', '티켓 결제 처리 및 영수증 발급 테스트', '티켓 결제를 처리하고 영수증을 발급하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-05-20', 'YYYY-MM-DD'), TO_DATE('2023-05-21', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 18
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_018', '티켓 환불 요청 및 처리 상태 확인 테스트', '티켓 환불을 요청하고 처리 상태를 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 19
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_019', '관리자 공지사항 등록 및 사용자 알림 테스트', '관리자로 로그인하여 공지사항을 등록하고 사용자에게 알림이 가는지 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-07-10', 'YYYY-MM-DD'), TO_DATE('2023-07-11', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 20
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_020', '고객센터 문의 등록 및 답변 확인 테스트', '고객센터에 문의를 등록하고 답변을 확인하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-06', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 21
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_021', '열차 노선도 조회 및 역별 정보 확인 테스트', '열차 노선도를 조회하고 각 역의 정보를 확인하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-09-20', 'YYYY-MM-DD'), TO_DATE('2023-09-21', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 22
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_022', '역 정보 조회 및 주변 시설 검색 테스트', '역 정보를 조회하고 주변 시설을 검색하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-10-16', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 23
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_023', '열차 연착 알림 설정 및 푸시 알림 테스트', '열차 연착 알림을 설정하고 푸시 알림을 받는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-11-10', 'YYYY-MM-DD'), TO_DATE('2023-11-11', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 24
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_024', '승차권 검증 및 QR 코드 스캔 테스트', '승차권을 검증하고 QR 코드를 스캔하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-12-05', 'YYYY-MM-DD'), TO_DATE('2023-12-06', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 25
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_025', '단체 티켓 예약 및 좌석 배치 확인 테스트', '단체 티켓을 예약하고 좌석 배치를 확인하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-16', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 26
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_026', '분실물 신고 접수 및 처리 상태 확인 테스트', '분실물을 신고하고 처리 상태를 확인하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2023-02-11', 'YYYY-MM-DD'), 5, 'user1', SYSDATE, 'Y'
       );

-- 테스트 27
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_027', '분실물 조회 및 습득물 목록 확인 테스트', '분실물을 조회하고 습득물 목록을 확인하는 테스트', 'PMS01303',
           'PMS01202', 1, TO_DATE('2023-03-05', 'YYYY-MM-DD'), TO_DATE('2023-03-06', 'YYYY-MM-DD'), 6, 'user1', SYSDATE, 'Y'
       );

-- 테스트 28
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_028', '여행 패키지 예약 및 일정 확인 테스트', '여행 패키지를 예약하고 일정을 확인하는 테스트', 'PMS01304',
           'PMS01201', 1, TO_DATE('2023-04-20', 'YYYY-MM-DD'), TO_DATE('2023-04-21', 'YYYY-MM-DD'), 7, 'user1', SYSDATE, 'Y'
       );

-- 테스트 29
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_029', '특가 할인 정보 조회 및 적용 테스트', '특가 할인 정보를 조회하고 적용하는 테스트', 'PMS01301',
           'PMS01202', 1, TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-16', 'YYYY-MM-DD'), 8, 'user1', SYSDATE, 'Y'
       );

-- 테스트 30
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 'T_01_TRN_030', '고객센터 문의 등록 및 실시간 채팅 지원 테스트', '고객센터에 문의를 등록하고 실시간 채팅을 이용하는 테스트', 'PMS01302',
           'PMS01201', 1, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-06-11', 'YYYY-MM-DD'), 9, 'user1', SYSDATE, 'Y'
       );

-- 테스트 데이터 INSERT 문 끝

INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, mem_no, par_test_dtl_no, test_no, created_dt)
VALUES (seq_testdetail.nextval, 'TD001', '테스트상세1', '테스트상세1 내용', '테스트상세1 예상결과', '테스트상세1 내용', '2021-01-01', 'PMS01401', '테스트상세1 진행내용', '테스트상세1 사전조건', 1, NULL, 1, sysdate);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, mem_no, par_test_dtl_no, test_no, created_dt)
VALUES (seq_testdetail.nextval, 'TD002', '테스트상세2', '테스트상세2 내용', '테스트상세2 예상결과', '테스트상세2 내용', '2021-01-01', 'PMS01401', '테스트상세2 진행내용', '테스트상세2 사전조건', 1, NULL, 1, sysdate);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, mem_no, par_test_dtl_no, test_no, created_dt)
VALUES (seq_testdetail.nextval, 'TD003', '테스트상세3', '테스트상세3 내용', '테스트상세3 예상결과', '테스트상세3 내용', '2021-01-01', 'PMS01401', '테스트상세3 진행내용', '테스트상세3 사전조건', 1, NULL, 3, sysdate);

INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (1, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (2, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (3, 1);

update codedetail set field_2 = 'Y' where common_cd_no = 'PMS004';
update codedetail set field_3 = 'Y' where common_cd_no = 'PMS004' and cd_dtl_no IN ('PMS00402', 'PMS00403', 'PMS00404');

INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0001', '승무원 로그인 시스템 인증 오류 발생', 'PMS00701', 'PMS00601', '사용자가 로그인할 수 없습니다.', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0002', '열차 운행 데이터 저장 실패로 인한 시스템 오류', 'PMS00702', 'PMS00602', '새로운 데이터를 저장할 때 오류 발생.', TO_DATE('2024-10-02', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0003', '승객 정보 조회 시 화면 로딩 지연 현상 발생', 'PMS00703', 'PMS00603', '메인 화면 로딩 시간이 오래 걸립니다.', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0004', '열차 운행 일정 그래프 표시 오류 발생', 'PMS00704', 'PMS00604', '통계 그래프가 올바르게 표시되지 않습니다.', TO_DATE('2024-10-04', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0005', '차량 정비 기록 파일 업로드 실패 문제 발생', 'PMS00701', 'PMS00605', '파일 업로드 시 에러 메시지 발생.', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0006', '승객 예약 확인 메일 전송 오류 발생', 'PMS00702', 'PMS00601', '인증 메일이 전송되지 않습니다.', TO_DATE('2024-10-06', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0007', '기관사 시스템 접근 권한 설정 문제 발생', 'PMS00703', 'PMS00602', '관리자 권한이 부여되지 않습니다.', TO_DATE('2024-10-07', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0008', '시간표 관리 페이지 이동 오류 발생', 'PMS00704', 'PMS00603', '특정 페이지로 이동할 수 없습니다.', TO_DATE('2024-10-08', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0009', '열차 지연 알림 기능 미작동 현상 발생', 'PMS00701', 'PMS00604', '새로운 알림이 표시되지 않습니다.', TO_DATE('2024-10-09', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0010', '역 검색 기능 오류로 인한 사용자 불편 발생', 'PMS00702', 'PMS00605', '검색 결과가 표시되지 않습니다.', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0011', '예약 시스템 세션 만료 시간 조정 필요', 'PMS00703', 'PMS00601', '세션이 예상보다 빨리 만료됩니다.', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0012', '모바일 앱에서 승차권 UI 깨짐 현상 발생', 'PMS00704', 'PMS00602', '브라우저 호환성 문제로 UI가 깨집니다.', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0013', '국제 승객을 위한 다국어 지원 오류 발생', 'PMS00701', 'PMS00603', '일부 텍스트가 번역되지 않습니다.', TO_DATE('2024-10-13', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0014', '중앙 서버와 역 단말기 간 데이터 동기화 문제 발생', 'PMS00702', 'PMS00604', '데이터 동기화가 제대로 이루어지지 않습니다.', TO_DATE('2024-10-14', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0015', '원격 유지보수 시스템 접속 불가 현상 발생', 'PMS00703', 'PMS00605', '일부 사용자가 접속할 수 없습니다.', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0016', '예약 변경 후 캐시로 인해 이전 정보 표시 문제', 'PMS00704', 'PMS00601', '업데이트 후에도 이전 내용이 표시됩니다.', TO_DATE('2024-10-16', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0017', '운영자 계정 로그아웃 불가 현상 발생', 'PMS00701', 'PMS00602', '사용자가 로그아웃할 수 없습니다.', TO_DATE('2024-10-17', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0018', '열차 노선도 이미지 로딩 실패 문제 발생', 'PMS00702', 'PMS00603', '이미지가 로딩되지 않습니다.', TO_DATE('2024-10-18', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0019', '실시간 위치 추적 API 호출 오류 발생', 'PMS00703', 'PMS00604', '외부 API 호출 시 오류 발생.', TO_DATE('2024-10-19', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0020', '승객 정보 시스템에서 보안 취약점 발견', 'PMS00704', 'PMS00605', 'SQL 인젝션 취약점 발견.', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0021', '역사 이벤트 로그 데이터 삭제 불가 문제', 'PMS00701', 'PMS00601', '데이터를 삭제할 수 없습니다.', TO_DATE('2024-10-21', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0022', '승객 모바일 앱 푸시 알림 오류 발생', 'PMS00702', 'PMS00602', '푸시 알림이 수신되지 않습니다.', TO_DATE('2024-10-22', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0023', '승무원 프로필 정보 업데이트 문제 발생', 'PMS00703', 'PMS00603', '프로필 정보 수정 시 오류 발생.', TO_DATE('2024-10-23', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0024', '열차 운행 로그 파일 생성 안됨 현상 발생', 'PMS00704', 'PMS00604', '서버 로그 파일이 생성되지 않습니다.', TO_DATE('2024-10-24', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0025', '국제선 운행 시간대 설정 오류로 인한 혼란 발생', 'PMS00701', 'PMS00605', '시간대 변경이 적용되지 않습니다.', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0026', '예약 입력 시 자동 저장 기능 작동 안함 문제', 'PMS00702', 'PMS00601', '자동 저장이 작동하지 않습니다.', TO_DATE('2024-10-26', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0027', '열차 운행 관리 시스템 메모리 누수 현상 발생', 'PMS00703', 'PMS00602', '장시간 사용 시 메모리 사용량 증가.', TO_DATE('2024-10-27', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0028', '승무원이 접근하지 못하는 페이지 권한 오류 발생', 'PMS00704', 'PMS00603', '비인가 사용자가 페이지에 접근 가능합니다.', TO_DATE('2024-10-28', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0029', '열차 번호 입력 시 특수문자 입력 불가 문제', 'PMS00701', 'PMS00604', '특정 필드에 입력이 불가능합니다.', TO_DATE('2024-10-29', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'TRN-0030', '승무원 계정 비밀번호 변경 시 오류 발생', 'PMS00702', 'PMS00605', '비밀번호 변경 시 오류 발생.', TO_DATE('2024-10-30', 'YYYY-MM-DD'), 1, 1, 'PMS00803');

-- 완료된 기능들 (8월~9월에 등록, 고객 확인 상태)
INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'TRN001', '고속열차 운행 스케줄 관리 시스템 개발', '고속열차 운행 스케줄을 효율적으로 관리하는 시스템을 개발합니다.', TO_DATE('24/08/01', 'YY/MM/DD'), TO_DATE('24/08/15', 'YY/MM/DD'), TO_DATE('24/08/02', 'YY/MM/DD'), TO_DATE('24/08/14', 'YY/MM/DD'), 'PMS00906', 'PMS00603', 100, 'PMS01103', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN002', '승객 예약 시스템 개선', '온라인 승객 예약 시스템의 기능 개선 및 안정화를 진행합니다.', TO_DATE('24/08/05', 'YY/MM/DD'), TO_DATE('24/08/20', 'YY/MM/DD'), TO_DATE('24/08/06', 'YY/MM/DD'), TO_DATE('24/08/19', 'YY/MM/DD'), 'PMS00906', 'PMS00602', 100, 'PMS01102', 'PMS01002', 'Y', 2, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN003', '화물 운송 추적 개발', '화물 열차의 실시간 위치 추적 및 상태 모니터링 시스템을 구축합니다.', TO_DATE('24/08/10', 'YY/MM/DD'), TO_DATE('24/08/25', 'YY/MM/DD'), TO_DATE('24/08/11', 'YY/MM/DD'), TO_DATE('24/08/24', 'YY/MM/DD'), 'PMS00906', 'PMS00601', 100, 'PMS01101', 'PMS01003', 'Y', 3, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN004', '철도 안전 모니터링 구축', '철도 안전을 위한 실시간 모니터링 및 경보 시스템을 개발합니다.', TO_DATE('24/08/15', 'YY/MM/DD'), TO_DATE('24/09/01', 'YY/MM/DD'), TO_DATE('24/08/16', 'YY/MM/DD'), TO_DATE('24/08/31', 'YY/MM/DD'), 'PMS00906', 'PMS00602', 100, 'PMS01102', 'PMS01004', 'Y', 4, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN005', '역사 안내 업그레이드', '승객을 위한 역사 내 안내 디스플레이 시스템을 업그레이드합니다.', TO_DATE('24/08/20', 'YY/MM/DD'), TO_DATE('24/09/05', 'YY/MM/DD'), TO_DATE('24/08/21', 'YY/MM/DD'), TO_DATE('24/09/04', 'YY/MM/DD'), 'PMS00906', 'PMS00603', 100, 'PMS01103', 'PMS01005', 'Y', 5, 3, 1, 1);

-- PL 확인 상태 (진척도 90, 9월에 등록)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN006', '차량 정비 관리 기능 개선', '열차 차량의 정비 스케줄 및 이력 관리 시스템을 개선합니다.', TO_DATE('24/09/01', 'YY/MM/DD'), TO_DATE('24/09/15', 'YY/MM/DD'), TO_DATE('24/09/02', 'YY/MM/DD'), NULL, 'PMS00905', 'PMS00601', 90, 'PMS01102', 'PMS01001', 'Y', 1, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN007', '승강장 안전 기능 개발', '승강장 내 승객 안전을 위한 시스템을 개발합니다.', TO_DATE('24/09/05', 'YY/MM/DD'), TO_DATE('24/09/20', 'YY/MM/DD'), TO_DATE('24/09/06', 'YY/MM/DD'), NULL, 'PMS00905', 'PMS00602', 90, 'PMS01103', 'PMS01002', 'Y', 2, 3, 1, 1);

-- 단위 테스트 완료 상태 (진척도 80, 9월~10월 등록)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN008', '티켓 검표 시스템 통합', '모바일 및 종이 티켓의 검표 시스템을 통합 개발합니다.', TO_DATE('24/09/10', 'YY/MM/DD'), TO_DATE('24/09/25', 'YY/MM/DD'), TO_DATE('24/09/11', 'YY/MM/DD'), NULL, 'PMS00904', 'PMS00603', 80, 'PMS01101', 'PMS01003', 'Y', 3, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN009', '열차 내 와이파이 개선', '승객을 위한 열차 내 와이파이 서비스 품질을 향상시킵니다.', TO_DATE('24/10/01', 'YY/MM/DD'), TO_DATE('24/10/15', 'YY/MM/DD'), TO_DATE('24/10/02', 'YY/MM/DD'), NULL, 'PMS00904', 'PMS00602', 80, 'PMS01102', 'PMS01004', 'Y', 4, 2, 1, 1);

-- 개발 완료 상태 (진척도 70, 10월 등록)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN010', '열차 상태 진단 시스템 개발', '열차의 기계적 상태를 실시간으로 진단하는 시스템을 개발합니다.', TO_DATE('24/10/05', 'YY/MM/DD'), TO_DATE('24/10/20', 'YY/MM/DD'), TO_DATE('24/10/06', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00603', 70, 'PMS01103', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN011', '역사 자동화 시스템 구축', '역사 내 자동화 시스템 구축을 통해 운영 효율성을 향상시킵니다.', TO_DATE('24/10/07', 'YY/MM/DD'), TO_DATE('24/10/22', 'YY/MM/DD'), TO_DATE('24/10/08', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 70, 'PMS01101', 'PMS01002', 'Y', 2, 3, 1, 1);

-- 개발 중 상태 (진척도 10~60, 10월~11월 등록)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN012', '철도 노선 최적화 알고리즘 개발', '효율적인 운행을 위한 노선 최적화 알고리즘을 개발합니다.', TO_DATE('24/10/10', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), TO_DATE('24/10/11', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00601', 40, 'PMS01103', 'PMS01003', 'Y', 3, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN013', '승객 혼잡도 분석 시스템', '실시간 승객 혼잡도 분석을 통해 운영을 개선합니다.', TO_DATE('24/10/12', 'YY/MM/DD'), TO_DATE('24/11/01', 'YY/MM/DD'), TO_DATE('24/10/13', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 50, 'PMS01102', 'PMS01002', 'Y', 4, 2, 1, 1);

-- 신규 상태 (진척도 0, 11월에 등록)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN014', '열차 좌석 예약 최적화', '승객 만족도를 높이기 위한 좌석 예약 시스템을 최적화합니다.', TO_DATE('24/11/01', 'YY/MM/DD'), TO_DATE('24/11/15', 'YY/MM/DD'), NULL, NULL, 'PMS00901', 'PMS00601', 0, 'PMS01101', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN015', '국제 열차 운행 화면 개선', '국제 열차 운행을 위한 시스템을 구축하고 테스트합니다.', TO_DATE('24/11/02', 'YY/MM/DD'), TO_DATE('24/11/18', 'YY/MM/DD'), NULL, NULL, 'PMS00901', 'PMS00602', 0, 'PMS01102', 'PMS01002', 'Y', 2, 2, 1, 1);

-- 추가된 기능들 (10월~11월에 등록, 다양한 진행 상태)
INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN016', '열차 운행 데이터 분석 도구 개발', '운행 데이터를 분석하여 효율성을 향상시킵니다.', TO_DATE('24/10/15', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), TO_DATE('24/10/16', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00602', 50, 'PMS01101', 'PMS01002', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN017', '승객 안내 방송 품질 개선', '승객 안내 방송의 음질과 내용을 개선합니다.', TO_DATE('24/10/17', 'YY/MM/DD'), TO_DATE('24/10/31', 'YY/MM/DD'), TO_DATE('24/10/18', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00601', 70, 'PMS01102', 'PMS01001', 'Y', 2, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN018', '철도 교통 안전 교육 프로그램', '직원을 위한 안전 교육 프로그램을 개발합니다.', TO_DATE('24/10/20', 'YY/MM/DD'), TO_DATE('24/11/05', 'YY/MM/DD'), TO_DATE('24/10/21', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00603', 20, 'PMS01103', 'PMS01003', 'Y', 3, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN019', '열차 내부 청결도 향상 프로젝트', '승객 만족도를 높이기 위한 청결도 개선을 추진합니다.', TO_DATE('24/10/22', 'YY/MM/DD'), TO_DATE('24/11/10', 'YY/MM/DD'), TO_DATE('24/10/23', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00602', 40, 'PMS01101', 'PMS01004', 'Y', 4, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN020', '친환경 열차 도입 연구', '탄소 배출을 줄이기 위한 친환경 열차 도입을 연구합니다.', TO_DATE('24/10/25', 'YY/MM/DD'), TO_DATE('24/11/15', 'YY/MM/DD'), TO_DATE('24/10/26', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 10, 'PMS01102', 'PMS01005', 'Y', 5, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN021', '철도 네트워크 확장 계획 수립', '새로운 노선 추가를 위한 계획을 수립합니다.', TO_DATE('24/10/28', 'YY/MM/DD'), TO_DATE('24/11/20', 'YY/MM/DD'), TO_DATE('24/10/29', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 30, 'PMS01103', 'PMS01001', 'Y', 1, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN022', '고속열차 서비스 개선', '고속열차의 서비스 품질을 향상시킵니다.', TO_DATE('24/10/30', 'YY/MM/DD'), TO_DATE('24/11/25', 'YY/MM/DD'), TO_DATE('24/10/31', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 60, 'PMS01101', 'PMS01002', 'Y', 2, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN023', '열차 소음 저감 기술 적용', '주변 환경에 미치는 소음을 줄이기 위한 기술을 도입합니다.', TO_DATE('24/11/01', 'YY/MM/DD'), TO_DATE('24/11/30', 'YY/MM/DD'), TO_DATE('24/11/02', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 20, 'PMS01102', 'PMS01003', 'Y', 3, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN024', '승차권 자동 발매기 업그레이드', '사용자 친화적인 인터페이스로 개선합니다.', TO_DATE('24/11/03', 'YY/MM/DD'), TO_DATE('24/11/25', 'YY/MM/DD'), TO_DATE('24/11/04', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 40, 'PMS01103', 'PMS01004', 'Y', 4, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN025', '열차 운행 정보 모바일 앱 개발', '실시간 운행 정보를 제공하는 모바일 앱을 개발합니다.', TO_DATE('24/11/05', 'YY/MM/DD'), TO_DATE('24/12/05', 'YY/MM/DD'), TO_DATE('24/11/06', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 50, 'PMS01101', 'PMS01005', 'Y', 5, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN026', '역사 내 무선 인터넷 환경 개선', '승객을 위한 와이파이 속도와 안정성을 높입니다.', TO_DATE('24/11/07', 'YY/MM/DD'), TO_DATE('24/11/30', 'YY/MM/DD'), TO_DATE('24/11/08', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 15, 'PMS01102', 'PMS01001', 'Y', 1, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN027', '열차 내부 디자인 리뉴얼', '승객 편의를 위한 내부 디자인을 새롭게 합니다.', TO_DATE('24/11/09', 'YY/MM/DD'), TO_DATE('24/12/10', 'YY/MM/DD'), TO_DATE('24/11/10', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 35, 'PMS01103', 'PMS01002', 'Y', 2, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN028', '안전 운행 매뉴얼 개정', '최신 안전 기준에 맞게 운행 매뉴얼을 업데이트합니다.', TO_DATE('24/11/12', 'YY/MM/DD'), TO_DATE('24/12/01', 'YY/MM/DD'), TO_DATE('24/11/13', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 55, 'PMS01101', 'PMS01003', 'Y', 3, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN029', '승객 피드백 시스템 도입', '고객 의견을 수렴할 수 있는 채널을 마련합니다.', TO_DATE('24/11/14', 'YY/MM/DD'), TO_DATE('24/12/05', 'YY/MM/DD'), TO_DATE('24/11/15', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 25, 'PMS01102', 'PMS01004', 'Y', 4, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN030', '열차 운행 예측 모델 개발', '딥러닝을 활용한 운행 예측 모델을 개발합니다.', TO_DATE('24/11/16', 'YY/MM/DD'), TO_DATE('24/12/15', 'YY/MM/DD'), TO_DATE('24/11/17', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 45, 'PMS01103', 'PMS01005', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN031', '열차 예약 플랫폼 다국어 지원', '외국인 승객을 위한 다국어 서비스를 제공합니다.', TO_DATE('24/11/18', 'YY/MM/DD'), TO_DATE('24/12/20', 'YY/MM/DD'), TO_DATE('24/11/19', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 50, 'PMS01101', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN032', '역사 내 친환경 에너지 도입', '태양광 및 풍력 에너지 사용을 확대합니다.', TO_DATE('24/11/20', 'YY/MM/DD'), TO_DATE('24/12/25', 'YY/MM/DD'), TO_DATE('24/11/21', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 20, 'PMS01102', 'PMS01002', 'Y', 2, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN033', '열차 지연 보상 제도 개선', '승객 불편을 최소화하기 위한 보상 제도를 개선합니다.', TO_DATE('24/11/22', 'YY/MM/DD'), TO_DATE('24/12/10', 'YY/MM/DD'), TO_DATE('24/11/23', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 30, 'PMS01103', 'PMS01003', 'Y', 3, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN034', '철도 교량 안전 점검 강화', '교량의 안전 점검 주기와 범위를 확대합니다.', TO_DATE('24/11/24', 'YY/MM/DD'), TO_DATE('24/12/15', 'YY/MM/DD'), TO_DATE('24/11/25', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00602', 60, 'PMS01101', 'PMS01004', 'Y', 4, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN035', '승객 맞춤형 서비스 제공', '개인화된 서비스로 승객 만족도를 높입니다.', TO_DATE('24/11/26', 'YY/MM/DD'), TO_DATE('24/12/20', 'YY/MM/DD'), TO_DATE('24/11/27', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00601', 25, 'PMS01102', 'PMS01005', 'Y', 5, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN036', '열차 출발 알림 기능 강화', '승객의 편의를 위한 출발 알림 서비스를 개선합니다.', TO_DATE('24/11/28', 'YY/MM/DD'), TO_DATE('24/12/22', 'YY/MM/DD'), TO_DATE('24/11/29', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00603', 35, 'PMS01103', 'PMS01001', 'Y', 1, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN037', '무인 역 운영 시범 사업', '인건비 절감을 위한 무인 역 운영을 시범적으로 도입합니다.', TO_DATE('24/11/30', 'YY/MM/DD'), TO_DATE('25/01/15', 'YY/MM/DD'), TO_DATE('24/12/01', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00602', 10, 'PMS01101', 'PMS01002', 'Y', 2, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN038', '열차 내 편의 시설 확대', '승객을 위한 편의 시설을 추가 설치합니다.', TO_DATE('24/12/02', 'YY/MM/DD'), TO_DATE('25/01/10', 'YY/MM/DD'), TO_DATE('24/12/03', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00601', 20, 'PMS01102', 'PMS01003', 'Y', 3, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN039', '철도 운행 시뮬레이션 개발', '운행 최적화를 위한 시뮬레이션 도구를 개발합니다.', TO_DATE('24/12/05', 'YY/MM/DD'), TO_DATE('25/01/20', 'YY/MM/DD'), TO_DATE('24/12/06', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00603', 50, 'PMS01103', 'PMS01004', 'Y', 4, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN040', '열차 안전 센서 기술 도입', '최신 센서 기술로 안전성을 강화합니다.', TO_DATE('24/12/07', 'YY/MM/DD'), TO_DATE('25/01/25', 'YY/MM/DD'), TO_DATE('24/12/08', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00602', 15, 'PMS01101', 'PMS01005', 'Y', 5, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN041', '역사 주변 상권 활성화 계획', '지역 경제 활성화를 위한 상권 개발을 추진합니다.', TO_DATE('24/12/09', 'YY/MM/DD'), TO_DATE('25/01/30', 'YY/MM/DD'), TO_DATE('24/12/10', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00601', 25, 'PMS01102', 'PMS01001', 'Y', 1, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN042', '열차 내 식음료 서비스 개선', '고품질의 식음료 서비스를 제공하기 위한 개선을 실시합니다.', TO_DATE('24/12/12', 'YY/MM/DD'), TO_DATE('25/02/05', 'YY/MM/DD'), TO_DATE('24/12/13', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00603', 45, 'PMS01103', 'PMS01002', 'Y', 2, 3, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN043', '철도 재난 대응 체계 구축', '재난 발생 시 신속한 대응을 위한 체계를 마련합니다.', TO_DATE('24/12/14', 'YY/MM/DD'), TO_DATE('25/02/10', 'YY/MM/DD'), TO_DATE('24/12/15', 'YY/MM/DD'), NULL, 'PMS00901', 'PMS00602', 30, 'PMS01101', 'PMS01003', 'Y', 3, 1, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN044', '열차 예약 취소 정책 개선', '승객 편의를 위한 예약 취소 절차를 간소화합니다.', TO_DATE('24/12/16', 'YY/MM/DD'), TO_DATE('25/02/15', 'YY/MM/DD'), TO_DATE('24/12/17', 'YY/MM/DD'), NULL, 'PMS00902', 'PMS00601', 35, 'PMS01102', 'PMS01004', 'Y', 4, 2, 1, 1);

INSERT INTO FEATURE VALUES (seq_feature.nextval, 'TRN045', '국제 열차 운행 확대 계획', '국제 노선 확대를 위한 계획을 수립합니다.', TO_DATE('24/12/18', 'YY/MM/DD'), TO_DATE('25/02/20', 'YY/MM/DD'), TO_DATE('24/12/19', 'YY/MM/DD'), NULL, 'PMS00903', 'PMS00603', 50, 'PMS01103', 'PMS01005', 'Y', 5, 3, 1, 1);


-- output
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '차세대 시스템', 1, nULL, 'y', 'y');

-- 철도 신호 시스템 폴더 생성
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '철도 신호 시스템', 1, 1, 'y', 'y');

-- 철도 물류 관리 시스템 폴더 생성
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '철도 물류 관리 시스템', 1, 1, 'y', 'y');

-- 철도 안전 관리 시스템 폴더 생성
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '철도 안전 관리 시스템', 1, 1, 'y', 'y');

-- 철도 예매 시스템 폴더 생성
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '철도 예매 시스템', 1, 1, 'y', 'y');

-- 철도 인력 관리 시스템 폴더 생성
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '철도 인력 관리 시스템', 1, 1, 'y', 'y');

InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 1로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '신호 시스템 설계서.docx',
           'https://kcc-bucket.s3.ap-northeast-2.amazonaws.com/kcc_pms/1/%EB%85%B8%ED%8A%B8%EB%B6%81_123123123%EB%9D%BC%EC%9D%B4%EC%96%B8.png',
           'docx',
           102400,
           1,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 7로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '신호 시스템 설계서',
           1,
           2,  -- 철도 신호 시스템 폴더의 opt_no
           'n',
           'y',
           1   -- fl_ms_no
       );

-- 파일 마스터 생성
InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 2로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '물류 관리 시스템 요구사항.xlsx',
           '/files/물류 관리 시스템 요구사항.xlsx',
           'xlsx',
           204800,
           2,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 8로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '물류 관리 시스템 요구사항',
           1,
           3,  -- 철도 물류 관리 시스템 폴더의 opt_no
           'n',
           'y',
           2   -- fl_ms_no
       );

InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 3로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '안전 관리 시스템 분석보고서.pdf',
           '/files/안전 관리 시스템 분석보고서.pdf',
           'pdf',
           512000,
           3,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 9로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '안전 관리 시스템 분석보고서',
           1,
           4,  -- 철도 안전 관리 시스템 폴더의 opt_no
           'n',
           'y',
           3   -- fl_ms_no
       );

InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 4로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '예매 시스템 UI 디자인.png',
           '/files/예매 시스템 UI 디자인.png',
           'png',
           256000,
           4,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 10로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '예매 시스템 UI 디자인',
           1,
           5,  -- 철도 예매 시스템 폴더의 opt_no
           'n',
           'y',
           4   -- fl_ms_no
       );

InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 5로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '인력 관리 시스템 DB 설계.sql',
           '/files/인력 관리 시스템 DB 설계.sql',
           'sql',
           128000,
           5,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 11로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '인력 관리 시스템 DB 설계',
           1,
           6,  -- 철도 인력 관리 시스템 폴더의 opt_no
           'n',
           'y',
           5   -- fl_ms_no
       );

-- 파일 마스터 생성
InSERT InTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성 (fl_ms_no = 6로 가정)
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (
           seq_filedetail.nextval,
           '신호 시스템 테스트 계획서.docx',
           '/files/신호 시스템 테스트 계획서.docx',
           'docx',
           150000,
           6,
           '홍길동',
           SySDATE
       );

-- 산출물 생성 (opt_no = 12로 가정)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (
           seq_output.nextval,
           '신호 시스템 테스트 계획서',
           1,
           2,  -- 철도 신호 시스템 폴더의 opt_no
           'n',
           'y',
           6   -- fl_ms_no
       );

-- 파일 마스터 생성 (fl_ms_no = 7)
InSERT InTO FileMaster (fl_ms_no, use_yn) VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (seq_filedetail.nextval, '신호 시스템 운영 매뉴얼.pdf', '/files/신호 시스템 운영 매뉴얼.pdf', 'pdf', 200000, 7, '홍길동', SySDATE);

-- 산출물 생성 (opt_no = 13)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (seq_output.nextval, '신호 시스템 운영 매뉴얼', 1, 2, 'n', 'y', 7);

-- 파일 마스터 생성 (fl_ms_no = 8)
InSERT InTO FileMaster (fl_ms_no, use_yn) VALUES (seq_filemaster.nextval, 'y');

-- 파일 상세 정보 생성
InSERT InTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (seq_filedetail.nextval, '물류 관리 시스템 데이터 모델링.pptx', '/files/물류 관리 시스템 데이터 모델링.pptx', 'pptx', 250000, 8, '홍길동', SySDATE);

-- 산출물 생성 (opt_no = 14)
InSERT InTO Output (opt_no, opt_ttl, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (seq_output.nextval, '물류 관리 시스템 데이터 모델링', 1, 3, 'n', 'y', 8);

-----------------------------------------------------------------------------------------------------------------
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_17', '적정한 업무/인력 배분', 'PMS00302', 'PMS00502', 'PMS00403', 'PMS00603', '모든 과업이 누락없이 확인되고 적정한 파트 및 인력에게 역할과 책임이 부여되지 않아 업무 사각지대가 발생위험',
                        '1. 업무별 개발대상 목록 식별(설계단계 1,2차 확정)
2. 개발자별 적정한 업무 분배
3. 설계자와 개발자의 연속성 확보', '2024-11-05', '2024-11-05', null, 1, 4, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_18', '도입 솔루션 선정 지연', 'PMS00302', 'PMS00503', 'PMS00402', 'PMS00604', '솔루션 업체와의 계약 지연으로 투입인력의 지원이 원활하지 못해 일정관리의 위험 있음.
특히, 전사정보분석체계 시스템의 구축 범위 및 뱡향성 제시 지연으로 타 시스템과의 연계 범위 정의가 미확정 되어 초기 범위 결정의 어려움 있음',
                        '1. 도입지연 솔루션에 대한 사전 기술검토 진행
2. 장비도입 심의위원회 심의 및 업체 확정
3. 인력구성 및 운영방안 수립

도입시점별 분석단계이전 도입 설계에 반영, 사전영업확인', '2024-11-05', '2024-11-05', null, 1, 5, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_01', '성능 저하', 'PMS00302', 'PMS00501', 'PMS00402', 'PMS00601',
                        '데이터베이스의 용량이 증가함에 따라 적시에 쿼리가 처리되지 않거나, 사용자 요청이 지연됨으로써 시스템 응답 속도가 현저히 느려지는 위험이 존재. 특히, 특정 시간대에 집중적인 트래픽 발생 시 성능 저하가 심각하게 발생할 우려가 있음.', '1.성능 모니터링 도구 설치 및 주기적 점검
2.데이터베이스 인덱스 최적화 및 쿼리 성능 개선 작업
3.고성능 서버로의 장비 업그레이드 검토', '2024-11-05', null, null, 1, 1, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_02', '자원 부족', 'PMS00302', 'PMS00502', 'PMS00401', 'PMS00602', '프로젝트가 진행됨에 따라 자원의 과도한 사용으로 인해 특정 작업에 필요한 인력과 장비가 부족하여 업무 공백이 발생할 가능성 존재. 중요한 작업에 자원을 배정하지 못함으로써 일정 지연과 품질 저하의 위험이 높아짐.',
                        '1.자원 활용도 분석을 통한 자원 최적화 방안 마련
2.추가 인력 및 장비 도입을 위한 예산 요청
3.중요 작업 우선 배정을 위한 자원 분배 계획 수립', '2024-11-05', null, null, 1, 2, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_03', '보안 취약점 노출', 'PMS00302', 'PMS00503', 'PMS00403', 'PMS00603', '데이터 전송 중 충분한 암호화가 이루어지지 않아 민감 정보가 외부에 노출될 위험 있음. 특히, 외부로부터의 침입 가능성이 높아 시스템 내부 데이터를 보호할 수 있는 추가 보안 조치가 시급히 요구됨.',
                        '1.전송 데이터 암호화 방식 적용 및 보안 강화
2.정기적인 보안 점검 및 모니터링 수행
3.보안 정책 개선 및 전 직원 보안 교육 실시', '2024-11-05', null, null, 1, 3, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_04', '장비 노후화', 'PMS00302', 'PMS00501', 'PMS00402', 'PMS00601', '기존 시스템에서 사용 중인 주요 장비가 노후화되어 유지보수 비용이 증가하고, 운영 안정성이 떨어짐. 장비 고장 시 즉각적인 대응이 어렵고, 운영 중단으로 이어질 가능성이 있어 장비 교체 필요성이 증가하고 있음.',
                        '1.주요 장비 교체 계획 수립 및 예산 확보
2.장비 상태 점검 및 고장 예방을 위한 정기 유지보수
3.새로운 장비 도입을 위한 업체 협의 및 선정', '2024-11-05', null, null, 1, 4, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_05', '프로젝트 일정 지연', 'PMS00302', 'PMS00502', 'PMS00403', 'PMS00602', '주요 프로젝트 과제가 계획된 일정 내 완료되지 않아 후속 작업이 지연될 가능성 존재. 특히, 타 부서와의 협업 작업에 차질이 생겨 전체 프로젝트 일정에 큰 영향을 미칠 위험이 있음.',
                        '1.주요 일정별 마일스톤 설정 및 진척도 모니터링
2.부서 간 커뮤니케이션 강화 및 정기 회의 진행
3.일정 조정 및 우선순위 재조정', '2024-11-05', null, null, 1, 5, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_06', '데이터 유출 위험', 'PMS00302', 'PMS00503', 'PMS00404', 'PMS00604', '회사 내부 데이터에 대한 접근 권한 관리가 부족하여 외부로 유출될 가능성 높음. 특히, 민감 정보에 대한 통제와 로그 기록이 미흡하여 데이터 유출 사고 발생 시 신속한 대응이 어려운 상황임.',
                        '1.접근 권한 관리 정책 강화 및 재설정
2.중요 데이터 암호화 및 접근 이력 모니터링
3.외부 유출 방지를 위한 보안 시스템 강화', '2024-11-05', null, null, 1, 6, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_07', '기술 부족', 'PMS00302', 'PMS00501', 'PMS00401', 'PMS00601', '프로젝트를 수행할 인력이 요구되는 기술 수준에 도달하지 못하여 중요한 기능 구현이 지연될 가능성 존재. 특히, 신규 기술 도입 시 필요한 기술 역량 부족으로 인해 프로젝트 진행 속도가 떨어지고, 오류 발생 위험이 증가함.',
                        '1.프로젝트 시작 전 기술 교육 프로그램 실시
2.외부 전문가의 컨설팅 및 지원 요청
3.신규 기술 관련 실습 및 현장 교육 진행', '2024-11-05', null, null, 1, 1, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_08', '네트워크 불안정', 'PMS00302', 'PMS00502', 'PMS00402', 'PMS00602', '시스템에 연결된 네트워크가 불안정하여 주요 데이터 전송 및 서비스 제공에 차질이 발생할 위험 존재. 특히, 중요한 업데이트나 사용자 요청을 처리하는 도중 네트워크 불안정으로 서비스 중단이 발생할 수 있음.',
                        '1.네트워크 장비 업그레이드 및 유지보수 강화
2.대체 네트워크 경로 확보 및 테스트
3.네트워크 모니터링 시스템 도입 및 실시간 관리', '2024-11-05', null, null, 1, 2, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_09', '저장공간 부족', 'PMS00302', 'PMS00503', 'PMS00403', 'PMS00603', '데이터의 급격한 증가로 인해 스토리지 용량이 포화 상태에 도달하여 추가 저장공간 확보가 필요함. 기존 데이터를 보존하면서 새로운 데이터를 수용하기 위한 장비 확장이 시급한 상황임.',
                        '1.데이터 정리 및 불필요한 데이터 삭제
2.스토리지 확장 및 신규 저장 장치 도입
3.백업 및 데이터 압축을 통한 공간 확보', '2024-11-05', null, null, 1, 3, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_10', '품질 저하', 'PMS00302', 'PMS00501', 'PMS00404', 'PMS00604', '테스트가 충분히 이루어지지 않아 제품의 품질이 저하될 가능성 높음. 특히, 오류와 버그가 미처 발견되지 않은 상태로 출시될 경우 사용자 불만이 증가하고, 유지보수 비용이 크게 증가할 위험 있음.',
                        '1.추가 테스트 인력 투입 및 테스트 주기 강화
2.QA(Quality Assurance) 프로세스 개선 및 문서화
3.사용자 피드백 수집 및 제품 개선 지속', '2024-11-05', null, null, 1, 4, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_11', '법적 제약', 'PMS00302', 'PMS00502', 'PMS00402', 'PMS00601', '개인정보 보호법 개정에 따라 기존 데이터 수집 및 처리 방식이 법적 제약을 받게 되어 업무 프로세스에 영향을 미칠 가능성 있음. 관련 법규 미준수 시 법적 책임과 벌금이 부과될 위험 있음.',
                        '1.법률 변경 사항 주기적 모니터링 및 준수 방안 수립
2.관련 법규 준수 교육 실시 및 문서화
3.법적 자문을 통한 컴플라이언스 강화', '2024-11-05', null, null, 1, 5, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_12', '시스템 과부하', 'PMS00302', 'PMS00503', 'PMS00401', 'PMS00602', '시스템 트래픽이 예상치를 초과하여 서버가 과부하 상태에 도달할 가능성 높음. 특히, 갑작스러운 사용자 증가 시 시스템이 버티지 못해 장애가 발생할 위험이 존재함.',
                        '1.트래픽 모니터링을 통한 실시간 관리 강화
2.서버 추가 및 확장 계획 수립
3.부하 분산 시스템 도입 검토', '2024-11-05', null, null, 1, 6, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_13', '신규 기술 도입 실패', 'PMS00302', 'PMS00501', 'PMS00403', 'PMS00603', '신규 기술 도입 과정에서 예상하지 못한 문제로 인해 성공적인 도입이 어려운 상황임. 특히, 기술 안정성이 충분히 확보되지 않아 운영 중 잦은 오류가 발생할 우려가 있음.',
                        '1.신규 기술 파일럿 테스트 및 안정성 검증
2.기술 전문가와 협력하여 도입 방안 마련
3.기술 도입 실패 대비 대체 계획 수립', '2024-11-05', null, null, 1, 7, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_14', '의사소통 문제', 'PMS00302', 'PMS00502', 'PMS00404', 'PMS00604', '팀 간의 원활하지 않은 의사소통으로 인해 업무 진행에 혼선이 발생할 가능성 있음. 특히, 중요한 정보가 제때 전달되지 않아 일정 지연과 품질 저하로 이어질 위험이 있음.',
                        '1.정기적인 회의 일정 수립 및 공유
2.팀 간 커뮤니케이션 도구 사용 및 가이드 제공
3.이슈 발생 시 즉각 보고 및 처리 절차 마련', '2024-11-05', null, null, 1, 1, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_15', '외부 협력사 이슈', 'PMS00302', 'PMS00503', 'PMS00402', 'PMS00601', '외부 협력사의 일정 지연 또는 품질 미달로 인해 프로젝트 전체 일정에 영향을 미칠 가능성 높음. 협력사와의 긴밀한 협조가 어려운 상황이며, 이에 따른 대체 방안이 필요한 상태임.',
                        '1.협력사와의 주기적인 미팅 및 진행 상황 공유
2.품질 문제 발생 시 대체 방안 검토 및 협의
3.계약서에 일정 준수 및 품질 기준 명시', '2024-11-05', null, null, 1, 2, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_16', '예산 초과', 'PMS00302', 'PMS00501', 'PMS00401', 'PMS00602', '예상치 못한 비용 발생으로 인해 예산을 초과할 가능성 존재. 특히, 장비 교체나 추가 인력 투입에 대한 비용이 부족하여 프로젝트 완성도가 떨어질 위험이 있음.',
                        '1.예산 사용 현황 모니터링 및 불필요한 비용 절감
2.추가 예산 확보 방안 검토 및 예산 조정
3.장비 및 인력 도입 우선순위 설정 및 관리', '2024-11-05', null, null, 1, 3, 2, null, null);



INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_001', '성능 저하 발생', 'PMS00301', 'PMS00502', 'PMS00402', 'PMS00602', '특정 시간대에 집중적인 트래픽 증가로 인해 시스템 응답 시간이 급격히 느려지며 사용자 불만이 증가하고 있음.', TO_DATE('2024-10-01', 'YYYY-MM-DD'), NULL, 1, 3, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_002', '데이터 유출 사고 발생', 'PMS00301', 'PMS00501', 'PMS00402', 'PMS00601', '내부 시스템 접근 권한 설정 오류로 인해 민감 정보가 외부에 유출되어 고객 불만과 보안 위협이 발생함.', TO_DATE('2024-09-15', 'YYYY-MM-DD'), NULL, 1, 5, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_003', '서버 다운', 'PMS00301', 'PMS00502', 'PMS00403', 'PMS00601', '서버 과부하로 인해 시스템이 중단되었고, 사용자 접근이 차단됨. 긴급 복구 작업이 필요함.', TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'), 1, 7, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_004', '데이터 손실', 'PMS00301', 'PMS00503', 'PMS00402', 'PMS00602', '백업 작업 중 오류가 발생하여 일부 데이터가 유실되었으며, 복구 작업이 시급히 요구됨.', TO_DATE('2024-09-20', 'YYYY-MM-DD'), NULL, 1, 2, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_005', '외부 침입 시도', 'PMS00301', 'PMS00501', 'PMS00402', 'PMS00601', '외부에서 비인가된 접근 시도가 탐지되었으며, 잠재적인 보안 위협으로 시스템 점검이 필요함.', TO_DATE('2024-09-01', 'YYYY-MM-DD'), NULL, 1, 4, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_006', '시스템 결함 발생', 'PMS00301', 'PMS00503', 'PMS00402', 'PMS00603', '일부 기능에서 예기치 않은 오류가 발생하여 사용자의 업무 수행에 차질이 발생하고 있음.', TO_DATE('2024-10-05', 'YYYY-MM-DD'), NULL, 1, 9, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_007', '네트워크 불안정', 'PMS00301', 'PMS00502', 'PMS00402', 'PMS00602', '지속적인 네트워크 불안정으로 인해 데이터 전송 속도가 느려지고 사용자 경험이 저하됨.', TO_DATE('2024-10-12', 'YYYY-MM-DD'), NULL, 1, 6, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_008', '사용자 인증 실패 증가', 'PMS00301', 'PMS00505', 'PMS00402', 'PMS00603', '인증 시스템 문제로 인해 다수의 사용자가 로그인을 시도하는 과정에서 인증에 실패하고 있음.', TO_DATE('2024-09-25', 'YYYY-MM-DD'), NULL, 1, 8, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_009', '자원 부족', 'PMS00301', 'PMS00504', 'PMS00402', 'PMS00601', '프로젝트 자원 사용이 급증하여 필수적인 작업에 필요한 인력과 장비가 부족함.', TO_DATE('2024-10-10', 'YYYY-MM-DD'), NULL, 1, 11, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_010', '시스템 과부하', 'PMS00301', 'PMS00502', 'PMS00403', 'PMS00602', '다수의 요청이 동시에 발생하여 시스템이 처리 한도를 초과하고 있으며, 성능 개선이 필요함.', TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_DATE('2024-10-22', 'YYYY-MM-DD'), 1, 13, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_011', '테스트 환경 오류 발생', 'PMS00301', 'PMS00503', 'PMS00402', 'PMS00601', '테스트 중에 예상하지 못한 오류가 발생하여 제품 품질에 영향을 미치고 있음.', TO_DATE('2024-09-30', 'YYYY-MM-DD'), NULL, 1, 1, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_012', '사용자 불만 증가', 'PMS00301', 'PMS00501', 'PMS00402', 'PMS00604', '최근 업데이트 이후 특정 기능이 느려져 사용자 불만이 급격히 증가함.', TO_DATE('2024-09-18', 'YYYY-MM-DD'), NULL, 1, 2, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_013', '중요 데이터 손상', 'PMS00301', 'PMS00503', 'PMS00402', 'PMS00601', '시스템 오류로 인해 일부 중요 데이터가 손상되어 복구가 필요함.', TO_DATE('2024-10-05', 'YYYY-MM-DD'), NULL, 1, 5, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_014', '이메일 서비스 장애', 'PMS00301', 'PMS00505', 'PMS00402', 'PMS00603', '메일 서버 문제로 인해 다수의 이메일 발송이 실패하여 고객과의 커뮤니케이션에 차질이 발생함.', TO_DATE('2024-10-12', 'YYYY-MM-DD'), NULL, 1, 12, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_015', '하드웨어 고장', 'PMS00301', 'PMS00504', 'PMS00403', 'PMS00602', '하드웨어 장비 고장으로 인해 서비스 제공에 지장이 발생하고 있으며, 즉각적인 교체가 요구됨.', TO_DATE('2024-09-25', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), 1, 8, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_016', '보안 업데이트 누락', 'PMS00301', 'PMS00501', 'PMS00402', 'PMS00601', '보안 패치가 제때 적용되지 않아 외부 위협에 대한 방어력이 약화됨.', TO_DATE('2024-09-15', 'YYYY-MM-DD'), NULL, 1, 10, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_017', '고객 불만 발생', 'PMS00301', 'PMS00501', 'PMS00402', 'PMS00602', '고객의 새로운 요구사항 반영이 지연되어 불만이 발생한 상황', TO_DATE('2024-10-20', 'YYYY-MM-DD'), NULL, 1, 3, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_018', '프로젝트 일정 지연', 'PMS00301', 'PMS00502', 'PMS00402', 'PMS00603', '외부 협력사의 일정 지연으로 인해 프로젝트 일정에 차질이 발생', TO_DATE('2024-10-15', 'YYYY-MM-DD'), NULL, 1, 4, 2, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_019', '품질 기준 미달 문제 발생', 'PMS00301', 'PMS00503', 'PMS00402', 'PMS00601', '테스트 결과가 품질 기준에 미달하여 추가 조치가 필요', TO_DATE('2024-10-10', 'YYYY-MM-DD'), NULL, 1, 2, 3, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_020', '인력 부족 문제 발생', 'PMS00301', 'PMS00504', 'PMS00402', 'PMS00602', '업무를 수행할 인력 부족으로 인해 특정 작업이 지연됨', TO_DATE('2024-11-05', 'YYYY-MM-DD'), NULL, 1, 7, 1, '2024-11-05');

INSERT INTO RISK (RISK_NO, RISK_ID, RSK_TTL, TYPE_CD, CLASS_CD, STAT_CD, PRI_CD, RISK_CONT, DUE_DT, COMPL_DT, PRJ_NO, SYS_NO, MEM_NO, regist_dt)
VALUES (SEQ_RISK.NEXTVAL, 'IS_PMS_021', '법적 규정 준수 미비', 'PMS00301', 'PMS00504', 'PMS00403', 'PMS00602', '새로운 법적 규정 준수가 이루어지지 않아 문제가 발생할 위험', TO_DATE('2024-10-30', 'YYYY-MM-DD'), TO_DATE('2024-11-10', 'YYYY-MM-DD'), 1, 10, 2, '2024-11-05');



COMMIT;
