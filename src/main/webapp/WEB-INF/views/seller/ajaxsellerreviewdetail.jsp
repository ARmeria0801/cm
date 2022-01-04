<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div style="padding-top: 50px; padding-bottom: 50px">
	<c:if test="${review.rev_filename != null }"><img src="/resources/images/reviewimage/${review.rev_filename}" width="200" /><br></c:if>
	${review.rev_content}
</div>
