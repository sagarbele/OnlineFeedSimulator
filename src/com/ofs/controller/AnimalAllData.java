package com.ofs.controller;

import java.io.IOException;
import java.util.List;





import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ofs.model.AnimalData;
import com.ofs.service.AnimalService;

/**
 * @author  Sagar, Amit
 *
 */
@Controller
public class AnimalAllData { 
	
	@Autowired
	private AnimalService animalService;
	

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView welcome() {
		return new ModelAndView("index");
	}
	
	
	@RequestMapping(value="/showSimulator", method = RequestMethod.GET)
	public String getAllData(Model model) {
		List<AnimalData> animalData = animalService.getAnimalData();
		for(AnimalData data:animalData){
			System.out.println(data.getAnimalCount()+"--"+data.getYear()+"--"+data.getCountryId());
		}
		
		model.addAttribute("animalData",animalData);
		
		/*			ObjectMapper mapper = new ObjectMapper();
		try {
			System.out.println(mapper.writeValueAsString(animalData));
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
*/
//		model.put("allData",  animalService.getAnimalData());
		//System.out.println( animalService.getAnimalData().ge);
	//	return null;
		return "showSimulator";
	}
}
