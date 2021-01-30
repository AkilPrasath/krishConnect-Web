 
package staffDetails;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/staffDupload")
public class staffDupload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String parameter = request.getParameter("parameter");
		System.out.println(parameter); 
		staffDetailsDao.upload(parameter);
//		response.sendRedirect(request.getContextPath() +"/staff_dashboard.jsp");  
		response.getWriter().print("done"); 
	}
}

