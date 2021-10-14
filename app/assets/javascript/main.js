/* ------------ base ------------ */

function getById(id) {
  return document.getElementById(id);
}

function getByClass(class_name, index = 0) {
  return document.getElementsByClassName(class_name)[index];
}

/* ------------ container height ------------ */

let content = getByClass("content");

content.style.height = `${window.innerHeight - 100}px`;

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

/* ------------ activities-char ------------ */


let activitiesChar = getById('activities-char');

if (activitiesChar !== null) {
  let dataWakeUpHour = activitiesChar.getAttribute('data-wake-up-hour');

  for (i = 0; i < 7; i++) {
    let activities_char_item = getByClass('activities-char-item', i);

    if (activities_char_item.children.length === 0) {
      continue;
    }

    for (j = 0; j < activities_char_item.children.length; j++) {
      let activity = activities_char_item.children[j],
          activityStartDay = activity.getAttribute('data-activity-start-day'),
          activityStart = activity.getAttribute('data-activity-start').split(':'),
          activityFinish = activity.getAttribute('data-activity-finish').split(':'),
          activityFinishDay = activity.getAttribute('data-activity-finish-day'),
          activityStartHour = parseInt(activityStart[0]),
          activityStartMin = parseInt(activityStart[1]),
          activityFinishHour = parseInt(activityFinish[0]),
          activityFinishMin = parseInt(activityFinish[1]);

      adaptedActivityStartHour = activityStartHour >= dataWakeUpHour ? activityStartHour - dataWakeUpHour : activityStartHour - dataWakeUpHour + 24
      adaptedActivityStartMinutes = adaptedActivityStartHour * 60 + activityStartMin
      adaptedActivityFinishHour = activityFinishHour >= dataWakeUpHour ? activityFinishHour - dataWakeUpHour : activityFinishHour - dataWakeUpHour + 24
      adaptedActivityFinishMinutes = adaptedActivityFinishHour * 60 + activityFinishMin

      if (activityStartDay !== 'yesterday') {
        activity.style.bottom = `${adaptedActivityStartMinutes / 4}px`
      }

      if (activityFinish[0].trim() === '' || activityFinishDay === 'tomorrow') {
        activity.style.top = 0;
      } else {
        if (activityStartDay !== 'yesterday') {
          activity.style.height = `${Math.ceil((adaptedActivityFinishMinutes - adaptedActivityStartMinutes) / 4 + 0.1)}px`
        } else {
          activity.style.height = `${Math.ceil(adaptedActivityFinishMinutes / 4 + 0.1)}px`
        }
      }
    }
  }
}
