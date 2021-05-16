#!/bin/bash
#
# This scripts using for hardening CentOS at TRUE DMP
# Template from hardening-Centos7.txt
#

#----- Packages -----
yum install -y epel-release
yum install -y rsync 
yum install -y ntp 
yum install -y iptraf 
yum install -y telnet 
yum install -y vim 
yum install -y sysfsutils 
yum install -y net-tools
yum install -y yum-utils
yum install -y traceroute
yum install -y sysstat
yum install -y zip
yum install -y nload
yum install -y wget

#----- Set banner for ssh -----
echo "|-----------------------------------------------------------------|" > /etc/issue.net
echo "| This system is for the use of authorized users only.            |" >> /etc/issue.net
echo "| Individuals using this computer system without authority, or in |" >> /etc/issue.net
echo "| excess of their authority, are subject to having all of their   |" >> /etc/issue.net
echo "| activities on this system monitored and recorded by system      |" >> /etc/issue.net
echo "| personnel.                                                      |" >> /etc/issue.net
echo "|                                                                 |" >> /etc/issue.net
echo "| In the course of monitoring individuals improperly using this   |" >> /etc/issue.net
echo "| system, or in the course of system maintenance, the activities  |" >> /etc/issue.net
echo "| of authorized users may also be monitored.                      |" >> /etc/issue.net
echo "|                                                                 |" >> /etc/issue.net
echo "| Anyone using this system expressly consents to such monitoring  |" >> /etc/issue.net
echo "| and is advised that if such monitoring reveals possible         |" >> /etc/issue.net
echo "| evidence of criminal activity, system personnel may provide the |" >> /etc/issue.net
echo "| evidence of such monitoring to law enforcement officials.       |" >> /etc/issue.net
echo "|-----------------------------------------------------------------|" >> /etc/issue.net

echo "|-----------------------------------------------------------------|" > /etc/issue
echo "| This system is for the use of authorized users only.            |" >> /etc/issue
echo "| Individuals using this computer system without authority, or in |" >> /etc/issue
echo "| excess of their authority, are subject to having all of their   |" >> /etc/issue
echo "| activities on this system monitored and recorded by system      |" >> /etc/issue
echo "| personnel.                                                      |" >> /etc/issue
echo "|                                                                 |" >> /etc/issue
echo "| In the course of monitoring individuals improperly using this   |" >> /etc/issue
echo "| system, or in the course of system maintenance, the activities  |" >> /etc/issue
echo "| of authorized users may also be monitored.                      |" >> /etc/issue
echo "|                                                                 |" >> /etc/issue
echo "| Anyone using this system expressly consents to such monitoring  |" >> /etc/issue
echo "| and is advised that if such monitoring reveals possible         |" >> /etc/issue
echo "| evidence of criminal activity, system personnel may provide the |" >> /etc/issue
echo "| evidence of such monitoring to law enforcement officials.       |" >> /etc/issue
echo "|-----------------------------------------------------------------|" >> /etc/issue

#----- Setting sshd service -----
sed -i "s/#ClientAliveCountMax 3/ClientAliveCountMax 2/" /etc/ssh/sshd_config
sed -i "s/#Compression delayed/Compression no/" /etc/ssh/sshd_config
sed -i "s/#MaxAuthTries 6/MaxAuthTries 4/" /etc/ssh/sshd_config
sed -i "s/#MaxSessions 10/MaxSessions 2/" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i "s/#TCPKeepAlive yes/TCPKeepAlive no/" /etc/ssh/sshd_config
sed -i "s/#UseDNS no/UseDNS no/" /etc/ssh/sshd_config   
sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config  
sed -i "s/X11Forwarding yes/X11Forwarding no/" /etc/ssh/sshd_config
sed -i "s/#AllowAgentForwarding yes/AllowAgentForwarding no/" /etc/ssh/sshd_config
sed -i "s/#AllowTcpForwarding yes/AllowTcpForwarding no/" /etc/ssh/sshd_config
sed -i "s/#Banner none/Banner \/etc\/issue/" /etc/ssh/sshd_config
sed -i "s/#LogLevel INFO/LogLevel INFO/" /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config
echo "ClientAliveInterval 900" >> /etc/ssh/sshd_config
echo "LoginGraceTime 60" >> /etc/ssh/sshd_config
sed -i 's/Banner/\#Banner/' /etc/ssh/sshd_config
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
echo "MACs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,umac-128@openssh.com" >> /etc/ssh/sshd_config

#----- Set UMASK -----
sed -i "s/umask 002/umask 027/"  /etc/profile
sed -i "s/umask 002/umask 027/"  /etc/bashrc
sed -i "s/umask 002/umask 027/"  /etc/csh.cshrc
sed -i "s/umask 022/umask 027/"  /etc/init.d/functions

#----- Set system configure -----
echo "kernel.dmesg_restrict=1" >> /etc/sysctl.conf
echo "kernel.kptr_restrict=2" >> /etc/sysctl.conf
echo "kernel.sysrq=0" >> /etc/sysctl.conf
echo "kernel.yama.ptrace_scope=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.log_martians=1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.send_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.log_martians=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.accept_redirects=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.accept_redirects=0" >> /etc/sysctl.conf
sysctl -p

#----- Set system configure -----
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
rm -rf /etc/hosts.deny

#-------Filesystem Configuration -------#
touch /etc/modprobe.d/CIS.conf 
echo "install cramfs /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install freevxfs /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install jffs2 /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install hfs /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install hfsplus /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install squashfs /bin/true" >> /etc/modprobe.d/CIS.conf 
echo "install udf /bin/true" >> /etc/modprobe.d/CIS.conf 

#-------Filesystem Configuration TMP Mount point-------#
systemctl unmask tmp.mount
sleep 3
systemctl enable tmp.mount
sleep 3
sed -i "s/Options=mode=1777,strictatime/Options=nodev,nosuid,noexec/" /etc/systemd/system/local-fs.target.wants/tmp.mount
sed -i 's/\/dev\/mapper\/centos-home/\#\/dev\/mapper\/centos-home/' /etc/fstab
echo "/dev/mapper/centos-home /home                   xfs     defaults,nodev       0 0" >> /etc/fstab
sed -i 's/\/dev\/mapper\/centos-tmp/\#\/dev\/mapper\/centos-tmp/' /etc/fstab
echo "/dev/mapper/centos-tmp  /tmp                    xfs     defaults,nodev,nosuid,noexec      0 0" >> /etc/fstab
echo "none /dev/shm tmpfs defaults,nodev,nosuid,noexec 0 0" >> /etc/fstab

#-------Disable core dump-------#
echo "*        hard     core   0" >> /etc/security/limits.conf
echo "*        hard     core   0" >> /etc/security/limits.d/20-nproc.conf

#----- Change permission of as command -----
chmod o-rx /usr/bin/as

#----- Set modprode -----
echo "blacklist usb-storage" > /etc/modprobe.d/usb.conf
echo "blacklist firewire-core" > /etc/modprobe.d/firewire.conf

#----- Set security password -----
sed -i "s/PASS_MAX_DAYS/#PASS_MAX_DAYS/" /etc/login.defs
echo "PASS_MAX_DAYS   60" >> /etc/login.defs
sed -i "s/PASS_MIN_DAYS/#PASS_MIN_DAYS/" /etc/login.defs
echo "PASS_MIN_DAYS   7" >> /etc/login.defs

#----- Set NTP service -----
sed -i 's/^server/#server/' /etc/ntp.conf
echo "server 1.th.pool.ntp.org prefer" >> /etc/ntp.conf
systemctl start ntpd
systemctl enable ntpd

#-------Enable audit before boot -------#
echo "GRUB_CMDLINE_LINUX="audit=1"" >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

#-------Set grub config file permission-------#
chmod 600 /boot/efi/EFI/centos/grub.cfg
chmod 600 /boot/grub2/grub.cfg

#-------Custom audit rules-------#
rm -rf /etc/audit/rules.d/audit.rules
cat <<EOF > /etc/audit/rules.d/audit.rules
## First rule - delete all
-D

## Increase the buffers to survive stress events.
## Make this bigger for busy systems
-b 8192

## Set failure mode to syslog
-f 1
# audit time changes
-a always,exit -F arch=b64 -S adjtimex -S stime -S settimeofday -S clock_settime -k audit_time
-w /etc/localtime -p wa -k audit_time

# audit account changes
-w /etc/group -p wa -k audit_account
-w /etc/passwd -p wa -k audit_account
-w /etc/gshadow -p wa -k audit_account
-w /etc/shadow -p wa -k audit_account
-w /etc/security/opasswd -p wa -k audit_account

# audit hostname changes
-a always,exit -F arch=b64 -S sethostname -S setdomainname -k audit_hostname

# audit banner changes
-w /etc/issue -p wa -k audit_banner
-w /etc/issue.net -p wa -k audit_banner

# audit network changes
-w /etc/hosts -p wa -k audit_network
-w /etc/sysconfig/network -p wa -k audit_network
-w /etc/sysconfig/network-scripts/ -p wa -k audit_network

# audit selinux changes
-w /etc/selinux/ -p wa -k audit_selinux
-w /usr/share/selinux/ -p wa -k audit_selinux

# audit login
-w /var/log/lastlog -p wa -k audit_login
-w /var/run/faillock/ -p wa -k audit_login
-w /var/run/utmp -p wa -k audit_login
-w /var/log/wtmp -p wa -k audit_login
-w /var/log/btmp -p wa -k audit_login

# audit permission changes
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S chmod -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fchmod -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fchmodat -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S chown -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fchown -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fchownat -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S lchown -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S setxattr -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S lsetxattr -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fsetxattr -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S removexattr -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S lremovexattr -k audit_perm
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S fremovexattr -k audit_perm

# audit mount
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S mount -k audit_mount

# audit file changes
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -k audit_file
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -k audit_file
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S unlink -S unlinkat -S rename -S renameat -F exit=-EPERM -k audit_file
-a always,exit -F arch=b64 -F auid>=1000 -F auid!=4294967295 -S unlink -S unlinkat -S rename -S renameat -F exit=-ACCESS -k audit_file

# audit privilege escalation
-w /bin/su -p x -k audit_su
-w /usr/bin/sudo -p x -k audit_sudo
-w /etc/sudoers -p wa -k audit_sudo
-w /etc/sudoers.d/ -p wa -k audit_sudo
-w /var/log/sudo.log -p wa -k audit_sudo

# audit kernel module
-w /sbin/insmod -p x -k audit_kernel
-w /sbin/rmmod -p x -k audit_kernel
-w /sbin/modprobe -p x -k audit_kernel
-a always,exit -F arch=b64 -S init_module -S delete_module -k audit_kernel

# audit privileged command
-a always,exit -F path=/bin/ping6 -F perm=x -F auid>=1000 -F auid!=4294967295 -k audit_privileged_cmd
-a always,exit -F path=/bin/fusermount -F perm=x -F auid>=1000 -F auid!=4294967295 -k privileged
-a always,exit -F path=/bin/mount -F perm=x -F auid>=1000 -F auid!=4294967295 -k audit_privileged_cmd

# Make the configuration immutable
-e 2
EOF

#-------Change rsyslog file create permission-------#
echo '$FileCreateMode 0640' >> /etc/rsyslog.conf

#-------Set permission of cron -------#
chmod 600 /etc/crontab
chmod 600 /etc/cron.hourly/
chmod 600 /etc/cron.daily/
chmod 600 /etc/cron.weekly/
chmod 600 /etc/cron.monthly/
chmod 600 /etc/cron.d/
rm /etc/cron.deny

#----- Add user -----
useradd cdnedge
echo "#Stm*1234" | passwd cdnedge --stdin
chage -m 0 -M 99999 -I -1 -E -1 cdnedge

#----- Set sudoers -----
echo "cdnedge ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#-------Set password history and lockout policy-------#
rm -rf /etc/pam.d/system-auth 
cat <<EOF > /etc/pam.d/system-auth 
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        required      pam_deny.so

account     required      pam_unix.so
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     required      pam_permit.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
#password   sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password   sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so

auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900
auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900
auth        [success=1 default=bad] pam_unix.so
EOF

#-------Set password history and lockout policy-------#
rm -rf /etc/pam.d/password-auth
cat <<EOF > /etc/pam.d/password-auth
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        required      pam_faildelay.so delay=2000000
auth        sufficient    pam_unix.so nullok try_first_pass
auth        requisite     pam_succeed_if.so uid >= 1000 quiet_success
auth        required      pam_deny.so

account     required      pam_unix.so
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     required      pam_permit.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
#password   sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password   sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     [success=1 default=ignore] pam_succeed_if.so service in crond quiet use_uid
session     required      pam_unix.so
auth        required      pam_faillock.so preauth audit silent deny=5 unlock_time=900
auth        sufficient    pam_faillock.so authsucc audit deny=5 unlock_time=900
auth        [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900
auth        [success=1 default=bad] pam_unix.so
EOF

#-------Set password history and lockout policy-------#
useradd -D -f 120
sed -i 's/PASS_MAX_DAYS/\#PASS_MAX_DAYS/' /etc/login.defs
echo "PASS_MAX_DAYS   365" >> /etc/login.defs
echo "minlen = 14" >> /etc/security/pwquality.conf
echo "dcredit = -1" >> /etc/security/pwquality.conf
echo "ucredit = -1" >> /etc/security/pwquality.conf
echo "lcredit = -1" >> /etc/security/pwquality.conf
echo "ocredit = -1" >> /etc/security/pwquality.conf
echo "auth            required        pam_wheel.so use_uid" >> /etc/pam.d/su
sed -i 's/umask 027/umask 007/' /etc/bashrc 
sed -i 's/umask 022/umask 027/' /etc/bashrc 
sed -i 's/umask 027/umask 007/' /etc/profile
sed -i 's/umask 022/umask 027/' /etc/profile
echo "export TMOUT=900" >> /etc/profile
echo "export TMOUT=900" >> /etc/bashrc

#----- Set syslog -----
echo "*.info;mail.none;authpriv.none;cron.none	@10.18.12.30" >> /etc/rsyslog.conf
systemctl restart rsyslog

#----- Set SNMP -----
mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak
cat <<EOF >> /etc/snmp/snmpd.conf
com2sec AllUser  default       Solarwind#611
group   AllGroup v2c           AllUser
view    systemview    included   .1
view    systemview    included   .1.3.6.1.2.1.1
view    systemview    included   .1.3.6.1.2.1.25.1.1
access  AllGroup ""      any       noauth    exact  systemview none none
syslocation Unknown (edit /etc/snmp/snmpd.conf)
syscontact Root <root@localhost> (configure /etc/snmp/snmp.local.conf)
dontLogTCPWrappersConnects yes
EOF
systemctl enable snmpd
systemctl start snmpd
snmpwalk -v 2c -c Solarwind#611 -O e 127.0.0.1

# increases the total port range from its default 28,232 ports to 49,000 ports
echo 15000 64000 > /proc/sys/net/ipv4/ip_local_port_range

#Tune OS
cat /etc/security/limits.conf
cat /etc/sysctl.conf
echo "# tune" >> /etc/security/limits.conf
echo "*               soft    nofile          1048576" >> /etc/security/limits.conf
echo "*               hard    nofile          1048576" >> /etc/security/limits.conf
echo "*               soft    nproc          262144" >> /etc/security/limits.conf
echo "*               hard    nproc          262144" >> /etc/security/limits.conf
echo "*               soft    memlock         256" >> /etc/security/limits.conf
echo "*               hard    memlock         256" >> /etc/security/limits.conf
echo "# tune" >> /etc/sysctl.conf
echo "kernel.pid_max=1048576" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_max = 524288" >> /etc/sysctl.conf
echo "net.core.somaxconn = 2048" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 15000 64000" >> /etc/sysctl.conf
echo "net.netfilter.nf_conntrack_tcp_timeout_time_wait = 60" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-iptables = 1" >> /etc/sysctl.conf
echo "net.bridge.bridge-nf-call-ip6tables = 1" >> /etc/sysctl.conf
modprobe ip_conntrack
modprobe nf_conntrack
sysctl -p

#----- Reboot -----