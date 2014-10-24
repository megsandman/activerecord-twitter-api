require 'default_value_for'
require_relative '../../config/application'

class Todo < ActiveRecord::Base

  def self.view_list
   # Todo.where(complete
   array=[]
   Todo.all.each {|object| array << [object.name, object.complete]}
   array
  end
  def self.add_todo(item)
    todoItem = Todo.new(name: item.join(" "))
    todoItem.save
    todoItem.name
  end

  def self.delete_todo(item)

    index = item.first.to_i
    itemToDelete = Todo.all[index - 1]
    itemToDelete.destroy

  end
  def self.complete_todo(item)

    index = item.first.to_i
    itemToComplete = Todo.all[index - 1]
    Todo.update(itemToComplete.id, complete: 1)
    itemToComplete.name

  end

end
