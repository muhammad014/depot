class Product < ActiveRecord::Base

	#validates :title, :description,:image,  :price, presence: true
	validates :price, numericality: {greater_than: 1}
	validates :title, uniqueness: true
	#validates :image_url, allow_blank: true, format: {with: %r{\.(gif|jpg|png)$}i, message: 'must be a URL for gif,jpg or png image'}
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item
	mount_uploader :image, ImageUploader
	attr_accessible :title, :description,:image, :image_url, :price



def image_name
  File.basename(image.path || image.filename) if image 
end
def enqueue_image
    ImageWorker.perform_async(id, key) if key.present?
  end

  class ImageWorker
    include Sidekiq::Worker
    
    def perform(id, key)
      product = Product.find(id)
      product.key = key
      product.remote_image_url = product.image.direct_fog_url(with_path: true)
      product.save!
      product.update_column(:image_processed, true)
    end
  end


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
