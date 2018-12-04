package reader;

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
 * Servlet implementation class ReaderLogin
 */
@WebServlet("/ReaderLogin")
public class ReaderLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReaderLogin() {
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

		String readerName=request.getParameter("username");
		String pass=request.getParameter("password");
		String sql="select username,password,account from reader where username=\""+readerName+" \"and password=\""+pass+"\"";
		int queryResult=0;
		Connection conn=null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		out.println("<html>");
		out.println("<head><title>input</title></head>");
		out.println("<body>");
        if(StringUtil.validateNull(readerName)) {
        	out.println("用户名不能为空<br>");
			out.println("<a href=\""+request.getContextPath()+"/reader/rlogin.html\">请重新输入</a><br>");
        }else if(StringUtil.validateNull(pass)){
        	out.println("密码不能为空<br>");
			out.println("<a href=\""+request.getContextPath()+"/reader/rlogin.html\">请重新输入</a><br>");
        }
        else {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url,username,password);
			Statement stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			float account=0;
			while(rs.next()) {
					queryResult++;
				    account=rs.getFloat(3);
			}

			if(queryResult>0) {
				request.getSession().setAttribute("rusername", readerName);
				request.getSession().setAttribute("raccount", account);
				response.sendRedirect(request.getContextPath()+"/reader/rClient.jsp");
			}
			else {
				out.println("用户名或密码错误<br>");
				out.println("<a href=\""+request.getContextPath()+"/reader/rlogin.html\">请重新输入</a><br>");
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
