package database;
import java.sql.*;
public class Dbinit {
	public static Connection connection;
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("class load success");
			connection = DriverManager.getConnection("jdbc:mysql://localhost/krishconnect","root","");
			
		}catch(Exception e) {
			
			System.out.println("dbinit exception !!!!!!!!"+e);
		} 
		return connection; 
	}
}
