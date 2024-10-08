#!/usr/bin/env bash
dir=${0%/*}
if [ "$dir" = "$0" ]; then
  dir="."
fi
cd "$dir"

# SEZIPURL=https://github.com/SubtitleEdit/subtitleedit/releases/download/4.0.8/SE408.zip
# VLCURL=http://download.videolan.org/pub/videolan/vlc/3.0.21/win64/vlc-3.0.21-win64.zip

echo "INSTALLING https://github.com/SubtitleEdit/ on macOS"
echo
echo "1. Go to https://github.com/SubtitleEdit/subtitleedit/releases"
echo "2. In 'Latest release', right click the ZIP with 'Portable version' (e.g. 'SE360.zip') and copy link address"
echo "3. Paste it here and press Enter or leave blank to skip"
echo "Example: https://github.com/SubtitleEdit/subtitleedit/releases/download/4.0.8/SE408.zip"
read SEZIPURL

echo "INSTALLING VideoLAN in wine"
echo
echo "1. Go to http://download.videolan.org/pub/videolan/vlc/"
echo "2. In 'last', "win64", right click the file with .zip  (e.g. 'vlc-3.0.21-win64.zip') and copy link address"
echo "3. Paste it here and press Enter or leave blank to skip"
echo "Example: http://download.videolan.org/pub/videolan/vlc/3.0.21/win64/vlc-3.0.21-win64.zip"
read VLCURL

# echo "Thank you, proceeding with installation..."

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the gcenx/wine build
brew tap gcenx/wine
brew install tesseract
brew install --cask wine-crossover
brew install winetricks

export WINEPREFIX=${HOME}/.wine-se/

# Install .NET 4.8
winetricks -q --force dotnet48
winetricks -q --force lavfilters
winetricks -q --force win10
winetricks -q --force d3dx9

# Install Subtitle Edit portable
curl -L -o "$dir/se.zip" "$SEZIPURL"
unzip "$dir/se.zip" -d "$WINEPREFIX/drive_c/Program Files/Subtitle Edit/"
rm "$dir/se.zip"

# install vlc
curl -L -o "$dir/vlc.zip" "$VLCURL"
unzip "$dir/vlc.zip" -d "$WINEPREFIX/drive_c/Program Files/VLC64/"
rm "dir/vlc.zip"

cp "$dir/subtitleeditw" "/usr/local/bin"

echo "Ready! Now open Terminal.app and type"
echo "subtitleeditw"
echo "to run the GUI or"
echo "subtitleeditw /help"
echo "to run the CLI"
