class Heroe < ApplicationRecord
	
	validates :name, :real_name, :species, uniqueness: true
end
