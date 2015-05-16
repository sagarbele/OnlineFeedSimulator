    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="shortcut icon" href="assets/ico/favicon.png">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>OnlineFeedSimulator</title>
<!-- Bootstrap core CSS -->
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!-- Jasny Bootstrap-Extension CSS -->
<link href="assets/css/jasny-bootstrap.css" rel="stylesheet">
<link href="assets/css/bordered.css" rel="stylesheet">
<link href="assets/css/bootstrap-select.css" rel="stylesheet">
<link href="assets/css/bootstrap-datetimepicker.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="assets/css/main.css" rel="stylesheet">
<link
	href='https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Raleway:400,300,700'
	rel='stylesheet' type='text/css'>

<script type="text/javascript" src="assets/js/jquery.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>
<script type="text/javascript" src="assets/js/jasny-bootstrap.js"></script>
<script type="text/javascript" src="assets/js/bootstrap-select.js"></script>
<script type="text/javascript" src="assets/js/moment.js"></script>
<script type="text/javascript" src="assets/js/highcharts.js"></script>
<script type="text/javascript" src="assets/js/grid-light.js"></script>
<script type="text/javascript"
	src="assets/js/bootstrap-datetimepicker.min.js"></script>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#selectCountryVD').selectpicker({
							size : 'auto',
							maxOptions : 3
						});
						$('#selectCountrySA').selectpicker({
							size : 'auto',
							maxOptions : 1
						});
						$('#selectIndexVD').selectpicker({
							size : 'auto',
							width : '130px'
						});
						$('#selectIndexSA').selectpicker({
							size : 'auto',
							width : '130px'
						});
						$('#selectEnergyEquivalentVD').selectpicker({
							size : 'auto',
							width : '150px'
						});
						$('#selectEnergyEquivalentSA').selectpicker({
							size : 'auto',
							width : '150px'
						});

						
						

                      

	});

</script>


<script type="text/javascript">
	function getData() {
	//	console.log($('#selectCountry').val());
		if($('#selectCountryVD').val()==null)			
		{
			alert("please select at least one country for Visualize Data");
			return false;
		}
		var country = "";
		$.each($("#selectCountryVD option:selected"), function() {
			country = country.concat($(this).val());
			country = country.concat(",");
		});

        var property =  $("#selectIndexVD option:selected").val().trim().toString();
	 	var unitIndex =$("input[name='selectEnergyEquivalentVD']:checked").val();
				
		//alert(property);
		//alert(unitIndex);
		
		jQuery.ajax({
			type : "GET",
			url : getContextPath() + "/getData.html",
			data : ({
				country : country,
				unitIndex : unitIndex,
				property : property

			}),
			success : function(data) {

				jQuery("#animalData").html(data);

			}
		});

	}

	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}

	function getScenarioData() {
		if($('#selectCountrySA').val()==null)			
		{
			alert("please select any country for Scenario Analysis");
			return false;
		}
		else if($('#selectCountrySA').val().length>1)			
		{
			alert("please select only one country for Scenario Analysis");
			return false;
		}
		else if($('#selectIndexSA').val()=="")
		{
			alert("please select at least one commodity for Scenario Analysis");
			return false;
		}
		var country = "";
		$.each($("#selectCountrySA option:selected"), function() {
			country = country.concat($(this).val()).toString();
		});
		
		

		var property =  $("#selectIndexSA option:selected").val().trim()
        

		var unitIndex =$("input[name='selectEnergyEquivalentSA']:checked").val();
			
		
		
		window.location.href = getContextPath()
				+ "/showSimulator.html?country=" + country + "&property="
				+ property + "&unitIndex=" + unitIndex;
	}
	
function goHome() {

window.location.href = getContextPath();
}	
function showScenario() {
window.location.href = getContextPath()
				+ "/showSimulator.html?country=" + 0 + "&property="
				+ 0 + "&unitIndex=" + 0;

}	

</script>


</head>
<body>
<body id="pageBody" style="background-color: #D7D6D4">
<div id="wrapper">
    <div id="navigation" class="banner" style="">
        <div>
            <div class="container">
                <div id="c134044" class="csc-default">
                    <p class="bodytext"><a href="http://www.amis-outlook.org/" title="AMIS homepage" class="internal-link"><img
                            alt="AMIS homepage" src="assets/img/amis_logo.jpg" height="129" width="260"></a></p>
                </div>
            </div>
        </div>
    </div>
    <ol class="breadcrumb">
        <li><a class="active"  style="cursor:pointer; color: #A9A9A9;"  onclick="goHome();">Visualize estimated feed demand</a></li>
		<li><a style="cursor:pointer;"   onclick="showScenario();">Scenario Analysis </a></li>
		<li style="float: right"><a style="cursor:pointer;" onclick="goHome();">HOME </a></li>
    </ol>

	<div class="container" id="page" style="padding-top: 0px">
		<div id="visualizeDiv">
		
		         <div class="row" style="background-color:CornflowerBlue; ">
					<div class="col-md-3" id="formTabOne">
						<div class="form-group" id="countryIdList">
							<label for="selectCountry" style="color:white">Select country<br /> (up to three)</label> 
						</div>
					</div>
					<div class="col-md-4" id="formTabThree">
						<div class="form-group" id="unitFormGroup"  >
							<label for="selectEnergyEquivalent" style="color:white">Select whether results should show energy or protein requirements </label><br/>
						</div>
					</div>
					<div class="col-md-3" id="formTabTwo">
						<div class="form-group" id="eeFormGroup">
							<label for="selectIndex" style="color:white">Select base commodity as reference</label> <br />
						</div>
					</div>
				
                </div>	
		
		<div  class="row"  style="background-color:CornflowerBlue; ">
			<div class="col-md-3" id="formTabOne">
				<div class="form-group" id="countryIdList">
					<select
						id="selectCountryVD" multiple="multiple" class="selectBox"
						title='Choose one or more..' data-live-search="true">
						<c:choose>
							<c:when test="${not empty countryList}">
								<c:forEach items="${countryList}" var="country"
									varStatus="varStatus">
									<option name="cList" value="${country.countryId}">
										${country.countryName}</option>
								</c:forEach>
							</c:when>
						</c:choose>


					</select>
				</div>
			</div>

			<div class="col-md-4" id="formTabThree">
				<div class="form-group" id="unitFormGroup">
					 <label style="color:white"><input type="radio" name="selectEnergyEquivalentVD" value="Energy" checked="checked" >Energy(1000 GJ)</label> 
					 <label style="color:white"><input type="radio" name="selectEnergyEquivalentVD" value="Protein" >Protein(1000 MT)</label>
				</div>
			</div>
			<div class="col-md-3" id="formTabTwo">
				<div class="form-group" id="eeFormGroup">
					<select class="selectBox"
						id="selectIndexVD" title='Choose one or more..'>
						<option selected="selected" value="">None</option>
						<c:choose>
							<c:when test="${not empty propertyList}">
								<c:forEach items="${propertyList}" var="property"
									varStatus="varStatus">
									<option name="pList" value="${property.propertyName}">
										${property.propertyName}</option>
								</c:forEach>
							</c:when>
						</c:choose>
					</select>
				</div>
			</div>

			<div class="col-md-2" id="buttonTab">
				<button type="button" id="visualize" class="btn btn-default" style="height: 32px; width: 120px" onClick="getData();">Proceed</button>
			</div>

		</div>
		</div>
		<div name="animalData" id="animalData"></div>
	</div>
	</div>

</body>
</body>
</html>