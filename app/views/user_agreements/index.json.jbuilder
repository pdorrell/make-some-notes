json.array!(@user_agreements) do |user_agreement|
  json.extract! user_agreement, :text, :published_at
  json.url user_agreement_url(user_agreement, format: :json)
end
