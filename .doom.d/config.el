(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'doom-one)

(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files '("~/Documents/org/agenda.org"))
  (setq org-log-done 'time)
  (setq org-log-done 'note)
  (setq org-todo-keywords '((sequence "TODO(t)" "PROJ(p)" "IMPORTANT(i)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" )))
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)

(setq display-line-numbers-type 't)
(global-set-key "\C-x\ t" 'toggle-truncate-lines)

(setq neo-window-fixed-size nil)

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
