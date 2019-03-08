<%@ page import="usermanage.User" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="User Manager"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${createLinkTo(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

    <!-- Website Font style -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'create.css')}">
    <!-- Google Fonts -->
    <link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <asset:stylesheet src="main.css"/>
    <asset:javascript src="lib/logout/logoutForm.js"/>
    <asset:javascript src="lib/etc/alertBox.js"/>
    <g:layoutHead/>
    <g:javascript library="application"/>
    <r:layoutResources/>
</head>

<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">User Manager</a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">



                <li><g:link controller="user" action="see_colleagues">     My<br/>Colleagues</g:link></li>
                <sec:ifAllGranted roles="ROLE_USER">
                    <li><g:link controller="user" action="edit_form">My<br/>Settings</g:link></li>
                </sec:ifAllGranted>

                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li><g:link controller="user" action="create_form">Create<br/>user</g:link></li>
                </sec:ifAllGranted>

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <sec:ifAllGranted roles="ROLE_ADMIN">

                    <li class="dropdown">
                        <g:link controller="schedule" action="schedule_form" class="dropdown-toggle"
                                data-toggle="dropdown"
                                ole="button" aria-haspopup="true" aria-expanded="false">User<br/>settings<span
                                class="caret"></span></g:link>
                        <ul class="dropdown-menu">

                            <g:each in="${User.list()}" var="user">

                                <g:if test="${user.username.equalsIgnoreCase(sec.username() as String)}">
                                    <li><g:link controller="user" action="edit_form"
                                                id="${user.id}">Me</g:link></li>
                                </g:if>
                                <g:else>
                                    <li><g:link controller="user" action="edit_form"
                                                id="${user.id}">${user.firstName + ' ' + user.lastName}</g:link></li>
                                </g:else>
                            </g:each>

                        </ul>
                    </li>

                    <li class="dropdown">
                        <ul class="dropdown-menu">

                            <g:each in="${User.list()}" var="user">

                                <g:if test="${user.username.equalsIgnoreCase(sec.username() as String)}">
                                    <li><g:link controller="schedule" action="schedule_form"
                                                id="${user.id}">Me</g:link></li>
                                </g:if>
                                <g:else>
                                    <li><g:link controller="schedule" action="schedule_form"
                                                id="${user.id}">${user.firstName}</g:link></li>
                                </g:else>
                            </g:each>

                        </ul>
                    </li>

                    <li class="dropdown">

                        <ul class="dropdown-menu">

                            <g:each in="${User.list()}" var="user">

                                <g:if test="${user.username.equalsIgnoreCase(sec.username() as String)}">
                                    <li><g:link controller="user" action="statistics"
                                                id="${user.id}">Me</g:link></li>
                                </g:if>
                                <g:else>
                                    <li><g:link controller="user" action="statistics"
                                                id="${user.id}">${user.firstName}</g:link></li>
                                </g:else>
                            </g:each>

                        </ul>
                    </li>

                </sec:ifAllGranted>

                <li class="active"><a href="" id="logoutLink">Logout <span class="sr-only">(current)</span></a></li>
            </ul>
        </div>
    </div>
</nav>

<g:layoutBody/>
<script>

    $("#logoutLink").click(function (e) {
        e.preventDefault();

        $.ajax({
            url: "${g.createLink(controller:'logout',action:'index')}",
            method: 'POST',
            success: function () {
                location.reload()
            },
            error: function () {
                alert("Request failed");
            }
        });

        return false;
    });


</script>

<r:layoutResources/>

</body>
</html>
