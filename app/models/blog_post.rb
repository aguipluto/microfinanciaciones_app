class BlogPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :proyecto

  default_scope -> { order('updated_at DESC') }

  validates :title, presence: true, length: {minimum: 3}
  validates :content, presence: true, length: {minimum: 5}

  def assign_class
    if approved
      'success'
    else
      'warning'
    end
  end

  def self.search(search)
    if search
      where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def deleted_user
    self.update_attribute(:approved, false)
  end
end
