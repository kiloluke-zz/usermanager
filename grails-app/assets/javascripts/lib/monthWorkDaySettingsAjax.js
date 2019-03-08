function getWorkDaysInMonth(link){

    $.ajax({
        url: link,
        method: 'POST',
        data : {
            year: $('#year').val(),
            monthString: $('#month').val()
        },
        success: function(data){
            document.getElementById('workDaysInMonth').innerHTML = data.getWorkDaysInMonth + '';
            document.getElementById('workDaysInMonthInput').value = data.getWorkDaysInMonth + '';
        }
    });

}


function setWorkDaysInMonth(link){

    $.ajax({
        url: link,
        method: 'POST',
        data : {
            year: $('#year').val(),
            monthString: $('#month').val(),
            workDaysInMonth: $('#workDaysInMonthInput').val()
        },
        success: function(data){
           alertBox(false, data.status + '');
        }
    });


}