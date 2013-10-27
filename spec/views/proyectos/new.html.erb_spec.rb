require 'spec_helper'

describe "proyectos/new" do
  before(:each) do
    assign(:proyecto, stub_model(Proyecto,
      :nombre => "MyString",
      :lugar => "MyString",
      :descripcion_corta => "MyString",
      :descripcion_larga => "MyText"
    ).as_new_record)
  end

  it "renders new proyecto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", proyectos_path, "post" do
      assert_select "input#proyecto_nombre[name=?]", "proyecto[nombre]"
      assert_select "input#proyecto_lugar[name=?]", "proyecto[lugar]"
      assert_select "input#proyecto_descripcion_corta[name=?]", "proyecto[descripcion_corta]"
      assert_select "textarea#proyecto_descripcion_larga[name=?]", "proyecto[descripcion_larga]"
    end
  end
end
