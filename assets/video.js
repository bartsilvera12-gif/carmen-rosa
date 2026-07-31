/* Reproductor liviano de YouTube.
   La miniatura se carga desde i.ytimg.com y el iframe recién se inserta al hacer clic,
   así la página no arrastra el peso del player de YouTube en la primera carga. */
(function () {
  'use strict';

  function idDe(url) {
    var m = String(url || '').match(/(?:youtu\.be\/|v=|embed\/|shorts\/)([\w-]{11})/);
    return m ? m[1] : '';
  }

  document.querySelectorAll('.video-card').forEach(function (card) {
    var id = idDe(card.dataset.youtube);
    if (!id) return;

    var frame = card.querySelector('.video-card__frame');
    var trigger = card.querySelector('.video-card__trigger');
    var thumb = card.querySelector('.video-card__thumb');
    var titulo = card.dataset.titulo || 'Video oficial de Carmen Rosa';

    if (thumb) {
      thumb.src = 'https://i.ytimg.com/vi/' + id + '/maxresdefault.jpg';
      thumb.addEventListener('error', function onError() {
        thumb.removeEventListener('error', onError);
        thumb.src = 'https://i.ytimg.com/vi/' + id + '/hqdefault.jpg';
      });
    }

    if (!trigger) return;

    var reproduciendo = false;

    trigger.addEventListener('click', function () {
      var iframe = document.createElement('iframe');
      iframe.src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&rel=0';
      iframe.title = titulo;
      iframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture';
      iframe.allowFullscreen = true;
      frame.replaceChildren(iframe);
      reproduciendo = true;
      iframe.focus();
    });

    // Escape vuelve a la miniatura, igual que en el diseño original.
    window.addEventListener('keydown', function (e) {
      if (e.key !== 'Escape' || !reproduciendo) return;
      frame.replaceChildren(trigger);
      reproduciendo = false;
      trigger.focus();
    });
  });
})();
