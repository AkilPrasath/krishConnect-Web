package staffAnnouncement;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;

import java.sql.*;
/**
 * Servlet implementation class PostAnnouncementServlet
 */
@WebServlet("/PostAnnouncementServlet")
public class PostAnnouncementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostAnnouncementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		 Connection con = Dbinit.getConnection();
		 String name = request.getParameter("name");
		 String type =request.getParameter("type");
		 String priority =request.getParameter("priority");
		 String semester =request.getParameter("semester");
		 String section =request.getParameter("section");
		 String department =request.getParameter("department");
		 String lastDate =request.getParameter("lastDate");
		 String content =request.getParameter("content");
		 String title =request.getParameter("title");
		 java.util.Date timestamp=java.util.Calendar.getInstance().getTime();
		  println(timestamp);
		  println("printing params");
		  println("department" + department);
		 try {
			PreparedStatement stmt = con.prepareStatement("INSERT INTO `announcements` (`id`, `content`,  `type`, `priority`, `last date`, `department`, `section`, `semester`,`title`) VALUES (?, ? , ?, ?, ?, ?, ?, ?, ?)");
			stmt.setString(1, name+"<"+timestamp );
			stmt.setString(2, content);
			stmt.setString(3, type);
			stmt.setString(4, priority);
			stmt.setString(5, lastDate);
			stmt.setString(6, department);
			stmt.setString(7, section);
			stmt.setString(8, semester); 
			stmt.setString(9, title);   
			stmt.executeUpdate();
			println("executed successfully");
			writer.print("success");  
			    
		} catch (SQLException e) {      
			// TODO Auto-generated catch block   
			 println("Exception in post announcement servlet "+e);
			 writer.print("fail"); 
			 
		}
	}
	void print(Object o) {
		System.out.print(o);
	}
	void println(Object o) {
		System.out.println(o);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
