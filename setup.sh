#! /bin/bash

set -e

scripthome=$(realpath $(dirname $0))

echo "installing antibody..."
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

echo "linking dot files..."
for config in $scripthome/config/*; do
    configtarget="$HOME/.$(basename $config)"

    # Check the original.
    if [ -f $configtarget ]; then 
	if [ ! -h $configtarget ]; then
	    echo "Moving original file $configtarget -> $configtarget.bak"
            mv $configtarget "$configtarget.bak"
	fi
    fi
    
    # Make links
    echo "Linking $configtarget -> $config"
    ln -fs $config $configtarget 
done

echo "installing asdf-vm..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

source ~/.zshrc
p10k configure

