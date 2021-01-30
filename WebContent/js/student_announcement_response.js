function respond(response, id, registerNumber) {
    alert("inside response function");
    var ajax = new XMLHttpRequest();
    ajax.onreadystatechange = function() {
        if (ajax.readyState == XMLHttpRequest.DONE) {
            alert(ajax.responseText);

        }
    }
    ajax.open("GET", "StudentResponseServlet?id=" + id + "&&response=" + response + "&&registerNumber=" + registerNumber, true);
    ajax.send();

}