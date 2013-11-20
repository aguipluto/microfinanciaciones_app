class Attachment < ActiveRecord::Base
  belongs_to :proyectos
  has_attached_file :attachment, :styles => { :medium => "600x600>", :thumb => "100x100>" }
end
