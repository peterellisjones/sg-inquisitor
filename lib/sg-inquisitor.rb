require 'aws-sdk'

class SGInquisitor

  def initialize options={}
    # defaults
    @verbose = options[:verbose].nil? ? true : options[:verbose]

    # initialize AWS
    raise "Need AWS access key" unless options.has_key?(:access_key)
    raise "Need AWS secret access key" unless options.has_key?(:secret_access_key)
    access_key = options[:access_key]
    secret_access_key = options[:secret_access_key]
    @ec2 = AWS::EC2.new(
      :access_key_id => access_key,
      :secret_access_key => secret_access_key)

    puts "The Inquisitor is Ready!" if @ec2
  end

  def inquisit options={}
    public_security_groups = options[:public_security_groups] || []
    whitelisted_ips = options[:whitelisted_ips] || []
    whitelisted_ips.map { |ip| ip = ip }

    delete_count = 0

    # iterate through security groups
    @ec2.security_groups.each do |sg|
      next if sg.name == 'default'
      puts "+ Carefully checking '#{sg.name}'..."
      sg.ingress_ip_permissions.each do |p|
        # iterate over ips
        p.ip_ranges.each do |ipc|
          ip, cidr = ipc.split('/')
          # check public security groups
          if cidr != "32" && !public_security_groups.include?(sg.name)
            puts "- '#{sg.name}' allows traffic from #{ipc} and isn't whitelisted. Deleting this permission."
            delete_count += 1 
            sg.revoke_ingress p.protocol, p.port_range, ipc
          elsif !whitelisted_ips.include? ip
            puts "- '#{sg.name}' allows traffic from #{ipc} and isn't whitelisted. Deleting this permission."
            sg.revoke_ingress p.protocol, p.port_range, ipc
          end      
        end
        # check port ranges
        if p.port_range.count != 1
          puts "- '#{sg.name}' allows traffic from a range of ports, #{p.port_range}. Deleting this permission."
          delete_count += 1
          p.revoke
        end
      end
    end
    puts "+ Finished the inquisition. #{delete_count} security group permission#{delete_count == 1 ? '' : 's'} deleted."
  end
end