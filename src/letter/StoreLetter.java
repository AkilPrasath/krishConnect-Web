package letter;


import java.io.*;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class StoreLetter
 */
@WebServlet("/StoreLetter")
public class StoreLetter extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession currentsession = request.getSession();
		String username= (String) currentsession.getAttribute("username");
		PrintWriter out = response.getWriter();
		String[] Letterdetail; 
		String details = request.getParameter("msg");
		System.out.println(details+"DS" +username);
		Letterdetail = details.split(",");
		System.out.println("date here: "+Letterdetail[0]);
		Date from_date = Date.valueOf(Letterdetail[0]);
		Date to_date = Date.valueOf(Letterdetail[1]);
		String reason = Letterdetail[2];
		String proof = Letterdetail[3];
		try {  
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			Connection con = database.Dbinit.getConnection();
			PreparedStatement statement = con.prepareStatement("insert into letter values(?,?,?,?,?,?,?,?,?)");
			statement.setString(1, username);
			statement.setString(2,Letterdetail[5]);
			statement.setDate(3, from_date); 
			statement.setDate(4, to_date);
			statement.setString(5,reason); 
			statement.setString(6, proof);
			statement.setInt(7, -1); 
			statement.setTimestamp(8, timestamp);
			statement.setString(9,Letterdetail[4]);
			statement.executeUpdate();
		}
		catch(Exception e) { 
			System.out.println(e);
		}
		response.getWriter().print("done"); 
	}

}
