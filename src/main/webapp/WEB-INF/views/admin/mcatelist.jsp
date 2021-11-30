<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중분류 리스트</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adminmain.jsp"></jsp:include>
	<table border="1" width="1000" align="center">
    	<tr>
        	<td>카테고리 분류</td>
            <td>카테고리 이름</td>
        </tr>
        <c:forEach var="McateVO" items="${mcatelist}">
        <tr>
    	<td><c:out value="${McateVO.mcate_code}" /></td>
    	<td><c:out value="${McateVO.mcate_name}" /></td>
    	<td><c:out value="${McateVO.lcate_code}" /></td>
    	</tr>
		</c:forEach>   
    </table>
</body>
</html>