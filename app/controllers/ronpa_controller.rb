class RonpaController < ApplicationController
  def index
    @tool_tip = 'The word between *[ and ] color as weak point. '
    @tool_tip += 'Use tab key to color text selection.'
    @characters = Dir.glob("#{Rails.root}/app/assets/images/ronpa/*.png")
    @characters.map { |e| e.gsub! "#{Rails.root}/app/assets/images/", '' }
    @characters.sort!
  end
end
