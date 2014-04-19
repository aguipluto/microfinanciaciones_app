class Attachment < ActiveRecord::Base
  belongs_to :proyectos
  has_attached_file :attachment, :styles => {original:'600x600', small: '300x300', :thumb => "100x100>"}
  mount_uploader :image, ProjectUploader

  def as_json(options = { })
    h = super(options)
    h[:url]   = url_original
    h
  end

  def url_thumb
    self.image.url(:thumb)
  end


  def url_small
    self.image.url(:small)
  end

  def url_original
    self.image.url
  end

end
