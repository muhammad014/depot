class ImageHighlighter

	include Sidekiq::Worker

	#@queue = :product


	def self.perform(product_id)
		#@product= Product.find(product_id)
		puts "We have created resque"

	
	end


end