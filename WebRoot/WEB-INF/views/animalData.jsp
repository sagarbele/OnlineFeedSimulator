
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="shortcut icon" href="assets/ico/favicon.png">
<!-- Bootstrap core CSS -->
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
		
		
	function makeTable(propertyValue) {
		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var resultArray = [];
		var listCountry = ('${countryList}');
		listCountry = listCountry.substr(0, listCountry.length - 1);
		var unitIndx = "${unitIndex}";
		//console.log(unitIndx);
		var arrCountry;
		arrCountry = listCountry.split(",");
		var energyType ;
		if(unitIndx == "Energy")
		{	
			energyType = "1000 GJ";
		}
		else
		{
			energyType = "1000 MT";
		}

		for ( var countryIndex = 0; countryIndex < arrCountry.length; countryIndex++) {
			var countryName = arrCountry[countryIndex];

			for ( var yearIndex = 0; yearIndex <= arrYears.length; yearIndex++) {
				var nutrition = 0;

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
													* animalData[increment].nonForageRate * energyIndex * 35600);
									
								}

							} else {

								var proteinIndex = animalData[increment].proteinUnitIndex;
								if (proteinIndex != null
										&& proteinIndex !== undefined) {
									nutrition = nutrition
											+ (animalData[increment].animalCount
													* animalData[increment].nonForageRate * proteinIndex *0.319);
								}

							}

						}
					}

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
									}
							} else {
								var proteinIndex = aquacultureData[aqua_increment].nutritionProtein;
								if (proteinIndex != null
										&& proteinIndex !== undefined) {
									nutrition = nutrition
											+ (aquacultureData[aqua_increment].nutritionProtein * 1);
								}

							}
						}
					}
				}
				
				nutrition = nutrition * parseFloat(propertyValue);
				if(unitIndx == "Energy")
				{
				nutrition = nutrition / 1000000;
				}
				else
				{
				nutrition = nutrition / 1000;
				}
				nutrition= formatNumber(nutrition);
				

				if (yearIndex == arrYears.length ) {
						$('#table' + (countryIndex + 1))
							.prepend(
									'<tr>'
											+ '<th width="100px">' + "Year" + '</th>'
											+ '<th>' + "Estimated Feed( "+ energyType +" )" + '</th>'
											+ '</tr>');
				} else {
					
					$('#tableData' + (countryIndex + 1)).prepend(
							'<tr>' + '<td width="100px">'
									+ yearNo + '</td>' + '<td>' + (nutrition)
									+ '</td>' + '</tr>');
				}
			}

		}
	}

	function makeProteinJson(propertyValue) {

		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var resultArray = [];
		var listCountry = ('${countryList}');
		listCountry = listCountry.substr(0, listCountry.length - 1);

		var arrCountry;
		arrCountry = listCountry.split(",");

		for ( var i = 0; i < arrCountry.length; i++) {
			var countryName = arrCountry[i];
			resultArray.push(countryName);
			for ( var j = 0; j < arrYears.length; j++) {
				var nutritionProtein = 0;
				var aquaNutritionProtein = 0;
				var yearNo = arrYears[j];

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
				var v =nutritionProtein * 0.319 + aquaNutritionProtein * 1; 
				v=v * propertyValue;
				v = v / 1000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
				
			}

		}

		var tempArray = [];
		tempArray = resultArray;
		var myarray = [];
		var tempLen = tempArray.length;
		var arrayLen = tempArray.length;
		var yearsLength = arrYears.length;
		for (; arrayLen > 0;) {
			var checkArray = [];
			var checkSlicedData = [];
			var countryName = tempArray.slice(0, 1);
			checkArray = tempArray.slice(1, yearsLength + 1);
			var item = {
				"name" : countryName,
				"data" : checkArray
			};
			checkSlicedData = tempArray.slice(yearsLength + 1, tempLen);
			tempArray = checkSlicedData;
			arrayLen = tempArray.length;
			myarray.push(item);
		}

		return myarray;

	}

	function makeEnergyJson(propertyValue) {

		var animalData = ${animalRawData};
		var aquacultureData = ${aquacultureData};
		var arrYears = ${yearList};
		var resultArray = [];
		var listCountry = ('${countryList}');
		listCountry = listCountry.substr(0, listCountry.length - 1);

		var arrCountry;
		arrCountry = listCountry.split(",");

		for ( var i = 0; i < arrCountry.length; i++) {
			var countryName = arrCountry[i];
			resultArray.push(countryName);
			for ( var j = 0; j < arrYears.length; j++) {
				var nutritionEnergy = 0;
				var aquaNutritionEnergy = 0;
				var yearNo = arrYears[j];

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
				var v = nutritionEnergy * 35600 + aquaNutritionEnergy * 1;
				v=v * propertyValue;
				v = v / 1000000;
				v = formatNumberRoundOff(v);
				resultArray.push(v);
			}

		}

		var tempArray = [];
		tempArray = resultArray;
		var myarray = [];
		var tempLen = tempArray.length;
		var arrayLen = tempArray.length;
		var yearsLength = arrYears.length;
		for (; arrayLen > 0;) {
			var checkArray = [];
			var checkSlicedData = [];
			var countryName = tempArray.slice(0, 1);
			checkArray = tempArray.slice(1, yearsLength + 1);
			var item = {
				"name" : countryName,
				"data" : checkArray
			};
			checkSlicedData = tempArray.slice(yearsLength + 1, tempLen);
			tempArray = checkSlicedData;
			arrayLen = tempArray.length;
			myarray.push(item);
		}

		return myarray;

	}

	jQuery(document)
			.ready(
					function() {

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

						var animalData = ${animalRawData};
						var aquacultureData = ${aquacultureData};

						var listCountry = ('${countryList}');
						listCountry = listCountry.substr(0,
								listCountry.length - 1);
						var arrCountry;
						arrCountry = listCountry.split(",");

						var listAnimal = ('${animalList}');
						listAnimal = listAnimal
								.substr(0, listAnimal.length - 1);
						var arrayAnimal;
						arrayAnimal = listAnimal.split(",");

						for ( var countryIndex = 0; countryIndex < arrCountry.length; countryIndex++) {
							var countryName = arrCountry[countryIndex];
							var resultArray = [];
							resultArray.push(countryName);

							var aquaEnergyIndex = 0;
							var aquaProteinIndex = 0;

							var latestYear = arrYears[arrYears.length - 1];
							if (unitIndx == "Energy") {
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
														nutritionEnergy =(animalData[increment].animalCount
																		* animalData[increment].nonForageRate * energyIndex);
															
													}
												}
											}
										}
									}
									
									resultArray.push(formatNumberRoundOff(nutritionEnergy * 35600/1000000));

								}
								for ( var aqua_increment in aquacultureData) {
									if (countryName == aquacultureData[aqua_increment].countryName) {
										if (latestYear == aquacultureData[aqua_increment].year) {
											resultArray.push("Aqua");
											aquaEnergyIndex = aquacultureData[aqua_increment].nutritionEnergy;
											
											resultArray.push(formatNumberRoundOff(aquaEnergyIndex * 1/1000000));
										}
									}

								}

							} else {
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
														nutritionProtein = (animalData[increment].animalCount
																		* animalData[increment].nonForageRate * proteinIndex);
													}
												}
											}
										}
									}
									resultArray.push(formatNumberRoundOff(nutritionProtein * 0.319/100));
								}
								for ( var aqua_increment in aquacultureData) {
									if (countryName == aquacultureData[aqua_increment].countryName) {
										if (latestYear == aquacultureData[aqua_increment].year) {
											resultArray.push("Aqua");
											aquaProteinIndex = aquacultureData[aqua_increment].nutritionProtein;
											resultArray.push(formatNumberRoundOff(aquaProteinIndex * 1/100));
										}
									}

								}

							}
							
							var myarray = [];
							var item = {
								"type" : 'pie',
								"name" : countryName,
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

							$('#pieChartDiv' + (countryIndex + 1))
									.highcharts(
											{
												chart : {
													plotBackgroundColor : null,
													plotBorderWidth : null,
													plotShadow : false
												},
												title : {
													text :  countryName,

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
						//Generate Table
						makeTable(propertyValue);
						
						var arrYears = ${yearList};
					var latestYear = arrYears[arrYears.length - 1];
					 $("#para").text('Share of different animal types/species of total estimated feed demand(Year:'+latestYear+')');
					}
					
					);
</script>

<div class="row" style="padding-top: 40px">
	<div class="col-md-12" id="lineChartDiv"></div>
</div>

<div  style="padding-top: 40px" >
	<P id="para" ALIGN="CENTER"></P>
</div>
<div class="row" style="padding-top: 0px">
	<div class="col-md-4" style="display: inline-block;" id="pieChartDiv1"></div>
	<div class="col-md-4" style="display: inline-block;" id="pieChartDiv2"></div>
	<div class="col-md-4" style="display: inline-block;" id="pieChartDiv3"></div>
</div>

<div class="row" style="padding-top: 20px; padding-bottom: 20px" >
	<div class="col-md-4" style="display: inline-block;" id="tableDiv1">
		<table class="bordered" id='table1'>
		</table>
		<div id="collapseTable1">
			<table id='tableData1' class="bordered">
			</table>
		</div>
	</div>
	<div class="col-md-4" style="display: inline-block;" id="tableDiv2">
		<table class="bordered" id='table2'>
		</table>
		<div id="collapseTable2">
			<table id='tableData2' class="bordered">
			</table>
		</div>
	</div>
	<div class="col-md-4" style="display: inline-block;" id="tableDiv3">
		<table class="bordered" id='table3'>
		</table>
		<div id="collapseTable3">
			<table id='tableData3' class="bordered">
			</table>
		</div>
	</div>
</div>