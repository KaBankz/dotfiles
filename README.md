# ~/.dotfiles

nothing special, just my dotfiles managed with [Dotter](https://github.com/SuperCuber/dotter), a simple dotfile manager.

## Installation

1. Clone this repo

    ```sh
   git clone https://github.com/KaBankz/dotfiles.git ~/.dotfiles
    ```

2. Go to the repo and stay there until the end

    ```sh
    cd ~/.dotfiles
    ```

3. Download the `dotter` binary inside the repo

    > [!NOTE]
    > Be sure to download the appropriate binary for your os and arch from [Dotter Releases](https://github.com/SuperCuber/dotter/releases/latest#:~:text=Assets).

    ```sh
    curl -sSL -o dotter https://github.com/SuperCuber/dotter/releases/latest/download/dotter-macos-arm64.arm
    chmod +x dotter
    ```

4. Run `dotter deploy` inside the repo

    The `-v` flag is optional, it enables verbose output to see what is happening.

    > [!WARNING]
    > If you have any existing dotfiles that conflict with the ones in this repo, you will receive an error. You can either remove the conflicting dotfiles or overwrite them by running `dotter deploy -v --force`.

    ```sh
    ./dotter deploy -v
    ```

5. Remove the `dotter` binary

    ```sh
    rm dotter
    ```

6. Profit!?

## Features

- 🤗 They are customized to my taste
- 😎 I like them
- ✅ Follows ***XDG Base Directory*** specification where possible
- 💻 Cross platform (GNU/Linux & MacOS only)

## License

[MIT](LICENSE)
