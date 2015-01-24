json.array!(@categorizes) do |categorize|
  json.extract! categorize, :id
  json.url categorize_url(categorize, format: :json)
end
