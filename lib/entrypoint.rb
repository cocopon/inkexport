module Inkexport

require 'optparse'
require File.join(ROOT_DIR, 'exporter')
require File.join(ROOT_DIR, 'extractor')

class EntryPoint
	def EntryPoint.run()
		# TODO: Create an Inkscape finder class
		inkscape_path = `which inkscape`
		if inkscape_path.empty?()
			inkscape_path = '/Applications/Inkscape.app/Contents/Resources/bin/inkscape'
		end

		actual_dpi = nil
		input_path = nil
		output_dir = nil

		opt = OptionParser.new()
		opt.on('--inkscape=<path>', 'Inkscape used to extract') {|v| inkscape_path = v}
		opt.on('--actual-dpi=<dpi>', 'Actual DPI of @1x image') {|v| actual_dpi = v}
		opt.on('-f', '--file=<path>', 'Input file') {|v| input_path = v}
		opt.on('-o', '--output-dir=<path>', 'Output directory') {|v| output_dir = v}
		argv = opt.parse!(ARGV)

		if input_path == nil
			puts opt.help()
			exit()
		end

		extractor = Extractor.new(input_path)
		targets = extractor.extract()

		exporter = Exporter.new(inkscape_path, input_path)
		exporter.actual_dpi = actual_dpi.to_i() if actual_dpi != nil
		exporter.output_dir = output_dir if output_dir != nil

		exporter.export_targets(targets)
	end
end

end
