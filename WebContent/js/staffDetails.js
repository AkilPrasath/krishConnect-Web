var sub = document.getElementById("addsub");
count = 0;
sub.onclick = function() {
    count += 1;
    // console.log(count);
    var d = document.getElementById('subjectDiv');
    d.innerHTML += "<div><h6> Subject '" + count + "' </h6></div> " + `<br /><form name="subject"><div class="form-row">
      <div class="form-group col-md-5" name="">
        <select class="form-control" id="department${count}">
          <option>select department</option>
          <option>CSE</option>
                <option>EEE</option>
                <option>ECE</option>
                <option>IT</option>
                <option>MECH</option>
                <option>MCT</option>
                <option>CIVIL</option>
        </select>
      </div>
      <div class="form-group col-md-3">
      <select class="form-control" id="section${count}">
        <option>select section</option>
        <option>A</option>
        <option>B</option>
        <option>C</option>
      </select>
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-md-3">
      <select class="form-control" id="semester${count}">
        <option>select semester</option>
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
        <option>6</option>
        <option>7</option>
        <option>8</option>
      </select>
      </div>
      <div class="form-group col-md-5">
      <select class="form-control" id="subcode${count}">
        <option>select subject code</option>
        <option>A</option>
        <option>B</option>
        <option>C</option>
      </select>
      </div>
    </div></form>`;
};

var tutor = document.getElementById("addtutor");
tutor.onclick = function() {
    var div = document.getElementById("tutorDiv");
    if (div.style.display === "none") {
        div.style.display = "block";
    } else {
        div.style.display = "none";
    }
}


var uploadbuttton = document.getElementById("upload");
uploadbuttton.onclick = function() {
    var xmlhttprequest = new XMLHttpRequest();
    xmlhttprequest.onreadystatechange = function() {
        if (xmlhttprequest.readyState == XMLHttpRequest.DONE) {
            if (xmlhttprequest.responseText == "done") {

                window.location.replace("http://localhost:8080/krishConnect-Web/login.html");
                console.log("done done done staff details");

            }
        }
    }
    let temp = "null";
    console.log(temp);
    var parameter = document.details.name.value + ":" +
        document.details.phonenumber.value + ":" +
        "null" + ":" +
        document.details.locationprivacy.checked + ":" +
        "null" + ":";
    if (document.getElementById("tutorDiv").style.display === "block") {
        parameter += 'tutor:' + document.tutordetails.department_tutor.value + ":" +
            document.tutordetails.section_tutor.value + ":" +
            document.tutordetails.semester_tutor.value + ":";
    } else {
        parameter += 'nottutor:';
    }
    for (var i = 1; i <= count; i++) {
        var dept = "department" + i;
        var sec = "section" + i;
        var sem = "semester" + i;
        var sub = "subcode" + i;
        parameter += document.getElementById(dept).value + ":" +
            document.getElementById(sec).value + ":" +
            document.getElementById(sem).value + ":" +
            document.getElementById(sub).value + ":";
    }
    console.log(parameter);
    xmlhttprequest.open("POST", "staffDupload?parameter=" + parameter, true);
    xmlhttprequest.send();

}