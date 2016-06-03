module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  ALERT_TYPES = [:error, :info, :success, :warning].freeze unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw('&times;'), :class => 'close', 'data-dismiss' => 'alert') +
                           msg, class: "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def get_recommended_case(recommended_case)
    @recommended_by = recommended_case
    case @recommended_by
      when 'also_bought'
        content_tag(:h2, 'С этим товаром покупают', class: ["text-center"])
      when 'interesting'
        content_tag(:h2, 'Возможно, вам это понравится', class: ["text-center"])
      when 'similar'
        content_tag(:h2, 'Похожие товары', class: ["text-center"])
      when 'popular'
        content_tag(:h2, 'Популярные товары', class: ["text-center","recommender-block-title"])
      when 'recently_viewed'
        content_tag(:h2, 'Вы недавно смотрели', class: ["text-center","recommender-block-title"])
      when 'see_also'
        content_tag(:h2, 'Посмотрите также', class: ["text-center","recommender-block-title"])
    end
  end
end
