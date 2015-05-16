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
var previousYear=0;
var initialYear=0;
function regerateData() {
	
		var animalData = ${animalRawData};
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		
		//var propertyValue = ${propertyValue};
		//var countryName = "${countryName}";
		//var unitIndx = "${unitIndex}";
		
		var propertySelectedKey="";
		var propertyValueMap = new Array();
		<c:forEach var="entry" items="${propertyMap}">
			propertyValueMap["${entry.key}"] = "${entry.value}";
		</c:forEach>

		var propertySelected =  $("#selectIndex option:selected").val().trim().replace(/\s/g,'');
		var unitIndexSelected =$("input[name='selectEnergyEquivalent']:checked").val();
		
		if(unitIndexSelected=="Energy"){
			propertySelectedKey=propertySelected+"Energy";
		}
		else{
			propertySelectedKey=propertySelected+"Protein";
		}	
		var propertyValue = propertyValueMap[propertySelectedKey];
		if(propertySelected=="None"){
			propertyValue=1;
		}
		
		var countryNameMap = new Array();
		<c:forEach var="entry" items="${countryMap}">
				countryNameMap[${entry.key}] = "${entry.value}";
		</c:forEach>
		var countrySelected =  $("#selectCountry option:selected").val().trim();		
		var countryName = countryNameMap[countrySelected];
		var unitIndx =$("input[name='selectEnergyEquivalent']:checked").val();
		
		if(countrySelected!="None"){
		
		var resultArray = [];
		var arrYears = ${yearList};
		var yearSelected = $("#selectYear option:selected").val();
		if(yearSelected==""){
			var latestYear = arrYears[arrYears.length - 1];
		}	
		else{
			latestYear=yearSelected;
		}
		var myarray = [];
		for ( var dataType = 0; dataType < 2; dataType++) {
			resultArray.push(latestYear);
			
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
						resultArray.push(nutritionEnergy * 35600 * propertyValue/1000000);
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
												
													nutritionProtein = nutritionProtein
															+ (document.getElementById(AnimalIdCount).value
																	* document.getElementById(AnimalIdNfg).value * document.getElementById(AnimalIdProtein).value);
														
												}
											}
									
											
								}
							}
						}
						resultArray.push(nutritionProtein * 0.319 * propertyValue/1000);
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
			
		var energyType ;
						if(unitIndx == "Energy")
						{	
							energyType = "1000 GJ";
						}
						else
						{
							energyType = "1000 MT";
						}
							
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
					text: energyType
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
						
							if (latestYear == animalData[increment].year) {
									var nutritionEnergy = 0;
									var nutritionProtein = 0;
								if(unitIndx=="Energy"){

									nutritionEnergy = nutritionEnergy
												+ (NfgValue * CountValue * EnergyValue * 35600 * propertyValue/1000000);
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];				
									document.getElementById(FeedDemand).value=nutritionEnergy;
										
								}
								else{

								nutritionProtein = nutritionProtein
												+ (NfgValue * CountValue * ProteinValue * 0.319 * propertyValue/1000 );
									nutritionProtein = (nutritionProtein+"").split(".")[0];					
									document.getElementById(FeedDemand).value=nutritionProtein;
								}
							}
						

					}
				}
			}
		}
	}
		else{
			$('#barGraph').empty();
		}
}



	function showResult() {
		
		
		var countryNameMap = new Array();
		<c:forEach var="entry" items="${countryMap}">
				countryNameMap[${entry.key}] = "${entry.value}";
		</c:forEach>
		var country =  $("#selectCountry option:selected").val().trim();		
		var countryName = countryNameMap[country];
	
		var unitIndx =$("input[name='selectEnergyEquivalent']:checked").val();
		
		var property =  $("#selectIndex option:selected").val().trim();
		
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		
		
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");

		var latestYear="";
		var yearSelected = $("#selectYear option:selected").val();
		if(yearSelected==""){
			var arrYears = ${yearList};
			latestYear = arrYears[arrYears.length - 1];
		}
		else{
			latestYear = yearSelected;
		}			
		
		
		
		var animalCountArray=[];
		var nonForageRateArray=[];
		var energyUnitIndexArray=[];
		var proteinUnitIndexArray=[];
		
		var perChngAnmCount="";
		var perChngNonForgRat="";
		var perChngUtIdx="";
		
		for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
				var AnimalIdCount=(animalIndex+1).toString()+"animalCount";
				var AnimalIdNfg=(animalIndex+1).toString()+"animalNfg";
				var AnimalIdEnergy=(animalIndex+1).toString()+"animalEnergy";
				var AnimalIdProtein=(animalIndex+1).toString()+"animalProtein";
				var anmCount=document.getElementById(AnimalIdCount).value;
				var nfg=document.getElementById(AnimalIdNfg).value;
				var energy=document.getElementById(AnimalIdEnergy).value;
				var protein=document.getElementById(AnimalIdProtein).value;
				animalCountArray.push(anmCount);
				nonForageRateArray.push(nfg);
				energyUnitIndexArray.push(energy);
				proteinUnitIndexArray.push(protein);
			}
			
		for ( var increment in animalData) {
			if (countryName == animalData[increment].countryName) {
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
				
					var animalName=arrayAnimalName[animalIndex].trim();
					if (animalName == animalData[increment].animalName) {
					
					if (initialYear == animalData[increment].year) {
									var nutritionEnergy = 0;
									var nutritionProtein = 0;
								
								    if(animalData[increment].animalCount==animalCountArray[animalIndex]){
									perChngAnmCount=perChngAnmCount.concat("0");
									perChngAnmCount=perChngAnmCount.concat(":");
									}
									else{
									var change=parseFloat(animalCountArray[animalIndex])-parseFloat(animalData[increment].animalCount);
									if(animalData[increment].animalCount=="0"){			
										perChngAnmCount=perChngAnmCount.concat("0");
										}
									else{
										var perChange=(change/parseFloat(animalData[increment].animalCount))*100;
										perChngAnmCount=perChngAnmCount.concat(perChange);
									}	
									
									perChngAnmCount=perChngAnmCount.concat(":");
									}
									
									if(animalData[increment].nonForageRate==nonForageRateArray[animalIndex]){
									perChngNonForgRat=perChngNonForgRat.concat("0");
									perChngNonForgRat=perChngNonForgRat.concat(":");
									}
									else{
										if(animalData[increment].nonForageRate=="0"){	
										perChngNonForgRat=perChngNonForgRat.concat("0");
										}
										else{
										var change=parseFloat(nonForageRateArray[animalIndex])-parseFloat(animalData[increment].nonForageRate);
										var perChange=(change/parseFloat(animalData[increment].nonForageRate))*100;
										perChngNonForgRat=perChngNonForgRat.concat(perChange);
										}
									perChngNonForgRat=perChngNonForgRat.concat(":");
									}
								
								if(unitIndx=="Energy"){
									
									if(animalData[increment].energyUnitIndex==energyUnitIndexArray[animalIndex]){
										perChngUtIdx=perChngUtIdx.concat("0");
										perChngUtIdx=perChngUtIdx.concat(":");
									}
									else{
										if(animalData[increment].energyUnitIndex=="0"){
												perChngUtIdx=perChngUtIdx.concat("0");
										}
										else{
											var change=parseFloat(energyUnitIndexArray[animalIndex])-parseFloat(animalData[increment].energyUnitIndex);
											var perChange=(change/parseFloat(animalData[increment].energyUnitIndex))*100;
											perChngUtIdx=perChngUtIdx.concat(perChange);
										}
									perChngUtIdx=perChngUtIdx.concat(":");
									}

								  }
								  else{
                                    
                                    if(animalData[increment].proteinUnitIndex==proteinUnitIndexArray[animalIndex]){
                                    	perChngUtIdx=perChngUtIdx.concat("0");
                                    	perChngUtIdx=perChngUtIdx.concat(":");
									}
									else{
										if(animalData[increment].proteinUnitIndex=="0"){
											perChngUtIdx=perChngUtIdx.concat("0");
										}	
										else{
											var change=parseFloat(proteinUnitIndexArray[animalIndex])-parseFloat(animalData[increment].proteinUnitIndex);
											var perChange=(change/parseFloat(animalData[increment].proteinUnitIndex))*100;
											perChngUtIdx=perChngUtIdx.concat(perChange);
										}
									perChngUtIdx=perChngUtIdx.concat(":");
									}									
								  }
								}
		        
			}
		  }
		}
	  }
		
		window.location.href = getContextPath()
		+ "/finalReport.html?country="+country+"&property="+property+"&unitIndex="+unitIndx+"&year="+latestYear+"&perChngAnmCount="+perChngAnmCount+"&perChngNonForgRat="+perChngNonForgRat+"&perChngUtIdx="+perChngUtIdx; 
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
		//var propertyValue=${propertyValue};
		
		var propertySelectedKey="";
		var propertyValueMap = new Array();
		<c:forEach var="entry" items="${propertyMap}">
			propertyValueMap["${entry.key}"] = "${entry.value}";
		</c:forEach>

		var propertySelected =  $("#selectIndex option:selected").val().trim().replace(/\s/g,'');
		var unitIndexSelected =$("input[name='selectEnergyEquivalent']:checked").val();
		
		if(unitIndexSelected=="Energy"){
			propertySelectedKey=propertySelected+"Energy";
		}
		else{
			propertySelectedKey=propertySelected+"Protein";
		}	
		var propertyValue = propertyValueMap[propertySelectedKey];
		
		if(propertySelected=="None"){
			propertyValue=1;
		}
		
		
		var countryNameMap = new Array();
		<c:forEach var="entry" items="${countryMap}">
				countryNameMap[${entry.key}] = "${entry.value}";
		</c:forEach>
		var countrySelected =  $("#selectCountry option:selected").val().trim();		
		var countryName = countryNameMap[countrySelected];
		
		if(countrySelected!="None")	{
	
		var unitIndx =$("input[name='selectEnergyEquivalent']:checked").val();

		var resultArray = [];
		resultArray.push(latestYear);

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
					resultArray.push(nutritionEnergy * 35600 * propertyValue/1000000);	
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
					resultArray.push( nutritionProtein * 0.319 * propertyValue/1000);		
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

							var energyType ;
						if(unitIndx == "Energy")
						{	
							energyType = "1000 GJ";
						}
						else
						{
							energyType = "1000 MT";
						}
			
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
					text: energyType
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
		else{
			$('#barGraph').empty();
		}

	}
	
	
$(document).ready(function(){

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
						$('#selectYear').selectpicker({
							size : 'auto',
							width : '130px'
						});
						
						document.getElementById("generateChartDiv").hidden = true;
						document.getElementById("reportChangetDiv").hidden = true;
				
		/*				
						var arrYears = ${yearList};
						var latestYear = arrYears[arrYears.length - 1];
						
						generateScenario(latestYear);
						showTable(0,latestYear);*/
					});

function unitIndexChange(){
//	var unitIndexSelected =$("input[name='selectEnergyEquivalent']:checked").val();
	document.getElementById("allYears").checked = false;
	var arrYears = ${yearList};
	var latestYear = arrYears[arrYears.length - 1];

	var latestYear="";
	var yearSelected = $("#selectYear option:selected").val();
	if(yearSelected==""){
		var arrYears = ${yearList};
		latestYear = arrYears[arrYears.length - 1];
	}
	else{
		latestYear = yearSelected;
	}	
	
					
	generateScenario(latestYear);
	showTable(0,latestYear);	
	
}				

function resetCountryValue(){
	document.getElementById("allYears").checked = false;
	var latestYear="";
	var yearSelected = $("#selectYear option:selected").val();
	if(yearSelected==""){
		var arrYears = ${yearList};
		latestYear = arrYears[arrYears.length - 1];
	}
	else{
		latestYear = yearSelected;
	}	
		generateScenario(latestYear);
		showTable(0,latestYear);		
}

function resetPropertyValue(){
	document.getElementById("allYears").checked = false;
	var arrYears = ${yearList};
	var latestYear = arrYears[arrYears.length - 1];
	
	var latestYear="";
	var yearSelected = $("#selectYear option:selected").val();
	if(yearSelected==""){
		var arrYears = ${yearList};
		latestYear = arrYears[arrYears.length - 1];
	}
	else{
		latestYear = yearSelected;
	}	

	generateScenario(latestYear);
	showTable(0,latestYear);	
}	

					
function showTable(previousYear,latestYear){
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		//var propertyValue = ${propertyValue};

		var propertySelectedKey="";
		var propertyValueMap = new Array();
		<c:forEach var="entry" items="${propertyMap}">
			propertyValueMap["${entry.key}"] = "${entry.value}";
		</c:forEach>

		var propertySelected =  $("#selectIndex option:selected").val().trim().replace(/\s/g,'');
		var unitIndexSelected =$("input[name='selectEnergyEquivalent']:checked").val();
		
		if(unitIndexSelected=="Energy"){
			propertySelectedKey=propertySelected+"Energy";
		}
		else{
			propertySelectedKey=propertySelected+"Protein";
		}	
		

		var propertyValue = propertyValueMap[propertySelectedKey];
		if(propertySelected=="None"){
			propertyValue=1;
		}
		
			
		var countryNameMap = new Array();
		<c:forEach var="entry" items="${countryMap}">
				countryNameMap[${entry.key}] = "${entry.value}";
		</c:forEach>
		var countrySelected =  $("#selectCountry option:selected").val().trim();		
		var countryName = countryNameMap[countrySelected];
	//	var countryName = "${countryName}";
//		var unitIndx = "${unitIndex}";

		var unitIndx =$("input[name='selectEnergyEquivalent']:checked").val();
		
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		$('#tableAqua').empty();
		
		if(countrySelected!="None"){
			
				document.getElementById("generateChartDiv").hidden = false;
				document.getElementById("reportChangetDiv").hidden = false;
				
				
			if(document.getElementById("allYears").checked != true){
			
			
				if(unitIndx=="Energy"){
					unitIndexWithUnit = "Energy in 1000 GJ"
				}
				else{
					unitIndexWithUnit = "Protein in 1000 MT"
				}
				
				$('#tableAnimal').empty();
				$('#tableAnimalLast').empty();
				initialYear=latestYear;
			


				$('#tableAnimal')
				.append(
								'<tr><th style="text-align: center;" colspan="6">'+latestYear+'</th></tr>' 
								+'<tr>' 
								+ '<th style="text-align: center;">Species</th>' 
								+ '<th style="text-align: center; width:120px;">Animal number</th>'
								+ '<th style="text-align: center;">Non-forage rate (share of animal population that is not fed through grazing, in %)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (energy)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (protein)</th>'
								+ '<th style="text-align: center; width:150px;"">Total Feed Demand ('+unitIndexWithUnit +')</th>'
								+ '</tr>');
			for ( var increment in animalData) {
				if (countryName == animalData[increment].countryName) {
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
						var animalName=arrayAnimalName[animalIndex].trim();
						if (animalName == animalData[increment].animalName) {
								previousYear=latestYear;
								if (latestYear == animalData[increment].year) {
										var nutritionEnergy = 0;
										var nutritionProtein = 0;
									if(unitIndx=="Energy"){
										nutritionEnergy = nutritionEnergy
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * animalData[increment].energyUnitIndex * 35600 * propertyValue/1000000);
										nutritionEnergy = (nutritionEnergy+"").split(".")[0];
										
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
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+nutritionEnergy+'"> </td>' 
												+ '</tr>');		
									}
									else{
									nutritionProtein = nutritionProtein
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * animalData[increment].proteinUnitIndex * 0.319 * propertyValue/1000);
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
												+ animalData[increment].energyUnitIndex + '</td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalProtein" name="'+(animalIndex+1)+'animalProtein" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+animalData[increment].proteinUnitIndex+'"> </td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'feedDemand" name="'+(animalIndex+1)+'feedDemand" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+nutritionProtein+'"> </td>' 
												+ '</tr>');		
									}
								}
							}
						}
					}
				}
			}
			else{
			
					//ghanshyam
					var animalCountArray=[];
					var nonForageRateArray=[];
					var energyUnitIndexArray=[];
					var proteinUnitIndexArray=[];
					
					var perChngAnmCountArray=[];
					var perChngNonForgRatArray=[];
					var perChngEnrgUtIdxArray=[];
					var perChngProtUtIdxArray=[];
					
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
							var AnimalIdCount=(animalIndex+1).toString()+"animalCount";
							var AnimalIdNfg=(animalIndex+1).toString()+"animalNfg";
							var AnimalIdEnergy=(animalIndex+1).toString()+"animalEnergy";
							var AnimalIdProtein=(animalIndex+1).toString()+"animalProtein";
							var anmCount=document.getElementById(AnimalIdCount).value;
							var nfg=document.getElementById(AnimalIdNfg).value;
							var energy=document.getElementById(AnimalIdEnergy).value;
							var protein=document.getElementById(AnimalIdProtein).value;
							animalCountArray.push(anmCount);
							nonForageRateArray.push(nfg);
							energyUnitIndexArray.push(energy);
							proteinUnitIndexArray.push(protein);
							
				}
				
				
				$('#tableAnimalLast').empty();
			
				for ( var increment in animalData) {
				if (countryName == animalData[increment].countryName) {
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					
						var animalName=arrayAnimalName[animalIndex].trim();
						if (animalName == animalData[increment].animalName) {
						
						//ghanshyam
						if (initialYear == animalData[increment].year) {
										var nutritionEnergy = 0;
										var nutritionProtein = 0;
									
										if(animalData[increment].animalCount==animalCountArray[animalIndex]){
										perChngAnmCountArray.push(0);
										}
										else{
											if(animalData[increment].animalCount==0){
												perChngAnmCountArray.push(0);
											}
											else{
												var change=parseFloat(animalCountArray[animalIndex])-parseFloat(animalData[increment].animalCount);
												var perChange=(change/parseFloat(animalData[increment].animalCount))*100;
												perChngAnmCountArray.push(perChange);
											}
										}
										
										if(animalData[increment].nonForageRate==nonForageRateArray[animalIndex]){
										perChngNonForgRatArray.push(0);
										}
										else{
											if(animalData[increment].nonForageRate==0){
												perChngNonForgRatArray.push(0);
											}
											else{
												var change=parseFloat(nonForageRateArray[animalIndex])-parseFloat(animalData[increment].nonForageRate);
												var perChange=(change/parseFloat(animalData[increment].nonForageRate))*100;
												perChngNonForgRatArray.push(perChange);
											}
										}
									
									if(unitIndx=="Energy"){
									

										
										if(animalData[increment].energyUnitIndex==energyUnitIndexArray[animalIndex]){
										perChngEnrgUtIdxArray.push(0);
										}
										else{
											if(animalData[increment].energyUnitIndex ==0){
												perChngEnrgUtIdxArray.push(0);
											}	
											else{
												var change=parseFloat(energyUnitIndexArray[animalIndex])-parseFloat(animalData[increment].energyUnitIndex);
												var perChange=(change/parseFloat(animalData[increment].energyUnitIndex))*100;
												perChngEnrgUtIdxArray.push(perChange);
											}
										}

									  }
									  else{

										
										if(animalData[increment].proteinUnitIndex==proteinUnitIndexArray[animalIndex]){
										perChngProtUtIdxArray.push(0);
										}
										else{
											if(animalData[increment].proteinUnitIndex==0){
												perChngProtUtIdxArray.push(0);	
											}
											else{
												var change=parseFloat(proteinUnitIndexArray[animalIndex])-parseFloat(animalData[increment].proteinUnitIndex);
												var perChange=(change/parseFloat(animalData[increment].proteinUnitIndex))*100;
												perChngProtUtIdxArray.push(perChange);	
											}
										
										}									
									  }
									}
					
				}
			  }
			}
		  }
			initialYear=latestYear;
			
			if(unitIndx=="Energy"){
				unitIndexWithUnit = "Energy in 1000 GJ"
			}
			else{
				unitIndexWithUnit = "Protein in 1000 MT"
			}
			
			$('#tableAnimalLast')
				.append(
								'<tr><th style="text-align: center;" colspan="6">'+latestYear+'</th></tr>' 
								+'<tr>' 
								+ '<th style="text-align: center;">Species</th>' 
								+ '<th style="text-align: center; width:120px;">Animal number</th>'
								+ '<th style="text-align: center;">Non-forage rate (share of animal population that is not fed through grazing, in %)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (energy)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (protein)</th>'
								+ '<th style="text-align: center; width:150px;"">Total Feed Demand ('+unitIndexWithUnit +')</th>'
								+ '</tr>');
								
			for ( var increment in animalData) {
				if (countryName == animalData[increment].countryName) {
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					
						var animalName=arrayAnimalName[animalIndex].trim();
						if (animalName == animalData[increment].animalName) {
							
								if (latestYear == animalData[increment].year) {
										previousYear=latestYear;
										var nutritionEnergy = 0;
										var nutritionProtein = 0;
										
									//ghanshyam
										var changedAnimalCount=0;
										var changedNonForageRate=0;
										var changedEnergyUnitIndex=0;
										var changedProteinUnitIndex=0;
										
									
										changedAnimalCount=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountArray[animalIndex])/100);
										changedAnimalCount=changedAnimalCount.toFixed(0);
										changedNonForageRate=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatArray[animalIndex])/100);
										changedNonForageRate=changedNonForageRate.toFixed(2);
										changedEnergyUnitIndex=parseFloat(animalData[increment].energyUnitIndex)+((parseFloat(animalData[increment].energyUnitIndex))*parseFloat(perChngEnrgUtIdxArray[animalIndex])/100);
										changedEnergyUnitIndex=changedEnergyUnitIndex.toFixed(2);
										changedProteinUnitIndex=parseFloat(animalData[increment].proteinUnitIndex)+((parseFloat(animalData[increment].proteinUnitIndex))*parseFloat(perChngProtUtIdxArray[animalIndex])/100);
										changedProteinUnitIndex=changedProteinUnitIndex.toFixed(2);
									
									if(unitIndx=="Energy"){
									
										nutritionEnergy = nutritionEnergy
													+ (changedAnimalCount * changedNonForageRate * changedEnergyUnitIndex * 35600 * propertyValue/1000000);
										nutritionEnergy = (nutritionEnergy+"").split(".")[0];
											
										
										$('#tableAnimalLast')
										.append(
											'<tr>' + '<td style="text-align: center;">' + animalData[increment].animalName + '</td>'  
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalCount" name="'+(animalIndex+1)+'animalCount" size="8"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedAnimalCount+'"> </td>'
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalNfg" name="'+(animalIndex+1)+'animalNfg" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedNonForageRate+'"> </td>' 
												+'<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalEnergy" name="'+(animalIndex+1)+'animalEnergy" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedEnergyUnitIndex+'"> </td>' 
												+'<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalProtein" name="'+(animalIndex+1)+'animalProtein" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+animalData[increment].proteinUnitIndex+'"> </td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'feedDemand" name="'+(animalIndex+1)+'feedDemand" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+nutritionEnergy+'"> </td>' 
												+ '</tr>');		
									}
									else{
									nutritionProtein = nutritionProtein
													+ (changedAnimalCount * changedNonForageRate * changedProteinUnitIndex * 0.319 * propertyValue/1000);
										nutritionProtein = (nutritionProtein+"").split(".")[0];	
										
										$('#tableAnimalLast')
										.append(
											'<tr>' + '<td style="text-align: center;">' + animalData[increment].animalName + '</td>'  
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalCount" name="'+(animalIndex+1)+'animalCount" size="8"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedAnimalCount+'"> </td>'
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalNfg" name="'+(animalIndex+1)+'animalNfg" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedNonForageRate+'"> </td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalEnergy" name="'+(animalIndex+1)+'animalEnergy" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+animalData[increment].energyUnitIndex+'"> </td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'animalProtein" name="'+(animalIndex+1)+'animalProtein" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;"'
												+ ' value="'+changedProteinUnitIndex+'"> </td>' 
												+ '<td style="text-align: center;">'
												+ '<input type="text" id="'+(animalIndex+1)+'feedDemand" name="'+(animalIndex+1)+'feedDemand" size="6"'
												+ 'maxlength="20" class="form-control" style="font-weight:bold ;text-align: center;" readonly="readonly"'
												+ ' value="'+nutritionProtein+'"> </td>' 
												+ '</tr>');		
									}
								}
							
							
							
							
							
							}
						}
					}
				}
			/*ghanshyam */
			$('#tableAnimal').empty();
			regerateData();
			}
		

			$('#tableAqua')
							.append(
											' <tr><th style="text-align: center;" colspan="5">'+latestYear+':Aquaculture</th></tr>'
											+'<tr>' 
											+ '<th style="text-align: center;">Total Feed Demand Energy(1000 GJ)</th>'
											+ '<th style="text-align: center;">Total Feed Demand Protein(1000 MT)</th>'
											+ '</tr>');
						
						for ( var increment in aquacultureData) {
							if (countryName == aquacultureData[increment].countryName) {
								if (latestYear == aquacultureData[increment].year) {
									var nutritionEnergy = aquacultureData[increment].nutritionEnergy/1000000 ;
									nutritionEnergy = (nutritionEnergy+"").split(".")[0];	
									var nutritionProtein = aquacultureData[increment].nutritionProtein/1000;
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
					$('#tableAnimal').empty();
					$('#tableAqua').empty();
					$('#tableAnimalLast').empty();
					document.getElementById("generateChartDiv").hidden = true;
					document.getElementById("reportChangetDiv").hidden = true;
				}
}	

function resetValue() {

	var yearSelected = $("#selectYear option:selected").val();
	$('#tableAqua').empty();
	generateScenario(yearSelected);
	showTable(previousYear,yearSelected);
}				

function goHome() {

window.location.href = getContextPath();
}

function goBack() {

window.history.back();
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
		<div>
			<div id="navigation" class="banner">
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
			<ol  class="breadcrumb" >
				<li><a style="cursor:pointer;"  onclick="goHome();">Visualize estimated feed demand</a></li>
				<li><a class="active"  style="cursor:pointer; color: #A9A9A9;" onclick="showScenario();">Scenario Analysis </a></li>
				<li style="float: right"><a onclick="goBack();">BACK </a></li>
				<li style="float: right"><a onclick="goHome();">HOME </a></li>
			</ol>

			<div style="padding-top: 0px" class="container" id="page">

             <div class="row" style="background-color:CornflowerBlue; ">
					<div class="col-md-3" id="formTabOne">
						<div class="form-group" id="countryIdList">
							<label for="selectCountry" style="color:white">Select country <br /> (only one)</label>
						</div>
					</div>
					<div class="col-md-4" id="formTabThree">
						<div class="form-group" id="unitFormGroup">
							<label for="selectEnergyEquivalent" style="color:white">Select whether results should show energy or protein requirements </label><br/>
						</div>
					</div>
					<div class="col-md-3" id="formTabTwo">
						<div class="form-group" id="eeFormGroup">
							<label for="selectIndex" style="color:white">Select base commodity as reference</label> <br />
						</div>
					</div>
					<div class="col-md-2" id="formTabTwo">
						<div class="form-group" id="eeFormGroup" >
							<label for="selectYear" style="color:white">Select Year</label> <br /><input type="checkbox" id="allYears" name="allYears"/> <font color="white">Apply for all Years</font>
						</div>
					</div>	
                </div>			
			
			
			
             <div class="row" style="background-color:CornflowerBlue;">
					<div class="col-md-3" id="formTabOne">
						<div class="form-group" id="countryIdList">
							<select
								id="selectCountry" class="selectBox"
								title='Choose one' data-live-search="true" onchange="resetCountryValue();">
								<option selected="selected" value="None">None</option>
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
						<div class="form-group" id="unitFormGroup"  >
							<label style="color:white"><input type="radio" name="selectEnergyEquivalent" onchange="unitIndexChange();" value="Energy" checked="checked" >Energy(1000 GJ)</label> 
							<label style="color:white"><input type="radio" name="selectEnergyEquivalent" onchange="unitIndexChange();" value="Protein" >Protein(1000 MT)</label>
						</div>
					</div>
					<div class="col-md-3" id="formTabTwo">
						<div class="form-group" id="eeFormGroup">
							<select class="selectBox"
								id="selectIndex" title='Choose one' onchange="resetPropertyValue();">
								<option selected="selected" value="None">None</option>
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
					<div class="col-md-2" id="formTabTwo">
								<div class="form-group" id="eeFormGroup">
									<select class="selectBox"
										id="selectYear" onchange="resetValue();">
										<option selected="selected" value="">None</option>
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

				 <div class="row" style="background-color:CornflowerBlue; ">
					<div class="col-md-9"></div>
					<div class="col-md-3">
						<div class="form-group" align="right">
							
						</div>
					</div>
                </div>	
				
				<div class="row" style="padding-top: 20px">
					<div class="col-md-9" id="tableDiv">
						<table class="bordered" id='tableAnimal' align="left" border="1">
						</table>
						<table class="bordered" id='tableAnimalLast' align="left" border="1">
						</table>
						<table class="bordered" id='tableAqua' align="left" style="margin-top:20px" border="1">
						</table>
					</div>
                    <div class=col-md-3>
                        
						
                        <div class="row" style="margin-top: 20px" id="generateChartDiv">
                            <button type="button" class="btn btn-default"
                            onClick="regerateData();">Regenerate Chart</button>
                        </div>
						<div class="row" style="margin-top: 20px" id="reportChangetDiv">
                            <button type="button" class="btn btn-default"
                            onClick="showResult();">View changed feed demand graph</button>
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