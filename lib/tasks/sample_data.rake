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


    user = User.create!(name: "Antonio",
                        family_name: "Aguilar Ayanz",
                        birthdate: "27/10/1988",
                        email: "aguipluto@gmail.com",
                        password: "27101988",
                        password_confirmation: "27101988",
                        admin: true)
    5.times do
      titulo = Faker::Lorem.sentence(5)
      descripcion_corta = Faker::Lorem.sentence(15)
      inicio_aportaciones = rand(2.years).ago
      fin_aportaciones = rand(2.years).from_now
      cantidad_total =  rand * (100000-1000) + 1000
      user.proyectos.create!(titulo: titulo, descripcion_corta: descripcion_corta,
                             inicio_aportaciones: inicio_aportaciones, fin_aportaciones: fin_aportaciones,
                             cantidad_total: cantidad_total)
    end

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