import java.sql.*;

public class RegisterDao {
//	static Connection connection;
	public static boolean register(String username, String password) {
		try {
			Connection connection = Dbinit.getConnection();
			if(connection == null) {
				return false;
			}
			PreparedStatement query = connection.prepareStatement("insert into login value(?,?);");
			query.setString(1, username);
			query.setString(2, password);
			return query.execute();
		} catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
}
