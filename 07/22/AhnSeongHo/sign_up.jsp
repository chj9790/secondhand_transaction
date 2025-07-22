<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>

<script>
	function checkDuplicate() {
	    const userId = document.getElementById("user_id").value;
	    const checkResult = document.getElementById("check_result");
	
	    fetch("/check_id.go?user_id=" + encodeURIComponent(userId))
	        .then(response => response.text())
	        .then(result => {
	            checkResult.innerText = result;
	
	            
	            if (result.includes("사용 가능한 아이디입니다.")) {
	                checkResult.style.color = "blue";  
	            } else {  // 빈칸 or 중복
	                checkResult.style.color = "red";   
	            }
	        })
	        .catch(() => {
	            checkResult.innerText = "서버 오류 발생";
	            checkResult.style.color = "red";
	        });
	}
	
	function validateForm() {
        const pwd = document.querySelector("input[name='user_pwd']").value;
        const confirm = document.getElementById("user_pwd_confirm").value;

        if (pwd !== confirm) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        return true;
    }
	
	function passwordMatch() {
        const pwd = document.querySelector("input[name='user_pwd']").value;
        const confirm = document.getElementById("user_pwd_confirm").value;
        const pwdCheckResult = document.getElementById("pwd_check_result");

        if (confirm.length === 0) {
            pwdCheckResult.innerText = ""; 
            return;
        }

        if (pwd === confirm) {
            pwdCheckResult.innerText = "비밀번호가 일치합니다.";
            pwdCheckResult.style.color = "blue";
        } else {
            pwdCheckResult.innerText = "비밀번호가 일치하지 않습니다.";
            pwdCheckResult.style.color = "red";
        }
    }
	
</script>

</head>
<body>
    <div>
        <h2>회원가입</h2>
        <form method="post" action="/sign_up_ok.go" onsubmit="return validateForm()">
            <table border="1" width="400">
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" name="user_id" id="user_id" required>
                        <button type="button" onclick="checkDuplicate()">중복확인</button>
                        <div id="check_result" style="margin-top: 5px;"></div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="user_pwd" required></td>
                </tr>
                <tr>
				    <th>비밀번호 확인</th>
				    <td>
					    <input type="password" id="user_pwd_confirm" required oninput="passwordMatch()">
					    <div id="pwd_check_result" style="margin-top: 5px;"></div>
				    </td>
				</tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="user_name" required></td>
                </tr>
                <tr>
                    <th>나이</th>
                    <td><input type="number" name="user_age" required></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="user_email" required></td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td><input type="text" name="user_phone" required></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td><input type="text" name="user_addr" required></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="가입하기">
                        <input type="reset" value="다시작성">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
