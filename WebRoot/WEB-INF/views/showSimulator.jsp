<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Animal Data</title>
</head>
<body>

	<table align="left" border="1">
		<tr>
			<th>Hi</th>
		</tr>
		<tr>
			<td>${propertyValue }</td>
		</tr>
		<tr>

			<c:choose>
				<c:when test="${not empty countryList}">
					<c:forEach items="${countryList}" var="country"
						varStatus="varStatus">

						<td>${country.countryName}</td>

					</c:forEach>
				</c:when>
			</c:choose>

		</tr>
	</table>

	<table align="left" border="1">
		<tr>
			<th>Hi</th>
		</tr>
		<tr>
			<td>${countryData}</td>
		</tr>
	</table>
</body>
</html>