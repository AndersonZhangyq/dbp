package com.db;
import java.sql.Time;

public class Run {
	private String train_id = "a";
	private int route_id = 0;
	private Time departure_time;
	private Time arrival_time;
	private int station_num = 0;
	
	public Run(String train_id, int route_id, Time departure_time, Time arrival_time, int station_num) {
		this.train_id = train_id;
		this.route_id = route_id;
		this.departure_time = departure_time;
		this.arrival_time = arrival_time;
		this.station_num = station_num;
	}
	
	public Run() {
		// TODO Auto-generated constructor stub
	}

	public String getTrainID() {
		return train_id;
	}
	
	public void setTrainID(String train_id) {
		this.train_id = train_id;
	}
	
	public int getRouteID() {
		return route_id;
	}
	
	public void setRouteID(int route_id) {
		this.route_id = route_id;
	}
	
	public Time getDepartureTime() {
		return departure_time;
	}
	
	public void setDepartureTime(Time departure_time) {
		this.departure_time = departure_time;
	}
	
	public Time getArrivalTime() {
		return arrival_time;
	}
	
	public void setArrivalTime(Time arrival_time) {
		this.arrival_time = arrival_time;
	}
	
	public int getStationNum() {
		return station_num;
	}
	
	public void setStationNum(int station_num) {
		this.station_num = station_num;
	}
}
