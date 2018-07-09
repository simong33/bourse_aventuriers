class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :fullname, presence: true, length: {maximum: 65}
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :default_url => "/assets/default_image.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  def update_without_password(params, *options)
      if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
      end
      result = update_attributes(params, *options)
      clean_up_passwords
      result
    end
  
end