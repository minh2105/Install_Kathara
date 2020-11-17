apt update
apt install -y python3
apt install -y python-pip
pip install -y ipaddress
apt install -y build-essential
apt install -y xterm

#Installing Docker Container
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y containerd.io docker-ce docker-ce-cli
systemctl enable docker

#Download source code Kathara
cd 
git clone https://github.com/minh2105/KatharaMMT.git
chmod 755 KatharaMMT/bin
chmod 755 KatharaMMT/bin/*

#Setting variables environment
cat >> ~/.bashrc <<EOF
export NETKIT_HOME=~/KatharaMMT/bin
export PATH=$PATH:$NETKIT_HOME
export MANPATH=:$NETKIT_HOME/man
EOF
source ~/.bashrc

#Configure proxies for docker
mkdir -p /etc/systemd/system/docker.service.d
cat >> /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
[Service]
Environment=
EOF
systemctl daemon-reload 
systemctl restart docker

#Start Kathara
$NETKIT_HOME/install
mkdir -p /root/netkit_temp/labs
