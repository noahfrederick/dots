;;; move-border.el --- Intuitive window resizing

;; Author: (unknown)
;; URL: https://github.com/ramnes/move-border

;;; Commentary:
;;
;; Move-border provides functions for resizing Emacs windows,
;; considering the current window border instead of the window itself.
;;
;; So, by binding your keys to move-border-up, move-border-down,
;; move-border-left, and move-border-right, you can resize your
;; windows much more intuitively than if you were using shrink-window,
;; enlarge-window, shrink-window-horizontally and
;; enlarge-window-horizontally.
;;
;; ;; example key bindings
;; (global-set-key (kbd "M-S-<up>") 'move-border-up)
;; (global-set-key (kbd "M-S-<down>") 'move-border-down)
;; (global-set-key (kbd "M-S-<left>") 'move-border-left)
;; (global-set-key (kbd "M-S-<right>") 'move-border-right)

;;; Code:

(defun xor (b1 b2)
  (or (and b1 b2)
      (and (not b1) (not b2))))

(defun move-border-left-or-right (arg dir)
  "General function covering move-border-left and move-border-right. If DIR is
     t, then move left, otherwise move right."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((left-edge (nth 0 (window-edges))))
    (if (xor (= left-edge 0) dir)
        (shrink-window arg t)
        (enlarge-window arg t))))

(defun move-border-up-or-down (arg dir)
  "General function covering move-border-up and move-border-down. If DIR is
     t, then move up, otherwise move down."
  (interactive)
  (if (null arg) (setq arg 3))
  (let ((top-edge (nth 1 (window-edges))))
    (if (xor (= top-edge 0) dir)
        (shrink-window arg nil)
        (enlarge-window arg nil))))

(defun move-border-left (arg)
  (interactive "P")
  (move-border-left-or-right arg t))

(defun move-border-right (arg)
  (interactive "P")
  (move-border-left-or-right arg nil))

(defun move-border-up (arg)
  (interactive "P")
  (move-border-up-or-down arg t))

(defun move-border-down (arg)
  (interactive "P")
  (move-border-up-or-down arg nil))

(provide 'move-border)
