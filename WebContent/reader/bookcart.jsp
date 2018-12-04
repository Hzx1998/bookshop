<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>


</style>
<title>购物车</title>
</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
if(request.getParameter("username")!=null){
	String uname= request.getParameter("username");
String bname=request.getParameter("bookname");
String price=request.getParameter("bookprice");
float bprice= Float.parseFloat(price);
String num=request.getParameter("booknum");
int bnum=Integer.parseInt(num);
String amount=request.getParameter("bookamount");
int bamount=Integer.parseInt(amount);
int oldbnum=0;
float total=0;
String sql1 = "select bookname,booknum from bookcart where username=\""+uname+"\" and bookname=\""+bname+"\"";

int result=0;
Connection conn = null;
int queryResult=0;
try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null;   
	   rs=stmt.executeQuery(sql1);
	        while(rs.next())
			   {
	        	oldbnum=rs.getInt(2);
	        	result++;
			   }
	        if(result>0){
	        	bamount=bamount-bnum;
	        	bnum=bnum+oldbnum;
	        	total=bprice*bnum;
	        	String sql2 = "update bookcart set booknum=\""+bnum+"\",booktotal=\""+total+"\" where username=\""+uname+"\" and bookname=\""+bname+"\"";
	        	String sql4 = "update book set bookamount=\""+bamount+"\" where bookname=\""+bname+"\"";
	        	stmt.executeUpdate(sql2);
	        	stmt.executeUpdate(sql4);
	        }
	        else{
	        	bamount=bamount-bnum;
	        	String sql4 = "update book set bookamount=\""+bamount+"\" where bookname=\""+bname+"\"";
	        	total=bprice*bnum;
	        	String sql3="insert into bookcart(username,bookname,booknum,booktotal) values(\'"+uname+"\',\'"+bname+"\',\'"+bnum+"\',\'"+total+"\')";
	         	stmt.executeUpdate(sql4);
	        	stmt.executeUpdate(sql3);
	        }
	        rs.close();
	        stmt.close();
}catch (ClassNotFoundException e) {
		e.printStackTrace();
} catch (SQLException e) {
		e.printStackTrace();
} finally {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>
<jsp:forward page="rClient.jsp"/>



</body>
</html>