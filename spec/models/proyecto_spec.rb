# encoding: utf-8
require 'spec_helper'

describe Proyecto do
  let(:admin) { FactoryGirl.create(:user, admin: true) }
  before do
    # This code is not idiomatically correct.
    @proyecto = admin.proyectos.build(titulo: "Ayuda en Sierra Leona", lugar: "Sierra Leona",
                             descripcion_corta: "Proyecto de ayuda a misioneros en SLeona",
                             descripcion_larga: "Los misioneros colaborarán con los pastores blablabla blablabla",
                             fecha_inicio: "27/10/2010", fecha_fin: "27/10/2013",
                             cantidad_total: 1000.1, inicio_aportaciones: "27/10/2009", fin_aportaciones: "27/10/2014")
  end

  subject { @proyecto }

  it { should respond_to(:titulo) }
  it { should respond_to(:lugar) }
  it { should respond_to(:descripcion_corta) }
  it { should respond_to(:descripcion_larga) }
  it { should respond_to(:fecha_inicio) }
  it { should respond_to(:fecha_fin) }
  it { should respond_to(:cantidad_total) }
  it { should respond_to(:inicio_aportaciones) }
  it { should respond_to(:fin_aportaciones) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user)}
  its(:user) { should eq admin }

  it { should be_valid }

  describe "validations" do

    describe "when titulo" do
      before { @proyecto.titulo = "abcd" }
      it { should_not be_valid }
    end

    describe "when user_id is not present" do
      before { @proyecto.user_id = nil }
      it { should_not be_valid }
    end

  end


end
