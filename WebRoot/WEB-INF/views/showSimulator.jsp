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
			<c:choose>
				<c:when test="${not empty countryList}">
					<c:forEach items="${countryList}" var="country"
						varStatus="varStatus">
						<tr>
							<td>${country.countryName}</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
	</table>

	<table align="left" border="1">
		<tr>
			<th>Hi</th>
		</tr>
			<c:choose>
				<c:when test="${not empty animalData}">
					<c:forEach items="${animalData}" var="animal"
						varStatus="varStatus">
						<tr>
							<td>${animal.animalCount}</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
	</table>
  <h5><a href="getData.html">Get Data</a></h5>
</body>
</html>