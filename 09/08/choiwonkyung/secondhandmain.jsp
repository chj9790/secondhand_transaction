<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 전자기기 목록</title>
<style>
    body {
	    font-family: 'Segoe UI', sans-serif;
	    background-color: #f4f7fb;
	    margin: 0;
	    padding: 0;
	}
	
	.main-container {
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
        background-color: #2b7cff;
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
        color: #2b7cff;
    }

    .product-list { 
	    display: flex; 
	    flex-wrap: wrap; 
	    gap: 20px; 
    } 
    
    .product-card { 
	    flex: 0 0 calc(20% - 20px); 
	    background: white; 
	    border-radius: 10px; 
	    display: flex; 
	    flex-direction: column; 
	    padding: 12px; 
	    box-shadow: 1px 2px 5px rgba(0,0,0,0.05); 
	    transition: 0.2s ease; 
	    box-sizing: border-box; 
	    min-width: 200px; 
    } 
    
    .product-img-wrapper {
	    position: relative; 
	    width: 100%; 
	    padding-top: 100%;  /* 정사각형 비율 유지 */
	    overflow: hidden; 
	    border-radius: 8px; 
	    border: 1px solid #ddd;
	    background: #fafafa;
    } 
    
    .product-img { 
	    position: absolute; 
	    top: 0; 
	    left: 0; 
	    width: 100%; 
	    height: 100%; 
	    object-fit: cover; 
	    border-radius: 8px; 
    }


	.no-product {
	    width: 100%;
	    text-align: center;
	    padding: 60px 0;
	    font-size: 20px;
	    font-weight: 500;
	    color: #777;
	}

	.sold-out {
	    opacity: 0.4;
	    filter: grayscale(50%);
	}
	
	.status-overlay {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    font-weight: bold;
	    font-size: 18px;
	    padding: 4px 12px;
	    border-radius: 6px;
	    background-color: rgba(255, 255, 255, 0.8);
	}
	
	.sold-text {
	    color: red;
	}
	
	.reserved-text {
	    color: green;
	}

    .product-info {
        margin-top: 10px;
    }

    .product-info a {
        font-size: 18px;
        font-weight: 600;
        color: #2a2a2a;
        text-decoration: none; 
		display: block;            
		width: 100%;               
		white-space: nowrap;     
		overflow: hidden;        
		text-overflow: ellipsis;   
    }

    .product-info a:hover {
        text-decoration: underline;
    }

    .product-meta {
        color: #666;
        font-size: 14px;
        margin-top: 6px;
		display: block;            
		width: 100%;               
		white-space: nowrap;     
		overflow: hidden;        
		text-overflow: ellipsis;   
    }

    .product-price {
        font-weight: bold;
        margin-top: 4px;
        font-size: 16px;
        color: #4e8fe1;
    }

    .settings-btn {
        background-color: #dbe7ff;
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
        background-color: #f2f7fd;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .page-btn {
        display: inline-block;
        padding: 8px 14px;
        font-size: 14px;
        font-weight: 500;
        color: #2b7cff;
        background-color: white;
        border: 1px solid #b3d3ff;
        border-radius: 8px;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .page-btn:hover {
        background-color: #dceaff;
    }

    .page-btn.active {
        background-color: #2b7cff;
        color: white;
        border-color: #2b7cff;
    }

    .page-btn.first,
    .page-btn.last {
        font-weight: bold;
    }
    
	.product-card:hover {
	    background-color: #eef4ff;
	    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	}
	
	.region-select {
        width: 100%;
        padding: 8px 10px;
        margin-bottom: 12px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background: #fff;
        font-size: 14px;
    }
    
    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    input[type=number] {
        -moz-appearance: textfield; /* Firefox */
    }
</style>

<script>
window.areaData = [];

<c:forEach var="a" items="${areas}">
  window.areaData.push("${fn:trim(a.name)}");
</c:forEach>

// ===== 지역 선택 전역 함수 =====
window.loadMidRegions = function(top) {
    const midSelect = document.getElementById("midRegionSelect");
    const subSelect = document.getElementById("subRegionSelect");
    const detailSelect = document.getElementById("detailRegionSelect");
    
    midSelect.innerHTML = '<option value="">-- 시/군/구 선택 --</option>';
    subSelect.innerHTML = '<option value="">-- 읍/면/동/구 선택 --</option>';
    if(detailSelect) detailSelect.innerHTML = '<option value="">-- 리/법정동 선택 --</option>';

    const mids = [...new Set(
        window.areaData.filter(a=>a.startsWith(top+" ")).map(a=>a.split(" ")[1])
    )];

    mids.forEach(m=>{
        const opt = document.createElement("option");
        opt.value = top + " " + m;
        opt.textContent = m;
        midSelect.appendChild(opt);
    });
    window.triggerFilter(); // 선택 시 Ajax 호출
}

window.loadSubRegions = function(mid) {
    const subSelect = document.getElementById("subRegionSelect");
    const detailSelect = document.getElementById("detailRegionSelect");
    
    subSelect.innerHTML = '<option value="">-- 읍/면/동/구 선택 --</option>';
    if(detailSelect) detailSelect.innerHTML = '<option value="">-- 리/법정동 선택 --</option>';

    const subs = [...new Set(
        window.areaData.filter(a=>a.startsWith(mid+" ")).map(a=>a.split(" ")[2])
    )];

    subs.forEach(s=>{
        const opt = document.createElement("option");
        opt.value = mid + " " + s;
        opt.textContent = s;
        subSelect.appendChild(opt);
    });
    window.triggerFilter(); // 선택 시 Ajax 호출
}

window.loadDetailRegions = function(sub){
    const detailSelect = document.getElementById("detailRegionSelect");
    if(!detailSelect) return;
    detailSelect.innerHTML = '<option value="">-- 리/법정동 선택 --</option>';

    const details = [...new Set(
        window.areaData.filter(a=>a.startsWith(sub+" ")).map(a=>a.split(" ")[3])
    )];

    details.forEach(d=>{
        const opt = document.createElement("option");
        opt.value = sub + " " + d;
        opt.textContent = d;
        detailSelect.appendChild(opt);
    });
    window.triggerFilter(); // 선택 시 Ajax 호출
}

// ===== 검색 버튼 전역 함수 =====
window.validateAndSubmit = function() {
    const top = document.getElementById("topRegionSelect").value;
    const mid = document.getElementById("midRegionSelect").value;
    const sub = document.getElementById("subRegionSelect").value;
    const detailSelect = document.getElementById("detailRegionSelect");
    const detail = detailSelect ? detailSelect.value : "";

    if(!top){ alert("시/도를 먼저 선택하세요."); return; }
    if(!mid){ alert("시/군/구를 먼저 선택하세요."); return; }
    if(!sub){ alert("읍/면/동/구를 선택하세요."); return; }

    const finalArea = detail ? detail : sub;
    document.getElementById("finalArea").value = finalArea;

    window.triggerFilter(); // 새로고침 없이 Ajax 호출
}

// ===== 이벤트 바인딩 =====
document.addEventListener("DOMContentLoaded", function(){
    const topSelect = document.getElementById("topRegionSelect");
    const midSelect = document.getElementById("midRegionSelect");
    const subSelect = document.getElementById("subRegionSelect");
    const detailSelect = document.getElementById("detailRegionSelect");

    topSelect.addEventListener("change", function(){
        if(this.value) window.loadMidRegions(this.value);
    });
    midSelect.addEventListener("change", function(){
        if(this.value) window.loadSubRegions(this.value);
    });
    subSelect.addEventListener("change", function(){
        if(this.value) window.loadDetailRegions(this.value);
    });
});
</script>

</head>
<body>

<jsp:include page="include/header.jsp" />

<div class="main-container">
  <div class="sidebar">
    <form id="filterForm" method="get" action="secondhand_list.go">

      <!-- 1단계: 시/도 -->
      <label for="topRegionSelect">광역자치단체</label>
      <select id="topRegionSelect" name="topRegion" class="region-select">
        <option value="">-- 시/도 선택 --</option>
        <c:forEach var="a" items="${areas}">
          <c:set var="parts" value="${fn:split(fn:trim(a.name), ' ')}"/>
          <c:if test="${fn:length(parts) == 1}">
            <option value="${parts[0]}"
              <c:if test="${param.topRegion == parts[0]}">selected</c:if>>
              ${parts[0]}
            </option>
          </c:if>
        </c:forEach>
      </select>

      <!-- 2단계: 시/군/구 -->
      <label for="midRegionSelect">기초자치단체</label>
      <select id="midRegionSelect" name="midRegion" class="region-select">
        <option value="">-- 시/군/구 선택 --</option>
        <c:forEach var="a" items="${areas}">
          <c:set var="parts" value="${fn:split(fn:trim(a.name), ' ')}"/>
          <c:if test="${fn:length(parts) >= 2 and parts[0] == param.topRegion}">
            <c:set var="mid" value="${parts[0]} ${parts[1]}"/>
            <option value="${mid}"
              <c:if test="${param.midRegion == mid}">selected</c:if>>
              ${parts[1]}
            </option>
          </c:if>
        </c:forEach>
      </select>

      <!-- 3단계: 읍/면/구 -->
      <label for="subRegionSelect">행정구역</label>
      <select id="subRegionSelect" name="subRegion" class="region-select">
        <option value="">-- 읍/면/동/구 선택 --</option>
        <c:forEach var="a" items="${areas}">
          <c:set var="parts" value="${fn:split(fn:trim(a.name), ' ')}"/>
          <c:set var="mid" value="${parts[0]} ${parts[1]}"/>
          <c:if test="${fn:length(parts) >= 3 and mid == param.midRegion}">
            <c:set var="sub" value="${parts[0]} ${parts[1]} ${parts[2]}"/>
            <option value="${sub}"
              <c:if test="${param.subRegion == sub}">selected</c:if>>
              ${parts[2]}
            </option>
          </c:if>
        </c:forEach>
      </select>

      <!-- 4단계: 동/리 -->
      <label for="detailRegionSelect">세부 행정구역</label>
      <select id="detailRegionSelect" class="region-select">
        <option value="">-- 리/법정동 선택 --</option>
        <c:forEach var="a" items="${areas}">
          <c:set var="parts" value="${fn:split(fn:trim(a.name), ' ')}"/>
          <c:set var="sub" value="${parts[0]} ${parts[1]} ${parts[2]}"/>
          <c:if test="${fn:length(parts) >= 4 and sub == param.subRegion}">
            <option value="${fn:trim(a.name)}"
              <c:if test="${param.area == fn:trim(a.name)}">selected</c:if>>
              ${parts[3]}
            </option>
          </c:if>
        </c:forEach>
      </select>

      <!-- hidden 필드 -->
      <input type="hidden" name="area" id="finalArea" />

       <!-- 검색 버튼 -->
      <div style="margin-top: 10px;">
        <button type="button" onclick="triggerFilter()" 
          style="width: 100%; background-color: #2b7cff; color: white; border: none; padding: 6px; border-radius: 6px; cursor: pointer;">
          지역 검색
        </button>
      </div>
      <br>
      <!-- 지역 초기화 버튼 -->
	<div style="margin-top: 10px;">
    	<button type="button" onclick="resetArea()"
        style="width: 100%; background-color: #ff6b6b; color: white; border: none; padding: 6px; border-radius: 6px; cursor: pointer;">
        지역 초기화
    	</button>
	</div>
     <br> 
		
		<div id="area-radios">   </div>


		<button type="button" id="btnUseMyLocation"  style="width: 100%; background-color: #2b7cff; color: white; border: none; padding: 6px; border-radius: 6px; cursor: pointer;">우리 동네 보기</button>
		<button type="button" id="btnHideMyLocation"  style="width: 100%; background-color: #2b7cff; color: white; border: none; padding: 6px; border-radius: 6px; cursor: pointer;">숨기기</button>

        <hr>
        <h3>카테고리</h3>
        <c:forEach var="c" items="${category}">
				    <label>
				        <input type="radio" name="category"
				               value="${c.category_code == null ? 'etc' : c.category_code}"
				              
				               <c:if test="${selectedCategory == (c.category_code == null ? 'etc' : c.category_code)}">checked</c:if>>
				        ${c.category_name}
				    </label>
				</c:forEach>
		        
		        <!-- 카테고리 초기화 버튼 -->
				<div style="margin-top: 10px;">
				    <button type="button" onclick="resetCategory()"
 style="margin-top: 10px; width: 50%; background-color: #2b7cff; color: white; border: none; padding: 5px; border-radius: 6px; cursor: pointer;">
카테고리 초기화
</button>
				</div>
        
        

        <hr>
        <h3>가격 범위</h3>
		<input type="number" id="minPrice" name="minPrice" placeholder="최소가격" 
		       value="${minPrice}" min="0" step="any"
		       style="width: 33%; margin-bottom: 8px;" /> ~
		
		<input type="number" id="maxPrice" name="maxPrice" placeholder="최대가격" 
		       value="${maxPrice}" min="0" step="any"
		       style="width: 33%; margin-bottom: 8px;" />

	    <!-- 무료나눔 버튼 -->
		<div style="margin-top: 10px;">
		    <button type="button" onclick="submitFreeShare()"
		        style="width: 30%; background-color: #28a745; color: white; border: none; padding: 5px; border-radius: 6px; cursor: pointer;">
		        무료나눔
		    </button>
		</div>

         <button type="button" onclick="triggerFilter()" style="margin-top: 10px; width: 50%; background-color: #2b7cff; color: white; border: none; padding: 5px; border-radius: 6px; cursor: pointer;">
			가격 검색
		</button> 
	    </form>
	</div>
	
	<div class="content">
	    <h1>중고 전자기기</h1>
	
	    <div class="top-bar">
	        <form class="search-bar" onsubmit="event.preventDefault(); triggerFilter();">
	            <input type="text" name="keyword" placeholder="제품명을 입력하세요" value="${param.keyword }">
	            <input type="submit" value="검색">	
	        </form>
	
	        <div style="display: flex; align-items: center; gap: 20px;">
	            <div class="product-count">총 <strong>${paging.totalRecord}</strong>개 상품</div>
	        </div>
	    </div>
	
	    <div class="product-list">
	        <c:if test="${empty productList}">
	            <div class="no-product">
	                상품이 없습니다.
	            </div>
	        </c:if>

	        <c:forEach var="p" items="${productList}">
	        	<c:set var="imgList" value="${fn:split(p.product_img, ',')}" />
	            <div class="product-card" onclick="location.href='product_detail.go?product_num=${p.product_num}'" style="cursor: pointer;">
				    <div class="product-img-wrapper">
				        <img src="<%=request.getContextPath() %>/resources/upload/${imgList[0]}"
				             class="product-img <c:if test='${p.product_status == "판매완료"}'>sold-out</c:if>">
				        
				        <c:choose>
				            <c:when test="${p.product_status == '판매완료'}">
				                <div class="status-overlay sold-text">판매완료</div>
				            </c:when>
				            <c:when test="${p.product_status == '예약중'}">
				                <div class="status-overlay reserved-text">예약중</div>
				            </c:when>
				        </c:choose>
				    </div>
				
				    <div class="product-info">
				        <a href="product_detail.go?product_num=${p.product_num}">${p.product_title}</a>
				        <fmt:formatDate value="${p.product_date}" pattern="YYYY-MM-dd · a h:mm" var="formattedTime" />
				        <div class="product-meta">${p.sales_area}</div>
				        <div class="product-meta">${formattedTime}</div>
				        <div class="product-price">
				            <c:choose>
				                <c:when test="${p.sales_price == 0}">
				                    무료 나눔
				                </c:when>
				                <c:otherwise>
				                    <fmt:formatNumber value="${p.sales_price}" type="number" />원
				                </c:otherwise>
				            </c:choose>
				        </div>
				    </div>
				</div>
	        </c:forEach>
	    </div>
	
	    <br><br>
	
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
</div>

<jsp:include page="include/footer.jsp" />

	
	<script>
  // ===== 전역 상태 =====
  let selectedArea = "<c:out value='${param.area}' default='' />";
  let selectedCategory = "<c:out value='${param.category}' default='' />";
  let radioVisible = false;

  // ===== 전역 함수 =====

  // Ajax 상품 리스트 가져오기
  window.fetchProductList = async function(params) {
      const productListContainer = document.querySelector('.product-list');
      const paginationWrapper = document.querySelector('.pagination-wrapper');
      const productCount = document.querySelector('.product-count');

      const query = new URLSearchParams(params).toString();
      const resp = await fetch('secondhand_list.go?' + query);
      const html = await resp.text();
      const tempDiv = document.createElement('div');
      tempDiv.innerHTML = html;

      const newList = tempDiv.querySelector('.product-list');
      if (newList) productListContainer.innerHTML = newList.innerHTML;

      const newPagination = tempDiv.querySelector('.pagination-wrapper');
      if (newPagination) paginationWrapper.innerHTML = newPagination.innerHTML;

      const newCount = tempDiv.querySelector('.product-count');
      if (newCount) productCount.innerHTML = newCount.innerHTML;
  };

//      triggerFilter() 
  window.triggerFilter = function() {
      const filterForm = document.getElementById('filterForm');
      if(!filterForm) return;

      
      // ===== 가격 값 가져오기 =====
      const minInput = filterForm.querySelector('input[name="minPrice"]');
      const maxInput = filterForm.querySelector('input[name="maxPrice"]');
      let minVal = parseFloat(minInput?.value) || 0;
      let maxVal = parseFloat(maxInput?.value) || 0;

      // ===== 가격 검증 =====
      if (minVal < 0 || maxVal < 0) {
          alert("가격은 0 이상의 숫자만 입력 가능합니다.");
          return; // Ajax 호출 막음
      }
      if (maxVal > 0 && minVal > maxVal) {
          alert("최소 가격은 최대 가격보다 클 수 없습니다.");
          return;
      }    
      //  라디오 우선, 없으면 select 최종값 사용 
      const areaRadio = document.querySelector('input[name="area"]:checked');
      const finalAreaInput = document.getElementById('finalArea');
      
      // select 값 가져오기 (detail > sub > mid > top)
      const top = document.getElementById("topRegionSelect")?.value || '';
      const mid = document.getElementById("midRegionSelect")?.value || '';
      const sub = document.getElementById("subRegionSelect")?.value || '';
      const detail = document.getElementById("detailRegionSelect")?.value || '';
      const selectFinalArea = detail || sub || mid || top;

      // 최종 area 결정: 라디오가 선택되면 라디오, 아니면 select
      const finalArea = areaRadio?.value || selectFinalArea;

      // hidden input에도 복사 (서버 전송용)
      if(finalAreaInput) finalAreaInput.value = finalArea;

      const params = {
          area: finalArea,  // 서버 전달용
          category: filterForm.querySelector('input[name="category"]:checked')?.value || '',
          minPrice: filterForm.querySelector('input[name="minPrice"]').value || '',
          maxPrice: filterForm.querySelector('input[name="maxPrice"]').value || '',
          keyword: document.querySelector('input[name="keyword"]')?.value || ''
      };

      console.log('triggerFilter params:', params); // 디버그용
      window.fetchProductList(params);
      
   
  };
  
  // 무료나눔 버튼
  window.submitFreeShare = function() {
      const form = document.getElementById('filterForm');
      if(!form) return;

      const minInput = form.querySelector('input[name="minPrice"]');
      const maxInput = form.querySelector('input[name="maxPrice"]');

      if(minInput) minInput.value = "";
      if(maxInput) maxInput.value = "0";

      // 카테고리 선택 해제 (필요 시)
      const radios = form.querySelectorAll('input[name="category"]');
      radios.forEach(r => r.checked = false);

      window.triggerFilter();
  };

  // 위치 가져오기
  window.getUserLocation = function() {
      return new Promise((resolve, reject) => {
          if(navigator.geolocation){
              navigator.geolocation.getCurrentPosition(
                  pos => resolve({lat: pos.coords.latitude, lng: pos.coords.longitude}),
                  err => reject(err),
                  {enableHighAccuracy:true, timeout:5000}
              );
          } else reject(new Error("브라우저가 위치 정보를 지원하지 않습니다."));
      });
  };

  // 구/동 목록 가져오기 (Google Maps API)
  window.fetchDongListByCoords = async function(lat, lng) {
      const geocoder = new google.maps.Geocoder();
      return new Promise((resolve, reject) => {
          geocoder.geocode({location:{lat,lng}}, (results, status)=>{
              if(status==="OK" && results.length>0){
                  let guName=null;
                  for(let r of results){
                      const guMatch=r.formatted_address.match(/([가-힣]+(구|군))/);
                      if(guMatch){ guName=guMatch[1]; break; }
                  }
                  if(!guName) return reject("구(군) 이름을 찾을 수 없습니다.");
                  fetch('/region/search?address=' + encodeURIComponent(guName))
                    .then(res=>res.json())
                    .then(data=>{
                        const dongNames = data.map(item=>{
                            const match = item.name.match(/([가-힣]+(동|면|리))$/);
                            return match ? match[1] : null;
                        }).filter(n=>n!==null);
                        resolve(dongNames);
                    })
                    .catch(e=>reject(e));
              } else reject("지오코딩 실패: "+status);
          });
      });
  };

  // 우리동네보기
  window.showMyLocation = async function() {
      try {
          const pos = await window.getUserLocation();
          const dongList = await window.fetchDongListByCoords(pos.lat, pos.lng);
          selectedArea = '';
          updateAreaRadios(dongList);
          document.getElementById('area-radios').style.display='block';
          radioVisible = true;

          document.getElementById('btnUseMyLocation').style.display='none';
          document.getElementById('btnHideMyLocation').style.display='inline-block';

          window.triggerFilter();
          
          
      } catch(e) {
          console.error(e);
          alert("위치 정보를 가져오지 못했습니다.");
      }
  };

  // 숨기기
  window.hideMyLocation = function() {
      selectedArea = '';
      updateAreaRadios([]);
      document.getElementById('area-radios').style.display='none';
      radioVisible = false;

      document.getElementById('btnUseMyLocation').style.display='inline-block';
      document.getElementById('btnHideMyLocation').style.display='none';

      window.triggerFilter();
  };

  // 라디오 버튼 갱신
  function updateAreaRadios(areaList){
      const areaRadioList=document.getElementById('area-radios');
      areaRadioList.innerHTML='';

      // 전체보기
      const labelAll=document.createElement('label');
      const inputAll=document.createElement('input');
      inputAll.type='radio'; inputAll.name='area'; inputAll.value='';
      inputAll.checked=!selectedArea;
      inputAll.addEventListener('change', ()=>{ selectedArea=''; window.triggerFilter(); });
      labelAll.appendChild(inputAll);
      labelAll.appendChild(document.createTextNode(' 전체보기'));
      areaRadioList.appendChild(labelAll);

      areaList.forEach(area=>{
          const label=document.createElement('label');
          const input=document.createElement('input');
          input.type='radio'; input.name='area'; input.value=area;
          input.checked=(area===selectedArea);
          input.addEventListener('change', ()=>{ selectedArea=area; window.triggerFilter(); });
          label.appendChild(input);
          label.appendChild(document.createTextNode(' '+area));
          areaRadioList.appendChild(label);
      });
  }
  
  window.resetCategory = function() {
	    const filterForm = document.getElementById('filterForm');
	    if(!filterForm) return;

	    // 모든 카테고리 라디오 선택 해제
	    const radios = filterForm.querySelectorAll('input[name="category"]');
	    radios.forEach(r => r.checked = false);

	    // Ajax로 필터 적용
	    window.triggerFilter();
	};
	
	function resetArea() {
	    // hidden input 초기화
	    const finalAreaInput = document.getElementById('finalArea');
	    if(finalAreaInput) finalAreaInput.value = '';

	    // select 초기화
	    document.getElementById("topRegionSelect").value = '';
	    document.getElementById("midRegionSelect").innerHTML = '<option value="">-- 시/군/구 선택 --</option>';
	    document.getElementById("subRegionSelect").innerHTML = '<option value="">-- 읍/면/동/구 선택 --</option>';
	    document.getElementById("detailRegionSelect").innerHTML = '<option value="">-- 리/법정동 선택 --</option>';

	    // 라디오 영역 초기화 (우리 동네 보기 선택 시)
	    const areaRadios = document.getElementById('area-radios');
	    if(areaRadios){
	        areaRadios.innerHTML = '';
	        document.getElementById('btnUseMyLocation').style.display='inline-block';
	        document.getElementById('btnHideMyLocation').style.display='none';
	    }

	    // Ajax 호출
	    window.triggerFilter();
	}

  // ===== DOMContentLoaded =====
  document.addEventListener('DOMContentLoaded', ()=>{
      const filterForm = document.getElementById('filterForm');
      if(!filterForm) return;

      const keywordInput = filterForm.querySelector('input[name="keyword"]');
      if(keywordInput){
          keywordInput.addEventListener('keypress', e=>{
              if(e.key==='Enter'){ e.preventDefault(); window.triggerFilter(); }
          });
      }

      filterForm.querySelectorAll('input[name="category"], input[name="minPrice"], input[name="maxPrice"]').forEach(el=>{
          el.addEventListener('change', window.triggerFilter);
      });

      document.getElementById('btnUseMyLocation').addEventListener('click', window.showMyLocation);
      document.getElementById('btnHideMyLocation').addEventListener('click', window.hideMyLocation);

      // 초기 라디오/버튼 상태
      if(selectedArea){
          updateAreaRadios([selectedArea]);
          document.getElementById('area-radios').style.display='block';
          radioVisible=true;

          document.getElementById('btnUseMyLocation').style.display='none';
          document.getElementById('btnHideMyLocation').style.display='inline-block';
      } else {
          document.getElementById('area-radios').style.display='none';
          radioVisible=false;

          document.getElementById('btnUseMyLocation').style.display='inline-block';
          document.getElementById('btnHideMyLocation').style.display='none';
      }
      
   
      // 페이지 버튼 Ajax 적용
      const paginationWrapper = document.querySelector('.pagination-wrapper');
      if(paginationWrapper){
          paginationWrapper.addEventListener('click', e=>{
              if(e.target.tagName==='A'){
                  e.preventDefault();
                  const page = new URL(e.target.href, window.location.origin).searchParams.get('page');
                  const params = {
                      page,
                      area: document.querySelector('input[name="area"]:checked')?.value || '',
                      category: document.querySelector('input[name="category"]:checked')?.value || '',
                      minPrice: document.querySelector('input[name="minPrice"]').value || '',
                      maxPrice: document.querySelector('input[name="maxPrice"]').value || '',
                      keyword: document.querySelector('input[name="keyword"]').value || ''
                  };
                  window.fetchProductList(params);
              }
          });
      }
      
      const minInput = document.getElementById("minPrice");
      const maxInput = document.getElementById("maxPrice");
      
      
      

      if(minInput && maxInput){
          // 최소 가격 입력 실시간 검증
          minInput.addEventListener('input', () => {
              let minVal = parseFloat(minInput.value) || 0;
              let maxVal = parseFloat(maxInput.value) || 0;

              if(minVal < 0){
                  alert("최소 가격은 0 이상의 숫자여야 합니다.");
                  minInput.value = '';
                  return;
              } 
              if(maxVal > 0 && minVal > maxVal){
                  alert("최소 가격은 최대 가격보다 클 수 없습니다.");
                  minInput.value = maxVal;
                  return;
              }

              maxInput.min = Math.max(0, minVal);
          });

          // 최대 가격 입력 실시간 검증
          maxInput.addEventListener('input', () => {
              let minVal = parseFloat(minInput.value) || 0;
              let maxVal = parseFloat(maxInput.value) || 0;

              if(maxVal < 0){
                  alert("최대 가격은 0 이상의 숫자여야 합니다.");
                  maxInput.value = '';
                  return;
              }
            
          });
      } 
      
  });


</script>



	
	 <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6GZL5JoPGTDsQqjhGD-dgKj7hRQSTxfE&"
      async defer>
    </script>

</body>
</html>

