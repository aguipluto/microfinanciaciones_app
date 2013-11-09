namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    def randomDate(params={})
      years_back = params[:year_range] || 5
      latest_year = params [:year_latest] || 0
      year = (rand * (years_back)).ceil + (Time.now.year - latest_year - years_back)
      month = (rand * 12).ceil
      day = (rand * 31).ceil
      series = [date = Time.local(year, month, day)]
      if params[:series]
        params[:series].each do |some_time_after|
          series << series.last + (rand * some_time_after).ceil
        end
        return series
      end
      date
    end


    User.create!(name: "Antonio",
                 family_name: "Aguilar Ayanz",
                 birthdate: "27/10/1988",
                 email: "aguipluto@gmail.com",
                 password: "27101988",
                 password_confirmation: "27101988",
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      family_name = Faker::Name.last_name
      birthdate = randomDate(:year_range => 60, :year_latest => 22)
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   family_name: family_name,
                   birthdate: birthdate,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   admin: false)
    end
  end
end