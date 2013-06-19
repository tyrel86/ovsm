class SuitcasesController < ApplicationController
	def post_ids_for_current_user
		render json: { post_ids: current_user.suit_case_post_ids }
	end

	def add_post
		begin
			@suitcase = current_user.suitcases.find( params[:id] )
		rescue
			@suitcase = current_user.suitcases.first
		end
		result = @suitcase.add_post( params[:post_id].to_i )
		@suitcase.save
		render json: { result: result }
	end

	def remove_post
		begin
			@suitcase = current_user.suitcases.find( params[:id] )
		rescue
			@suitcase = current_user.suitcases.first
		end
		result = @suitcase.remove_post( params[:post_id].to_i )
		@suitcase.save
		render json: { result: result }
	end
end
