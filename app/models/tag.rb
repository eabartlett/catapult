class Tag < ApplicationRecord
  has_and_belongs_to_many :breeds, join_table: "breeds_tags"

  validates_presence_of :name
end
