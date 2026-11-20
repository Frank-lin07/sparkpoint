document.addEventListener('DOMContentLoaded', function () {
    M.Sidenav.init(document.querySelectorAll('.sidenav'), { edge: 'left' });
      // Anime.js 1: menú (logo y enlaces entran al cargar)
    anime({
    targets: '#logo',
    translateX: [-30, 0],
    opacity: [0, 1],
    duration: 800,
    easing: 'easeOutQuad'
    });
    anime({
    targets: '.nav-casa ul li',
    translateY: [-20, 0],
    opacity: [0, 1],
    delay: anime.stagger(90, { start: 300 }),
    easing: 'easeOutQuad'
    });

  // Anime.js 2: servicios entran escalonados al aparecer en pantalla
    anime.set('.servicio-col', { opacity: 0, translateY: 40 });
    const observador = new IntersectionObserver(function (entradas) {
    if (entradas[0].isIntersecting) {
        anime({
        targets: '.servicio-col',
        translateY: [40, 0],
        opacity: [0, 1],
        delay: anime.stagger(150),
        duration: 700,
        easing: 'easeOutCubic'
        });
        observador.disconnect();
    }
    }, { threshold: 0.2 });
    observador.observe(document.getElementById('servicios'));

  // Microinteracción: la card se eleva al pasar el mouse
    document.querySelectorAll('.servicio').forEach(function (tarjeta) {
    tarjeta.addEventListener('mouseenter', function () {
        anime({ targets: tarjeta, translateY: -8, duration: 250, easing: 'easeOutQuad' });
    });
    tarjeta.addEventListener('mouseleave', function () {
        anime({ targets: tarjeta, translateY: 0, duration: 250, easing: 'easeOutQuad' });
    });
    });
});

    M.Datepicker.init(document.querySelectorAll('.datepicker'), { format: 'dd/mm/yyyy', autoClose: true });
    M.FormSelect.init(document.querySelectorAll('select'));
    M.textareaAutoResize(document.getElementById('mensaje'));

    document.getElementById('formReserva').addEventListener('submit', function (e) {
    e.preventDefault();
    M.toast({ html: 'Solicitud enviada. Te contactaremos pronto.' });
    this.reset();
    });