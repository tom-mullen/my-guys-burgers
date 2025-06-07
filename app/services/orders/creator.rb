class Orders::Creator
  attr_reader :params, :order

  def initialize(params)
    @params = params
  end

  def call
    @order = Order.new(processed_params)
    @order.save
  end

  def success?
    @order&.persisted?
  end

  def errors
    @order&.errors || {}
  end

  private

  def processed_params
    items_keys = params[:order].keys.select { |key| key.start_with?("items_") }
    # Handle both scalar and array params
    scalar_keys = items_keys.reject { |key| key.end_with?("_ids") }
    array_keys = items_keys.select { |key| key.end_with?("_ids") }.map { |key| { key => [] } }
    
    permitted_params = params.require(:order).permit(:customer_name, *scalar_keys, *array_keys)

    # Collect all item IDs from both single values and arrays
    all_item_ids = permitted_params.to_h.each_with_object([]) do |(key, value), array|
      next unless key.start_with?("items_") && value.present?

      if value.is_a?(Array)
        array.concat(value)
      else
        array << value
      end
    end

    # Create line_items_attributes with sequential indices
    line_items_attributes = all_item_ids.each_with_index.each_with_object({}) do |(item_id, index), hash|
      hash[index] = { item_id: item_id }
    end

    # Include the original items_ params for validation and line_items_attributes for creation
    permitted_params.merge(line_items_attributes: line_items_attributes)
  end
end