document.addEventListener('DOMContentLoaded', function () {
    M.Sidenav.init(document.querySelectorAll('.sidenav'), { edge: 'left' });
});

    M.Datepicker.init(document.querySelectorAll('.datepicker'), { format: 'dd/mm/yyyy', autoClose: true });
    M.FormSelect.init(document.querySelectorAll('select'));
    M.textareaAutoResize(document.getElementById('mensaje'));

    document.getElementById('formReserva').addEventListener('submit', function (e) {
    e.preventDefault();
    M.toast({ html: 'Solicitud enviada. Te contactaremos pronto.' });
    this.reset();
    });