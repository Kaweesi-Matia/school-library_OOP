require 'json'
def get_data(file)
  path_file = "./store_data/#{file}.json"
  File.new(path_file, 'w+') unless File.exist?(path_file)
  File.write(path_file, '[]') if File.empty?(path_file)
  file_contents = File.read(path_file)
  JSON.parse(file_contents)
end

def update_data(file, data)
  opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
  }
  json = JSON.generate(data, opts)
  File.write("./store_data/#{file}.json", json)
end

