<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="shortcut icon" href="assets/ico/favicon.png">
<!-- Bootstrap core CSS -->
<script type="text/javascript">
function makeProteinJson()
{

	var animalData = ${animalRawData};
	var aquacultureData = ${aquacultureData};


	var arrYears =${yearList};
	var resultArray= [];
	var listCountry = ('${countryList}');
	listCountry = listCountry.substr(0,listCountry.length - 1);	
	
	var arrCountry ;
	arrCountry = listCountry.split(",");
	
	
	for(var i= 0; i < arrCountry.length ; i++ ) 
	{
	var countryName = arrCountry[i];
	resultArray.push(countryName);
	for(var j= 0; j < arrYears.length ; j++ )
		{
		var nutritionProtein = 0;
		var yearNo = arrYears[j];  
		
		
		for(var increment in animalData)
			{	
			if(countryName == animalData[increment].countryName)
				{
					if(yearNo == animalData[increment].year)
					{
					var proteinIndex = animalData[increment].proteinUnitIndex;
			    	if(proteinIndex != null && proteinIndex !== undefined){ 
				    	 nutritionProtein  = nutritionProtein + (animalData[increment].animalCount * animalData[increment].nonForageRate * proteinIndex ) ;
				    	 }
			     	}
				}
			}
		resultArray.push(nutritionProtein * 0.345); // Multiply by 10k to show it in graph 
		}
	
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

function makeEnergyJson()
{

	var animalData = ${animalRawData};
	var aquacultureData = ${aquacultureData};


	var arrYears =${yearList};
	var resultArray= [];
	var listCountry = ('${countryList}');
	listCountry = listCountry.substr(0,listCountry.length - 1);	
	
	var arrCountry ;
	arrCountry = listCountry.split(",");

	for(var i= 0; i < arrCountry.length ; i++ ) 
	{
	var countryName = arrCountry[i];
	resultArray.push(countryName);
	for(var j= 0; j < arrYears.length ; j++ )
		{
		var nutritionEnergy = 0;
		var yearNo = arrYears[j];  
		
		
		for(var increment in animalData)
			{	
			if(countryName == animalData[increment].countryName)
				{
					if(yearNo == animalData[increment].year)
					{
					var energyIndex = animalData[increment].energyUnitIndex;
			    	if(energyIndex != null && energyIndex !== undefined){ 
				    	 nutritionEnergy  = nutritionEnergy + (animalData[increment].animalCount * animalData[increment].nonForageRate * energyIndex ) ;
				    	 
						 }
			     	
					}
					
					
	 			}
			
			
			}
		resultArray.push(nutritionEnergy * 0.319);
		}
	
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

	jQuery(document)
			.ready(
					function() {
						
						var unitIndx = "${unitIndex}";
						var arrYears =${yearList};
						if(unitIndx=="Energy"){
							var jsonData =	makeEnergyJson();
						}
						else{
							var jsonData = makeProteinJson();						
						}

						$('#lineChartDiv').highcharts(
								{
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
		
					/*
					Country Array
					*/
					var animalData = ${animalRawData};
					var listCountry = ('${countryList}');
					listCountry = listCountry.substr(0,listCountry.length - 1);	
					var arrCountry ;
					arrCountry = listCountry.split(",");
					
					var listAnimal = ('${animalList}');
					listAnimal = listAnimal.substr(0,listAnimal.length - 1);
					var arrayAnimal ;
					arrayAnimal = listAnimal.split(",");
					alert(arrayAnimal + "-"+arrCountry);
						
					var resultArray= [];
					for(var countryIndex= 0; countryIndex < arrCountry.length ; countryIndex++ ) 
					{
						var countryName = arrCountry[countryIndex];
						resultArray.push(countryName);	
						alert(countryName);
						var nutritionEnergy = 0;
						var latestYear = arrYears[arrYears.length-1];  
									
						for(var animalIndex= 0; animalIndex < arrayAnimal.length ; animalIndex++ ) 
							{
							resultArray.push(arrayAnimal[animalIndex]);
							for(var increment in animalData)
									{	
									if(countryName == animalData[increment].countryName)
										{
											
											if(latestYear == animalData[increment].year)
											{
											var energyIndex = animalData[increment].energyUnitIndex;
											if(energyIndex != null && energyIndex !== undefined){ 
												 nutritionEnergy  = nutritionEnergy + (animalData[increment].animalCount * animalData[increment].nonForageRate * energyIndex ) ;
												 }
											}
										}
									}
								resultArray.push(nutritionEnergy * 0.319);		
							}
						console.log(resultArray);
							console.log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++");
						/*name : 'Animal share',
												data : [ [ 'Firefox', 45.0 ],
														[ 'IE', 26.8 ], 
														['Chrome', 12.8],
														[ 'Safari', 8.5 ],
														[ 'Opera', 6.2 ],
														[ 'Others', 0.7 ] ]
														*/
							var myarray = [];
								var item = {
								"type" : 'pie',
								"name" : "Animal Data",
								"data" : 	[[resultArray[1], resultArray[2]], [resultArray[3], resultArray[4]],
											[resultArray[5], resultArray[6]], [resultArray[7], resultArray[8]],
											[resultArray[9], resultArray[10]],[resultArray[11],resultArray[12]],
											[resultArray[13],resultArray[14]],[resultArray[15],resultArray[16]]]
											}
								;
								myarray.push(item);

							var resultJson = JSON.stringify(myarray);
							alert(resultJson);
							
							console.log(resultJson);
							
						$('#pieChartDiv')
								.highcharts(
										{
											chart : {
												plotBackgroundColor : null,
												plotBorderWidth : null,
												plotShadow : false
											},
											title :{
												text : countryName,
											},
											tooltip : {
												pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
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
				});
</script>

<div class="row" style="padding-top: 40px">
	<div class="col-md-12" id="lineChartDiv"></div>
</div>
<div class="row" style="padding-top: 20px">
	<div class="col-md-12" id="pieChartDiv1"></div>
</div>