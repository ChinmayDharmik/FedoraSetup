#!/bin/bash

echo "Installing Nerd Fonts and applying them to system fonts"

# Create a directory for the fonts
mkdir -p fonts

# List of Nerd Fonts to download
urls=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Mononoki.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Terminus.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hermit.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/VictorMono.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/GeistMono.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
)

# Download each font zip file
for url in "${urls[@]}"; do
    # echo "Downloading $url..."
    if wget -q "$url" -P fonts; then
        echo "Downloaded: $url"
    else
        echo "Failed to download: $url"
    fi
done

# Unzip the downloaded fonts
echo "Unzipping downloaded fonts..."
for zipfile in fonts/*.zip; do
    if [ -f "$zipfile" ]; then
        unzip -o "$zipfile" -d fonts
    else
        echo "No zip files found to unzip."
    fi
done

# Create the fonts directory in local share if it doesn't exist
mkdir -p ~/.local/share/fonts

# Copy the font files to the local fonts directory
if cp fonts/*.{ttf,otf} ~/.local/share/fonts; then
    echo "Fonts copied to ~/.local/share/fonts."
else
    echo "No font files found to copy. Please check the unzipped files."
    exit 1
fi

# Refresh font cache
fc-cache -f -v

# Clean up
rm -rf fonts

echo "Nerd Fonts installation complete!"
