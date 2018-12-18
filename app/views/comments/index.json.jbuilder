json.array!(@comments) do |comment|
    json.extrac! comment, :id, :user_id, :article_id, :body
    json.url comment_url(comment, format: :json)
end