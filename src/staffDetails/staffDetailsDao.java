package staffDetails;

import database.Dbinit;
import java.sql.*;

public class staffDetailsDao {
	static boolean upload(String parameter) {
		String[] param = parameter.split(":");
		System.out.println(param.length);
		Connection connection = Dbinit.getConnection();
		Byte TRUE = 1;
		Byte FALSE = 0;
		int index = 0;
		boolean staff = false, tutor = false, subject = false;
		try {
			
			{																												// staff details block
				PreparedStatement staffTable = connection.prepareStatement("insert into staff value(?,?,?,?,?,?);");				
				staffTable.setString(1, param[0]);		// 0     
				staffTable.setString(2, param[1]);		// 1
				staffTable.setString(3, null);			// 2
				if(param[index++] == "true") {
					staffTable.setByte(4, TRUE);		// 3
				} else {
					staffTable.setByte(4, FALSE);
				}
				staffTable.setString(5, null);			// 4
				if(param[5] == "tutor") {				// 5
					staffTable.setByte(6, TRUE);
				} else {
					staffTable.setByte(6, FALSE);
				}
				staff =  staffTable.execute();    
			}
			
			if(param[5].equals("tutor")) {
				PreparedStatement tutorTable = connection.prepareStatement("insert into tutor value(?,?,?,?);");
				tutorTable.setString(1, param[0]);
				tutorTable.setString(2, param[6]);
				tutorTable.setString(3, param[7]);
				tutorTable.setString(4, param[8]);
				tutorTable.execute();
			} 
			
			if (param[5].equals("tutor")){
				int length = (param.length - 9)/4, i = 9, count = 0;
				while(count<length) {
					PreparedStatement subjectTable = connection.prepareStatement("insert into staffsubject value(?,?,?,?,?);");
					subjectTable.setString(1, param[0]);
																					
					subjectTable.setString(2, param[i++]);
																					
					subjectTable.setString(3, param[i++]);
																					
					subjectTable.setString(4, param[i++]);

					subjectTable.setString(5, param[i++]);
					subjectTable.execute();
					count++;
				}
			} else {
				int length = (param.length - 6)/4, i = 6, count = 0;
				while(count<length) {
					PreparedStatement subjectTable = connection.prepareStatement("insert into staffsubject value(?,?,?,?,?);");
					subjectTable.setString(1, param[0]);

					subjectTable.setString(2, param[i++]);

					subjectTable.setString(3, param[i++]);

					subjectTable.setString(4, param[i++]);

					subjectTable.setString(5, param[i++]);
					subjectTable.execute();
					count++;
				}
			}
			
			return staff;
		}catch (Exception e) {
			System.out.println(e);
		}
		return false;
	}
}