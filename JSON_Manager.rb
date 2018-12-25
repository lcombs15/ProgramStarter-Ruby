#!/usr/bin/ruby

require 'JSON'

def writeJSONFile(filePath, hash)
	file = File.new(filePath, 'w')
	file.print(JSON.pretty_generate(hash))
	file.close()
end