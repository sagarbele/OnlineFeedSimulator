
<script type="text/javascript">



function makeProteinJson()
{


	var animalData = ${animalRawData};
	var aquacultureData = ${aquacultureData};


var arrYears = [ "2009","2010","2011","2012"];
var arrCountry = ["Canada","India","Germany","Mexico"];
var resultArray= [];
var countryArrayList ="${countryList}";
	var yearArrayList ="${yearList}";
	alert(countryArrayList);
	alert(yearArrayList);
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
	resultArray.push(nutritionProtein * 0.345);
	}

}

	//{countryName : Canada} , {nutritionProtein :[1588130.409965,1620992.5704280003,1549261.476312,0]}

	var myarray = [];
	var arrayLen = resultArray.length;
	for (var i = 0; i < arrayLen; i=i+5) {
		 var country =
			 {
				 "countryName": resultArray[i]
			 }
	    var item = {
	         "nutritionProtein":[ resultArray[i+1],resultArray[i+2],resultArray[i+3],resultArray[i+4]]
	
	    };
	 
		 myarray.push(country);
	     myarray.push(item);
	}
	var resultJson  = JSON.stringify(myarray);
	alert(resultJson);

}

function makeEnergyJson()
{

	var animalData = ${animalRawData};
	var aquacultureData = ${aquacultureData};


var arrYears = [ "2009","2010","2011","2012"];
var arrCountry = ["Canada","India","Germany","Mexico"];
var resultArray= [];

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
				var energyIndex = animalData[increment].EnergyUnitIndex;
		    	if(energyIndex != null && energyIndex !== undefined){ 
			    	 nutritionEnergy  = nutritionEnergy + (animalData[increment].animalCount * animalData[increment].nonForageRate * energyIndex ) ;
			    	 
					 }
		     	
				}
				
				
 			}
		
		
		}
	resultArray.push(nutritionEnergy * 0.319);
	}

}

	//{countryName : Canada} , {nutritionEnergy :[1588130.409965,1620992.5704280003,1549261.476312,0]}
	
	//{"countryName":"Canada","nutritionEnergy":"1989295.66","nutritionProtein":"42303.57","year":2010},
	//{"countryName":"Canada","nutritionEnergy":"1989295.66","nutritionProtein":"42303.57","year":2011},
	//{"countryName":"Canada","nutritionEnergy":"1989295.66","nutritionProtein":"42303.57","year":2012},
	//{"countryName":"Canada","nutritionEnergy":"0.00","nutritionProtein":"0.00","year":2013}]

	
	var myarray = [];
	var arrayLen = resultArray.length;
	for (var i = 0; i < arrayLen; i=i+5) {
		 var country =
			 {
				 "countryName": resultArray[i]
			 }
	    var item = {
	         "nutritionEnergy":[ resultArray[i+1],resultArray[i+2],resultArray[i+3],resultArray[i+4]]
	
	    };
	 
		 myarray.push(country);
	     myarray.push(item);
	}
	var resultJson  = JSON.stringify(myarray);
	alert(resultJson);


}


jQuery(document).ready(
			function() {
				
				makeEnergyJson();
				makeProteinJson();
});



</script>


<div>
	<tr>
		<td>${propertyName}</td><td>${propertyValue }</td><td>${unitIndex }</td>
	</tr>

		<tr>
			<td>${animalRawData}</td>
		</tr>
		<tr>
			<td>${aquacultureData}</td>
		</tr>

</div>

<div>

</div>