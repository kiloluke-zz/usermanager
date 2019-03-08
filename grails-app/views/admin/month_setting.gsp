<%@ page import="usermanage.MonthSetting; java.text.DateFormatSymbols" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="topPanel">

    <title>Welcome, ${name}</title>
</head>


<body>

<g:set var="months" value="${new DateFormatSymbols().months}"/>
<g:set var="today" value="${new Date()}"/>

<h2 align="center">Month work days setting</h2>
<div id="monthSettingDiv">

    <label for="workDaysInMonth">Work days in chosen month -> <label id="workDaysInMonth">${workDaysInMonth}</label>
    </label>
    <input type="number" min="17" max="25" class="form-control" name="workDaysInMonthInput"
           id="workDaysInMonthInput"
           value="${workDaysInMonth}"/>
    <h4>Choose amount of work days for certain month</h4>
    <label>Year</label>
    <g:select class="form-control" id="year" from="${2010..2030}" name="year" value="${today[Calendar.YEAR]}"
              onchange="passGet()"/>
    <label>Month</label>
    <g:select class="form-control" id="month" from="${months as List}" name="month"
              value="${months[today[Calendar.MONTH]]}" onchange="passGet()"/>



    <button id="submit" class="btn btn-primary btn-lg btn-block login-button" name="submit"
            onclick="passSet()">Submit</button>

</div>


<br/><br/><br/><br/><br/>


<div style="width: 40%; position: fixed; top:100px; right:27%; z-index: 2 ">
    <div class="alert alert-success" id="responseSuccess" style="display: none">
        <strong>Success!</strong> <label id="successMessage">.....</label>
    </div>

    <div class="alert alert-danger" id="responseError" style="display: none; ">
        <strong>Error!</strong> <label id="errorMessage"></label>
    </div>
</div>

<div class="container">
    %{--<table class="table table-bordered" style="width: 30%">--}%
    %{--<thead>--}%
    %{--<tr>--}%
    %{--<th>Year/Month</th>--}%
    %{--<th>January</th>--}%
    %{--<th>February</th>--}%
    %{--<th>March</th>--}%
    %{--<th>April</th>--}%
    %{--<th>May</th>--}%
    %{--<th>June</th>--}%
    %{--<th>July</th>--}%
    %{--<th>August</th>--}%
    %{--<th>September</th>--}%
    %{--<th>October</th>--}%
    %{--<th>November</th>--}%
    %{--<th>December</th>--}%
    %{--</tr>--}%
    %{--</thead>--}%
    %{--<tbody>--}%
    %{--<g:each in="${MonthSetting.list().year.unique()}" var="year">--}%
    %{--<tr>--}%
    %{--<td><label>${year}</label></td>--}%
    %{--<g:each in="${MonthSetting.list().month.unique()}" var="month">--}%
    %{--<td>${MonthSetting.findByYearAndMonth(year, month).workHoursAmt}</td>--}%
    %{--</g:each>--}%
    %{--</tr>--}%
    %{--</g:each>--}%
    %{--</tbody>--}%
    %{--</table>--}%
</div>







<asset:javascript src="lib/monthWorkDaySettingsAjax.js"/>

<script>
    function passGet() {
        getWorkDaysInMonth("${createLink(controller: 'admin', action: 'getWorkDaysInMonth')}");
    }
    function passSet() {
        setWorkDaysInMonth("${createLink(controller: 'admin', action: 'setMonthWorkDays')}")
    }

</script>
</body>
</html>
