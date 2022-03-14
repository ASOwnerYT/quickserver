# Script that makes a simple Minecraft survival server for LAN, with recommended PaperMC plugins
# Made by ASOwnerYT

# Server folder
echo QUICKSERVER: Making folders and downloading plugins...

# Plugins folder
mkdir plugins
cd plugins

# Download plugins

echo QUICKSERVER: Downloading plugins...

# EssentialsX
# This downloads the latest release from a Github repository
essentialsx="$(curl \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/EssentialsX/Essentials/releases | \
  jq -r '.[0] | .assets | .[0] | .browser_download_url')"
wget "$essentialsx"

# GeyserMC
wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar

# ViaVersion
viaversion="$(curl \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/ViaVersion/ViaVersion/releases | \
  jq -r '.[0] | .assets | .[0] | .browser_download_url')"
wget "$viaversion"

# End of plugin download
cd ..

# Minecraft Version
version="1.18.1"

# Download PaperMC
echo QUICKSERVER: Downloading the latest PaperMC server jar...
api=https://papermc.io/api/v2
latest_build="$(curl -X 'GET' \
  'https://papermc.io/api/v2/projects/paper/versions/1.18.1' \
  -H 'accept: application/json' | jq '.builds [-1]')"

echo "QUICKSERVER: Minecraft version: $version"
echo "QUICKSERVER: Latest build version: $latest_build"
download_url="$api"/projects/paper/versions/"$version"/builds/"$latest_build"/downloads/paper-"$version"-"$latest_build".jar
wget -O paper.jar "$download_url"

# Start server
echo QUICKSERVER: Starting server...
java -jar paper.jar
