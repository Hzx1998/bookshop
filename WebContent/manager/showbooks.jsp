<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>

<head>
<meta charset="UTF-8">
<title>图书列表</title>
<style type="text/css">
#linkbox{

width：75px;
         float:right;
}
span{
display:inline-block;
width:200px;
}

</style>
</head>
<body>
<%
   String url = "jdbc:mysql://localhost:3306/bookstore";
   String username = "huazixu";
   String password = "wamxz";
   String sql = "select bookname,bookamount,bookprice from book";
   Connection conn = null;
   int queryResult=0;
   try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null;   
	   rs=stmt.executeQuery(sql);

	   
	   while(rs.next()){
		   queryResult++;
		   out.println("<div>");
		   out.println("<span>书名：《"+rs.getString(1)+"》</span>");
		   out.println("<span>数量:"+rs.getInt(2)+"</span>");
		   out.println("<span>价格:"+rs.getFloat(3)+"</span>");
		   out.println("<form action=\""+context+"/manager/addold.jsp\" method=\"get\">");
		   out.println("<input type=\"hidden\" name=\"bookname\" value=\""+rs.getString(1)+"\"> ");
		   out.println("<input type=\"number\" name=\"bookadd\" min=\"0\">");
		   out.println("<input type=\"submit\" value=\"添加\">");
		   out.println("</form>");
		   out.println("</div>");
	   }
	
	   out.println("<div id=\"linkbox\">");
	   out.println("<a href=\"" + context + "/manager/mClient.jsp\">返回客户端</a>");
	   out.println("<br>");
		out.println("<a href=\""+context+"/manager/addbook.jsp\">继续添加新的图书</a>");
		out.println("</div>");
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
</body>
</html>