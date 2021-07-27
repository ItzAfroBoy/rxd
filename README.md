# rxd

An Arch Linux install script

Included in the repo are:

1. [`rxd.sh`](https://github.com/ItzAfroBoy/rxd/blob/main/rxd.sh)
    - `Install script`
2. [`rxd.txt`](https://github.com/ItzAfroBoy/rxd/blob/main/rxd.txt)
    - `Figlet Text`
3. [`walls`](https://github.com/ItzAfroBoy/rxd/tree/main/walls)
    - `36 Wallpapers`
    - `All 1920x1080`

## Installation

1. Clone this repo: `git clone && cd rxd`
2. Run the install script: `./rxd.sh`
3. Enjoy your new `Arch Linux` setup

## FAQs

> What gets installed?  

There are a total of `75 packages` that will get installed.  
This total does count the packages inside the `xorg-apps` group of packages.  
There are also a total of `5 repos` and `2 scripts` that will be cloned.  
You are more than welcome to look at the script and modify anything to your needs. There are a few patches I have created that you can apply so the installation is more customizable.

> What if I don't want to keep the git repos?

At the end, you will be asked if you would like a clean up which will remove the `5 repos` off your system. As I am nice, the script will also remove orphan packages from `pacman` off your system.

> Could we get some color up in here please?

No problem. Below, I have provided a patch file which you can apply to the script so you have colored output.  
It works well if you have the color option enabled on `pacman`.

> I don't want some of the packages to be installed to my system. I prefer other ones

Thats also fine. If you look towards the bottom of this readme, you should find a patch which you can apply to the script that makes each package install a function, so you can customize which packages you want and the ones you dont.

> Why aren't these things you've put in the patch files already built in.

They used to be. But because people probs don't want the same install as me; just take the hassle out of remembering all the packages they need to install. I ended up deciding that if you want something, just add it in. Patches also means there isn't messing about with flags or proper help documentation as you know what you're getting. It just made for a better use for everyone in my eyes.

## Contributing

If you want to contribute:

1. Fork this repo
2. Make a new branch
    - You can call it something like dev. Just make it sensible
3. Make some changes, commit them to your branch and push them to GitHub
4. Submit a PR and I'll take a look
    - If you could generate a `patch` / `diff` file, that would be great
5. Pray I like it

## License

[`GNU GPLv3`](https://github.com/ItzAfroBoy/rxd/blob/main/LICENSE)
