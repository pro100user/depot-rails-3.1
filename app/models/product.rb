# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|jpeg|png)$}i,
        message: 'URL должен указывать на изображение формата GIF, JPEG или PNG.'
    }
    validates :title, :length => { :minimum => 10 }
end
