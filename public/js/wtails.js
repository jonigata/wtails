var Wtails = {
    run: function(port, filter) {
        var self = this;
        jQuery(function($) {
            var socket = new (WebSocket || MozWebSocket)('ws://localhost:' + port);
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

                    // Scroll to bottom of the page
                    curr.parent().scrollTop(curr.height());
                });
            };
        });
    },
};
