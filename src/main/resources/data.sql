DROP TABLE TestDetail;
DROP TABLE TestMaster;
DROP TABLE Feature;
DROP TABLE System;
DROP TABLE CodeDetail;
DROP TABLE CommonCode;
DROP TABLE ProjectMember;
DROP TABLE Project;
DROP TABLE Team;
DROP TABLE Member;
DROP TABLE UserGroup;

DROP SEQUENCE seq_project;
DROP SEQUENCE seq_team;
DROP SEQUENCE seq_member;
DROP SEQUENCE seq_usergroup;
DROP SEQUENCE seq_system;
DROP SEQUENCE seq_feature;
DROP SEQUENCE seq_commoncode;
DROP SEQUENCE seq_codedetail;
DROP SEQUENCE seq_testmaster;
DROP SEQUENCE seq_testdetail;

----------------------------------------------------------------------------------------------------------------------
-- CREATE TABLE
CREATE TABLE UserGroup (
    grp_no number NOT NULL,
    grp_nm VARCHAR2(20) NOT NULL,
    par_grp_no NUMBER NULL
);

CREATE TABLE Member (
    mem_no number NOT NULL,
    grp_no NUMBER NULL,
    login_id VARCHAR2(20) NOT NULL,
    pw VARCHAR2(30) NOT NULL,
    mem_nm VARCHAR2(10) NOT NULL,
    phone_no VARCHAR2(15) NOT NULL,
    email VARCHAR2(40) NOT NULL,
    auth_cd CHAR(8) NOT NULL,
    pos_nm VARCHAR2(8) NULL,
    birth_dt VARCHAR2(10) NULL,
    tech_grd_cd CHAR(8) NULL,
    org VARCHAR2(20) NULL,
    use_yn VARCHAR2(1) NOT NULL,
    rec_prj NUMBER NULL
);

CREATE TABLE team (
    tm_no number NOT NULL,
    tm_nm VARCHAR2(200) NOT NULL,
    tm_cont VARCHAR2(200) NULL,
    use_yn VARCHAR2(1) NOT NULL,
    par_tm_no NUMBER NULL,
    prj_no NUMBER NOT NULL,
    sys_no NUMBER NULL,
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(200) NULL,
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
    reg_id VARCHAR2(100) NOT NULL,
    reg_dt DATE NOT NULL,
    mod_id VARCHAR2(200) NULL,
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
    mod_id VARCHAR2(200) NULL,
    mod_dt DATE NULL
);

CREATE TABLE System (
    sys_no number NOT NULL,
    sys_ttl	VARCHAR2(100) NOT NULL,
    sys_cont VARCHAR2(1000) NOT NULL,
    use_yn VARCHAR2(1) NOT NULL,
    prj_no NUMBER NOT NULL,
    par_sys_no NUMBER NULL
);

CREATE TABLE Feature
(
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
    use_yn VARCHAR2(1) NOT NULL,
    sys_no NUMBER NULL,
    mem_no NUMBER NOT NULL,
    tm_no NUMBER NOT NULL,
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
    use_yn VARCHAR2(1) NOT NULL
);

CREATE TABLE TestMaster (
    test_no	number NOT NULL,
    test_title VARCHAR2(200) NOT NULL,
    test_cont VARCHAR2(100) NOT NULL,
    stat_cd	CHAR(8) NOT NULL,
    type_cd	CHAR(8) NOT NULL,
    class_cd CHAR(8) NOT NULL,
    prj_no NUMBER NOT NULL,
    test_st_dt DATE NULL,
    test_end_dt	DATE NULL,
    created_date DATE NOT NULL
);

CREATE TABLE TestDetail (
    test_dtl_no	number NOT NULL,
    test_dtl_id	VARCHAR2(20) NOT NULL,
    wrk_proc_dtl VARCHAR2(1000) NULL,
    test_data VARCHAR2(1000) NULL,
    prd VARCHAR2(1000)	NULL,
    test_cont VARCHAR2(1000) NULL,
    test_no	NUMBER	NOT NULL,
    par_test_dtl_no	NUMBER NULL,
    test_st_dt DATE	NULL,
    test_result_cd CHAR(8) NULL,
    mem_no NUMBER	NULL,
    pre_cond VARCHAR2(1000)	NULL,
    note VARCHAR2(1000)	NULL,
    sys_no NUMBER NOT NULL,
    sys_work_no NUMBER NOT NULL
);

----------------------------------------------------------------------------------------------------------------------
-- SEQUENCE
CREATE SEQUENCE seq_usergroup START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_member START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_team START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_project START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_system START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_feature START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_commoncode START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_codedetail START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_testmaster START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_testdetail START WITH 1 INCREMENT BY 1;
----------------------------------------------------------------------------------------------------------------------
-- ALTER TABLE
ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (mem_no);
ALTER TABLE UserGroup ADD CONSTRAINT PK_GROUP PRIMARY KEY (grp_no);
ALTER TABLE ProjectMember ADD CONSTRAINT PK_PROJECTMEMBER PRIMARY KEY (mem_no, tm_no, prj_no);
ALTER TABLE Team ADD CONSTRAINT PK_TEAM PRIMARY KEY (tm_no);

ALTER TABLE Project ADD CONSTRAINT PK_PROJECT PRIMARY KEY (prj_no);

ALTER TABLE System ADD CONSTRAINT pk_sys_no_001 PRIMARY KEY (sys_no);
ALTER TABLE System ADD CONSTRAINT fk_prj_no_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);
ALTER TABLE System ADD CONSTRAINT fk_par_sys_no_003 FOREIGN KEY (par_sys_no) REFERENCES System (sys_no);

ALTER TABLE Feature ADD CONSTRAINT pk_feat_no_001 PRIMARY KEY (feat_no);
ALTER TABLE Feature ADD CONSTRAINT fk_sys_no_002 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE Feature ADD CONSTRAINT fk_mem_no_003 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE Feature ADD CONSTRAINT fk_tm_no_004 FOREIGN KEY (tm_no) REFERENCES Team (tm_no);
ALTER TABLE Feature ADD CONSTRAINT fk_prj_no_005 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);

ALTER TABLE CommonCode ADD CONSTRAINT PK_COMMONCODE PRIMARY KEY (common_cd_no);
ALTER TABLE CodeDetail ADD CONSTRAINT PK_CODEDETAIL PRIMARY KEY (cd_dtl_no);
ALTER TABLE CodeDetail ADD CONSTRAINT FK_CommonCode_TO_CodeDetail FOREIGN KEY (common_cd_no) REFERENCES CommonCode (common_cd_no);

ALTER TABLE TestMaster ADD CONSTRAINT pk_tes_no_001 PRIMARY KEY (test_no);
ALTER TABLE TestMaster ADD CONSTRAINT fk_prj_no_tm_002 FOREIGN KEY (prj_no) REFERENCES Project (prj_no);

ALTER TABLE TestDetail ADD CONSTRAINT pk_tes_dtl_no_001 PRIMARY KEY (test_dtl_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_tes_no_002 FOREIGN KEY (test_no) REFERENCES TestMaster (test_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_test_dtl_no_003 FOREIGN KEY (par_test_dtl_no) REFERENCES TestDetail (test_dtl_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_mem_no_004 FOREIGN KEY (mem_no) REFERENCES Member (mem_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_sys_no_005 FOREIGN KEY (sys_no) REFERENCES System (sys_no);
ALTER TABLE TestDetail ADD CONSTRAINT fk_sys_work_no_006 FOREIGN KEY (sys_work_no) REFERENCES System (sys_no);
----------------------------------------------------------------------------------------------------------------------
-- INDEX
----------------------------------------------------------------------------------------------------------------------
-- INSERT
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (1, '공공', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (2, 'SI', 1);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (3, 'SI 1팀', 2);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (4, 'SI 2팀', 2);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (5, '금융', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (6, 'RDD', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (7, '신사업', NULL);
INSERT INTO UserGroup (grp_no, grp_nm, par_grp_no) VALUES (8, '클라우드', NULL);

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

INSERT INTO CodeDetail VALUES ('PMS00101', 'PMS001', '대기', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00102', 'PMS001', '진행중', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00103', 'PMS001', '완료', 3, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00201', 'PMS002', 'PM', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00202', 'PMS002', 'PL', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00203', 'PMS002', '팀원', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00204', 'PMS002', '사업관리자', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00205', 'PMS002', '고객', 5, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00301', 'PMS003', '위험', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00302', 'PMS003', '이슈', 2, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00401', 'PMS004', '발생전', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00402', 'PMS004', '진행중', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00403', 'PMS004', '조치완료', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00404', 'PMS004', '취소', 4, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00501', 'PMS005', '고객변심', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00502', 'PMS005', '일정지연', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00503', 'PMS005', '품질문제', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00504', 'PMS005', '인력관련', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00505', 'PMS005', '규정관련', 5, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00601', 'PMS006', '즉시', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00602', 'PMS006', '긴급', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00603', 'PMS006', '높음', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00604', 'PMS006', '보통', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00605', 'PMS006', '낮음', 5, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00701', 'PMS007', '신규', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00702', 'PMS007', '진행중', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00703', 'PMS007', '해결', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00704', 'PMS007', '취소', 4, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00801', 'PMS008', '테스트결함', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00802', 'PMS008', '일반결함', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00803', 'PMS008', '기타결함', 3, 'Y');

INSERT INTO CodeDetail VALUES ('PMS00901', 'PMS009', '신규', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00902', 'PMS009', '개발중', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00903', 'PMS009', '개발완료', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00904', 'PMS009', '단위테스트완료', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00905', 'PMS009', 'PL확인', 5, 'Y');
INSERT INTO CodeDetail VALUES ('PMS00906', 'PMS009', '고객확인', 6, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01001', 'PMS010', '화면', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01002', 'PMS010', '인터페이스', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01003', 'PMS010', '프로그램', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01004', 'PMS010', '보고서', 4, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01101', 'PMS011', '매우높음', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01102', 'PMS011', '높음', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01103', 'PMS011', '보통', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01104', 'PMS011', '낮음', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01105', 'PMS011', '매우낮음', 5, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01201', 'PMS012', '단위', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01202', 'PMS012', '통합', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01203', 'PMS012', '사용자', 3, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01301', 'PMS013', '진행전', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01302', 'PMS013', '진행중', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01303', 'PMS013', '결함발생', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01304', 'PMS013', '진행완료', 4, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01401', 'PMS014', '통과', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01402', 'PMS014', '실패', 2, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01501', 'PMS015', '특급', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01502', 'PMS015', '고급', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01503', 'PMS015', '중급', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01504', 'PMS015', '초급', 4, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01601', 'PMS016', '발견첨부', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01602', 'PMS016', '조치첨부', 2, 'Y');

INSERT INTO CodeDetail VALUES ('PMS01701', 'PMS017', '부장', 1, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01702', 'PMS017', '차장', 2, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01703', 'PMS017', '과장', 3, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01704', 'PMS017', '대리', 4, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01705', 'PMS017', '주임', 5, 'Y');
INSERT INTO CodeDetail VALUES ('PMS01706', 'PMS017', '사원', 6, 'Y');

INSERT INTO Member (mem_no, grp_no, login_id, pw, mem_nm, phone_no, email, auth_cd, pos_nm, birth_dt, tech_grd_cd, org, use_yn, rec_prj)
VALUES (1, 3, 'user1', 'pw1', '홍길동', '010-1234-5678', 'hong@example.com', 'PMS01501', 'PMS01706', '1990-01-01', 'PMS01503', '공공', 'Y', NULL);

INSERT INTO project (prj_no, prj_title, prj_cont, stat_cd, prg, org, pre_st_dt, pre_end_dt, st_dt, end_dt, use_yn, reg_id, reg_dt, mod_dt)
VALUES (1, '프로젝트1', '프로젝트1 내용', 'PMS00101', 0, '공공', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', '2021-01-01');

INSERT INTO team (tm_no, tm_nm, tm_cont, use_yn, par_tm_no, prj_no, sys_no, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, '팀1', '팀1 내용', 'Y', NULL, 1, NULL, 'user1', '2021-01-01', NULL, NULL);

INSERT INTO projectMember (mem_no, tm_no, prj_no, prj_auth_cd, pre_start_dt, pre_end_dt, start_dt, end_dt, use_yn, reg_id, reg_dt, mod_id, mod_dt)
VALUES (1, 1, 1, 'PMS00203', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'Y', 'user1', '2021-01-01', NULL, NULL);

INSERT INTO System (sys_no, sys_ttl, sys_cont, use_yn, prj_no, par_sys_no)
VALUES (1, 'A 업무 시스템', '시스템1 내용', 'Y', 1, NULL);

INSERT INTO Feature (feat_no, feat_id, feat_title, feat_cont, pre_st_dt, pre_end_dt, st_dt, end_dt, stat_cd, pri_cd, prg, diff_cd, use_yn, sys_no, mem_no, tm_no, prj_no)
VALUES (1, 'F001', '기능1', '기능1 내용', '2021-01-01', '2021-01-01', '2021-01-01', '2021-01-01', 'PMS00901', 'PMS00603', 0, 'PMS01103', 'Y', 1, 1, 1, 1);

INSERT INTO TestMaster (test_no, test_title, test_cont, stat_cd, type_cd, class_cd, prj_no, test_st_dt, test_end_dt, created_date)
VALUES (1, '테스트1', '테스트1 내용', '001', '001', '001', 1, '2021-01-01', '2021-01-01', '2021-01-01');

INSERT INTO TestDetail (test_dtl_no, test_dtl_id, wrk_proc_dtl, test_data, prd, test_cont, test_no, test_st_dt, test_result_cd, mem_no, pre_cond, note, sys_no, sys_work_no)
VALUES (1, 'TD001', '작업절차1', '테스트데이터1', '제품1', '테스트내용1', 1, '2021-01-01', '001', 1, '사전조건1', '비고1', 1, 1);

-----------------------------------------------------------------------------------------------------------------
COMMIT;
