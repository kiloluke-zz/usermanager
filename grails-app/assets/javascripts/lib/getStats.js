function getStats(link, userId){
    $.ajax({
        url: link,
        method: 'POST',
        data : {
            year: $('#year').val(),
            monthString: $('#month').val(),
            id: userId
        },
        success: function(data){
            console.log(data.hoursToWorkRequired);
            console.log(data.workedHours);
            console.log(data.holidaysTaken);
            console.log(data.hoursLeftToWork);
            console.log(data.overWorked);
            document.getElementById('hoursToWorkRequired').innerHTML = data.hoursToWorkRequired + '';
            document.getElementById('workedHours').innerHTML = data.workedHours + '';
            document.getElementById('holidaysTaken').innerHTML = data.holidaysTaken + '';
            document.getElementById('hoursLeftToWork').innerHTML = data.hoursLeftToWork + '';
            document.getElementById('overWorked').innerHTML = data.overWorked + '';
            // document.getElementById('workDaysInMonth').innerHTML = data.getWorkDaysInMonth + '';
           // document.getElementById('workDaysInMonthInput').value = data.getWorkDaysInMonth + '';
        }
    });

}

