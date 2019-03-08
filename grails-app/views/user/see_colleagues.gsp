<%--
  Created by IntelliJ IDEA.
  User: kyle
  Date: 3/23/17
  Time: 7:21 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="topPanel">
    <title>Colleagues info</title>
</head>

<body>

<h2 align="center">User info</h2>
<br/><br/>

<div style="width:60%; margin: 0 auto;">

    <div class="panel panel-primary">
        <div class="panel-body" id="user${currUser.id}">
            <ul class="list-group">
                <li class="list-group-item">First name: ${currUser.firstName}</li>
                <li class="list-group-item">Last name: ${currUser.lastName}</li>
                <li class="list-group-item">Email: ${currUser.username}</li>
                <li class="list-group-item">User country: ${currUser.country.name}</li>
            </ul>
        </div>
    </div>

    <sec:ifAllGranted roles="ROLE_ADMIN">

        <g:each in="${users}" var="user">

            <div class="panel panel-primary">
                <g:if test="${!user.username.equalsIgnoreCase(sec.username() as String)}">

                    <div class="panel-body" id="user${user.id}">
                        <ul class="list-group">
                            <li class="list-group-item">First name: ${user.firstName}</li>
                            <li class="list-group-item">Last name: ${user.lastName}</li>
                            <li class="list-group-item">Email: ${user.username}</li>
                            <li class="list-group-item">User country: ${user.country.name}</li>
                        </ul>
                    </div>
                </g:if>

            </div>

            <ul class="list-group">

            </ul>
        </g:each>
    </sec:ifAllGranted>
</div>

</body>
</html>
