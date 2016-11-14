require 'yaml'

Puppet::Functions.create_function(:to_yaml) do
  dispatch :hash_to_yaml do
    param 'Hash', :hash
  end

  dispatch :array_to_yaml do
    param 'Array', :array
  end

  def hash_to_yaml(hash)
    yaml = "%YAML 1.1\n"
    yaml << hash.to_yaml
  end

  def array_to_yaml(array)
    yaml = "%YAML 1.1\n"
    yaml << array.to_yaml
  end
end

