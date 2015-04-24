<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="shortcut icon" href="assets/ico/favicon.png">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Feed Simulator</title>
<!-- Bootstrap core CSS -->
<link href="assets/css/bootstrap.css" rel="stylesheet">
<!-- Jasny Bootstrap-Extension CSS -->
<link href="assets/css/jasny-bootstrap.css" rel="stylesheet">
<link href="assets/css/bootstrap-select.css" rel="stylesheet">
<link href="assets/css/bordered.css" rel="stylesheet">
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
function regerateData() {
	
		var animalData = ${animalRawData};
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		
		var countryName = "${countryName}";
		var resultArray = [];
		var arrYears = ${yearList};
		var yearSelected = $("#selectYear option:selected").val();
		alert(yearSelected);
		if(yearSelected==""){
			var latestYear = arrYears[arrYears.length - 1];
		}	
		else{
			latestYear=yearSelected;
		}
		var myarray = [];
		for ( var dataType = 0; dataType < 2; dataType++) {
			resultArray.push(latestYear);
			var unitIndx = "${unitIndex}";
				if (unitIndx == "Energy") {
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
						var animalName=arrayAnimalName[animalIndex].trim();
						var nutritionEnergy = 0;
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (animalName == animalData[increment].animalName) {
									
										if (latestYear == animalData[increment].year) {
											var energyIndex = animalData[increment].energyUnitIndex;
											if(dataType==0){
												var energyIndex = animalData[increment].energyUnitIndex;
												if (energyIndex != null
														&& energyIndex !== undefined) {
													nutritionEnergy = nutritionEnergy
															+ (animalData[increment].animalCount
																	* animalData[increment].nonForageRate * energyIndex);
												}
											}
											else{
												var AnimalIdNfg=(animalIndex+1).toString()+"animalNfg";
												var AnimalIdCount=(animalIndex+1).toString()+"animalCount";
												var AnimalIdEnergy=(animalIndex+1).toString()+"animalEnergy";
												
												
													nutritionEnergy = nutritionEnergy
															+ (document.getElementById(AnimalIdCount).value
																	* document.getElementById(AnimalIdNfg).value * document.getElementById(AnimalIdEnergy).value);
												
											}
										}
									
									
								}
							}
						}
						resultArray.push(nutritionEnergy * 0.319);
					}
				} else {
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
							var animalName=arrayAnimalName[animalIndex].trim();
						var nutritionProtein = 0;
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (animalName == animalData[increment].animalName) {
									
										if (latestYear == animalData[increment].year) {
											if(dataType==0){
												var proteinIndex = animalData[increment].proteinUnitIndex;
												if (proteinIndex != null
														&& proteinIndex !== undefined) {
													nutritionProtein = nutritionProtein
															+ (animalData[increment].animalCount
																	* animalData[increment].nonForageRate * proteinIndex);
													}
												}
											else{
												var AnimalIdNfg=(animalIndex+1).toString()+"animalNfg";
												var AnimalIdCount=(animalIndex+1).toString()+"animalCount";
												var AnimalIdProtein=(animalIndex+1).toString()+"animalProtein";
												
												console.log(AnimalIdNfg);
												
													nutritionProtein = nutritionProtein
															+ (document.getElementById(AnimalIdCount).value
																	* document.getElementById(AnimalIdNfg).value * document.getElementById(AnimalIdProtein).value);
														
												}
											}
									
											
								}
							}
							resultArray.push(nutritionProtein * 35600);
						}
					}
				}
			
				if(dataType==0){
				var item = {
				name : "Existing Data",
				data : [ resultArray[1], resultArray[2],
						 resultArray[3], resultArray[4],
						 resultArray[5], resultArray[6],
						 resultArray[7], resultArray[8]]
					};
				myarray.push(item);
				}
				else{
					var item = {
					name : "Modified Data",
					data : [ resultArray[10], resultArray[11],
						 resultArray[12], resultArray[13],
						 resultArray[14], resultArray[15],
						 resultArray[16], resultArray[17]]
					};
				myarray.push(item);	
				}	
			}
			
			var resultJson = JSON.stringify(myarray);
			console.log(resultJson);
			
		$('#barGraph').highcharts({
			chart: {
				type: 'column'
			},
			title: {
				text: countryName
			},
			subtitle: {
				text: 'Source: AMIS Database'
			},
			xAxis: {
				categories: arrayAnimalName,
				crosshair: true
			},
			yAxis: {
				min: 0,
				allowDecimals: false,
				title: {
					text: ''
				}
			},
			credits : {
				enabled : false
			},
			tooltip: {
				headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
				footerFormat: '</table>',
				shared: true,
				useHTML: true
			},
			plotOptions: {
				column: {
					pointPadding: 0.2,
					borderWidth: 0
				}
			},
			series: myarray
		});
	
		
		for ( var increment in animalData) {
			if (countryName == animalData[increment].countryName) {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					var animalName=arrayAnimalName[animalIndex].trim();
					if (animalName == animalData[increment].animalName) {
						var AnimalIdNfg=(animalIndex+1).toString()+"animalNfg";
						var AnimalIdCount=(animalIndex+1).toString()+"animalCount";
						var AnimalIdProtein=(animalIndex+1).toString()+"animalProtein";
						var AnimalIdEnergy=(animalIndex+1).toString()+"animalEnergy";
						var FeedDemand=(animalIndex+1).toString()+"feedDemand";
						var ProteinValue = document.getElementById(AnimalIdProtein).value;						
						var NfgValue = document.getElementById(AnimalIdNfg).value;
						var CountValue = document.getElementById(AnimalIdCount).value;
						var EnergyValue = document.getElementById(AnimalIdEnergy).value;
						if(latestYear!="All Years"){
							if (latestYear == animalData[increment].year) {
									var nutritionEnergy = 0;
									var nutritionProtein = 0;
								if(unitIndx=="Energy"){

									nutritionEnergy = nutritionEnergy
												+ (NfgValue * CountValue * EnergyValue * 0.319);
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];				
									document.getElementById(FeedDemand).value=nutritionEnergy;
										
								}
								else{

								nutritionProtein = nutritionProtein
												+ (NfgValue * CountValue * ProteinValue * 35600 );
									nutritionProtein = (nutritionProtein+"").split(".")[0];					
									document.getElementById(FeedDemand).value=nutritionProtein;
								}
							}
						}
						else{
							
									var nutritionEnergy = 0;
									var nutritionProtein = 0;
								if(unitIndx=="Energy"){

									nutritionEnergy = nutritionEnergy
												+ (NfgValue * CountValue * EnergyValue * 0.319);
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];				
									document.getElementById(FeedDemand).value=nutritionEnergy;
										
								}
								else{

								nutritionProtein = nutritionProtein
												+ (NfgValue * CountValue * ProteinValue * 35600 );
									nutritionProtein = (nutritionProtein+"").split(".")[0];					
									document.getElementById(FeedDemand).value=nutritionProtein;
								}
							
						}	
					}
				}
			}
		}
}



	function showResult() {
		
		var nfgRate = "";
		for(index=1;index< ${animalListSize+1} ; index++){
					var AnimalId=index.toString()+"animal";
					var parameter = index.toString()+"a-";
					nfgRate=nfgRate.concat(parameter);
					nfgRate= nfgRate.concat(document.getElementById(AnimalId).value);
					if(index!=${animalListSize}){
						nfgRate=nfgRate.concat(",");}
	
		}

		window.location.href = getContextPath()
				+ "/finalReport.html?country=${country}&property=${propertyName}&unitIndex=${unitIndex}&nfgRate="+nfgRate; 
	}
	
	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}
	
	function generateScenario(latestYear) {
		var animalData = ${animalRawData};
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");

		var countryName = "${countryName}";
		var resultArray = [];

		resultArray.push(latestYear);
		var unitIndx = "${unitIndex}";

			if (unitIndx == "Energy") {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					var animalName=arrayAnimalName[animalIndex].trim();
					var nutritionEnergy = 0;
					for ( var increment in animalData) {
						if (countryName == animalData[increment].countryName) {
							if (animalName == animalData[increment].animalName) {
						
							if (latestYear == animalData[increment].year) {
								var energyIndex = animalData[increment].energyUnitIndex;
								if (energyIndex != null
										&& energyIndex !== undefined) {
									nutritionEnergy = nutritionEnergy
											+ (animalData[increment].animalCount
													* animalData[increment].nonForageRate * energyIndex);
								}
							}
							}
						}
					}
					resultArray.push(nutritionEnergy * 0.319);	
				}
			} else {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
						var animalName=arrayAnimalName[animalIndex].trim();
					var nutritionProtein = 0;
					for ( var increment in animalData) {
						if (countryName == animalData[increment].countryName) {
							if (animalName == animalData[increment].animalName) {
							
							if (latestYear == animalData[increment].year) {
								var proteinIndex = animalData[increment].proteinUnitIndex;
								if (proteinIndex != null
										&& proteinIndex !== undefined) {
									nutritionProtein = nutritionProtein
											+ (animalData[increment].animalCount
													* animalData[increment].nonForageRate * proteinIndex);
								}
							}
							}
						}
					}
					resultArray.push( nutritionProtein * 35600);		
				}
			}

			var myarray = [];
			var item = {
				name : countryName + " Animal Data",
				data : [ resultArray[1], resultArray[2],
						 resultArray[3], resultArray[4],
						 resultArray[5], resultArray[6],
						 resultArray[7], resultArray[8]]
			};
			myarray.push(item);

			var resultJson = JSON.stringify(myarray);
			// alert(resultJson);

			console.log(resultJson);
			
		$('#barGraph').highcharts({
			chart: {
				type: 'column'
			},
			title: {
				text: countryName
			},
			subtitle: {
				text: 'Source: AMIS Database'
			},
			xAxis: {
				categories: arrayAnimalName,
				crosshair: true
			},
			credits : {
				enabled : false
			},
			yAxis: {
				min: 0,
			    allowDecimals: false,
				title: {
					text: ''
				}
			},
			tooltip: {
				headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
				footerFormat: '</table>',
				shared: true,
				useHTML: true
			},
			plotOptions: {
				column: {
					pointPadding: 0.2,
					borderWidth: 0
				}
			},
			series: myarray
		});
	}
	
	
$(document).ready(function(){
						var arrYears = ${yearList};
						var latestYear = arrYears[arrYears.length - 1];
						
						generateScenario(latestYear);
						showTable(latestYear);
					});

function showTable(latestYear){
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		
		var countryName = "${countryName}";
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		console.log(arrayAnimalName);
		var unitIndx = "${unitIndex}";

		
		$('#tableAnimal')
			.append(
							'<tr><th style="text-align: center;" colspan="6">'+latestYear+'</th></tr>' 
							+'<tr>' 
							+ '<th style="text-align: center;">Species</th>' 
							+ '<th style="text-align: center;">Animal number</th>'
							+ '<th style="text-align: center;">Non-forage rate (share of animal population that is not fed through grazing, in %)</th>'
							+ '<th style="text-align: center;">Animal Unit Index (energy)</th>'
							+ '<th style="text-align: center;">Animal Unit Index (protein)</th>'
							+ '<th style="text-align: center;">Total Feed Demand ('+unitIndx +')</th>'
							+ '</tr>');
		
		for ( var increment in animalData) {
			if (countryName == animalData[increment].countryName) {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					var animalName=arrayAnimalName[animalIndex].trim();
					if (animalName == animalData[increment].animalName) {
				
							if (latestYear == animalData[increment].year) {
									var nutritionEnergy = 0;
									var nutritionProtein = 0;
								if(unitIndx=="Energy"){
									nutritionEnergy = nutritionEnergy
												+ (animalData[increment].animalCount
														* animalData[increment].nonForageRate * animalData[increment].energyUnitIndex * 0.319);
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];
									console.log(nutritionEnergy);
									$('#tableAnimal')
									.append(
										'<tr>' + '<td style="text-align: center;">' + animalData[increment].animalName + '</td>'  
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalCount" name="'+(animalIndex+1)+'animalCount" size="8"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].animalCount+'"> </td>'
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalNfg" name="'+(animalIndex+1)+'animalNfg" size="6"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].nonForageRate+'"> </td>' 
											+'<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalEnergy" name="'+(animalIndex+1)+'animalEnergy" size="6"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].energyUnitIndex+'"> </td>' +	 '<td style="text-align: center;" id="'+(animalIndex+1)+'animalProtein" name="'+(animalIndex+1)+'animalProtein">'
											+ animalData[increment].proteinUnitIndex + '</td>' 
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'feedDemand" name="'+(animalIndex+1)+'feedDemand" size="6"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+nutritionEnergy+'"> </td>' 
											+ '</tr>');		
								}
								else{
								nutritionProtein = nutritionProtein
												+ (animalData[increment].animalCount
														* animalData[increment].nonForageRate * animalData[increment].proteinUnitIndex * 35600 );
									nutritionProtein = (nutritionProtein+"").split(".")[0];					
									$('#tableAnimal')
									.append(
										'<tr>' + '<td style="text-align: center;">' + animalData[increment].animalName + '</td>'  
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalCount" name="'+(animalIndex+1)+'animalCount" size="8"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].animalCount+'"> </td>'
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalNfg" name="'+(animalIndex+1)+'animalNfg" size="6"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].nonForageRate+'"> </td>' + '<td style="text-align: center;" id="'+(animalIndex+1)+'animalEnergy" name="'+(animalIndex+1)+'animalEnergy">'
											+ animalData[increment].energyUnitIndex + '</td>' + '<td style="text-align: center;">'
											+ '<td style="text-align: center;">'
											+ '<input type="text" id="'+(animalIndex+1)+'animalProtein" name="'+(animalIndex+1)+'animalProtein" size="6"'
											+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
											+ ' value="'+animalData[increment].proteinUnitIndex+'"> </td>' + '<td style="text-align: center;" id="'+(animalIndex+1)+'feedDemand" name="'+(animalIndex+1)+'feedDemand">'
											+ ' value="'+nutritionProtein +'"> '
											+ '</td>' + '</tr>');		
								}
							}
			
					}
			}
		}
	}	
		
		if(latestYear!="All Years"){
						$('#tableAqua')
										.append(
														' <tr><th style="text-align: center;" colspan="5">'+latestYear+':Aquaculture</th></tr>'
														+'<tr>' 
														+ '<th style="text-align: center;">Total Feed Demand (energy)</th>'
														+ '<th style="text-align: center;">Total Feed Demand (protein)</th>'
														+ '</tr>');
									
									for ( var increment in aquacultureData) {
										if (countryName == aquacultureData[increment].countryName) {
											if (latestYear == aquacultureData[increment].year) {
												var nutritionEnergy = aquacultureData[increment].nutritionEnergy ;
												nutritionEnergy = (nutritionEnergy+"").split(".")[0];	
												var nutritionProtein = aquacultureData[increment].nutritionProtein;
												nutritionProtein = (nutritionProtein+"").split(".")[0];	

												$('#tableAqua')
												.append(
													'<tr>' + '<td style="text-align: center;">'
														+ nutritionEnergy + '</td>' + '<td style="text-align: center;">'
														+ nutritionProtein + '</td>' + '</tr>');		
											}
										}
									}
					}
					else{
										$('#tableAqua')
										.append(
														' <tr><th style="text-align: center;" colspan="5">'+latestYear+':Aquaculture</th></tr>'
														+'<tr>' 
														+ '<th style="text-align: center;">Total Feed Demand (energy)</th>'
														+ '<th style="text-align: center;">Total Feed Demand (protein)</th>'
														+ '</tr>');
									var nutritionEnergy =0;
									var nutritionProtein = 0;
									for ( var increment in aquacultureData) {
										if (countryName == aquacultureData[increment].countryName) {
											
												nutritionEnergy = nutritionEnergy*1 + aquacultureData[increment].nutritionEnergy*1 ;
												
												nutritionProtein = nutritionProtein*1 + aquacultureData[increment].nutritionProtein*1;
												

											
										
										
									}
								}
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];	
									nutritionProtein = (nutritionProtein+"").split(".")[0];
										$('#tableAqua')
												.append(
													'<tr>' + '<td style="text-align: center;">'
														+ nutritionEnergy + '</td>' + '<td style="text-align: center;">'
														+ nutritionProtein + '</td>' + '</tr>');				
						
					}			
	
		
}	

function resetValue() {

	var yearSelected = $("#selectYear option:selected").val();
	$('#tableAqua').empty();
	$('#tableAnimal').empty();
	generateScenario(yearSelected);
	showTable(yearSelected);
}				
	
</script>

</head>
<body>
<body id="pageBody" style="background-color: #D7D6D4">
	<div id="wrapper">
		<div>
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

			<div class="container" id="page" style="padding-top: 20px">

                <div class="row">
                    <div class="col-md-3" align="left">
                    <button type="button" class="btn btn-default">Country/Region
                    : ${countryName}</button>
                    </div>
                    <div class="col-md-3" align="center">
                    <button type="button" class="btn btn-default">Base Commodity : ${propertyName}</button>
                    </div>
                    <div class="col-md-3" align="right">
                    <button type="button" class="btn btn-default">Animal Unit
                    Index : ${unitIndex}</button>
                    </div>
					<div class="col-md-3" id="formTabTwo">
						<div class="form-group" id="eeFormGroup">
							<label for="selectYear">Select Year</label> <br /> <select class="selectBox"
								id="selectYear" title='Choose one or more..'>
								<option selected="selected" value="">Select one</option>
								<option name="yearValue" value="All Years">
												All Years</option>
								<c:choose>
									<c:when test="${not empty yearList}">
										<c:forEach items="${yearList}" var="year"
											varStatus="varStatus">
											
											<option name="yearValue" value="${year}">
												${year}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
					</div>
                </div>


				<div class="row" style="padding-top: 20px">
					<div class="col-md-9" id="tableDiv">
						<table class="bordered" id='tableAnimal' align="left" border="1">
						</table>
						
						<table class="bordered" id='tableAqua' align="left" style="margin-top:20px" border="1">
						</table>
					</div>
                    <div class=col-md-3>
                        <div class="row">
                            <button type="button" class="btn btn-default"
                            onClick="showResult();">Show Results</button>
                        </div>

                        <div class="row" style="margin-top: 20px">
                            <button type="button" class="btn btn-default"
                            onClick="regerateData();">Regenerate Graph</button>
                        </div>
						<div class="row" style="margin-top: 20px">
                            <button type="button" class="btn btn-default"
                            onClick="resetValue();">Reset Values</button>
                        </div>
                    </div>
				</div>

                <div class="row">
                    <div class="col-md-12">
                    <div id="barGraph"
                    style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                    </div>
                </div>

                <div class="row" style="margin-top: 30px">
                    <div class="col-md-4">
                        <div name="scenarioRegenerateData" id="scenarioRegenerateData"></div>
                    </div>
                </div>
    		</div>
		</div>
	</div>
</body>
</body>
</html>