create table transaction_category(
    category_num number(10) primary key,
    category_code varchar2(10) unique,  -- null을 허용하여 카테고리가 기타인 경우 null로 처리할 예정.
                                        -- 이미 등록되어 있는 상품에 대하여 해당 카테고리가 삭제될 경우
                                        -- 상품의 카테고리 코드가 null로 바뀌어 기타 카테고리에 포함시키기 위함.
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
    product_img varchar2(200),          -- null 값 허용하여 상품 이미지를 등록하지 않을 경우
                                        -- 해당 컬럼이 null 처리 되어 기본 이미지 출력 되도록 할 예정.
    user_id varchar2(20) not null,
    sales_price number(10),
    sales_area varchar2(50) not null,   -- 지도 api를 추가하면서 위치정보에 대한 테이블을 추가적으로 생성 시
                                        -- 해당 컬럼을 외래키로 잡고 새로 생성한 위치정보 테이블의 primary key를
                                        -- 참조키로 잡아야 함.
                                        -- 위치 정보 테이블에서 참조키인 컬럼이 모종의 이유로 삭제될 경우
                                        -- 해당 외래키 컬럼은 어떻게 처리할 지 생각해야 함. (판매지역이 null 이 될 수는 없지만
                                        -- 지역에 해당하는 모든 상품 데이터가 삭제되는 것도 말이 안 됨.)
    constraint category_code_fk foreign key(category_code)
        references transaction_category(category_code)
        on delete set null,
    constraint user_id_fk foreign key(user_id)
        references transaction_user(user_id)
        on delete cascade   -- 상품을 등록한 회원의 정보가 삭제될 경우 해당 회원이 등록한 상품도 삭제처리.
);

-- 관리자는 전 프로젝트와 동일하게 로그인 정보를 통해서 제어 권한만 가질 예정.
create table transaction_manager(
    manager_id varchar2(20) primary key,
    manager_pwd varchar2(20) not null
);