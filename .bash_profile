if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH:/usr/local/go/bin"
fi

# Mac specific paths for Python, ports, and Emacs!
if [[ $OSTYPE == darwin* ]]; then
  PATH=/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}
  PATH=/opt/local/bin:/opt/local/sbin:$PATH
  PATH=/Applications/Emacs.app/Contents/MacOS/bin/:${PATH}
fi

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
