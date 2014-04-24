class Product < ActiveRecord::Base

	validates :title, :description, :image_url, :price, presence: true
	validates :price, numericality: {greater_than: 1}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {with: %r{\.(gif|jpg|png)$}i, message: 'must be a URL for gif,jpg or png image'}
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	private
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
		return true
		else
		errors.add(:base, 'Line Items present')
		return false
		end
	end
end