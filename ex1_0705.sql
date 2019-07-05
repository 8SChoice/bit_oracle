desc user_constraints
/*
constraint_type : c:check, not null을 의미한다.
p:primary key, u: unique, r:reference, f:foreign key
*/
select constraint_name, constraint_type from user_constraints;

/*
2. 컬럼단위 제약조건
테이블을 생성할때 컬럼에 직접 제약조건을 명시하는 경우이다. not null 제약조건은 컬럼레벨에서만 정의할 수 있따.
3. 테이블 단위 제약조건
not null을 제외한 모든 제약조건을 명시할 수 있따.
*/
--column constraint.sql의 내용
--constraint 테이블명_컬럼_제약조건이름 제약조건 명시
create table colst(
bun number(3) constraint colst_bun_pk primary key,
name varchar2(10) constraint colst_name_nn not null,
age number(5) constraint colst_age_ck check(age>=20 and age<=30),
addr varchar2(50) default '서울시 마포구 신수동',
jumin varchar2(14) constraint colst_jumin_uq unique);
--제약조건
select constraint_name, CONSTRAINT_TYPE from user_constraints where table_name='COLST';

create table talst(
bun number(3),
name varchar2(10) constraint talst_name_nn not null,
age number(3),
addr varchar2(30) default '서울시 마포구',
jumin varchar2(14) constraint talst_jumin_nn not null,
constraint talst_bun_pk primary key(bun),
constraint talst_age_ch check(age>=20 and age<=30),
constraint talst_uq unique(jumin));

create table lib(
bun number(3),
book varchar2(20),
l_date date default sysdate,
constraint lib_bun_fk foreign key(bun) references talst(bun) on delete cascade);

select owner, r_owner, table_name, constraint_type, constraint_name
        from user_constraints
        where table_name in('LIB', 'TALST');

insert into talst values(10, '김길동', 30, '서울시 마포구', '111111-1234567');  
insert into talst values(20, '이춘자', 20, '서울시 마포구', '111111-2345267');  
insert into talst values(30, '임아영', 20, '인천시 남구', '111111-2536567');  
select * from talst;
delete FROM talst;
insert into lib values(10, '자바책', sysdate);
insert into lib values(20, '오라클책', sysdate);
select * from lib;
--on delete cascade 참조하고 있는 자식데이터도 함께 삭제되는 속성이다.
delete from talst where bun=10;
delete from lib;

--제약조건 삭제
alter table talst drop constraint talst_jumin_nn;

select owner, r_owner, table_name, constraint_type, constraint_name
        from user_constraints
        where table_name in('LIB', 'TALST');
        
--실습테이블 삭제
drop table talst CASCADE CONSTRAINTS;
drop table lib CASCADE CONSTRAINTS;
drop table gogek;
drop table sawon CASCADE CONSTRAINTS;
drop table dept;

create table dept(
deptno number(3),
dname varchar2(10),
loc varchar2(10));

create table sawon(
     sabun number(3), 
     saname varchar2(10), 
     deptno number(3), 
     sajob varchar2(10), 
     sapay number(10), 
     sahire date default sysdate, 
     sasex varchar2(6), 
     samgr number(3));
     
create table gogek(gobun number(3),
                  goname varchar2(10),
                  gotel varchar2(14),
                  gojumin varchar(14),
                  godam number(3));
                  
alter table dept add constraint dept_deptno_pk primary key(deptno);
alter table dept add constraint dept_dname_uq unique(dname);
alter table sawon add constraint sawon_sabun_pk primary key(sabun);
alter table sawon add constraint sawon_depto_fk foreign key(deptno) references dept(deptno) on delete cascade;
alter table sawon add constraint sawon_sasex_ck check(sasex='남자' or sasex='여자');
alter table sawon add constraint sawon_samgr_fk foreign key(samgr) references sawon(sabun) on delete cascade;
alter table gogek add constraint gogek_gobun_pk primary key(gobun);
alter table gogek add constraint gogek_gojumin_uq unique(gojumin);
alter table gogek add constraint gogek_goda_fk foreign key(godam) references sawon(sabun) on delete cascade;


