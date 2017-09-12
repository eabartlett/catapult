class Breed < ApplicationRecord
  has_and_belongs_to_many :tags, join_table: "breeds_tags"

  validates_presence_of :name
end
