require 'spec_helper'

describe "proyectos/edit" do
  before(:each) do
    @proyecto = assign(:proyecto, stub_model(Proyecto,
      :nombre => "MyString",
      :lugar => "MyString",
      :descripcion_corta => "MyString",
      :descripcion_larga => "MyText"
    ))
  end

  it "renders the edit proyecto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", proyecto_path(@proyecto), "post" do
      assert_select "input#proyecto_nombre[name=?]", "proyecto[nombre]"
      assert_select "input#proyecto_lugar[name=?]", "proyecto[lugar]"
      assert_select "input#proyecto_descripcion_corta[name=?]", "proyecto[descripcion_corta]"
      assert_select "textarea#proyecto_descripcion_larga[name=?]", "proyecto[descripcion_larga]"
    end
  end
end
