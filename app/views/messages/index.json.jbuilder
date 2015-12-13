json.array!(@messages) do |message|
  json.extract! message, :id, :content, :sender_id, :recipient_id, :is_read
  json.url message_url(message, format: :json)
end
