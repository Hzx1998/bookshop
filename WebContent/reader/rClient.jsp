<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.box{
display:flex;
flex-direction:row;
justify-content:center;
}

.bookbox{
   height:150px;
   width:250px;
   padding:20px;
   margin:20px;
   display:flex;
   flex-direction:column;
   justify-content:space-around;
   background-color:gray;
   text-align:center;
}

.itembox{
   width:100%;
}
.numswitch{
  display:block;
  width:100px;
}
.cartbutton{
display:block;
  width:100px;
}


</style>
<title>读者客户端</title>
</head>
<body>
<%
String rusername=null;
float raccount=0;
    if(session.getAttribute("rusername")!=null)
    {
    	rusername=session.getAttribute("rusername").toString();
        raccount=Float.parseFloat(session.getAttribute("raccount").toString());
         out.println("用户名"+rusername+"   账户余额"+raccount+"<br>");
    	out.println("<a href=\""+context+"/reader/showcart.jsp\">购物车</a>");
    	out.println("<a href=\""+context+"/reader/recharge.jsp\">账户充值</a>");
    }else{
    	out.println("未登录，请先登录<br>");
    	out.println("<a href=\""+context+"/reader/rlogin.html\">点击登录</a>");
    }
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
String sql = "select bookname,bookamount,bookprice from book";
String sql1 = "select account from reader";
Connection conn = null;
int queryResult=0;
int userResult=0;
try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null; 
	   rs=stmt.executeQuery(sql);
	   out.println("<div class=\"box\">");
	   while(rs.next()){
		   queryResult++;
		   int i=queryResult;
		   out.println("<div class=\"bookbox\">");
		   out.println("<div class=\"itembox\">");
		   out.println("<span>书名:《"+rs.getString(1)+"》</span>");
		   String bname=rs.getString(1);
		   out.println("</div>");
		   out.println("<div class=\"itembox\">");
		   out.println("<span>"+rs.getInt(2)+"本</span>");
		   int num=rs.getInt(2);
		   out.println("</div>");
		   out.println("<div class=\"itembox\">");
		   out.println("<span>价格："+rs.getFloat(3)+"</span>");
		   float price=rs.getFloat(3);
		   out.println("</div>");
		   out.println("<form action=\""+context+"/reader/bookcart.jsp\" method=\"post\">");
		   out.println("<input type=\"hidden\" name=\"username\" value=\""+rusername+"\">");
		   out.println("<input type=\"hidden\" name=\"bookname\" value=\""+bname+"\">");
		   out.println("<input type=\"hidden\" name=\"bookprice\" value=\""+price+"\">");
		   out.println("<input type=\"hidden\" name=\"bookamount\" value=\""+num+"\">");
		   out.println("<input class=\"numswitch\" type=\"number\" name=\"booknum\" min=\"0\" max=\""+num+"\">");
		   out.println("<input class=\"cartbutton\" type=\"submit\" value=\"加入购物车\" >");
		   out.println("</form>");
		   out.println("</div>");
	   }
	   out.println("</div>");
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
</body>
</html>