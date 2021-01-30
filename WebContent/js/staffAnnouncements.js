function postNewAnnouncement() {
    console.log("post function called ");
    var ajax = new XMLHttpRequest();
    ajax.onreadystatechange = function() {
        if (ajax.readyState == XMLHttpRequest.DONE) {
            var res = ajax.responseText;
            alert(res);
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
    var queryString = "name=" + name + "&&type=" + type + "&&priority=" + priority + "&&semester=" + semester + "&&department=" + department + "&&section" + section + "&&lastDate=" + lastDate + "&&content" + content;
    ajax.open("GET", "PostAnnouncementServlet/?" + queryString, true);
    ajax.send();
    alert("request sent");
}