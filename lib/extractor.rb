require 'rexml/document'


module Inkexport


# An extractor class that extracts target elements from a SVG file.
class Extractor
	def initialize(path)
		xml = ''
		open(path) do |file|
			xml = file.read()
		end

		@doc = REXML::Document.new(xml)
	end

	# Extracts target elements to export.
	#
	# @return [Array<REXML::Element>]
	# The array of target elements
	def extract()
		ns = @doc.root.namespace
		targets = REXML::XPath.match(@doc, "//ns:g[@inkscape:label='export']/ns:rect", {'ns' => ns})
		return targets
	end
end


end
