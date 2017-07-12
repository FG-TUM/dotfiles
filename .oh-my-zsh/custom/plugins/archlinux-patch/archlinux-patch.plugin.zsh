# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

# Look for pacaur, and add some useful functions if we have it.
if [[ -x `which pacaur` ]]; then
  upgrade () {
    pacaur -Syu
  }
  alias paconf='pacaur -C'        # Fix all configuration files with vimdiff
  # Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
  alias paupg='pacaur -Syua'        # Synchronize with repositories before upgrading packages (AUR packages too) that are out of date on the local system.
  alias pasu='pacaur --sucre'      # Same as yaupg, but without confirmation
  alias pain='pacaur -S'           # Install specific package(s) from the repositories
  alias pains='pacaur -U'          # Install specific package not from the repositories but from a file
  alias pare='pacaur -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
  alias parem='pacaur -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
  alias parep='pacaur -Si'         # Display information about a given package in the repositories
  alias pareps='pacaur -Ss'        # Search for package(s) in the repositories
  alias paloc='pacaur -Qi'         # Display information about a given package in the local database
  alias palocs='pacaur -Qs'        # Search for package(s) in the local database
  alias palst='pacaur -Qe'         # List installed packages, even those installed from AUR (they're tagged as "local")
  alias paorph='pacaur -Qtd'       # List orphans using pacaur
  alias paorph='pacaur -Rs $(pacaur -Qqtd)'       # Remove orphans using pacaur

  # Additional pacaur alias examples
  if [[ -x `which abs` && -x `which aur` ]]; then
    alias paupd='pacaur -Sy && sudo abs && sudo aur'  # Update and refresh the local package, ABS and AUR databases against repositories
  elif [[ -x `which abs` ]]; then
    alias paupd='pacaur -Sy && sudo abs'   # Update and refresh the local package and ABS databases against repositories
  elif [[ -x `which aur` ]]; then
    alias paupd='pacaur -Sy && sudo aur'   # Update and refresh the local package and AUR databases against repositories
  else
    alias paupd='pacaur -Sy'               # Update and refresh the local package database against repositories
  fi
  alias painsd='pacaur -S --asdeps'        # Install given package(s) as dependencies of another package
  alias pamir='pacaur -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
  alias paclean='pacaur -Sc'               # Clean cache from unused packages
else
 upgrade() {
   sudo pacman -Syu
 }
fi

