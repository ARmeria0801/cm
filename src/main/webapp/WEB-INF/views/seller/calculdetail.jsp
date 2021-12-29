<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<td colspan="10">
				${calculate.clcln_num}
				${calculate.ord_num}
				${calculate.sel_num}
				${calculate.gds_num}
				${calculate.ord_totalprice}
				${calculate.clcln_amount}
				${calculate.clcln_bank}
				${calculate.clcln_appdate}
				${calculate.clcln_comdate}
				${calculate.clcln_status}
				${goods.lcate_code}
				${goods.mcate_code}
				${goods.scate_code}
				${goods.gds_name}
				${goods.gds_price}
				<c:choose>
					<c:when test="${option.opt_2ndval != null}">
						${option.opt_1stname} : ${option.opt_1stval}	<br>
						${option.opt_2ndname} : ${option.opt_2ndval}
					</c:when>
					<c:when test="${option.opt_1stval != null}">
						${option.opt_1stname} : ${option.opt_1stval}
					</c:when>
					<c:otherwise>
						-
					</c:otherwise>
				</c:choose>
				${order.ol_count}
				<%-- ${order.deltem_delfee} --%>
				${order.ord_request}
			</td>
		</tr>
	</table>
</body>
</html>