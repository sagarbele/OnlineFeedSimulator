<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Online Feed Simulator</title>

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">

function regerateData() {
	
	var nfgRate = "";
	for(index=1;index< ${animalListSize+1} ; index++){
				var AnimalId=index.toString()+"animal";
				var parameter = index.toString()+"-";
				nfgRate=nfgRate.concat(parameter);
				nfgRate= nfgRate.concat(document.getElementById(AnimalId).value);
				if(index!=${animalListSize}){
					nfgRate=nfgRate.concat(",");}

	}

	var country="${countryId}";
	var property="${propertyName}";
	var unitIndex="${unitIndex}";

	jQuery.ajax({
		type : "GET",
		url : getContextPath() + "/scenarioRegenerateData.html",
		data : ({
			country : country,
			unitIndex : unitIndex,
			property : property,
			nfgRate : nfgRate

		}),
		success : function(data) {

			jQuery("#scenarioRegenerateData").html(data);

		}
	});

}


	function showResult() {
		
		var nfgRate = "";
		for(index=1;index< ${animalListSize+1} ; index++){
					var AnimalId=index.toString()+"animal";
					var parameter = index.toString()+"-";
					nfgRate=nfgRate.concat(parameter);
					nfgRate= nfgRate.concat(document.getElementById(AnimalId).value);
					if(index!=${animalListSize}){
						nfgRate=nfgRate.concat(",");}
	
		}

		window.location.href = getContextPath()
				+ "/finalReport.html?country=${countryId}&property=${propertyName}&unitIndex=${unitIndex}&nfgRate="+nfgRate; 
	}
	
	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}
</script>

</head>
<body>
<div>
	<table align="left" border="1">
		<tr>
			<td>${propertyValue}</td>&nbsp;&nbsp;&nbsp;<td>${country }</td>
			&nbsp;&nbsp;&nbsp;<td>${propertyName }</td>
			&nbsp;&nbsp;&nbsp;<td>${unitIndex }</td>
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
						<td><input type="text" id="${anList.animalId}animal"
							name="${anList.animalId}animal" size="8" maxlength="20"></td>
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
				<button type="button" onClick="regerateData();">Get
					Regenerate Graph</button>
			</td>
		</tr>
	</table>
	</div>
	<div name="scenarioRegenerateData" id="scenarioRegenerateData"></div>
</body>
</html>