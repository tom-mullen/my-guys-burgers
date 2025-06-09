module OrdersHelper
  def text_field_style
    "block w-full rounded-md outline-1 outline-gray-200 -outline-offset-1 py-3.5 px-4 text-black bg-white text-xl uppercase leading-6 placeholder:text-gray-500 focus:outline-2 focus:-outline-offset-2 focus:outline-white"
  end

  def radio_button_style(category:)
    color = category == "topping" ? "red" : "white"

    base_style = "appearance-none w-5 h-5 border-2 cursor-pointer focus:outline-none checked:ring-2"
    if color == "red"
      "#{base_style} border-white checked:bg-white checked:ring-white checked:border-red"
    else
      "#{base_style} border-red checked:bg-red-600 checked:border-red-600 checked:ring-red-600 checked:ring-offset-2"
    end
  end

  def item_category_prompt(category:)
    case category
    when "main"
      "Choose your #{category}"
    when "drink", "side"
      "Pick your #{category}"
    when "topping"
      "Choose your #{category.pluralize}"
    end
  end

  def category_style(category:)
    case category
    when "main", "side", "drink"
      "bg-white text-red mt-12 max-lg:mt-6"
    when "topping"
      "border-1 border-white"
    end
  end

  def category_grid_style(category:)
    case category
    when "main"
      "grid grid-cols-2 md:grid-cols-6 "
    when "topping"
      "grid grid-cols-6 "
    when "side"
      "grid grid-cols-4 "
    when "drink"
      "grid grid-cols-2 "
    end
  end
end
