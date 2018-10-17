import 'simplemde/dist/simplemde.min.css';
import '../css/admin.css';

import 'phoenix_html';
import SimpleMDE from 'simplemde';

function ready(fn) {
  if (document.readyState != "loading"){
    fn();
  } else {
    document.addEventListener("DOMContentLoaded", fn);
  }
}

ready(() => {
  const inputs = document.querySelectorAll('.editor');

  Array.from(inputs).forEach(input => {
    new SimpleMDE({ element: input, spellChecker: false })
  });
});
