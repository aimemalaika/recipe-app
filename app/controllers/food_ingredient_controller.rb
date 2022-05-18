class FoodIngredientController < ApplicationController
  def new
    @ingredients_food_id = Receipe.find(params[:receipe_id]).food_ingredients.pluck(:food_id)
    @food_ingredient = FoodIngredient.new
    @foods = Food.where.not(id: @ingredients_food_id)
  end

  def create
    @food_ingredient = current_user.receipes.find(params[:receipe_id]).food_ingredients.new(food_ingredient_params)
    if @food_ingredient.save
      redirect_to receipe_path(params[:receipe_id])
    else
      render :new
    end
  end

  def destroy
    @food_ingredient = FoodIngredient.find(params[:id])
    @food_ingredient.destroy
    redirect_to receipe_path(params[:receipe_id])
  end

  private

  def food_ingredient_params
    params.require(:food_ingredient).permit(:food_id, :Quantity)
  end
end