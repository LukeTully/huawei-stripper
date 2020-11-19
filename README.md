# Strip Bloatware from your Huawei device
This script will run through the lists of packages that belong to Huawei, Bell media, Facebook, Amazon, Google, and anything else you want to add to the list. The defaults should all be safe, most of them coming from [this guide to uninstalling system apps](https://forum.xda-developers.com/huawei-p30-pro/how-to/how-to-remove-huawei-bloatware-vog-ele-t4014937)

## Usage
Make sure you have adb installed and in your PATH.
1. Clone the repo or download the file
2. Customize the script to only remove what you're comfortable with. Google apps aren't uninstall by default, but you can easily uncomment line 132 for that.
3. Make sure you can access your device by running `adb shell`
4. Run it from the terminal. For example: `. ~/Downloads/huawei-stripper/huawei.sh`
5. Enjoy your phone a little more tidy!
