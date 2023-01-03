class Nameable
  def correct_name
    raise NotImplementedError, "Implementation of #{__method__} in class #{self.class} not successful"
  end
end
