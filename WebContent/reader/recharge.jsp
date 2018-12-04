<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>账户充值</title>
</head>
<body>
<%
           String uname=session.getAttribute("rusername").toString();
           float raccount=Float.parseFloat(session.getAttribute("raccount").toString());
           out.println("<div>用户名:"+uname+"当前余额"+raccount+"</div>"); 
           out.println("<span><a href=\""+context+"/reader/rClient.jsp\">返回客户端</a></span>");
           out.println("<form action=\""+context+"/reader/recharged.jsp\" method=\"get\">");
		   out.println("<input type=\"text\" name=\"money\" >");
		   out.println("<input type=\"submit\" value=\"点击充值\">");
		   out.println("</form>");
%>
</body>
</html>