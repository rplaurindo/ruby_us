class Array

  def intersection set
    all = [self, set]

    smaller = (all = all.sort do |first, second|
      first.count <=> second.count
    end).first

    larger = all[1]

    smaller.select do |item|
      larger.include? item
    end.uniq
  end

  def intersections *sets
    all = sets.push(self)

    smaller = all.sort do |first, second|
      first.count <=> second.count
    end.first

    all.delete smaller

    intersections = smaller.intersection(all.first)

    sets.reduce do |list|
      intersections = intersections.intersection list
    end
  end

end
