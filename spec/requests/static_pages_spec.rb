# encoding: UTF-8
require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Microfinanciaciones CEU'" do
      visit '/static_pages/home'
      expect(page).to have_content('MicroFinanciaciones CEU')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("MicroFinanciaciones CEU | Home")
    end
  end

  describe "Help page" do

    it "should have the content 'Ayuda'" do
      visit '/static_pages/help'
      expect(page).to have_content('Ayuda')
    end

    it "should have the title 'Ayuda'" do
      visit '/static_pages/help'
      expect(page).to have_title("MicroFinanciaciones CEU | Ayuda")
    end

  end

  describe "About page" do

    it "should have the content '¿Quiénes somos?'" do
      visit '/static_pages/about'
      expect(page).to have_content('¿Quiénes somos?')
    end

    it "should have the title '¿Quiénes somos?'" do
      visit '/static_pages/about'
      expect(page).to have_title("MicroFinanciaciones CEU | ¿Quiénes somos?")
    end
  end

end

