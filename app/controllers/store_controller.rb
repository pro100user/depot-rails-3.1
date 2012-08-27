# -*- encoding : utf-8 -*-
class StoreController < ApplicationController
  def visit_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end

  def index
    @products = Product.order(:title)
    @counter = visit_counter
  end
end
