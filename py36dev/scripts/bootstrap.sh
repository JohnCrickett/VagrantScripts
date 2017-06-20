sudo apt-get -y update
sudo apt-get -y install git

miniconda=Miniconda3-4.3.11-Linux-x86_64.sh
if [[ ! -f $miniconda ]]; then
    wget --quiet http://repo.continuum.io/miniconda/$miniconda
fi
chmod +x $miniconda
./$miniconda -b -p /home/vagrant/miniconda
/home/vagrant/miniconda/bin/conda install conda-build

chown -R vagrant:vagrant /home/vagrant/miniconda

cat >> /home/vagrant/.bashrc <<-BASHRCEND
# add for miniconda install
PATH=/home/vagrant/miniconda/bin:\$PATH
BASHRCEND

sudo -su vagrant /home/vagrant/miniconda/bin/conda create -n Py36 python=3.6 --yes
sudo -su vagrant /home/vagrant/miniconda/bin/conda install -n Py36 numpy scipy pytest flake8 
