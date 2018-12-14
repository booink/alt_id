# https://qiita.com/awakia/items/049791daca69120d7035#おまけパディングのをなくして少し短くする

require 'base64'

module Base64
  def self.short_urlsafe_encode64(str)
    urlsafe_encode64(str).delete('=')
  end

  def self.short_urlsafe_decode64(str)
    urlsafe_decode64(str + '=' * (-1 * str.size & 3))
  end
end