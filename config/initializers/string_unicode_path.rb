# frozen_string_literal: true

class String
  def downcase
    if !frozen?
      Unicode.downcase(force_encoding('utf-8'))
    else
      Unicode.downcase(self)
    end
  end

  def downcase!
    replace(downcase)
  end

  def upcase
    if !frozen?
      Unicode.upcase(force_encoding('utf-8'))
    else
      Unicode.upcase(self)
    end
  end

  def upcase!
    replace upcase
  end

  def capitalize
    if !frozen?
      Unicode.capitalize(force_encoding('utf-8'))
    else
      Unicode.capitalize(self)
    end
  end

  def capitalize!
    replace capitalize
  end
end
