package com.db;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Search extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public Search() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");


		try {
			HttpSession session = request.getSession();
			
			String departure = request.getParameter("departure");
			session.setAttribute("departure", departure);
			String arrival = request.getParameter("arrival");
			session.setAttribute("arrival", arrival);
			String date = request.getParameter("departure_time");
			java.util.Date d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
			java.sql.Date dbDate = new java.sql.Date(d.getTime());
			Connection conn = new DB().DBConnect();
			
			String sql = "{call ticket_search(?, ?, ?)}";
			CallableStatement cs = conn.prepareCall(sql);
			cs.setString(1, departure);
			cs.setString(2, arrival);
			cs.setDate(3, dbDate);
			cs.execute();
			ResultSet rs = cs.getResultSet();
			List<Run> tripList = new ArrayList<Run>();
			Run trip = null;
			while (rs.next()) {
				trip = new Run();
				trip.setTrainID(rs.getString("train_id"));
				trip.setRouteID(rs.getInt("route_id"));
				trip.setDepartureTime(rs.getTime("departure_time"));
				trip.setArrivalTime(rs.getTime("arrival_time"));
				trip.setStationNum(rs.getInt("station_num"));
				tripList.add(trip);
			}
			request.setAttribute("tripList", tripList);
			request.getRequestDispatcher("book.jsp").forward(request, response);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
