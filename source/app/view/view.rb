class View
  def self.display(value)
    value.each_with_index do |v,i|
      displayString =  "#{i+1} #{v[0]}"
      if v[1] == 1
        displayString += " - Complete"
      end
      print displayString
      puts ""
    end
  end
   def self.display_add(value)
    puts "Appended \"#{value}\" to your TODO list.."
  end

   def self.display_delete(value)
    puts "Deleted \"#{value}\" from your TODO list.."
  end
  def self.display_complete(value)
    puts "Completed \"#{value}\" "
  end

end
