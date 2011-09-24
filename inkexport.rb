#!/usr/bin/ruby

require './inkexport/exporter'
require './inkexport/extractor'

if ARGV.length() == 0
	puts 'Usage: inkexport.rb [file]'
else
	path = ARGV[0]
	extractor = Inkexport::Extractor.new(path)
	targets = extractor.extract()

	exporter = Inkexport::Exporter.new(path)
	exporter.export_targets(targets)
end

