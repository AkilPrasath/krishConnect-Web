package studentAnnouncement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;
import java.sql.*;
 
@WebServlet("/StudentResponseServlet")
public class StudentResponseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public StudentResponseServlet() { 
        super();
         
    }

	  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String id = request.getParameter("id");  
		 int announcememtResponse = Integer.parseInt(request.getParameter("response"));
		 String registerNumber = request.getParameter("registerNumber"); 
		 Connection con = Dbinit.getConnection();    
		 try { 
			 System.out.println("reg number: "+registerNumber);  
			PreparedStatement statement = con.prepareStatement("INSERT INTO `announcement_responses`(`id`,`registerNumber`,`response`) VALUES(?,?,?)");
			statement.setString(1, id);    
			statement.setString(2, registerNumber+"@skcet.ac.in");       
			statement.setInt(3, announcememtResponse);      
			statement.executeUpdate(); 
//			response.getWriter().print("success");  
//			request.getRequestDispatcher("student_announcements.jsp").forward(request,response);
			response.sendRedirect("student_announcements.jsp"); 
		} catch (SQLException e) { 
			// TODO Auto-generated catch block
			System.out.println(e);
			response.getWriter().print("error"); 
		}
		  
	}

	 

}
