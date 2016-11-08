module Api::V1
	class UniversesController < ApplicationController
		http_basic_authenticate_with name: "my_user", password: "my_password"

		before_action :set_universe, only: [:show, :update, :destroy]


		set_pagination_headers :widgets, only: [:index]

	  def index
	    @widgets = Widget.all.paginate(params).order("created_at desc")
	    respond_with @widgets
	  end
	  
	  # GET /Universes
	  def index
	    @universes = Universe.all
	    render json: @universes.to_json
	  end

	  # GET /universes/1
	  def show
	  	render json: @universe.to_json
	  end

	  # # PATCH/PUT /universes/1
	  def update
    	@universe.update(universe_params)
    	if @universe.update_attributes(universe_params)
				render json: @universe.to_json
			else
				render json: @universe.errors
			end
		end

		# POST /universes
		def create
			@universe = Universe.new(universe_params)
			if @universe.save
				render json: @universe.to_json
			else
				render json: @universe.errors
			end
		end

		# DELETE /heroes/1
		def destroy
			if @universe.destroy
				render plain: ""
			else
				render json: @universe.errors
			end
		end

		private
		 # Use callbacks to share common setup or constraints between actions.
    def set_universe
			@universe = Universe.find(params[:id])
    end
		# Never trust parameters from the scary internet, only allow the white list through. 
	  def universe_params
			params.require(:universe).permit(:name)
		end
	end
end