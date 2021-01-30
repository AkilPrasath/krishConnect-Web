<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        #SEND {
            left: 50%;
            position: absolute;
            -ms-transform: translateX(-50%);
            transform: translateX(-50%);
        }
    </style>
</head>

<body>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script type="text/javascript">
        function letter() {
            var selectoption = document.getElementById("LetterType");
            var xmlhttprequest = new XMLHttpRequest();
            var param = document.getElementById("from_date").value + "," + document.getElementById("to_date").value + "," +
                document.getElementById("reason").value + "," + document.getElementById("proof").value + "," +
                selectoption.options[selectoption.selectedIndex].value + "," +
                document.getElementById("tutorID").options[document.getElementById("tutorID").selectedIndex].value;

            xmlhttprequest.onreadystatechange = function() {
                if (xmlhttprequest.readyState == XMLHttpRequest.done) {
                    alert(xmlhttprequest.responseText);
                }
            }
            xmlhttprequest.open("GET", "StoreLetter?msg=" + param, true);
            xmlhttprequest.send();
            window.location.replace("http://localhost:8080/krishConnect-Web/StudentLetterRequests.jsp");

        }
    </script>
    <div name="first" class="container-fluid  p-0">

        <div w3-include-html="navbar.html"></div>
        <div align="center" name="LETTER" style="position: absolute;left: 50%;top:10%;-ms-transform: translateX(-50%);transform: translateX(-50%);">
            <select class="form-select" id="LetterType" name="type" style="text-align-last: center; background-color: cornflowerblue; color:white;width: 200px;" required>
                <option value="1">--SELECT--</option>
                <option value="OD">OD</option>
                <option value="LEAVE">LEAVE</option>
            </select>
            <br></br>
            <div align="left" id="Content">
                <form name="F1" method="POST">
                    <select id="tutorID" name="tutor" style="text-align-last: center; background-color: cornflowerblue; color:white;width: 200px;" required>
                    <%HttpSession currentsession = request.getSession();
        			String username = currentsession.getAttribute("username").toString();%>
                    <%@ page import="java.sql.*"%>
                    <%@page import="java.util.*"%>
                    <%@ page import="database.Dbinit"%>  
                    <%@page import="java.text.*"%>
                    <%try {
                        Connection connection = Dbinit.getConnection();
                        PreparedStatement statement = connection.prepareStatement("select staff.name from staff,tutor,student where staff.name=tutor.name AND staff.isTutor=0 AND tutor.department=student.department AND tutor.section=student.section AND student.register_number = ? ");
                        statement.setString(1, username);
                        ResultSet rs = statement.executeQuery();
                        while(rs.next()){ 
                            System.out.println(rs.getString(1));
                            String staffName = rs.getString(1);
                    %>
                    <option value="<%=staffName%>"><%=staffName%></option>
                    
                    <%}
                    }
                    catch(Exception e){
                        System.out.println(e);
                    }
                    %>
                    </select>
                    <br><br> FROM : &nbsp&nbsp<input type="date" id="from_date" style="border-color:green;background-color:bisque" required><br></br>
                    To &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp:&nbsp&nbsp&nbsp<input type="date" id="to_date" style="border-color:green;background-color:bisque" required><br></br>
                    REASON :
                    <div class="form-group shadow-textarea"><textarea class="form-control z-depth-1 rounded-4" id="reason" rows="10" cols="100" style="border-color:green;background-color:bisque" required></textarea></div>
                    </br>
                    PROOF : <input type="text" id="proof" class="form-control" style="border-color:green;background-color:bisque" placeholder="URL"><br></br>
                    <a onclick="letter()" id="SEND" class="btn btn-primary">Submit </a>
                </form>
            </div>
        </div>
    </div>
    <script src="js/navbar.js"></script>
    <script>
        includeNavbar();
    </script>
</body>

</html>