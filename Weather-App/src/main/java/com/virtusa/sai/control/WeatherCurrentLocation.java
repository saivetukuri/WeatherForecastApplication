package com.virtusa.sai.control;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.Normalizer;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.virtusa.sai.dao.LocationWithOutCoords;
//WeatherCurrentLocation is a Controller
@Controller
public class WeatherCurrentLocation {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeatherCurrentLocation.class); //Logging for WeatherCurrentLocation class.
	@Autowired
	   RestTemplate restTemplate;
	
	@RequestMapping("/weather_home1")// URL Pattern for showing current weather data in Opening page of the project.
	public String CurrentWeather(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,@RequestParam(value="units",required=false) String units,Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		long unixTime = System.currentTimeMillis()/1000L;
		LOGGER.trace("Entering Method CurrentWeather");
		LOGGER.debug("Retrieving the Current Weather Data");
		// Check whether Latitude and Longitude values are present or not 
		if(lat!=0 && lng!=0 && lat!=null && lng!=null) {
			
			LOGGER.info("Latitude and Longitude input is there");
			System.out.println(units);
			if(units==null||units=="null") {
				
				units="metric";
			}
			try {
			 model.addAttribute("latitude", lat);
			  model.addAttribute("longitude",lng);
			  model.addAttribute("cityname", cityname);
			  model.addAttribute("units", units);
			  session.setAttribute("latitude", lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname", cityname);
			  session.setAttribute("units", units);
			  LOGGER.info("API Initializing");
			  // API URL to get the json data 
			  
			  String url="https://api.openweathermap.org/data/2.5/onecall/timemachine?lat="+lat+"&lon="+lng+"&dt="+unixTime+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
			  String url2="https://api.waqi.info/feed/geo:"+lat+";"+lng+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";
			 
			  String url1 ="http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lng+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
			  
			  
			  String objects1 =restTemplate.getForObject(url1, String.class);
			// Convert all the unwanted symbols to understandable symbols
			  String nfdNormalizedString = Normalizer.normalize(objects1, Normalizer.Form.NFD); 
			    Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
			    objects1=pattern.matcher(nfdNormalizedString).replaceAll("");
			    JSONObject city =new JSONObject(objects1);
			    // If cityname is empty then from the json data get the cityname and initialized
			    if(cityname=="") {
			    	LOGGER.error("cityname is empty");
	
	model.addAttribute("cityname", city.get("name"));
	session.setAttribute("cityname", city.get("name"));
	LOGGER.info("cityname value initialized");
			    }
	
	
	model.addAttribute("country",city.getJSONObject("sys").getString("country"));
	session.setAttribute("country",city.getJSONObject("sys").getString("country"));
			// Get the current weather data 
			  String objects =restTemplate.getForObject(url, String.class);
			  String nfdNormalizedString1 = Normalizer.normalize(objects, Normalizer.Form.NFD); 
			    Pattern pattern1 = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
			    objects=pattern1.matcher(nfdNormalizedString1).replaceAll("");
			  JSONObject json =new JSONObject(objects);
			  // Get Air quality data
			  String airpoll =restTemplate.getForObject(url2, String.class);
				JSONObject airpollution=new JSONObject(airpoll);
				

				model.addAttribute("air", airpollution);
			  model.addAttribute("json", json);
			  session.setAttribute("air", airpollution);
			  session.setAttribute("json", json);
			  LOGGER.info("Data Retrieved");
			}
			catch(Exception e) {
				LOGGER.error("No Data Available");
				// If no Data available for the location
				model.addAttribute("json", "null");
				model.addAttribute("air", "null");
				session.setAttribute("json", "null");
				session.setAttribute("air", "null");
			}
		}
		else {
			// When Latitude and Longitude values are empty 
			LOGGER.info("Latitude and Longitude input is empty");
			try {
				LOGGER.info("API Initializing");
			/* By city name we the latitude and longitude values from the response of the 
				API URL given below.
				*/
			String url1 ="http://api.openweathermap.org/data/2.5/weather?q="+cityname+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
			
			  String objects =restTemplate.getForObject(url1, String.class);
			// Convert all the unwanted symbols to understandable symbols
			  String nfdNormalizedString = Normalizer.normalize(objects, Normalizer.Form.NFD); 
			    Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
			    objects=pattern.matcher(nfdNormalizedString).replaceAll("");
			  JSONObject json =new JSONObject(objects);
				
			String coord=json.get("coord").toString();
			JSONObject coordinates = new JSONObject(coord);
			LOGGER.info("Latitude and Longitude values updated");
			String url2="https://api.waqi.info/feed/geo:"+coordinates.getDouble("lat")+";"+coordinates.getDouble("lon")+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";
			String url3="https://api.openweathermap.org/data/2.5/onecall/timemachine?lat="+coordinates.getDouble("lat")+"&lon="+coordinates.getDouble("lon")+"&dt="+unixTime+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
			System.out.println(coordinates.getDouble("lat"));
			  
			  model.addAttribute("latitude", coordinates.getDouble("lat"));
			  model.addAttribute("longitude",coordinates.getDouble("lon"));
			  model.addAttribute("cityname", cityname);
			  model.addAttribute("units", units);
			  model.addAttribute("country",json.getJSONObject("sys").getString("country"));
			  session.setAttribute("latitude", coordinates.getDouble("lat"));
			  session.setAttribute("longitude",coordinates.getDouble("lon"));
			  session.setAttribute("cityname", cityname);
			  session.setAttribute("units", units);
			  session.setAttribute("country",json.getJSONObject("sys").getString("country"));
			  // Get current weather data
			  String objects2 =restTemplate.getForObject(url3, String.class);
				String nfdNormalizedString1 = Normalizer.normalize(objects2, Normalizer.Form.NFD); 
			    Pattern pattern1 = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
			    objects2=pattern1.matcher(nfdNormalizedString1).replaceAll("");
				JSONObject json1 =new JSONObject(objects2);
				
				// Get air quality data
				String airpoll =restTemplate.getForObject(url2, String.class);
				JSONObject airpollution=new JSONObject(airpoll);
				  

				model.addAttribute("json", json1);
				model.addAttribute("air", airpollution);
				session.setAttribute("json", json1);
				session.setAttribute("air", airpollution);
				LOGGER.info("Data Retrieved");
			}
			catch(Exception e) {
				LOGGER.error("No Data Available");
				// If no Data available for the location
				model.addAttribute("json", "null");
				model.addAttribute("air", "null");
				session.setAttribute("json", "null");
				session.setAttribute("air", "null");
				return "CurrentWeather";
			}
		}
		LOGGER.info("Showing Current Weather Details");
		// Go to CurrentWeather.jsp to show the current weather details.
		return "CurrentWeather";
	}
	
	
	
	
	
	
	
	
	
	@GetMapping("/weather_home")
	public String GetCurrent(Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method GetCurrent");
		LOGGER.debug("Retrieving the Location Details");
		HttpSession session=request.getSession();
		LocationWithOutCoords searchlocation=new LocationWithOutCoords();
		model.addAttribute("loc", searchlocation);
		session.setAttribute("loc", searchlocation);
		LOGGER.info("Retrieved the Location Details");

		return "WeatherHome";
	}
	@PostMapping("/weather_home")
	public String ShowCurrent(@ModelAttribute("loc")  LocationWithOutCoords searchlocation,Model model,HttpServletRequest request) {
		LOGGER.trace("Entering Method ShowCurrent");
		LOGGER.debug("Retrieving the Current Weather Details");
		
		HttpSession session=request.getSession();
		LOGGER.info("API Initializing");
		String url1 ="http://api.openweathermap.org/data/2.5/weather?q="+searchlocation.getLocation_name()+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+searchlocation.getUnits();
		String url2="https://api.waqi.info/feed/"+searchlocation.getLocation_name()+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";
		
		
		try {
		String objects =restTemplate.getForObject(url1, String.class);
		
		JSONObject json =new JSONObject(objects);
	System.out.println(json);
String wea=json.get("weather").toString();
wea=wea.replace("]", "");
wea=wea.replace("[","");


JSONObject weather = new JSONObject(wea);
System.out.println(weather.getString("main"));
String airpoll =restTemplate.getForObject(url2, String.class);
JSONObject airpollution=new JSONObject(airpoll);
System.out.println(airpollution);
		model.addAttribute("json", json);
		model.addAttribute("weather",weather);
		model.addAttribute("airpollution",airpollution);
		session.setAttribute("json", json);
		session.setAttribute("weather",weather);
		session.setAttribute("airpollution",airpollution);
LOGGER.info("Data Retrieved");
		}
		catch(Exception e) {
			LOGGER.error("No Data Available");
			model.addAttribute("json", null);
			session.setAttribute("json", null);
			
		}
		LOGGER.info("Showing Current Weather Details");
		return "CurrentWeather";
	}
	
	

	
}
