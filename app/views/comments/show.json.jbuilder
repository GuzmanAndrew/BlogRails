json.extract! @comment, :id, :user_id, :article_id, :body, :créate_at, :update_at
json.user do
  json.mail @comment.user.email
end