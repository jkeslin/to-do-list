require 'csv'

#--------------------------------------
#--------------------------------------
class Task
	@@id = 0
	attr_reader :task_name
	attr_accessor :completion, :id

	def initialize(task = {})
		@task_name = task[:task]
		@completion = task.fetch(:completion, "incomplete")
		@id = id_generator
	end

	def task_completed?
		@completion == "complete" ? "[X]" : "[ ]"
	end

	def id_generator
		@@id += 1
	end
end

#--------------------------------------
#--------------------------------------
class List
	attr_reader :list, :file

	def initialize(file)
		@file = file
		@list = build_list(file)
	end

	def add_task(new_task)
		create_new_task_object(new_task)
		CSV.open(@file, 'a') { |to_do_list| to_do_list << [new_task,"incomplete"] }
	end

	def delete_task(requested_task_number)
		@list.each  do |task|
			if task.id == requested_task_number
				@list.delete(task)
			end
		end
		change_file_after_completing_or_deleting
		update_task_id
	end

	def mark_task_completed(task_id)
		@list.each do |task|
			if task.id == task_id
				task.completion = "complete"
			end
		end
		change_file_after_completing_or_deleting
	end

	private #------Private List Methods----------#

	def create_new_task_object(new_task)
		@list << Task.new({task: new_task})
	end

	def update_task_id
		@list.each_with_index { |task, task_index| task.id = task_index + 1 }
	end
 
	def change_file_after_completing_or_deleting
		CSV.open(@file, 'w', {:write_headers => true, headers: [:task, :completion]}) do |row|
			@list.each { |task| row << [task.task_name, task.completion] }		
		end
	end

	def build_list(file)
		list_array = []
		CSV.foreach(file, :headers => true, :header_converters => :symbol) do |row|
			list_array << Task.new(row.to_hash)
		end
		list_array
	end
end

#--------------------------------------
#--------------------------------------
class Viewer

	def display_list(to_do_list)
		puts "TO DO LIST:"
		to_do_list.each { |task| puts "#{task.task_completed?} #{task.id} #{task.task_name}" }
	end

	def list_commands
		puts "Command Options: 'display' 'add' 'delete' 'completed'"
	end
end

#--------------------------------------
#--------------------------------------
class Controller
	attr_accessor :to_do
	attr_reader :command, :requested_task_number, :given_task
	def initialize(file)
		@to_do = List.new(file)
		@list  = @to_do.list
		@view = Viewer.new
		if any_command? 
			@command = ARGV[0]
			@requested_task_number = ARGV[1].to_i
			@given_task = ARGV[1..-1].join(' ')
			execute_command
		else 
			@view.list_commands
		end
	end

	def any_command?
		ARGV.any?
	end

	def execute_command
		case @command
			when "display"
				@view.display_list(@list)
			when "add"
				@to_do.add_task(given_task)
				@view.display_list(@list)
			when "delete"
				@to_do.delete_task(requested_task_number)
				@view.display_list(@list)
			when "completed"
				@to_do.mark_task_completed(requested_task_number)
				@view.display_list(@list)
			else
				puts "Not a valid command"
		end
	end
end


#----------Driver Code------------------#

Controller.new('todo.csv')

#---------------------------------------#
