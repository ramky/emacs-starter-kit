;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Load up ELPA, the package manager

(add-to-list 'load-path dotfiles-dir)

(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))
(add-to-list 'load-path (concat dotfiles-dir "/util"))
(add-to-list 'load-path (concat dotfiles-dir "/color-theme-6.6.0"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")))
  (add-to-list 'package-archives source t))
(package-initialize)
(require 'starter-kit-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; backport some functionality to Emacs 22 if needed
(require 'dominating-file)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))

;;  cd ~/.emacs.d/plugins
;;  git clone --recursive https://github.com/capitaomorte/yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;;(require 'rinari)
(require 'rspec-mode)
(require 'inf-ruby)

;; erlang
;; Erlang mode (installed via Homebrew)
;; cd .emacs.d
;; ln -s /usr/local/Cellar/erlang/R16B03/lib/erlang/lib/tools-2.6.13/emacs emacs
;; ln -s /usr/local/Cellar/erlang/R16B03/lib/erlang/lib lib
;; ln -s /usr/local/Cellar/erlang/R16B03/lib/erlang/bin bin
(setq load-path (cons "~/.emacs.d/erlang/emacs" load-path))
(setq erlang-root-dir "~/.emacs.d/erlang/lib")
(setq exec-path (cons "~/.emacs.d/erlang/bin" exec-path))
(require 'erlang-start)
(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))

(require 'python-mode)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; color-themes
(require 'color-theme)

;; quickmode
(require 'quickrun)

(regen-autoloads)
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))
(if (file-exists-p user-specific-config) (load user-specific-config))

;; enable meta-s to start rectangle
(setq cua-rectangle-mark-key (kbd "M-s"))

;; aspell on mac
(setq ispell-program-name "aspell")

;;(setq debug-on-error t)

;; remap bindings
(global-set-key (kbd "M-C-s") 'save-buffer)
(global-set-key (kbd "C-q") 'save-buffers-kill-emacs)

;;; init.el ends here
