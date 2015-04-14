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
	function getPieChart() {
		var arrYears = ${yearList};
		var unitIndx = "${unitIndex}";
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var countryName = "${countryName}";

		var listAnimal = ('${animalList}');
		listAnimal = listAnimal
				.substr(0, listAnimal.length - 1);
		var arrayAnimal;
		arrayAnimal = listAnimal.split(",");
		
		var nfgRate = "${nfgRate}";
		var nfgList;
		nfgList = nfgRate.split(",");
		
		// var resultArray= [];
		for ( var dataType = 0; dataType < 2; dataType++) {
			var resultArray = [];
			if(dataType==0){
				var type= "Old";
				resultArray.push(countryName+"(Old)");
				}
			else {
				var type= "New";
				resultArray.push(countryName+"(New)");
			}	
			var nutritionEnergy = 0;
			var nutritionProtein = 0;
			var aquaEnergyIndex = 0;
			var aquaProteinIndex = 0;
			
			var latestYear = arrYears[arrYears.length - 1];
			if (unitIndx == "Energy") {
				if(dataType==0){
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						resultArray.push(arrayAnimal[animalIndex]);
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {	
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
				}
				else{
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						resultArray.push(arrayAnimal[animalIndex]);
						var nfgValue = nfgList[animalIndex].replace((animalIndex+1)+"a-",""); 
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {	
								if (latestYear == animalData[increment].year) {
									var energyIndex = animalData[increment].energyUnitIndex;
									if (energyIndex != null
											&& energyIndex !== undefined) {
										nutritionEnergy = nutritionEnergy
												+ (animalData[increment].animalCount
														* nfgValue * energyIndex);
									}
								}
								}
							}
						}
						resultArray.push(nutritionEnergy * 0.319);
					}				
				}
				for ( var aqua_increment in aquacultureData) {
					if (countryName == aquacultureData[aqua_increment].countryName) {
						if (latestYear == aquacultureData[aqua_increment].year) {
							resultArray.push("Aqua");
							aquaEnergyIndex = aquacultureData[aqua_increment].nutritionEnergy;
							resultArray.push(aquaEnergyIndex * 1);
						}
					}
					
				}
				
				
			} else {
				if(dataType==0){	
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
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
						resultArray.push(nutritionProtein * 35600);
					}
				}
				else {
					for ( var animalIndex = 0; animalIndex < arrayAnimal.length; animalIndex++) {
						resultArray.push(arrayAnimal[animalIndex]);
						var nfgValue = nfgList[animalIndex].replace((animalIndex+1)+"a-",""); 
						for ( var increment in animalData) {
							if (countryName == animalData[increment].countryName) {
								if (arrayAnimal[animalIndex] == animalData[increment].animalName) {	
								if (latestYear == animalData[increment].year) {
									var proteinIndex = animalData[increment].proteinUnitIndex;
									if (proteinIndex != null
											&& proteinIndex !== undefined) {
										nutritionProtein = nutritionProtein
												+ (animalData[increment].animalCount
														* nfgValue * proteinIndex);
									}
								}
								}
							}
						}
						resultArray.push(nutritionProtein * 35600);
					}				
				}				
				for ( var aqua_increment in aquacultureData) {
					if (countryName == aquacultureData[aqua_increment].countryName) {
						if (latestYear == aquacultureData[aqua_increment].year) {
							resultArray.push("Aqua");
							aquaProteinIndex = aquacultureData[aqua_increment].nutritionProtein;
							resultArray.push(aquaProteinIndex * 1);
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
				"name" : countryName + " (" + type+")" ,
				"data" : [ [ resultArray[1], resultArray[2] ],
						[ resultArray[3], resultArray[4] ],
						[ resultArray[5], resultArray[6] ],
						[ resultArray[7], resultArray[8] ],
						[ resultArray[9], resultArray[10] ],
						[ resultArray[11], resultArray[12] ],
						[ resultArray[13], resultArray[14] ],
						[ resultArray[15], resultArray[16] ],
						[ resultArray[17], resultArray[18] ]]
			};
			myarray.push(item);

			var resultJson = JSON.stringify(myarray);
			// alert(resultJson);

			//console.log(resultJson);

			$('#pieChart'+type)
					.highcharts(
							{
								chart : {
									plotBackgroundColor : null,
									plotBorderWidth : null,
									plotShadow : false
								},
								title : {
									text : countryName +  " (" + type+")" ,

								},
								tooltip : {
									pointFormat : '{series.name}:  {point.percentage:.1f} % :<b>{point.y}</b>'
								},
								plotOptions : {
									pie : {
										allowPointSelect : true,
										cursor : 'pointer',
										dataLabels : {
											enabled : false
										},
										showInLegend : true
									}
								},
								credits : {
									enabled : false
								},
								series : myarray
							});
		}
		
	}

	function makeProteinJson() {
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
		var nfgRate = "${nfgRate}";
		var nfgList;
		nfgList = nfgRate.split(",");
		

		//New Data with updated nfg
		resultArray.push(countryName+"(new)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionProtein = 0;
			var aquaNutritionProtein = 0;
			var yearNo = arrYears[yearIndex];
			for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
				var animalName=arrayAnimalName[animalIndex].trim();
				for ( var increment in animalData) {
					if (countryName == animalData[increment].countryName) {
					if (animalName == animalData[increment].animalName) {
						var nfgValue = nfgList[animalIndex].replace((animalIndex+1)+"a-",""); 
						
						if (yearNo == animalData[increment].year) {
							var proteinIndex = animalData[increment].proteinUnitIndex;
							if (proteinIndex != null
									&& proteinIndex !== undefined) {
								nutritionProtein = nutritionProtein
										+ (animalData[increment].animalCount
												* nfgValue * proteinIndex);
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
			resultArray.push(nutritionProtein * 35600+ aquaNutritionProtein*1);
		}

		//Old Data
		resultArray.push(countryName+"(old)");
		for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
			var nutritionProtein = 0;
			var aquaNutritionProtein = 0;
			var yearNo = arrYears[yearIndex];
			
				for ( var increment in animalData) {
					if (countryName == animalData[increment].countryName) {
						if (yearNo == animalData[increment].year) {
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
			resultArray.push(nutritionProtein * 35600+ aquaNutritionProtein*1);
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

	function makeEnergyJson() {

		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var listAnimalName = "${animalNameList}";
		var listAnimalName = listAnimalName.replace("[", ""); 
		var listAnimalName = listAnimalName.replace("]", ""); 
		var arrayAnimalName;
		arrayAnimalName = listAnimalName.split(",");
		console.log(arrayAnimalName);
		var resultArray = [];
		var countryName = "${countryName}";
		var nfgRate = "${nfgRate}";
		var nfgList;
		nfgList = nfgRate.split(",");
		console.log(nfgList);

			//New Data with updated nfg
			resultArray.push(countryName+"(new)");
			for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
				var nutritionEnergy = 0;
				var aquaNutritionEnergy = 0;
				var yearNo = arrYears[yearIndex];
				for ( var animalIndex = 0; animalIndex < arrayAnimalName.length; animalIndex++) {
					var animalName=arrayAnimalName[animalIndex].trim();
					for ( var increment in animalData) {
						if (countryName == animalData[increment].countryName) {
						if (animalName == animalData[increment].animalName) {
							var nfgValue = nfgList[animalIndex].replace((animalIndex+1)+"a-",""); 
							console.log(nfgValue +"-"+animalName);
							if (yearNo == animalData[increment].year) {
								var energyIndex = animalData[increment].energyUnitIndex;
								if (energyIndex != null
										&& energyIndex !== undefined) {
									nutritionEnergy = nutritionEnergy
											+ (animalData[increment].animalCount
													* nfgValue * energyIndex);
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
				resultArray.push(nutritionEnergy * 0.319+ aquaNutritionEnergy*1);
			}

			//Old Data
			resultArray.push(countryName+"(old)");
			for ( var yearIndex = 0; yearIndex < arrYears.length; yearIndex++) {
				var nutritionEnergy = 0;
				var aquaNutritionEnergy = 0;
				var yearNo = arrYears[yearIndex];
				
					for ( var increment in animalData) {
						if (countryName == animalData[increment].countryName) {
							if (yearNo == animalData[increment].year) {
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
				resultArray.push(nutritionEnergy * 0.319+ aquaNutritionEnergy*1);
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
		console.log(resultJson);
		return myarray;

	}

	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}
	
$(document).ready(function(){
		var unitIndx = "${unitIndex}";
		var arrYears = ${yearList};
		if (unitIndx == "Energy") {
			var jsonData = makeEnergyJson();
		} else {
			var jsonData = makeProteinJson();
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
				} ]
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
			series : jsonData
		});
		
		getPieChart();
	});

	
	
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

			<div class="container" id="page" style="padding-top: 60px">
				<h4>
					<b><div class="row"
							style="margin-left: 20px; margin-right: 20px; margin-top: 30px; margin-bottom: 50px; background-color: #ADD5F7;">
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
						</div></b>
				</h4>

				<div class="row" style="margin-top: 30px">
					<div class="col-md-1">
						<button type="button" class="btn btn-default"
							onClick="reportChanges();">Report Changes</button>
					</div>

					<div class="col-md-6"></div>
				</div>
			</div>

		</div>
		<div>
<div class="row" style="padding-top: 40px">
	<div class="col-md-12" id="lineChartDiv"></div>
</div>
<div class="row" style="padding-top: 20px">
	<div class="col-md-6" style="display: inline-block;" id="pieChartNew"></div>
	<div class="col-md-6" style="display: inline-block;" id="pieChartOld"></div>
</div>

	</div>
</body>
</body>
</html>