#!/usr/bin/ruby

require 'json'

class Task
	attr_accessor :name, :path, :exe, :args
	
	# Constructor
	def initialize(name, path, exe, args)
		@name = name
		@path = path
		@exe = exe
		@args = args
	end
	
	# Parse JSON hash into Task object
	def self.fromJSON(json_hash)
		return Task.new(json_hash["name"], json_hash["path"], json_hash["exe"], json_hash["args"])
	end
	
	# Put all arguments in args[] into one string
	# args[] --> "args[0] args[1] ... args[n-1]"
	def argsToString()
		retVal = ""
		args.each do |arg|
			retVal += " #{arg}"
		end
		# Remove extra space on the end(s)
		return retVal.chomp()
	end
	
	# Make system call to start this Task
	def start()
		system("START \"#{@name}\" \"#{path + exe}\" #{argsToString}")
	end
end