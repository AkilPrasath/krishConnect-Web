<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Insert title here</title>
    </head>

    <body>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <div class="container-fluid  ">
            <div w3-include-html="navbar.html"></div>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 p-3">

                    <a class="btn btn-primary btn-block" data-toggle="collapse" href="#newAnnouncement" role="button" aria-expanded="false" aria-controls="newAnnouncement">
                        Post New Announcement
                      </a>
                    <div class="card collapse" id="newAnnouncement">
                        <div class="card-header">
                            New Announcement
                        </div>
                        <div class="card-body">
                            <form action="" method="post" name="new announcement">
                                <div class="row  p-2">
                                    <div class="col-md-4">
                                        <span class="text-dark">Name</span>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="text" name="" id="name" value="priyaa" disabled>
                                    </div>
                                </div>

                                <div class="row  p-2">
                                    <div class="col-md-4">
                                        <span class="text-dark">Type</span>
                                    </div>
                                    <div class="col-md-8">
                                        <select class="custom-select" name="type">
                                            <option selected value="1">BroadCast</option>
                                            <option value="2">Yes or No</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row p-2">
                                    <div class="col-md-4">
                                        <span class="text-dark">Priority</span>
                                    </div>
                                    <div class="col-md-8">
                                        <select class="custom-select" name="priority">
                                            <option selected value="1">High</option>
                                            <option value="2">Usual</option>
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
                                                <select class="custom-select" name="department">
                                                    <option selected value="1">CSE</option>
                                                    <option value="2">IT</option>
                                                    <option value="3">EEE</option>
                                                    <option value="4">ECE</option>
                                                    <option value="5">MECH</option>
                                                    <option value="6">MCT</option>
                                                    <option value="7">CIVIL</option>
                                                </select>
                                            </div>
                                            <div class="col-md-4">
                                                <select class="custom-select" name="semester">
                                                    <option selected value="1"> 1</option>
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
                                                <select class="custom-select" name="section">
                                                    <option selected value="1">A</option>
                                                    <option value="2">B</option>
                                                    <option value="3">C</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row  p-2">
                                    <div class="col-md-4">
                                        <span class="text-dark">Last Date</span>
                                    </div>
                                    <div class="col-md-8">
                                        <input type="date" name="date" id="">
                                    </div>
                                </div>
                                <div class="row  p-2">
                                    <div class="col-md-4">
                                        <span class="text-dark">Content</span>
                                    </div>
                                    <div class="col-md-8">
                                        <textarea name="content" id="content" cols="30" rows="10"></textarea>
                                    </div>
                                </div>



                                <button onsubmit="" class="btn btn-success btn-block">Post</button>


                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>
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