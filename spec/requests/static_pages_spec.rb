# encoding: UTF-8
require 'spec_helper'

describe "Static pages" do

  let(:base_title) { "MicroFinanciaciones CEU" }
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_content('MicroFinanciaciones CEU') }
    it { should have_title(full_title) }
    it { should_not have_title('| Home') }

  end


  describe "Help page" do
    before { visit help_path }
    it { should have_content('Ayuda') }
    it { should have_title(full_title('Ayuda')) }
  end

  describe " About page " do
    before { visit about_path }

    it { should have_content('¿Quiénes somos?') }
    it { should have_title(full_title('¿Quiénes somos?')) }

  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contacte con nosotros') }
    it { should have_title(full_title('Contacto')) }
  end

end

