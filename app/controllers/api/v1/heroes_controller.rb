module Api::V1
	class HeroesController < ApplicationController
		http_basic_authenticate_with name: "my_user", password: "my_password"

		before_action :set_heroe, only: [:show, :update, :destroy]
	  # GET /heroes
	  def index
	    @heroes = Heroe.all.paginate(page: params[:page], per_page:10)
	    page = params[:page] if params[:page]
	    render_unauthorized(@heroes,page)
	    render json: @heroes.to_json(except: ['created_at', 'updated_at', 'universe_id', 'abilities'], :include => {:universe => {except: ['created_at', 'updated_at']}})
	    
	  end

	  # GET /heroes/1
	  def show
	  	render json: @heroe.to_json(except: ['created_at', 'updated_at', 'universe_id'], 
	    														:include => {:universe => {except: ['created_at', 'updated_at']}})
	  end

		# PATCH/PUT /heroes/1
	  def update
    	@heroe.update(heroes_params)
    	if @heroe.update_attributes(heroes_params)
				render json: @heroe.to_json(except: ['created_at', 'updated_at', 'universe_id', 'abilities'], 
	    														:include => {:universe => {except: ['created_at', 'updated_at']}})
			else
				render json: @heroe.errors
			end
		end

	  # POST /heroes/
		def create
			@heroe = Heroe.new(heroes_params)
			if @heroe.save
				render json: @heroe.to_json(except: ['created_at', 'updated_at', 'universe_id', 'abilities'], 
	    														include: {universe: {except: ['created_at', 'updated_at']}})
			else
				render json: @heroe.errors
			end
		end

		# DELETE /heroes/1
		def destroy
			if @heroe.destroy
				render plain: ""
			else
				render json: @heroe.errors
			end
		end

		private
		 # Use callbacks to share common setup or constraints between actions.
    def set_heroe
			@heroe = Heroe.find(params[:id])
    end

		# Never trust parameters from the scary internet, only allow the white list through. 
	  def heroes_params
			params.require(:heroe).permit(:name, :real_name, :universe_id, :species)
		end
	end
end