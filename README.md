# Qt CMake template
A template for Qt development with CMake. Check out [cavansite](https://github.com/Fryy55/cavansite)!

# Setup
Once copied with the `Use this template` button, customize the template by:
- Changing the project name from `Template` to something else in `CMakeLists.txt`
- Changing the display name of your app in `src/main.cpp`
- Customizing the app icon at `resources/icon.png` (**see `Caution` below**)
- Changing this `README.md` to reflect your project

> [!NOTE]
> It's **illegal** to remove the original license, as per its conditions. Add your own license _along_ it, not _instead_ of it

For further platform customization, you can:
- Modify the `Info.plist` that is used on macOS by editing `resources/platform/macos/template.plist` and filling in empty fields/adding other keys. It can pull in CMake variables enclosed in `@`s, just as any file that has `template` as a basename
- Modify `resources/platform/linux/template.desktop` to better reflect your application
- Customize the `.dmg` image background and structure by modifying `dmg-background.png` and `template.json` at `resources/platform/macos` (**see `Caution` below**)

> [!CAUTION]
> Unless you've introduced your own changes to backing `.cmake` files and CI pipeline, _do NOT_ change the **filenames**, **paths**, **image dimensions** and **directory structure** of anything inside `resources/`. This is especially relevant for images - modifying their contents is fine, but please pay extra attention to keeping _dimensions_ intact

## Alternative Setup
Follow this guide to setup this template _from a specific tag (release)_ instead of the latest commit
```bash
# shallowly clone this repository somewhere (replace v1.0.0 with the release you want to use). `cd` into that copy
git clone --depth 1 --branch tags/v1.0.0 https://github.com/Fryy55/qt-cmake-template.git
cd ./qt-cmake-template/

# delete all existing tags (do it one by one if you can't use `xargs` or use command substitution)
git tag -l | xargs git tag -d

# create an initial commit off the current repository state
git commit --amend -m 'Initial commit'

# replace the upstream url with your repository
# it's preferred you create this repo with the `Use this template` feature off the original
# repository to keep the `generated from` notice
git remote set-url origin https://github.com/YourUsername/amazing-qt-project.git

# force-push to your repository
git push -u origin main -f
```
You're good to go!

# Development
As your project grows, you will have more source files, headers and resources in it

All source files ending in `.cpp` inside `src/` are already globbed by CMake, but feel free to add more globbing patterns if needed

Header paths can be added to `target_include_directories` in `CMakeLists.txt` as needed

Resources are intended to be added to `resources/` and `resources/qresource.qrc` for usage in source. See `qresource.qrc` comments for usage

# License
This project is distributed under the **MIT License**.

See `TEMPLATE-LICENSE` for permissions, conditions and limitations.