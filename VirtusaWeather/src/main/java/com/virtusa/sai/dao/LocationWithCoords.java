package com.virtusa.sai.dao;

public class LocationWithCoords {
private String location_name;
private String from_weather_date;
private String to_weather_date;

 private Double latitude;
 private Double longitude;
 
 public Double getLatitude() {
	return latitude;
}
public void setLatitude(Double latitude) {
	this.latitude = latitude;
}
public Double getLongitude() {
	return longitude;
}
public void setLongitude(Double longitude) {
	this.longitude = longitude;
}
public Long getFrom_weather_unix() {
	return from_weather_unix;
}
public void setFrom_weather_unix(Long from_weather_unix) {
	this.from_weather_unix = from_weather_unix;
}
public Long getTo_weather_unix() {
	return to_weather_unix;
}
public void setTo_weather_unix(Long to_weather_unix) {
	this.to_weather_unix = to_weather_unix;
}
private Long from_weather_unix;
 private Long to_weather_unix;
 
public String getLocation_name() {
	return location_name;
}
public void setLocation_name(String location_name) {
	this.location_name = location_name;
}
public String getFrom_weather_date() {
	return from_weather_date;
}
public void setFrom_weather_date(String from_weather_date) {
	this.from_weather_date = from_weather_date;
}
public String getTo_weather_date() {
	return to_weather_date;
}
public void setTo_weather_date(String to_weather_date) {
	this.to_weather_date = to_weather_date;
}

}
