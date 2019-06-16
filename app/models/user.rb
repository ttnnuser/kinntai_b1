class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100 },
             format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    validates :department, length: { in: 3..50 }, allow_blank: true
    has_many :attendances, dependent: :destroy

  def self.search(search)
      if search
        where(['name LIKE ?', "%#{search}%"])
      else
          all
      end
  end
  def self.import(file)
      user = find_by(id: row["id"]) || new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
  end
  def self.updatable_attributes
      ["id", "name", "email",]
  end
end
