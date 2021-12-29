<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<input type="hidden" name="rev_num" value="${review.rev_num}" />
 <input type="hidden" name="page" value="${page}" />
	
<c:if test="${empty review.rev_filename}">
	${review.rev_content}
</c:if>
<c:if test="${!empty review.rev_filename}">
	<img src="<%=request.getContextPath() %>/resources/images/reviewimage/${review.rev_filename}" height="100" width="100" />
	<br><br>${review.rev_content}
</c:if>
