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
	7	valstybe			char(7)		utf8_lithuanian_ci		
*/
%>
<h2 align="center"><font><strong>Priimti duomenys is duomenu bazes java server pages</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>

</tr>
<tr style="background-color: #A52A2A">
<th>id</th>
<th>Pavadinimas</th>
<th>Gyventoju skaicius</th>
<th>Plotas</th>
<th>Platuma</th>
<th>Ilguma</th>
<th>Valstybe</th>
<th>Kelio pavadinimas</th>
<th>Kelio<br>ilgumas</th>
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
			"SELECT "
				+"`miestai`.`id`"
				+",`miestai`.`pavadinimas`"
				+ ",`gyventoju_skaicius`"
				+ ",`plotas`"
				+ ",`num_pavadinimas`"
				+ ",`ilgumas` "
				+ ",`valstybe` "
				+ ",`ilguma` "
				+ ",`platuma` "
			+ " FROM"
				+ " `miestai` "
			+ " LEFT JOIN `keliai_miestai` ON ("
				+ " `keliai_miestai`.`id_miesto` = `miestai`.`id` "
				+ ")"
			+ " LEFT JOIN `keliai` ON ("
				+ " `keliai`.`id` = `keliai_miestai`.`id_kelio` "
				+ ")"
			+ " WHERE 1"
				;
		
		resultSet = statement.executeQuery(sql);
		
		String miestas;
		String sk;
		String plotas;
		String plt;
		String ilg;
		String valst;
		String keliopav;
		String kelioilg;
		String nr;
		String ankstesnis_nr = "";
		 
		while ( resultSet.next() ){
		
			nr = resultSet.getString ( "id" );
			miestas = resultSet.getString ( "pavadinimas" );
			sk = resultSet.getString ( "gyventoju_skaicius" );
			plotas = resultSet.getString ( "plotas" );
			plt = resultSet.getString ( "platuma" );
			ilg = resultSet.getString ( "ilguma" );
			valst = resultSet.getString ( "valstybe" );
			keliopav = resultSet.getString ( "num_pavadinimas" );
			kelioilg = resultSet.getString ( "ilgumas" );
			
			if ( keliopav == null ) {
			
				keliopav = "";
			}
			if ( kelioilg == null ) kelioilg = ""; // ! nenaudoti be { nors veikia
			
			if ( ankstesnis_nr.equals ( "" ) ) {
			
				ankstesnis_nr = nr;
				
			} else {
				
				if ( ! nr.equals ( ankstesnis_nr ) ) {
				
					ankstesnis_nr = nr;
					
				} else {
					
					nr ="";
					miestas = "";
					sk = "";
					plotas = "";
					plt = "";
					ilg = "";
					valst = "";
				}
			}					
%>
<tr style="background-color: #cc9933">
	<td><%= nr %></td>
	<td><%= miestas %></td>
	<td><%= sk %></td>
	<td><%= plotas %></td>
	<td><%= plt %></td>
	<td><%= ilg %></td>
	<td><%= valst %></td>
	<td><%= keliopav %></td>
	<td><%= kelioilg %></td>
</tr>

<% 
		}

	} catch (Exception e) {
	
		e.printStackTrace();
	}
%>
</table>
</body>