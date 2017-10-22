json.extract! expense, :id, :name, :type_id, :amount, :comment, :created_at, :updated_at, :category_id
json.url expense_url(expense, format: :json)
