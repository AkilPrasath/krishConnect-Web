<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>

    <body>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <div name="first" class="container-fluid  p-0">
            <div w3-include-html="navbar.html"></div>
            <div id="content" style="padding-left: 20%;padding-right: 20%;padding-top: 5%;">

                <%HttpSession currentsession = request.getSession();
        	String username = currentsession.getAttribute("username").toString();%>
                    <%@ page import="java.sql.*"%>
                        <%@page import="java.util.*"%>
                            <%@ page import="database.Dbinit"%>
                                <%@page import="java.text.*"%>
                                    <%try {
                Connection connection = Dbinit.getConnection();
                PreparedStatement statement = connection.prepareStatement("select from_date,to_date,tutor,accepted from letter where username=? order by from_date");
                statement.setString(1,username);
                ResultSet rs = statement.executeQuery();
                SimpleDateFormat formatter=new SimpleDateFormat("dd-MM-yyyy");
                
                while(rs.next()){
                    String accepted;
                    if(rs.getString(4).equals("1"))
                    accepted = new String("ACCEPTED");
                    else if(rs.getString(4).equals("0"))
                    accepted = new String("DENIED");
                    else
                    accepted = new String("NOT SEEN");
                    %>
                                        <div class="card">
                                            <div class="card-body" style="font-size:10px;">
                                                <h1 align="left" style="font-size: 20px;">&nbsp
                                                    <%=rs.getString(3)%>
                                                </h1>
                                                <h4 align="right" style="font-size:20px;">Status :
                                                    <%=accepted%>
                                                </h4>
                                                <h4 align="left" style="font-size:20px;">
                                                    <%=formatter.format(rs.getDate(1))%> &nbsp&nbspTO &nbsp&nbsp
                                                        <%=formatter.format(rs.getDate(2))%>
                                                </h4>
                                            </div>
                                        </div>
                                        </br>
                                        <%}
            }
            catch(Exception e){
                System.out.println(e);
            }
            %>
            </div>
            <form action="http://localhost:8080/krishConnect-Web/StudentLetter.jsp">
                <input type="submit" class="btn btn-primary" style="position: absolute;bottom: 2rem;right: 2rem;" value="NEW REQUEST">
            </form>
        </div>
        <script src="js/navbar.js"></script>
        <script>
            includeNavbar();
        </script>
    </body>

    </html>