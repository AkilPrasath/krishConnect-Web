package login;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");  
	    String username = request.getParameter("username");  
	    String password = request.getParameter("password");
	    if(LoginDao.checkUser(username, password)) {
//	    	RequestDispatcher rd=request.getRequestDispatcher("menu.html");
	    	HttpSession s = request.getSession();
	    	s.setAttribute("username", username);
	    	Pattern pattern = Pattern.compile("[0-9]{2}[a-zA-Z]{4}[0-9]{3}", Pattern.CASE_INSENSITIVE);
	        Matcher matcher = pattern.matcher(username.split("@")[0]);
	        boolean matchFound = matcher.find();
	        if(matchFound) {
	          System.out.println("Match found");
	          response.sendRedirect("student_dashboard.jsp");
	        } else {
	          System.out.println("Match not found");
	          response.sendRedirect("staff_dashboard.jsp");
	        }
//			rd.forward(request,response);
	    } else {
			RequestDispatcher rd =request.getRequestDispatcher("login.html");
			rd.include(request, response);
	    }
	}
}
