class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ownerships
  has_many :items, through: :ownerships
  has_many :wants
  has_many :want_items, through: :wants, source: :item
  has_many :carts
  has_many :cart_items, through: :carts, source: :item

  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end
  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end
  def want?(item)
    self.want_items.include?(item)
  end

  def cart(item)
    self.carts.find_or_create_by(item_id: item.id)
  end
  def uncart(item)
    cart = self.carts.find_by(item_id: item.id)
    cart.destroy if cart
  end
  def cart?(item)
    self.cart_items.include?(item)
  end
end
