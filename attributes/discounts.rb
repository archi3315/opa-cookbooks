node.default[:deploy][:discounts][:port] = 8788
node.default[:discounts][:user] = "discounts"
node.default[:discounts][:gid] = nil
node.default[:discounts][:uid] = nil
node.default[:discounts][:pid_path] = "/var/run/discounts"
node.default[:discounts][:pid_file] = "/var/run/discounts/discounts.pid"
node.default[:discounts][:skip_restart] = false
node.default[:discounts][:log_file] = "discounts.log"
node.default[:discounts][:log_path] = "/var/log/discounts"

