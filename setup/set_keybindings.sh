#!/bin/bash

# Define the directory and file paths
KEY_BINDINGS_DIR="$HOME/Library/KeyBindings"
KEY_BINDINGS_FILE="$KEY_BINDINGS_DIR/DefaultKeyBinding.dict"

# Create the KeyBindings directory if it doesn't exist
mkdir -p "$KEY_BINDINGS_DIR"

# Create the DefaultKeyBinding.dict file with the custom keybindings
cat << EOF > "$KEY_BINDINGS_FILE"
{
    # "\UF729"  = moveToBeginningOfLine:; // home
    # "\UF72B"  = moveToEndOfLine:; // end
    # "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    # "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
    "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
    "^\UF72B" = moveToEndOfDocument:; // ctrl-end
    "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
    "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end./
    "^\UF702" = moveToBeginningOfLine:; // fn + left arrow
    "^\UF703" = moveToEndOfLine:; // fn + right arrow
    "^$\UF702" = moveToBeginningOfLineAndModifySelection:; // fn + shift + left arrow
    "^$\UF703" = moveToEndOfLineAndModifySelection:; // fn + shift + right arrow
}
EOF

# Check if the file was created successfully
if [ -f "$KEY_BINDINGS_FILE" ]; then
    echo "Keybindings file created successfully at $KEY_BINDINGS_FILE"
    echo "Please log out and log back in, or restart your computer for the changes to take effect."
else
    echo "Error: Failed to create keybindings file."
    exit 1
fi

# Optionally, set Terminal.app preferences
read -p "Do you want to set Terminal.app preferences for Home and End keys? (y/n) " set_terminal

if [[ $set_terminal == "y" || $set_terminal == "Y" ]]; then
    # Set Terminal.app preferencessda
    defaults write com.apple.Terminal NSUserKeyEquivalents -dict-add "End" "\\033OF"
    defaults write com.apple.Terminal NSUserKeyEquivalents -dict-add "Home" "\\033OH"
    echo "Terminal.app preferences set. You may need to restart Terminal for changes to take effect."
fi

echo "Script completed."