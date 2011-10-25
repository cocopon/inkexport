module Inkexport

# TODO: Support other environment
class BashPath
	def BashPath.compatible?(shell)
		return /bash/ =~ shell
	end

	def BashPath.escape(path)
		if path[0..1] == '"'
			return path
		end

		# See `man bash` - QUOTING
		escaped_path = path.gsub(/(["$'\\`])/) {"\\#{$1}"}
		return "\"#{escaped_path}\""
	end
end

end
