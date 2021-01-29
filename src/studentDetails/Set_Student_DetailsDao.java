package studentDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;

import database.Dbinit;

public class Set_Student_DetailsDao {
	public static boolean setDetails(String details) {
		String[] user_details = details.split(":");
		try {
			Connection connection = Dbinit.getConnection();
			if(connection == null) {
				return false;
			}
			PreparedStatement query = connection.prepareStatement("insert into student value(?,?,?,?,?,?,?,?);");
			query.setString(1, user_details[0]);
			query.setString(2, user_details[1]);
			query.setString(3, user_details[2]);
			query.setString(4, user_details[3]);
			query.setString(5, user_details[4]);
			query.setString(6, null);
			if(user_details[5] == "true") {
				query.setBoolean(7, true);
			} else {
				query.setBoolean(7, false);
			}
			query.setString(8, null);
			return query.execute();
		}catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
}
