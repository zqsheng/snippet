
-- ATTENDANCE 考勤

DESC CAM_ATTENDANCE;

SELECT T.* FROM PINSTANCE.CAM_ATTENDANCE T WHERE STAFFNAME = "林立" AND CHECK_TYPE = "CHECK_IN";

SELECT T.* FROM PINSTANCE.CAM_ATTENDANCE T WHERE CHECK_TIME IS NOT NULL ORDER BY CHECK_TIME DESC; 

SELECT T.* FROM PINSTANCE.CAM_ATTENDANCE T WHERE DATE_FORMAT(T.CHECK_TIME, '%Y-%m-%d') = '2018-11-27'; 

SELECT DATE_FORMAT(T.CHECK_TIME,'%Y-%m-%d') FROM PINSTANCE.CAM_ATTENDANCE T;
-- 昨天的记录
SELECT T.* FROM PINSTANCE.CAM_ATTENDANCE T WHERE TO_DAYS(NOW()) -  TO_DAYS(T.CALCULATETIME) <= 1 AND STAFFNAME = '林俊存' ORDER BY CALCULATETIME DESC;

DELETE FROM PINSTANCE.CAM_ATTENDANCE WHERE TO_DAYS(NOW()) -  TO_DAYS(CALCULATETIME) <= 1 AND STAFFNAME = '林立' ORDER BY CALCULATETIME DESC LIMIT 1;

DELETE  FROM PINSTANCE.CAM_ATTENDANCE WHERE CALCULATETIME > NOW();

SELECT CURDATE();

SELECT TO_DAYS(NOW());

SELECT DATE_FORMAT(NOW(),'%Y-%m-%d');

SELECT MIN(WORK_DATE) FROM PINSTANCE.CAM_ATTENDANCE;

SELECT T.* FROM PINSTANCE.CAM_ATTENDANCE_HIS T ORDER BY CHECK_TIME;
USE DINSTANCE;
-- 请假
USE MENGKUANG2;
DESC CAM_LEAVE_REQ;
SELECT HEX(L.RECID),S.NAME,L.* FROM CAM_LEAVE_REQ L  LEFT JOIN CAM_STAFF S ON S.RECID = L.STAFF WHERE S.NAME = '任爽' ORDER BY REQ_TIME DESC ; -- (L.DAYS = 0 OR L.DAYS IS NULL) AND L.HOURS <= 10 AND   -- STAFF = 0x5676179E8BBEF49EACC07BE128631BB1;
SELECT HEX(L.RECID),L.* FROM CAM_LEAVE_REQ L ORDER BY L.REQ_TIME DESC;--  LEFT JOIN CAM_STAFF S ON S.RECID = L.STAFF WHERE S.NAME = '柳明扬' ORDER BY REQ_TIME DESC ; -- (L.DAYS = 0 OR L.DAYS IS NULL) AND L.HOURS <= 10 AND   -- STAFF = 0x5676179E8BBEF49EACC07BE128631BB1;
SELECT * FROM CAM_STAFF_ANNUALLEAVE L LEFT JOIN CAM_STAFF S ON S.RECID = L.STAFF WHERE S.NAME = '任爽';
UPDATE CAM_LEAVE_REQ SET HOURS = 0 WHERE DAYS > 0 AND HOURS >= 10 AND TENANT = 0x6164F486C0000021F32DE3E7D06CCA9C;

UPDATE  CAM_LEAVE_REQ SET HOURS = 8 WHERE RECID = 0x67A03633A00000810BA4C61E9C925B96; 
USE INST1;

SELECT 
    HEX(A.RECID),A.*
FROM
    CAM_LEAVE_REQ A
        LEFT JOIN
    CAM_TENANT T ON T.RECID = A.TENANT
        LEFT JOIN
    CAM_STAFF S ON A.STAFF = S.RECID
WHERE
    S.NAME = '何延林';
    
DESC CAM_LEAVE_REQ;
DESC CAM_STAFF_ANNUALLEAVE;
UPDATE CAM_LEAVE_REQ SET LEAVESTAFF=STAFF WHERE LEAVESTAFF IS NULL;
DELETE FROM CAM_LEAVE_REQ WHERE RECID = 0x695614BC600009C1BB4E9D49594F0D8A;
DESC CAM_LEAVE_CLASSES;
use mengkuang2;
use inst1;
SELECT S.NAME,HEX(L.RECID),HEX(LEAVE_1),L.* FROM CAM_LEAVE_CLASSES L LEFT JOIN CAM_STAFF S ON S.RECID = L.STAFF  WHERE S.NAME = '何延林' ;
SELECT COUNT(*) FROM CAM_LEAVE_CLASSES;--  L LEFT JOIN CAM_STAFF S ON S.RECID = L.STAFF ;
DELETE FROM CAM_LEAVE_CLASSES WHERE RECID = 0x697ABCD0600002616F71CF16B1401921;
SELECT R.* FROM CAM_LEAVE_REQ R WHERE R.RECID  = 0x697EFC9D000000614016DB2DC4FC9216;
SELECT R.* FROM CAM_LEAVE_REQ R LEFT JOIN CAM_LEAVE_CLASSES  C ON R.RECID = C.LEAVE_1 LEFT JOIN CAM_STAFF S ON R.LEAVESTAFF = S.RECID WHERE S.NAME = '何延林' ;  
DELETE FROM CAM_LEAVE_CLASSES;
UPDATE CAM_LEAVE_CLASSES SET YEAR = 2019,LEAVETYPE = 0x51F0B4D3DB3397BC3B1CD82F4CC189A6;
SELECT HEX(LT.RECID),LT.* FROM CAM_LEAVE_TYPE LT LEFT JOIN  CAM_TENANT T ON T.RECID = LT.TENANT WHERE T.NAME LIKE '%中国黄金%' AND LT.NAME = '年休假';
SELECT 
    A.*
FROM
    PINSTANCE.CAM_ATTENDANCE_HIS A
        LEFT JOIN
    CAM_TENANT T ON A.TENANT = T.RECID
        LEFT JOIN
    CAM_STAFF S ON S.RECID = A.STAFF
WHERE
    DATE_FORMAT(WORK_DATE, '%Y-%m-%d') = '2017-11-30'
        AND T.NAME = '孙建卫'
        AND S.NAME = '林立'
ORDER BY A.WORK_DATE DESC;

-- CHECK RECORD 打卡
use inst1;

DESC PINSTANCE.CAM_CHECK;

USE mengkuang2;

SELECT S.NAME,HEX(C.RECID),C.* FROM CAM_CHECK C LEFT JOIN CAM_STAFF S ON S.RECID = C.STAFF WHERE NAME = '石玉君' ORDER BY CHECK_TIME DESC  LIMIT 10;
SELECT S.NAME,HEX(C.RECID),C.* FROM CAM_CHECK C LEFT JOIN CAM_STAFF S ON S.RECID = C.STAFF WHERE NAME = '宋学亮' AND TO_DAYS(C.CHECK_TIME) = TO_DAYS('2019-03-05 8:01:00') ORDER BY CHECK_TIME DESC  LIMIT 10;

DELETE  FROM CAM_CHECK WHERE RECID IN (SELECT C.RECID FROM CAM_CHECK C LEFT JOIN CAM_STAFF S ON S.RECID = C.STAFF WHERE NAME = '公司公司公司' AND TO_DAYS(C.CHECK_TIME) - TO_DAYS(NOW()) = 0 ORDER BY CHECK_TIME) ;

SELECT C.RECID FROM CAM_CHECK C LEFT JOIN CAM_STAFF S ON S.RECID = C.STAFF WHERE NAME = '公司公司公司' AND TO_DAYS(C.CHECK_TIME) - TO_DAYS(NOW()) = 0 ORDER BY CHECK_TIME;

DELETE FROM CAM_CHECK WHERE RECID IN (0x696C1A5B80000021CCEF841F9C611B05);-- ,0x6909BB4240000021E05A3AC8A0775282,0x6909AC0A40000021545D1BEECA682BC7,0x69097F60000000216333DEE0022E6D82);
-- 子查询删除
DELETE FROM CAM_CHECK 
WHERE
    RECID IN (SELECT 
        N.RECID
    FROM
        (SELECT 
            S.RECID
        FROM
            CAM_CHECK AS C
        LEFT JOIN CAM_STAFF AS S ON S.RECID = C.STAFF
        
        WHERE
            S.NAME = '蔡普敏'
            AND TO_DAYS(C.CHECK_TIME) = TO_DAYS('2019-03-05 8:08:56')) AS N); -- 更新和删除不能同时对一张表进行处理，这里采用临时表的编码处理，执行时间过长，容易导致丢失连接 
        
SELECT 
	S.RECID
FROM
	CAM_CHECK C
		LEFT JOIN
	CAM_STAFF S ON S.RECID = C.STAFF
WHERE
	S.NAME = '蔡普敏' AND TO_DAYS(C.CHECK_TIME) = TO_DAYS('2019-03-05 8:08:56') ;     
DELETE FROM CAM_CHECK WHERE TURNNAME = '测试' OR TURNNAME = 'JIABAN';

UPDATE CAM_CHECK SET CHECK_TIME = '2019-03-10 19:56:16',CHECK_TYPE = 'CHECK_IN' WHERE RECID = 0x6955A3F3600000212F6E7C0588872A43;
-- 值班记录
use mengkuang;
SELECT HEX(O.RECID),S.NAME,FROM_UNIXTIME(O.STARTTIME / 1000 ),FROM_UNIXTIME(O.FINISHTIME / 1000) FROM CAM_ONDUTYRECORD O LEFT JOIN CAM_STAFF S ON S.RECID = O.STAFF WHERE O.STARTTIME >= O.FINISHTIME;

UPDATE CAM_ONDUTYRECORD SET STARTTIME = 1000 * UNIX_TIMESTAMP('2019-02-24 16:44:34'),FINISHTIME = 1000 * UNIX_TIMESTAMP('2019-02-24 23:5:58') WHERE RECID = 0x6955A3F3600000212F6E7C0588872A43;
SELECT HEX(STAFF) FROM CAM_ONDUTYRECORD  O WHERE O.STARTTIME > 1550764800000 AND O.FINISHTIME < 1550851199999;
DELETE FROM CAM_ONDUTYRECORD;
DESC CAM_ONDUTYRECORD;
SELECT HEX(STAFF),HEX(TENANT),TYPE FROM CAM_ONDUTYRECORD ;
INSERT CAM_ONDUTYRECORD(RECID,STAFF,TENANT,STARTTIME,FINISHTIME,TYPE) VALUES(0x3C5FEE35600000218BF9C5D7B5D3524E,0x2E727D1A47C25E0326CC538E8C2D7710,0x6955A3F3600000212F6E7C0588872A43,1000 * UNIX_TIMESTAMP('2019-02-26 16:44:34'),1000 * UNIX_TIMESTAMP('2019-02-27 23:44:34'),2);
-- 加班
DESC CAM_EXTWORK;
SELECT E.CREATORNAME,E.DEPTNAME, FROM_UNIXTIME(E.STARTTIME / 1000),FROM_UNIXTIME(E.FINISHTIME / 1000),FROM_UNIXTIME(E.CREATETIME / 1000 ) FROM CAM_EXTWORK E LEFT JOIN CAM_STAFF S ON S.RECID = E.CREATOR WHERE S.NAME = '宋学亮';

-- 出差

SELECT * FROM CAM_BUSITRAVEL ;-- WHERE STAFF = 0xA9DB04947614BC0FD95810A58456D50B;
SELECT * FROM CAM_BUSITRAVEL B RIGHT JOIN  CAM_BUSITRAVEL_STAFF BS ON BS.BUSIID = B.RECID WHERE STAFFID = 0xA9DB04947614BC0FD95810A58456D50B;

-- 租户 
USE MINSTANCE;

DESC CAM_TENANT;

SELECT HEX(T.RECID),T.* FROM CAM_TENANT T  WHERE T.NAME LIKE '中国黄金%';

 -- OR RECID = 0x3C5FEE35600000218BF9C5D7B5D3524E;

SELECT HEX(T.RECID),T.* FROM PINSTANCE.CAM_TENANT T  WHERE T.RECID = 0x3C5FEE35600000218BF9C5D7B5D3524E;


-- 员工
USE INSTANCE;

DESC CAM_STAFF;

SELECT HEX(S.RECID),S.* FROM CAM_STAFF S LEFT JOIN CAM_TENANT T ON T.RECID = S.TENANT WHERE   T.NAME LIKE '孙建卫%'  AND FINISH_TIME = '3000-01-01 00:00:00';

SELECT S.EMAIL FROM CAM_STAFF S WHERE S.EMAIL IS NOT NULL AND  TENANT = 0x3C5FEE35600000218BF9C5D7B5D3524E AND FINISH_TIME = '3000-01-01 00:00:00' AND S.EMAIL NOT LIKE '%@%';

SELECT COUNT(*) FROM CAM_STAFF S WHERE S.EMAIL IS  NULL AND  TENANT = 0x3C5FEE35600000218BF9C5D7B5D3524E AND FINISH_TIME = '3000-01-01 00:00:00';

SELECT HEX(S.RECID),HEX(S.TENANT),S.FINISH_TIME,S.NAME,S.CELLPHONE FROM CAM_STAFF S WHERE S.NAME = "张启生";-- S.RECID = 0x5EA5653C25706F316F87F8C9DE9EEED1 OR NAME = '诸葛亮';

SELECT HEX(S.RECID),HEX(S.TENANT),S.FINISH_TIME,S.NAME,S.CELLPHONE FROM CAM_STAFF S WHERE S.RECID = 0x3C38271E80000021887021B0852BE5CA;

-- 部门
SELECT * FROM CAM_DEPT;

SELECT HEX(DEPT) FROM cam_dept_am;

SELECT HEX(D.DEPT),D.* FROM cam_dept_m  D WHERE NAME LIKE '久其融通';

SELECT * FROM cam_dept_am;

SELECT * FROM cam_dept;

SELECT * FROM cam_dept_mgr WHERE STAFF = 0x5EA5653C25706F316F87F8C9DE9EEED1;

SELECT HEX(S.RECID),S.* FROM CAM_STAFF S WHERE email = "lyhui@jiuqi.com.cn" OR CELLPHONE = "15652241205";

SELECT * FROM CAM_STAFF S WHERE RECID = 0x67C5B11620000021955E497CA6F22434;

SELECT COUNT(*) FROM CAM_STAFF S LEFT JOIN CAM_TENANT T ON T.RECID = S.TENANT  WHERE S.EMAIL IS NULL AND T.NAME LIKE '北京久其%';

-- 单据定义

DESC INSTANCE.CAM_CUSTOMFORM_DEFINITION;


-- 常用功能

DESC PINSTANCE.CAM_COMMONFUNCTION;

SELECT * FROM INST_JKS.CAM_COMMONFUNCTION ;

SELECT * FROM INST_JKS.CAM_COMMONFUNCTION_BD;
-- 复制表(备份)
CREATE TABLE INST_JKS.CAM_COMMONFUNCTION_BD SELECT * FROM INST_JKS.CAM_COMMONFUNCTION;

UPDATE CAM_COMMONFUNCTION  SET FUNCTIONTYPE = 0;
-- 复制列
UPDATE CAM_COMMONFUNCTION SET FUNCTIONID = UNUSED_FUNCTIONID;

-- 音视频
USE MASTER;

DESC CAM_ZOOMUSER;

DELETE FROM CAM_ZOOMUSER;

SELECT HEX(Z.CREATOR),HEX(Z.TENANT),HEX(Z.RECID),Z.* FROM MASTER.CAM_ZOOMUSER Z WHERE EMAIL like "liwenbao%" ;-- and Z.MARK <> 1 or CREATORNAME = '张启生'; 

UPDATE CAM_ZOOMUSER SET USERID = NULL WHERE RECID = 0x6811D48460000021EEA07103E0F6E911;

UPDATE CAM_ZOOMUSER SET INFORMSTATUS = 1;

ALTER TABLE CAM_ZOOMUSER DROP COLUMN TOKEN ,DROP COLUMN TENANTID;

SELECT HEX(Z.CREATOR) ,Z.EMAIL,S.NAME FROM MASTER.CAM_ZOOMUSER Z LEFT JOIN INSTANCE.CAM_STAFF S ON S.RECID = Z.CREATOR WHERE Z.CREATOR IS NOT NULL ;

DELETE FROM CAM_ZOOMUSER  WHERE CREATOR = 0x648C76968EF6F660018B6A791C26173D;  

SELECT HEX(T.RECID),T.* FROM CAM_AVMEETINGINFO T;

DELETE FROM CAM_AVMEETINGINFO;

UPDATE CAM_AVMEETINGINFO SET STATUS = 2;

SELECT * FROM CAM_AVMEETINGCUSTOMCONFIG;

-- Z0zDUnx1SvCZnZXJyWejxA 

-- cZUUougJnFMSzpzW1pQT7Cfki7f5rWMZsjxk 

-- 会议

USE PINSTANCE;
DESC CAM_MEETING;

SELECT HEX(M.RECID),HEX(ROOTID),M.STARTTIME,M.REMINDTIME,M.CHECKSTARTTIME,HEX(M.CONVENER),M.* FROM CAM_MEETING M ;--   WHERE TO_DAYS(FROM_UNIXTIME(M.STARTTIME)) = TO_DAYS(NOW())  ;-- WHERE TO_DAYS(M.STARTTIME) = TO_DAYS(NOW()) ;

SELECT HEX(M.RECID),HEX(ROOTID),M.STARTTIME,M.AMOUNT,M.* FROM CAM_MEETING M ;--   WHERE TO_DAYS(FROM_UNIXTIME(M.STARTTIME)) = TO_DAYS(NOW())  ;-- WHERE TO_DAYS(M.STARTTIME) = TO_DAYS(NOW()) ;

DELETE FROM CAM_MEETING;

-- 更新会议

UPDATE CAM_MEETING SET AUDITSTATUS = 0 ,CANCEL = FALSE WHERE RECID = 0x691D5B2640000E61E3B486E8C3B3905C;

SELECT COUNT(*) FROM CAM_MEETING M WHERE M.ROOTID = 0x684BF786C000002189C65C1CC4C1C566 and M.ENDTIME < 1547567999999;

ALTER TABLE CAM_MEETING DROP COLUMN CHECKLAT,DROP COLUMN CHECKLNG,DROP COLUMN CHECKRADIUS;

SELECT HEX(M.TENANT),M.* FROM CAM_MEETING M LEFT JOIN CAM_MEETMEMBER ME ON M.RECID = ME.MEETID WHERE ME.STAFF = 0x5186F66531C1A963C7E20A8B5BF65985;  

SELECT * from CAM_MEETING as t where t.TENANT = 0x3C5FEE35600000218BF9C5D7B5D3524E and  t.ROOMID is not null and t.STARTTIME > 1546272000000 and t.ENDTIME < 1548950399999;

SELECT * FROM CAM_MEETING  M WHERE  M.ROOMID IN (SELECT R.RECID FROM CAM_MEETINGROOM R WHERE R.NAME LIKE '%%' ) ;

UPDATE CAM_MEETING SET HOSTER = NULL;

SELECT * FROM CAM_MEET_COMPENSATE;

SELECT * FROM CAM_MEETCOST_TYPE;
-- 纪要
SELECT * FROM CAM_MEETSUMMARY;
-- 纪要记录
SELECT * FROM CAM_MEETSUMMARYRECORD;
-- 回复
SELECT HEX(T.RECID),HEX(T.MEETID),T.* FROM CAM_MEETREPLY T WHERE MEETID = 0x691978E8E000004168E5E8A33F7D425A;

DELETE FROM CAM_MEETREPLY;--  WHERE  MEETID = 0x691978E8E000004168E5E8A33F7D425A;
-- 成员
SELECT HEX(M.MEETID),HEX(M.STAFF),M.* FROM CAM_MEETMEMBER M ;-- WHERE M.MEETID = 0x682CA91DA0000041D6B16FD8C71E90DF;

DELETE FROM CAM_MEETMEMBER;

-- 会议室
SELECT HEX(M.RECID),M.*,T.NAME FROM CAM_MEETINGROOM  LEFT JOIN  CAM_TENANT T ON T.RECID = M.TENANT WHERE M.RECID = 0x5FD9F5376000000116814A01BC9F8A34 ; 

SELECT HEX(M.RECID),M.* FROM CAM_MEETINGROOM M;

UPDATE CAM_MEETINGROOM SET  DISCOUNT = 0.85,PRICE  = 300;

SELECT HEX(recid),m FROM CAM_MEETCOST_TYPE M LEFT JOIN  CAM_TENANT T ON T.RECID = M.TENANT;

SELECT * FROM CAM_MEETINGROOM_BOOKER;

SELECT * FROM CAM_MEETINGROOM_BOOKING;

SELECT COUNT(*) FROM CAM_MEETMEMBER WHERE TYPE = 1;

SELECT M.* FROM CAM_MEETING M LEFT JOIN CAM_MEETINGROOM_BOOKING B ON M.RECID = B.MEETING WHERE B.MEETING IS NOT NULL;

SELECT * FROM CAM_MEETINGROOM_FACILITY;

SELECT * FROM CAM_MEETINGROOM_RELATION;

-- 计价模式
SELECT * FROM CAM_MEETCOST_TYPE MT WHERE  MT.RECID = 0x67C5340020000081DCF137F0C40774E9;

-- 日程
USE INSTANCE;

SELECT HEX(A.RECID),HEX(A.ROOTID),A.* FROM CAM_AGENDA A ORDER BY A.STARTTIME;

DELETE FROM CAM_AGENDA;

UPDATE CAM_AGENDA SET REMINDSTATUS = 1 WHERE RECID = 0x6832BB36C0000001DF02B36CBE8E177A;

DELETE FROM CAM_AGENDA  ;-- WHERE RECID = 0x683714CB6000000179960AC5AEC09DC8 ;

SELECT * FROM CAM_AGENDA_STAFF;


SELECT * FROM CAM_MEET_COMPENSATE WHERE recid = 0x683CC32400004F815E332D70F78BE9B3;

-- 列选

SELECT HEX(C.STAFF),C.COLUMNS ,C.* FROM CAM_COLUMNSET C;

DELETE FROM CAM_COLUMNSET;

UPDATE CAM_COLUMNSET SET FUNCTIONS = 2;

-- 岗位变更记录

SELECT * FROM CAM_JOB_HISTORY J WHERE J.STAFF = 0x756116ED7F76F6FA3628985838177447 ;
DELETE FROM CAM_JOB_HISTORY  WHERE  STAFF = 0x0FDC4CC1D4DCA726970B1EB638D0C9B5;

select * from CAM_STAFF_ANNUALLEAVE as t where t.TENANT = 0x6164F486C0000021F32DE3E7D06CCA9C and t.STAFF = 0xE0AE7B089FEC694395E453AE6E9045F7 and t.LEAVEYEAR = 2019;
SELECT * FROM cam_schedule_apply WHERE CHANGESTAFF IS NULL;
DELETE FROM cam_schedule_apply WHERE CHANGESTAFF IS NULL;