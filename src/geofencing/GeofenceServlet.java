package geofencing;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Dbinit;

import java.sql.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
@WebServlet("/GeofenceServlet")
public class GeofenceServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession()==null) {
			return;
		}
		if(request.getSession().getAttribute("username")==null) {
			return;
		}
		String username = request.getSession().getAttribute("username").toString();
		
		String lat  = request.getParameter("latitude"); 
		String lon  = request.getParameter("longitude");
		String blockLocation = "outside";
		double latitude = 0.0;
		double longitude = 0.0;
		if(  !lat.equals("")) {  
			latitude = Double.parseDouble(lat);
		}  
		if(  !lon.equals("")) {
			longitude = Double.parseDouble(lon); 
		}
		
		
		 
		Connection con = Dbinit.getConnection();
		
		Pattern pattern = Pattern.compile("[0-9]{2}[a-zA-Z]{4}[0-9]{3}", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(username.split("@")[0]);
        boolean matchFound = matcher.find();
        
        if(matchFound) { //student
        	try {
    			PreparedStatement statement = con.prepareStatement("SELECT location_privacy from student where register_number=?  ");
    			statement.setString(1, username);
    			ResultSet result = statement.executeQuery();
    			if(result.next()) {
    				int privacy = result.getInt(1);
    				if(privacy==1) { //privacy on
    					return; 
    				} 
    				else {
    					 
    					 blockLocation =  GeofenceService.findBlock(latitude, longitude);
    					 statement = con.prepareStatement("UPDATE student set location=?,last_seen=? where register_number=?");
    					 statement.setString(1, blockLocation);
    					 statement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
    					 statement.setString(3,username);
    					 statement.executeUpdate();
    				}
    			}
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
        } else { //staff
        	try {
    			PreparedStatement statement = con.prepareStatement("SELECT locationprivacy from staff where name=?");
    			statement.setString(1, username);
    			ResultSet result = statement.executeQuery();
    			if(result.next()) {
    				int privacy = result.getInt(1);
    				if(privacy==1) { //privacy on
    					return;
    				}
    				else {
    					 
    					 blockLocation =  GeofenceService.findBlock(latitude, longitude);	
    					 statement = con.prepareStatement("UPDATE staff set location=?,last_seen=? where name=?");
    					 statement.setString(1, blockLocation);
    					 statement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
    					 statement.setString(3,username);
    					 statement.executeUpdate();
    				}
    			}
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
           
        }
		
		
		
		
		response.getWriter().print(blockLocation);
		  
	}

}
