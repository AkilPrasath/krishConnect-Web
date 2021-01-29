package registeration;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Staff_register
 */
@WebServlet("/Staff_register")
public class Staff_register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");  
		String username=request.getParameter("username");  
		String password=request.getParameter("password");
		RegisterDao.register(username, password);
		response.sendRedirect(request.getContextPath() + "/staffDetails.html?reg_num="+username); 
	}
}
