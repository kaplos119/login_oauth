class SearchController < ActionController::Base
	def index
		@all_states = Rails.cache.fetch("all_states",expires_in: 1.day)  do
		 State.select(:id,:name)
		end
	end

	def result
		state_id = params[:state].to_i
		state = State.find_by_id(state_id)
		@packages = {}
		unless state.blank?
			@cities = Rails.cache.fetch("package_#{state_id}_#{params[:city].downcase}",expires_in: 30.minutes) do
			 state.cities.select(:id,:name).where("name like ?","#{params[:city].downcase}%")
			end
			if !@cities.blank?
				@cities.each{|city|
					pkgs = city.packages.limit(3)
					arr = []
					pkgs.each{|package|
						arr << package.package_name
						@packages[city.name] = arr
					}
				}
			end	
		end
		respond_to do |format|
		  format.json { render json: @packages }
		end
	end
end
