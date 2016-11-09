class Universe < ApplicationRecord
	has_many :heroes, :dependent => :delete
	#this method will overwrite to_json to avoid code repetition.
	def as_json(options)
   options[:except] ||= [:created_at, :updated_at]
   super(options)
 	end
end
