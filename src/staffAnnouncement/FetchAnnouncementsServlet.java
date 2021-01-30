package staffAnnouncement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;
import java.sql.*;
 
@WebServlet("/FetchAnnouncementsServlet")
public class FetchAnnouncementsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public FetchAnnouncementsServlet() {
        super();
         
    }
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter writer = response.getWriter();
		 Connection con = Dbinit.getConnection();
		 String username = "priyaa"; //TODO: Fetch from Session
		 try {  
				 Statement stmt = con.createStatement();
				 
				ResultSet result = stmt.executeQuery("SELECT * FROM announcements WHERE id LIKE "+"'%"+username+"%'");
				println("executed successfully");
//				result.next();
				String details="";
				while(result.next()) {
					String id=result.getString("id");
					String content=result.getString("content");
					String type=result.getString("type");
					String priority=result.getString("priority");
					String lastDate=result.getString("last date");
					String department=result.getString("department");
					String section=result.getString("section");
					String semester=result.getString("semester");
					details=details+id+"%"+content+"%"+type+"%"+priority+"%"+lastDate+"%"+department+"%"+section+"%"+semester+"#";
					
				}
				writer.print(details);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				 println("Exception in fetch announcement servlet "+e);
				 writer.print("fail");
				 
			}
	}
	void print(Object o) {
		System.out.print(o);
	}
	void println(Object o) {
		System.out.println(o);
	}
 
 

}
