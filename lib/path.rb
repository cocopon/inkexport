module Inkexport


class Path
	def self.escape(path, quote = true )
		if path[0..1] == '"'
			return path
		end

		# See `man bash` - QUOTING
		escaped_path = path.strip.gsub(/(["$'\\` ()])/) {"\\#{$1}"}
		if quote
			return "\"" + escaped_path + "\""
		else 
			return escaped_path
		end
	end
end


end
