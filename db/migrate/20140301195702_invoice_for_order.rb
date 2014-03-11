class InvoiceForOrder < ActiveRecord::Migration
  def change
    add_column :orders, :invoice_name, :string
    add_column :orders, :invoice_nif, :string
    add_column :orders, :invoice_others, :string
  end
end
