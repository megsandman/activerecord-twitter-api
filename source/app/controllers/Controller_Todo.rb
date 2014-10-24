require 'active_record'
require_relative '../models/todo'
require_relative '../view/view'

class Controller_todo


  def self.parse_command_line(view,model)
    @view=view
    @model=model
    # p ARGV
    check_argument_length
    command=ARGV[0]
    case command
    when 'list'
      @view.display(@model.list_todo)
    else

    end
  end



  private
  def self.check_argument_length
    puts "Supply a parameter" if ARGV.empty?
  end
end

Controller_todo.parse_command_line(View,Todo)
