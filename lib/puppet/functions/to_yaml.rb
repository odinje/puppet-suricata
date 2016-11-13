require 'yaml'

Puppet::Functions.create_function(:to_yaml) do
  dispatch :to_yaml do
    param 'Hash', :hash
  end

  def to_yaml(hash)
    hash.to_yaml
  end

end

