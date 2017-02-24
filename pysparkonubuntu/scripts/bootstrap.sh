sudo apt-get -y update
sudo apt-get -y install openjdk-7-jdk
sudo apt-get -y install git

spark=spark-2.0.2-bin-hadoop2.7
if [[ ! -f $spark.tgz ]]; then
    wget --quiet http://d3kbcqa49mib13.cloudfront.net/$spark.tgz
fi
tar -zxf $spark.tgz -C /opt/

miniconda=Miniconda3-4.3.11-Linux-x86_64.sh
if [[ ! -f $miniconda ]]; then
    wget --quiet http://repo.continuum.io/miniconda/$miniconda
fi
chmod +x $miniconda
./$miniconda -b -p /home/vagrant/miniconda
/home/vagrant/miniconda/bin/conda install conda-build

chown -R vagrant:vagrant /home/vagrant/miniconda

cat >> /home/vagrant/.bashrc <<-BASHRCEND
# add for spark install
PATH=/opt/$spark/bin:\$PATH
# add for miniconda install
PATH=/home/vagrant/miniconda/bin:\$PATH
BASHRCEND

sudo -su vagrant /home/vagrant/miniconda/bin/conda create -n Py35 python=3.5 --yes
sudo -su vagrant /home/vagrant/miniconda/bin/conda install -n Py35 numpy scipy pytest flake8 
