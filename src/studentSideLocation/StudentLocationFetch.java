package studentSideLocation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;
  
@WebServlet("/StudentLocationFetch")
public class StudentLocationFetch extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
		 String query = request.getParameter("query");
		 System.out.println("query : "+query);
		 if(query.equals("all")) {
			 query = "";
		 }
		 HashSet<String> staffnames = new HashSet<String>();
		 String studentname = request.getSession().getAttribute("username").toString();
		 try {
			 Connection con = Dbinit.getConnection();
			 PreparedStatement statement = con.prepareStatement("select staffsubject.staffname from staffsubject,student where student.department=staffsubject.departmentName AND student.section=staffsubject.section AND student.semester=staffsubject.semester and student.register_number=?");
			 statement.setString(1, studentname);
			 ResultSet result = statement.executeQuery();
			 while(result.next()) {
				 staffnames.add(result.getString(1));
			 }
			 statement = con.prepareStatement("select tutor.name from tutor,student where student.department=tutor.department AND student.section=tutor.section AND student.semester=tutor.semester and student.register_number=? ");
			 statement.setString(1, studentname);
			 result = statement.executeQuery();
			 while(result.next()) {
				 staffnames.add(result.getString(1)); 
			 } 
			 String output = "";
			 int sno = 1;
			 for(String s:staffnames) {
				 if(s.contains(query)) {
					 
					 statement = con.prepareStatement("select * from staff where name=?");
					 statement.setString(1, s);
					 result = statement.executeQuery();
					 result.next(); 
					 output+= String.valueOf(sno)+"#"+result.getString("name")+"#"+result.getString("phone_number")+"#"+result.getString("location")+"#"+result.getTimestamp("last_seen")+"!";
					 sno++;
				 }
			 }
			 response.getWriter().print(output);
		 }
		 catch(Exception e) {
			 System.out.println(e);
		 }
 	}

	 

}
