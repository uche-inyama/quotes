class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:validatable
        #  :recoverable, :rememberable, 

  belongs_to :company

  def name
    email.split("@").first.capitalize
  end
end
