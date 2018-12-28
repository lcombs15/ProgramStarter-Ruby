#!/usr/bin/ruby

require 'set'
require_relative 'Task'
require_relative 'JSON_Manager'
require 'fileutils'

# Make system call to generate set of open programs
def getOpenPrograms()
	programs = Set.new()
		# Loop through CSV formatted list of tasks
		(`TASKLIST /FO CSV`).split("\n").each do |line|
			# Extract lowercase program name and add to set
			programs.add(line[1,line.index("\"", 1)-1].downcase())
		end
	return programs
end

# Output heading
puts "Task\t\tStatus"
puts "-" * 50

openPrograms = getOpenPrograms()

# Open each program in array
getTasksFromJSON($TASK_FILE).each do |program|
	print "#{program.name}:\t"
	if !openPrograms.include?(program.exe.downcase()) then
		program.start()
		print "Started"
	else
		print "***Already Running***"
	end
	
	# New line
	puts
end

sleep_time = 5
puts "Complete. Halting for #{sleep_time} second(s)..."

# Ensure console gets updated before sleep
STDOUT.flush
sleep(sleep_time)