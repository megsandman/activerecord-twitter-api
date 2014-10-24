require_relative '../app/models/todo'



module TodoListImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/list.csv")
    field_names = nil
    Todo.transaction do
      File.open(filename).each do |line|
        data = line.chomp.split(',')
        if field_names.nil?
          field_names = data
        else
          p field_names
          attribute_hash = Hash[field_names.zip(data)]
          todo = Todo.create!(attribute_hash)
        end
      end
    end
  end
end
