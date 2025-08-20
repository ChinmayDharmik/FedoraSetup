# FedoraSetup

A collection of scripts to automate **Fedora** post-install setup for developers. This project helps streamline environment configuration, package installation, and tool setup — saving time and ensuring reproducibility across machines.

## 🚀 Features

* Automated installation of essential developer tools and packages
* Configurable dotfiles for custom environments
* Shell scripts for system updates and package management
* Cross-distro compatibility (tested on **Fedora** and **Ubuntu**)
* Reproducible setup for new developer machines or VMs

## 📂 Structure

```
FedoraSetup/
│── install.sh        # Main setup script
│── packages.txt      # List of packages for installation
│── config/           # Environment and dotfiles configuration
│── README.md         # Documentation
```

## 🛠️ Requirements

* Linux system (Fedora 42)
* Git
* Sudo access

## ⚡ Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/ChinmayDharmik/FedoraSetup.git
   cd FedoraSetup
   ```

2. Run the setup script:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Restart your terminal or system to apply changes.

## 🤝 Contributing

Pull requests and suggestions are welcome!
If you’d like to contribute:

1. Fork the repo
2. Create a new branch (`feature/my-update`)
3. Commit your changes
4. Open a pull request

## 📜 License

This project is licensed under the MIT License — feel free to use and modify.
