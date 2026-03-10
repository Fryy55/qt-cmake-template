# Qt CMake template
A template for Qt development with CMake

# Setup
Once cloned, customize the template by:
- Changing the project name from `Template` to something else in `CMakeLists.txt`
- Customizing the app icon at `resources/icon.png` (**see `Caution` below**)
- Changing this `README.md` to reflect your project

> [!NOTE]
> It's **illegal** to remove the original license, as per its conditions. Add your own license _along_ it, not _instead_ of it

For further platform customization, you can:
- Modify `resources/platform/linux/template.desktop` to better reflect your application. It can pull in CMake variables enclosed in `@`s, just as any file that has `template` as a basename
- Customize the `.dmg` image background and structure by modifying `dmg-background.png` and `template.json` at `resources/platform/macos` (**see `Caution` below**)

> [!CAUTION]
> Unless you've introduced your own changes to backing `.cmake` files and CI pipeline, _do NOT_ change the **filenames**, **paths**, **image dimensions** and **directory structure** of anything inside `resources/`. This is especially relevant for images - modifying their contents is fine, but please pay extra attention to keeping _dimensions_ intact

# Development
As your project grows, you will have more source files, headers and resources in it.

All source files ending in `.cpp` inside `src/` are already globbed by CMake, but feel free to add more globbing patterns if needed

Header paths can be added to `target_include_directories` in `CMakeLists.txt` as needed

Resources are intended to be added to `resources/` and `resources/qresource.qrc` for usage in source. See `qresource.qrc` comments for usage

# License
This project is distributed under the **MIT License**.

See `LICENSE` for permissions, conditions and limitations.