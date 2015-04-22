
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

						$('#selectCountry').selectpicker({
							size : 'auto',
							maxOptions : 3
						});
						$('#selectIndex').selectpicker({
							size : 'auto',
							width : '130px'
						});
						$('#selectEnergyEquivalent').selectpicker({
							size : 'auto',
							width : '150px'
						});

						if ($('#selectCountry').val() != null
								&& $('#selectEnergyEquivalent').val() != ""
								&& $('#selectIndex').val() != ""
								&& $('#selectCountry').val().length > 1) {
							$('#scenarioAnalysis').prop('disabled', true);
							$('#visualize').prop('disabled', false);
							console.log('disabled: '
									+ $('#selectCountry').val().length);
						} else if ($('#selectCountry').val() != null
								&& $('#selectEnergyEquivalent').val() != ""
								&& $('#selectIndex').val() != ""
								&& $('#selectCountry').val().length < 2) {
							$('#scenarioAnalysis').prop('disabled', false);
							$('#visualize').prop('disabled', false);
							console.log('enabled: '
									+ $('#selectCountry').val().length);
						} else {
							$('#scenarioAnalysis').prop('disabled', true);
							$('#visualize').prop('disabled', true);
						}

						$('.selectBox')
								.change(
										function() {

											if ($('#selectCountry').val() != null
													&& $(
															'#selectEnergyEquivalent')
															.val() != ""
													&& $('#selectIndex').val() != ""
													&& $('#selectCountry')
															.val().length > 1) {
												$('#scenarioAnalysis').prop(
														'disabled', true);
												$('#visualize').prop(
														'disabled', false);
												console.log('disabled: '
														+ $('#selectCountry')
																.val().length);
											} else if ($('#selectCountry')
													.val() != null
													&& $(
															'#selectEnergyEquivalent')
															.val() != ""
													&& $('#selectIndex').val() != ""
													&& $('#selectCountry')
															.val().length < 2) {
												$('#scenarioAnalysis').prop(
														'disabled', false);
												$('#visualize').prop(
														'disabled', false);
												console.log('enabled: '
														+ $('#selectCountry')
																.val().length);
											} else {
												$('#scenarioAnalysis').prop(
														'disabled', true);
												$('#visualize').prop(
														'disabled', true);
											}

											console.log($(
													'#selectEnergyEquivalent')
													.val());

										});

					});
</script>


<script type="text/javascript">
	function getData() {

		var country = "";
		$.each($("#selectCountry option:selected"), function() {
			country = country.concat($(this).val());
			country = country.concat(",");
		});

		var property = $("#selectEnergyEquivalent option:selected").val()
				.trim().toString();

		var unitIndex = $("#selectIndex option:selected").val().trim()
				.toString();

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
		var country = "";
		$.each($("#selectCountry option:selected"), function() {
			country = country.concat($(this).val());
		});

		var property = $("#selectEnergyEquivalent option:selected").val()
				.trim().toString();

		var unitIndex = $("#selectIndex option:selected").val().trim()
				.toString();

		window.location.href = getContextPath()
				+ "/showSimulator.html?country=" + country + "&property="
				+ property + "&unitIndex=" + unitIndex;
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
						<p class="bodytext">
							<a href="http://www.amis-outlook.org/" title="AMIS homepage"
								class="internal-link"><img alt="AMIS homepage"
								src="assets/img/amis_logo.jpg" height="129" width="260"></a>
						</p>
					</div>
				</div>
			</div>
		</div>
		<ol class="breadcrumb">
			<li><a class="active">Online Feed Simulator</a></li>
		</ol>

		<div class="container" id="page" style="padding-top: 60px">
			<div class="row">
				<div class="col-md-4" id="formTabOne">
					<div class="form-group" id="countryIdList">
						<label for="selectCountry">Select Countries</label> <br /> <select
							id="selectCountry" multiple="multiple" class="selectBox"
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
				<div class="col-md-4" id="formTabTwo">
					<div class="form-group" id="eeFormGroup">
						<label for="selectEnergyEquivalent">Select Energy
							Equivalent</label> <br /> <select class="selectBox"
							id="selectEnergyEquivalent" title='Choose one or more..'>
							<option selected="selected" value="">Select one</option>
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
				<div class="col-md-4" id="formTabThree">
					<div class="form-group" id="unitFormGroup">
						<label for="selectIndex">Select Unit Index</label><br /> <select
							class="selectBox" id="selectIndex">
							<option selected="selected" value="">Select one</option>
							<option value="Energy">Energy(kcal)</option>
							<option value="Protein">Protein</option>
						</select>
					</div>
				</div>
			</div>

			<div class="row" style="margin-top: 30px">
				<div class="col-md-1">
					<button type="button" id="visualize" class="btn btn-default"
						onClick="getData();">Visualize</button>
				</div>

				<div class="col-md-1" style="margin-left: 20px">
					<button type="button" class="btn btn-default" id="scenarioAnalysis"
						onClick="getScenarioData();">Scenario Analysis</button>
				</div>
				<div class="col-md-6"></div>
			</div>

			<div name="animalData" id="animalData"></div>
		</div>
	</div>

</body>
</body>
</html>