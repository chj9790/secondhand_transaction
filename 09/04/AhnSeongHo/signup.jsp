<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f7fb;
    margin: 0;
    padding: 0;
}

/* 메인 컨테이너 */
.signup-container {
    max-width: 600px;
    margin: 40px auto;
    padding: 0 20px;
}

.signup-title {
    text-align: center;
    font-size: 28px;
    color: #2b7cff;
    margin-bottom: 30px;
    font-weight: 600;
}

/* 폼 스타일 */
.signup-form {
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    padding: 30px;
    border: 1px solid #e0e0e0;
}

.form-table {
    width: 100%;
    border-collapse: collapse;
    border: none;
}

.form-table tr {
    border-bottom: 1px solid #f0f0f0 !important;
}

.form-table tr:last-child {
    border-bottom: none;
}

.form-table th {
    background-color: #f8fbff !important;
    padding: 15px 20px;
    text-align: left;
    font-weight: 500 !important;
    color: #2b7cff !important;
    border: none !important;
    width: 120px;
    vertical-align: top;
    font-size: 14px !important;
    font-family: 'Segoe UI', sans-serif !important;
}

.form-table td {
    padding: 15px 20px;
    border: none !important;
    vertical-align: top;
    font-family: 'Segoe UI', sans-serif !important;
}

/* 입력 필드 스타일 */
.form-input {
    padding: 10px 12px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 6px;
    transition: all 0.2s ease;
    font-family: 'Segoe UI', sans-serif;
}

.form-input:focus {
    outline: none;
    border-color: #2b7cff;
    box-shadow: 0 0 0 2px rgba(43, 124, 255, 0.1);
}

/* 텍스트 입력 필드 너비 */
input[type="text"], 
input[type="password"], 
input[type="number"] {
    width: 200px;
}

/* 선택 박스 스타일 */
select {
    padding: 10px 8px;
    font-size: 14px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background-color: white;
    font-family: 'Segoe UI', sans-serif;
    transition: all 0.2s ease;
}

select:focus {
    outline: none;
    border-color: #2b7cff;
    box-shadow: 0 0 0 2px rgba(43, 124, 255, 0.1);
}

/* 버튼 스타일 */
.btn {
    background-color: transparent;
    border: 1px solid #2b7cff;
    padding: 8px 16px;
    border-radius: 6px;
    font-size: 14px;
    color: #2b7cff;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.25s ease;
    font-family: 'Segoe UI', sans-serif;
}

.btn:hover {
    background-color: #2b7cff;
    color: white;
}

.btn-primary {
    background-color: #2b7cff;
    color: white;
    padding: 12px 24px;
    font-size: 15px;
    margin: 0 8px;
}

.btn-primary:hover {
    background-color: #1f5fcf;
}

.btn-secondary {
    background-color: #f8f9fa;
    border: 1px solid #ddd;
    color: #666;
    padding: 12px 24px;
    font-size: 15px;
    margin: 0 8px;
}

.btn-secondary:hover {
    background-color: #e9ecef;
    color: #495057;
}

/* 검증 메시지 스타일 */
.validation-message {
    margin-top: 8px;
    font-size: 12px;
    line-height: 1.4;
}

/* 이메일 입력 영역 */
.email-input-group {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
}

.email-input-group input[type="text"] {
    width: 120px;
}

.email-input-group select {
    min-width: 120px;
}

/* 전화번호 입력 영역 */
.phone-input-group {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
}

.phone-input-group select {
    width: 70px;
}

.phone-input-group input[type="text"] {
    width: 80px;
}

/* 주소 입력 영역 */
.address-input-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.address-input-group input[type="text"] {
    width: 140px;
}

/* 버튼 그룹 */
.button-group {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #f0f0f0;
    margin-top: 20px;
}

/* 반응형 */
@media screen and (max-width: 768px) {
    .signup-container {
        margin: 20px auto;
        padding: 0 15px;
    }
    
    .signup-form {
        padding: 20px 15px;
    }
    
    .form-table th,
    .form-table td {
        padding: 12px 10px;
        display: block;
        width: 100%;
    }
    
    .form-table th {
        background-color: transparent;
        font-weight: 600;
        color: #2b7cff;
        padding-bottom: 5px;
    }
    
    .form-table td {
        padding-top: 0;
        padding-bottom: 15px;
    }
    
    input[type="text"], 
    input[type="password"], 
    input[type="number"] {
        width: 100%;
        max-width: 300px;
    }
    
    .email-input-group,
    .phone-input-group {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .address-input-group {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .address-input-group input[type="text"] {
        width: 100%;
        max-width: 300px;
    }
}
</style>

<script>
// 실시간 검사(클라이언트 검사)
document.addEventListener("DOMContentLoaded", function() {
    const userIdInput = document.getElementById("user_id");
    const passwordInput = document.getElementById("user_pwd");
    const confirmInput = document.getElementById("user_pwd_confirm");
    const idMessage = document.getElementById("check_result");
    const pwdMessage = document.getElementById("pwd_check_result");
    const pwdConfirmMessage = document.getElementById("pwd_confirm_result");
    const nameInput = document.getElementById("user_name");
    const nameMessage = document.getElementById("name_check_result");
    const nicknameInput = document.getElementById("user_nickname");
    const nicknameMessage = document.getElementById("nickname_check_result");

    const idRegex = /^[a-zA-Z0-9]{6,12}$/;
    const pwdRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_]).{8,16}$/;
    const nameRegex = /^[가-힣]+$/; 

    // 아이디 유효성 검사
    userIdInput.addEventListener("input", function() {
        if (userIdInput.value.length === 0) {
            idMessage.innerText = "";
            return;
        }
        if (!idRegex.test(userIdInput.value)) {
            idMessage.innerText = "아이디는 6~12자 영문과 숫자의 조합이어야 합니다.";
            idMessage.style.color = "red";
        } else {
            idMessage.innerText = "";
        }
    });

    // 비밀번호 유효성 검사
    passwordInput.addEventListener("input", function() {
        if (passwordInput.value.length === 0) {
            pwdMessage.innerText = "";
            return;
        }
        if (!pwdRegex.test(passwordInput.value)) {
            pwdMessage.innerText = "비밀번호는 8~16자리이면서 영문자, 숫자, 특수문자를 모두 포함해야 합니다.";
            pwdMessage.style.color = "red";
        } else {
            pwdMessage.innerText = "사용 가능한 비밀번호입니다.";
            pwdMessage.style.color = "#2b7cff";
        }
        checkPasswordConfirm();
    });

    confirmInput.addEventListener("input", checkPasswordConfirm);

    function checkPasswordConfirm() {
        if (confirmInput.value.length === 0) {
            pwdConfirmMessage.innerText = "";
            return;
        }
        if (passwordInput.value === confirmInput.value) {
            pwdConfirmMessage.innerText = "비밀번호가 일치합니다.";
            pwdConfirmMessage.style.color = "#2b7cff";
        } else {
            pwdConfirmMessage.innerText = "비밀번호가 일치하지 않습니다.";
            pwdConfirmMessage.style.color = "red";
        }
    }

    // 이름 유효성 검사
    nameInput.addEventListener("input", function() {
        if (nameInput.value.length === 0) {
            nameMessage.innerText = "";
            return;
        }
        if (!nameRegex.test(nameInput.value)) {
            nameMessage.innerText = "이름은 한글만 입력 가능합니다.";
            nameMessage.style.color = "red";
        } else {
            nameMessage.innerText = "";
        }
    });

    // 닉네임 유효성 검사
    nicknameInput.addEventListener("input", function() {
        if (nicknameInput.value.length === 0) {
            nicknameMessage.innerText = "";
            return;
        }
        const nicknameRegex = /^[가-힣a-zA-Z0-9_]{2,20}$/;
        if (!nicknameRegex.test(nicknameInput.value)) {
            nicknameMessage.innerText = "닉네임은 2~20자, 한글, 영문, 숫자, _만 가능합니다.";
            nicknameMessage.style.color = "red";
        } else {
            nicknameMessage.innerText = "";
        }
    });

    // 이메일 도메인 직접입력 표시 제어
    document.querySelector("select[name='email_domain']").addEventListener("change", function() {
        const customInput = document.getElementById("email_custom");
        if (this.value === "direct") {
            customInput.style.display = "inline";
        } else {
            customInput.style.display = "none";
            customInput.value = "";
        }
    });
});

// 아이디 중복 검사
function checkDuplicate() {
    const userId = document.getElementById("user_id").value.trim();
    const checkResult = document.getElementById("check_result");

    if (userId.length === 0) {
        checkResult.innerText = "아이디를 입력해주세요.";
        checkResult.style.color = "red";
        return;
    }

    fetch("/check_id.go?user_id=" + encodeURIComponent(userId))
        .then(response => response.text())
        .then(result => {
            checkResult.innerText = result;
            checkResult.style.color = result.includes("사용 가능한") ? "#2b7cff" : "red";
        })
        .catch(() => {
            checkResult.innerText = "서버 오류 발생";
            checkResult.style.color = "red";
        });
}

// 닉네임 중복 검사
function checkNicknameDuplicate() {
    const nickname = document.getElementById("user_nickname").value.trim();
    const nicknameResult = document.getElementById("nickname_check_result");

    if (nickname.length === 0) {
        nicknameResult.innerText = "닉네임을 입력해주세요.";
        nicknameResult.style.color = "red";
        return;
    }

    fetch("/check_nickname.go?user_nickname=" + encodeURIComponent(nickname))
        .then(response => response.text())
        .then(result => {
            nicknameResult.innerText = result;
            nicknameResult.style.color = result.includes("사용 가능한") ? "#2b7cff" : "red";
        })
        .catch(() => {
            nicknameResult.innerText = "서버 오류 발생";
            nicknameResult.style.color = "red";
        });
}
</script>

</head>
<body>

	<div>
        <jsp:include page="include/header.jsp" />
    </div>

    <div class="signup-container">
        <h2 class="signup-title">회원가입</h2>
        <form method="post" action="/sign_up_ok.go" class="signup-form">
            <table class="form-table">
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" name="user_id" id="user_id" class="form-input" required>
                        <button type="button" class="btn" onclick="checkDuplicate()">중복확인</button>
                        <div id="check_result" class="validation-message"></div>
                    </td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td>
                        <input type="text" name="user_nickname" id="user_nickname" maxlength="20" class="form-input" required>
                        <button type="button" class="btn" onclick="checkNicknameDuplicate()">중복확인</button>
                        <div id="nickname_check_result" class="validation-message"></div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input type="password" name="user_pwd" id="user_pwd" class="form-input" required>
                        <div id="pwd_check_result" class="validation-message"></div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td>
                        <input type="password" name="user_pwd_confirm" id="user_pwd_confirm" class="form-input" required>
                        <div id="pwd_confirm_result" class="validation-message"></div>
                    </td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>
                        <input type="text" name="user_name" id="user_name" class="form-input" required>
                        <div id="name_check_result" class="validation-message"></div>
                    </td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td><input type="number" name="user_age" class="form-input" required></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>
                        <div class="email-input-group">
                            <input type="text" name="email_id" placeholder="이메일 아이디" class="form-input" required>
                            <span>@</span>
                            <select name="email_domain" required>
                                <option value="">--선택--</option>
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="daum.net">daum.net</option>
                                <option value="nate.com">nate.com</option>
                                <option value="direct">직접입력</option>
                            </select>
                            <input type="text" name="email_custom" id="email_custom" class="form-input" style="display: none;">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>
                        <div class="phone-input-group">
                            <select name="phone1" required>
                                <option value="010">010</option>
                                <option value="011">011</option>
                                <option value="016">016</option>
                            </select>
                            <span>-</span>
                            <input type="text" name="phone2" maxlength="4" minlength="3" pattern="\d{3,4}" placeholder="3~4자리" class="form-input" required>
                            <span>-</span>
                            <input type="text" name="phone3" maxlength="4" minlength="4" pattern="\d{4}" placeholder="4자리" class="form-input" required>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>우편번호</th>
                    <td>
                        <div class="address-input-group">
                            <input type="text" name="user_zipcode" id="user_zipcode" class="form-input" readonly required>
                            <button type="button" class="btn" onclick="openPostcode()">주소 검색</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>기본주소</th>
                    <td><input type="text" name="user_addr_base" id="user_addr_base" class="form-input" readonly required style="width: 300px;"></td>
                </tr>
                <tr>
                    <th>상세주소</th>
                    <td><input type="text" name="user_addr_detail" id="user_addr_detail" class="form-input" required style="width: 300px;"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="button-group">
                            <input type="submit" value="가입하기" class="btn btn-primary">
                            <input type="reset" value="다시작성" class="btn btn-secondary">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
    <div>
        <jsp:include page="include/footer.jsp" />
    </div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function openPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('user_zipcode').value = data.zonecode;
            document.getElementById('user_addr_base').value = data.address;
            document.getElementById('user_addr_detail').focus();
        }
    }).open();
}
</script>

</body>
</html>
