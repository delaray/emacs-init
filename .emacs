;; ---------------------------------------------------------------------
;; Emacs Font and Window Setup
;; ---------------------------------------------------------------------

;; (set-frame-font "Menlo 14" nil t)
;; (set-face-attribute 'default nil :font "Monospace" :height 160)
;; (set-default-font "Menlo 14")

(set-face-attribute 'default nil :height 130)

(setq initial-frame-alist '((top . 10) (left . 100) (width . 170) (height . 45)))

;; ---------------------------------------------------------------------
;; MELPA Package Support
;; ---------------------------------------------------------------------

;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Initializes the package infrastructure
(package-initialize)

;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages
;;
;; myPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment    
    flycheck                        ;; On the fly syntax checking
    py-autopep8                     ;; Run autopep8 on save
    flycheck-pyflakes               ;; Support pyflakes in flycheck
    flycheck-pycheckers             ;; multiple syntax checker for Python, using Flycheck
    flymake-ruff                    ;; A flymake plugin for python files using ruff
    jedi                            ;; a Python auto-completion for Emacs
    pippel                          ;; Frontend to python package manager pip
    py-import-check                 ;; Finds the unused python imports using importchecker
    blacken                         ;; Black formatting on save
    ein                             ;; Emacs IPython Notebook
    conda                           ;; Conda 
    cider                           ;; Clojure Interface
    flycheck-clojure                ;; Flycheck: Clojure support
    material-theme                  ;; Theme
    company-tabnine                 ;; Install DL completion package
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;;  ===================================
;; Basic Customization
;; ===================================

(setq inhibit-startup-message t)    ;; Hide the startup message
(load-theme 'material t)            ;; Load material theme
(global-linum-mode t)               ;; Enable line numbers globally


;; ---------------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-mode slime scala-mode company-tabnine exec-path-from-shell cider python-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ---------------------------------------------------------------------
;; Python Setup
;; ---------------------------------------------------------------------

;; Enable elpy
(elpy-enable)

;; Use IPython for REPL
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args ""
      python-shell-prompt-detect-failure-warning nil)

(add-to-list 'python-shell-completion-native-disabled-interpreters
             "ipython")

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-mode)

;; (require 'python)

;; (setq python-shell-interpreter "c:/Program Files/Python39/python.exe")
;; (setq python-shell-interpreter
;;       "C:/Users/delar/AppData/Local/Microsoft/WindowsApps/python.exe")
;; (setq python-shell-interpreter-args "")


;; ---------------------------------------------------------------------
;; Conda Setup
;; ---------------------------------------------------------------------

(require 'conda)
;; if you want interactive shell support, include:
(conda-env-initialize-interactive-shells)
;; if you want eshell support, include:
(conda-env-initialize-eshell)
;; if you want auto-activation (see below for details), include:
(conda-env-autoactivate-mode t)
;; if you want to automatically activate a conda environment on the opening of a file:
(add-hook 'find-file-hook
	  (lambda () (when (bound-and-true-p conda-project-env-path)
                       (conda-env-activate-for-buffer))))

;; ---------------------------------------------------------------------
;; Tabnine
;; ---------------------------------------------------------------------

;; (use-package company-tabnine :ensure t)
(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)

;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)


;; ---------------------------------------------------------------------
;; SBCL
;; ---------------------------------------------------------------------

(load (expand-file-name "/Users/delar/quicklisp/slime-helper.el"))

;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;; ---------------------------------------------------------------------
;; End of File
;; ---------------------------------------------------------------------
