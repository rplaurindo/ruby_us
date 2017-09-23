class Array

  def intersection list
    all = [list].push self

    smaller = (all = all.sort do |first, second|
      first.count <=> second.count
    end).first

    larger = all[1]

    smaller.select do |item|
      larger.include? item
    end.uniq
  end

  def intersections *lists
    all = lists.push(self)

    smaller = all.sort do |first, second|
      first.count <=> second.count
    end.first

    all.delete smaller

    intersections = smaller.intersection(all.first)

    lists.reduce do |list|
      intersections = intersections.intersection list
    end
  end

end
