package staffSideLocation;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;
import java.sql.*;
/**
 * Servlet implementation class StaffLocationFetch
 */
@WebServlet("/StaffLocationFetch")
public class StaffLocationFetch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /** 
     * @see HttpServlet#HttpServlet() 
     */
    public StaffLocationFetch() {
        super(); 
        // TODO Auto-generated constructor stub
    } 
 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String query = request.getParameter("query"); 
		if(query.equals("all")) {
			query = "";
		}
		String className = request.getParameter("className");
		String semester="",department="",section="";
		if(!className.equals("all")) {
			
			semester = className.split("-")[0];
			department = className.split("-")[1];
			section = className.split("-")[2];
		}
		System.out.println("query="+query+" classname="+className);
		String username = request.getSession().getAttribute("username").toString();
		String string ;
		string = ""; 
		Connection con = Dbinit.getConnection();
		if(  className.equals("all")) {
			try {
				PreparedStatement statement = con.prepareStatement("SELECT * FROM staffsubject  WHERE staffsubject.staffname=? ");
				statement.setString(1, username);
				 
				ResultSet r = statement.executeQuery(); 
				int i=0; 
				 while(r.next()) {
					 
					 semester = r.getString("semester");
					 department = r.getString("departmentName");
					 section = r.getString("section");
					 PreparedStatement stmt = con.prepareStatement("SELECT * FROM student WHERE semester=? AND department=? AND section=? AND register_number LIKE ? ORDER BY register_number ");
					 stmt.setString(1, semester);
					 stmt.setString(2, department); 
					 stmt.setString(3, section);
					 stmt.setString(4, "%"+query+"%");
					 
					 ResultSet result = stmt.executeQuery();
					 i=0; 
					 while(result.next()) { 
//						 System.out.println();
						 i++;
						 string+= Integer.toString(i)+"#"+result.getString("register_number").toString()+"#"+result.getString("name").toString()+"#"+result.getString("location")+"#"+result.getString("last_seen")+"!";             
					 }
					 System.out.println(i);
				 }
				  
			} catch (SQLException e) {
				// TODO Auto-generated catch block 
//				response.getWriter().print("first if "+e);
				System.out.println(e);
			}
			try {
				PreparedStatement statement = con.prepareStatement("SELECT * FROM  tutor WHERE  name=? ");
				statement.setString(1, username);
				 
				ResultSet r = statement.executeQuery(); 
				int i=0;
				 while(r.next()) {
					 
					 semester = r.getString("semester");
					 department = r.getString("department");
					 section = r.getString("section");
					 PreparedStatement stmt = con.prepareStatement("SELECT * FROM student WHERE semester=? AND department=? AND section=? AND register_number LIKE ? ORDER BY register_number");
					 stmt.setString(1, semester);
					 stmt.setString(2, department); 
					 stmt.setString(3, section);
					 stmt.setString(4, "%"+query+"%");
					 
					 ResultSet result = stmt.executeQuery();
					 i=0; 
					 while(result.next()) { 
//						 System.out.println();
						 i++;
						 string+= Integer.toString(i)+"#"+result.getString("register_number").toString()+"#"+result.getString("name").toString()+"#"+result.getString("location")+"#"+result.getTimestamp("last_seen")+"!";              
					 }
					 System.out.println(i);
				 }
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
//				response.getWriter().print("first if "+e);
				System.out.println(e);
			}
		}
		else if(!className.equals("all")){
			try {
				PreparedStatement stmt = con.prepareStatement("SELECT * FROM student WHERE semester=? AND department=? AND section=? AND register_number LIKE ? ORDER BY register_number");
				stmt.setString(1, semester);
				stmt.setString(2, department);
				stmt.setString(3, section);
				stmt.setString(4, "%"+query+"%");
				ResultSet result = stmt.executeQuery();
				int i=0;
				 while(result.next()) {
					 i++;
					 string+= Integer.toString(i)+"#"+result.getString("register_number").toString()+"#"+result.getString("name").toString()+"#"+result.getString("location")+"#"+result.getTimestamp("last_seen")+"!";            
				 } 
				 System.out.println("second if "+string);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
//				response.getWriter().print("second if "+e);
			}
			
		}
		response.getWriter().print(string);
	}  

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
 

}
