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
span{
display:inline-block;
width:200px;

}


</style>
<title>购物车</title>
</head>
<body>
<% 
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";
String uname=null;
if(session.getAttribute("rusername")!=null)
{uname=session.getAttribute("rusername").toString();
}

String sql="select bookname,booknum,booktotal from bookcart where username=\""+uname+"\"";
String sql1="select account from reader where username=\""+uname+"\"";
Connection conn = null;
float account=0;
float total=0;

try{
	   Class.forName("com.mysql.jdbc.Driver");
	   conn=DriverManager.getConnection(url,username,password);
	   Statement stmt=conn.createStatement();
	   ResultSet rs=null;   
	   rs=stmt.executeQuery(sql1);
	   while(rs.next()){
	       account=rs.getFloat(1);
	       out.println("<span>用户名:"+uname+"</span>");
	       out.println("<span>账户余额:"+account+"</span>");
	       out.println("<span><a href=\""+context+"/reader/rClient.jsp\">返回客户端</a></span>");
	   }
	   session.setAttribute("raccount", account);
	   rs=stmt.executeQuery(sql);
	   while(rs.next()){
		   out.println("<div>");
		   out.println("<span>书名:《"+rs.getString(1)+"》</span>");
		   out.println("<span>"+rs.getInt(2)+"本</span>");
		   out.println("<span>总价："+rs.getFloat(3)+"</span>");
		   total=total+rs.getFloat(3);
		   out.println("<form action=\""+context+"/reader/cutbook.jsp\" method=\"get\">");
		   out.println("<input type=\"hidden\" name=\"bookname\" value=\""+rs.getString(1)+"\"> ");
		   out.println("<input type=\"number\" name=\"bookcut\" min=\"0\" max=\""+rs.getInt(2)+"\">");
		   out.println("<input type=\"submit\" value=\"删除\">");
		   out.println("</form>");
		   out.println("</div>");
	   }
	   if(total!=0){
	   out.println("<span>合计："+total+"</span>");
	   out.println("<form action=\""+context+"/reader/settle.jsp\" method=\"get\">");
	   out.println("<input type=\"hidden\" name=\"total\" value=\""+total+"\"> ");
	   out.println("<input type=\"hidden\" name=\"account\" value=\""+account+"\">");
	   out.println("<input type=\"submit\" value=\"点击结算\">");
	   out.println("</form>");
	   }else{
		   out.println("<div>购物车为空</div>");
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
</body>
</html>