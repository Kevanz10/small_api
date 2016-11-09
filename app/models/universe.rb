class Universe < ApplicationRecord
	before_destroy :destroy_heroes
	has_many :heroes, :class_name => "Heroe", dependent: :destroy

	#this method will overwrite to_json to avoid code repetition.
	def as_json(options)
   options[:except] ||= [:created_at, :updated_at]
   super(options)
 	end

 	#method for deleting all associated models

   private

   def destroy_heroes
     self.heroes.delete_all   
   end
end
