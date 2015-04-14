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
		var latestYear = arrYears[arrYears.length - 1];
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
										if (energyIndex != null
												&& energyIndex !== undefined) {
											nutritionEnergy = nutritionEnergy
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * energyIndex);
										}
									}
									else{
										var AnimalId=(animalIndex+1).toString()+"animal";
										console.log(AnimalId);
										if (energyIndex != null
												&& energyIndex !== undefined) {
											nutritionEnergy = nutritionEnergy
													+ (animalData[increment].animalCount
															* document.getElementById(AnimalId).value * energyIndex);
										}
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
									if(dataType==0){
										if (proteinIndex != null
												&& proteinIndex !== undefined) {
											nutritionProtein = nutritionProtein
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * proteinIndex);
										}
									}
									else{
										var AnimalId=(animalIndex+1).toString()+"animal";
										console.log(AnimalId);
										if (proteinIndex != null
												&& proteinIndex !== undefined) {
											nutritionProtein = nutritionProtein
													+ (animalData[increment].animalCount
															* document.getElementById(AnimalId).value * proteinIndex);
									}			
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
			yAxis: {
				min: 0,
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
	
	function generateScenario() {
		var animalData = ${animalRawData};
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");

		var countryName = "${countryName}";
		var resultArray = [];
		var arrYears = ${yearList};
		var latestYear = arrYears[arrYears.length - 1];
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
					resultArray.push(nutritionProtein * 35600);
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
						
						generateScenario();
						showTable();
					});

function showTable(){
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var latestYear = arrYears[arrYears.length - 1];
		var countryName = "${countryName}";
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		console.log(arrayAnimalName);
		
		$('#table')
			.append(
							' <tr><th style="text-align: center;" colspan="5">'+latestYear+'</th></tr>'
							+'<tr>' 
							+ '<th style="text-align: center;">Animal</th>' 
							+ '<th style="text-align: center;">Number</th>'
							+ '<th style="text-align: center;">Non-forage rate</th>'
							+ '<th style="text-align: center;">Energy</th>'
							+ '<th style="text-align: center;">Protein</th>'
							+ '</tr>');
		
		for ( var increment in animalData) {
			if (countryName == animalData[increment].countryName) {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					var animalName=arrayAnimalName[animalIndex].trim();
					if (animalName == animalData[increment].animalName) {
						if (latestYear == animalData[increment].year) {
							$('#table')
							.append(
								'<tr>' + '<td style="text-align: center;">' + animalData[increment].animalName + '</td>'  
									+ '<td style="text-align: center;">' + animalData[increment].animalCount + '</td>' 
									+ '<td style="text-align: center;">'
									+ '<input type="text" id="'+(animalIndex+1)+'animal" name="'+(animalIndex+1)+'animal" size="8"'
									+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
									+ ' value="'+animalData[increment].nonForageRate+'"> </td>' + '<td style="text-align: center;">'
									+ animalData[increment].energyUnitIndex + '</td>' + '<td style="text-align: center;">'
									+ animalData[increment].proteinUnitIndex + '</td>' + '</tr>');		
						}
					}
				}
			}
		}
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
                    <div class="col-md-4" align="left">
                    <button type="button" class="btn btn-default">Country/Region
                    : ${countryName}</button>
                    </div>
                    <div class="col-md-4" align="center">
                    <button type="button" class="btn btn-default">Property
                    Name : ${propertyName}</button>
                    </div>
                    <div class="col-md-4" align="right">
                    <button type="button" class="btn btn-default">Unit
                    Index : ${unitIndex}</button>
                    </div>
                </div>


				<div class="row" style="padding-top: 20px">
					<div class="col-md-9" id="tableDiv">
						<table class="bordered" id='table' align="left" border="1">
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