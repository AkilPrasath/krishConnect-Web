<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Announcements</title>
    </head>

    <body>
        <%!String username = ""; //TODO: Fetch from Session
        %>
            <% username = request.getSession().getAttribute("username").toString().split("@")[0]; %>
                <%@ page import="java.sql.*"%>
                    <%@ page import="database.Dbinit"%>
                        <%Connection connection = Dbinit.getConnection();  
                 	PreparedStatement statement = connection.prepareStatement(" SELECT * FROM student WHERE register_number = ? ");
                    System.out.println("username session student announcement: "+username); 
                     statement.setString(1, request.getSession().getAttribute("username").toString());
                 	ResultSet res = statement.executeQuery(); 
                 	res.next();
                 	String studentDepartment = res.getString("department");
                 	String studentSemester = res.getString("semester");
                 	String studentSection = res.getString("section");
                 %>
                            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                            <div class="container-fluid">
                                <div w3-include-html="navbar.html"></div>
                                <br><br>

                                <%
                int cardIndex = 0;
                Connection con = Dbinit.getConnection();
                 
                try {
                    PreparedStatement stmt = con.prepareStatement("SELECT * FROM announcements WHERE department=? AND semester=? AND section=?");
                    stmt.setString(1, studentDepartment);
                    stmt.setString(2, studentSemester);
                    stmt.setString(3, studentSection);
        
                    ResultSet result = stmt.executeQuery();
        
                    //							result.next();
                    String details = "";
                    while (result.next()) {
                        String id = result.getString("id");
                        String content = result.getString("content");
                        String type = result.getString("type");
                        String priority = result.getString("priority");
                        String lastDate = result.getString("last date");
                        String department = result.getString("department");
                        String section = result.getString("section");
                        String semester = result.getString("semester");
                        String title = result.getString("title");
                        
                %>
                                    <%
                if (cardIndex % 3 == 0) {
                %>
                                        <div class="container">
                                            <div class="row">

                                                <% 
                    }
                    %>
                                                    <div class="col-md-4 d-flex align-items-stretch">

                                                        <div class="card">
                                                            <div class="card-block d-flex flex-column">
                                                                <%
                                if (priority.equals("High")) {
                                %>

                                                                    <div class="card-header bg-danger">
                                                                        <%
                                    } else {
                                    %>
                                                                            <div class="card-header bg-info">
                                                                                <%
                                        }
                                        %>
                                                                                    <div class="row">
                                                                                        <div class="col-md-6 text-light">
                                                                                            <strong><%=title%></strong>
                                                                                        </div>
                                                                                        <div class="col-md-3"></div>
                                                                                        <div class="col-md-3 text-light">
                                                                                            <strong><%=priority%> </strong>
                                                                                        </div>
                                                                                    </div>

                                                                            </div>

                                                                            <div class="card-body">
                                                                                <h6 class="card-subtitle p-3">
                                                                                    <%=id.split("<")[1]%>
                                                                                </h6>
                                                                                <div class="p-3">
                                                                                    <div class="pb-2">
                                                                                        <h6 class="card-subtitle text-muted">
                                                                                            <%=semester%>
                                                                                                <%=department%>
                                                                                                    <%=section%>
                                                                                                        <%=type%>
                                                                                        </h6>
                                                                                    </div>
                                                                                    <p class="card-text p-y-1">
                                                                                        <%=content%>
                                                                                    </p>
                                                                                    <h6 class="card-subtitle ">
                                                                                        Last Date
                                                                                        <%=lastDate%>
                                                                                    </h6>
                                                                                    <br>
                                                                                    <% PreparedStatement statement1 = connection.prepareStatement("SELECT * FROM announcement_responses WHERE id = ? AND registerNumber = ?");
                                                                                statement1.setString(1, id);
                                                                                statement1.setString(2, username+"@skcet.ac.in");
                                                                                ResultSet resultSet = statement1.executeQuery();
                                                                                boolean alreadyResponded=resultSet.next();
                                                                                 if(alreadyResponded==true){
                                                                                	 
                                                                                	 if(type.equals("Broadcast")){ %>
                                                                                        <div class="btn btn-light mt-auto disabled">Marked as Read</div>
                                                                                        <%}else{ 
                                                                                     	if(resultSet.getString("response").equals("1")){
                                                                                     %>
                                                                                            <div class="btn btn-light mt-auto disabled">Already responded : Yes</div>
                                                                                            <% } else{ %>
                                                                                                <div class="btn btn-light mt-auto disabled">Already responded : No</div>
                                                                                                <%}   
                                                                                     	} 
                                                                                	  
                                                                                 }
                                                                                  else{    
                                                                                	 
                                                                                 if(type.equals("Broadcast")){ 
                                                                                	 
                                                                                 %>
                                                                                                    <a href="StudentResponseServlet?id=<%=id%>&&response=1&&registerNumber=<%=username%>" class="btn btn-primary mt-auto">Mark As Read</a>
                                                                                                    <%}else{ %>
                                                                                                        <a href="StudentResponseServlet?id=<%=id%>&&response=1&&registerNumber=<%=username%>" class="btn btn-success mt-auto">Yes</a>
                                                                                                        <a href="StudentResponseServlet?id=<%=id%>&&response=0&&registerNumber=<%=username%>" class="btn btn-danger mt-auto">No</a>
                                                                                                        <%}
                                                                                 }%>

                                                                                </div>
                                                                            </div>

                                                                    </div>
                                                            </div>
                                                        </div>

                                                        <% 
                        if (((cardIndex + 1) % 3) == 0) {
                        %>
                                                    </div>

                                            </div><br>
                                            <%} 
                    cardIndex += 1; 
                    }    
                    %>
                                                <%for(int i=0; i<(3-(cardIndex%3));i++){ %>
                                                    <div class="col-md-4 d-flex align-items-stretch">

                                                    </div>
                                                    <%} %>
                                                        <%if(cardIndex%3!=0) {%>

                                        </div>

                            </div><br>
                            <%} %>
                                <% 
                    } catch (SQLException e) {
                    %>
                                    <h1>
                                        Error =
                                        <%=e%>>
                                    </h1>
                                    <%
                    }
                    %>
                                        </div>
                                        <script src="js/navbar.js"></script>
                                        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                                        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                                        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                                        <script>
                                            function addListener() {

                                                document.getElementById("yes").addEventListener("click",
                                                    respond);
                                                document.getElementById("broadcast").addEventListener("click",
                                                    respond);
                                                document.getElementById("no").addEventListener("click",
                                                    respond);
                                            }
                                            addListener();
                                        </script>
                                        <script>
                                            function respond(response, id, registerNumber) {
                                                alert("inside response function");
                                                var ajax = new XMLHttpRequest();
                                                ajax.onreadystatechange = function() {
                                                    if (ajax.readyState == XMLHttpRequest.DONE) {
                                                        alert(ajax.responseText);

                                                    }
                                                }
                                                ajax.open("GET", "StudentResponseServlet?id=" + id + "&&response=" + response + "&&registerNumber=" + registerNumber, true);
                                                ajax.send();

                                            }
                                        </script>
                                        <script>
                                            includeNavbar();
                                        </script>
    </body>

    </html>