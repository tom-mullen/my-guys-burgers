class Orders::Creator
  attr_reader :joint, :params, :order

  def initialize(joint:, params:)
    @joint = joint
    @params = params
  end

  def call
    @order = joint.orders.new(processed_params)
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
    permitted_params.merge(line_items_attributes: line_items_attributes)
  end

  def line_items_attributes
    all_item_ids.each_with_index.each_with_object({}) do |(item_id, index), hash|
      hash[index] = { item_id: item_id }
    end
  end

  def all_item_ids
    permitted_params.to_h.each_with_object([]) do |(key, value), array|
      next unless key.start_with?("items_") && value.present?

      if value.is_a?(Array)
        array.concat(value)
      else
        array << value
      end
    end
  end

  def permitted_params
    @permitted_params ||= params.require(:order).permit(:customer_name, *scalar_keys, *array_keys)
  end

  def items_keys
    params[:order].keys.select { |key| key.start_with?("items_") }
  end

  def scalar_keys
    items_keys.reject { |key| key.end_with?("_ids") }
  end

  def array_keys
    items_keys.select { |key| key.end_with?("_ids") }.map { |key| { key => [] } }
  end
end
