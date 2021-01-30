package letter;


import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StaffLetterStore")
public class StaffLetterStore extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String param = request.getParameter("msg");
		String[] accept = param.split(",");
		try{
			Connection con = database.Dbinit.getConnection();
			PreparedStatement statement = con.prepareStatement("update letter set accepted=? where from_date=? AND to_date=? AND username=? AND type=? AND tutor=? AND timestamps=? AND accepted=-1 ");
			statement.setString(1, accept[6]);
			statement.setDate(2,Date.valueOf(accept[0]));
            statement.setDate(3,Date.valueOf(accept[1]));
            statement.setString(4,accept[2]);
            statement.setString(5,accept[3]);
            statement.setString(6,accept[4]);
            statement.setString(7,accept[5]);
            int row = statement.executeUpdate();
            System.out.println("ROWS AFFECTED : "+row);
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}

}
