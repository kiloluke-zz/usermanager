function alertBox(isFailed, message) {
    if (isFailed) {
        document.getElementById('errorMessage').innerHTML = message + '';
        $('#responseError').fadeIn(100).delay(1000).fadeOut(100);
    } else {
        document.getElementById('successMessage').innerHTML = message + '';
        $('#responseSuccess').fadeIn(100).delay(1000).fadeOut(100);
    }
}