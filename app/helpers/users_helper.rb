module UsersHelper
  # Return the Gravatar (http://gravatar.com/) for the given user
  def gravatar_for(user, size=80)
    size = 1 if size < 1
    size = 512 if size > 512

    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
