class Suggest < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  belongs_to :user

  validates :name, presence: true, length: {minimum: 3}
  validates :suggestion, presence: true, length: {minimum: 5}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: {with: VALID_EMAIL_REGEX}

  def assign_class
    if self.shown?
      'suggest-shown'
    end
  end

  def self.search(search)
    if search
      where('name LIKE ? OR tel LIKE ? OR email LIKE ? OR title LIKE ? OR suggestion LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def answered?
    !answer.nil?
  end

  def as_json(options = { })
    h = super(options)
    h[:createdAt]   = created_at.strftime("%d/%m/%Y %H:%M")
    h
  end


end
