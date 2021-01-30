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
                        // alert(query);
                        var ajax = new XMLHttpRequest();
                        ajax.onreadystatechange = function() {
                            if (ajax.readyState == XMLHttpRequest.DONE) {
                                var string = ajax.responseText;
                                var rows = string.split("!");
                                var index, name, phoneNumber, location, lastSeen;
                                var singleRow;
                                var element = document.getElementById("tableRows");
                                element.innerHTML = "";
                                for (var i = 0; i < rows.length - 1; i++) {
                                    singleRow = rows[i].split("#");
                                    index = singleRow[0];
                                    name = singleRow[1];
                                    phoneNumber = singleRow[2];
                                    location = singleRow[3];
                                    lastSeen = singleRow[4];
                                    element.innerHTML += "<tr>" +
                                        "<td>" + index + "</td>" +
                                        "<td>" + name.split("@")[0] + "</td>" +
                                        "<td>" + phoneNumber + "</td>" +
                                        "<td>" + location + "</td>" +
                                        "<td>" + lastSeen + "</td>" +
                                        "</tr>";

                                }
                            }
                        }
                        ajax.open("GET", "StudentLocationFetch?query=" + query, true);
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

                            <input onkeyup="tableDataFetch(this.value)" placeholder="Search by name" type="text" name="query" class="input-group" id="query">
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
                                        Name
                                    </th>
                                    <th scope="col">
                                        Mobile Number
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