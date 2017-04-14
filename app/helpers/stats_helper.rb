module StatsHelper

	def getData(data)
		res = [];
		data = data.map{|i| i.genre.upcase}
		data.uniq.each{|v|
			value = (data.count(v).to_f / data.size * 100).to_i
			res << {label: v, value: value}
		} 
		return res.to_json	
	end

end