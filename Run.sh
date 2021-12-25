#!/usr/bin/env bash

echo "Lets check if Ruby is installed"
ruby --version
RESULT=$?
if [ $RESULT == 0 ]; then
  echo "Congrats Ruby is installed. Please note Version 3.0 is prefered and the application may not be compatible with other versions"
  echo "Now lets check if RubyGem is installed"
  gem --version
  RESULT=$?
  if [ $RESULT == 0 ]; then
    echo "yay RubyGem is installed"
  else
    echo "RubyGem isn't installed, This script will now attempt to install RubyGem"
    git clone https://github.com/rubygems/rubygems
    ruby setup.rb
    RESULT=$?
    if [ $RESULT == 0 ]; then
      echo "RubyGems is now installed, lets make sure its updated before we continue"
      gem update --system
      RESULT=$?
      if [ $RESULT == 0 ]; then
        echo "RubyGems Updated"
      else
        echo "RubyGems failed to update, please run; 'gem update --system' to update"
      fi
    fi
  fi
  echo "Now lets check if Bundler is installed"
  bundler --version
  RESULT=$?
  if [ $RESULT == 0 ]; then
    echo "Brilliant with this done we can bundle the downloaded gemfile and run the application"
  else
    echo "Bundler isn't installed, lets try to install it"
    gem install bundler --version 2.2.3
    RESULT=$?
    if [ $RESULT == 0 ]; then
      echo "bundler version 2.2.3 installed, get this script running"
    else
      echo "could not install bunlder, please run; 'gem install bundler --version 2.2.3' to install the bundler"
    fi
  fi
  bundle install --gemfile=./src/Gemfile
  cd ./src
  ./DandD_DPR_Calculator.rb
else
  echo "Ruby isn't installed, please Install Ruby 3.0 before attempting to run this script again"
fi