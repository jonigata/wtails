wtails
======

Wtails is a web server acts like 'tails -f', inspired by webtail( https://github.com/r7kamura/webtail ).

Wtails can handle multiple files.

Wtails can serve files without launching browser(--serve), this option is usable for browsing remote server.

usage
=====

  % wtails foo.log bar.log baz.log - --serve

  then web server started, and you can now browse them at 'http://localhost:9999'.

screenshot
==========

  ![single view](wtails/master/doc/img/dual_view.png)
  ![dual view](wtails/master/doc/img/dual_view.png)
