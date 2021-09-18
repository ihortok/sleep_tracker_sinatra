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
  current_date = Time.current
  sleep_date = baby.date_of_birth

  # seed night sleeps
  while current_date > sleep_date
    sleep_started_at = (sleep_date + 1.day).change({ hour: 23 })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 8.hours,
      status: :finished
    )
    sleep_date += 1.day
  end

  sleep_date = baby.date_of_birth

  # seed daytime sleep
  while current_date > sleep_date
    sleep_started_at = (sleep_date + 1.day).change({ hour: 10 })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 2.hours,
      status: :finished
    )
    sleep_started_at = (sleep_date + 1.day).change({ hour: 15 })
    baby.sleeps.create!(
      started_at: sleep_started_at,
      finished_at: sleep_started_at + 2.hours,
      status: :finished
    )
    sleep_date += 1.day
  end
end
