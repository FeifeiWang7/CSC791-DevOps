import boto.ec2.autoscale

from boto.ec2.autoscale import LaunchConfiguration

autoscale = boto.ec2.autoscale.AutoScaleConnection()
ec2 = boto.ec2.connect_to_region('us-east-1')
group = autoscale.get_all_groups

lc = LaunchConfiguration(name='my-launch_config', image_id='ami-a8d369c0', key_name='lab-key-pair-useast',)
autoscale.create_launch_configuration(lc)

from boto.ec2.autoscale import AutoScalingGroup

ag = AutoScalingGroup(group_name='my_group', load_balancers=['my-loadbalancer'], availability_zones=['us-east-1a'], launch_config=lc, min_size=1, max_size=4,connection=autoscale)
autoscale.create_auto_scaling_group(ag)

autoscale.get_all_activities(ag)
