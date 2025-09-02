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
/* 기존 CSS 유지 */
body { font-family: 'Segoe UI', sans-serif; background-color: #f4f7fb; margin: 0; padding: 0; }
.main-container { display: flex; }
.sidebar { width: 15%; padding: 20px; background-color: #fff; border-right: 1px solid #ddd; overflow-y: auto; }
.sidebar h3 { font-size: 16px; margin-bottom: 10px; }
.sidebar label { display: block; margin-bottom: 6px; font-size: 14px; cursor: pointer; }
.content { flex: 1; padding: 20px; }
.top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.search-bar input[type="text"] { width: 250px; padding: 8px 12px; border: 1px solid #ccc; border-radius: 5px; }
.search-bar input[type="submit"] { padding: 8px 16px; background-color: #2b7cff; color: white; border: none; border-radius: 5px; margin-left: 8px; cursor: pointer; }
.product-list { display: flex; flex-wrap: wrap; gap: 20px; }
.product-card { width: calc(20% - 20px); background: white; border-radius: 10px; display: flex; flex-direction: column; padding: 12px; box-shadow: 1px 2px 5px rgba(0,0,0,0.05); cursor: pointer; }
.product-card:hover { background-color: #eef4ff; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
.product-info a { font-size: 18px; font-weight: 600; color: #2a2a2a; text-decoration: none; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.product-meta { color: #666; font-size: 14px; margin-top: 6px; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.product-price { font-weight: bold; margin-top: 4px; font-size: 16px; color: #4e8fe1; }
</style>
</head>
<body>

<jsp:include page="include/header.jsp" />

<div class="main-container">
    <div class="sidebar">
        <form id="filterForm" method="get" action="secondhand_list.go">
            <h3>지역 선택</h3>
            <div id="area-radios"></div>
            <button type="button" id="btnUseMyLocation" style="margin-top:10px; padding:5px 10px;">우리 동네 보기</button>

            <hr>
            <h3>카테고리</h3>
            <c:forEach var="c" items="${categorylist}">
                <label>
                    <input type="radio" name="category" value="${c.category_code}" 
                        <c:if test="${param.category == c.category_code}">checked</c:if> >
                    ${c.category_name}
                </label>
            </c:forEach>

            <hr>
            <h3>가격 범위</h3>
            <input type="number" name="minPrice" placeholder="최소가격" value="${minPrice}" style="width: 33%; margin-bottom: 8px;" /> ~
            <input type="number" name="maxPrice" placeholder="최대가격" value="${maxPrice}" style="width: 33%; margin-bottom: 8px;" />
            <input type="submit" value="가격 검색" style="margin-top: 10px; width: 50%; background-color: #2b7cff; color: white; border: none; padding: 5px; border-radius: 6px; cursor: pointer;"/>
        </form>
    </div>

    <div class="content">
        <h1>중고 전자기기</h1>
        <div class="top-bar">
            <form class="search-bar" method="get" action="secondhand_list.go">
                <input type="text" name="keyword" placeholder="제품명을 입력하세요" value="${keyword}">
                <input type="submit" value="검색">
            </form>
        </div>
        <div class="product-list">
            <c:forEach var="p" items="${productList}">
                <c:set var="imgList" value="${fn:split(p.product_img, ',')}" />
                <div class="product-card" onclick="location.href='product_detail.go?product_num=${p.product_num}'">
                    <img src="<%=request.getContextPath() %>/resources/upload/${imgList[0]}" width="260px" height="260px">
                    <div class="product-info">
                        <a href="product_detail.go?product_num=${p.product_num}">${p.product_title}</a>
                        <div class="product-meta">${p.sales_area}</div>
                        <div class="product-price">
                            <c:choose>
                                <c:when test="${p.sales_price == 0}">무료 나눔</c:when>
                                <c:otherwise><fmt:formatNumber value="${p.sales_price}" type="number" />원</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" />

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC6GZL5JoPGTDsQqjhGD-dgKj7hRQSTxfE&" async defer></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const btn = document.getElementById('btnUseMyLocation');
    const areaRadioList = document.getElementById('area-radios');
    const filterForm = document.getElementById('filterForm');

    // 서버에서 내려준 기본 지역 배열
    const defaultAreas = [];
    <c:forEach items="${areas}" var="a">
        defaultAreas.push('${a}');
    </c:forEach>

    // 현재 선택된 지역
    let selectedArea = "<c:out value='${param.area}' default='' />";
    let useMyLocationMode = <c:out value='${isDongneMode}' default='false' /> === true;

    // AJAX로 제품 리스트를 갱신
    async function fetchProductList(params) {
        const query = new URLSearchParams(params).toString();
        const response = await fetch('secondhand_list.go?' + query, { method: 'GET' });
        if(!response.ok) throw new Error('서버 요청 실패');

        const htmlText = await response.text();
        // 서버에서 반환되는 HTML에서 product-list 부분만 추출
        const tempDiv = document.createElement('div');
        tempDiv.innerHTML = htmlText;
        const newList = tempDiv.querySelector('.product-list');
        document.querySelector('.product-list').innerHTML = newList.innerHTML;
    }

    // 지역 라디오 렌더링
    function updateAreaRadios(areaList) {
        areaRadioList.innerHTML = '';

        // 전체보기
        const labelAll = document.createElement('label');
        const inputAll = document.createElement('input');
        inputAll.type = 'radio';
        inputAll.name = 'area';
        inputAll.value = '';
        inputAll.checked = !selectedArea;
        inputAll.addEventListener('change', () => {
            selectedArea = '';
            triggerFilter();
        });
        labelAll.appendChild(inputAll);
        labelAll.appendChild(document.createTextNode(' 전체보기'));
        areaRadioList.appendChild(labelAll);

        // 동 목록
        areaList.forEach(area => {
            const label = document.createElement('label');
            const input = document.createElement('input');
            input.type = 'radio';
            input.name = 'area';
            input.value = area;
            input.checked = (area === selectedArea);
            input.addEventListener('change', () => {
                selectedArea = area;
                triggerFilter();
            });
            label.appendChild(input);
            label.appendChild(document.createTextNode(' ' + area));
            areaRadioList.appendChild(label);
        });
    }

    // 폼 값 읽어서 AJAX 요청
    function triggerFilter() {
        const params = {
            area: selectedArea,
            category: filterForm.querySelector('input[name="category"]:checked')?.value || '',
            minPrice: filterForm.querySelector('input[name="minPrice"]').value,
            maxPrice: filterForm.querySelector('input[name="maxPrice"]').value,
            keyword: filterForm.querySelector('input[name="keyword"]')?.value || ''
        };
        fetchProductList(params);
    }

    // 사용자 위치 가져오기
    async function getUserLocation() {
        return new Promise((resolve, reject) => {
            if(navigator.geolocation){
                navigator.geolocation.getCurrentPosition(pos => resolve({lat: pos.coords.latitude, lng: pos.coords.longitude}),
                                                        err => reject(err),
                                                        {enableHighAccuracy:true, timeout:5000});
            } else reject(new Error("브라우저가 위치 정보를 지원하지 않습니다."));
        });
    }

    // 위도/경도로 동 리스트 가져오기
    async function fetchDongListByCoords(lat, lng) {
        const geocoder = new google.maps.Geocoder();
        return new Promise((resolve, reject) => {
            geocoder.geocode({location: {lat, lng}}, (results, status) => {
                if(status === "OK" && results.length > 0){
                    let guName = null;
                    for(let r of results){
                        const match = r.formatted_address.match(/([가-힣]+(구|군))/);
                        if(match){ guName = match[1]; break; }
                    }
                    if(!guName){ reject("구(군) 이름을 찾을 수 없습니다."); return; }

                    fetch('/region/search?address=' + encodeURIComponent(guName))
                        .then(res => res.json())
                        .then(data => {
                            const dongList = data.map(item => {
                                const match = item.name.match(/([가-힣]+(동|면|리))$/);
                                return match? match[1] : null;
                            }).filter(n => n !== null);
                            resolve(dongList);
                        })
                        .catch(e => reject(e));
                } else reject("지오코딩 실패: " + status);
            });
        });
    }

    async function setMyLocationAreas() {
        try {
            const {lat, lng} = await getUserLocation();
            const dongList = await fetchDongListByCoords(lat, lng);
            if(dongList.length === 0) {
                alert("동(면,리) 정보를 찾을 수 없습니다.");
                return;
            }
            updateAreaRadios(dongList);
            useMyLocationMode = true;
        } catch(e) {
            console.error(e);
            alert("위치 정보를 가져오지 못했습니다.");
            useMyLocationMode = false;
        }
    }

    btn.addEventListener('click', async () => {
        if(!useMyLocationMode){
            await setMyLocationAreas();
            btn.textContent = '전체 지역 보기';
        } else {
            updateAreaRadios(defaultAreas);
            btn.textContent = '우리 동네 보기';
            useMyLocationMode = false;
        }
    });

    // 초기 렌더링
    updateAreaRadios(defaultAreas);

    // 카테고리, 가격 입력 이벤트도 AJAX로 처리
    filterForm.querySelectorAll('input[name="category"], input[name="minPrice"], input[name="maxPrice"]').forEach(el => {
        el.addEventListener('change', triggerFilter);
    });

    // 검색창 이벤트
    const keywordInput = filterForm.querySelector('input[name="keyword"]');
    if(keywordInput){
        keywordInput.addEventListener('keypress', e => {
            if(e.key === 'Enter'){
                e.preventDefault();
                triggerFilter();
            }
        });
    }
});
</script>
</body>
</html>
