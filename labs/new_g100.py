#!/usr/bin/python3

import time
import subprocess


current_time = time.strftime("%Y%m%d%H%M%S").rstrip('\n')
ssh_command = "ssh"
ssh_port = 4444
ssh_parameters = [
    '-p {port}'.format(port=ssh_port),
    '-i ~/.ssh/id_rsa-labs-20150319234517',
    '-o "StrictHostKeyChecking no"',
    '-o "ConnectTimeout 2"',
    ]
ssh_remote_host = 'root@147.52.58.{:}'
ssh_remote_command = '{:}'

for i in range(5,255):
    print("147.52.58."+str(i))

    command = ssh_command + ' ' + ' '.join(ssh_parameters) + ' ' + ssh_remote_host.format(i) + ' ' + ssh_remote_command.format('cat /etc/hostname')
    print(command)
    #print(subprocess.Popen(command.split(), stdout=subprocess.PIPE).communicate()[0])


    #print(subprocess.Popen(['ssh', '-p 4444', '-i /home/labop/.ssh/id_rsa-labs-20150319234517', 'root@147.52.58.117', '"ls"'], stdout=subprocess.PIPE).communicate()[0])
    print(subprocess.Popen(['ssh', '-p 4444', 'root@147.52.58.117', '"ls"'], stdout=subprocess.PIPE).communicate()[0])
    
    break
