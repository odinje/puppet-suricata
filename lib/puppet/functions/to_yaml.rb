require 'yaml'

Puppet::Functions.create_function(:to_yaml) do
  dispatch :hash_to_yaml do
    param 'Hash', :hash
  end

  dispatch :array_to_yaml do
    param 'Array', :array
  end

  def hash_to_yaml(hash)
    hash.to_yaml( :Indent => 4, :UseHeader => true, :UseVersion => true )
  end

  def array_to_yaml(array)
    array.to_yaml( :Indent => 4, :UseHeader => true, :UseVersion => true )
  end
end

