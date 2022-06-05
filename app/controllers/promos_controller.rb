class PromosController < ApplicationController
  def index
    @promos= Promo.all()
  end

  def create
    p "in promo controller"
    p params
    @promo=Promo.create()
  end
end
