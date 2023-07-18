module ApplicationHelper
    def gravatar_for(user, options={size: 80})
        email_address=user.email.downcase
        hash= Digest::MD5.hexdigest(email_address)
        size= options[:size]
        image_src="https://randomuser.me/api/portraits/men/28.jpg?s=#{size}"
        image_tag(image_src, alt: user.username, class: "rounded shadow mx-auto d-block")
    end
end
