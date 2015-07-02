class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  has_many :daily_collections, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :bulk_imports, dependent: :destroy
end
