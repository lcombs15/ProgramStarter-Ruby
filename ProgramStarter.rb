#!/usr/bin/ruby

require 'set'
require_relative 'Task'
require 'fileutils'

$PROGRAM_LIST = []
$TASK_FILE = "tasks.JSON"

# Make system call to generate set of open programs
def getOpenPrograms()
	programs = Set.new()
		(`TASKLIST /FO CSV`).split("\n").each do |line|
			# Extract lowercase program name and add to set
			programs.add(line[1,line.index("\"", 1)-1].downcase())
		end
	return programs
end

JSON.parse(File.new($TASK_FILE).read).each do |task|
	$PROGRAM_LIST.push(Task.fromJSON(task))
end

openPrograms = getOpenPrograms()

# Open each program in array
$PROGRAM_LIST.each do |program|
	if !openPrograms.include?(program.exe.downcase()) then
		program.start()
		puts "Started: #{program.name}"
	else
		puts "Skipped #{program.name}, already running"
	end
end