<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <link rel="stylesheet" href="css/staff_dashboard.css">
        <title>Dashboard</title>

    </head> 
 
    <body>
        <script>
            function updateLocation() { 
                var ajax = new XMLHttpRequest();
                ajax.onreadystatechange = function() {
                    if (ajax.readyState == XMLHttpRequest.DONE) {
                        var res = ajax.responseText;
                        console.log(res);
                    }
                };

                navigator.geolocation.watchPosition(function(position) {
                    ajax
                        .open("GET", "http://localhost:8080/krishConnect-Web/GeofenceServlet?latitude=" + position.coords.latitude + "&&longitude=" + position.coords.longitude,
                            true);
                    ajax.send();
                }); 
            }
            updateLocation(); 
        </script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <div class="container-fluid  p-0">
            <div w3-include-html="navbar.html"></div>
            <br>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-3">
                    <p style="display: inline-block">Hi,</p>
                    <p class="username">
                        <%= request.getSession().getAttribute("username").toString().split("@")[0]%>
                    </p>
                </div>
                <div class="col-md-5"></div>
                <div class="col-md-2">
                    <div id="logout" class="btn btn-success">Logout</div>
                </div>
                <div class="col-md-1"></div>
                <script>
                    function addListener() {

                        document.getElementById("logout").addEventListener("click",
                            logout);
                    }
                    addListener();

                    function logout() {
                        alert("logout");
                        var ajax = new XMLHttpRequest();
                        ajax.onreadystatechange = function() {
                            if (ajax.readyState == XMLHttpRequest.DONE) {
                                location.replace("http://localhost:8080/krishConnect-Web/login.html");
                            }
                        }
                        ajax.open("GET", "LogoutServlet", true);
                        ajax.send();
                    }
                </script>
            </div>
            <br>


            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-3">
                    <a href="student_announcements.jsp">
                        <div class="card h-100" style="width: 18rem;height: 18rem;">
                            <img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxANDw8NDRIPDg8WDQ8VFRAPDxAPDxcVFRIWFhUXFxUYHSshGBolGxUVITEhJSkrLjIvFyAzODMsNygtLisBCgoKDg0OGhAQGi8lHyYtLS8tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAKMBNgMBEQACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAAAQUCBAYDBwj/xABHEAABAwIEAwQGAw4DCQAAAAABAAIDBBEFEiExBkFRE2GBkRQicaGxwTJisgcjJDNCUnJzgpLC0eHwFTXxNFNUZJOis9Li/8QAGwEBAAMBAQEBAAAAAAAAAAAAAAECAwQFBgf/xAAyEQEAAgIBAwIEBQMDBQAAAAAAAQIDEQQSITETQQUiMlEzYXGBsQYUkSQ0QiNSocHx/9oADAMBAAIRAxEAPwC2XoPlxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEGTGk7aomI2hwsSO9CUIgQEBAQSB10RMQgi2iIEBAQEBAsgICAgICAgICAAgl7bGxRMxpCIEBAQSBfQIJLCNfgQUTpiiBAQEBAQEBBLHWIPeiYnQ5xO5J9qEztCIEBAQEEh1v7uidoJRAgICAgICAgICAgICAgICAgICAgIMmG2/MEImJToAdQb9FCfDBSqICAgICAgICAgICAgICAgICAgICAgICDJguQCiYSdQbi3u8FCWClUQEBAQEBAQEBAQEBAQEHvRUj53iOIXcfIDmSeQVbWisblfHjtkt01K2ldBI6J9szSL5TcagH5qazuNmSk0tNZ9ngpUEBAQEBAQEBAQEBAQSwXPyRMJeNuXchLFECAgICAgE33uUNiAgICAgICAgICAgICAg96KjfO8RRC7j5AcyTyCra0Vjcr48dslumroquqjw2M09PZ9Q4DPJbbvPyHie/GInJO58PQvevGr0U+r7uXc4kkkkkm5J1JPUroebM7ncoRAgICAgICAgICAgICAgICAgICAgICAgICD1iizg2+kD4WUbXrXcMHgA2Bv3qVZiIYogQEBAQEBBb4XgEs/rvvDDa5e4akfVHz2WV8sVdmDh3yz37Q+WwY87050gc7snykZS4kBhNm6baC3v6rycXJt6vVM9pffc34PgngehSsdVY3E++/M/5fSsKxl9PHI2Jrcz7euR6zbaadV7FqRbu/PcXIthia18y0XOJJJJJJuSTcknckq7CZ3O5THG57g1gLnHYNBJPgFEzorWbTqG9W4NNTxtllDWgutlzXeDYkXG3Lqq1yRadQ3yca+OsWsr1dziAgICAgICAgICAgICAgICAgICAgICCEHoJXCwBtY8lGk9UsXuuSdu5STO0IgQSBoiUIh6U9O+U5Y2ueejQXfBRMxHlatLW+mNruh4UnksZS2Fv77/ACGnvWVs0R4duPgXt9XZ0eH4BT09nBud4/KfZx8BsFjbJaXoYuJjx+25OKarsaCskGmWknI63yGywyTqsy9HiU689I/OP5fl8nU+1edMdn22/nl9SwmbtIY39WNPmBf33X0GG3VSJ/J+S/EMPo8nJj+1p/lfYLh0dQXumlbExgBNyA43vsTttvql7zHiFOPhrk3Np1ELOXHIKUGOhjBPOV4Ovzd42CpGObd7Om3Kx4o6cMfuoauskndnlc5579h7BsFtWsV8ODJltkndpeClRZ8PYcyrmMUhc1vZuddhANwQOYPVUyWmsbh08XDXLfpltU+DRurn0hL+zaDY3bn+iDva3PoqTkno6mteNWc84/Z48RYKaR4LLuhds46kG2oNvMf0U48nV+qnK43pTuPDewHhkTx9rOXsDvoBlgbdTcHfkq3y6nUNuNwovXqu1sBwaOqknjeZGhh0yFoP0nDW4PRTe81iNKcbjVyXtE+ywPDVLJnZBUEytvdpfG+xBtq0AEaqvq2jzDeeFituK27qKjwmWWc0wsHNcQ4nVrQDYnvWs3iK7cNOPa2TodAeHqJhEMk57U20MrGuudrNssfVvPeId/8AaYK/La3dSY9grqNwN88br5XWsb9COvxWuPJ1OPk8acM/kuncN0jI2STTSRhwbq6SNrbkXsLt9vksvVtvUOz+zwxWLWnStxvAW07Gzwv7SEkC5IJF9jcaEFaUybnU+XPn4kY4i9Z3CzpuHaGYlsU75CBchksTiB4NWc5bx5h0V4eC/wBNmjjGFUcEchinLpmkDszJGTfMAQWgX0F1el7TPeGOfj4aVnVu6OHMAbVsfJKXtaHZW5C0XsPW3B6j3pkyTWdQji8WMtZtZW41QeizviFy3QtJtctI/nceCvS3VG3PyMPpXmq4puGWzUjZo3P7Z0eYNJbkJvttfX2rOcsxbU+HVThRfDFo86ePD2BR1Ucj5TI1zZC2zS0cgdbg6qcmSazGleNxa5KzNvMMMEw2kniY6eYxyucR2Ykjad7CwIvql73ie0GDBhvX5p7rKp4coobCWd8d72zyRNvbe12qkZbz4hvfh4KfVbTkpgA5wabtD3AHe4B0PkuiPHd5doiJmIYqVRBCCUBBCGttCrxqnhuHSNJ/NZ67vdt4rnycrFTzL1+L8D53J70xzEfeezpOEMMZiUHpRc+OMyPa1thmIbYE35a3012VK8qLxusNuR8Etx8np5Lbn8nV0vDtLHrkMh6yHN7tvconLaU04eKvtv8AVaRtawZWNa0dAAB5LPbpiIjwklEoQUHH78uFVx/5cjzcB81lm+iXb8NjfKp+r4fxTwfPhsdPUSOZLFMDlczMC05Q7K4HuJta+xXLek1rD6HjcyubJasRqYdHwo/NTR/okeTnBerw53hh8J/UNOn4hk/af8xC4XU8RKAgIL7gn/aj+of9pqyzfS7uB+L+ywo/83m/Rd9hqzn8J0U/3k/os5K6KaaehqA2wLC3MbBwyNdv1BPl4qkVmIi0Oi2Slrziu98MxRtRLNHFbs48gDhzJzXt9UWACi1ZiImV8WaL2mtfEKXg38fWfpfxvWmX6YcnC/EyPdjqGjllqO1LpSZLsDg8gl13ANA0101UfPaIjS+8GK8333eXCVYJqire4We8tcBzygnTwu1TlrqsKcPJF8l5+7ncQoZhO9j2Pc90jjcNJzXO46rato6XDlxZPUncd3R8S3jw+GOY3l+9De5zNb63uuL96wx977h38r5ePEW89lnXwwSQQMqjZpdEG6lvrlhAFx3XVKzMTOnRkrjtjrGTx2VPF7+wgipImFsZ/KvcWab5et72K0wx1W6pc3NnoxxjiOzW4F/HS/qf4grZ/DL4d9c/op8YBNVOBqe3k0/aWlPphy8iN5bfq7qnoZIaWOGAtbIMhJde18wc/Yc9R4rlm27bl7VMc0xRWvlVccUWaOOoA1acrv0XbeR+0tMFu+nL8Qx7rFvs26Ks9Gw6Ka1w1sdxzsZA0277Eqlo3eYa4snp8etvyWVLDGBJLFa0tnm2xJba49uirMz4lvWtYibV9+75thf42D9bF9oLst9MvAx/iR+v/t0fHv06f9CX4tWOD3d/xLzVyy6HmCAgICAgp+K5nMpH5SQS5jbjoTr8LeK5Obaa4p097+m8NcnPr1e25/8ADgl4D9WfevuUf5RT/rKj/wAz/wCi9Pj/AIcPh/jP+7t+zr1u8sQEBBzv3QxfCq79SPc9qyzfRLu+G/7qn6uT+6uAcEoXc/SILeMEl1TN+HDs+GzP93b9/wCXN8HH8GZ+39pdnB/Cj93z39TR/r7fpX+HU4XLCyS9Sx0jMp0b10sdxfmuq8TMdniYbUrbd43C49Ow3/h3+X/0sunJ93X6vF/7UOrsNsfvD9u8fxKenJ90Tl4uvpc6Vs8+W7hGIupJO1a0POQts4kDUg8vYqXr1RptgzTit1RD3ixpzap1YGNLnA+pc5dQBv4KPT+XpaV5Uxl9TTTxKsNTK+ZwDS7L6o1GjQ35K1K9MaZZsvqX6m3gmMuo+0yMa/NlvmJFst+ntVb4+ppx+TOHeo3tOFY06lfLI1jXl5uQSQBqTp5pfH1REJw8mcVptEeVdUS53vkOhc9zrcvWJPzV4jUac97dVpsmmqHwvbJGS1wOhH97JMRMakpe1J3V0UfGUgbZ0THO/OD3NHlY/FY+hH3ehHxGdd691HiWISVT88pubWDRo1o6ALWtIr4cWbNbLO7NvFMcfUxMhcxrQ1zSCCSdGlvzVa44rO2ublTkpFdeGVdj76iAQSsY4gNtJc5rj8q3X+aiMep3EpycucmPotH7tfBsVdRvc9rWvJbls4kcweStenVGmfHzzhmZiNvMV34R6SWtJ7UvyXOW97jX2/BT0/L0o9X/AKnqTDZxbHZaotP4oNBFo3uAN9yfIKtMcVaZuVfJMez0HEL/AEY0r2NkBY5udznZtSSD7Rp5KPSjq3C0cy3p+nMbYSY451KKPI3LlaM9zm0cHbeCen83UrPKn0vS0zwriKWmj7ENbI25tmJBF9wLcr6pbFFp2nDzLY69Gtqmmk7NzHjXK5pseeUg/JaTHbTmrbVolv41jDqwsL2tZlDh6pJve3X2KlKdDfkcmc2txrSuWjmEBAQEBBq4pRiohfCTbMNDvYg3B8wss2P1KTV2/DuZPD5Nc0e38e7iqrh2piBJaHtAJJY4HQc7GxXjX4WWvfW36Rx/6l4GaYjqmJn7w+l/ckxiI0LqZ0sbJGVL7MdI1ri14DgQCddcw8FrxrR0al53xvDaeR11jcTH8O/Bda4uR1GoXS8MEpH+iDIT9Qg9Gyg/1QVPGUPaYbXMGpNJMR4NJ+SpkjdJdXCt08ik/nD4VxNxlNiFPT0T42RxQlpBaXOe5zWZASTtoTpbmuO2SbUiH0mDhVw5rXifK94PH4Mz9v7ZXqcL8KP3fE/1LP8Ar7fpX+IdHT0skubs2OfYXOUE2C6pmI8vCrS1vpjbxUqT2EBB7UVMZpY4m7ueB7BzPgLlRadRtfHSb3irqeJ8OiMBfAwMMUgDsrMt2kC+v5Vrt17iufFeeru9Pl4a+nuseENwmOooIQwMbOYy5psA5xF7gnncJN5i8lePXJgr93vLRxf4jFH2ceT0UnLkblvd2tuqjqnomVpx1/uKxr2YuwiONtbI1rHxOgLozYHKQH5gOljb+wnXM6g/t6165jxrs0Xuiw+CnIhZPLKzMXSagCwNh+8Ffve092O6cfHWency9X0cL5aGpjYGNlfZ0RALb2J26aH3KItMRMLTipa2PJEefYwymjdidRGWMLAx9mloLRqzYeKWmfTgxUrPJtGu3/xlgmHRT0T2yBrXOme1slhmDtMuvt5KL2mLQnBhpfDMT92VTg7XHD4Htaxxa/tC0AEljATqN9jr3pF5+aU341Z9Okx+rQxHF4mmWnZTQhjS9gLh6+YEjNt1CvWkzqdsMvIpXdIpGlvQ0o9Ep3RxUr3FnrGcBvvA1KztPzT3dWOkelWYiN/m1MBhikfXGdkQaCL2ALGgZg7KeQ03VrzMRGmXHrS1r9UQ2sJ4ejglcZiyXM4iJrrG7bXJI62/vVVvlmY7NMPErS0zbv8AZ5YHStMdW4RwPeKuQN7YDIB6ul7aDdTeZ3COPjrq/aPPu8IYc2IxRyx04HYuuyIB0Z0eQTcb/wAlMz8naVK1ieRFbRHj2bv+Dxxmrla1j4nQuLNAcjxmzAdLH+9FXrmdQ1jj1rN7RHaYamAVUcsM2aCC8MAIOQEuIafpafV96tkiYmO/llxb1vSd1jtDUwWoZUVMj3xRNb6M85A0FgLbagHnurXia18ssF65MszMR4c8Nls4JSgICAgIACiZ0mImZ1C6pMIbl+/DMSNW39UX5d68nPzbTPTTw+o4PwilIi+Xvb7fZqmlwqJwgyUIeSW9nkic++xzC1x4rh7voOvLPfcvQYR6K38Cc+JoJtE2RwGrr+qb9Tsu7jcqtY6b+Hg/EeBly3nLinv7wmHiCqjNnPz2Ni2RocfPf3r0ox0tG4eD/d58c9Nvb7rKm4padJoiPrROv/2u/mqTg+zop8Rj/lC3pMQgn0ikaXfmu9R/kd/BZWpaPLsx8jHfxL3nizNfG7QOY5p9jhY/FZzG406aW6bRb7PzDWwGKWSN30mvc0+1psfeF5vtp9zuLT1R7xEvoXDEeWmiH1L/ALxJ+a9riRrFV+afH79fPyT+ev8AEadFh2IyUzi6IgXtcEXaQNrre1It5eZizWxTuq89Po67Spb2Ev8AvAbD97/2WPTenju7vVwZ/rjU/dXYvgT6ZvaBzZIrizxoddrj5haUyRbs5s/FtjjqidwqVo5W9g+ICll7bJ2hykAF2WxPPbpceKpevVGm+DLGK3Vrbeh4mlIkZUATsewty6Mte97EDoVScUezevNv3i/eJa7saf2VNGxuR0Lrh+a99CNRbbVW9PvMz7s55U9FaxHhsv4jJqmVXZi7YizJn31Jve3eq+l8umk8zeSL69njS48+OKeEtDmyGQi7rZM97201Gqmce5iVacua1tXXaWVFjobE2CohZUsb9HMbEd17FLY++4nRj5URXpvXcR4eFdjUk0scoDYxGR2bG/Rbt57BTXHERpTJyrWtEx214b8nE303xwRxzubYzZrn22t3DnyVfS9pns2nmx3mK6t91dHihbSmlDbffQ8SZrEEEEaW7t7q3R822MciYxen+e9tiv4hkmMDwAySIk5wb5iQAdLaDTbvUVxRG18nMtfpnxMPSqx2OVri6lhMrmkGS/UWva17+KiMcx79k25VLR3pG/uiLHY+xiglpmTBjbAvd77ZdEnHO9xKa8uvRFbV3p4w4wI/SgyJrWzMDQ0OsGDKRpprvdWmm9d/CleTFerUeXlhuKvgljldmlyMc1rXPIABFrDoptSJjSmLkWpaLT302aHHGxsmjfC2ZskznlrnWGttLW12VbY967tMfKisWia7iZYxYwyOeOeKnZEGtcCxjrBxIIuTbvT05mNTJHJrXJF611pNLj742VEZbmbK6UgF1shkJvbTXf3JOLepKcyaxaNdpa+F4n6Mydgbn7SPLfNa2hF9td1a9OrTPBn9OLRry1qOZkbiZIxKMjgGlxbYnY3HRTaJmOzPHatZ7xt4BWZiAgIBNtToOpQ00anGaaL8ZPC3u7RpPkNVE2hrGHJbxDpcMw57THNI2zHRh7DcHMDsdO43XBzc8RTpr7vY+FcG3q+pkjtHj9VuvIfUOQwCpcMVxSGKJjw4xOMhcGZbMAynQ3BJPkVf2b5ax6VJmXUwsO7msaejbn32HwVNMJc3WMyTytLs5zXvtvrb2i6+g41urFHbT4j4jSa8i0b281u4RBZ4fjs8Fhm7Rn5kmo8DuFnbHWXVi5eTH77h8/46wzta4z0zH5JiHFtiQ2Q6PBI5X9a/eei8nkca9cmojtL7/wCE/GOPk4u8loiaeYn3j219/s7Dhqnga6OOouIsobcEgaCzSTyC9WKzWkRX2fB2y1zci18ni0zP+VhjmEOpXXF3xOPqv+R7/ippfqZ8jjzinfsrFo5mfbOy5Mzsl75bnLfrbZRqPK3VbWt9mJaQL8lKNIRAgICAgICAgICAgICAgICAgICAgICD5lPxDVybzPH6GWP3tAK5+uXt142KPZXzTvk1kc95+u4u+KrtrFYjxCzi4imja1kTKaG1E+mc6OnZnkjebuMhdfM/6wso0tt9n4Qq/ScHw6W9yyMwuPO8ZLNf+mPNcXLr229Dg276b7idgPE2suB6b5rHK2lx+YSTupo3H1nhwaHZo2uAcToATz+CvDumOrjRqNy+i0+S5yF7h+c50j2+DnaeSq4J37ubqyO2kyNyNvsRY356L3uNE+nG52+J+ITWc9umNMF0OEQEBBCC/wAExduX0Sr9aBwsHO/J7j3d/L4Y3pP1V8u7j8iNenk8NLHMKNJIADmjcCWO52Frg94uFal+qGPJwelb8p8K5aOdJdfdDaEBAQEGTBuTyCJgcBYEab6boTDFECAgICAgICAgICDJrCdeVjrbRExG2KIEBAQfHlyvohAUD6x9yrGo2YbU00zspbVB8YyuJIc1pIFh1a7zWeXFbJXUL4uTTDaJvLpnYzFyzn2Mt8Vxxwcs+XVb4zxo8TM/s4fiOimmr48QpWs9XsjllIF3RnS4F9LAK88HJHjTp4/9Q8X05pfcLyHH657z2kVPEzLplc+R97jrYWtfktMfBnfz+HDy/jGGKRHHmZn84Q4lznPccznHU7L0qUisRWHzOXLbLab28yKzMQEBAQEGT5C6wcS6wsLkmw6DoE0mZmfLFECAgICAgkG2yESOdfdE72hECAgICAgICAgICDJkhF7fHvRMTpiTfVECAgIPnFJwvVSbtbGPru18hdYRSXsW5eOPfa5peCmjWaRzu5gDR81aMbntzp/4wuaTh6li+jG0nq71z77q8UiHNbk5Le6yawDYAK2mMzMs0QICAgICCTbkiUIgQEBAQEBAQEBAQEBAQEBBLRfyQgcNvYiZQiBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEC6ASgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAghAQS11jdCEvdc3RM90IhCCUEICCUBBIHM7ey6JiEOFkQICAgICCEEoCAgICDJjC7boiYjbFEIQSgICAgICAgku0tyRO2KISghBKAghBKAgIIQEEoIQSghBIdZAJugICAgIIQSgICAgICACgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg//2Q=="
                                class="card-img-top" alt="...">
                            <div class="card-body">
                                <p class="card-text">Announcements</p>
                            </div>
                        </div>
                    </a>
                </div>


                <div class="col-md-3" style="height: 100px; ">
                    <a href="StudentLetterRequests.jsp">
                        <div class="card h-100" style="width: 18rem;height: 18rem;">
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHjYwbfbNgG74X_IMuu4pBTQ1nfGaAjifBRQ&usqp=CAU" class="card-img-top " alt="...">
                            <div class="card-body">
                                <p class="card-text">My Requests</p>
                            </div>
                        </div>
                    </a>

                </div>

                <div class="col-md-3"></div>
            </div>
            <div style="height: 50px;"></div>
            <div class="row">
                <div class="col-md-3"></div>

                <div class="col-md-3">
                    <a href="student_location_view.jsp">
                        <div class="card h-100" style="width: 18rem;height: 18rem;">
                            <img src="data:image/jpeg;base64,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"
                                class="card-img-top " alt="...">
                            <div class="card-body">
                                <p class="card-text">Find Staffs</p>
                            </div>
                        </div>
                    </a>



                </div>
                <div class="col-md-3">
                    <a href="">
                        <div class="card h-100" style="width: 18rem;height: 18rem;">
                            <img src="data:image/png;base64,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"
                                class="card-img-top" alt="...">
                            <div class="card-body">
                                <p class="card-text">Settings</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-3"></div>
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