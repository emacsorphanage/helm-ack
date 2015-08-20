# helm-ack.el [![melpa badge][melpa-badge]][melpa-link] [![melpa stable badge][melpa-stable-badge]][melpa-stable-link]

**This package is deprecated. This pacakge does not work with newer helm. Please switch to [helm-ag](https://github.com/syohex/emacs-helm-ag). You can also use ack with helm-ag.**

## Introduction
`helm-ack.el` is App::ack helm interface.

I recommend you to use [helm-ag](https://github.com/syohex/emacs-helm-ag) instead of helm-ack. helm-ag provides much features than helm-ack and helm-ag also supports ack.


## Screenshot

![helm-ack](https://github.com/syohex/emacs-helm-ack/raw/master/image/helm-ack.png)


## Requirements

* Emacs 24 or higher
* helm 1.0 or higher
* [App::Ack](https://metacpan.org/module/ack) or `ack-grep` debian package.


## Basic Usage

#### `helm-ack`

Input search word with ack. If you specified prefix argument(`C-u`), you can
change searched directory.

#### `helm-ack-pop-stack`

Move to previous point on the stack.


## Customize

#### `helm-ack-use-ack-grep`(Default is `nil`)

If you install ack as debian package, please set `t` to this variable.

#### `helm-ack-base-command`

Base ack command, default is "ack --nocolor --nogroup"

#### `helm-ack-auto-set-filetype`
Auto insert `--type` option, default is true.

#### `helm-ack-thing-at-point`(Default `'word`)

Insert thing at point as default search pattern, you can set the value
same as `thing-at-point`.


## Sample Configuration

```lisp
(require 'helm-config)
(require 'helm-ack)

(custom-set-variables
 ;; Does not insert '--type' option
 '(helm-ack-auto-set-filetype nil)
 ;; Insert "thing-at-point 'symbol" as search pattern
 '(helm-ack-thing-at-point 'symbol))
```

[melpa-link]: http://melpa.org/#/helm-ack
[melpa-stable-link]: http://stable.melpa.org/#/helm-ack
[melpa-badge]: http://melpa.org/packages/helm-ack-badge.svg
[melpa-stable-badge]: http://stable.melpa.org/packages/helm-ack-badge.svg
