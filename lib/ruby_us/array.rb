class Array

  def intersection list
    self.select do |item|
      list.include? item
    end.uniq
  end

  # private :intersect

  def intersections *lists
    all = lists.push(self)

    smaller = all.sort do |a, b|
      a.count <=> b.count
    end.first

    all.delete smaller

    intersections = smaller.intersection(all.first)

    # ver possibilidade de usar reduce
    lists.each do |list|
      intersections = intersections.intersection list
    end
    intersections
  end

end

# p [1, 2, 3, 1].intersections [6, 1, 2, 5, 3], [3, 1, 2]
