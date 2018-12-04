<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理员主页</title>
</head>
<body>
<%
    
    if(session.getAttribute("username")!=null)
    {
    	String username=session.getAttribute("username").toString();
    	out.println("用户名"+username+"<br>");
    	out.println("<a href=\""+context+"/manager/addbook.jsp\">添加图书</a>");
    	out.println("<a href=\""+context+"/manager/showbooks.jsp\">查看图书</a>");
    }else{
    	out.println("未登录，请先登录<br>");
    	out.println("<a href=\""+context+"/manager/login.html\">点击登录</a>");
    }

%>
</body>
</html>