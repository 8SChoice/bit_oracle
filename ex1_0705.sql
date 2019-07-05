desc user_constraints
/*
constraint_type : c:check, not null�� �ǹ��Ѵ�.
p:primary key, u: unique, r:reference, f:foreign key
*/
select constraint_name, constraint_type from user_constraints;

/*
2. �÷����� ��������
���̺��� �����Ҷ� �÷��� ���� ���������� ����ϴ� ����̴�. not null ���������� �÷����������� ������ �� �ֵ�.
3. ���̺� ���� ��������
not null�� ������ ��� ���������� ����� �� �ֵ�.
*/
--column constraint.sql�� ����
--constraint ���̺��_�÷�_���������̸� �������� ���
create table colst(
bun number(3) constraint colst_bun_pk primary key,
name varchar2(10) constraint colst_name_nn not null,
age number(5) constraint colst_age_ck check(age>=20 and age<=30),
addr varchar2(50) default '����� ������ �ż���',
jumin varchar2(14) constraint colst_jumin_uq unique);
--��������
select constraint_name, CONSTRAINT_TYPE from user_constraints where table_name='COLST';

create table talst(
bun number(3),
name varchar2(10) constraint talst_name_nn not null,
age number(3),
addr varchar2(30) default '����� ������',
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

insert into talst values(10, '��浿', 30, '����� ������', '111111-1234567');  
insert into talst values(20, '������', 20, '����� ������', '111111-2345267');  
insert into talst values(30, '�Ӿƿ�', 20, '��õ�� ����', '111111-2536567');  
select * from talst;
delete FROM talst;
insert into lib values(10, '�ڹ�å', sysdate);
insert into lib values(20, '����Ŭå', sysdate);
select * from lib;
--on delete cascade �����ϰ� �ִ� �ڽĵ����͵� �Բ� �����Ǵ� �Ӽ��̴�.
delete from talst where bun=10;
delete from lib;

--�������� ����
alter table talst drop constraint talst_jumin_nn;

select owner, r_owner, table_name, constraint_type, constraint_name
        from user_constraints
        where table_name in('LIB', 'TALST');
        
--�ǽ����̺� ����
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
alter table sawon add constraint sawon_sasex_ck check(sasex='����' or sasex='����');
alter table sawon add constraint sawon_samgr_fk foreign key(samgr) references sawon(sabun) on delete cascade;
alter table gogek add constraint gogek_gobun_pk primary key(gobun);
alter table gogek add constraint gogek_gojumin_uq unique(gojumin);
alter table gogek add constraint gogek_goda_fk foreign key(godam) references sawon(sabun) on delete cascade;


