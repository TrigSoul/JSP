<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<html><head><META charset="UTF-8"></head><body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
// String id = request.getParameter("userId");
	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "turizmo_informacija";
	String userId = "root";
	String password = "";
/*
try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
*/
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
/*
	2	pavadinimas		varchar(256)	utf8_lithuanian_ci
	3	gyventoju_skaicius	bigint(20)
	4	plotas			decimal(12,2)
	5	platuma			decimal(10,7)
	6	ilguma			decimal(10,7)	
	7	valstybe			char(3)		utf8_lithuanian_ci		
*/
%>
<h2 align="center"><font><strong>Retrieve data from database in jsp</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>

</tr>
<tr style="background-color: #A52A2A">
<th>id</th>
<th>Pavadinimas</th>
<th>Gyv. sk.</th>
<th>Plotas</th>
<th>Platuma</th>
<th>Ilguma</th>
<th>Valst.</th>
</tr>
<%

	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}

	try{ 
	
		String jdbcutf8 = ""; //  "&useUnicode=true&characterEncoding=UTF-8";	
		connection = DriverManager.getConnection ( connectionUrl + dbName + jdbcutf8, userId, password );
		
		statement=connection.createStatement();		
		String sql;
		sql =
			"SELECT"
			+"FROM"
				+"``"
			+"WHERE 1"
				;

		resultSet = statement.executeQuery(sql);
		 
		while( resultSet.next() ){
%>
<tr style="background-color: #DEB887">
	<td><%= resultSet.getString ( "id" ) %></td>
	<td><%= resultSet.getString ( "pavadinimas" ) %></td>
	<td><%= resultSet.getString  ("gyventoju_skaicius" ) %></td>
	<td><%=resultSet.getString ( "plotas" ) %></td>
	<td><%=resultSet.getString ( "platuma" ) %></td>
	<td><%=resultSet.getString ( "ilguma" ) %></td>
	<td><%=resultSet.getString ( "valstybe" ) %></td>
</tr>

<% 
		}

	} catch (Exception e) {
	
		e.printStackTrace();
	}
%>
</table>
</body>