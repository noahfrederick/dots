;;; init.el --- Bootstrap Emacs configuration

;;; Commentary:

;; This file loads Org-mode and then loads the rest of our Emacs
;; initialization from Emacs Lisp embedded in literate Org-mode files.

;;; Code:

;; Cask manages our package dependencies
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Pallet allows us to use Cask in tandem with package.el
(require 'pallet)

;; Load up Org-babel
(require 'ob-tangle)

;; Load our main configuration file
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))

;;; init.el ends here
