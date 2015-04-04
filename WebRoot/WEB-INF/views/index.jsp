<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>OnlineFeedSimulator</title>
    
    <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<!-- 
	<script type="text/javascript">
	
		$(document).ready(function() {
	
			$("button").click(function() {
	
				var favorite = [];
	
				$.each($("input[name='cList']:checked"), function() {
					favorite.push($(this).val());
				});
				alert("My favourite sports are: " + favorite.join(", "));
			});
		});
	</script>
	 -->
	<script type="text/javascript">
	
	function getData()
	{
		var country="";
		$.each($("input[name='cList']:checked"), function() {
		     var con = $(this).val().trim().toString(); 
		     country = country.concat(con);
		     country = country.concat(",");
		});  
		

		var property="";
		$.each($("input[name='pList']:checked"), function() {
		     var prop = $(this).val().trim().toString(); 
		     property = property.concat(prop);
		});  
		

		var unitIndex="";
		$.each($("input[name='unitIndex']:checked"), function() {
		     var uIndex = $(this).val().trim().toString(); 
				unitIndex = unitIndex.concat(uIndex);
		});  
		
		alert(unitIndex);
		alert(property);
		alert(country);
		
		jQuery.ajax({
			type : "GET",	
			url : getContextPath() + "/getData.html",
			data : ({
				country	: country,
				unitIndex : unitIndex,
				property : property
				
			}),
			success : function(data) {
				
				jQuery("#animalData").html(data);	
				
			}
			});
			
	}
	
	function getContextPath(){		
		pn = location.pathname;
		len = pn.indexOf("/", 1);				
		cp = pn.substring(0, len);
		return cp;
	}
	</script>
	
    
  </head>
  <body>
    <form class="box" method="post" action="showSimulator.html?country=1" id="countryForm">
        <table align="left" border="1">
		<tr>
				<th>Hi ${propertyValue}</th>
		</tr>
		<tr>	<td>		
			<c:choose>
				<c:when test="${not empty countryList}">
					<c:forEach items="${countryList}" var="country"
						varStatus="varStatus">
										
							<input type="checkbox" name="cList" value="${country.countryId}">${country.countryName} &nbsp;&nbsp;&nbsp;&nbsp;
							
					</c:forEach>
					
				</c:when>
			</c:choose>	
			</td>
		</tr>
		<tr>
		<td>
			<c:choose>
				<c:when test="${not empty propertyList}">
					<c:forEach items="${propertyList}" var="property"
						varStatus="varStatus">
			
							<input type="checkbox" name="pList" value="${property.propertyName}">${property.propertyName} &nbsp;&nbsp;&nbsp;&nbsp;
			
					</c:forEach>
				</c:when>
			</c:choose>
			</td>
			</tr>
			<tr><td>
				<input type="checkbox" id="unitIndex" name="unitIndex" value="Protein">Protein
				<input type="checkbox" id="unitIndex" name="unitIndex" value="Energy">Energy				
			</td></tr>
			<tr><td>
			<input type="submit" value="Scenario Analysis" class="ui-button ui-widget ui-state-default ui-corner-all" />
			  <button type="button" onClick="getData();">Get Graph/Charts</button>
			</td>
			</tr>
	</table>
	</form>
	<div name="animalData" id="animalData">
	</div>
  </body>
</html>