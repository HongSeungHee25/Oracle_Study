## <span style="color:pink">SQL �̶�?</span>
 : Structured Query Lenguage (����ȭ�� ���� ���)
+ 1. DML - ������ �߰�, ����, ����, ��ȸ ���(INSERT, DELETE, SELECT)
+ 2. DDL - �����͸� ������ ���̺� �Ǵ� ����� ��� ����Ŭ�� ��ü ����/���� ���(CREATE, ALTER, DROP)
+ 3. DCL - ���� ��� �����͸� �ٷ�µ� �ʿ��� ����� ���� ���(GRANT,REVOKE)

## <span style="color:pink">���ڿ� ���� �׽�Ʈ</span>
+ **CHAR (����)** : ��������, ������ ����Ʈ
+ **VARVHAR (����)** : ����Ŭ���� ���������� ������� �ʴ� �����ڷ���.
+ **VARCHAR2 (����)** : ������ ���� ���� ����Ʈ, ���̴� �ִ� ���̰� ������ �޸𸮴� ������ ũ�⸸ŭ ����մϴ�.</BR> �ִ� 2000����Ʈ�Դϴ�. UTF-8 ���ڵ����� �ѱ��� 3����Ʈ, ����/����/��ȣ�� 1����Ʈ �Դϴ�. 

     + ���� : �������̴� ������ ��ŭ �������� �����մϴ�. �������̴� ������ ũ�⸸ŭ ������ ����ϰ� �ִ� ũ��� ���ѵ˴ϴ�.

### DDL : 1. ���̺� ����
**<span style="color:red">CREATE</span><span style="color:blue"> TABLE</span> ���̺��(���̺��� �����ϴ� �÷��� ����)**;

### DDL : 2. ���̺� ����
**<span style="color:red">DROP </span><span style="color:blue"> TABLE</span> ���̺��;</span>**

### DDL : 3. ���̺��� ��� ������ ����
**<span style="color:red">TRUNCATE </span><span style="color:blue"> TABLE</span> ���̺��̸�;</span>**

### DML : ���̺� ������ �߰�
**<span style="color:red">INSERT INTO</span> ���̺��<span style="color:red"> VALUES</span> (�÷������� �����Ǵ� ��, ��,....)**;

## <span style="color:pink">���� �Ǵ� �Ǽ� ��ġ ���� �׽�Ʈ</span>

+ ������ Ÿ�� NUMBER (����) : JAVA ������ �Ǽ� Ÿ�� ���� ����
+ NUMBER(���е� N, �Ҽ������� �ڸ��� M)

    + <����>
    + **NUMBER** - ���е� ���� ���ϸ� �ִ� 38�ڸ� (JAVA BIGDECIMAL) - �����ڸ��� �Ǽ��ڸ�
    + **NUMBER(5)** - ������ �ִ� 5�ڸ�(�Ҽ��� ���� ����. -�Ҽ��� ���� �ݿø�)(M = 0 �ΰ��)
    + **NUMBER(7,2)** - ��ü �ڸ��� �ִ� 7�ڸ�, �Ҽ��� ���� 2�ڸ�(����)(N > M �ΰ��)
    + **NUMBER(2,5)** - �Ҽ������� �ִ� 5�ڸ�(0�� 3�� ����), 0�ƴ� ��ȿ ���� �ִ� 2�ڸ�(N < M �ΰ��)

### TO_DATE
: ���ڿ��� ��¥ DATE �������� ��ȯ�ϴ� �Լ��Դϴ�.
+ EX) <span style="color:blue">**TO_DATE </span>(<span style="color:green">'2022-03-10 14:23:25'</span>,<span style="color:green">'YYYY-MM-DD HH24:MI:SS</span>);**
    + ���糯¥�� �ð� �Է��ϴ� ���� �÷��� �⺻���� ����Ŭ�� "<span style="color:blue">**SYSDATE**</span>" �� �����մϴ�.

### TO_CHAR
: date ������ ������ ������ ���ڿ��� ��ȯ�ϴ� �Լ��Դϴ�.
+ EX) <span style="color:red">**WHERE </span><span style="color:blue">TO_CHAR</span> (reg_date, <span style="color:green">'YYYY-MM-DD'</span>) <span style="color:red">IN </span>(<span style="color:green">'2022-03-10'</span>,<span style="color:green">'2021-12-25'</span>);**
    + **"<span style="color:red">IN</span>"** ��ſ� **"<span style="color:red">OR</span>"** �� ����ص� ����. �׷��� **"<span style="color:red">IN</span>"** �� �� �ڵ尡 ������.

### DISTINCT - ��ȸ�� �÷��� �ߺ����� ����
+ **<span style="color:red">SELECT DISTINCT</span> �ߺ��� ������ �÷� <span style="color:red">FROM</span> ���̺��**;
