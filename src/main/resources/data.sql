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
    original_ttl VARCHAR2(100) NOT NULL,
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
    opt_ttl VARCHAR2(50) NOT NULL,
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
    test_dtl_id   VARCHAR2(20) NOT NULL,
    wrk_proc_cont VARCHAR2(1000) NULL,  -- 업무처리내용
    test_data VARCHAR2(1000) NULL,      -- 테스트데이터
    estimated_rlt VARCHAR2(1000)   NULL,   -- 예상결과
    test_detail_cont VARCHAR2(1000) NULL,      -- 테스트상세내용
    progress_cont VARCHAR2(1000) NULL,       -- 수행절차
    pre_cond VARCHAR2(1000)   NULL,           -- 사전조건
    note VARCHAR2(1000)   NULL,               -- 비고
    test_st_dt DATE   NULL,                       -- 테스트진행일자
    test_result_cd CHAR(8) NULL,                -- 테스트결과코드
    mem_no NUMBER NULL,                         -- 테스트 담당자
    par_test_dtl_no NUMBER NULL,
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
    fl_ms_NO NUMBER
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

ALTER TABLE Defect ADD CONSTRAINT pk_df_no_001 PRIMARY KEY (df_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_work_no_003 FOREIGN KEY (work_no) REFERENCES System (sys_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_test_dtl_no_004 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_fd_no_005 FOREIGN KEY (fl_ms_fd_no) REFERENCES Member (mem_no);
ALTER TABLE Defect ADD CONSTRAINT fk_df_fl_ms_work_no_006 FOREIGN KEY (fl_ms_work_no) REFERENCES Member (mem_no);

ALTER TABLE FeatureTest ADD CONSTRAINT pk_ft_feat_test_no_001 PRIMARY KEY (feat_no, test_dtl_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_no_002 FOREIGN KEY (feat_no) REFERENCES Feature (feat_no);
ALTER TABLE FeatureTest ADD CONSTRAINT fk_ft_feat_test_dtl_no_003 FOREIGN KEY (test_dtl_no) REFERENCES TestDetail (test_dtl_no);

ALTER TABLE FileMaster ADD CONSTRAINT pk_fl_ms_no_001 PRIMARY KEY (fl_ms_no);

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
VALUES (seq_project.nextval, '차세대 공공 프로젝트', '공공 프로젝트', 'PMS00102', 30, '경찰청', '2024-10-01', '2024-10-30', '2024-10-01', '2024-10-30', 'Y', 'user1', '2024-10-01', '2024-10-01');

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
VALUES (seq_member.nextval, 3, 'user1', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이철수', '010-1234-5678', 'hong@example.com', 'PMS01501', 'PMS01706', '1990-01-01', 'PMS01503', '공공', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user2', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김철수', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user3', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '박철수', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user4', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '강재석', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user5', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김상중', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user6', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김연호', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'user7', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이수호', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user8', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이한희', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user9', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '황철순', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user10', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '유재석', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user11', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '강호동', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01502', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user12', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이경규', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'user13', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '신동엽', '010-9876-5432', 'kim@example.com', 'PMS01501', 'PMS01703', '1992-05-21', 'PMS01501', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'pm1', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '홍길동', '010-9876-5432', 'kim@example.com', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 4, 'pm2', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '김길동', '010-9876-5432', 'kim@example.com', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (seq_member.nextval, 3, 'pm3', '$2a$10$GBpeKte0vdpwmnB3brH3LeB4YwMZnbHQpyDkvTp9BWo0BS6fYXINe', '이길동', '010-9876-5432', 'kim@example.com', 'PMS01503', 'PMS01702', '1992-05-21', 'PMS01503', 'SI', 'Y', NULL);

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, order_no, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (seq_team.nextval, '차세대 공공 프로젝트', '테스트 내용', 'Y', 1, NULL, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 1, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 2, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 3, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 4, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 5, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 6, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 7, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 8, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 9, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 10, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 11, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 12, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (2, 1, 1, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (3, 1, 1, 'PMS00202', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 1, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 2, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 3, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 4, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 5, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 6, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 7, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 8, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 9, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 10, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 11, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (14, 1, 12, 'PMS00201', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'pm1', '2021-01-01', NULL, NULL);

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
VALUES (seq_feature.nextval, 'F001', 'RSTR110', '기능1 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no, class_cd)
VALUES (seq_feature.nextval, 'F002', 'RSTR111', '기능2 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');
INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no, class_cd)
VALUES (seq_feature.nextval, 'F003', 'RSTR123', '기능3 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1, 'PMS01005');

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

INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD001', '테스트상세1', '테스트상세1 내용', '테스트상세1 예상결과', '테스트상세1 내용', '2021-01-01', 'PMS01401', '테스트상세1 진행내용', '테스트상세1 사전조건', '테스트상세1 비고', 1, NULL, 1);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD002', '테스트상세2', '테스트상세2 내용', '테스트상세2 예상결과', '테스트상세2 내용', '2021-01-01', 'PMS01401', '테스트상세2 진행내용', '테스트상세2 사전조건', '테스트상세2 비고', 1, NULL, 1);
INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_cont, test_data, estimated_rlt, test_detail_cont, test_st_dt, test_result_cd, progress_cont, pre_cond, note, mem_no, par_test_dtl_no, test_no)
VALUES (seq_testdetail.nextval, 'TD003', '테스트상세3', '테스트상세3 내용', '테스트상세3 예상결과', '테스트상세3 내용', '2021-01-01', 'PMS01401', '테스트상세3 진행내용', '테스트상세3 사전조건', '테스트상세3 비고', 1, NULL, 3);


INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (1, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (2, 1);
INSERT INTO FeatureTest (feat_no, test_dtl_no) VALUES (3, 1);

update codedetail set field_2 = 'Y' where common_cd_no = 'PMS004';
update codedetail set field_3 = 'Y' where common_cd_no = 'PMS004' and cd_dtl_no IN ('PMS00402', 'PMS00403', 'PMS00404');

INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0001', '로그인 오류', 'PMS00701', 'PMS00601', '사용자가 로그인할 수 없습니다.', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0002', '데이터 저장 실패', 'PMS00702', 'PMS00602', '새로운 데이터를 저장할 때 오류 발생.', TO_DATE('2024-10-02', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0003', '화면 로딩 지연', 'PMS00703', 'PMS00603', '메인 화면 로딩 시간이 오래 걸립니다.', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0004', '그래프 표시 오류', 'PMS00704', 'PMS00604', '통계 그래프가 올바르게 표시되지 않습니다.', TO_DATE('2024-10-04', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0005', '파일 업로드 실패', 'PMS00701', 'PMS00605', '파일 업로드 시 에러 메시지 발생.', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0006', '메일 전송 오류', 'PMS00702', 'PMS00601', '인증 메일이 전송되지 않습니다.', TO_DATE('2024-10-06', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0007', '권한 설정 문제', 'PMS00703', 'PMS00602', '관리자 권한이 부여되지 않습니다.', TO_DATE('2024-10-07', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0008', '페이지 이동 오류', 'PMS00704', 'PMS00603', '특정 페이지로 이동할 수 없습니다.', TO_DATE('2024-10-08', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0009', '알림 기능 미작동', 'PMS00701', 'PMS00604', '새로운 알림이 표시되지 않습니다.', TO_DATE('2024-10-09', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0010', '검색 기능 오류', 'PMS00702', 'PMS00605', '검색 결과가 표시되지 않습니다.', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0011', '세션 만료 문제', 'PMS00703', 'PMS00601', '세션이 예상보다 빨리 만료됩니다.', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0012', 'UI 깨짐 현상', 'PMS00704', 'PMS00602', '브라우저 호환성 문제로 UI가 깨집니다.', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0013', '다국어 지원 오류', 'PMS00701', 'PMS00603', '일부 텍스트가 번역되지 않습니다.', TO_DATE('2024-10-13', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0014', '데이터 동기화 문제', 'PMS00702', 'PMS00604', '데이터 동기화가 제대로 이루어지지 않습니다.', TO_DATE('2024-10-14', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0015', '접속 불가 현상', 'PMS00703', 'PMS00605', '일부 사용자가 접속할 수 없습니다.', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0016', '캐시 문제', 'PMS00704', 'PMS00601', '업데이트 후에도 이전 내용이 표시됩니다.', TO_DATE('2024-10-16', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0017', '로그아웃 불가', 'PMS00701', 'PMS00602', '사용자가 로그아웃할 수 없습니다.', TO_DATE('2024-10-17', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0018', '이미지 로딩 실패', 'PMS00702', 'PMS00603', '이미지가 로딩되지 않습니다.', TO_DATE('2024-10-18', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0019', 'API 호출 오류', 'PMS00703', 'PMS00604', '외부 API 호출 시 오류 발생.', TO_DATE('2024-10-19', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0020', '보안 취약점 발견', 'PMS00704', 'PMS00605', 'SQL 인젝션 취약점 발견.', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0021', '데이터 삭제 불가', 'PMS00701', 'PMS00601', '데이터를 삭제할 수 없습니다.', TO_DATE('2024-10-21', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0022', '푸시 알림 오류', 'PMS00702', 'PMS00602', '푸시 알림이 수신되지 않습니다.', TO_DATE('2024-10-22', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0023', '프로필 업데이트 문제', 'PMS00703', 'PMS00603', '프로필 정보 수정 시 오류 발생.', TO_DATE('2024-10-23', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0024', '로그 파일 생성 안됨', 'PMS00704', 'PMS00604', '서버 로그 파일이 생성되지 않습니다.', TO_DATE('2024-10-24', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0025', '시간대 설정 오류', 'PMS00701', 'PMS00605', '시간대 변경이 적용되지 않습니다.', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0026', '자동 저장 기능 문제', 'PMS00702', 'PMS00601', '자동 저장이 작동하지 않습니다.', TO_DATE('2024-10-26', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0027', '메모리 누수 현상', 'PMS00703', 'PMS00602', '장시간 사용 시 메모리 사용량 증가.', TO_DATE('2024-10-27', 'YYYY-MM-DD'), 1, 1, 'PMS00803');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0028', '페이지 권한 오류', 'PMS00704', 'PMS00603', '비인가 사용자가 페이지에 접근 가능합니다.', TO_DATE('2024-10-28', 'YYYY-MM-DD'), 1, 1, 'PMS00801');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0029', '텍스트 입력 문제', 'PMS00701', 'PMS00604', '특정 필드에 입력이 불가능합니다.', TO_DATE('2024-10-29', 'YYYY-MM-DD'), 1, 1, 'PMS00802');
INSERT INTO Defect (df_no, df_id, df_ttl, stat_cd, pri_cd, df_cont, df_fd_dt, mem_fd_no, prj_no, type_cd)
VALUES (seq_defect.nextval, 'DF-0030', '비밀번호 변경 오류', 'PMS00702', 'PMS00605', '비밀번호 변경 시 오류 발생.', TO_DATE('2024-10-30', 'YYYY-MM-DD'), 1, 1, 'PMS00803');

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F001', '기능1', '내용1', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F002', '기능2', '내용2', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F003', '기능3', '내용3', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01001', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_001', '기능1', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/17', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00601', 50, 'PMS01101', 'PMS01002', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_002', '기능2', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 50, 'PMS01101', 'PMS01002', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_003', '기능3', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 50, 'PMS01101', 'PMS01003', 'Y', 5, 3, 1, 1);



INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F001', '기능1', '내용1', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01003', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F002', '기능2', '내용2', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01002', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F003', '기능3', '내용3', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01002', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_001', '기능1', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/17', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00601', 40, 'PMS01101', 'PMS01004', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_002', '기능2', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 70, 'PMS01101', 'PMS01004', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_003', '기능3', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 20, 'PMS01101', 'PMS01003', 'Y', 5, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F001', '기능1', '내용1', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01003', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F002', '기능2', '내용2', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01002', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F003', '기능3', '내용3', TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), TO_DATE('21/01/01', 'YY/MM/DD'), 'PMS00901', 'PMS00603', 100, 'PMS01103', 'PMS01002', 'Y', 1, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_001', '기능63', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/17', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00601', 40, 'PMS01101', 'PMS01004', 'Y', 6, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_002', '기능62', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 70, 'PMS01101', 'PMS01004', 'Y', 6, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'ITS_003', '기능61', 'test', TO_DATE('24/10/02', 'YY/MM/DD'), TO_DATE('24/10/30', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 20, 'PMS01101', 'PMS01003', 'Y', 6, 3, 1, 1);


INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F004', '기능4', '내용4', TO_DATE('22/02/15', 'YY/MM/DD'), TO_DATE('22/03/01', 'YY/MM/DD'), NULL, NULL, 'PMS00901', 'PMS00601', 20, 'PMS01101', 'PMS01001', 'Y', 2, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F005', '기능5', '내용5', TO_DATE('22/03/15', 'YY/MM/DD'), TO_DATE('22/04/01', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00602', 40, 'PMS01102', 'PMS01002', 'Y', 3, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F006', '기능6', '내용6', TO_DATE('22/04/15', 'YY/MM/DD'), TO_DATE('22/05/01', 'YY/MM/DD'), NULL, NULL, 'PMS00903', 'PMS00603', 60, 'PMS01103', 'PMS01003', 'Y', 4, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F007', '기능7', '내용7', TO_DATE('22/05/15', 'YY/MM/DD'), TO_DATE('22/06/01', 'YY/MM/DD'), NULL, NULL, 'PMS00904', 'PMS00604', 80, 'PMS01104', 'PMS01004', 'Y', 5, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F008', '기능8', '내용8', TO_DATE('22/06/15', 'YY/MM/DD'), TO_DATE('22/07/01', 'YY/MM/DD'), NULL, NULL, 'PMS00905', 'PMS00605', 100, 'PMS01105', 'PMS01005', 'Y', 6, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F009', '기능9', '내용9', TO_DATE('22/07/15', 'YY/MM/DD'), TO_DATE('22/08/01', 'YY/MM/DD'), NULL, NULL, 'PMS00906', 'PMS00601', 50, 'PMS01101', 'PMS01001', 'Y', 7, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F010', '기능10', '내용10', TO_DATE('22/08/15', 'YY/MM/DD'), TO_DATE('22/09/01', 'YY/MM/DD'), NULL, NULL, 'PMS00901', 'PMS00602', 70, 'PMS01102', 'PMS01002', 'Y', 8, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F011', '기능11', '내용11', TO_DATE('22/09/15', 'YY/MM/DD'), TO_DATE('22/10/01', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00603', 30, 'PMS01103', 'PMS01003', 'Y', 9, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F012', '기능12', '내용12', TO_DATE('22/10/15', 'YY/MM/DD'), TO_DATE('22/11/01', 'YY/MM/DD'), NULL, NULL, 'PMS00903', 'PMS00604', 90, 'PMS01104', 'PMS01004', 'Y', 10, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F013', '기능13', '내용13', TO_DATE('22/11/15', 'YY/MM/DD'), TO_DATE('22/12/01', 'YY/MM/DD'), NULL, NULL, 'PMS00904', 'PMS00605', 10, 'PMS01105', 'PMS01005', 'Y', 11, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F014', '기능14', '내용14', TO_DATE('23/01/15', 'YY/MM/DD'), TO_DATE('23/02/01', 'YY/MM/DD'), NULL, NULL, 'PMS00905', 'PMS00601', 60, 'PMS01101', 'PMS01001', 'Y', 12, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F015', '기능15', '내용15', TO_DATE('23/03/15', 'YY/MM/DD'), TO_DATE('23/04/01', 'YY/MM/DD'), NULL, NULL, 'PMS00906', 'PMS00602', 20, 'PMS01102', 'PMS01002', 'Y', 13, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F016', '기능16', '내용16', TO_DATE('23/05/15', 'YY/MM/DD'), TO_DATE('23/06/01', 'YY/MM/DD'), NULL, NULL, 'PMS00901', 'PMS00603', 70, 'PMS01103', 'PMS01003', 'Y', 1, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F017', '기능17', '내용17', TO_DATE('23/07/15', 'YY/MM/DD'), TO_DATE('23/08/01', 'YY/MM/DD'), NULL, NULL, 'PMS00902', 'PMS00604', 40, 'PMS01104', 'PMS01004', 'Y', 2, 1, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F018', '기능18', '내용18', TO_DATE('23/09/15', 'YY/MM/DD'), TO_DATE('23/10/01', 'YY/MM/DD'), NULL, NULL, 'PMS00903', 'PMS00605', 30, 'PMS01105', 'PMS01005', 'Y', 3, 2, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F019', '기능19', '내용19', TO_DATE('23/11/15', 'YY/MM/DD'), TO_DATE('23/12/01', 'YY/MM/DD'), NULL, NULL, 'PMS00904', 'PMS00601', 50, 'PMS01101', 'PMS01001', 'Y', 4, 3, 1, 1);

INSERT INTO FEATURE (FEAT_NO, FEAT_ID, FEAT_TITLE, FEAT_CONT, PRE_ST_DT, PRE_END_DT, ST_DT, END_DT, STAT_CD, PRI_CD, PRG, DIFF_CD, CLASS_CD, USE_YN, SYS_NO, MEM_NO, TM_NO, PRJ_NO)
VALUES (seq_feature.nextval, 'F020', '기능20', '내용20', TO_DATE('24/01/15', 'YY/MM/DD'), TO_DATE('24/02/01', 'YY/MM/DD'), NULL, NULL, 'PMS00905', 'PMS00602', 90, 'PMS01102', 'PMS01002', 'Y', 5, 2, 1, 1);

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
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_01', '고우선순위 위험', 'PMS00302', 'PMS00501', 'PMS00402', 'PMS00601', '데이터 유출 가능성', '데이터 보안을 강화하여 유출 방지', null, null, 1, 1, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_02', '시스템 장애 위험', 'PMS00302', 'PMS00502', 'PMS00401', 'PMS00602', '시스템 부하로 인해 장애 발생 가능성', '부하 분산을 통해 시스템 안정성 확보', null, null, 1, 2, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_03', '데이터 손실 위험', 'PMS00302', 'PMS00503', 'PMS00403', 'PMS00603', '데이터 백업 실패로 인한 손실 가능성', '주기적인 백업 점검', null, null, 1, 3, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_04', '네트워크 다운 위험', 'PMS00302', 'PMS00501', 'PMS00402', 'PMS00601', '네트워크 연결 장애 발생 가능성', '다중 네트워크 경로 확보', null, null, 1, 4, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_05', '무단 접근 위험', 'PMS00302', 'PMS00502', 'PMS00403', 'PMS00602', '비인가 사용자의 무단 접근', '접근 제어 강화 및 이중 인증 도입', null, null, 1, 5, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_06', '시스템 과부하', 'PMS00302', 'PMS00503', 'PMS00404', 'PMS00604', '과도한 트래픽으로 인한 시스템 불안정', '부하 분산 시스템 적용', null, null, 1, 6, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_07', '설정 오류', 'PMS00302', 'PMS00501', 'PMS00401', 'PMS00601', '잘못된 설정으로 인한 운영 장애', '정기적인 설정 검토 및 문서화', null, null, 1, 1, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_08', '하드웨어 장애', 'PMS00302', 'PMS00502', 'PMS00402', 'PMS00602', '하드웨어 고장으로 인한 서비스 중단', '예비 하드웨어 확보 및 교체 주기 관리', null, null, 1, 2, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_09', '소프트웨어 버그', 'PMS00302', 'PMS00503', 'PMS00403', 'PMS00603', '버그로 인한 서비스 품질 저하', '버그 수정 및 테스트 강화', null, null, 1, 3, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_10', '데이터 유실', 'PMS00302', 'PMS00501', 'PMS00404', 'PMS00604', '데이터 저장 실패로 인한 유실', '저장 시스템 점검 및 모니터링 강화', null, null, 1, 4, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_11', '보안 취약점', 'PMS00302', 'PMS00502', 'PMS00402', 'PMS00601', '보안 취약점으로 인한 외부 침입 가능성', '보안 패치 및 방화벽 강화', null, null, 1, 5, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_12', '치명적 오류', 'PMS00302', 'PMS00503', 'PMS00401', 'PMS00602', '오류로 인한 시스템 다운타임 발생', '오류 관리 프로세스 개선', null, null, 1, 6, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_13', '운영 리스크', 'PMS00302', 'PMS00501', 'PMS00403', 'PMS00603', '운영상의 예기치 못한 상황', '위험 평가 및 대응 계획 수립', null, null, 1, 7, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_14', '성능 저하', 'PMS00302', 'PMS00502', 'PMS00404', 'PMS00604', '성능 저하로 인한 사용자 불만 증가', '성능 모니터링 시스템 구축', null, null, 1, 1, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_15', '자원 부족', 'PMS00302', 'PMS00503', 'PMS00402', 'PMS00601', '서버 자원 부족으로 인한 서비스 지연', '자원 관리 계획 수립', null, null, 1, 2, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_16', '유지보수 지연', 'PMS00302', 'PMS00501', 'PMS00401', 'PMS00602', '유지보수가 지연될 가능성', '정기 유지보수 일정 관리', null, null, 1, 3, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_17', '시스템 통합 문제', 'PMS00302', 'PMS00502', 'PMS00403', 'PMS00603', '통합 과정에서의 호환성 문제', '시스템 통합 테스트 강화', null, null, 1, 4, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_18', '프로젝트 지연', 'PMS00302', 'PMS00503', 'PMS00402', 'PMS00604', '프로젝트 완료 시점 지연 가능성', '일정 관리 및 자원 배분 개선', null, null, 1, 5, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_19', '예산 초과', 'PMS00302', 'PMS00501', 'PMS00401', 'PMS00601', '예산을 초과하여 비용 부담 증가', '비용 절감 방안 모색', null, null, 1, 6, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_20', '범위 확장', 'PMS00302', 'PMS00502', 'PMS00403', 'PMS00602', '계획 범위 이상의 요구사항 추가', '범위 관리 프로세스 개선', null, null, 1, 7, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_21', '품질 저하', 'PMS00302', 'PMS00503', 'PMS00402', 'PMS00603', '품질 관리 부재로 인한 불만', '품질 관리 프로세스 강화', null, null, 1, 1, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_22', '고객 불만', 'PMS00302', 'PMS00501', 'PMS00404', 'PMS00604', '고객 만족도 저하 가능성', '고객 피드백 반영 시스템 마련', null, null, 1, 2, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_23', '기술적 위험', 'PMS00302', 'PMS00502', 'PMS00402', 'PMS00601', '기술 부족으로 인한 프로젝트 리스크', '기술 교육 및 개발자 역량 강화', null, null, 1, 3, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_24', '환경적 위험', 'PMS00302', 'PMS00503', 'PMS00401', 'PMS00602', '외부 환경 변화로 인한 프로젝트 리스크', '환경 변화 대응 계획 수립', null, null, 1, 4, 2, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_25', '재정적 위험', 'PMS00302', 'PMS00501', 'PMS00403', 'PMS00603', '재정 부족으로 인한 프로젝트 지연', '재정 관리 및 자원 확보 방안 마련', null, null, 1, 5, 1, null, null);
INSERT INTO RISK VALUES(SEQ_RISK.nextval, 'PMS_RSK_26', '인력 부족 위험', 'PMS00302', 'PMS00502', 'PMS00404', 'PMS00604', '인력 부족으로 인한 일정 지연', '인력 계획 수립 및 채용 강화', null, null, 1, 6, 2, null, null);
COMMIT;
