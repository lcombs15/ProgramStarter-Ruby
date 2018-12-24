#!/usr/bin/ruby

require 'json'

class Task
	attr_accessor :name
	attr_accessor :path
	attr_accessor :exe
	attr_accessor :args
	
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
	
	# Make system call to start this Task
	def start()
		puts "Would have started: #{@name}"
	end
end