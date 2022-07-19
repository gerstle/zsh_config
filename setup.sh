#! /usr/bin/env zsh

DIR=${0:a:h}

echo "installing antibody..."
Brew install antibody

echo "linking dot files..."
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

echo "installing asdf-vm..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
# asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
# asdf install ruby 2.6.2
# asdf global ruby 2.6.2
# asdf plugin-add java
# asdf list all java
# asdf install java amazon-corretto-11.0.6.10.1-2
# asdf global java amazon-corretto-11.0.7.10.1

source ~/.zshrc
p10k configure

