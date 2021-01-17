import java.sql.*;
public class Dbinit {
	public static Connection connection;
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost/krishconnect","root","");
			
		}catch(Exception e) {
			System.out.println(e);
		}
		return connection;
	}
}
