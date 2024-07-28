wallpaperDir="/home/laged/wallpapers/"
wallpaperExt="jpg"
wallpaper=$(ls "$wallpaperDir"*."$wallpaperExt" | shuf -n 1 | awk '{print $1}')
#echo $wallpaper

monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
hyprctl hyprpaper unload all
hyprctl hyprpaper preload $wallpaper
for m in ''${monitor[@]}; do
  cmd="$m,$wallpaper"
  echo $cmd
  hyprctl hyprpaper wallpaper "$m,$wallpaper"
done
