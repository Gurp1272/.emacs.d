# Emacs Setup
## Install Packages
* ```M-x package-install-packages```
## Elixir ls
* Clone the elixir-lsp elixir-ls repo locally  
```git clone https://github.com/elixir-lsp/elixir-ls.git```  
```cd elixir-ls``` (that you just cloned)  
```mix deps.get```  
```mix elixir_ls.release```  
This will be referred to later in `.emacs` as ```path-to-elixir-ls/release```  
