class TableSerializer
  include JSONAPI::Serializer

  attribute :id
  attribute :number
  attribute :x, &:x_position
  attribute :y, &:y_position
  attribute :width
  attribute :height
  attribute :rotation
  attribute :fill
  attribute :table_name
  attribute :final_bill ,&:current_table_bill
  attribute :bill, &:current_table_bill
  attribute :final_bill_number, &:current_final_bill_number
  attribute :total_bill_items
end