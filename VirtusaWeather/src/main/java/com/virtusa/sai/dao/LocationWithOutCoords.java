package com.virtusa.sai.dao;

public class LocationWithOutCoords {
private String location_name;
private String units;
public String getLocation_name() {
	return location_name;
}

@Override
public String toString() {
	return "LocationWithOutCoords [location_name=" + location_name + ", units=" + units + "]";
}

public void setLocation_name(String location_name) {
	this.location_name = location_name;
}

public String getUnits() {
	return units;
}

public void setUnits(String units) {
	this.units = units;
}
}
