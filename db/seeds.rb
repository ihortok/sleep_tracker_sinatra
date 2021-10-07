# frozen_string_literal: true

user = User.find_or_initialize_by(email: 'test@test.com')

unless user.persisted?
  user.name = 'test'
  user.password = '123456abc@'
  user.country = 'UA'
  user.time_zone = 'Europe/Uzhgorod'

  p 'user test@test.com created' if user.save!
end

unless user.baby.present?
  baby = Baby.new(
    name: 'Jane',
    gender: 'G',
    date_of_birth: Time.current - 1.month,
    user: user,
    night_sleep_start: 23,
    night_sleep_finish: 7
  )

  p 'baby added' if baby.save!

  baby_param = baby.baby_params.new(
    weight: 2950,
    height: 510,
    measurement_date: baby.date_of_birth
  )

  p 'baby params added' if baby_param.save!
end

baby = user.baby

unless baby.sleeps.any?
  current_date = Time.current.in_time_zone(user.time_zone) - 1.day
  sleep_date = baby.date_of_birth.in_time_zone(user.time_zone) + 1.day

  # seed night sleeps
  while current_date > sleep_date
    sleep_started_at = sleep_date.change({ hour: 23, min: rand(0..59) })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + rand(7..8).hours,
      status: :finished
    )
    sleep_date += 1.day
  end

  sleep_date = baby.date_of_birth.in_time_zone(user.time_zone) + 1.day

  # seed daytime sleep
  while current_date > sleep_date
    sleep_started_at = sleep_date.change({ hour: rand(8..10), min: rand(0..59) })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 2.hours,
      status: :finished
    )
    sleep_started_at = sleep_date.change({ hour: rand(14..16), min: rand(0..59) })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 2.hours,
      status: :finished
    )
    sleep_started_at = sleep_date.change({ hour: 20, min: rand(0..59) })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 1.hours,
      status: :finished
    )
    sleep_date += 1.day
  end
end

unless baby.feedings.any?
  current_date = Time.current.in_time_zone(user.time_zone) - 4.hours
  feeding_date = baby.date_of_birth.in_time_zone(user.time_zone) + 4.hours

  # seed night feedings
  while current_date > feeding_date
    feeding_started_at = feeding_date.change({ min: rand(0..59) })
    baby.feedings.create!(
      started_at: feeding_started_at,
      finished_at: feeding_started_at + rand(15..45).minutes,
      status: :finished
    )
    feeding_date += rand(2..4).hours
  end
end
