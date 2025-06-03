;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-modern-star "replace")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq evil-escape-key-sequence "jk")

(setq browse-url-generic-program "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe")
(setq browse-url-chrome-program "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe")
(setq browse-url-browser-function 'browse-url-chrome)

(setq auth-sources '("~/.authinfo"))

(setq deft-directory "~/org"
      deft-extensions '("org")
      deft-recursive t)

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")

(setq org-roam-directory "~/roam"
      org-roam-db-location (expand-file-name "~/.config/emacs/.local/cache/org-roam.db"))

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(setq mu4e-mu-binary "/usr/local/bin/mu")

(require 'epg)
(setq epg-pinentry-mode 'loopback)

(setq mu4e-sent-messages-behavior 'delete)
(setq message-send-mail-function 'smtpmail-send-it)

(require 'mu4e)
(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "Professional"
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p "/weesoonglim" (mu4e-message-field msg :maildir))))
          :vars '((user-mail-address . "weesoong.lim@gmail.com")
                  (user-full-name    . "Daniel Lim Wee Soong")
                  (smtpmail-smtp-server  . "smtp.gmail.com")
                  (smtpmail-smtp-service . 465)
                  (smtpmail-stream-type  . ssl)
                  (mu4e-drafts-folder  . "/weesoonglim/[Gmail]/Drafts")
                  (mu4e-sent-folder  . "/weesoonglim/[Gmail]/Sent Mail")
                  (mu4e-refile-folder  . "/weesoonglim/[Gmail]/All Mail")
                  (mu4e-trash-folder  . "/weesoonglim/[Gmail]/Trash")))))

;; auto-load agda-mode for .agda and .lagda.md
(setq auto-mode-alist
      (append
       '(("\\.agda\\'" . agda2-mode)
         ("\\.lagda.md\\'" . agda2-mode))
       auto-mode-alist))

(exec-path-from-shell-initialize)

(after! agda2-mode
  (map! :map agda2-mode-map
        :localleader
        "m" #'markdown-mode))

(after! markdown-mode
  (map! :map markdown-mode-map
        :localleader
        "a"   #'agda2-mode))
