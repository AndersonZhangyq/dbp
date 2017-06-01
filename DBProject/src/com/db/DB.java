package com.db;
import java.sql.*;

public class DB
{
	public DB()
	{}
	
	public Connection DBConnect() throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		
		String url = "jdbc:mysql://localhost:3306/dbproject?useUnicode=true&characterEncoding=UTF-8";
		String user = "root";
		String password = "A85675169";
		
		Connection conn = DriverManager.getConnection(url,user,password);
		return conn;
	}
	
	public boolean Login(String username,String psw)  throws SQLException, ClassNotFoundException
	{
		Connection conn = DBConnect();
		Statement stmt = conn.createStatement();
		ResultSet resultSet = stmt.executeQuery("select username, password from user");
		
		while (resultSet.next()) {
			if(username != null && !username.equals("") && psw != null && !psw.equals("")) {
				if(username.equals(resultSet.getString("username")) && psw.equals(resultSet.getString("password"))) {
					resultSet.close();
					stmt.close();
					conn.close();
					return true;
				}
			}
		}

		resultSet.close();
		stmt.close();
		conn.close();
		return false;
	}
	
	public boolean Register(String username, String psw)  throws SQLException, ClassNotFoundException
	{
		Connection conn = DBConnect();
		Statement stmt = conn.createStatement();
		ResultSet resultSet = stmt.executeQuery("select username from user");
		
		while (resultSet.next()) {
			if(username != null && !username.equals("")) {
				if(username.equals(resultSet.getString("username"))) {
					return false;
				}
			}
		}

		stmt.executeUpdate("insert into user(username, password) values(\"" + username + "\", \"" + psw + "\")");
		return true;
	}
}