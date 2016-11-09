class Heroe < ApplicationRecord
	serialize :abilities, Array
	belongs_to :universe
	validates :name, :real_name, :species, uniqueness: true
end
