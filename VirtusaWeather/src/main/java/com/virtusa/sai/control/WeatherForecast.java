package com.virtusa.sai.control;

import java.text.Normalizer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.View;

import com.virtusa.sai.dao.JSONRetrieve;
import com.virtusa.sai.dao.LatitudeValue;
import com.virtusa.sai.dao.LocationWithCoords;
import com.virtusa.sai.dao.LocationWithOutCoords;
import com.virtusa.sai.dao.LongitudeValue;

@Controller
public class WeatherForecast {
	private static final Logger LOGGER = LoggerFactory.getLogger(WeatherForecast.class);

	@Autowired
	   RestTemplate restTemplate;

	
	  @RequestMapping("/weather_forecast") 
	  public String GetForecast(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,@RequestParam(value="units",required=false) String units,Model model,HttpServletRequest request) {
		  HttpSession session=request.getSession();
			LOGGER.trace("Entering Method GetForecast");
			LOGGER.debug("Retrieving the Weather Data for Today and Tomorrow");
		  long startTime = System.nanoTime();
		  System.out.println("Start:"+(System.nanoTime() - startTime)/1000000);
	 String day,date,time,tmwdate,tmwday;
	 System.out.println(units);
	 System.out.println(System.currentTimeMillis());
	 long unixTime = System.currentTimeMillis()/1000L;
System.out.println(session.getAttribute("useremail"));
System.out.println(cityname);

if(session.getAttribute("useremail")!=null) {
	LOGGER.info("User Id Present");
	
	  if(lat!=0 && lng!=0 && lat!=null && lng!=null) {
		  try {
		  LOGGER.info("Latitude and Longitude values are there");
		// Add Model Attributes for latitudes,longitudes and cityname  
	  model.addAttribute("latitude", lat);
	  model.addAttribute("longitude",lng);
	  model.addAttribute("cityname", cityname);
	  model.addAttribute("units",units);
	  model.addAttribute("unixTime",unixTime);
	  session.setAttribute("latitude",lat);
	  session.setAttribute("longitude",lng);
	  session.setAttribute("cityname",cityname);
	  session.setAttribute("units",units);
	  session.setAttribute("unixTime",unixTime);
	  System.out.println("Time1:"+(System.nanoTime() - startTime)/1000000);
	  
	
	  System.out.println("Time2:"+(System.nanoTime() - startTime)/1000000);
	  LOGGER.info("API Initializing");
	  String urlcity ="http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lng+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
	  
	  String objects1 =restTemplate.getForObject(urlcity, String.class);
	  String nfdNormalizedStringcity = Normalizer.normalize(objects1, Normalizer.Form.NFD); 
	    Pattern patterncity = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
	    objects1=patterncity.matcher(nfdNormalizedStringcity).replaceAll("");
	    JSONObject city =new JSONObject(objects1);
	    System.out.println(city);
	    model.addAttribute("city", city);
	    session.setAttribute("city", city);
	    model.addAttribute("country",city.get("sys") );
	    session.setAttribute("country", city.get("sys"));
	    System.out.println(city.get("sys"));
	    System.out.println(cityname=="");
	    
	    if(cityname=="") {
	    	LOGGER.error("cityname is empty");
System.out.println(city.get("name"));
session.setAttribute("cityname",(String)city.get("name"));
session.setAttribute("city", city);
cityname=(String)city.get("name");
model.addAttribute("cityname", city.get("name"));
model.addAttribute("city", city);
LOGGER.info("cityname value initiazed");
	    }
	  System.out.println("Time2a retrieved:"+(System.nanoTime() - startTime)/1000000);

		System.out.println("Time3:"+(System.nanoTime() - startTime)/1000000);
			System.out.println("Time4:"+(System.nanoTime() - startTime)/1000000);
		
		
		System.out.println("Time5:"+(System.nanoTime() - startTime)/1000000);
		
		System.out.println(units);
		
	System.out.println("Time9:"+(System.nanoTime() - startTime)/1000000);
	
	LOGGER.info("All values stored in Session");
	  session.setAttribute("latitude",lat);
	  session.setAttribute("longitude",lng);
	  session.setAttribute("cityname",cityname);
	  session.setAttribute("units", units);
	  session.setAttribute("unixTime",unixTime);
  
	  System.out.println("Time12:"+(System.nanoTime() - startTime)/1000000);
	  long elapsedTime = System.nanoTime() - startTime;
	  System.out.println("execution time:"+elapsedTime/1000000);
	  }
		  catch(Exception e) {
				LOGGER.error("No Data Available");
				return "WeatherAfterLogin";
				
		  }
	  
		  }
	  
	  else {

			LOGGER.info("Latitude and Longitude input is empty");
			try {
				LOGGER.info("API Initializing");
		  String url1 ="http://api.openweathermap.org/data/2.5/weather?q="+cityname+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
		  
		  String objects =restTemplate.getForObject(url1, String.class);
		  String nfdNormalizedString = Normalizer.normalize(objects, Normalizer.Form.NFD); 
		    Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
		    objects=pattern.matcher(nfdNormalizedString).replaceAll("");
		  JSONObject json =new JSONObject(objects);
			System.out.println(json);
			System.out.println("Current Weather Report");
		String coord=json.get("coord").toString();
		JSONObject coordinates = new JSONObject(coord);
		LOGGER.info("Getting the Latitude and Longitude Values");
		
		//Check by latitude and longitude
		String url3="https://api.openweathermap.org/data/2.5/onecall/timemachine?lat="+coordinates.getDouble("lat")+"&lon="+coordinates.getDouble("lon")+"&dt="+unixTime+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
		  String url2="https://api.waqi.info/feed/geo:"+coordinates.getDouble("lat")+";"+coordinates.getDouble("lon")+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";
		  
		  System.out.println(coordinates.getDouble("lat"));
		  System.out.println(coordinates.getDouble("lon"));

		
		  String objects2 =restTemplate.getForObject(url3, String.class);
			String nfdNormalizedString1 = Normalizer.normalize(objects2, Normalizer.Form.NFD); 
		    Pattern pattern1 = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
		    objects2=pattern1.matcher(nfdNormalizedString1).replaceAll("");
			JSONObject json2 =new JSONObject(objects2);
			String current=json2.get("current").toString();
			JSONObject json3 = new JSONObject(current);
			System.out.println(json3);
			date=new SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date((Integer)json3.get("dt")*1000L)).toString();
			time=new SimpleDateFormat("HH:mm").format(new java.util.Date((Integer)json3.get("dt")*1000L)).toString();
			day=new SimpleDateFormat("E").format(new java.util.Date((Integer)json3.get("dt")*1000L)).toString();
			model.addAttribute("todaydate", date);
			model.addAttribute("todaytime", time);
			model.addAttribute("todayweek",day);
			session.setAttribute("todaydate",date);
			  session.setAttribute("todaytime",time);
			  session.setAttribute("todayweek", day);
			String wea1=json3.get("weather").toString();
			wea1=wea1.replace("]", "");
			wea1=wea1.replace("[","");
			JSONObject weather1 = new JSONObject(wea1);		
			//Air Quality
			String airpoll =restTemplate.getForObject(url2, String.class);
			JSONObject airpollution=new JSONObject(airpoll);
			JSONObject air=new JSONObject(airpollution.get("data").toString());
			String s;
			if((Integer)air.get("aqi")<=50) {
				s="Good";
			}
			else if((Integer)air.get("aqi")<=100) {
				s="Moderate";
			}
			else if((Integer)air.get("aqi")<=150){
			s="Unhealthy for Sensitive Groups";
			}
			else if((Integer)air.get("aqi")<=200){
				s="Unhealthy";
			}
			else if((Integer)air.get("aqi")<=300){
				s="Very Unhealthy";
			}
			else {
				s="Hazardous";
			}
			String url5="http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lng+"&appid=32a5443257de297a3b5b97d1ea462ed8&units="+units;
			String objects5 =restTemplate.getForObject(url5, String.class);
			  String nfdNormalizedString2 = Normalizer.normalize(objects5, Normalizer.Form.NFD); 
			    Pattern pattern2 = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
			    objects5=pattern2.matcher(nfdNormalizedString2).replaceAll("");
			JSONObject json5 =new JSONObject(objects5);
		String wea=json.get("weather").toString();
		wea=wea.replace("]", "");
		wea=wea.replace("[","");
		JSONObject weather = new JSONObject(wea);
		model.addAttribute("json", json);
		model.addAttribute("weather",weather);
		session.setAttribute("json", json);
		session.setAttribute("weather",weather);
		//First in current webpage
		String now="{city:"+cityname+",country:"+new JSONObject(json.get("sys").toString()).get("country")+",time:'"+time+"',temperature:"
		+new JSONObject(current).getDouble("temp")+",feel_like:"+new JSONObject(current).get("feels_like")+",aqi:"+air.get("aqi")+",air_quality:"+s+",main:"+weather1.get("description")+"}";
		  JSONObject firstnow=new JSONObject(now);
		  System.out.println(firstnow);
		  model.addAttribute("firstnow",firstnow);
		  session.setAttribute("firstnow",firstnow);
		  // Extract todays data 
		  String url4="https://api.openweathermap.org/data/2.5/onecall?lat="+lat+"&lon="+lng+"&appid=32a5443257de297a3b5b97d1ea462ed8&units"+units;
		  String objects3 =restTemplate.getForObject(url4, String.class);
		  JSONObject json4=new JSONObject(objects3);
		  JSONObject todayfull=new JSONArray(json4.get("daily").toString()).getJSONObject(0);
		  System.out.println(todayfull);
		  JSONObject todayweather= new JSONArray(todayfull.get("weather").toString()).getJSONObject(0);
		  System.out.println(todayweather);
		  model.addAttribute("todayfull",todayfull);
		  model.addAttribute("todayweather", todayweather);
		  session.setAttribute("todayfull",todayfull);
		  session.setAttribute("todayweather", todayweather);
		 // Extracts Tomorrows data
		  JSONObject tmwfull=new JSONArray(json4.get("daily").toString()).getJSONObject(1);
		  System.out.println(tmwfull);
		  JSONObject tmwweather= new JSONArray(todayfull.get("weather").toString()).getJSONObject(0);
		  System.out.println(tmwweather);
		  model.addAttribute("tmwfull",tmwfull);
		  model.addAttribute("tmwweather", tmwweather);
		 model.addAttribute("latitude", coordinates.getDouble("lat"));
		  model.addAttribute("longitude",coordinates.getDouble("lon"));
		  model.addAttribute("cityname",json.get("name"));
		  
		  session.setAttribute("firstnow",firstnow);
		  session.setAttribute("todayfull",todayfull);
		  session.setAttribute("todaydate", date);
		  session.setAttribute("todayweek", day);
		  session.setAttribute("todayweather",todayweather);
		  session.setAttribute("tmwfull",tmwfull);
		  session.setAttribute("tmwweather",tmwweather);
		  model.addAttribute("weather1", weather1);
		  session.setAttribute("weather1", weather1);
		  session.setAttribute("latitude",coordinates.getDouble("lat"));
		  session.setAttribute("longitude",coordinates.getDouble("lon"));
		  session.setAttribute("cityname", json.get("name"));
		  
		  LOGGER.info("Data Retrieved");
  }
			catch(Exception e) {
				LOGGER.error("No Data Available");
				
				return "WeatherAfterLogin";
			}
	  }
	  
	  return "WeatherForecast"; 
}
else {
	LOGGER.error("User Id expired");
	return "WeatherLogin";
}
}
	 
	  
	  
	  
	  
	  
	  
	  @RequestMapping("/currentdetails")
	  public String CurrentDetails(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,Model model,HttpServletRequest request) {
		  LOGGER.trace("Entering Method CurrentDetails");
			LOGGER.debug("Retrieving the Current Weather in Detail");
			
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  if(session.getAttribute("latitude")==null) {
		  session.setAttribute("latitude",lat);
		  session.setAttribute("longitude",lng);
		  session.setAttribute("cityname",cityname);
		  }
		  if(session.getAttribute("longitude")==null) {
			  session.setAttribute("latitude",lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname",cityname);
			  }
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
			
		  System.out.println(session.getAttribute("latitude"));
		 System.out.println(session.getAttribute("longitude"));
		 System.out.println(session.getAttribute("cityname"));
		 LOGGER.info("Storing all values in Model Attribute");
		  model.addAttribute("latitude",session.getAttribute("latitude"));
		  model.addAttribute("longitude",session.getAttribute("longitude"));
		  model.addAttribute("cityname",session.getAttribute("cityname"));
		 
	
	  	return "CurrentDetails";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}
		  }
		  else
		  {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	  
	  
	  @RequestMapping("/tmwdetails")
	  public String TmwDetails(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,Model model,HttpServletRequest request) {
		  HttpSession session=request.getSession();
		  LOGGER.trace("Entering Method TmwDetails");
			LOGGER.debug("Retrieving the Weather Data for Tomorrow in Detail");
		  System.out.println(session.getAttribute("useremail"));
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
			  if(session.getAttribute("latitude")==null) {
				  session.setAttribute("latitude",lat);
				  session.setAttribute("longitude",lng);
				  session.setAttribute("cityname",cityname);
				  }
				  if(session.getAttribute("longitude")==null) {
					  session.setAttribute("latitude",lat);
					  session.setAttribute("longitude",lng);
					  session.setAttribute("cityname",cityname);
					  }
			
			  LOGGER.info("Stroing all values in Model Attribute");
		  model.addAttribute("latitude",session.getAttribute("latitude"));
		  model.addAttribute("longitude",session.getAttribute("longitude"));
		  model.addAttribute("cityname",session.getAttribute("cityname"));
		  
		  return "TommorowDetails";
		  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
		  
	  }
	  
	  
	  
	  
	  
	  
	  @RequestMapping("/weatherforecast") 
	  public String	 Forecast(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
			  @ModelAttribute("forloc") LocationWithCoords searchforecast,@RequestParam(value="units",required=false) String units,Model model,HttpServletRequest request)
	  {
		  System.out.println(lat);
		  System.out.println(lng);
		  System.out.println(units);
		  HttpSession session=request.getSession();
		  LOGGER.trace("Entering Method Forecast");
			LOGGER.debug("Retrieving the Forecast Weather Data");
		  System.out.println(session.getAttribute("useremail"));
		  if(session.getAttribute("useremail")!=null) {
			
			  try {
			  LOGGER.info("User Id Present");
			  LOGGER.info("Storing All values in Model Attribute");
			model.addAttribute("latitude", lat);
			  model.addAttribute("longitude",lng);
			  model.addAttribute("cityname", cityname);
			  model.addAttribute("units", units);
			  session.setAttribute("latitude", lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname", cityname);
			  session.setAttribute("units", units);
			return "WeatherForecast1"; 
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	  
	  
	  
	  
	  @RequestMapping("/anydaydetails")
	  public String AnyDayDetails(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
			  @ModelAttribute("forloc") LocationWithCoords searchforecast,Model model,HttpServletRequest request,@RequestParam(value="i",required=false) int i) {
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method AnyDayDetails");
			LOGGER.debug("Retrieving the Any Day Weather Data in Detail");
		  if(session.getAttribute("useremail")!=null) {
			
			  try {
				  LOGGER.info("User Id Present");
		  System.out.println(i);
		
		  LOGGER.info("Storing all values in Model Attribute");
		  session.setAttribute("i",i);
		  model.addAttribute("i",i);
		  return "AnyDayDetails";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	  
	  
	  
	  @RequestMapping("/hourly")
	  public String Hourly(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
			  @ModelAttribute("forloc") LocationWithCoords searchforecast,Model model,HttpServletRequest request) {
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method Hourly");
			LOGGER.debug("Retrieving the Today Hourly Weather Data");
		  if(session.getAttribute("useremail")!=null) {
			  try {
				  LOGGER.info("User Id Present");
		 
				  LOGGER.info("Storing all values in Model Attribute");
				  LOGGER.info("Storing all values in Session");
			  session.setAttribute("latitude",lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname", cityname);
			  model.addAttribute("latitude", lat);
			  model.addAttribute("longitude",lng);
			  model.addAttribute("cityname", cityname);
		  return "WeatherHourly";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	  
	  
	  
	  
	  @RequestMapping("/tmwweatherhourly")
	  public String TmwHourly(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
	  @RequestParam("i") int i,@ModelAttribute("forloc") LocationWithCoords searchforecast,Model model,HttpServletRequest request) {
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method TmwHourly");
			LOGGER.debug("Retrieving the Tomorrow Hourly Weather Data");
		  if(session.getAttribute("useremail")!=null) {
			  try {
				  LOGGER.info("User Id Present");
		  model.addAttribute("hourly",session.getAttribute("hourly"));
		  model.addAttribute("i",i);
		  session.setAttribute("hourly",session.getAttribute("hourly"));
		  session.setAttribute("i",i);
		  LOGGER.info("Storing all values in Model Attribute");
		  LOGGER.info("Storing all values in Session");
		  session.setAttribute("latitude",lat);
		  session.setAttribute("longitude",lng);
		  session.setAttribute("cityname", cityname);
		  model.addAttribute("latitude", lat);
		  model.addAttribute("longitude",lng);
		  model.addAttribute("cityname", cityname);
		  
		  return "TmwWeatherHourly";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				} 
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	  
	  
	  
	  @RequestMapping("/tmwafterhourly")
	  public String TmwAfterHourly(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
			  @RequestParam("i") int i,@ModelAttribute("forloc") LocationWithCoords searchforecast,Model model,HttpServletRequest request) {
				  HttpSession session=request.getSession();
				  System.out.println(session.getAttribute("useremail"));
				  LOGGER.trace("Entering Method TmwAfterHourly");
					LOGGER.debug("Retrieving the Hourly Weather Data After Tomorrow");
				  if(session.getAttribute("useremail")!=null) {
					  try {
					  LOGGER.info("User Id Present");
				  model.addAttribute("hourly",session.getAttribute("hourly"));
				  session.setAttribute("hourly",session.getAttribute("hourly"));
				  LOGGER.info("Storing all values in Model Attribute");
				  LOGGER.info("Storing all values in Session");
				  session.setAttribute("latitude",lat);
				  session.setAttribute("longitude",lng);
				  session.setAttribute("cityname", cityname);
				  model.addAttribute("latitude", lat);
				  model.addAttribute("longitude",lng);
				  model.addAttribute("cityname", cityname);
				  model.addAttribute("i",i);
				  session.setAttribute("i",i);
				  return "TmwAfterHourly";
				  }
					  catch(Exception e) {
							LOGGER.error("No Data Available");
							
							return "WeatherAfterLogin";
						} 
				  }
				  else {
					  LOGGER.error("User Id expired");
					  return "WeatherLogin";
				  }
			  }
	  
	  
	  
	  
	  
	  @RequestMapping("/airquality")
	  public String AirQuality(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,@ModelAttribute("forloc") LocationWithCoords searchforecast,
			  Model model,HttpServletRequest request) {
		  
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("cityname"));
		  LOGGER.trace("Entering Method AirQuality");
			LOGGER.debug("Retrieving the Air Quality Data");
			
			LOGGER.info("Storing all values in Model Attribute");
			  LOGGER.info("Storing all values in Session");
		  session.setAttribute("latitude",lat);
		  session.setAttribute("longitude",lng);
		  session.setAttribute("cityname", cityname);
		  model.addAttribute("latitude", lat);
		  model.addAttribute("longitude",lng);
		  model.addAttribute("cityname", cityname);
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
			  LOGGER.info("API Intializing");
		  String url2="https://api.waqi.info/feed/geo:"+lat+";"+lng+"/?token=1a7e1e347fbf8336f24932c64f00754b8cbc4520";
		  String objects1 =restTemplate.getForObject(url2, String.class);
			JSONObject airjson =new JSONObject(objects1);
			
			System.out.println(airjson);
			LOGGER.info("Storing All Values in Model Attribute");
			model.addAttribute("airjson",airjson);
			session.setAttribute("airjson",airjson);
		  return "AirQuality";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				} 
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  @RequestMapping("/satellite")
	  public String Satellite(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,@ModelAttribute("forloc") LocationWithCoords searchforecast,
			  Model model,HttpServletRequest request) {
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method Satellite");
			LOGGER.debug("Retrieving the Weather Map");
		  System.out.println("Latitude:"+lat);
		  System.out.println("Longitude:"+lng);
		  System.out.println("City Name:"+cityname);
		  System.out.println("Latitude Session:"+session.getAttribute("latitude"));
		  System.out.println("Longitude Session:"+session.getAttribute("longitude"));
		  System.out.println("Cityname Session:"+session.getAttribute("cityname"));
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
			  LOGGER.info("Storing all values in Model Attribute");
			  LOGGER.info("Storing all values in Session");
			  session.setAttribute("latitude",lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname", cityname);
			  
			  model.addAttribute("latitude", lat);
			  model.addAttribute("longitude",lng);
			  model.addAttribute("cityname", cityname);
		  return "Satellite";
			  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				} 
			  
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
		  
	  }
	  
	  
	  @RequestMapping("/weatherhistory")
	  public String History(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,
			  @RequestParam(value="cityname",required=false) String cityname,@RequestParam(value="units",required=false) String units,@ModelAttribute("forloc") LocationWithCoords searchforecast,
			  Model model,HttpServletRequest request)
	  {
		  HttpSession session=request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method History");
			LOGGER.debug("Retrieving the Weather History Data");
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
		  System.out.println(lat);
		  System.out.println(lng);
		  
		  Double latitude=17.38;
			Double longitude=78.47;
			
			LOGGER.info("Storing all values in Model Attribute");
			  LOGGER.info("Storing all values in Session");
			 session.setAttribute("latitude",lat);
			  session.setAttribute("longitude",lng);
			  session.setAttribute("cityname", cityname);
			  model.addAttribute("latitude", lat);
			  model.addAttribute("longitude",lng);
			  model.addAttribute("cityname", cityname);
		  return "WeatherHistory";
		  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				}   
		  }
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
		  
	  }
	  @RequestMapping("/monthly")
	  public String Monthly(@RequestParam(value="lat",required=false) Double lat,@RequestParam(value="lng",required=false) Double lng,@RequestParam(value="cityname",required=false) String cityname,
			  @ModelAttribute("forloc") LocationWithCoords searchforecast,@RequestParam(value="units",required=false) String units,Model model,HttpServletRequest request) {
		  HttpSession session = request.getSession();
		  System.out.println(session.getAttribute("useremail"));
		  LOGGER.trace("Entering Method Monthly");
			LOGGER.debug("Retrieving the 13 Days Weather Data");
		  if(session.getAttribute("useremail")!=null) {
			  try {
			  LOGGER.info("User Id Present");
			  
			  LOGGER.info("Storing all values in Model Attribute");
			  LOGGER.info("Storing all values in Session");
				model.addAttribute("latitude", lat);
				  model.addAttribute("longitude",lng);
				  model.addAttribute("cityname", cityname);
				  
	
				session.setAttribute("latitude", lat);
				session.setAttribute("longitude", lng);
				session.setAttribute("cityname", cityname);
			  
		
				model.addAttribute("latitude", lat);
				  model.addAttribute("longitude",lng);
				  model.addAttribute("cityname", cityname);
				  model.addAttribute("units", units);
				  session.setAttribute("latitude", lat);
				  session.setAttribute("longitude",lng);
				  session.setAttribute("cityname", cityname);
				  session.setAttribute("units", units);
												
				
			
		  return "WeatherMonth";
		  }
			  catch(Exception e) {
					LOGGER.error("No Data Available");
					
					return "WeatherAfterLogin";
				} 
		  }
		  
		  else {
			  LOGGER.error("User Id expired");
			  return "WeatherLogin";
		  }
	  }
	  
	  
	
}
