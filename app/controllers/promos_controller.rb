# frozen_string_literal: true

class PromosController < ApplicationController
  def index
    @promos = Promo.all
  end

  def create
    @promo = Promo.create
  end
end
