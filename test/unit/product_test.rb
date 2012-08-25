# -*- encoding : utf-8 -*-
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    fixtures :products

    test "product attributes are not be empty" do
        #Свойства товара не должны оставаться пустыми
        product = Product.new
        assert product.invalid?
        assert product.errors[:title].any?
        assert product.errors[:description].any?
        assert product.errors[:image_url].any?
        assert product.errors[:price].any?
    end

    test "product price must be positive" do
        #Цена товара должна быть положительной
        product = Product.new(title: "My book title", description: "desc", image_url: "img.jpg")
        product.price = -1 #проверка на отрицательное значение цены
        assert product.invalid?
        assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ') #должна быть больше или равна 0.01
        product.price = 0 #проверка на ошибку, если цена = 0
        assert product.invalid?
        assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
        product.price = 1
        assert product.valid?
    end

    def new_product(image_url)
        Product.new(
            title: "My book title",
            description: "desc",
            price: 1,
            image_url: image_url)
    end

    test "image url" do
        # url изображения
        ok = %w{ freg.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/v/z/fred.gif }
        bad = %w{ fred.doc fred.gif/more fred.gif.more }

        ok.each do |name|
            assert new_product(name).valid?, "#{name} shouldn't be invalid" # не должно быть неприемлемым
        end

        bad.each do |name|
            assert new_product(name).invalid?, "#{name} shouldn't be valid" # не должно быть приемлемым
        end
    end

    test "product is not valid without a unique title" do
        # если у товара нет уникального имени, то он не допустим
        product = Product.new(title: products(:ruby).title,
            description: "yyy",
            price: 1,
            image_url: "fred.gif")
        assert !product.save
        assert_equal "has already been taken", product.errors[:title].join('; ') # уже было использовано
    end

    test "product title must be at least ten characters long" do
        product = products(:ruby)
        assert product.valid?, "product title shouldn't be invalid" 

        product.title = product.title.first(9)
        assert product.invalid?, "product title shouldn't be valid" 
    end
end
