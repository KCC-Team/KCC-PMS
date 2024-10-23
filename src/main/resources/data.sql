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
    login_id VARCHAR2(20) NOT NULL,
    pw VARCHAR2(30) NOT NULL,
    mem_nm VARCHAR2(10) NOT NULL,
    phone_no VARCHAR2(15) NOT NULL,
    email VARCHAR2(50) NOT NULL,
    auth_cd CHAR(8) NOT NULL,
    pos_nm VARCHAR2(8) NULL,
    birth_dt VARCHAR2(10) NULL,
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
    pre_st_dt DATE NULL,
    pre_end_dt DATE NULL,
    st_dt DATE NULL,
    end_dt DATE NULL,
    stat_cd CHAR(8) NOT NULL,
    pri_cd CHAR(8) NOT NULL,
    prg	NUMBER NOT NULL,
    diff_cd CHAR(8) NOT NULL,
    class_cd CHAR(8) NULL,
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
    original_ttl VARCHAR2(100) NOT NULL,
    file_path VARCHAR2(500) NOT NULL,
    fl_type VARCHAR2(20) NOT NULL,
    fl_size VARCHAR2(20) NOT NULL,
    fl_ms_no NUMBER NOT NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(100) NULL,
    mod_dt DATE NULL
);

CREATE TABLE Output (
    opt_no number NOT NULL,
    opt_ttl VARCHAR2(50) NOT NULL,
    depth NUMBER NOT NULL,
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
    test_dtl_no	number NOT NULL,
    test_dtl_id	VARCHAR2(20) NOT NULL,
    wrk_proc_cont VARCHAR2(1000) NULL,  -- 업무처리내용
    test_data VARCHAR2(1000) NULL,      -- 테스트데이터
    estimated_rlt VARCHAR2(1000)	NULL,   -- 예상결과
    test_detail_cont VARCHAR2(1000) NULL,      -- 테스트상세내용
    proceed_cont VARCHAR2(1000) NULL,       -- 수행절차
    pre_cond VARCHAR2(1000)	NULL,           -- 사전조건
    note VARCHAR2(1000)	NULL,               -- 비고
    test_st_dt DATE	NULL,                       -- 테스트진행일자
    test_result_cd CHAR(8) NULL,                -- 테스트결과코드
    mem_no NUMBER NULL,                         -- 테스트 담당자
    par_test_dtl_no NUMBER NULL,
    test_no	NUMBER NOT NULL                 -- 테스트번호
);

CREATE TABLE Defect (
    df_no number NOT NULL,
    df_id VARCHAR(20) NOT NULL,
    df_ttl VARCHAR2(100) NOT NULL,
    type_cd CHAR(3) NOT NULL,
    stat_cd CHAR(3) NOT NULL,
    pri_cd CHAR(3) NOT NULL,
    df_cont VARCHAR2(500) NOT NULL,
    df_fd_dt DATE NOT NULL,
    due_dt DATE NULL,
    compl_dt DATE NULL,
    df_compl_cont VARCHAR2(500) NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NULL,
    test_dtl_no NUMBER NULL,
    mem_fd_no NUMBER NOT NULL,
    mem_act_no NUMBER NULL,
    fl_ms_act_no NUMBER NULL,
    fl_ms_fd_no NUMBER NULL
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
    mem_no NUMBER NOT NULL
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
ALTER TABLE TaskMember ADD CONSTRAINT fk_tsk_tsk_no_003 FOREIGN KEY (tsk_no) REFERENCES Task (tsk_no);

ALTER TABLE Feature ADD CONSTRAINT pk_feat_no_001 PRIMARY KEY (feat_no);
ALTER TABLE Feature ADD CONSTRAINT fk_feat_sys_no_002 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Feature ADD CONSTRAINT FK_ProjectMember_To_Feature FOREIGN KEY(mem_no, tm_no, prj_no) REFERENCES ProjectMember (mem_no, tm_no, prj_no);

ALTER TABLE TestMaster ADD CONSTRAINT pk_tm_tes_no_001 PRIMARY KEY (test_no);
ALTER TABLE TestMaster ADD CONSTRAINT fk_tm_prj_no_tm_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE TestMaster ADD CONSTRAINT fk_tm_sys_work_no_004 FOREIGN KEY (sys_work_no) REFERENCES System (sys_no);

ALTER TABLE TestDetail ADD CONSTRAINT pk_td_test_dtl_no_001 PRIMARY KEY (test_dtl_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_no_002 FOREIGN KEY (test_no) REFERENCES TestMaster (test_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_mem_no_003 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_td_test_par_test_dtl_no_004 FOREIGN KEY (par_test_dtl_no) REFERENCES TestDetail (test_dtl_no);

ALTER TABLE Defect ADD CONSTRAINT pk_df_no_001 PRIMARY KEY (df_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_sys_no_003 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_test_dtl_no_004 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_mem_fd_no_005 FOREIGN KEY (mem_fd_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_mem_act_no_006 FOREIGN KEY (mem_act_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_act_no_007 FOREIGN KEY (fl_ms_act_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_fd_no_008 FOREIGN KEY (fl_ms_fd_no) REFERENCES Member (mem_no);

ALTER TABLE FeatureTest ADD CONSTRAINT pk_ft_feat_test_no_001 PRIMARY KEY (feat_no, test_dtl_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_no_002 FOREIGN KEY (feat_no) REFERENCES Feature (feat_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_test_dtl_no_003 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);

ALTER TABLE FileMaster ADD CONSTRAINT pk_fl_ms_no_001 PRIMARY KEY (fl_ms_no);

ALTER TABLE FileDetail ADD CONSTRAINT pk_fl_no_001 PRIMARY KEY (fl_no);
ALTER TABLE FileDetail ADD CONSTRAINT fk_fl_ms_no_002 FOREIGN KEY (fl_ms_no) REFERENCES FileMaster (fl_ms_no);

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

ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_1 FOREIGN KEY(
                                                                  type_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_2 FOREIGN KEY(
                                                                  stat_cd) REFERENCES CodeDetail (cd_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT FK_Code_To_Defect_3 FOREIGN KEY(
                                                                  pri_cd) REFERENCES CodeDetail (cd_dtl_no);
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
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, 'RDD', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '신사업', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (seq_usergroup.nextval, '클라우드', NULL);

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
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00803', 'PMS008', '기타결함', 3, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00901', 'PMS009', '신규', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00902', 'PMS009', '개발중', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00903', 'PMS009', '개발완료', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00904', 'PMS009', '단위테스트완료', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00905', 'PMS009', 'PL확인', 5, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS00906', 'PMS009', '고객확인', 6, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01001', 'PMS010', '화면', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01002', 'PMS010', '인터페이스', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01003', 'PMS010', '프로그램', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01004', 'PMS010', '보고서', 4, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01101', 'PMS011', '매우높음', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01102', 'PMS011', '높음', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01103', 'PMS011', '보통', 3, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01104', 'PMS011', '낮음', 4, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01105', 'PMS011', '매우낮음', 5, 'Y');

INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01201', 'PMS012', '단위', 1, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01202', 'PMS012', '통합', 2, 'Y');
INSERT INTO CodeDetail (cd_dtl_no, common_cd_no, cd_dtl_nm, order_no, use_yn) VALUES ('PMS01203', 'PMS012', '사용자', 3, 'Y');

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

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user1', 'pw1', '홍길동', '010-1234-5678', 'hong@example.com', 'PMS01501', 'PMS01706', '1990-01-01', 'PMS01503', '공공', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user2', 'pw2', '김철수', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user3', 'pw2', '박길순', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user4', 'pw2', '유재석', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user5', 'pw2', '강호동', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (seq_project.nextval, '차세대 공공 프로젝트', '프로젝트 내용', 'PMS00102', 0, '공공', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', '2021-01-01');

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user6', 'pw2', '김연호', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user7', 'pw2', '이수호', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user8', 'pw2', '이한희', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user9', 'pw2', '황철순', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user10', 'pw2', '김박사', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user11', 'pw2', '이박사', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user12', 'pw2', '박카스', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user13', 'pw2', '밀키스', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '차세대 공공 프로젝트', '테스트 내용', 'Y', 1, NULL, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 1, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);
INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (2, 1, 1, 'PMS00202', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);
INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (3, 1, 1, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, 'A 업무 시스템', '시스템1 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, 'B 업무 시스템', '시스템2 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, 'C 업무 시스템', '시스템3 내용', 'Y', 1, NULL, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, 'D 업무 시스템', '시스템4 내용', 'Y', 1, NULL, 'Y');
-- 업무 seq = 5
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '범위관리', '시스템1 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '일정관리', '시스템2 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '비용관리', '시스템3 내용', 'Y', 1, 1, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '품질관리', '시스템4 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '인적자원관리', '시스템5 내용', 'Y', 1, 2, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '통신관리', '시스템6 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '위험관리', '시스템7 내용', 'Y', 1, 3, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '조달관리', '시스템8 내용', 'Y', 1, 4, 'Y');
INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no, sys_yn)
VALUES (seq_system.nextval, '통합관리', '시스템9 내용', 'Y', 1, 4, 'Y');

INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no)
VALUES (seq_feature.nextval, 'F001', 'RSTR110', '기능1 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1);
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no)
VALUES (seq_feature.nextval, 'F002', 'RSTR111', '기능2 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1);
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no)
VALUES (seq_feature.nextval, 'F003', 'RSTR123', '기능3 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1);

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_001', '테스트1', '테스트1 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_002', '테스트2', '테스트2 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_003', '테스트3', '테스트3 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_004', '테스트4', '테스트4 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_005', '테스트5', '테스트5 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_006', '테스트6', '테스트6 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_007', '테스트7', '테스트7 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_008', '테스트8', '테스트8 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_009', '테스트9', '테스트9 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_010', '테스트10', '테스트10 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );
INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_011', '테스트11', '테스트11 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_012', '테스트12', '테스트12 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_013', '테스트13', '테스트13 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_014', '테스트14', '테스트14 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_015', '테스트15', '테스트15 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_016', '테스트16', '테스트16 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_017', '테스트17', '테스트17 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_018', '테스트18', '테스트18 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_019', '테스트19', '테스트19 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_020', '테스트20', '테스트20 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_021', '테스트21', '테스트21 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_022', '테스트22', '테스트22 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_023', '테스트23', '테스트23 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_024', '테스트24', '테스트24 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_025', '테스트25', '테스트25 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_026', '테스트26', '테스트26 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 5, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_027', '테스트27', '테스트27 내용', 'PMS01301',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 6, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_028', '테스트28', '테스트28 내용', 'PMS01302',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 7, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_029', '테스트29', '테스트29 내용', 'PMS01303',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 8, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestMaster (
    test_no, test_id, test_title, test_cont, stat_cd, type_cd, prj_no,
    test_st_dt, test_end_dt, sys_work_no, reg_id, reg_dt, use_yn
)
VALUES (
           seq_testmaster.nextval, 't_030', '테스트30', '테스트30 내용', 'PMS01304',
           'PMS01201', 1, '2021-01-01', '2021-01-01', 9, 'user1', '2021-01-01', 'Y'
       );

INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, proceed_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD001', '테스트상세1', '테스트상세1 내용', '테스트상세1 예상결과', '테스트상세1 내용', '2021-01-01', 'PMS01401', '테스트상세1 진행내용', '테스트상세1 사전조건', '테스트상세1 비고', 1, NULL, 1);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, proceed_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD002', '테스트상세2', '테스트상세2 내용', '테스트상세2 예상결과', '테스트상세2 내용', '2021-01-01', 'PMS01401', '테스트상세2 진행내용', '테스트상세2 사전조건', '테스트상세2 비고', 1, NULL, 1);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, proceed_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD003', '테스트상세3', '테스트상세3 내용', '테스트상세3 예상결과', '테스트상세3 내용', '2021-01-01', 'PMS01401', '테스트상세3 진행내용', '테스트상세3 사전조건', '테스트상세3 비고', 1, NULL, 3);

-- INSERT INTO Defect (df_no, df_id, df_ttl, type_cd, stat_cd, pri_cd, df_cont, df_fd_dt, due_dt, compl_dt, df_compl_cont, prj_no, sys_no, test_dtl_no, mem_fd_no, mem_act_no)
-- VALUES (seq_defect.nextval, 'D001', '결함1', '001', '001', '001', '결함1 내용', '2021-01-01', '2021-01-01', '2021-01-01', '결함1 해결내용', 'PMS00801', 1, 1, 1, 1);
-- INSERT INTO Defect (df_no, df_id, df_ttl, type_cd, stat_cd, pri_cd, df_cont, df_fd_dt, due_dt, compl_dt, df_compl_cont, prj_no, sys_no, test_dtl_no, mem_fd_no, mem_act_no)
-- VALUES (seq_defect.nextval, 'D002', '결함2', '001', '001', '001', '결함2 내용', '2021-01-01', '2021-01-01', '2021-01-01', '결함2 해결내용', 'PMS00801', 1, 1, 1, 1);

INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (1, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (2, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (3, 1);

update codedetail set field_2 = 'Y' where common_cd_no = 'PMS004';
update codedetail set field_3 = 'Y' where common_cd_no = 'PMS004' and cd_dtl_no IN ('PMS00402', 'PMS00403', 'PMS00404');

INSERT INTO Output (opt_no, opt_ttl, depth, prj_no, high_folder_no, fld_yn, use_yn)
VALUES (seq_output.nextval, '차세대 공공 프로젝트', 1, 1, NULL, 'Y', 'Y');

INSERT INTO FileMaster (fl_ms_no, use_yn)
VALUES (seq_filemaster.nextval, 'Y');

INSERT INTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (seq_filedetail.nextval, '노트북_123123123라이언', 'https://kcc-bucket.s3.ap-northeast-2.amazonaws.com/kcc_pms/1/%EB%85%B8%ED%8A%B8%EB%B6%81_123123123%EB%9D%BC%EC%9D%B4%EC%96%B8.png', 'png', '7.1KB', 1, '홍길동', sysdate);
INSERT INTO FileDetail (fl_no, original_ttl, file_path, fl_type, fl_size, fl_ms_no, reg_id, reg_dt)
VALUES (seq_filedetail.nextval, 'spri123123123123ngboot ', 'https://kcc-bucket.s3.ap-northeast-2.amazonaws.com/kcc_pms/1/spri123123123123ngboot.png', 'png', '24.7KB', 1, '홍길동', sysdate);

INSERT INTO Output (opt_no, opt_ttl, depth, prj_no, high_folder_no, fld_yn, use_yn, fl_ms_no)
VALUES (seq_output.nextval, 'A 업무 요구사항 정의서', 2, 1, 1, 'N', 'Y', 1);

-----------------------------------------------------------------------------------------------------------------
COMMIT;
