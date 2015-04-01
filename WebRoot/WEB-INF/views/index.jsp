<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>OnlineFeedSimulator</title>
  </head>
  <body>
    <form class="box" method="post" action="showSimulator.html?countryId=1" id="countryForm">
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
			<tr><td>
			<input type="submit" value="Get Data" class="ui-button ui-widget ui-state-default ui-corner-all" />
			</td>
			</tr>
	</table>
	</form>
  </body>
</html>