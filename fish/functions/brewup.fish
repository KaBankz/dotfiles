function brewup --description "Update Homebrew and all installed packages"
    if command -v brew >/dev/null
        if brew update >/dev/null
            if test -n "$(brew outdated)"
                echo "The following packages are outdated:"
                brew outdated
                read -lP "Do you want to upgrade packages? [Y/n] " upgrade_choice
                switch $upgrade_choice
                    case Y y ''
                        echo "Upgrading packages..."
                        brew upgrade
                    case N n
                        echo "Exiting without upgrading."
                        return 0
                    case '*'
                        echo "Invalid choice. Exiting."
                        return 1
                end
            else
                echo "All packages are up to date."
                return 0
            end
        else
            echo "Error: Failed to update Homebrew. Exiting."
            return 1
        end
    else
        echo "Error: Homebrew is not installed. Please install Homebrew first."
        return 1
    end
end
