module Inkexport

#
# An exporter class that exports PNG from target elements.
#
class Exporter
	DEFAULT_ACTUAL_DPI = 90
	FILE_EXT = '.png'

	def initialize(inkscape_path, path)
		@inkscape_path = inkscape_path
		@path = path
		self.actual_dpi = DEFAULT_ACTUAL_DPI
	end

	def actual_dpi()
		return @actual_dpi
	end

	def actual_dpi=(actual_dpi)
		@actual_dpi = actual_dpi
		build_dpi_map()
	end

	def build_dpi_map()
		@dpi_map = {@actual_dpi => ''}

		other_scales = [2]
		other_scales.each do |scale|
			@dpi_map[@actual_dpi * scale] = "@#{scale}x"
		end
	end

	def export(id, export_path, dpi)
		args = []
		args << @path
		args << "--export-id=#{id}"
		args << "--export-dpi=#{dpi}"
		args << "--export-png=#{export_path}"
		p `#{@inkscape_path} #{args.join(' ')}`
	end
	private :export

	def export_target(target)
		file_name = target.attributes['inkscape:label']
		if file_name == nil
			return
		end

		@dpi_map.each do |dpi, file_postfix|
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
