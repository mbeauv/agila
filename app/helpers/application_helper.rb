module ApplicationHelper

    def gravatar_for(user, size: 80, extra_class: "")
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.email, class: "gravatar" + extra_class.to_s)
    end

    # Generates the CSS class for a button based on the given style and size.
    #
    # style - The Symbol representing the button style (:primary or :alternate).
    # size - The Symbol representing the button size (:normal, :small, :large).
    #
    # Examples
    #
    #   button_class(:primary, :normal)
    #   # => "bg-blue-500 hover:bg-blue-700 text-white py-2 px-4 font-bold rounded"
    #
    #   button_class(:alternate, :small)
    #   # => "bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white border border-blue-500 hover:border-transparent py-1 px-2 font-bold rounded"
    def button_class(style, size)
        clazz_size = size == :normal ? "py-2 px-4" : "py-1 px-2"
        clazz_color = style == :primary ? "bg-blue-500 hover:bg-blue-700 text-white" : "bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white border border-blue-500 hover:border-transparent"
        clazz_extra = "font-bold rounded"
        "#{clazz_color} #{clazz_size} #{clazz_extra}"
    end

    # Generates a button link with the specified text, path, style, and size.
    #
    # @param text [String] The text to display on the button.
    # @param path [String] The URL or path the button should link to.
    # @param style [Symbol] The style of the button (default: :primary).
    # @param size [Symbol] The size of the button (default: :normal).
    # @return [String] The HTML for the button link.
    def button(text, path, style = :primary, size = :normal)
        link_to text, path, class: button_class(style, size), data: { turbolinks: false }
    end

end
