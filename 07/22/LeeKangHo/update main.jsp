// Category 클래스 생성


package com.boot.project.model;

import lombok.Data;

@Data
public class Category {

	private int category_num;
	private String category_code;
	private String category_name;
	
}



_________________________________________________________________________________________

// Page 클래스 생성

package com.boot.project.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor   // 기본 생성자
public class Page {

	// 페이징 처리 작업 관련 멤버 선언.
	private int page;                   // 현재 페이지
	private int rowsize;                // 한 페이지당 보여질 게시물의 수
	private int totalRecord;            // DB 상의 board 테이블 전체 게시물의 수
	private int startNo;                // 해당 페이지에서 시작 번호
	private int endNo;                  // 해당 페이지에서 끝 번호
	private int startBlock;             // 해당 페이지에서 시작 블럭
	private int endBlock;               // 해당 페이지에서 끝 블럭
	private int allPage;                // 전체 페이지 수
	private int block = 3;              // 아래에 보여질 최대 페이지 수
	
	private String field;
	private String keyword;
	
	private String listSort = "rec_num";
	
	// 일반적인 페이징 처리 인자 생성자
	public Page(int page, int rowsize, int totalRecord) {
		
		this.page = page;
		this.rowsize = rowsize;
		this.totalRecord = totalRecord;
		
		// 해당 페이지에서 시작 번호.
		this.startNo = (this.page * this.rowsize) - (this.rowsize - 1);
		
		// 해당 페이지에서 끝 번호.
		this.endNo = (this.page * this.rowsize);
		
		// 해당 페이지에서 시작 블럭
		this.startBlock = 
				(((this.page - 1) / this.block) * this.block) + 1;
		
		// 해당 페이지에서 끝 블럭
		this.endBlock = 
				(((this.page - 1) / this.block) * this.block) + this.block;
		
		// 전체 페이지 수 얻어오는 과정
		this.allPage =
				(int)Math.ceil(this.totalRecord / (double)this.rowsize);
		
		// 전체 페이지 수보다 endBlock이 큰 경우
		if(this.endBlock > this.allPage) {
			this.endBlock = this.allPage;
		}
		
	}  // 인자 생성자
	
	// 검색을 하는 페이징 처리 인자 생성자 (회원)
		public Page(int page, int rowsize, int totalRecord,
					String field, String keyword) {
			
			this(page, rowsize, totalRecord);
			this.field = field;
			this.keyword = keyword;
			
		}  // 인자 생성자
	
	// 검색을 하는 페이징 처리 인자 생성자 + 정렬
	public Page(int page, int rowsize, int totalRecord,
				String field, String keyword, String listSort) {
		
		this(page, rowsize, totalRecord);
		this.field = field;
		this.keyword = keyword;
		this.listSort = listSort;
		
	}  // 인자 생성자
	
	
	// 오름차순, 내림차순 정렬 페이징 처리 인자 생성자
	public Page(int page, int rowsize, int totalRecord, String listSort) {
		
	this(page, rowsize, totalRecord);
	
	this.listSort = listSort;
	
	
}  // 오름차순, 내림차순 정렬 페이징 처리 인자 생성자 end

	
}




_________________________________________________________________________________________

// Mapper 클래스

List<ProductDTO> product_list(Page pdto); // 기존의 메서드에 인자 추가

int products_count();

List<Category> getcategory();



_________________________________________________________________________________________

// 컨트롤러 클래스(기존의 매핑 대체)

    // 페이지 변수
    private final int rowsize = 10;
    private final int userRowsize = 5;
 	private int totalRecord = 0;
	
	@GetMapping("/")
	public String main(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
	
		totalRecord = this.mapper.products_count();
				
		Page pdto = new Page(page, rowsize, totalRecord);
	
		List<ProductDTO> productlist = mapper.product_list(pdto); // 전체 상품 조회하기	
		
		List<Category> category = mapper.getcategory();
		
		model.addAttribute("productList", productlist)
		.addAttribute("paging", pdto)	
		.addAttribute("category", category);		
		
		
		return "main";
		
	}




_________________________________________________________________________________________


// secondHand.xml 추가

<select id="product_list" parameterType="Page" resultType="ProductDTO">
        <![CDATA[
  			select * from
				(select row_number()
					over(order by product_date desc) rnum, a.* from transaction_product a)
						where rnum >= #{startNo} and rnum <= #{endNo}
  		]]>
	</select>
	
	<select id="products_count" resultType="int">
		select count(*) from transaction_product
	</select>
	
	<select id="getcategory" resultType="Category">
		select * from transaction_category order by category_num
	</select>


_________________________________________________________________________________________


// mybatis-config.xml 추가

<typeAlias type="com.boot.project.model.Page" alias="Page" />
 <typeAlias type="com.boot.project.model.Category" alias="Category" />



_________________________________________________________________________________________

// main.jsp 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 전자기기 목록</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 0;
        display: flex;
    }

    .sidebar {
        width: 15%;
        padding: 20px;
        background-color: #ffffff;
        border-right: 1px solid #ddd;
        overflow-y: auto;
    }

    .sidebar h3 {
        font-size: 16px;
        margin-bottom: 10px;
    }

    .sidebar label {
        display: block;
        margin-bottom: 6px;
        font-size: 14px;
    }

    .content {
        flex: 1;
        padding: 20px;
    }

    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .search-bar input[type="text"] {
        width: 250px;
        padding: 8px 12px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .search-bar input[type="submit"] {
        padding: 8px 16px;
        background-color: #ff7e36;
        color: white;
        border: none;
        border-radius: 5px;
        margin-left: 8px;
        cursor: pointer;
    }

    .product-count {
        font-size: 15px;
        color: #555;
        margin-right: 10px;
    }

    .product-count strong {
        color: #ff6f0f;
    }

    .product-list {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .product-card {
        width: calc(20% - 20px);
        background: white;
        border-radius: 10px;
        display: flex;
        flex-direction: column;
        padding: 12px;
        box-shadow: 1 2px 5px rgba(0,0,0,0.05);
        transition: 0.2s ease;
        box-sizing: border-box;
    }

    .product-card:hover {
        background-color: #f1f1f1;
    }

    .product-img {
        width: 100%;
        height: 200px;
        border-radius: 8px;
        object-fit: cover;
        border: 1px solid #ddd;
    }

    .product-info {
        margin-top: 10px;
    }

    .product-info a {
        font-size: 18px;
        font-weight: 600;
        color: #333;
        text-decoration: none;
    }

    .product-info a:hover {
        text-decoration: underline;
    }

    .product-meta {
        color: #666;
        font-size: 14px;
        margin-top: 6px;
    }

    .product-price {
        font-weight: bold;
        margin-top: 4px;
        font-size: 16px;
        color: #FF5722;
    }

    .settings-btn {
        background-color: #ddd;
        border: none;
        padding: 8px 16px;
        border-radius: 5px;
        cursor: pointer;
    }

    .pagination-wrapper {
        margin: 30px 0;
    }

    .pagination {
        display: inline-flex;
        gap: 6px;
        padding: 10px 20px;
        border-radius: 12px;
        background-color: #fff7f0;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .page-btn {
        display: inline-block;
        padding: 8px 14px;
        font-size: 14px;
        font-weight: 500;
        color: #ff6f0f;
        background-color: white;
        border: 1px solid #ffddb9;
        border-radius: 8px;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .page-btn:hover {
        background-color: #fff0e1;
    }

    .page-btn.active {
        background-color: #ff6f0f;
        color: white;
        border-color: #ff6f0f;
    }

    .page-btn.first,
    .page-btn.last {
        font-weight: bold;
    }
</style>
</head>
<body>

<div class="sidebar">
    <form method="get" action="secondhand_list.go">
        <h3>지역 선택</h3> <!-- 위치는 임시용 추후에 변경 예정 -->
        <label><input type="checkbox" name="area" value="서울"> 서울</label>
        <label><input type="checkbox" name="area" value="부산"> 부산</label>      
        <label><input type="checkbox" name="area" value="인천"> 인천</label>
        <label><input type="checkbox" name="area" value="대구"> 대구</label>
        <label><input type="checkbox" name="area" value="대전"> 대전</label>

        <hr>
        <h3>카테고리</h3>
        <c:forEach var="c" items="${category}">
            <label>
                <input type="radio" name="category" value="${c.category_code}" onchange="this.form.submit()">
                ${c.category_name}
            </label>
        </c:forEach>
    </form>
</div>

<div class="content">

    <h1>중고 전자기기</h1>

    <div class="top-bar">
        <form class="search-bar" method="get" action="secondhand_list.go">
            <input type="text" name="keyword" placeholder="제품명을 입력하세요">
            <input type="submit" value="검색">
        </form>

        <div style="display: flex; align-items: center; gap: 20px;">
            <div class="product-count">총 <strong>${paging.totalRecord}</strong>개 상품</div>
            <button class="settings-btn" onclick="location.href='user_login.go'">로그인</button>
        </div>
    </div>

    <div class="product-list">
        <c:forEach var="p" items="${productList}">
            <div class="product-card">
                <img class="product-img" src="${p.product_img}" alt="이미지">
                <div class="product-info">
                    <a href="product_detail.go?product_code=${p.product_code}">${p.product_name}</a>
                    <div class="product-meta">${p.sales_area} · ${p.product_date}</div>
                    <div class="product-price"><fmt:formatNumber value="${p.sales_price}" type="number" />원</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <br><br>

    <!-- 페이징 버튼 -->
    <div class="pagination-wrapper" align="center">
        <div class="pagination">
            <c:if test="${paging.page > paging.block}">
                <a href="?page=1" class="page-btn first">처음</a>
                <a href="?page=${paging.startBlock - 1}" class="page-btn">◀</a>
            </c:if>

            <c:forEach begin="${paging.startBlock}" end="${paging.endBlock}" var="i">
                <c:choose>
                    <c:when test="${i == paging.page}">
                        <a href="?page=${i}" class="page-btn active">${i}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="?page=${i}" class="page-btn">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${paging.endBlock < paging.allPage}">
                <a href="?page=${paging.endBlock + 1}" class="page-btn">▶</a>
                <a href="?page=${paging.allPage}" class="page-btn last">마지막</a>
            </c:if>
        </div>
    </div>

</div>

</body>
</html>





_________________________________________________________________________________________
