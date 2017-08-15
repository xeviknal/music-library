class Album < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
