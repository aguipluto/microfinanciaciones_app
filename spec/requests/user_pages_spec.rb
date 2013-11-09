# encoding: utf-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title('Perfil de Usuario') }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Registrar" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name", with: "Example User"
        fill_in "user_family_name", with: "Example User"
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title("Perfil de Usuario") }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Editar Perfil") }
      it { should have_title("Editar Perfil") }
    end

    describe "with invalid information" do
      before { click_button "Guardar cambios" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_family_name) { "New FamilyName" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "user_name", with: new_name
        fill_in "user_family_name", with: new_family_name
        fill_in "user_email", with: new_email
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password

        click_button "Guardar cambios"
      end

      it { should have_title("Perfil de Usuario") }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

  end

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('Usuarios') }
    it { should have_content('Usuarios') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

  describe "delete links" do

    it { should_not have_link('Borrar') }

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end

      it { should have_link('Borrar', href: user_path(User.first)) }
      it "should be able to delete another user" do
        expect do
          click_link('Borrar', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('Borrar', href: user_path(admin)) }
    end
  end
end


end