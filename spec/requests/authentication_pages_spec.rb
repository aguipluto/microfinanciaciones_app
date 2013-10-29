# encoding: utf-8
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Iniciar sesión') }
    it { should have_title('Iniciar sesión') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button 'Iniciar sesión' }

      it { should have_title('Iniciar sesión') }
      it { should have_selector('div.alert.alert-danger', text: 'no correctos') }

      describe "after visiting another page" do
        before { click_link "MicroFinanciaciones CEU" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "session_email",    with: user.email.upcase
        fill_in "session_password", with: user.password
        click_button 'Iniciar sesión'
      end

      it { should have_title("Perfil de Usuario") }
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Cerrar sesión',    href: signout_path) }
      it { should_not have_button('Iniciar sesión') }

      describe "followed by signout" do
        before { click_link "Cerrar sesión" }
        it { should have_button('Iniciar sesión') }
      end
    end
  end
end