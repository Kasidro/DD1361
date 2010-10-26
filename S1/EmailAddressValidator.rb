class EmailAddressValidator
  def validate(email)

    if email.match(/^\..*$/) != nil
      return false
    end

    if email.match(/\.@/) != nil
      return false
    end

    email.match(/^[a-z0-9!#\$%\*\/\?\|\^{}\.`~&'\+\-=_]+@([a-z0-9]+\.)+(com|org|net|nu|se)$/i) != nil
  end
end

if __FILE__ == $0
  validator = EmailAddressValidator.new

  while email = $stdin.gets
    if validator.validate email
      puts $DEBUG ? email.chomp + ": YES" : "YES"
    else
      puts $DEBUG ? email.chomp + ": NO" : "NO"
    end
  end
end
