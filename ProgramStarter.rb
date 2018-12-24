#!/usr/bin/ruby

require 'set'

$PROGRAM_LIST = [
	["Calculator", "calc.exe"],
	["Notes", "notepad.exe"],
]

# Make system call to generate set of open programs
def getOpenPrograms()
	programs = Set.new()
		(`TASKLIST /FO CSV`).split("\n").each do |line|
			# Put lowercase program name in set
			programs.add(line[1,line.index("\"", 1)-1].downcase())
		end
	return programs
end

# Open each program in array
$PROGRAM_LIST.each do |program|
	system("START \"#{program[0]}\" #{program[1]}")
end

# Print set of running programs
puts "Running Programs: \n #{getOpenPrograms()}"