/**
 *
 * @param start - existing shift start
 * @param end - existing shift end
 * @param updateBegin - begin after drop
 * @param updateEnd - end after drop
 * @param userId
 * @param link - link on the controller
 * @param isAdmin
 */

function editSchedule(start, end, updateBegin, updateEnd, userId, link, isAdmin) {

    var minDate = moment().startOf('day');
    if (!isAdmin) {
        if (minDate > start) {
            $("#calendar").fullCalendar('unselect');
            return;
        }
    }
    var existingShift = {
        begin: start._d.getTime(),
        end: end._d.getTime(),
        isHoliday: !start.hasTime() && !end.hasTime()
    };


    var updatedShift;
    updatedShift = {
        begin: updateBegin._d.getTime(),
        end: updateEnd._d.getTime(),
        isHoliday: !updateBegin.hasTime() && !updateEnd.hasTime()
    };

    console.log(existingShift);
    console.log(updatedShift);

    $.ajax({
        url: link,
        data: {
            upShift: JSON.stringify(updatedShift),
            exShift: JSON.stringify(existingShift),
            id: userId
        },
        method: 'POST',
        success: function (data) {
        },
        error: function (xhr) {
            alertBox(true, JSON.parse(xhr.responseText).message);
            $("#calendar").fullCalendar('unselect');

        }
    });

}


/**
 * @desc submitting and resizing schedule
 * @param start
 * @param end
 * @param link
 * @param userId
 * @param isAdmin
 */



function submitOrResizeSchedule(start, end, link, userId, isAdmin) {
    var minDate = moment().startOf('day');
    if (!isAdmin) {
        if (minDate > start) {
            $("#calendar").fullCalendar('unselect');
            return;
        }
    }
    var isHoliday = !start.hasTime() && !end.hasTime();
    var uhl = parseInt($('#amountHolidaysLeft').text());

    if (isHoliday && uhl == 0) {
        alert("No more holidays available");
        $("#calendar").fullCalendar('unselect');
        return;
    }

    var hour = (new Date(end).getTime() / 1000 - new Date(start).getTime() / 1000) / 60;

    hour /= 60;
    var title = parseFloat(hour) + ' hours ';
    if (title.substring(0,2) === '24') {
        title = 'set as holiday';
    }


    var eventData;
    if (title) {
        eventData = {
            title: title,
            start: start,
            end: end
        };

    }
    $('#calendar').fullCalendar('unselect');

    var shift;
    shift = {
        begin: start._d.getTime(),
        end: end._d.getTime(),
        isHoliday: !start.hasTime() && !end.hasTime()
    };

    console.log(start);

    $.ajax({
        url: link,
        data: {
            shift: JSON.stringify(shift),
            id: userId
        },
        method: 'POST',
        success: function (data) {
            eventData.id=data.id;
            $('#calendar').fullCalendar('renderEvent', eventData, true);

            document.getElementById('hltwitm').innerHTML = data.hoursLeft + '';
            document.getElementById('overWorkedHoursLabel').innerHTML = data.overWorkedHours + '';
            document.getElementById('hoursWorkedLbl').innerHTML = data.hoursWorked + '';
            if (isHoliday) {
                uhl--;
                console.log(uhl);
                document.getElementById('amountHolidaysLeft').innerHTML = uhl + '';
            }


        },
        error: function (xhr) {
            alertBox(true, JSON.parse(xhr.responseText).message);
        }
    });

}

function removeShift(calEvent, link, userId, isAdmin) {
    var start = calEvent.start;
    var cend = calEvent.end;
    var isHoliday;
    try {
        isHoliday = !calEvent.start.hasTime() && !calEvent.end.hasTime();
    }catch (error){
        isHoliday = cend==null;
    }
    var minDate = moment().startOf('day');
    if (!isAdmin) {
        if (minDate > start) {
            $("#calendar").fullCalendar('unselect');
            return;
        }
    }

    var r = confirm("Delete?");
    if (r === true) {
        var end;
        try {
            end = calEvent.end._d.getTime();
        } catch (error){
            end = calEvent.start._d.getTime() + 1800000
        }

        $('#calendar').fullCalendar('removeEvents', calEvent._id);
        var shift = {
            begin: calEvent.start._d.getTime(),
            end: end,
            isHoliday: isHoliday
        };
        $.ajax({
            url: link,
            data: {
                shift: JSON.stringify(shift),
                id: userId
            },
            method: 'POST',
            success: function (data) {
                console.log(data.hoursLeft);
                document.getElementById('hltwitm').innerHTML = data.hoursLeft + '';
                document.getElementById('overWorkedHoursLabel').innerHTML = data.overWorkedHours + '';
                document.getElementById('hoursWorkedLbl').innerHTML = data.hoursWorked + '';

                if (isHoliday) {
                    var uhl = parseInt($('#amountHolidaysLeft').text());
                    uhl++;
                    console.log(uhl);
                    document.getElementById('amountHolidaysLeft').innerHTML = uhl + '';
                }
            },
            error: function () {
                alertBox(true, "Something is wrong");
            }
        });
    }

}

