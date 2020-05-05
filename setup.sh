#! /usr/bin/env zsh

DIR=${0:a:h}

# install antibody
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

for config in $DIR/config/*; do
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

source ~/.zshrc

p10k configure
