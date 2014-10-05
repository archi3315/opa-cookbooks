node.default[:discounts][:port] = 8788
node.default[:discounts][:version] = nil
node.default[:discounts][:user] = "discounts"
node.default[:discounts][:gid] = nil
node.default[:discounts][:uid] = nil
node.default[:discounts][:pid][:path] = "/var/run/discounts"
node.default[:discounts][:pid][:file] = "discounts.pid"
node.default[:discounts][:skip_restart] = false
node.default[:discounts][:log][:file] = "discounts.log"
node.default[:discounts][:log][:path] = "/var/log/discounts"
node.default[:discounts][:log][:rolling_date_pattern] = "yyyy-MM-dd"
node.default[:discounts][:log][:rolling_file_extension] = ".gz"

