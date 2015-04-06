<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Online Feed Simulator</title>
<script type="text/javascript">

	function showResult() {
		
		var href = "";
		var index=0;
		for(index=0;index< animalList.size; index++){
			href = href.concat(animalList.animalName);
		}
		alert(href);
		/* 
		window.location.href = getContextPath()
				+ "/showSimulator.html?country=" + country + "&property="
				+ property + "&unitIndex=" + unitIndex; */
	}
</script>

</head>
<body>

	<table align="left" border="1">
		<tr>
			<td>${propertyValue}</td>
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

	<table id="nonForageRate" align="left" border="1">

		<c:choose>
			<c:when test="${not empty animalList}">
				<c:forEach items="${animalList}" var="anList" varStatus="varStatus">
					<tr>
						<td>${anList.animalName}</td>
						<td><input type="text" id="${anList.animalId}"
							name="${anList.animalId}" size="8" maxlength="7"></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	<table align="left" border="1">
		<tr>
			<td>${animalRawData}</td>
		</tr>
		<tr>
			<td>${aquacultureData}</td>
		</tr>
	</table>
	<table>
		<tr>
			<td>
				<button type="button" onClick="showResult();">Show Results</button>
			</td>
			</tr>
	</table>
</body>
</html>