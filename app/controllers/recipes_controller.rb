class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    before_action :authorize
    def index
        render json: Recipe.all
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user.valid?
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created
        else
            render json: {error: "Invalid user"}, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_unprocessable_entity_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end

    def record_not_found
        render json: { error: "No recipes found" }, status: :not_found
    end

    def authorize
        return render json: {error: "Invalid username or password"}, status: :unauthorized unless session.include? :user_id
    end
end
