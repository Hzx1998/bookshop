<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>添加图书</title>
</head>
<body>
<a id="showbook" href="<%=context%>/manager/showbooks.jsp">查看书库</a>
<br>
<form id="bookmsg" action="<%=context%>/manager/submitbook.jsp" method="post">
书名：<input class="msg" type="text" name="bookname"><br>
数量：<input class="msg" type="text" name="bookamount"><br>
价格：<input class="msg" type="text" name="bookprice"><br>
<input type="submit" value="提交">
<input type="reset" value="重置">
</form>
</body>
</html>