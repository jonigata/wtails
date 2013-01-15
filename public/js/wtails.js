var Wtails = {
    run: function(host, port, filter) {
        var self = this;
        jQuery(function($) {
            var url = 'ws://' + host + ':' + port;
            var socket = new (WebSocket || MozWebSocket)(url);
            var context = { port: port };

            socket.onmessage = function(message) {
                $('.port-' + context.port).each(function() {
                    var curr = $(this);
                    
                    // To ignore serial empty lines
                    if (message.data == '\n' && curr.find('pre:last').text() == '\n') return;

                    // apply filter
                    var line = $('<pre>').text(message.data);
                    line = filter(line);

                    // Insert a new line
                    curr.append(line);

                    // Truncate old lines
                    var children = curr.children();
                    if (300 < children.length) {
                        children.slice(0, children.length - 300).remove();
                    }

                    // Scroll to bottom of the page
                    curr.parent().scrollTop(curr.height());
                });
            };
            $(window).resize(function() {
                $('.terminal').each(function() {
                    $(this).parent().scrollTop($(this).height());
                });
            });
        });
    }
};
