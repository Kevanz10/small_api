module Api::V1
	class UniversesController < ApplicationController
		http_basic_authenticate_with name: "my_user", password: "my_password"

		before_action :set_universe, only: [:show, :update, :destroy]

	  # GET /Universes
	  def index
	    @universes = Universe.all.paginate(page: params[:page], per_page:10)
	    page = params[:page] if params[:page]
	    render_unauthorized(@universes,page)
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