module LocationsHelper
	# Returns the CSS style associate with the give status
	def status_css_class(status)
		["OK", "On"].include?(status) ? "status-success" : "status-error"
	end
end
