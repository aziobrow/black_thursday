module Search

  def find_instance_by_id(list, search_id)
    search_id = search_id.to_s
    list.find do |object|
      search_id == object.id
    end
  end

  def find_instance_by_name(list, search_name)
    search_name = search_name.downcase
    list.find do |object|
      item_name = object.name.downcase
      item_name == search_name
    end
  end

end
