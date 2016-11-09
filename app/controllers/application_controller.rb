class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Basic::ControllerMethods
	protected

	#method for the response at header
	def render_unauthorized(universe,page)
  	self.headers['X-Total'] = "#{universe.count}"
  	self.headers['X-Total-Pages'] = "#{(headers['X-Total'].to_f/10).ceil}"
  	if !params[:page].nil?
  		self.headers['X-Page'] = params[:page]
  		current = "#{headers['X-Page']}".to_i
  		total = "#{headers['X-Total-Pages']}".to_i
  		if ( current < total )
  			self.headers['X-Next-Page'] = current.to_i + 1 
  		elsif ( current > total )
  			self.headers['X-Next-Page'] = total
  		else
  			self.headers['X-Next-Page'] = current
  		end
  		if ( current < total ) && (current > 1)
  			self.headers['X-Prev-Page'] = current.to_i - 1 
  		elsif ( current >= 2 ) && (current <= total)
  			self.headers['X-Prev-Page'] = total - 1
  		elsif (current > total)
  			self.headers['X-Prev-Page'] = total
  		elsif (current == 1)
  			self.headers['X-Prev-Page'] = 1
  		end
  	else
  		self.headers['X-Next-Page'] = 1
  		self.headers['X-Page'] = 1
  		self.headers['X-Prev-Page'] = 1
  	end
  	self.headers['X-Per-Page'] = 10
  	
	end
end


