# -*- encoding : utf-8 -*-
class LineItem < ActiveRecord::Base
    belongs_to :product
    belongs_to :cart
end
