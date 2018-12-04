<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>结算</title>
</head>
<body>
<% 
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
float account=0;
float total=1;
String uname=null;
if(request.getParameter("account")!=null){
   account=Float.parseFloat(request.getParameter("account"));
   total=Float.parseFloat(request.getParameter("total"));
   uname=session.getAttribute("rusername").toString();
}
if(account>=total){
account=account-total;
String sql="update reader set account=\""+account+"\" where username=\""+uname+"\"";
String sql1="delete from bookcart";
Connection conn = null;
try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
       stmt.executeUpdate(sql);
       stmt.executeUpdate(sql1);
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
response.sendRedirect(request.getContextPath()+"/reader/showcart.jsp");
}else{
	out.println("<div>余额不足</div>");
	out.println("<a href=\""+context+"/reader/showcart.jsp\">返回购物车</a>");
}
%>
</body>
</html>