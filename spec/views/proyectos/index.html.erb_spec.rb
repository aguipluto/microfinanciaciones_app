require 'spec_helper'

describe "proyectos/index" do
  before(:each) do
    assign(:proyectos, [
      stub_model(Proyecto,
        :nombre => "Nombre",
        :lugar => "Lugar",
        :descripcion_corta => "Descripcion Corta",
        :descripcion_larga => "MyText"
      ),
      stub_model(Proyecto,
        :nombre => "Nombre",
        :lugar => "Lugar",
        :descripcion_corta => "Descripcion Corta",
        :descripcion_larga => "MyText"
      )
    ])
  end

  it "renders a list of proyectos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "Lugar".to_s, :count => 2
    assert_select "tr>td", :text => "Descripcion Corta".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
