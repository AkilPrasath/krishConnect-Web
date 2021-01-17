import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao {
	static Connection connection;
	public static boolean checkUser(String username, String password) {
		try {
			connection = Dbinit.getConnection();
			PreparedStatement statement = connection.prepareStatement("select password from login where username=?;");
			statement.setString(1, username);
			ResultSet rs = statement.executeQuery();
			return rs.next();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return false;
	}
}
