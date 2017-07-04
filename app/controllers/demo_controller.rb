class DemoController < ApplicationController

	layout 'application'
	
	def index
	end

	def hello
		# render('hello')
		@array = [1,2,3,4,5]
		@id = params['id'].to_i
		@page = params[:page].to_i
	end

	def other_hello
		redirect_to(controller: 'demo', action: 'hello')
	end

	def lynda
		redirect_to('http://lynda.com')
	end

	def text_helpers
		
	end

	def escape_output
		
	end

	def make_error
		# My guess for the 3 most common errors:
		# render(:text => "test" # Syntax Error
		# render(:text => @something.upcase) # undefined method
		# render(:text => "1" + 1) # can't convert type
	end

	def logging
		logger.debug("This is debbug.")
		logger.info("This is info.")
		logger.warn("This is warn.")
		logger.error("This is error")
		logger.fatal("This is fatal")
		render(:text => "Logged!")
	end
end
