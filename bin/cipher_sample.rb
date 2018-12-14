# https://docs.ruby-lang.org/ja/latest/class/OpenSSL=3a=3aCipher.html

require 'openssl'
require 'base64'

ciphers = `openssl list-cipher-commands`.split(/\n/)

# 暗号化するデータ
data = ARGV[0]
# パスワード
pass = "users-testapp"
# salt
salt = OpenSSL::Random.random_bytes(8)

# 暗号化器を作成する
ciphers.each do |cipher|
  error = nil
  begin
    enc = OpenSSL::Cipher.new(cipher)
    enc.encrypt
    # 鍵とIV(Initialize Vector)を PKCS#5 に従ってパスワードと salt から生成する
    #key_iv = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, salt, 2000, enc.key_len + enc.iv_len)
    #key = key_iv[0, enc.key_len]
    #iv = key_iv[enc.key_len, enc.iv_len]
    key = "a" * enc.key_len
    iv = "a" * enc.iv_len
    # 鍵とIVを設定する
    enc.key = key
    enc.iv = iv

    # 暗号化する
    encrypted_data = ""
    encrypted_data << enc.update(data)
    encrypted_data << enc.final

    # base64でエンコードデコードしてみる
    encoded = Base64.urlsafe_encode64(encrypted_data)
    decoded_encrypted_data = Base64.urlsafe_decode64(encoded)

    # 復号化器を作成する
    dec = OpenSSL::Cipher.new(cipher)
    dec.decrypt

    # 鍵とIVを設定する
    dec.key = key
    dec.iv = iv

    # 復号化する
    decrypted_data = ""
    decrypted_data << dec.update(decoded_encrypted_data)
    decrypted_data << dec.final
  rescue => e
    error = e.message
    encrypted_data = ""
    decrypted_data = ""
  ensure
    puts cipher
    if error.nil?
      puts "\tencrypt: " + encrypted_data.inspect
      puts "\tencode :  " + encoded
      puts "\tdecrypt: " + decrypted_data.inspect
    else
      puts "\terror  : " + error
    end
  end
end