# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :title, uniqueness: true
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|jpeg|png)$}i,
        message: 'URL должен указывать на изображение формата GIF, JPEG или PNG.'
    }
    # validates :title, :length => { :minimum => 10 }
    validates_length_of :title, :minimum => 10, :too_short => "Должно быть минимум %{count} символов"

    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item

    private

    # Убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар.
    def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'существуют товарные позиции')
            return false
        end
    end
end
