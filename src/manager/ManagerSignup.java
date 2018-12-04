package manager;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.StringUtil;

/**
 * Servlet implementation class ManagerSignup
 */
@WebServlet("/ManagerSignup")
public class ManagerSignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerSignup() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String url="jdbc:mysql://localhost:3306/bookstore?useSSL=false";
		String username="huazixu";
		String password="wamxz";
	    ResultSet rs=null;

		String managerName=request.getParameter("username");
		String pass=request.getParameter("password");
		System.out.println(managerName+pass);
		String sql1="select username,password from manager where username=\""+managerName+" \"and password=\""+pass+"\"";
		String sql2="insert into manager(username,password) values (\'"+managerName+"\',"+"\'"+pass+"\')";
		int queryResult=0;
	
		Connection conn=null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<head><title>input</title></head>");
		out.println("<body>");
        if(StringUtil.validateNull(managerName)) {
        	out.println("用户名不能为空<br>");
			out.println("<a href=\""+request.getContextPath()+"/manager/login.html\">请重新输入</a><br>");
        }else if(StringUtil.validateNull(pass)){
        	out.println("密码不能为空<br>");
			out.println("<a href=\""+request.getContextPath()+"/manager/login.html\">请重新输入</a><br>");
        }
        else {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url,username,password);
			Statement stmt=conn.createStatement();
			rs=stmt.executeQuery(sql1);
			while(rs.next()) {
					queryResult++;
			}

			if(queryResult==0) {
				stmt.executeUpdate(sql2);
				request.getSession().setAttribute("username", managerName);
				response.sendRedirect(request.getContextPath()+"/manager/login.html");
			}
			else {
				out.println("用户名已存在<br>");
				out.println("<a href=\""+request.getContextPath()+"/manager/signup.html\">请重新输入</a><br>");
				
			}
			rs.close();
			stmt.close();
			conn.close();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println("</body>");
		out.println("</html>");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
