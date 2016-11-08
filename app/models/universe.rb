class Universe < ApplicationRecord
	#this method will overwrite to_json to avoid code repetition.
	def as_json(options)
   options[:except] ||= [:created_at, :updated_at]
   super(options)
 	end
end
