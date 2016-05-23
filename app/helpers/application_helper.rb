module ApplicationHelper
	def render_date(date)
		date.strftime("%A, %B %d")
	end
end
