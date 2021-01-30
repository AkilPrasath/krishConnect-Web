<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            #APPROVE {
                left: 30%;
                width: 150px;
                position: absolute;
                background-color: green;
                -ms-transform: translateX(-30%);
                transform: translateX(-30%);
            }
            
            #DENY {
                left: 70%;
                background-color: red;
                width: 150px;
                position: absolute;
                -ms-transform: translateX(-65%);
                transform: translateX(-65%);
            }
        </style>
    </head>

    <body>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <div name="first" class="container-fluid  p-0">
            <div w3-include-html="navbar.html"></div>
            <br>
            <div align="center" class="form-group" name="LETTER" style="position: absolute;left: 50%;top:10%;-ms-transform: translateX(-50%);transform: translateX(-50%);">
                <%@ page import="java.sql.*"%>
                    <%@ page import="database.Dbinit"%>
                        <%@page import="java.text.*"%>
                            <%try{
                Connection connection = Dbinit.getConnection();
                String param = (String)request.getParameter("msg");
                SimpleDateFormat formatter=new SimpleDateFormat("dd-MM-yyyy");
                String[] details = param.split(",");
                PreparedStatement statement = connection.prepareStatement("select from_date,to_date,username,type,tutor,reason,proof from letter where from_date=? AND to_date=? AND username=? AND type=? AND tutor=? AND timestamps=? AND accepted=-1");
                statement.setDate(1,Date.valueOf(details[0]));
                statement.setDate(2,Date.valueOf(details[1]));
                statement.setString(3,details[2]);
                statement.setString(4,details[3]);
                statement.setString(5,details[4]);
                statement.setString(6,details[5]);
                ResultSet rs = statement.executeQuery();
                System.out.println(details[0]+" "+details[2]+" "+details[4]+" "+"KI");
                if(rs.next()){              
                    Date from_date = Date.valueOf(rs.getString(1));
                    Date to_date = Date.valueOf(rs.getString(2));
                System.out.println(param+"JI");
            %>
                                <script>
                                    function approve() {
                                        if (confirm("APPROVE")) {
                                            var param = "<%=details[0]%>" + "," + "<%=details[1]%>" + "," + "<%=details[2]%>" + "," + "<%=details[3]%>" + "," + "<%=details[4]%>" + "," + "<%=details[5]%>" + "," + 1;
                                            var xmlhttprequest = new XMLHttpRequest();
                                            xmlhttprequest.open("POST", "StaffLetterStore?msg=" + param, true);
                                            xmlhttprequest.send();
                                            location.replace("http://localhost:8080/krishConnect-Web/StaffLetterRequests.jsp");
                                        }
                                    }

                                    function deny() {
                                        if (confirm("DENY")) {
                                            var param = "<%=details[0]%>" + "," + "<%=details[1]%>" + "," + "<%=details[2]%>" + "," + "<%=details[3]%>" + "," + "<%=details[4]%>" + "," + "<%=details[5]%>" + "," + 0;
                                            var xmlhttprequest = new XMLHttpRequest();
                                            xmlhttprequest.open("POST", "StaffLetterStore?msg=" + param, true);
                                            xmlhttprequest.send();
                                            location.replace("http://localhost:8080/krishConnect-Web/StaffLetterRequests.jsp");
                                        }
                                    }
                                </script>
                                <form>
                                    <select class="form-select" id="LetterType" name="type" style="text-align-last: center; background-color: cornflowerblue; color:white;width: 200px;" disabled>
                    <option value="<%=rs.getString(4)%>"><%=rs.getString(4)%></option>
                    </select>
                                    <select id="tutorID" name="tutor" style="text-align-last: center; background-color: cornflowerblue; color:white;width: 200px;" disabled>
                    <option value="<%=rs.getString(5)%>"><%=rs.getString(5)%></option>
                    </select>
                                    <br><br> FROM : &nbsp&nbsp<input type="text" style="border-color:green;background-color:bisque" value="<%=formatter.format(from_date)%>" id="from" disabled><br></br>
                                    To &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp<input type="text" style="border-color:green;background-color:bisque" value="<%=formatter.format(to_date)%>" id="to" disabled><br></br>
                                    REASON :
                                    <div class="form-group shadow-textarea"><textarea class="form-control z-depth-1 rounded-4" id="reason" rows="10" cols="100" style="border-color:green;background-color:bisque" placeholder="<%=rs.getString(6)%>" disabled></textarea></div>
                                    </br>
                                    PROOF :
                                    <div class="form-group shadow-textarea"><a href="<%=rs.getString(7)%>" target="_blank"><textarea class="form-control z-depth-1 rounded-4" id="reason" rows="1" cols="100" style="border-color:green;background-color:bisque" disabled><%=rs.getString(7)%></textarea></a><br></br>
                                        <button type="button" class="btn btn-primary" id="APPROVE" onclick="approve()">APPROVE</button>
                                        <button type="button" class="btn btn-primary" id="DENY" onclick="deny()">DENY</button>
                                </form>
                                <%}
            }
            catch(Exception e){
            	System.out.println(e);
            }%>
                                    </div>
            </div>
            <script src="js/navbar.js"></script>
            <script>
                includeNavbar();
            </script>

    </body>

    </html>