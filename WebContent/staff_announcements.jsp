<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Announcements</title>
    </head>

    <body>
        <%@ page import="java.sql.*"%>
            <%@ page import="database.Dbinit"%>
                <%!String username = "";%>
                <% username = request.getSession().getAttribute("username").toString().split("@")[0]; %>
                <% System.out.println("session value "+username); %>
                    <style>
                        .error {
                            font-size: small;
                            color: red;
                        }
                    </style>
                    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                    <link rel="stylesheet" href="css/staff_announcements.css">
                    <div class="container-fluid  ">
                        <div w3-include-html="navbar.html"></div>
                        <div class="row">
                            <div class="col-md-10"></div>
                            <div class="col-md-2 p-3">
                                <a class="btn btn-primary btn-block" data-toggle="collapse" href="#newAnnouncement" role="button" aria-expanded="false" aria-controls="newAnnouncement"> New Announcement </a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4"></div>
                            <div class="col-md-4 p-3">

                                <!-- <a class="btn btn-primary btn-block" data-toggle="collapse" href="#newAnnouncement" role="button" aria-expanded="false" aria-controls="newAnnouncement"> Post New Announcement </a> -->
                                <div class="card collapse" id="newAnnouncement">
                                    <div class="card-header">New Announcement</div>
                                    <div class="card-body">
                                        <form action="" method="post" name="new announcement">
                                            <div class="row  p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Name</span>
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="text" name="name" id="name" value="<%=username%>" disabled>
                                                </div>
                                            </div>

                                            <div class="row  p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Type</span>
                                                </div>
                                                <div class="col-md-8">
                                                    <select class="custom-select" name="type" id="type">
										<option selected value="Broadcast">BroadCast</option>
										<option value="Yes or No">Yes or No</option>
									</select>
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Priority</span>
                                                </div>
                                                <div class="col-md-8">
                                                    <select class="custom-select" name="priority" id="priority">
										<option selected value="High">High</option>
										<option value="Usual">Usual</option>
									</select>
                                                </div>
                                            </div>
                                            <div class="row p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Class</span>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <select class="custom-select" name="department" id="department">
												<option selected value="CSE">CSE</option>
												<option value="IT">IT</option>
												<option value="EEE">EEE</option>
												<option value="ECE">ECE</option>
												<option value="MECH">MECH</option>
												<option value="MCT">MCT</option>
												<option value="CIVIL">CIVIL</option>
											</select>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <select class="custom-select" name="semester" id="semester">
												<option selected value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
											</select>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <select class="custom-select" name="section" id="section">
												<option selected value="A">A</option>
												<option value="B">B</option>
												<option value="C">C</option>
											</select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row  p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Last Date</span> <br>
                                                    <span class="error" id="lastDateError"></span>
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="date" name="lastDate" id="lastDate">
                                                </div>
                                            </div>
                                            <div class="row  p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Title</span> <br>
                                                    <span class="error" id="titleError"></span>
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="text" name="title" id="title">
                                                </div>
                                            </div>
                                            <div class="row  p-2">
                                                <div class="col-md-4">
                                                    <span class="text-dark">Content</span> <br>
                                                    <span class="error" id="contentError"></span>
                                                </div>
                                                <div class="col-md-8">
                                                    <textarea name="content" id="content" cols="30" rows="10"></textarea>
                                                </div>
                                            </div>


                                            <input id="postButton" type="button" value="Post" class="btn btn-success btn-block">


                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4"></div>
                        </div>

                        <%
		int cardIndex = 0;
		Connection con = Dbinit.getConnection();
		String username = "priyaa"; //TODO: Fetch from Session
		try {
			Statement stmt = con.createStatement();

			ResultSet result = stmt.executeQuery("SELECT * FROM announcements WHERE id LIKE " + "'%" + username + "%'");

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
				System.out.println(id);
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
                                                                            <h6 class="card-subtitle  ">
                                                                                Last Date
                                                                                <%=lastDate%>
                                                                            </h6>
                                                                            <br>
                                                                            <a href="announcement_stats.jsp?id=<%=id%>" class="btn btn-primary mt-auto">View Stats</a>
                                                                        </div>
                                                                    </div>

                                                            </div>
                                                    </div>
                                                </div>
                                                <%
                                                //System.out.println("cardIndex "+cardIndex+"  "+ ((cardIndex + 1 % 3) == 0));
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
                                <script>
                                    function postNewAnnouncement() {
                                        console.log("post function called ");
                                        var ajax = new XMLHttpRequest();
                                        ajax.onreadystatechange = function() {
                                            if (ajax.readyState == XMLHttpRequest.DONE) {
                                                var res = ajax.responseText;
                                                if (res == "success") {
                                                    window.location.reload();
                                                } else {
                                                    alert("Oops! Some error occured.");
                                                }
                                            }
                                        };
                                        var name = document.getElementById("name").value;
                                        var type = document.getElementById("type").value;
                                        var priority = document.getElementById("priority").value;
                                        var semester = document.getElementById("semester").value;
                                        var section = document.getElementById("section").value;
                                        var department = document.getElementById("department").value;
                                        var lastDate = document.getElementById("lastDate").value;
                                        var content = document.getElementById("content").value;
                                        var title = document.getElementById("title").value;
                                        var hasError = false;
                                        if (title == "") {
                                            hasError = true;
                                            document.getElementById("titleError").innerHTML = "Title Cannot be empty!";
                                        }
                                        if (content == "") {
                                            hasError = true;
                                            document.getElementById("contentError").innerHTML = "Content Cannot be empty!";
                                        }
                                        if (lastDate == "") {
                                            hasError = true;
                                            document.getElementById("lastDateError").innerHTML = "Set the last date!";
                                        }
                                        if (hasError) {
                                            return;
                                        }

                                        var queryString = "name=" + name + "&&type=" + type +
                                            "&&priority=" + priority + "&&semester=" + semester +
                                            "&&department=" + department + "&&section=" + section +
                                            "&&lastDate=" + lastDate + "&&content=" + content +
                                            "&&title=" + title;
                                        ajax
                                            .open("GET", "PostAnnouncementServlet?" + queryString,
                                                true);
                                        ajax.send();

                                    }

                                    function fetchNewAnnouncement() {
                                        var ajax = new XMLHttpRequest();
                                        ajax.onreadystatechange = function() {
                                            if (ajax.readyState == XMLHttpRequest.DONE) {
                                                var res = ajax.responseText;
                                                alert(res);
                                            }
                                        };
                                        ajax.open("GET", "FetchAnnouncementsServlet", true);
                                        ajax.send();
                                        alert("fetch request sent");
                                    }
                                    //fetchNewAnnouncement();
                                </script>
                                <script>
                                    function addListener() {

                                        document.getElementById("postButton").addEventListener("click",
                                            postNewAnnouncement);
                                    }
                                    addListener();
                                </script>
                                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                                <script>
                                    includeNavbar();
                                </script>
    </body>

    </html>