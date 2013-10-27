require "spec_helper"

describe ProyectosController do
  describe "routing" do

    it "routes to #index" do
      get("/proyectos").should route_to("proyectos#index")
    end

    it "routes to #new" do
      get("/proyectos/new").should route_to("proyectos#new")
    end

    it "routes to #show" do
      get("/proyectos/1").should route_to("proyectos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proyectos/1/edit").should route_to("proyectos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proyectos").should route_to("proyectos#create")
    end

    it "routes to #update" do
      put("/proyectos/1").should route_to("proyectos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proyectos/1").should route_to("proyectos#destroy", :id => "1")
    end

  end
end
