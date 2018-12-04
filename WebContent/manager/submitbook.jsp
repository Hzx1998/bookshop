<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*,util.*"%>

<% String context=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>提交图书</title>
</head>
<body>
<%
String url = "jdbc:mysql://localhost:3306/bookstore";
String username = "huazixu";
String password = "wamxz";

String sql = "insert into book (bookname,bookamount,bookprice) values(?,?,?)";

Connection conn = null;

int result = 0;
request.setCharacterEncoding("utf-8");
String bname = request.getParameter("bookname");
String bamount = request.getParameter("bookamount");
String bprice = request.getParameter("bookprice");
if (StringUtil.validateNull(bname)) {
out.println("对不起，书名不能为空，请您重新输入！<br>");
out.println("><a href=\"" + context + "/manager/addbook.jsp\">重新添加</a><br>");
} else if (StringUtil.validateNull(bamount)) {
out.println("对不起，数量不能为空，请您重新输入！<br>");
out.println("<a href=\"" + context + "/manager/addbook.jsp\">重新添加</a><br>");
}else if(StringUtil.validateNull(bprice)){
	out.println("对不起，价格不能为空，请您重新输入！<br>");
	out.println("<a href=\"" + context + "/manager/addbook.jsp\">重新添加/a><br>");
}else {
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, username, password);

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, StringUtil.filterHtml(bname));
		pstmt.setString(2, StringUtil.filterHtml(bamount));
		pstmt.setString(3, StringUtil.filterHtml(bprice));
		result = pstmt.executeUpdate();
		pstmt.close();
	} catch (ClassNotFoundException e) {
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


if (result == 0) {
	out.println("对不起，添加图书不成功，请您重新输入！<BR>");
	out.println("<a href=\"" + context + "/manager/addbook.jsp\">继续添加图书</a><BR>");
} else {
	out.println("祝贺您，成功添加图书。<br>");
	out.println("<a href=\"" + context + "/manager/mClient.jsp\">返回客户端</a><BR>");
	out.println("<a href=\""+context+"/manager/addbook.jsp\">继续添加新的图书</a><br>");
}
}

%>
	
	
</body>
</html>