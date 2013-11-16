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
      before { sign_in user }


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

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "session_email",    with: user.email
          fill_in "session_password", with: user.password
          click_button "Iniciar sesión"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Editar Perfil')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Iniciar sesión') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Iniciar sesión') }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end


    end

  end
end