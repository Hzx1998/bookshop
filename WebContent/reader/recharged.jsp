<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>余额充值</title>
</head>
<body>
<% 
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
float account=0;
String uname=null;
if(session.getAttribute("rusername")!=null){
   uname=session.getAttribute("rusername").toString();
   account=Float.parseFloat(request.getParameter("money"));
}

String sql1="select account from reader where username=\""+uname+"\"";
Connection conn = null;
try{
	   float oldaccount=-1;
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null;
	   rs=stmt.executeQuery(sql1);
	 while(rs.next()){
		 oldaccount=rs.getFloat(1);
	 }
	 account=account+oldaccount;
	 session.setAttribute("raccount", account);
	 String sql="update reader set account=\""+account+"\" where username=\""+uname+"\"";
	 stmt.executeUpdate(sql);

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
response.sendRedirect(request.getContextPath()+"/reader/recharge.jsp");
%>
</body>
</html>