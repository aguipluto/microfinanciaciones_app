class AddPaperclipAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :attachments, :attachment
  end

  def self.down
    remove_attachment :attachments, :attachment
  end
end
