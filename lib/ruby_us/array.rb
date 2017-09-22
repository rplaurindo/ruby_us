class Array

  def intersection list
    self.select do |item|
      list.include? item
    end.uniq
  end

  def intersections *lists
    all = lists.push(self)

    smaller = all.sort do |a, b|
      a.count <=> b.count
    end.first

    all.delete smaller

    intersections = smaller.intersection(all.first)

    lists.reduce do |list|
      intersections = intersections.intersection list
    end
  end

end
