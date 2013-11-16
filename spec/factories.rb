# encoding: utf-8
FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    family_name "Aguilar"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end

  factory :proyecto do
    titulo "Ayuda en Sierra Leona"
    lugar "Sierra Leona"
    descripcion_corta "Proyecto de ayuda a misioneros en SLeona"
    descripcion_larga "Los misioneros colaborarán con los pastores blablabla blablabla"
    fecha_inicio "27/10/2010"
    fecha_fin "27/10/2013"
    cantidad_total 1000.1
    inicio_aportaciones "27/10/2009"
    user
  end
end