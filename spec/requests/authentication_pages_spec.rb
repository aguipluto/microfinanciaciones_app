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
      before { click_button 'Iniciar' }

      it { should have_title('Iniciar sesión') }
      it { should have_selector('div.alert.alert-danger', text: 'no correctos') }

      describe "after visiting another page" do
        before { click_link "Página principal" }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "session_email",    with: user.email.upcase
        fill_in "session_password", with: user.password
        click_button 'Iniciar'
      end

      it { should have_title(user.name) }
      it { should have_link('Perfil',     href: user_path(user)) }
      it { should have_link('Cerrar sesión',    href: signout_path) }
      it { should_not have_link('Iniciar sesión', href: signin_path) }
    end
  end
end