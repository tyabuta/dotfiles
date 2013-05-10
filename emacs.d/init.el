;; *******************************************************************
;;
;;                          Emacs設定ファイル
;;
;;                                                  (c) 2013 tyabuta.
;; *******************************************************************

;; -------------------------------------------------------------------
;; loadpath設定
;; -------------------------------------------------------------------

;; Emacs23より前のバージョンでは、
;; user-emacs-directory変数が未定義の為、下記設定を行う。
(when (< emacs-major-version 23)
  (defvar user-emacs-directory "~/.emacs.d/"))

;;
;; サブディレクトリも含めてload-pathに追加する関数
;;
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;; サブディレクトリも含めてload-pathに追加する。
(add-to-load-path "elisp")


;; -------------------------------------------------------------------
;; package設定
;; -------------------------------------------------------------------

(when (require 'package nil t)
  ;; リポジトリ追加
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; 拡張機能の読み込み
  (package-initialize))

;; Undo, Redo設定
(require 'redo+)
(define-key global-map (kbd "C-u") 'undo)
(define-key global-map (kbd "C-r") 'redo)




;; -------------------------------------------------------------------
;; auto-install設定
;; -------------------------------------------------------------------

;;
;; auto-install.el 導入について
;;
;; cd ~/.emacs.d/elisp
;; curl -O http://www.emacswiki.org/emacs/download/auto-install.el
;; emacs -batch -f batch-byte-compile ./auto-install.el
;;

(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  (auto-install-update-emacswiki-package-name t)
  (auto-install-compatibility-setup))

;; auto-complete
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

(require 'anything nil t)
(setq
 anything-idle-delay 0.3
 anything-input-idle-delay 0.2
 anything-quick-update t
 anything-enable-shortcuts 'alphabet)

(require 'anything-config nil t)
(setq anything-su-or-sudo "sudo")

(require 'anything-match-plugin nil t)

(when (and (executable-find "cmigemo")
	   (require 'migemo nil t))
  (require 'anything-migemo nil t))

(require 'anything-complete nil t)
(anything-lisp-complete-symbol-set-timer 150)

(require 'anything-show-completion nil t)

(require 'anything-auto-install nil t)

(when (require 'descbinds-anything nil t)
  (descbinds-anything-install))





  

;; 文字コード設定
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)


;; モードラインにカラム番号の表示
(column-number-mode t)

;; モードラインに行番号の表示
(line-number-mode t)

;; モードラインにファイルサイズを表示
(size-indication-mode t)

;; フリンジに行番号を表示する。 
(global-linum-mode t)

;; TABの表示幅設定
(setq-default tab-width 4)

;; インデントにTAB文字を使用しない。
(setq-default indent-tabs-mode nil)

;; 対応する括弧を強調表示
(setq show-paren-delay 0) ; 表示までの秒数(def:0.125)
(show-paren-mode t)       ; 有効化

;; バックアップファイルの作成場所をTempディレクトリに変更する。
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
;; オートセーブファイルの作成場所をTempディレクトリに変更する。
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; オートセーブファイル作成までの秒間隔
(setq auto-save-timeout 15)
;; オートセーブファイル作成までのタイプ間隔
(setq auto-save-interval 60)


;;
;; リージョンの行数と文字数を取得する。
;;
(defun count-lines-and-chars ()
  (if mark-active
      (format "[%d lines, %d chars] "
	      (count-lines (region-beginning) (region-end))
	      (- (region-end) (region-beginning)))
    ""))
;; リージョン選択中にモードラインに行数と文字数を表示する。
(add-to-list 'default-mode-line-format
	     '(:eval (count-lines-and-chars)))



;; -------------------------------------------------------------------
;; キーバインド設定
;; -------------------------------------------------------------------

;; 折り返し表示の切り替えコマンド
;; C-c l
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; ウィンドウ切り替え
;; C-t
(define-key global-map (kbd "C-t") 'other-window)


(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])

;; スクロールキーバインド
(global-set-key [(meta up)] 'scroll-down-command)
(global-set-key [(meta down)] 'scroll-up-command)
 

;; -------------------------------------------------------------------
;; OS別の設定項目
;; -------------------------------------------------------------------

;; Mac専用内容
(when (eq system-type 'darwin)
  ;; Macでファイル名を正しく扱うための設定
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))

;; Windows専用内容
(when (eq system-type 'w32)
  ;; TODO: Windows用の設定
  )

;; GUI専用の内容
(when window-system
  ;; TODO: GUI用の設定
  )


;; -------------------------------------------------------------------
;; フックの設定項目
;; -------------------------------------------------------------------

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             ;; Elisp関数や変数の情報をエコーエリアに表示する。
             (when (require 'eldoc nil t)
               (setq eldoc-idle-delay 0.2)
               (setq eldoc-echo-area-use-multiline-p t)
               (turn-on-eldoc-mode))))

(add-hook 'after-save-hook 
          '(lambda()
             ;; TODO: 保存後のフック処理
             ))

(add-hook 'emacs-startup-hook 
          '(lambda()
             ;; TODO: Emacs起動時の設定ファイル読込直後の処理。
             ))



