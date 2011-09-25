module Inkexport

#
# An exporter class that exports PNG from target elements.
#
class Exporter
	DPI_MAP = {90 => '', 180 => '@2x'}
	FILE_EXT = '.png'

	def initialize(inkscape_path, path)
		@inkscape_path = inkscape_path
		@path = path
	end

	def find_inkscape()
		which_result = `which ruby`.chomp()
		if which_result != nil
			return which_result
		end

	end

	def export(id, export_path, dpi)
		args = []
		args << @path
		args << "--export-id=#{id}"
		args << "--export-dpi=#{dpi}"
		args << "--export-png=#{export_path}"
		p "#{@inkscape_path} #{args.join(' ')}"
	end
	private :export

	def export_target(target)
		file_name = target.attributes['inkscape:label']
		if file_name == nil
			return
		end

		DPI_MAP.each do |dpi, file_postfix|
			export_path = file_name + file_postfix + FILE_EXT

			target_id = target.attributes['id']
			export(target_id, export_path, dpi)
		end
	end
	private :export_target

	# 
	# Exports PNGs using specified elements.
	#
	# @param [Array<REXML::Element>] targets
	# The array of target elements to export
	# 
	def export_targets(targets)
		targets.each do |target|
			export_target(target)
		end
	end
end

end
