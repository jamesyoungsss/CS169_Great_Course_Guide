require 'csv'
require 'set'

class Utils
  def self.alpha_sort(list, field)
    return list.sort_by!{ |x|
      x[field].gsub(/\d+/) { |m| "0"*(6 - m.size) + m }
    }
  end

  def self.split_by_colon(course)
    index = course.index(":")
    number = course[0..(index-1)]
    title = course[(index + 2)..(course.length - 1)]
    return title, number
  end

  def self.draft_schedule
    fall_2016 = Hash.new
    spring_2017 = Hash.new
    CSV.foreach('data/DraftSchedule.csv') do |line|
      course = line[0]
      if not line[1].nil?
        fall_2016[course] = line[1]
      elsif line.length == 3
        spring_2017[course] = line[2]
      end
    end
    return [fall_2016, spring_2017]
  end

  def self.breadth_schedule
    fall_2016_breadth = Set.new
    CSV.foreach('data/fall2016breadths.csv') do |line|
      fall_2016_breadth.add(line)
    end
    return fall_2016_breadth
  end

  # def self.getLecs
  #   begin
  #     file = File.open("newFile4.csv", "w")
  #     CSV.foreach('data/fall2016breadths.csv') do |line|
  #       final = []
  #       course = line[0] + line[1]
  #       title = line[2]
  #       puts "AHH"
  #       name = line[3]
  #       puts "YOO"
  #       final << course
  #       final << title
  #       final << name
  #       file.write(final.join(",") + "\n")
  #     end
  #   rescue IOError => e
  #     puts "lol"
  #   ensure
  #     file.close unless file.nil?
  #   end
  # end

end
