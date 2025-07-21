create table transaction_category(
    category_num number(10) primary key,
    category_code varchar2(10) unique,  -- null�� ����Ͽ� ī�װ��� ��Ÿ�� ��� null�� ó���� ����.
                                        -- �̹� ��ϵǾ� �ִ� ��ǰ�� ���Ͽ� �ش� ī�װ��� ������ ���
                                        -- ��ǰ�� ī�װ� �ڵ尡 null�� �ٲ�� ��Ÿ ī�װ��� ���Խ�Ű�� ����.
    category_name varchar2(30) not null
);

create table transaction_user(
    user_id varchar2(20) primary key,
    user_pwd varchar2(20) not null,
    user_name varchar2(30) not null,
    user_age number(3) not null,
    user_email varchar2(50) not null,
    user_phone varchar2(20) not null,
    user_addr varchar2(100),
    user_regdate date not null
);

create table transaction_product(
    product_code varchar2(10) primary key,
    category_code varchar2(10) not null,
    product_name varchar2(50) not null,
    product_date date not null,
    product_img varchar2(200),          -- null �� ����Ͽ� ��ǰ �̹����� ������� ���� ���
                                        -- �ش� �÷��� null ó�� �Ǿ� �⺻ �̹��� ��� �ǵ��� �� ����.
    user_id varchar2(20) not null,
    sales_price number(10),
    sales_area varchar2(50) not null,   -- ���� api�� �߰��ϸ鼭 ��ġ������ ���� ���̺��� �߰������� ���� ��
                                        -- �ش� �÷��� �ܷ�Ű�� ��� ���� ������ ��ġ���� ���̺��� primary key��
                                        -- ����Ű�� ��ƾ� ��.
                                        -- ��ġ ���� ���̺��� ����Ű�� �÷��� ������ ������ ������ ���
                                        -- �ش� �ܷ�Ű �÷��� ��� ó���� �� �����ؾ� ��. (�Ǹ������� null �� �� ���� ������
                                        -- ������ �ش��ϴ� ��� ��ǰ �����Ͱ� �����Ǵ� �͵� ���� �� ��.)
    constraint category_code_fk foreign key(category_code)
        references transaction_category(category_code)
        on delete set null,
    constraint user_id_fk foreign key(user_id)
        references transaction_user(user_id)
        on delete cascade   -- ��ǰ�� ����� ȸ���� ������ ������ ��� �ش� ȸ���� ����� ��ǰ�� ����ó��.
);

-- �����ڴ� �� ������Ʈ�� �����ϰ� �α��� ������ ���ؼ� ���� ���Ѹ� ���� ����.
create table transaction_manager(
    manager_id varchar2(20) primary key,
    manager_pwd varchar2(20) not null
);