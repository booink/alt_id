require "alt_id/version"
require "alt_id/active_record"
require 'openssl'
require 'base64_with_short'

module AltId
  class Error < StandardError; end

  DEFAULT_CIPHER = 'aes-128-cbc'
  
  class << self
    # @param id integer 
    # @param secret_key string Rails.application.credentials.secret_key_base
    # @param table_name optional string
    # @param application_name optional string
    def obfuscate(id, secret_key, table_name: nil, application_name: nil)
      enc = OpenSSL::Cipher.new(cipher)
      enc.encrypt

      salt = "#{table_name}-#{application_name}"

      # 鍵とIV(Initialize Vector)を PKCS#5 に従ってパスワードと salt から生成する
      key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(secret_key, salt, 2000, enc.key_len + enc.iv_len)
      key = key_iv[0, enc.key_len]
      iv = key_iv[enc.key_len, enc.iv_len]

      # 鍵とIVを設定する
      enc.key = key
      enc.iv = iv

      # 暗号化する
      encrypted_data = ""
      encrypted_data << enc.update(id.to_s)
      encrypted_data << enc.final

      # base64でエンコードする
      Base64.short_urlsafe_encode64(encrypted_data)
    end

    def deobfuscate(encoded_id, secret_key, table_name: nil, application_name: nil)
      # base64でデコードする
      decoded_encrypted_data = Base64.urlsafe_decode64(encoded_id)

      salt = "#{table_name}-#{application_name}"

      # 復号化器を作成する
      dec = OpenSSL::Cipher.new(cipher)
      dec.decrypt

      # 鍵とIV(Initialize Vector)を PKCS#5 に従ってパスワードと salt から生成する
      key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(secret_key, salt, 2000, dec.key_len + dec.iv_len)
      key = key_iv[0, dec.key_len]
      iv = key_iv[dec.key_len, dec.iv_len]

      # 鍵とIVを設定する
      dec.key = key
      dec.iv = iv

      # 復号化する
      decrypted_data = ""
      decrypted_data << dec.update(decoded_encrypted_data)
      decrypted_data << dec.final

      decrypted_data
    end

    def cipher
      DEFAULT_CIPHER
    end
  end
end
