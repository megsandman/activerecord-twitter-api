base_uri = 'https://<your-firebase>.firebaseio.com/'

firebase = Firebase::Client.new(base_uri)

response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })
response.success? # => true
response.code # => 200
response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'


# If you have a read-only namespace, set your secret key as follows:

firebase = Firebase::Client.new(base_uri, secret_key)

response = firebase.push("todos", { :name => 'Pick the milk', :priority => 1 })


# You can now pass custom query options to firebase:

response = firebase.push("todos", :limit => 1)
# So far, supported methods are:

set(path, data, query_options)
get(path, query_options)
push(path, data, query_options)
delete(path, query_options)
update(path, data, query_options)