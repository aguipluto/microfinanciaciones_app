class Volunteer < ActiveRecord::Base
  belongs_to :user
  belongs_to :proyecto

  validates_presence_of :user
  validates_presence_of :proyecto

  default_scope -> { order('volunteers.created_at DESC') }

  def self.search(search)
    if search
      where('users.name LIKE ? OR users.family_name LIKE ? OR proyectos.titulo LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
    else
      all
    end
  end
end
