<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
String bname=request.getParameter("bookname");
String add=request.getParameter("bookadd");
int badd=Integer.parseInt(add);


int oldbnum=0;
String sql = "select bookamount from book where bookname=\""+bname+"\"";


int result=0;
Connection conn = null;

try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null;   
	   rs=stmt.executeQuery(sql);
	        while(rs.next())
			   {
	        	oldbnum=rs.getInt(1);
	        	result++;
			   }
	        if(result>0){
	        	int bookamount=badd+oldbnum;
	        	System.out.println(bookamount);
	        	String sql4 = "update book set bookamount=\""+bookamount+"\" where bookname=\""+bname+"\"";
	        	stmt.executeUpdate(sql4);
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
%>
<jsp:forward page="showbooks.jsp"/>

</body>
</html>