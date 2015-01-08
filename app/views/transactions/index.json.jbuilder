json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :file, :bank_account, :user_id
  json.url transaction_url(transaction, format: :json)
end
