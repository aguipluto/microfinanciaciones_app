require 'spec_helper'

describe "proyectos/show" do
  before(:each) do
    @proyecto = assign(:proyecto, stub_model(Proyecto,
      :nombre => "Nombre",
      :lugar => "Lugar",
      :descripcion_corta => "Descripcion Corta",
      :descripcion_larga => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/Lugar/)
    rendered.should match(/Descripcion Corta/)
    rendered.should match(/MyText/)
  end
end
