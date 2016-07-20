json.array!(@comments) do |comment|
  json.extract! comment, :id, :title, :body, :user, :post_id
  json.url comment_url(comment, format: :json)
end
