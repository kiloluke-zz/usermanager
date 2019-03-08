<%--
  Created by IntelliJ IDEA.
  User: kyle
  Date: 3/23/17
  Time: 4:54 PM
--%>

<%@ page import="usermanage.Country" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="topPanel">
    <title>Create user</title>


</head>

<body>

<div class="container">
    <div class="row main">
        <div class="main-login main-center">
            <h2>Create new user</h2>
            <g:form name="createUser" method="post" controller="admin" action="createUser">

                <div class="form-group">
                    <label for="firstName" class="cols-sm-2 control-label">Enter First Name</label>

                    <div class="cols-sm-10">
                        <div class="input-group">
                            <g:textField type="text" class="form-control" name="firstName" id="firstName" placeholder="Name"
                                         />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="lastName" class="cols-sm-2 control-label">Enter Last Name</label>

                    <div class="cols-sm-10">
                        <div class="input-group">
                            <g:textField type="text" class="form-control" name="lastName" id="lastName"
                                         placeholder="Enter last name" />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="username" class="cols-sm-2 control-label">Email(User name)</label>

                    <div class="cols-sm-10">
                        <div class="input-group">
                            <g:textField type="text" class="form-control" name="username" id="username"
                                         placeholder="Email" autocomplete="false"/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password" class="cols-sm-2 control-label">Password</label>

                    <div class="cols-sm-10">
                        <div class="input-group">
                            <g:passwordField type="password" class="form-control" name="password" id="password"
                                             placeholder="Enter Password" autocomplete="false"/>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="confirm" class="cols-sm-2 control-label">Confirm Password</label>

                    <div class="cols-sm-10">
                        <div class="input-group">
                            <g:passwordField type="password" class="form-control" name="confirm" id="confirm"
                                             placeholder="Confirm Password" onkeyup="checkPassword()"/>
                        </div>
                    </div>
                </div>




                <div class="form-group" style="width:60%">
                    <label for="country" class="">Country <br/></label>

                    <g:select name="country" from="${Country.findAll().name}"
                              value="Choose country" />

                </div>



                <div class="form-group ">
                    <g:submitButton id="submit" class="btn btn-primary btn-lg btn-block login-button"
                                    value="Submit" name="submit" disabled="disabled"/>
                </div>

            </g:form>

        </div>
    </div>
</div>



<script>
    (function () {
        var previousValue = document.getElementsByClassName('holidays').value;
        var pattern = /^\d*((\.|,)\d*)?$/;

        function validateInput(event) {
            event = event || window.event;
            var newValue = event.target.value || '';

            if(previousValue == "undefined"){
                previousValue = '';
            }

            if(newValue == "undefined"){
                newValue = '';
            }

            if (newValue.match(pattern)) {
                // Valid input; update previousValue:
                previousValue = newValue;
            } else {
                // Invalid input; reset field value:
                event.target.value = previousValue;
            }
        }

        document.getElementById('holidays').onkeyup = validateInput;
        document.getElementById('workTimeBase').onkeyup = validateInput;
    }());


</script>

<script>


    function checkPassword() {
        var pass1 = document.getElementById("password").value;
        var pass2 = document.getElementById("confirm").value;
        var ok = true;
        if (pass1 != pass2) {
            //alert("Passwords Do not match");
            document.getElementById("password").style.borderColor = "#E34234";
            document.getElementById("confirm").style.borderColor = "#E34234";
            document.getElementById("submit").disabled = true;

            ok = false;

        }
        else {

            document.getElementById("password").style.borderColor = "#d8e3d8";
            document.getElementById("confirm").style.borderColor = "#e3e1d7";
            document.getElementById("submit").disabled = false;
        }
        return ok;
    }

</script>

<asset:javascript src="lib/jscolor.min.js"/>


</body>
</html>
