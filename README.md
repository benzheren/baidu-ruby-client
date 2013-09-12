# Baidu Ruby Client

This is a simple REST client for [Baidu Developer Platform
Cloud](http://developer.baidu.com/cloud/)

## Installation

Add this line to your application's Gemfile:

    gem 'baidu-ruby-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install baidu-ruby-client


## Usage

### Configuration

If you use this with Rails, put a file like `baidu.rb` in `config/initializers/`, the
default **url_scheme** is `https`.

```
require 'baidu-ruby-client'

Baidu.init api_key: 'your_baidu_api_key',
           secret_key: 'your_baidu_secret_key',
           url_scheme: 'http:'
```

### Cloud Push

The code below pushes a simple message to all Android devices. `push_msg`, by default, does *push notification* and pushed to *everyone*.

```
message = { :title => 'Hello', :content => 'World' }
Baidu::Push.push_msg({ :messages => JSON.dump(message), :msg_keys =>'random_key' })
```

## TODO

* Test Coverage

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
