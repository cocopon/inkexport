module Inkexport


class Path
	def self.escape(path)
		if path[0..1] == '"'
			return path
		end

		# See `man bash` - QUOTING
		escaped_path = path.gsub(/(["$'\\`])/) {"\\#{$1}"}
		return "\"#{escaped_path}\""
	end
end


end
