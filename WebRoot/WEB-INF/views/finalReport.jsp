
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
<link href="assets/css/bordered.css" rel="stylesheet">
<link href="assets/css/jasny-bootstrap.css" rel="stylesheet">
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
function formatNumber (num) {
		var myNumberAsString = num;           
		var myNumber = Math.round(0.0 + myNumberAsString); 
		parseInt(myNumber);
		return myNumber.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,"); 
		}
		
		function formatNumberRoundOff (num) {
		var myNumberAsString = num;           
		var myNumber = Math.round(0.0 + myNumberAsString); 
		return parseInt(myNumber); 
		}
		
		
	function getPieChart() {
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var unitIndx = "${unitIndex}";
		var countryName = "${countryName}";
		var latestYear = "${year}";
		var listAnimal = ('${animalList}');
		listAnimal = listAnimal.substr(0, listAnimal.length - 1);
		var arrayAnimal;
		arrayAnimal = listAnimal.split(",");

		var perChngAnmCount = "${perChngAnmCount}";
		var perChngAnmCountList;
		perChngAnmCountList=perChngAnmCount.split(":");

		var perChngNonForgRat = "${perChngNonForgRat}";
		var perChngNonForgRatList;
		perChngNonForgRatList=perChngNonForgRat.split(":");

		var perChngUtIdx = "${perChngUtIdx}";
		var perChngUtIdxList;
		perChngUtIdxList=perChngUtIdx.split(":");


		// var resultArray= [];
		for ( var dataType = 0; dataType < 2; dataType++) {
			var resultArray = [];
			if (dataType == 0) {
				var type = "Old";
				resultArray.push(countryName + "(Old)");
			} else {
				var type = "New";
				resultArray.push(countryName + "(New)");
			}
			
	
			var aquaEnergyIndex = 0;
			var aquaProteinIndex = 0;

			
			if (unitIndx == "Energy") {
				if (dataType == 0) {
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						var nutritionEnergy = 0;
						resultArray.push(arrayAnimal[animalIndex]);
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {
									if (latestYear == animalData[increment].year) {
										var energyIndex = animalData[increment].energyUnitIndex;
										if (energyIndex != null
												&& energyIndex !== undefined) {
											nutritionEnergy = (animalData[increment].animalCount
															* animalData[increment].nonForageRate * energyIndex);
										}
									}
								}
							}
						}
						resultArray.push(nutritionEnergy * 35600/1000000);
					}
				} else {
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						resultArray.push(arrayAnimal[animalIndex]);
						var nutritionEnergy = 0;
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {
									if (latestYear == animalData[increment].year) {
										var energyIndex = animalData[increment].energyUnitIndex;
										if (energyIndex != null
												&& energyIndex !== undefined) {
												var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].energyUnitIndex)+((parseFloat(animalData[increment].energyUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
												
											nutritionEnergy = ( animalCountPer * nfgPer * unitPer);
										}
									}
								}
							}
						}
						resultArray.push(nutritionEnergy * 35600/1000000);
					}
				}
				for ( var aqua_increment in aquacultureData) {
					if (countryName == aquacultureData[aqua_increment].countryName) {
						if (latestYear == aquacultureData[aqua_increment].year) {
							resultArray.push("Aqua");
							aquaEnergyIndex = aquacultureData[aqua_increment].nutritionEnergy;
							resultArray.push(aquaEnergyIndex * 1/1000000);
						}
					}

				}

			} else {
				if (dataType == 0) {
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						var nutritionProtein = 0;
						resultArray.push(arrayAnimal[animalIndex]);
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {
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
						resultArray.push(nutritionProtein * 0.319/1000);
					}
				} else {
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						resultArray.push(arrayAnimal[animalIndex]);
						var nutritionProtein = 0;
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {
									if (latestYear == animalData[increment].year) {
										var proteinIndex = animalData[increment].proteinUnitIndex;
										if (proteinIndex != null
												&& proteinIndex !== undefined) {
												
												var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].proteinUnitIndex)+((parseFloat(animalData[increment].proteinUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
												
											nutritionProtein = nutritionProtein
													+  (animalCountPer * nfgPer * unitPer);
										}
									}
								}
							}
						}
						resultArray.push(nutritionProtein * 0.319/1000);
					}
				}
				for ( var aqua_increment in aquacultureData) {
					if (countryName == aquacultureData[aqua_increment].countryName) {
						if (latestYear == aquacultureData[aqua_increment].year) {
							resultArray.push("Aqua");
							aquaProteinIndex = aquacultureData[aqua_increment].nutritionProtein;
							resultArray.push(aquaProteinIndex * 1/1000);
						}
					}

				}

			}
			//alert(resultArray);
			// console.log(resultArray);

			var myarray = [];
			//alert(resultArray.length);
			var item = {
				"type" : 'pie',
				"name" : countryName + " (" + type + ")",
				"data" : [ [ resultArray[1], resultArray[2] ],
						[ resultArray[3], resultArray[4] ],
						[ resultArray[5], resultArray[6] ],
						[ resultArray[7], resultArray[8] ],
						[ resultArray[9], resultArray[10] ],
						[ resultArray[11], resultArray[12] ],
						[ resultArray[13], resultArray[14] ],
						[ resultArray[15], resultArray[16] ],
						[ resultArray[17], resultArray[18] ] ]
			};
			myarray.push(item);

			var resultJson = JSON.stringify(myarray);
			// alert(resultJson);

			//console.log(resultJson);

			$('#pieChart' + type)
					.highcharts(
							{
								chart : {
									plotBackgroundColor : null,
									plotBorderWidth : null,
									plotShadow : false
								},
								title : {
									text : countryName + " (" + type + ")",

								},
								tooltip : {
									pointFormat : '{series.name}: {point.percentage:.1f} % :<b>{point.y}</b>'
								},
								plotOptions : {
									pie : {
										allowPointSelect : true,
										cursor : 'pointer',
										dataLabels : {
															enabled: true,
															distance: -30,
															style: {
																fontWeight: 'bold',
																color: 'white',
																textShadow: '0px 1px 2px black'
																}
														},
										showInLegend : false
									}
								},
								credits : {
									enabled : false
								},
								series : myarray
							});
		}
		
//		var arrYears = ${yearList};
		//			var latestYear = arrYears[arrYears.length - 1];
		var latestYear = "${year}";
					 $("#para").text('Share of different animal types/species of total estimated feed demand(Year:'+latestYear+')');

	}

	function makeProteinJson(propertyValue) {
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};

		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", "");
		var listAnimalName = listAnimalName.replace("]", "");
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");

		var resultArray = [];
		var countryName = "${countryName}";

		var perChngAnmCount = "${perChngAnmCount}";
		var perChngAnmCountList;
		perChngAnmCountList=perChngAnmCount.split(":");

		var perChngNonForgRat = "${perChngNonForgRat}";
		var perChngNonForgRatList;
		perChngNonForgRatList=perChngNonForgRat.split(":");

		var perChngUtIdx = "${perChngUtIdx}";
		var perChngUtIdxList;
		perChngUtIdxList=perChngUtIdx.split(":");

		//New Data with updated changed values 
		resultArray.push(countryName + "(new)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionProtein = 0;
			var aquaNutritionProtein = 0;
			var yearNo = arrYears[yearIndex];
			for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
				var animalName = arrayAnimalName[animalIndex].trim();
				for ( var increment in animalData) {
					if (countryName == animalData[increment].countryName) {
						if (animalName == animalData[increment].animalName) {
						
							if (yearNo == animalData[increment].year) {
								var proteinIndex = animalData[increment].proteinUnitIndex;
								if (proteinIndex != null
										&& proteinIndex !== undefined) {
										
											var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].proteinUnitIndex)+((parseFloat(animalData[increment].proteinUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
										
									nutritionProtein = nutritionProtein
											+ (animalCountPer*nfgPer* unitPer);
									console.log(nutritionProtein);				
								}
							}
						}
					}
				}
			}
			for ( var aqua_increment in aquacultureData) {
				if (countryName == aquacultureData[aqua_increment].countryName) {
					if (yearNo == aquacultureData[aqua_increment].year) {
						var aquaProteinIndex = aquacultureData[aqua_increment].nutritionProtein;
						if (aquaProteinIndex != null
								&& aquaProteinIndex !== undefined) {
							aquaNutritionProtein = aquaNutritionProtein
									+ (aquacultureData[aqua_increment].nutritionProtein);
						}
					}
				}
			}
					var v =nutritionProtein * 0.319 + aquaNutritionProtein * 1; 
				v=v * propertyValue;
				v = v / 1000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
		}

		//Old Data
		resultArray.push(countryName + "(old)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionProtein = 0;
			var aquaNutritionProtein = 0;
			var yearNo = arrYears[yearIndex];

			for ( var increment in animalData) {
				if (countryName == animalData[increment].countryName) {
					if (yearNo == animalData[increment].year) {
						var proteinIndex = animalData[increment].proteinUnitIndex;
						if (proteinIndex != null && proteinIndex !== undefined) {
							nutritionProtein = nutritionProtein
									+ (animalData[increment].animalCount
											* animalData[increment].nonForageRate * proteinIndex);
						}
					}

				}
			}

			for ( var aqua_increment in aquacultureData) {
				if (countryName == aquacultureData[aqua_increment].countryName) {
					if (yearNo == aquacultureData[aqua_increment].year) {
						var aquaProteinIndex = aquacultureData[aqua_increment].nutritionProtein;
						if (aquaProteinIndex != null
								&& aquaProteinIndex !== undefined) {
							aquaNutritionProtein = aquaNutritionProtein
									+ (aquacultureData[aqua_increment].nutritionProtein);
						}
					}
				}
			}
				var v =nutritionProtein * 0.319 + aquaNutritionProtein * 1; 
				v=v * propertyValue;
				v = v / 1000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
		}

		var myarray = [];
		var arrayLen = resultArray.length;
		for ( var i = 0; i < arrayLen; i = i + 5) {

			var item = {
				"name" : resultArray[i],
				"data" : [ resultArray[i + 1], resultArray[i + 2],
						resultArray[i + 3], resultArray[i + 4] ]

			};

			myarray.push(item);
		}
		return myarray;

	}

	function makeEnergyJson(propertyValue) {

		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};

		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", "");
		var listAnimalName = listAnimalName.replace("]", "");
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");

		var resultArray = [];
		var countryName = "${countryName}";

		var perChngAnmCount = "${perChngAnmCount}";
		var perChngAnmCountList;
		perChngAnmCountList=perChngAnmCount.split(":");

		var perChngNonForgRat = "${perChngNonForgRat}";
		var perChngNonForgRatList;
		perChngNonForgRatList=perChngNonForgRat.split(":");

		var perChngUtIdx = "${perChngUtIdx}";
		var perChngUtIdxList;
		perChngUtIdxList=perChngUtIdx.split(":");


		//New Data with updated nfg
		resultArray.push(countryName + "(new)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionEnergy = 0;
			var aquaNutritionEnergy = 0;
			var yearNo = arrYears[yearIndex];
			for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
				var animalName = arrayAnimalName[animalIndex].trim();
				for ( var increment in animalData) {
					if (countryName == animalData[increment].countryName) {
						if (animalName == animalData[increment].animalName) {
							
							
							if (yearNo == animalData[increment].year) {
								var energyIndex = animalData[increment].energyUnitIndex;
								if (energyIndex != null
										&& energyIndex !== undefined) {

											var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].energyUnitIndex)+((parseFloat(animalData[increment].energyUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
										
									nutritionEnergy = nutritionEnergy
											+ ( animalCountPer*nfgPer* unitPer);
									console.log(nutritionEnergy);				
								}
							}
						}
					}
				}
			}
			for ( var aqua_increment in aquacultureData) {
				if (countryName == aquacultureData[aqua_increment].countryName) {
					if (yearNo == aquacultureData[aqua_increment].year) {
						var aquaEnergyIndex = aquacultureData[aqua_increment].nutritionEnergy;
						if (aquaEnergyIndex != null
								&& aquaEnergyIndex !== undefined) {
							aquaNutritionEnergy = aquaNutritionEnergy
									+ (aquacultureData[aqua_increment].nutritionEnergy);
						}
					}
				}
			}
			var v = nutritionEnergy * 35600 + aquaNutritionEnergy * 1;
				v=v * propertyValue;
				v = v / 1000000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
		}

		//Old Data
		resultArray.push(countryName + "(old)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionEnergy = 0;
			var aquaNutritionEnergy = 0;
			var yearNo = arrYears[yearIndex];

			for ( var increment in animalData) {
				if (countryName == animalData[increment].countryName) {
					if (yearNo == animalData[increment].year) {
						var energyIndex = animalData[increment].energyUnitIndex;
						if (energyIndex != null && energyIndex !== undefined) {
							nutritionEnergy = nutritionEnergy
									+ (animalData[increment].animalCount
											* animalData[increment].nonForageRate * energyIndex);
						}
					}

				}
			}

			for ( var aqua_increment in aquacultureData) {
				if (countryName == aquacultureData[aqua_increment].countryName) {
					if (yearNo == aquacultureData[aqua_increment].year) {
						var aquaEnergyIndex = aquacultureData[aqua_increment].nutritionEnergy;
						if (aquaEnergyIndex != null
								&& aquaEnergyIndex !== undefined) {
							aquaNutritionEnergy = aquaNutritionEnergy
									+ (aquacultureData[aqua_increment].nutritionEnergy);
						}
					}
				}
			}
			var v = nutritionEnergy * 35600 + aquaNutritionEnergy * 1;
				v=v * propertyValue;
				v = v / 1000000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
		}

		var myarray = [];
		var arrayLen = resultArray.length;
		for ( var i = 0; i < arrayLen; i = i + 5) {

			var item = {
				"name" : resultArray[i],
				"data" : [ resultArray[i + 1], resultArray[i + 2],
						resultArray[i + 3], resultArray[i + 4] ]

			};

			myarray.push(item);
		}
		var resultJson = JSON.stringify(myarray);
//		console.log(resultJson);
		return myarray;

	}

	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}

	function reportChanges() {
				$('#collapseTable').empty();
				$('#collapseInfoTable').empty();
				$('#collapseChangeInfoTable').empty();
				$('#collapseSendTable').empty();
				
//				var nfgRate = "${nfgRate}";
//				var nfgList;
//				nfgList = nfgRate.split(",");

		var perChngAnmCount = "${perChngAnmCount}";
		var perChngAnmCountList;
		perChngAnmCountList=perChngAnmCount.split(":");

		var perChngNonForgRat = "${perChngNonForgRat}";
		var perChngNonForgRatList;
		perChngNonForgRatList=perChngNonForgRat.split(":");

		var perChngUtIdx = "${perChngUtIdx}";
		var perChngUtIdxList;
		perChngUtIdxList=perChngUtIdx.split(":");

				var propertyValue = "${propertyValue}";
				
				if(propertyValue == "")
					{
					propertyValue = 1;
					}
				else
					{
					propertyValue = parseFloat(propertyValue);
					}
				var listAnimalName = "${animalNameList}";
				var listAnimalName = listAnimalName.replace("[", "");
				var listAnimalName = listAnimalName.replace("]", "");
				var arrayAnimalName;
				arrayAnimalName = listAnimalName.split(",");
				
				var animalData = ${animalRawData};
				var aquacultureData = ${aquacultureData};
				var arrYears = ${yearList};
				var resultArray = [];
				var countryName = "${countryName}";
				var unitIndx = "${unitIndex}";
							
					for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
						var nutrition = 0;
						var nutritionNew = 0;
						var yearNo = arrYears[yearIndex];
							
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (yearNo == animalData[increment].year) {
									if (unitIndx == "Energy") {
										var energyIndex = animalData[increment].energyUnitIndex;
										if (energyIndex != null
												&& energyIndex !== undefined) {
											nutrition = nutrition
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * energyIndex);
										}

									} else {

										var proteinIndex = animalData[increment].proteinUnitIndex;
										if (proteinIndex != null
												&& proteinIndex !== undefined) {
											nutrition = nutrition
													+ (animalData[increment].animalCount
															* animalData[increment].nonForageRate * proteinIndex);
										}

									}

								}
							}
						}
						
						for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
							var animalName = arrayAnimalName[animalIndex].trim();
							
							for ( var increment in animalData) {
								if (countryName == animalData[increment].countryName) {					
									if(animalName == animalData[increment].animalName){
												
										if (yearNo == animalData[increment].year) {
										if (unitIndx == "Energy") {
											var energyIndex = animalData[increment].energyUnitIndex;
											if (energyIndex != null
													&& energyIndex !== undefined) {
													
										var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].energyUnitIndex)+((parseFloat(animalData[increment].energyUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
													
												nutritionNew = nutritionNew
														+ ( animalCountPer*nfgPer*unitPer);
											}

										} else {

											var proteinIndex = animalData[increment].proteinUnitIndex;
											if (proteinIndex != null
													&& proteinIndex !== undefined) {
												var animalCountPer=parseInt(animalData[increment].animalCount)+((parseInt(animalData[increment].animalCount))*parseInt(perChngAnmCountList[animalIndex])/100);
												animalCountPer=animalCountPer.toFixed(0);
												var nfgPer=parseFloat(animalData[increment].nonForageRate)+((parseFloat(animalData[increment].nonForageRate))*parseFloat(perChngNonForgRatList[animalIndex])/100);
												nfgPer=nfgPer.toFixed(2);
												var unitPer=parseFloat(animalData[increment].proteinUnitIndex)+((parseFloat(animalData[increment].proteinUnitIndex))*parseFloat(perChngUtIdxList[animalIndex])/100);
												unitPer=unitPer.toFixed(2);
													
												nutritionNew = nutritionNew
														+ (animalCountPer*nfgPer*unitPer);
											}

										}

									}
									
									}
									
									
								}

							}
						
						}	
						if (unitIndx == "Energy") {
							nutrition = nutrition * 35600;
							nutritionNew = nutritionNew * 35600;
						} else {
							nutrition = nutrition * 0.319 ;
							nutritionNew = nutritionNew * 0.319;
						}
						//aqua
						for ( var aqua_increment in aquacultureData) {
							if (countryName == aquacultureData[aqua_increment].countryName) {
								if (yearNo == aquacultureData[aqua_increment].year) {
									if (unitIndx == "Energy") {
										var energyIndex = aquacultureData[aqua_increment].nutritionEnergy;
										if (energyIndex != null
												&& energyIndex !== undefined) {
											nutrition = nutrition
													+ (aquacultureData[aqua_increment].nutritionEnergy * 1);
											nutritionNew = nutritionNew
													+ (aquacultureData[aqua_increment].nutritionEnergy * 1);		
											nutrition = nutrition * propertyValue /1000000;
											nutritionNew = nutritionNew * propertyValue /1000000;		
										}
									} else {
										var proteinIndex = aquacultureData[aqua_increment].nutritionProtein;
										if (proteinIndex != null
												&& proteinIndex !== undefined) {
											nutrition = nutrition
													+ (aquacultureData[aqua_increment].nutritionProtein * 1);
											nutritionNew = nutritionNew
													+ (aquacultureData[aqua_increment].nutritionProtein * 1);
											nutrition = nutrition * propertyValue /1000;
											nutritionNew = nutritionNew * propertyValue /1000;														
										}

									}
								}
							}
						}


							$('#collapseTable').prepend(

									'<tr><td style="text-align: center;">' + yearNo + '</td>' + '<td style="text-align: center;">'
											+ parseInt(nutrition) + '</td>' + '<td style="text-align: center;">' + parseInt(nutritionNew)
											+ '</td></tr>');
					}

				if (unitIndx == "Energy") {	
				$('#collapseTable').prepend(
						'<tr><th style="text-align: center;" colspan="5" style="color: lightseagreen">'+countryName+'</th></tr>'
						+'<tr><th style="text-align: center;"> Year </th><th style="text-align: center;"> Old Data (1000 GJ) </th><th style="text-align: center;"> New Data (1000 GJ)</th></tr>');
					}
				else{
				$('#collapseTable').prepend(
						'<tr><th style="text-align: center;" colspan="5" style="color: lightseagreen">'+countryName+'</th></tr>'
						+'<tr><th style="text-align: center;"> Year </th><th style="text-align: center;"> Old Data (1000 MT) </th><th style="text-align: center;"> New Data (1000 MT)</th></tr>');
				}	
			
			if(unitIndx=="Energy"){
				$('#collapseChangeInfoTable')
				.append(
								'<tr><th style="text-align: center;" colspan="4">Percentage Change in Values</th></tr>' 
								+'<tr>' 
								+ '<th style="text-align: center;">Species</th>' 
								+ '<th style="text-align: center; width:120px;">Animal number</th>'
								+ '<th style="text-align: center;">Non-forage rate (share of animal population that is not fed through grazing, in %)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (energy)</th>'
								+ '</tr>');
			}
			else{
				
				$('#collapseChangeInfoTable')
				.append(
								'<tr><th style="text-align: center;" colspan="4">Percentage Change in Values</th></tr>' 
								+'<tr>' 
								+ '<th style="text-align: center;">Species</th>' 
								+ '<th style="text-align: center; width:120px;">Animal number</th>'
								+ '<th style="text-align: center;">Non-forage rate (share of animal population that is not fed through grazing, in %)</th>'
								+ '<th style="text-align: center;">Animal Unit Index (protein)</th>'
								+ '</tr>');

			}

					var perChngAnmCount = "${perChngAnmCount}";
					var perChngAnmCountList;
					perChngAnmCountList=perChngAnmCount.split(":");

					var perChngNonForgRat = "${perChngNonForgRat}";
					var perChngNonForgRatList;
					perChngNonForgRatList=perChngNonForgRat.split(":");

					var perChngUtIdx = "${perChngUtIdx}";
					var perChngUtIdxList;
					perChngUtIdxList=perChngUtIdx.split(":");
			
					for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {

							
							
							$('#collapseChangeInfoTable')
							.append(
								'<tr>' + '<td style="text-align: center;">' + arrayAnimalName[animalIndex] + '</td>'  
									+'<td style="text-align: center;">' + parseFloat(perChngAnmCountList[animalIndex]).toFixed(2) + '</td>'
									+'<td style="text-align: center;">' + parseFloat(perChngNonForgRatList[animalIndex]).toFixed(2) + '</td>'
									+'<td style="text-align: center;">' + parseFloat(perChngUtIdxList[animalIndex]).toFixed(2) + '</td>'
									+ '</tr>');		
					}
		
			
				$('#collapseInfoTable').append(
						'<tr><td style="text-align: center;" colspan="6" style="color: lightseagreen">Reporter Information</td></tr>'
						+'<tr>'
						+'<td style="text-align: right;"> Name </td>'
						+'<td style="text-align: left;"> '
							+ '<input type="text" id="reporterName" name="reporterName" size="8"'
										+ 'class="form-control" style="font-weight:bold ;text-align: left;"> </td>'
						+'<td style="text-align: right;"> Email </td>'
						+'<td style="text-align: left;"> '
							+ '<input type="text" id="reporterEmail" name="reporterEmail" size="8"'
										+ 'class="form-control" style="font-weight:bold ;text-align: left;"> </td>'
						+'<td style="text-align: right;"> Comments </td>'				
						+'<td style="text-align: left;"> '
							+ '<input type="text" id="reporterComments" name="reporterComments" size="8"'
										+ 'class="form-control" style="font-weight:bold ;text-align: left;"> </td>'				
						+'</tr>'
				
						 
						);
				$('#collapseSendTable').append(
						'<tr><td style="text-align: center;margin-top:20px" colspan="6"><button type="button" class="btn btn-default" onclick="sendMail();">Send E-mail</button></td></tr>'
				);				

			}
		
		function sendMail() {

		reporterName = document.getElementById('reporterName').value;
		reporterEmail = document.getElementById('reporterEmail').value;
		reporterComments = document.getElementById('reporterComments').value;
		
		
		jQuery.ajax({
			type : "POST",
			url : getContextPath() + "/reportChanges.html",
			data : ({
				country : "${countryId}",
				unitIndex : "${unitIndex}",
				property : "${propertyName}",
				perChngAnmCount : "${perChngAnmCount}",
				 perChngNonForgRat : "${perChngNonForgRat}",
				 perChngUtIdx : "${perChngUtIdx}",
				name : reporterName,
				email : reporterEmail,
				commnet : reporterComments
			}),
			success : function(data) {
				alert("Thanks for submitting your analysis. Mail has been sent successfully.");
				jQuery("#animalData").html(data);
				window.location.href = getContextPath()
				+ "/index.html";
			}
		});
	/*		window.location.href = getContextPath()
			+ "/reportChanges.html?country=${countryId}&property=${propertyName}&unitIndex=${unitIndex}&nfgRate=${nfgRate}";
*/		 }

	$(document).ready(function() {
		var unitIndx = "${unitIndex}";
		var propertyValue = "${propertyValue}";
		var propertyName = "${propertyName}";
		var energyType ;
		if(unitIndx == "Energy")
		{	
			energyType = "1000 GJ";
		}
		else
		{
			energyType = "1000 MT";
		}
		if(propertyValue == "")
		{
		propertyValue = 1;
		}
		else
		{
		propertyValue = parseFloat(propertyValue);
		}
		var arrYears = ${yearList};
		if (unitIndx == "Energy") {
			var jsonData = makeEnergyJson(propertyValue);
		} else {
			var jsonData = makeProteinJson(propertyValue);
		}

		$('#lineChartDiv').highcharts({
			title : {
				text : 'Estimated Feed Demand',
				x : -20
			//center
			},
			subtitle : {
				text : 'Source: AMIS Database',
				x : -20
			},
			xAxis : {
				categories : arrYears
			},
			yAxis : {
				plotLines : [ {
					value : 0,
					width : 1,
					color : '#808080'
				} ],
				
				title: {
                        text: energyType
                       }
			},
			credits : {
				enabled : false
			},
			legend : {
				layout : 'vertical',
				align : 'right',
				verticalAlign : 'middle',
				borderWidth : 0
			},
			tooltip: {
				formatter: function() {
					
					return this.y;
				}
			},
			series : jsonData
		});

		getPieChart();
	});
	
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
			<ol style="padding-bottom: 0px" class="breadcrumb">
				<li><a style="cursor:pointer;"  onclick="goHome();">Visualize estimated feed demand</a></li>
				<li><a style="cursor:pointer;"  onclick="showScenario();">Scenario Analysis </a></li>
				<li style="float: right"><a class="active" onclick="goBack();">BACK</a></li>
				<li style="float: right"><a class="active" onclick="goHome();">HOME</a></li>
			</ol>
			<div class="container" id="page">
				<div class="row" padding-top: 10px">
				<div class="col-md-4" align="left">
                    <button type="button" class="btn btn-default">Country/Region
                    : ${countryName}</button>
                    </div>
                    <div class="col-md-4" align="center">
                    <button type="button" class="btn btn-default">Base Commodity : ${propertyName}</button>
                    </div>
                    <div class="col-md-4" align="right">
                    <button type="button" class="btn btn-default">Animal Unit
                    Index : ${unitIndex}</button>
                    </div>
				</div>
				

			</div>

		</div>
		<div>
			<div class="row" style="padding-top: 40px">
				<div class="col-md-12" id="lineChartDiv"></div>
			</div>
			<div  style="padding-top: 40px">
				<P id="para" ALIGN="CENTER"></P>
			</div>
			<div class="row" style="padding-top: 0px">
				<div class="col-md-6" style="display: inline-block;"
					id="pieChartNew"></div>
				<div class="col-md-6" style="display: inline-block;"
					id="pieChartOld"></div>
			</div>
			<div style="padding-top: 40px;">	
				<div class="row">
					<div class="col-md-11" style="margin-top: 30px" class="col-md-12" align="center">
						<button type="button" class="btn btn-default"
							data-toggle="collapse" onclick="reportChanges();"
							data-target="#collapseDiv" aria-expanded="false"
							aria-controls="collapseDiv">View / Report Changes</button>
					</div>

					<div class="col-md-6"></div>
				</div>
				<div id="collapseDiv" >
					<table id="collapseTable" class="bordered">
					</table>
					<table id="collapseChangeInfoTable" class="bordered" style="margin-top:20px">
					</table>
					<table id="collapseInfoTable" style="margin-top:20px">
					</table>
					<table id="collapseSendTable" style="margin-top:20px;">
					</table>
				</div>
			</div>
		</div>
</body>
</body>
</html>