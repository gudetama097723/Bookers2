import Raty from "raty-js"

document.addEventListener("turbo:load", () => {

  const elem = document.querySelector("#post_raty");
  if (elem) {
    new Raty(elem, {
      starOn: "https://cdn.jsdelivr.net/npm/raty-js/lib/images/star-on.png",
      starOff: "https://cdn.jsdelivr.net/npm/raty-js/lib/images/star-off.png",
      scoreName: "book[rating]"
    }).init();
  }

  document.querySelectorAll(".raty-readonly").forEach((elem) => {
    new Raty(elem, {
      readOnly: true,
      score: elem.dataset.score,
      starOn: "https://cdn.jsdelivr.net/npm/raty-js/lib/images/star-on.png",
      starOff: "https://cdn.jsdelivr.net/npm/raty-js/lib/images/star-off.png"
    }).init();
  });
});