# Zadarma API

This repo is archived. The development has moved to https://github.com/DGaffney/zadarma-ruby

---

## Installation

Add this line to your application's Gemfile:

    gem 'zadarma'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zadarma

## Usage

    Zadarma.api_key = "YOUR_API_KEY"
    Zadarma.api_secret = "YOUR_API_SECRET"
    Zadarma.log_requests = false # default

    Zadarma::Client.balance
or
    
    client = Zadarma::Client.new("YOUR_API_KEY", "YOUR_API_SECRET")
    client.balance
    
    
## Available methods:

* `balance` - user balance
* `price(number)` - call price
* `callback(from, to, params = {})` - request callback
* `sip` - list user’s SIP-numbers
* `set_sip_caller(id, number)` - change of CallerID
* `redirection(params = {})` - get call forwarding status on SIP-numbers
* `set_redirect(id, params)` - enable/disable sip forwarding
* `pbx_internal` - list PBX internal numbers
* `pbx_record(id, status, params = {})` - toggle call recording
* `send_sms(number, message, params = {})` - send sms
* `statistics(date_start, date_end, params = {})` - get stats
* `pbx_statistics(date_start, date_end)` - get PBX stats

## Contributing

1. Fork it ( https://github.com/zhekanax/zadarma-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
