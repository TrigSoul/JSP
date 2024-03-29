<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<html>
	<head>
		<meta charset="utf-8">
		<style>
			table {
				border-collapse: collapse;
			}
			form {
				float: right;
			}
			input {
				width: 111px;
			}
			th, td {
				padding: 3px 4px;
				border: 1px solid black;
			}
			th {
				background-color: #A52A2A;
			}
			td {
				background-color: #DEB887;			
			}
		</style>
	</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "turizmo_inf";
	String userId = "root";
	String password = "";

	Connection connection = null;
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;

%>
<h2 align="center"><strong>Retrieve data from database in jsp</strong></h2>
<form method="post" action="">
	<table>
		<tr>
			<th>Pavadinimas</th>
			<td>
				<input type="text" name="pav" required>
			</td>
			<td rowspan="6">
		</tr>
		<tr>
			<th>Gyv. sk.</th>
			<td>
				<input type="number" name="gyv_sk" value="1">
			</td>
		</tr>
		<tr>
			<th>Plotas</th>
			<td>
				<input type="number" name="plotas" value="1">
			</td>
		</tr>
		<tr>
			<th>Platuma</th>
			<td>
				<input type="number" min="-90"  max="90" name="platuma" value="0">
			</td>
		</tr>
		<tr>
			<th>Ilguma</th>
			<td>
				<input type="number" min="0" max="180" name="ilguma" value="0">
			</td>
		</tr>
		<tr>
			<th>Valst.</th>
			<td>			
				<input type="text" name="valstybe">
			</td>
		</tr>
		<tr>
			<td colspan="2">
			</td>
			<td>
				<input type="submit" name="add" value="papildyti">
			</td>
		</tr>
	</table>
</form>
<table align="center">
<tr>
</tr>
<tr>
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
	
		connection = DriverManager.getConnection ( connectionUrl + dbName, userId, password );
		String add; 
		
		if ( ( ( add = request.getParameter("add")  ) != null ) && add.equals ( "papildyti" ) ) {
%>
			Forma submit'inta
<%
			String n_pav = request.getParameter( "pav" );
			String n_gyv_sk = request.getParameter( "gyv_sk" );
			String n_plotas = request.getParameter( "plotas" );
			String n_platuma = request.getParameter( "platuma" );
			String n_ilguma = request.getParameter( "ilguma" );
			String n_valstybe = request.getParameter( "valstybe" );
			
			String sql_ins = 
				"INSERT INTO `miestai`"
				+ " ( `pav`, `gyv_sk`, `plotas`, `platuma`, `ilguma`, `valstybe` )"
				+ " VALUES ( "
					+ "'" + n_pav + "'"
					+ "," + n_gyv_sk
					+ "," + n_plotas
					+ "," + n_platuma
					+ "," + n_ilguma
					+ ", '" + n_valstybe + "'"
				+ " )";
%>
	<%= sql_ins %>
<%
			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_ins);			
			
			
		 } else {
		 
			if ( add != null ) {
%>
			<%= add %>
<%
			}
		 } 
		
		statement_take = connection.createStatement();		
		String sql ="SELECT * FROM `miestai`  WHERE 1";

		resultSet = statement_take.executeQuery(sql);
		 
		while( resultSet.next() ){
%>
<tr>
	<td><%= resultSet.getString ( "id" ) %></td>
	<td><%= resultSet.getString ( "pav" ) %></td>
	<td><%= resultSet.getString  ("gyv_sk" ) %></td>
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