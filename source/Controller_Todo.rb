require 'active_record'
require_relative 'app/models/todo'
require_relative 'app/view/view'

class Controller_todo


  def self.parse_command_line(view,model)
    @view=view
    @model=model
    # p ARGV
    check_argument_length
    command=ARGV.shift
    data=ARGV
    case command
    when 'list'
      @view.display(@model.view_list)
    when 'add'
      @view.display_add(@model.add_todo(data))
    when "delete"
      @view.display_delete(@model.delete_todo(data))
    when "complete"
      @view.display_complete(@model.complete_todo(data))
    else


    end
  end



  private
  def self.check_argument_length
    puts "Supply a parameter" if ARGV.empty?
  end
end

Controller_todo.parse_command_line(View,Todo)
