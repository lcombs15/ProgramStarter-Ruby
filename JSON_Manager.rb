#!/usr/bin/ruby

require 'JSON'
require_relative 'Task'

$TASK_FILE = "tasks.JSON"

def writeJSONFile(filePath, hash)
	file = File.new(filePath, 'w')
	file.print(JSON.pretty_generate(hash))
	file.close()
end

def getTasksFromJSON(filePath)
	retVal = []
	JSON.parse(File.new(filePath).read)["Tasks"].each do |task|
		retVal.push(Task.fromJSON(task))
	end
	return retVal
end