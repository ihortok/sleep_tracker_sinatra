function getById(id) {
  return document.getElementById(id);
}

let setSleepFinishedAt = getById('set_sleep_finished_at');
let sleepFinishedAtFormBlock = getById('sleep_finished_at_form_block');
let sleepFinishedAtHour = getById('sleep_finished_at_hour');
let sleepFinishedAtMinute = getById('sleep_finished_at_minute');

function setSleepFinishedAtedAtBlockFields() {
  let timeCurrent = new Date(Date.now());
  sleepFinishedAtHour.setAttribute('value', timeCurrent.getHours());
  sleepFinishedAtMinute.setAttribute('value', timeCurrent.getMinutes());
}

function resetSleepFinishedAtedAtBlockFields() {
  sleepFinishedAtHour.removeAttribute('value');
  sleepFinishedAtMinute.removeAttribute('value');
}

if (setSleepFinishedAt !== null) {
  setSleepFinishedAt.onclick = () => {
    sleepFinishedAtFormBlock.classList.toggle('d-none');
    setSleepFinishedAt.classList.toggle('active');

    if (setSleepFinishedAt.classList.contains('active')) {
      setSleepFinishedAtedAtBlockFields();
      setSleepFinishedAt.innerHTML = 'Reset sleep finish';
    } else {
      resetSleepFinishedAtedAtBlockFields();
      setSleepFinishedAt.innerHTML = 'Set sleep finish';
    }
  }
}
