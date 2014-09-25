module ApplicationHelper
  def url_for_twitter(user)
    "https://twitter.com/#{user.nickname}"
  end

  def url_for_symptom(symptom)
    "http://localhost:3000/users/#{symptom.user_id}/symptoms/#{symptom.id}"
  end
end
