<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Stats</title>
    </head>

    <body>
        <%@ page import="java.sql.*"%>
            <%@ page import="database.Dbinit"%>
                <%@ page import=" java.util.*"%>
                    <%! ArrayList<String> respondedYes,respondedNo,respondedStudents,allStudents,nonRespondedStudents; %>
                        <%!String department,section,semester,announcementType; %>
                            <%!double yesPercent,noPercent,respondedPercent,notRespondedPercent; %>
                                <%!double yesAngle,noAngle,respondedAngle,notRespondedAngle; %>
                                    <%! String id;%>
                                        <%id = request.getParameter("id");
    Connection con = Dbinit.getConnection();
   
    try {
    	
    	  respondedYes = new ArrayList<String>();
    	  respondedNo = new ArrayList<String>();
    	  respondedStudents=new ArrayList<String>();
    	  allStudents=new ArrayList<String>();
    	 nonRespondedStudents=new ArrayList<String>();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM announcement_responses WHERE id=?");
        stmt.setString(1,id);
        
         

        ResultSet result = stmt.executeQuery();
         
        
        PreparedStatement st= con.prepareStatement("SELECT * FROM announcements WHERE id=?");
        st.setString(1,id);
        ResultSet details=st.executeQuery();
        details.next(); 
        section=details.getString("section");
        semester=details.getString("semester");
        department=details.getString("department");
        announcementType=details.getString("type");
        if(!announcementType.equals("Broadcast")){
        	 
        	while(result.next()){
        		if(result.getInt("response")==1){
        			respondedYes.add(result.getString("registerNumber"));
        		}
        		else{
        			respondedNo.add(result.getString("registerNumber"));
        		}
        	}
        }
        else{
        	while(result.next()){
            	respondedStudents.add(result.getString("registerNumber"));
            	System.out.print(result.getString("registerNumber")+"sdfsd\n");
            }
        }
        
        
        PreparedStatement studentQuery=con.prepareStatement("SELECT * FROM student WHERE section=? AND semester=? AND department=?");
        studentQuery.setString(1,section);
        studentQuery.setString(2,semester);
        studentQuery.setString(3,department);
        ResultSet res=studentQuery.executeQuery(); 
         
        while(res.next()){
        	allStudents.add(res.getString("register_number"));
        	System.out.print(res.getString("register_number")+"\n");
        }
		if(!announcementType.equals("Broadcast")){
			for(int i=0; i<allStudents.size(); i++){
	            String currentStudent = allStudents.get(i);
	            if( !respondedYes.contains(currentStudent) && !respondedNo.contains(currentStudent) ){
	                nonRespondedStudents.add(currentStudent);
	            }
	        }
			yesPercent = (respondedYes.size()+0.0)/allStudents.size();
			yesAngle = yesPercent*360;
			noPercent = (respondedNo.size()+0.0)/allStudents.size();
			noAngle = noPercent*360;
			notRespondedPercent = (nonRespondedStudents.size()+0.0)/allStudents.size();
			notRespondedAngle = notRespondedPercent*360;
		}
		else{ 
			for(int i=0; i<allStudents.size(); i++){
				String currentStudent = allStudents.get(i);
	            if( !respondedStudents.contains(currentStudent)   ){
	                nonRespondedStudents.add(currentStudent);
	            } 
			}
			respondedPercent =  (respondedStudents.size()+0.0)/allStudents.size();
			respondedAngle = respondedPercent*360;
			notRespondedPercent = (nonRespondedStudents.size()+0.0)/allStudents.size();
			notRespondedAngle = notRespondedPercent*360;
		}
		System.out.println("type"+announcementType  );
		System.out.println("no "+respondedNo+" "+noAngle);
		System.out.println("yes "+respondedYes+" "+yesAngle);
		System.out.println("responded "+respondedStudents+" "+respondedAngle);
		System.out.println("non "+nonRespondedStudents+" "+notRespondedAngle);
		
		
        
        
    }
    catch(Exception e){ 
    	System.out.print("stats "+e);
    }
    %>

                                            <link rel="stylesheet" href="css/piechart.css">
                                            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
                                            <div class="container-fluid">
                                                <style>
                                                    body {
                                                        font-family: Arial;
                                                    }
                                                    /* Style the tab */
                                                    
                                                    .tab {
                                                        overflow: hidden;
                                                        /* border: 1px solid #ccc; */
                                                        /* background-color: #f1f1f1; */
                                                    }
                                                    /* Style the buttons inside the tab */
                                                    
                                                    .tab button {
                                                        background-color: inherit;
                                                        float: left;
                                                        border: none;
                                                        outline: none;
                                                        cursor: pointer;
                                                        padding: 14px 16px;
                                                        transition: 0.3s;
                                                        font-size: 17px;
                                                    }
                                                    /* Change background color of buttons on hover */
                                                    
                                                    .tab button:hover {
                                                        background-color: rgb(219, 219, 219);
                                                    }
                                                    /* Create an active/current tablink class */
                                                    
                                                    .tab button.active-yes {
                                                        background-color: rgb(71, 172, 177);
                                                        color: white;
                                                    }
                                                    
                                                    .tab button.active-no {
                                                        background-color: rgb(242, 101, 34);
                                                        color: white;
                                                    }
                                                    
                                                    .tab button.active-not-responded {
                                                        background-color: rgb(255, 205, 50);
                                                        color: white;
                                                    }
                                                    /* Style the tab content */
                                                    
                                                    .tabcontent {
                                                        display: none;
                                                        padding: 6px 12px;
                                                        /* border: 1px solid #ccc; */
                                                        -webkit-animation: fadeEffect 1s;
                                                        border-top: none;
                                                    }
                                                    
                                                    @-webkit-keyframes fadeEffect {
                                                        from {
                                                            opacity: 0;
                                                            font-weight: 200;
                                                        }
                                                        to {
                                                            opacity: 1;
                                                            font-weight: 700;
                                                        }
                                                    }
                                                    
                                                    @keyframes fadeEffect {
                                                        from {
                                                            opacity: 0;
                                                        }
                                                        to {
                                                            opacity: 1;
                                                        }
                                                    }
                                                    
                                                    .piechart-yes-or-no {
                                                        /* margin-top: 300px; */
                                                        /* display: block; */
                                                        /* position: absolute; */
                                                        width: 300px;
                                                        height: 300px;
                                                        border-radius: 50%;
                                                        background-image: conic-gradient( rgb(71, 172, 177) <%=yesAngle%>deg, rgb(242, 101, 34) 0 <%=(yesAngle+noAngle)%>deg, rgb(255, 205, 50) 0);
                                                        /* display: flex; */
                                                        justify-content: center;
                                                        align-items: center;
                                                    }
                                                    
                                                    .piechart-broadcast {
                                                        /* margin-top: 300px; */
                                                        /* display: block; */
                                                        /* position: absolute; */
                                                        width: 300px;
                                                        height: 300px;
                                                        border-radius: 50%;
                                                        /* background-image: conic-gradient( rgb(25, 25, 175) 70deg, rgb(15, 119, 114) 0); */
                                                        background-image: conic-gradient( rgb(71, 172, 177) <%=respondedAngle%>deg, rgb(255, 205, 50) 0);
                                                        /* display: flex; */
                                                        justify-content: center;
                                                        align-items: center;
                                                    }
                                                </style>
                                                <div w3-include-html="navbar.html"></div>
                                                <br>
                                                <div class="row">
                                                    <div class="col-md-3"></div>
                                                    <div class="col-md-5">
                                                        <p style="text-align: left;text-align: center;
                                                    font-weight: 800;
                                                    font-size: xxx-large;
                                                    color: dimgrey;">Announcement Stats</p>
                                                    </div>
                                                    <div class="col-md-3"></div>
                                                </div>


                                                <div class="row">
                                                    <div class="col-md-3"></div>
                                                    <div class="col-md-5">
                                                        <% Connection con1 = Dbinit.getConnection();
		String username = "priyaa"; //TODO: Fetch from Session
		try {
			Statement stmt = con.createStatement();

			ResultSet result = stmt.executeQuery("SELECT * FROM announcements WHERE id = '"+id+"'");
            result.next();

                                                 
                                                 %>
                                                            <div class="card">
                                                                <div class="card-block d-flex flex-column">
                                                                    <%if(!result.getString("type").equals("Broadcast")){%>
                                                                        <div class="card-header bg-danger">
                                                                            <%}else{%>
                                                                                <div class="card-header bg-info">
                                                                                    <%}%>
                                                                                        <div class="row">
                                                                                            <div class="col-md-6 text-light">
                                                                                                <strong><%=result.getString("title") %></strong>
                                                                                            </div>
                                                                                            <div class="col-md-3"></div>
                                                                                            <div class="col-md-3 text-light">
                                                                                                <strong><%=result.getString("priority") %></strong>
                                                                                            </div>
                                                                                        </div>

                                                                                </div>

                                                                                <div class="card-body">
                                                                                    <h6 class="card-subtitle p-3">
                                                                                        <%= id.split("<")[1] %>
                                                                                    </h6>
                                                                                    <div class="p-3">
                                                                                        <div class="pb-2">
                                                                                            <h6 class="card-subtitle text-muted">
                                                                                                <%=result.getString("semester") %>
                                                                                                    <%=result.getString("department") %>
                                                                                                        <%=result.getString("section") %>
                                                                                                            <%=result.getString("type") %>
                                                                                            </h6>
                                                                                        </div>
                                                                                        <p class="card-text p-y-1">
                                                                                            <%=result.getString("content") %>
                                                                                        </p>
                                                                                        <h6><strong> Last Date
                                                                                            <%=result.getString("last date")%>
                                                                                        </strong>
                                                                                        </h6>
                                                                                        <br>

                                                                                    </div>
                                                                                </div>

                                                                        </div>
                                                                </div>
                                                                <% 
                                                    }
        catch(Exception e){ 
            System.out.println(e);
        }
                                                    %>
                                                            </div>
                                                    </div>
                                                    <div class="col-md-3"></div>
                                                </div>

                                                <br><br>
                                                <div class="row">
                                                    <div class="col-md-2"></div>
                                                    <div class="col-md-4 " style="text-align: center;">
                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <br>
                                                                <%if(announcementType.equals("Broadcast")){%>
                                                                    <div class="piechart-broadcast"></div>
                                                                    <%}else{%>
                                                                        <div class="piechart-yes-or-no"></div>
                                                                        <%}%>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <br>
                                                                <br>
                                                                <br>
                                                                <%if(!announcementType.equals("Broadcast")){%>
                                                                    <div class="row p-1">

                                                                        <div class="p-2" style="height: 20px;width: 20px;background-color: rgb(71, 172, 177); "></div>&nbsp;Yes&nbsp;&nbsp;
                                                                        <%=respondedYes.size()%> <br>
                                                                    </div>
                                                                    <div class="row p-1">

                                                                        <div class="p-2" style="height: 20px;width: 20px;background: rgb(242, 101, 34); "></div>&nbsp;No&nbsp;&nbsp;
                                                                        <%=respondedNo.size()%> <br>
                                                                    </div>
                                                                    <div class="row p-1">

                                                                        <div class="p-2" style="height: 20px;width: 20px;background-color: rgb(255, 205, 50); "></div>&nbsp;Not Responded&nbsp;&nbsp;
                                                                        <%=nonRespondedStudents.size()%>
                                                                    </div>
                                                                    <%}else{%>
                                                                        <div class="row p-1">

                                                                            <div class="p-2" style="height: 20px;width: 20px;background-color: rgb(71, 172, 177); "></div>&nbsp;Responded&nbsp;&nbsp;
                                                                            <%=respondedStudents.size()%> <br>
                                                                        </div>
                                                                        <div class="row p-1">

                                                                            <div class="p-2" style="height: 20px;width: 20px;background-color: rgb(255, 205, 50); "></div>&nbsp;Not Responded&nbsp;&nbsp;
                                                                            <%=nonRespondedStudents.size()%>
                                                                        </div>
                                                                        <%}%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <br><br>
                                                        <div class="card">
                                                            <div class="card-header bg-white">
                                                                <div class="tab   row ">
                                                                    <%if(!announcementType.equals("Broadcast")) {%>
                                                                        <button id="defaultOpen" class="d-flex tablinks mx-auto " onclick="openCity(event, 'London')">Responded Yes</button>
                                                                        <button class="d-flex tablinks mx-auto " onclick="openCity(event, 'Tokyo')">Responded No</button>
                                                                        <button class="d-flex tablinks mx-auto " onclick="openCity(event, 'Paris')">Not Responded</button>
                                                                        <%}else{ %>
                                                                            <button id="defaultOpen" class="d-flex tablinks mx-auto " onclick="openCity(event, 'London')">Responded</button>
                                                                            <button class="d-flex tablinks mx-auto " onclick="openCity(event, 'Paris')">Not Responded</button>
                                                                            <%} %>
                                                                </div>
                                                            </div>
                                                            <%if(!announcementType.equals("Broadcast")) {%>
                                                                <div class="card-body">

                                                                    <div id="London" class="row tabcontent">
                                                                        <div class="col-md-12">
                                                                            <%if(respondedYes.size()==0){%>
                                                                                <p>No Student has responded Yes yet</p>
                                                                                <%}%>
                                                                                    <% for(int i=0; i<respondedYes.size(); i++){ %>
                                                                                        <ul class="list-group list-group-flush">
                                                                                            <li class="list-group-item">
                                                                                                <%=respondedYes.get(i) %>
                                                                                            </li>
                                                                                        </ul>
                                                                                        <%} %>

                                                                        </div>
                                                                    </div>
                                                                    <div id="Tokyo" class="row  tabcontent">
                                                                        <div class="col-md-12">
                                                                            <%if(respondedNo.size()==0){%>
                                                                                <p>No Student has responded No yet</p>
                                                                                <%}%>
                                                                                    <% for(int i=0; i<respondedNo.size(); i++){ %>
                                                                                        <ul class="list-group list-group-flush">
                                                                                            <li class="list-group-item">
                                                                                                <%=respondedNo.get(i) %>
                                                                                            </li>
                                                                                        </ul>
                                                                                        <%} %>

                                                                        </div>
                                                                    </div>
                                                                    <div id="Paris" class="row  tabcontent">
                                                                        <div class="col-md-12">
                                                                            <%if(nonRespondedStudents.size()==0){%>
                                                                                <p>All Students have Responded</p>
                                                                                <%}%>
                                                                                    <% for(int i=0; i<nonRespondedStudents.size(); i++){ %>
                                                                                        <ul class="list-group list-group-flush">
                                                                                            <li class="list-group-item">
                                                                                                <%=nonRespondedStudents.get(i) %>
                                                                                            </li>
                                                                                        </ul>
                                                                                        <%} %>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <%} else{%>
                                                                    <div class="card-body">

                                                                        <div id="London" class="row tabcontent">
                                                                            <div class="col-md-12">
                                                                                <%if(respondedStudents.size()==0){%>
                                                                                    <p>No Student has responded yet</p>
                                                                                    <%}%>
                                                                                        <% for(int i=0; i<respondedStudents.size(); i++){ %>
                                                                                            <ul class="list-group list-group-flush">
                                                                                                <li class="list-group-item">
                                                                                                    <%=respondedStudents.get(i) %>
                                                                                                </li>
                                                                                            </ul>
                                                                                            <%} %>

                                                                            </div>
                                                                        </div>

                                                                        <div id="Paris" class="row  tabcontent">
                                                                            <div class="col-md-12">
                                                                                <%if(nonRespondedStudents.size()==0){%>
                                                                                    <p>All Students have Responded</p>
                                                                                    <%}%>
                                                                                        <% for(int i=0; i<nonRespondedStudents.size(); i++){ %>
                                                                                            <ul class="list-group list-group-flush">
                                                                                                <li class="list-group-item">
                                                                                                    <%=nonRespondedStudents.get(i) %>
                                                                                                </li>
                                                                                            </ul>
                                                                                            <%} %>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <%} %>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2"></div>
                                                </div>
                                                <br>
                                                <br>

                                            </div>
                                            <script src="js/navbar.js"></script>
                                            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                                            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
                                            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
                                            <script>
                                                function openCity(evt, cityName) {

                                                    var i, tabcontent, tablinks;
                                                    tabcontent = document.getElementsByClassName("tabcontent");
                                                    for (i = 0; i < tabcontent.length; i++) {
                                                        tabcontent[i].style.display = "none";
                                                    }
                                                    tablinks = document.getElementsByClassName("tablinks");
                                                    for (i = 0; i < tablinks.length; i++) {
                                                        tablinks[i].className = tablinks[i].className.replace(" active-yes", "");
                                                        tablinks[i].className = tablinks[i].className.replace(" active-no", "");
                                                        tablinks[i].className = tablinks[i].className.replace(" active-not-responded", "");
                                                    }
                                                    if (cityName == "London") {

                                                        document.getElementById(cityName).style.display = "block";
                                                        evt.currentTarget.className += " active-yes";
                                                    } else if (cityName == "Tokyo") {
                                                        document.getElementById(cityName).style.display = "block";
                                                        evt.currentTarget.className += " active-no";
                                                    } else if (cityName == "Paris") {

                                                        document.getElementById(cityName).style.display = "block";
                                                        evt.currentTarget.className += " active-not-responded";
                                                    }
                                                }
 
                                                // Get the element with id="defaultOpen" and click on it
                                                document.getElementById("defaultOpen").click();
                                            </script>
                                            <script>
                                                includeNavbar();
                                            </script>
    </body>

    </html>