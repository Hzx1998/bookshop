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
String cut=request.getParameter("bookcut");
int bcut=Integer.parseInt(cut);
String sql = "select booknum from bookcart where bookname=\""+bname+"\"";
String sql1="select bookamount,bookprice from book where bookname=\""+bname+"\"";

Connection conn = null;

try{

        int result=0;
        int result1=0;
        int oldamount=0;
        int oldbnum=0;
        float bprice=0;
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
	   rs=stmt.executeQuery(sql1);
       while(rs.next())
		   {
            	oldamount=rs.getInt(1);
            	bprice=rs.getFloat(2);
            	result1++;
		   }
	        if(result>0){
	        	if(bcut<oldbnum){
	        	int booknum=oldbnum-bcut;
	        	float total=booknum*bprice;
	        	String sql4 = "update bookcart set booknum=\""+booknum+"\",booktotal=\""+total+"\" where bookname=\""+bname+"\"";
	        	stmt.executeUpdate(sql4);
	        	}else{
	        		String sql3 = "delete from bookcart where bookname=\""+bname+"\"";
		        	stmt.executeUpdate(sql3);
	        	}
	        }
	        if(result1>0)
	        {
	        	int bookamount=oldamount+bcut;
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
<jsp:forward page="showcart.jsp"/>

</body>
</html>