## <span style="color:pink">SELECT - ������ ��ȸ</span>
: SELECT�� '��� ��', 'Ư�� ������ ��', '��� ��', '������ ��' �� �ִ� �����͸� ��ȸ�� �� �ֽ��ϴ�.
+ [SELECT] ��ȸ�� �� [FROM] ���̺� �̸� [WHERE] Ư�� ���� ��ȸ�� ���� [ORDER BY] ������ �÷�</BR>(�ڵ� �������� [] ���ȣ �����ϰ� �Է�)
+ [SELECT] ��ȸ�� ��� ���� �����ϴ� ��ȣ * (���ϵ�ī�� ����)

#### 1) ������ ��� �� ��ȸ
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER**;

#### 2) ������ ���� ��� �� ��ȸ
+ EX) **<span style="color:red">SELECT </span> name <span style="color:red">FROM</span> TBL_MEMBER***;
+ EX) **<span style="color:red">SELECT </span> name, email <span style="color:red">FROM</span> TBL_MEMBER**;

#### 3) ���ǿ� �´� ���� ��� �÷� ��ȸ
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = <span style="color:green">'�ڻ糪' </span>**;

#### 4) ���ǿ� �´� ���� ������ �÷� ��ȸ
+ EX) **<span style="color:red">SELECT </span> email <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = <span style="color:green">'�ڻ糪' </span>**;

#### 5) order by�� ���� �÷� ����(�����ٶ� ���� �Ǵ� abcd ���� - ��������)
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> ORDER BY </span> NAME**;

#### 5-1) order by�� ���� �÷� ����(��������)
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> ORDER BY </span> NAME <span style="color:red"> DESC </span>**; 

#### 6) ���ڿ��� �κ� ��ġ �˻� : like ���� ���ǰ� �˻�
+ EX) **<span style="color:red">SELECT </span>* <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '��%' </span>**;
    + % ���ڴ� �������. ������ '��'
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '%����' </span>**;
    + ���� �������. '����' �˻�
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME <span style="color:red"> LIKE </span><span style="color:green"> '%��%' </span>**;
    + '��' ���ڰ� �ִ� �̸� �˻�(��ġ�� �������)

#### 7) �������� ������ ��ȸ : �̸��� ���� �Ǵ� �ڳ���
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = </span><span style="color:green"> '����' </span> <span style="color:red"> OR </span>NAME = <span style="color:green"> '�ڳ���' </span>**;
+  EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME </span><span style="color:red"> IN </span> (<span style="color:green"> '����','�ڳ���' </span>)**;
    + OR ���꿡 �ش�
+  EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME </span><span style="color:red"> NOT IN </span> (<span style="color:green"> '����','�ڳ���' </span>)**; 
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> NAME = </span><span style="color:green"> '����' </span> <span style="color:red"> AND </span>NAME = <span style="color:green"> '�ڳ���' </span>**;
    + 2���� �� ���� ����

#### 8) �̸��� EMAIL �÷��� NULL�� ��ȸ : NULL ��ȸ�� ���� IS ���� ���
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> EMAIL <span style="color:red"> IS NULL </span>**;
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> EMAIL <span style="color:red"> IS NOT NULL </span>**;

#### 9) MNO �÷��� ��ġ(����) ����
##### <MNO���� 5�� �� ��ȸ>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO = <span style="color:blue"> 5 </span>**;
##### <MNO���� 4�̸� ��ȸ>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO < <span style="color:blue"> 4 </span>**;
##### <MNO���� 1,2,5,7 �� �� ��ȸ : IN ����(OR ����)>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO <span style="color:red"> IN </span>(<span style="color:blue">1,2,5,7</span>)**;
##### <MNO���� 3~6 �� �� ��ȸ : between (AND ����)>
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO >= <span style="color:blue">3</span><span style="color:red"> AND </span>MNO <= <span style="color:blue">6</span>**;
+ EX) **<span style="color:red">SELECT </span> * <span style="color:red">FROM</span> TBL_MEMBER <span style="color:red"> WHERE </span> MNO <span style="color:red"> BETWEEN </span><span style="color:blue">3</span><span style="color:red"> AND </span><span style="color:blue">6</span><span style="color:red"> ORDER BY </span>JOIN_DATE<span style="color:red"> DESC </span>**;