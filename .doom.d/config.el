(getenv "PATH")

(setq user-full-name "Leo Rönnebro"
      user-mail-address "leo.ronnebro@hamsterapps.net")

(map! :leader
      :desc "Toggle hiding"
      "t h" #'hs-toggle-hiding)
(map! :leader
      :desc "Toggle line comment"
      "t c" #'comment-line)
(map! :leader
      :desc "Open SSH connection"
      "o s" #'ssh-conn)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-position                      'right)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(defun ssh-conn (host port)
  "Connect to a remote host by SSH."
  (interactive "sHost: \nsPort (default 22): ")
  (let* ((port (if (equal port "") "22" port))
         (switches (list host "-p" port)))
       (set-buffer (apply 'make-term "ssh" "ssh" nil switches))
       (term-mode)
       (term-char-mode)
       (switch-to-buffer "*ssh*")))

(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun custom-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode t)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  (electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c R") 'dotnet-run)
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c f") 'omnisharp-code-format-entire-file)
  (local-set-key (kbd "C-c C-c") 'recompile))

(add-hook 'csharp-mode-hook 'custom-csharp-mode-setup t)

(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'doom-laserwave)

(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files '("~/Documents/org/agenda.org"))
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "IMPORTANT(i)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" )))
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (sh . t)
   (java . t)
   (js . t)
   (org . t)
  ))

(use-package! org-super-agenda
    :after org-agenda
    :init
    (setq org-super-agenda-groups '((:name "Today"
                                        :time-grid t
                                        :scheduled today)
                                    (:name "Due today"
                                        :deadline today)
                                    (:name "Important"
                                        :priority "A")
                                    (:name "Due soon"
                                        :deadline future)
                                    (:name "Big Outcomes"
                                        :tag "bo")
                                    ))
    :config
    (org-super-agenda-mode)
)

(setq display-line-numbers-type 't)
(map! :leader
      :desc "Toggle truncate lines"
      "t t" #'toggle-truncate-lines)

;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(setq projectile-project-search-path '("~/code/"))

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
