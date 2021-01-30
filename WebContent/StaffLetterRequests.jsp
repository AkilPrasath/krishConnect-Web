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
        	String tutor = currentsession.getAttribute("username").toString();%>
                    <%@ page import="java.sql.*"%>  
                        <%@ page import="database.Dbinit"%> 
                            <%@page import="java.text.*"%>
                                <%try {
                Connection connection = Dbinit.getConnection();
                PreparedStatement st = connection.prepareStatement("select count(from_date) from letter where tutor=? AND accepted=-1 order by from_date");
                st.setString(1,tutor);
                PreparedStatement statement = connection.prepareStatement("select from_date,to_date,username,accepted,type,timestamps from letter where tutor=? AND accepted=-1 order by from_date");
                statement.setString(1,tutor);
                
                ResultSet rs = statement.executeQuery();
                ResultSet r = st.executeQuery();
                r.next();
                SimpleDateFormat formatter=new SimpleDateFormat("dd-MM-yyyy");
                int index = 0;
                String[][] str = new String[r.getInt(1)][6];
                while(rs.next()){
                    String accepted = new String("NOT SEEN");
                    Date from_date = Date.valueOf(rs.getString(1));
                    Date to_date = Date.valueOf(rs.getString(2));
                    str[index][0] = rs.getString(1);
                    str[index][1] = rs.getString(2);
                    str[index][2] = rs.getString(3);
                    str[index][4] = rs.getString(5);
                    str[index][5] = rs.getString(6);
                    System.out.println(rs.getString(6));

            %>

                                    <div class="card">
                                        <form>
                                            <div class="card-body form-group" style="font-size:10px;">
                                                <h1 align="left" style="font-size: 20px;" id="<%=str[index][2]%>" value="<%=str[index][2]%>">&nbsp
                                                    <%=str[index][2]%>
                                                </h1>
                                                <h4 align="right" style="font-size:20px;">Status :
                                                    <%=accepted%>
                                                </h4>
                                                <h4 align="left" style="font-size:20px;">
                                                    <%=formatter.format(from_date)%> &nbsp&nbspTO &nbsp&nbsp
                                                        <%=formatter.format(to_date)%>
                                                </h4>
                                                <a id="<%=index%>" class="btn btn-primary">OPEN</a>
                                                <script>
                                                    var buttonid = document.getElementById("<%=index%>");
                                                    buttonid.onclick = function() {
                                                        //var xmlhttprequest = new XMLHttpRequest();
                                                        var param = "<%=str[index][0]%>" + "," + "<%=str[index][1]%>" + "," + "<%=str[index][2]%>" + "," + "<%=str[index][4]%>" + "," + "<%=tutor%>" + "," + "<%=str[index][5]%>";
                                                        //xmlhttprequest.open("GET","StaffLetter.jsp?msg="+param,true);
                                                        //xmlhttprequest.send();
                                                        try {
                                                            var url = "http://localhost:8080/krishConnect-Web/StaffLetter.jsp?msg=" + param;
                                                            window.location.href = url;
                                                            // location = url;
                                                            //location.assign(url);
                                                            //location.replace(url);
                                                            //window.location.replace("StaffLetter.jsp?msg="+param);
                                                            //alert(window.location);
                                                        } catch (error) {
                                                            alert(error);
                                                        }
                                                    }
                                                </script>
                                            </div>
                                        </form>
                                    </div>
                                    </br>
                                    <%index++;}
            }
            catch(Exception e){
                System.out.println(e);
            }
            %>
            </div>
            </form>
        </div>
        <script src="js/navbar.js"></script>
        <script>
            includeNavbar();
        </script>
    </body>

    </html>