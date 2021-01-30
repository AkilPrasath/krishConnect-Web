<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
        <%@ page import="java.sql.*"%>
            <%@ page import="database.Dbinit"%>

                <script>
                    var query = "all";
                    var className = "all";
                    window.onload = function() {
                        tableDataFetch(query);
                    }
                </script>
                <script>
                    function tableDataFetch(value) {
                        if (value == "") {
                            query = "all";
                        } else {
                            query = value;
                        }
                        className = document.getElementById("className").value;
                        var ajax = new XMLHttpRequest();
                        ajax.onreadystatechange = function() {
                            if (ajax.readyState == XMLHttpRequest.DONE) {
                                var string = ajax.responseText;
                                var rows = string.split("!");
                                var index, regNo, name, location, lastSeen;
                                var singleRow;
                                var element = document.getElementById("tableRows");
                                element.innerHTML = "";
                                for (var i = 0; i < rows.length - 1; i++) {
                                    singleRow = rows[i].split("#");
                                    index = singleRow[0];
                                    regNo = singleRow[1];
                                    name = singleRow[2];
                                    location = singleRow[3];
                                    lastSeen = singleRow[4];
                                    element.innerHTML += "<tr>" +
                                        "<td>" + index + "</td>" +
                                        "<td>" + regNo + "</td>" +
                                        "<td>" + name + "</td>" +
                                        "<td>" + location + "</td>" +
                                        "<td>" + lastSeen + "</td>" +
                                        "</tr>";

                                }
                            }
                        }
                        ajax.open("GET", "StaffLocationFetch?query=" + query + "&&className=" + className, true);
                        ajax.send();
                    }
                </script>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                <div class="p-0 container-fluid">
                    <div w3-include-html="navbar.html"></div>
                    <br>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-3">

                            <input onkeyup="tableDataFetch(this.value)" placeholder="Search by register number" type="text" name="query" class="input-group" id="query">
                        </div>
                        <div class="col-md-2">
                            <select onchange="tableDataFetch(query)" name="className" id="className">
                <option value="all">All</option>
                <%  
                
               String staffname = request.getSession().getAttribute("username").toString();
                Connection con=Dbinit.getConnection();
                PreparedStatement stmt=con.prepareStatement("SELECT * FROM staffsubject WHERE staffname=?");
                stmt.setString(1,staffname);
                ResultSet rs=stmt.executeQuery();
                String department="";
                String semester=""; 
                String section="";
                String className;
                while(rs.next()){
                	 department=rs.getString("departmentName");
                	 semester=rs.getString("semester");
                	 section=rs.getString("section"); 
                	 className=semester+"-"+department+"-"+section;
                	System.out.println(className);
                

		%>
                     
                    <option value=<%=className %>><%=className %></option>
                    <%} %>
                     <%  
                
              
               try{
                 stmt=con.prepareStatement("SELECT * FROM tutor WHERE name=?");
                stmt.setString(1,staffname);
                System.out.print("nlah "+staffname);
                  rs=stmt.executeQuery();
                  department="";
                  semester=""; 
                  section=""; 
                  className="";
                while(rs.next()){
                	 department=rs.getString("department");
                	 semester=rs.getString("semester");
                	 section=rs.getString("section"); 
                	 className=semester+"-"+department+"-"+section;
                	System.out.println("cnameeeee"+className);
                

		%>
                     
                    <option value=<%=className %>><%=className %></option>
                    <%}}catch(Exception e){
                    	System.out.println("dropdown exception "+e);
                    } %>
                </select>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                                    <th scope="col">
                                        S.no
                                    </th>
                                    <th scope="col">
                                        Register number
                                    </th>
                                    <th scope="col">
                                        Name
                                    </th>
                                    <th scope="col">
                                        Location
                                    </th>
                                    <th scope="col">
                                        Updated
                                    </th>
                                </thead>
                                <tbody id="tableRows">
                                    <!-- <div id="tableRows"></div> -->
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-2"></div>
                    </div>
                </div>
                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                <script src="js/navbar.js"></script>
                <script>
                    includeNavbar();
                </script>
    </body>

    </html>