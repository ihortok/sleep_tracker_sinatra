/* ------------ base ------------ */

function getById(id) {
  return document.getElementById(id);
}

function getByClass(class_name, index = 0) {
  return document.getElementsByClassName(class_name)[index];
}

/* ------------ container height ------------ */

let container = getById("container");

container.style.height = `${window.innerHeight}px`;

/* ------------ activity finish form ------------ */

let setActivityFinishedAt = getById('set_activity_finished_at');
let activityFinishedAtFormBlock = getById('activity_finished_at_form_block');
let activityFinishedAtHour = getById('activity_finished_at_hour');
let activityFinishedAtMinute = getById('activity_finished_at_minute');

function setActivityFinishedAtedAtBlockFields() {
  let timeCurrent = new Date(Date.now());
  activityFinishedAtHour.setAttribute('value', timeCurrent.getHours());
  activityFinishedAtMinute.setAttribute('value', timeCurrent.getMinutes());
}

function resetActivityFinishedAtedAtBlockFields() {
  activityFinishedAtHour.removeAttribute('value');
  activityFinishedAtMinute.removeAttribute('value');
}

if (setActivityFinishedAt !== null) {
  setActivityFinishedAt.onclick = () => {
    activityFinishedAtFormBlock.classList.toggle('d-none');
    setActivityFinishedAt.classList.toggle('active');

    if (setActivityFinishedAt.classList.contains('active')) {
      setActivityFinishedAtedAtBlockFields();
      setActivityFinishedAt.innerHTML = 'Reset activity finish';
    } else {
      resetActivityFinishedAtedAtBlockFields();
      setActivityFinishedAt.innerHTML = 'Set activity finish';
    }
  }
}

/* ------------ sleeps-char ------------ */

let dataWakeUpHour = getById('sleeps-char').getAttribute('data-wake-up-hour');

for (i = 0; i < 7; i++) {
  let sleeps_char_item = getByClass('sleeps-char-item', i);

  if (sleeps_char_item.children.length === 0) {
    continue;
  }

  for (j = 0; j < sleeps_char_item.children.length; j++) {
    let activity = sleeps_char_item.children[j],
        activityStart = activity.getAttribute('data-sleep-start').split(':'),
        activityFinish = activity.getAttribute('data-sleep-finish').split(':'),
        activityStartHour = parseInt(activityStart[0]),
        activityStartMin = parseInt(activityStart[1]),
        activityFinishHour = parseInt(activityFinish[0]),
        activityFinishMin = parseInt(activityFinish[1]);

    adaptedActivityStartHour = activityStartHour >= dataWakeUpHour ? activityStartHour - dataWakeUpHour : activityStartHour - dataWakeUpHour + 24
    adaptedActivityFinishHour = activityFinishHour >= dataWakeUpHour ? activityFinishHour - dataWakeUpHour : activityFinishHour - dataWakeUpHour + 24

    if (activityStart[0].trim() !== '') {
      activity.style.bottom = `${((adaptedActivityStartHour) * 15) + Math.ceil(activityStartMin/15)}px`
    }

    if (activityFinish[0].trim() !== '') {
      if (activityStart[0].trim() !== '') {
        activity.style.height = `${((adaptedActivityFinishHour - adaptedActivityStartHour) * 15) + Math.ceil(activityFinishMin*15/60)}px`
      } else {
        activity.style.height = `${((adaptedActivityFinishHour) * 15) + Math.ceil(activityFinishMin*15/60)}px`
      }
    } else {
      activity.style.top = 0
    }
  }
}
