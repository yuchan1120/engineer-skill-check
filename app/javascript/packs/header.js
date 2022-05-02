(function () {
  document.addEventListener('DOMContentLoaded', function() {
    const btn = document.getElementById('dropdown__btn');
    if(btn) { // ボタンが存在しないときにエラーになるのを回避
      btn.addEventListener('click', function() {
        const element = document.getElementById('dropdown_menu');
        element.classList.toggle('is-open');
      });
    }
  });
}());
