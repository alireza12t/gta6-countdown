const release = new Date(2026, 10, 19);     // November 19, 2026, local midnight
const clock = document.querySelector(".clock");

// Four cards. Each one is two fixed halves and two flaps.
clock.innerHTML = ["DAYS", "HOURS", "MIN", "SEC"].map(label => `
  <div class="unit">
    <div class="card">
      <b class="half top"></b>
      <b class="half bottom"></b>
      <b class="half top flap"></b>
      <b class="half bottom flap"></b>
    </div>
    ${label}
  </div>`).join("");

const cards = [...clock.querySelectorAll(".card")];

function show(card, text) {
  const [top, bottom, oldTop, newBottom] = card.children;
  const old = top.textContent;
  if (old === text) return;

  top.textContent = newBottom.textContent = text;           // the new number
  bottom.textContent = oldTop.textContent = old || text;    // the old one
  if (!old) return;                                         // first paint, nothing to flip

  card.classList.add("flip");
  newBottom.onanimationend = () => {
    // Reset quietly for the next flip. Nothing moves on screen.
    bottom.textContent = oldTop.textContent = text;
    card.classList.remove("flip");
  };
}

function tick() {
  const left = Math.max(0, Math.floor((release - Date.now()) / 1000));
  const parts = [left / 86400, (left / 3600) % 24, (left / 60) % 60, left % 60];
  parts.forEach((value, i) => show(cards[i], String(Math.floor(value)).padStart(2, "0")));
}

tick();
setInterval(tick, 1000);
